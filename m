Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5188728835
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 21:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbfEWTXY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 May 2019 15:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390674AbfEWTXV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 May 2019 15:23:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E1E220868;
        Thu, 23 May 2019 19:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639400;
        bh=2RbjxuETqCYHxBeM3B7PFPrflHs91gMsDYPlQQFhKMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ge58KPWrSV7wz9R7P10QsrfSe3YNnb7FpLhxrd1Swv1TGFKciuI98TEXWm0Q6rwxu
         uqGxp0l30P5U+a9nNodBxNMjBF54FESz2ZUynQsQR7wZAulLB/COMMtCPm1QgPYbOu
         ut+tG+iAZ4wpDslT0s6oXhU0rI0HR8HmA+TVqPvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Biener <rguenther@suse.de>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>, Guan Xuetao <gxt@pku.edu.cn>,
        "H. Peter Anvin" <hpa@zytor.com>, Jeff Dike <jdike@addtoit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-um@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.0 075/139] x86/mpx, mm/core: Fix recursive munmap() corruption
Date:   Thu, 23 May 2019 21:06:03 +0200
Message-Id: <20190523181730.571246299@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 5a28fc94c9143db766d1ba5480cae82d856ad080 upstream.

This is a bit of a mess, to put it mildly.  But, it's a bug
that only seems to have showed up in 4.20 but wasn't noticed
until now, because nobody uses MPX.

MPX has the arch_unmap() hook inside of munmap() because MPX
uses bounds tables that protect other areas of memory.  When
memory is unmapped, there is also a need to unmap the MPX
bounds tables.  Barring this, unused bounds tables can eat 80%
of the address space.

But, the recursive do_munmap() that gets called vi arch_unmap()
wreaks havoc with __do_munmap()'s state.  It can result in
freeing populated page tables, accessing bogus VMA state,
double-freed VMAs and more.

See the "long story" further below for the gory details.

To fix this, call arch_unmap() before __do_unmap() has a chance
to do anything meaningful.  Also, remove the 'vma' argument
and force the MPX code to do its own, independent VMA lookup.

== UML / unicore32 impact ==

Remove unused 'vma' argument to arch_unmap().  No functional
change.

I compile tested this on UML but not unicore32.

== powerpc impact ==

powerpc uses arch_unmap() well to watch for munmap() on the
VDSO and zeroes out 'current->mm->context.vdso_base'.  Moving
arch_unmap() makes this happen earlier in __do_munmap().  But,
'vdso_base' seems to only be used in perf and in the signal
delivery that happens near the return to userspace.  I can not
find any likely impact to powerpc, other than the zeroing
happening a little earlier.

powerpc does not use the 'vma' argument and is unaffected by
its removal.

I compile-tested a 64-bit powerpc defconfig.

== x86 impact ==

For the common success case this is functionally identical to
what was there before.  For the munmap() failure case, it's
possible that some MPX tables will be zapped for memory that
continues to be in use.  But, this is an extraordinarily
unlikely scenario and the harm would be that MPX provides no
protection since the bounds table got reset (zeroed).

I can't imagine anyone doing this:

	ptr = mmap();
	// use ptr
	ret = munmap(ptr);
	if (ret)
		// oh, there was an error, I'll
		// keep using ptr.

Because if you're doing munmap(), you are *done* with the
memory.  There's probably no good data in there _anyway_.

This passes the original reproducer from Richard Biener as
well as the existing mpx selftests/.

The long story:

munmap() has a couple of pieces:

 1. Find the affected VMA(s)
 2. Split the start/end one(s) if neceesary
 3. Pull the VMAs out of the rbtree
 4. Actually zap the memory via unmap_region(), including
    freeing page tables (or queueing them to be freed).
 5. Fix up some of the accounting (like fput()) and actually
    free the VMA itself.

This specific ordering was actually introduced by:

  dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")

during the 4.20 merge window.  The previous __do_munmap() code
was actually safe because the only thing after arch_unmap() was
remove_vma_list().  arch_unmap() could not see 'vma' in the
rbtree because it was detached, so it is not even capable of
doing operations unsafe for remove_vma_list()'s use of 'vma'.

