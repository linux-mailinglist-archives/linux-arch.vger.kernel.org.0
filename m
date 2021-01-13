Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB602F574E
	for <lists+linux-arch@lfdr.de>; Thu, 14 Jan 2021 03:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbhAMVNf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 16:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbhAMVJS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2021 16:09:18 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8B4C061786
        for <linux-arch@vger.kernel.org>; Wed, 13 Jan 2021 13:09:53 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kznOp-005vHf-SI; Wed, 13 Jan 2021 22:09:51 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] um: separate child and parent errors in clone stub
Date:   Wed, 13 Jan 2021 22:09:42 +0100
Message-Id: <20210113220944.7732f6bfd3bb.Ib87c91b49d57d27314cf444696273da6d8463e9c@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the two are mixed up, then it looks as though the parent
returned an error if the child failed (before) the mmap(),
and then the resulting process never gets killed. Fix this
by splitting the child and parent errors, reporting and
using them appropriately.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/skas/stub-data.h |  2 +-
 arch/um/kernel/skas/clone.c             | 25 +++++++++++--------------
 arch/um/os-Linux/skas/process.c         | 23 +++++++++++++----------
 arch/x86/um/shared/sysdep/stub_32.h     |  2 +-
 arch/x86/um/shared/sysdep/stub_64.h     |  2 +-
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 6b01d97a9386..5e3ade3fb38b 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -11,7 +11,7 @@
 struct stub_data {
 	unsigned long offset;
 	int fd;
-	long err;
+	long parent_err, child_err;
 };
 
 #endif
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index bfb70c456b30..7c592c788cbf 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -24,29 +24,26 @@
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_clone_handler(void)
 {
-	struct stub_data *data = (struct stub_data *) STUB_DATA;
+	int stack;
+	struct stub_data *data = (void *) ((unsigned long)&stack & ~(UM_KERN_PAGE_SIZE - 1));
 	long err;
 
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
-			    STUB_DATA + UM_KERN_PAGE_SIZE / 2 - sizeof(void *));
-	if (err != 0)
-		goto out;
+			    (unsigned long)data + UM_KERN_PAGE_SIZE / 2 - sizeof(void *));
+	if (err) {
+		data->parent_err = err;
+		goto done;
+	}
 
 	err = stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
-	if (err)
-		goto out;
+	if (err) {
+		data->child_err = err;
+		goto done;
+	}
 
 	remap_stack(data->fd, data->offset);
 	goto done;
 
- out:
-	/*
-	 * save current result.
-	 * Parent: pid;
-	 * child: retcode of mmap already saved and it jumps around this
-	 * assignment
-	 */
-	data->err = err;
  done:
 	trap_myself();
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index d910e25c273e..623b0aeadf4c 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -545,8 +545,14 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	 * and child's mmap2 calls
 	 */
 	*data = ((struct stub_data) {
-			.offset	= MMAP_OFFSET(new_offset),
-			.fd     = new_fd
+		.offset	= MMAP_OFFSET(new_offset),
+		.fd     = new_fd,
+		.parent_err = -ESRCH,
+		.child_err = 0,
+	});
+
+	*child_data = ((struct stub_data) {
+		.child_err = -ESRCH,
 	});
 
 	err = ptrace_setregs(pid, thread_regs);
@@ -564,9 +570,6 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 		return err;
 	}
 
-	/* set a well known return code for detection of child write failure */
-	child_data->err = 12345678;
-
 	/*
 	 * Wait, until parent has finished its work: read child's pid from
 	 * parent's stack, and check, if bad result.
@@ -581,7 +584,7 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 
 	wait_stub_done(pid);
 
-	pid = data->err;
+	pid = data->parent_err;
 	if (pid < 0) {
 		printk(UM_KERN_ERR "copy_context_skas0 - stub-parent reports "
 		       "error %d\n", -pid);
@@ -593,10 +596,10 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	 * child's stack and check it.
 	 */
 	wait_stub_done(pid);
-	if (child_data->err != STUB_DATA) {
-		printk(UM_KERN_ERR "copy_context_skas0 - stub-child reports "
-		       "error %ld\n", child_data->err);
-		err = child_data->err;
+	if (child_data->child_err != STUB_DATA) {
+		printk(UM_KERN_ERR "copy_context_skas0 - stub-child %d reports "
+		       "error %ld\n", pid, data->child_err);
+		err = data->child_err;
 		goto out_kill;
 	}
 
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 51fd256c75f0..8ea69211e53c 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -86,7 +86,7 @@ static inline void remap_stack(int fd, unsigned long offset)
 			    "d" (PROT_READ | PROT_WRITE),
 			    "S" (MAP_FIXED | MAP_SHARED), "D" (fd),
 			    "a" (offset),
-			    "i" (&((struct stub_data *) STUB_DATA)->err)
+			    "i" (&((struct stub_data *) STUB_DATA)->child_err)
 			  : "memory");
 }
 
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index 994df93c5ed3..b7b8b8e4359d 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -92,7 +92,7 @@ static inline void remap_stack(long fd, unsigned long offset)
 			    "d" (PROT_READ | PROT_WRITE),
                             "g" (MAP_FIXED | MAP_SHARED), "g" (fd),
 			    "g" (offset),
-			    "i" (&((struct stub_data *) STUB_DATA)->err)
+			    "i" (&((struct stub_data *) STUB_DATA)->child_err)
 			  : __syscall_clobber, "r10", "r8", "r9" );
 }
 
-- 
2.26.2

