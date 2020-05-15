Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACEE1D5740
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgEORQ6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 13:16:58 -0400
Received: from foss.arm.com ([217.140.110.172]:59532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgEORQ6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:16:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F44111D4;
        Fri, 15 May 2020 10:16:57 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A224E3F305;
        Fri, 15 May 2020 10:16:55 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Alan Hayward <Alan.Hayward@arm.com>,
        Luis Machado <luis.machado@linaro.org>,
        Omair Javaid <omair.javaid@linaro.org>
Subject: [PATCH v4 18/26] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS support
Date:   Fri, 15 May 2020 18:16:04 +0100
Message-Id: <20200515171612.1020-19-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515171612.1020-1-catalin.marinas@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add support for bulk setting/getting of the MTE tags in a tracee's
address space at 'addr' in the ptrace() syscall prototype. 'data' points
to a struct iovec in the tracer's address space with iov_base
representing the address of a tracer's buffer of length iov_len. The
tags to be copied to/from the tracer's buffer are stored as one tag per
byte.

On successfully copying at least one tag, ptrace() returns 0 and updates
the tracer's iov_len with the number of tags copied. In case of error,
either -EIO or -EFAULT is returned, trying to follow the ptrace() man
page.

Note that the tag copying functions are not performance critical,
therefore they lack optimisations found in typical memory copy routines.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Alan Hayward <Alan.Hayward@arm.com>
Cc: Luis Machado <luis.machado@linaro.org>
Cc: Omair Javaid <omair.javaid@linaro.org>
---

Notes:
    v4:
    - Following the change to only clear the tags in a page if it is mapped
      to user with PROT_MTE, ptrace() now will refuse to access tags in
      pages not previously mapped with PROT_MTE (PG_mte_tagged set). This is
      primarily to avoid leaking uninitialised tags to user via ptrace().
    - Fix SYM_FUNC_END argument typo.
    - Rename MTE_ALLOC_* to MTE_GRANULE_*.
    - Use uao_user_alternative for the user access in case we ever want to
      call mte_copy_tags_* with a kernel buffer. It also matches the other
      uaccess routines in the kernel.
    - Simplify arch_ptrace() slightly.
    - Reorder down_write_killable() with access_ok() in
      __access_remote_tags().
    - Handle copy length 0 in mte_copy_tags_{to,from}_user().
    - Use put_user() instead of __put_user().
    
    New in v3.

 arch/arm64/include/asm/mte.h         |  17 ++++
 arch/arm64/include/uapi/asm/ptrace.h |   3 +
 arch/arm64/kernel/mte.c              | 139 +++++++++++++++++++++++++++
 arch/arm64/kernel/ptrace.c           |   7 ++
 arch/arm64/lib/mte.S                 |  53 ++++++++++
 5 files changed, 219 insertions(+)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 7435f6619bf1..9d4b1390d07d 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -5,6 +5,11 @@
 #ifndef __ASM_MTE_H
 #define __ASM_MTE_H
 
+#define MTE_GRANULE_SIZE	UL(16)
+#define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
+#define MTE_TAG_SHIFT		56
+#define MTE_TAG_SIZE		4
+
 #ifndef __ASSEMBLY__
 
 #include <linux/page-flags.h>
@@ -12,6 +17,10 @@
 #include <asm/pgtable-types.h>
 
 void mte_clear_page_tags(void *addr, size_t size);
+unsigned long mte_copy_tags_from_user(void *to, const void __user *from,
+				      unsigned long n);
+unsigned long mte_copy_tags_to_user(void __user *to, void *from,
+				    unsigned long n);
 
 #ifdef CONFIG_ARM64_MTE
 
@@ -25,6 +34,8 @@ void mte_thread_switch(struct task_struct *next);
 void mte_suspend_exit(void);
 long set_mte_ctrl(unsigned long arg);
 long get_mte_ctrl(void);
+int mte_ptrace_copy_tags(struct task_struct *child, long request,
+			 unsigned long addr, unsigned long data);
 
 #else
 
@@ -54,6 +65,12 @@ static inline long get_mte_ctrl(void)
 {
 	return 0;
 }
+static inline int mte_ptrace_copy_tags(struct task_struct *child,
+				       long request, unsigned long addr,
+				       unsigned long data)
+{
+	return -EIO;
+}
 
 #endif
 
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 1daf6dda8af0..cd2a4a164de3 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -67,6 +67,9 @@
 /* syscall emulation path in ptrace */
 #define PTRACE_SYSEMU		  31
 #define PTRACE_SYSEMU_SINGLESTEP  32
+/* MTE allocation tag access */
+#define PTRACE_PEEKMTETAGS	  33
+#define PTRACE_POKEMTETAGS	  34
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index cda09bc8caf4..6abd6a16a145 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -4,14 +4,18 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/prctl.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/string.h>
 #include <linux/thread_info.h>
+#include <linux/uio.h>
 
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
+#include <asm/ptrace.h>
 #include <asm/sysreg.h>
 
 void mte_sync_tags(pte_t *ptep, pte_t pte)
@@ -173,3 +177,138 @@ long get_mte_ctrl(void)
 
 	return ret;
 }