Richard Biener reported a test that shows this in dmesg:

  [1216548.787498] BUG: Bad rss-counter state mm:0000000017ce560b idx:1 val:551
  [1216548.787500] BUG: non-zero pgtables_bytes on freeing mm: 24576

What triggered this was the recursive do_munmap() called via
arch_unmap().  It was freeing page tables that has not been
properly zapped.

But, the problem was bigger than this.  For one, arch_unmap()
can free VMAs.  But, the calling __do_munmap() has variables
that *point* to VMAs and obviously can't handle them just
getting freed while the pointer is still in use.

I tried a couple of things here.  First, I tried to fix the page
table freeing problem in isolation, but I then found the VMA
issue.  I also tried having the MPX code return a flag if it
modified the rbtree which would force __do_munmap() to re-walk
to restart.  That spiralled out of control in complexity pretty
fast.

Just moving arch_unmap() and accepting that the bonkers failure
case might eat some bounds tables seems like the simplest viable
fix.

This was also reported in the following kernel bugzilla entry:

  https://bugzilla.kernel.org/show_bug.cgi?id=203123

There are some reports that this commit triggered this bug:

  dd2283f2605 ("mm: mmap: zap pages with read mmap_sem in munmap")

While that commit certainly made the issues easier to hit, I believe
the fundamental issue has been with us as long as MPX itself, thus
the Fixes: tag below is for one of the original MPX commits.

[ mingo: Minor edits to the changelog and the patch. ]

Reported-by: Richard Biener <rguenther@suse.de>
Reported-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Yang Shi <yang.shi@linux.alibaba.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Rik van Riel <riel@surriel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-um@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: stable@vger.kernel.org
Fixes: dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
Link: http://lkml.kernel.org/r/20190419194747.5E1AD6DC@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/mmu_context.h   |    1 -
 arch/um/include/asm/mmu_context.h        |    1 -
 arch/unicore32/include/asm/mmu_context.h |    1 -
 arch/x86/include/asm/mmu_context.h       |    6 +++---
 arch/x86/include/asm/mpx.h               |   15 ++++++++-------
 arch/x86/mm/mpx.c                        |   10 ++++++----
 include/asm-generic/mm_hooks.h           |    1 -
 mm/mmap.c                                |   15 ++++++++-------
 8 files changed, 25 insertions(+), 25 deletions(-)

--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -237,7 +237,6 @@ extern void arch_exit_mmap(struct mm_str
 #endif
 
 static inline void arch_unmap(struct mm_struct *mm,
-			      struct vm_area_struct *vma,
 			      unsigned long start, unsigned long end)
 {
 	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -22,7 +22,6 @@ static inline int arch_dup_mmap(struct m
 }
 extern void arch_exit_mmap(struct mm_struct *mm);
 static inline void arch_unmap(struct mm_struct *mm,
-			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
 }
--- a/arch/unicore32/include/asm/mmu_context.h
+++ b/arch/unicore32/include/asm/mmu_context.h
@@ -88,7 +88,6 @@ static inline int arch_dup_mmap(struct m
 }
 
 static inline void arch_unmap(struct mm_struct *mm,
-			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
 }
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -277,8 +277,8 @@ static inline void arch_bprm_mm_init(str
 	mpx_mm_init(mm);
 }
 
-static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
-			      unsigned long start, unsigned long end)
+static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
+			      unsigned long end)
 {
 	/*
 	 * mpx_notify_unmap() goes and reads a rarely-hot
@@ -298,7 +298,7 @@ static inline void arch_unmap(struct mm_
 	 * consistently wrong.
 	 */
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_MPX)))
-		mpx_notify_unmap(mm, vma, start, end);
+		mpx_notify_unmap(mm, start, end);
 }
 
 /*
--- a/arch/x86/include/asm/mpx.h
+++ b/arch/x86/include/asm/mpx.h
@@ -64,12 +64,15 @@ struct mpx_fault_info {
 };
 
 #ifdef CONFIG_X86_INTEL_MPX
-int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs);
-int mpx_handle_bd_fault(void);
+
+extern int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs);
+extern int mpx_handle_bd_fault(void);
+
 static inline int kernel_managing_mpx_tables(struct mm_struct *mm)
 {
 	return (mm->context.bd_addr != MPX_INVALID_BOUNDS_DIR);
 }
+
 static inline void mpx_mm_init(struct mm_struct *mm)
 {
 	/*
@@ -78,11 +81,10 @@ static inline void mpx_mm_init(struct mm
 	 */
 	mm->context.bd_addr = MPX_INVALID_BOUNDS_DIR;
 }
