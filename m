Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF81D20E4B0
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390194AbgF2V17 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgF2Smo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:44 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06521C033C0F;
        Mon, 29 Jun 2020 11:26:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU8-002Dsy-Jp; Mon, 29 Jun 2020 18:26:28 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 01/41] introduction of regset ->get() wrappers, switching ELF coredumps to those
Date:   Mon, 29 Jun 2020 19:25:48 +0100
Message-Id: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200629182349.GA2786714@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Two new helpers: given a process and regset, dump into a buffer.
regset_get() takes a buffer and size, regset_get_alloc() takes size
and allocates a buffer.

Return value in both cases is the amount of data actually dumped in
case of success or -E...  on error.

In both cases the size is capped by regset->n * regset->size, so
->get() is called with offset 0 and size no more than what regset
expects.

binfmt_elf.c callers of ->get() are switched to using those; the other
caller (copy_regset_to_user()) will need some preparations to switch.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf.c        | 54 ++++++++++++++++++++++++--------------------------
 include/linux/regset.h |  9 +++++++++
 kernel/Makefile        |  2 +-
 kernel/regset.c        | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 29 deletions(-)
 create mode 100644 kernel/regset.c

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 9fe3b51c116a..80743b8957c9 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1821,7 +1821,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 				 long signr, size_t *total)
 {
 	unsigned int i;
-	unsigned int regset0_size = regset_size(t->task, &view->regsets[0]);
+	unsigned int regset0_size;
 
 	/*
 	 * NT_PRSTATUS is the one special case, because the regset data
@@ -1830,8 +1830,10 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 	 * We assume that regset 0 is NT_PRSTATUS.
 	 */
 	fill_prstatus(&t->prstatus, t->task, signr);
-	(void) view->regsets[0].get(t->task, &view->regsets[0], 0, regset0_size,
-				    &t->prstatus.pr_reg, NULL);
+	regset0_size = regset_get(t->task, &view->regsets[0],
+		   sizeof(t->prstatus.pr_reg), &t->prstatus.pr_reg);
+	if (regset0_size < 0)
+		return 0;
 
 	fill_note(&t->notes[0], "CORE", NT_PRSTATUS,
 		  PRSTATUS_SIZE(t->prstatus, regset0_size), &t->prstatus);
@@ -1846,32 +1848,28 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 	 */
 	for (i = 1; i < view->n; ++i) {
 		const struct user_regset *regset = &view->regsets[i];
+		int note_type = regset->core_note_type;
+		bool is_fpreg = note_type == NT_PRFPREG;
+		void *data;
+		int ret;
+
 		do_thread_regset_writeback(t->task, regset);
-		if (regset->core_note_type && regset->get &&
-		    (!regset->active || regset->active(t->task, regset) > 0)) {
-			int ret;
-			size_t size = regset_size(t->task, regset);
-			void *data = kzalloc(size, GFP_KERNEL);
-			if (unlikely(!data))
-				return 0;
-			ret = regset->get(t->task, regset,
-					  0, size, data, NULL);
-			if (unlikely(ret))
-				kfree(data);
-			else {
-				if (regset->core_note_type != NT_PRFPREG)
-					fill_note(&t->notes[i], "LINUX",
-						  regset->core_note_type,
-						  size, data);
-				else {
-					SET_PR_FPVALID(&t->prstatus,
-							1, regset0_size);
-					fill_note(&t->notes[i], "CORE",
-						  NT_PRFPREG, size, data);
-				}
-				*total += notesize(&t->notes[i]);
-			}
-		}
+		if (!note_type) // not for coredumps
+			continue;
+		if (regset->active && regset->active(t->task, regset) <= 0)
+			continue;
+
+		ret = regset_get_alloc(t->task, regset, ~0U, &data);
+		if (ret < 0)
+			continue;
+
+		if (is_fpreg)
+			SET_PR_FPVALID(&t->prstatus, 1, regset0_size);
+
+		fill_note(&t->notes[i], is_fpreg ? "CORE" : "LINUX",
+			  note_type, ret, data);
+
+		*total += notesize(&t->notes[i]);
 	}
 
 	return 1;
diff --git a/include/linux/regset.h b/include/linux/regset.h
index 46d6ae68c455..968a032922d5 100644
--- a/include/linux/regset.h
+++ b/include/linux/regset.h
@@ -353,6 +353,15 @@ static inline int user_regset_copyin_ignore(unsigned int *pos,
 	return 0;
 }
 
+extern int regset_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int size, void *data);
+
+extern int regset_get_alloc(struct task_struct *target,
+			    const struct user_regset *regset,
+			    unsigned int size,
+			    void **data);
+
 /**
  * copy_regset_to_user - fetch a thread's user_regset data into user memory
  * @target:	thread to be examined
diff --git a/kernel/Makefile b/kernel/Makefile
index f3218bc5ec69..e6e03380a0f1 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,7 +10,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    extable.o params.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
-	    async.o range.o smpboot.o ucount.o
+	    async.o range.o smpboot.o ucount.o regset.o
 
 obj-$(CONFIG_MODULES) += kmod.o
 obj-$(CONFIG_MULTIUSER) += groups.o
diff --git a/kernel/regset.c b/kernel/regset.c
new file mode 100644
index 000000000000..6b39fa0993ec
--- /dev/null
+++ b/kernel/regset.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/regset.h>
+
+static int __regset_get(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int size,
+			void **data)
+{
+	void *p = *data, *to_free = NULL;
+	int res;
+
+	if (!regset->get)
+		return -EOPNOTSUPP;
+	if (size > regset->n * regset->size)
+		size = regset->n * regset->size;
+	if (!p) {
+		to_free = p = kzalloc(size, GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+	}
+	res = regset->get(target, regset, 0, size, p, NULL);
+	if (unlikely(res < 0)) {
+		kfree(to_free);
+		return res;
+	}
+	*data = p;
+	if (regset->get_size) { // arm64-only kludge, will go away
+		unsigned max_size = regset->get_size(target, regset);
+		if (size > max_size)
+			size = max_size;
+	}
+	return size;
+}
+
+int regset_get(struct task_struct *target,
+	       const struct user_regset *regset,
+	       unsigned int size,
+	       void *data)
+{
+	return __regset_get(target, regset, size, &data);
+}
+EXPORT_SYMBOL(regset_get);
+
+int regset_get_alloc(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int size,
+		     void **data)
+{
+	*data = NULL;
+	return __regset_get(target, regset, size, data);
+}
+EXPORT_SYMBOL(regset_get_alloc);
-- 
2.11.0