+
+/*
+ * Access MTE tags in another process' address space as given in mm. Update
+ * the number of tags copied. Return 0 if any tags copied, error otherwise.
+ * Inspired by __access_remote_vm().
+ */
+static int __access_remote_tags(struct task_struct *tsk, struct mm_struct *mm,
+				unsigned long addr, struct iovec *kiov,
+				unsigned int gup_flags)
+{
+	struct vm_area_struct *vma;
+	void __user *buf = kiov->iov_base;
+	size_t len = kiov->iov_len;
+	int ret;
+	int write = gup_flags & FOLL_WRITE;
+
+	if (!access_ok(buf, len))
+		return -EFAULT;
+
+	if (down_read_killable(&mm->mmap_sem))
+		return -EIO;
+
+	while (len) {
+		unsigned long tags, offset;
+		void *maddr;
+		struct page *page = NULL;
+
+		ret = get_user_pages_remote(tsk, mm, addr, 1, gup_flags,
+					    &page, &vma, NULL);
+		if (ret <= 0)
+			break;
+
+		/*
+		 * Only copy tags if the page has been mapped as PROT_MTE
+		 * (PG_mte_tagged set). Otherwise the tags are not valid and
+		 * not accessible to user. Moreover, an mprotect(PROT_MTE)
+		 * would cause the existing tags to be cleared if the page
+		 * was never mapped with PROT_MTE.
+		 */
+		if (!test_bit(PG_mte_tagged, &page->flags)) {
+			ret = -EOPNOTSUPP;
+			put_page(page);
+			break;
+		}
+
+		/* limit access to the end of the page */
+		offset = offset_in_page(addr);
+		tags = min(len, (PAGE_SIZE - offset) / MTE_GRANULE_SIZE);
+
+		maddr = page_address(page);
+		if (write) {
+			tags = mte_copy_tags_from_user(maddr + offset, buf, tags);
+			set_page_dirty_lock(page);
+		} else {
+			tags = mte_copy_tags_to_user(buf, maddr + offset, tags);
+		}
+		put_page(page);
+
+		/* error accessing the tracer's buffer */
+		if (!tags)
+			break;
+
+		len -= tags;
+		buf += tags;
+		addr += tags * MTE_GRANULE_SIZE;
+	}
+	up_read(&mm->mmap_sem);
+
+	/* return an error if no tags copied */
+	kiov->iov_len = buf - kiov->iov_base;
+	if (!kiov->iov_len) {
+		/* check for error accessing the tracee's address space */
+		if (ret <= 0)
+			return -EIO;
+		else
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+/*
+ * Copy MTE tags in another process' address space at 'addr' to/from tracer's
+ * iovec buffer. Return 0 on success. Inspired by ptrace_access_vm().
+ */
+static int access_remote_tags(struct task_struct *tsk, unsigned long addr,
+			      struct iovec *kiov, unsigned int gup_flags)
+{
+	struct mm_struct *mm;
+	int ret;
+
+	mm = get_task_mm(tsk);
+	if (!mm)
+		return -EPERM;
+
+	if (!tsk->ptrace || (current != tsk->parent) ||
+	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
+	     !ptracer_capable(tsk, mm->user_ns))) {
+		mmput(mm);
+		return -EPERM;
+	}
+
+	ret = __access_remote_tags(tsk, mm, addr, kiov, gup_flags);
+	mmput(mm);
+
+	return ret;
+}
+
+int mte_ptrace_copy_tags(struct task_struct *child, long request,
+			 unsigned long addr, unsigned long data)
+{
+	int ret;
+	struct iovec kiov;
+	struct iovec __user *uiov = (void __user *)data;
+	unsigned int gup_flags = FOLL_FORCE;
+
+	if (!system_supports_mte())
+		return -EIO;
+
+	if (get_user(kiov.iov_base, &uiov->iov_base) ||
+	    get_user(kiov.iov_len, &uiov->iov_len))
+		return -EFAULT;
+
+	if (request == PTRACE_POKEMTETAGS)
+		gup_flags |= FOLL_WRITE;
+
+	/* align addr to the MTE tag granule */
+	addr &= MTE_GRANULE_MASK;
+
+	ret = access_remote_tags(child, addr, &kiov, gup_flags);
+	if (!ret)
+		ret = put_user(kiov.iov_len, &uiov->iov_len);
+
+	return ret;
+}
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 077e352495eb..c8bda5f5b321 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -34,6 +34,7 @@
 #include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/fpsimd.h>
+#include <asm/mte.h>
 #include <asm/pgtable.h>
 #include <asm/pointer_auth.h>
 #include <asm/stacktrace.h>
@@ -1797,6 +1798,12 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 long arch_ptrace(struct task_struct *child, long request,
 		 unsigned long addr, unsigned long data)
 {
+	switch (request) {
+	case PTRACE_PEEKMTETAGS:
+	case PTRACE_POKEMTETAGS:
+		return mte_ptrace_copy_tags(child, request, addr, data);
+	}
+
 	return ptrace_request(child, request, addr, data);
 }
 
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index a531b52fa5ba..862655a36013 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -4,7 +4,9 @@
  */
 #include <linux/linkage.h>
 
+#include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/mte.h>
 #include <asm/page.h>
 
 	.arch	armv8.5-a+memtag
@@ -40,3 +42,54 @@ SYM_FUNC_START(mte_copy_page_tags)
 	b.ne	1b
 2:
 SYM_FUNC_END(mte_copy_page_tags)
+
+/*
+ * Read tags from a user buffer (one tag per byte) and set the corresponding
+ * tags at the given kernel address. Used by PTRACE_POKEMTETAGS.
+ *   x0 - kernel address (to)
+ *   x1 - user buffer (from)
+ *   x2 - number of tags/bytes (n)
+ * Returns:
+ *   x0 - number of tags read/set
+ */
+SYM_FUNC_START(mte_copy_tags_from_user)
+	mov	x3, x1
+	cbz	x2, 2f
+1:
+	uao_user_alternative 2f, ldrb, ldtrb, w4, x1, 0
+	lsl	x4, x4, #MTE_TAG_SHIFT
+	stg	x4, [x0], #MTE_GRANULE_SIZE
+	add	x1, x1, #1
+	subs	x2, x2, #1
+	b.ne	1b
+
+	// exception handling and function return
+2:	sub	x0, x1, x3		// update the number of tags set
+	ret
+SYM_FUNC_END(mte_copy_tags_from_user)
+
+/*
+ * Get the tags from a kernel address range and write the tag values to the
+ * given user buffer (one tag per byte). Used by PTRACE_PEEKMTETAGS.
+ *   x0 - user buffer (to)
+ *   x1 - kernel address (from)
+ *   x2 - number of tags/bytes (n)
+ * Returns:
+ *   x0 - number of tags read/set
+ */
+SYM_FUNC_START(mte_copy_tags_to_user)
+	mov	x3, x0
+	cbz	x2, 2f
+1:
+	ldg	x4, [x1]
+	ubfx	x4, x4, #MTE_TAG_SHIFT, #MTE_TAG_SIZE
+	uao_user_alternative 2f, strb, sttrb, w4, x0, 0
+	add	x0, x0, #1
+	add	x1, x1, #MTE_GRANULE_SIZE
+	subs	x2, x2, #1
+	b.ne	1b
+
+	// exception handling and function return
+2:	sub	x0, x0, x3		// update the number of tags copied
+	ret
+SYM_FUNC_END(mte_copy_tags_to_user)