-void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
-		      unsigned long start, unsigned long end);
 
-unsigned long mpx_unmapped_area_check(unsigned long addr, unsigned long len,
-		unsigned long flags);
+extern void mpx_notify_unmap(struct mm_struct *mm, unsigned long start, unsigned long end);
+extern unsigned long mpx_unmapped_area_check(unsigned long addr, unsigned long len, unsigned long flags);
+
 #else
 static inline int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs)
 {
@@ -100,7 +102,6 @@ static inline void mpx_mm_init(struct mm
 {
 }
 static inline void mpx_notify_unmap(struct mm_struct *mm,
-				    struct vm_area_struct *vma,
 				    unsigned long start, unsigned long end)
 {
 }
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -881,9 +881,10 @@ static int mpx_unmap_tables(struct mm_st
  * the virtual address region start...end have already been split if
  * necessary, and the 'vma' is the first vma in this range (start -> end).
  */
-void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end)
+void mpx_notify_unmap(struct mm_struct *mm, unsigned long start,
+		      unsigned long end)
 {
+	struct vm_area_struct *vma;
 	int ret;
 
 	/*
@@ -902,11 +903,12 @@ void mpx_notify_unmap(struct mm_struct *
 	 * which should not occur normally. Being strict about it here
 	 * helps ensure that we do not have an exploitable stack overflow.
 	 */
-	do {
+	vma = find_vma(mm, start);
+	while (vma && vma->vm_start < end) {
 		if (vma->vm_flags & VM_MPX)
 			return;
 		vma = vma->vm_next;
-	} while (vma && vma->vm_start < end);
+	}
 
 	ret = mpx_unmap_tables(mm, start, end);
 	if (ret)
--- a/include/asm-generic/mm_hooks.h
+++ b/include/asm-generic/mm_hooks.h
@@ -18,7 +18,6 @@ static inline void arch_exit_mmap(struct
 }
 
 static inline void arch_unmap(struct mm_struct *mm,
-			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
 }
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2736,9 +2736,17 @@ int __do_munmap(struct mm_struct *mm, un
 		return -EINVAL;
 
 	len = PAGE_ALIGN(len);
+	end = start + len;
 	if (len == 0)
 		return -EINVAL;
 
+	/*
+	 * arch_unmap() might do unmaps itself.  It must be called
+	 * and finish any rbtree manipulation before this code
+	 * runs and also starts to manipulate the rbtree.
+	 */
+	arch_unmap(mm, start, end);
+
 	/* Find the first overlapping VMA */
 	vma = find_vma(mm, start);
 	if (!vma)
@@ -2747,7 +2755,6 @@ int __do_munmap(struct mm_struct *mm, un
 	/* we have  start < vma->vm_end  */
 
 	/* if it doesn't overlap, we have nothing.. */
-	end = start + len;
 	if (vma->vm_start >= end)
 		return 0;
 
@@ -2817,12 +2824,6 @@ int __do_munmap(struct mm_struct *mm, un
 	/* Detach vmas from rbtree */
 	detach_vmas_to_be_unmapped(mm, vma, prev, end);
 
-	/*
-	 * mpx unmap needs to be called with mmap_sem held for write.
-	 * It is safe to call it before unmap_region().
-	 */
-	arch_unmap(mm, vma, start, end);
-
 	if (downgrade)
 		downgrade_write(&mm->mmap_sem);
 


