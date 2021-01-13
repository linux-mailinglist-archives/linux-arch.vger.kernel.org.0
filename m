Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFB22F5482
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 22:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbhAMVOh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 16:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbhAMVJS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2021 16:09:18 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E8FC061795
        for <linux-arch@vger.kernel.org>; Wed, 13 Jan 2021 13:09:54 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kznOq-005vHf-HO; Wed, 13 Jan 2021 22:09:52 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] um: remove process stub VMA
Date:   Wed, 13 Jan 2021 22:09:44 +0100
Message-Id: <20210113220944.ba020fe73c75.Ia71e6fe697af9b196278084a9f730c30e20773c9@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210113220944.7732f6bfd3bb.Ib87c91b49d57d27314cf444696273da6d8463e9c@changeid>
References: <20210113220944.7732f6bfd3bb.Ib87c91b49d57d27314cf444696273da6d8463e9c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This mostly reverts the old commit 3963333fe676 ("uml: cover stubs
with a VMA") which had added a VMA to the existing PTEs. However,
there's no real reason to have the PTEs in the first place and the
VMA cannot be 'fixed' in place, which leads to bugs that userspace
could try to unmap them and be forcefully killed, or such. Also,
there's a bit of an ugly hole in userspace's address space.

Simplify all this: just install the stub code/page at the top of
the (inner) address space, i.e. put it just above TASK_SIZE. The
pages are simply hard-coded to be mapped in the userspace process
we use to implement an mm context, and they're out of reach of the
inner mmap/munmap/mprotect etc. since they're above TASK_SIZE.

Getting rid of the VMA also makes vma_merge() no longer hit one of
the VM_WARN_ON()s there because we installed a VMA while the code
assumes the stack VMA is the first one.

It also removes a lockdep warning about mmap_sem usage since we no
longer have uml_setup_stubs() and thus no longer need to do any
manipulation that would require mmap_sem in activate_mm().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/Kbuild         |  1 +
 arch/um/include/asm/mmu_context.h  | 30 +----------
 arch/um/include/shared/as-layout.h |  3 +-
 arch/um/kernel/exec.c              |  4 +-
 arch/um/kernel/skas/mmu.c          | 87 ------------------------------
 arch/um/kernel/tlb.c               | 15 ------
 arch/um/kernel/um_arch.c           |  5 ++
 arch/um/os-Linux/skas/process.c    |  4 --
 arch/x86/um/os-Linux/task_size.c   |  2 +-
 9 files changed, 11 insertions(+), 140 deletions(-)

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 1c63b260ecc4..da50d0bf1060 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -26,3 +26,4 @@ generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
 generic-y += kprobes.h
+generic-y += mm_hooks.h
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 17ddd4edf875..6db0c8b54330 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -9,34 +9,9 @@
 #include <linux/sched.h>
 #include <linux/mm_types.h>
 #include <linux/mmap_lock.h>
-
+#include <asm/mm_hooks.h>
 #include <asm/mmu.h>
 
-extern void uml_setup_stubs(struct mm_struct *mm);
-/*
- * Needed since we do not use the asm-generic/mm_hooks.h:
- */
-static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
-{
-	uml_setup_stubs(mm);
-	return 0;
-}
-extern void arch_exit_mmap(struct mm_struct *mm);
-static inline void arch_unmap(struct mm_struct *mm,
-			unsigned long start, unsigned long end)
-{
-}
-static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
-		bool write, bool execute, bool foreign)
-{
-	/* by default, allow everything */
-	return true;
-}
-
-/*
- * end asm-generic/mm_hooks.h functions
- */
-
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
 extern void force_flush_all(void);
@@ -48,9 +23,6 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 	 * when the new ->mm is used for the first time.
 	 */
 	__switch_mm(&new->context.id);
-	mmap_write_lock_nested(new, SINGLE_DEPTH_NESTING);
-	uml_setup_stubs(new);
-	mmap_write_unlock(new);
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 56408bf3480d..9a0bd648d872 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -20,7 +20,7 @@
  * 'UL' and other type specifiers unilaterally.  We
  * use the following macros to deal with this.
  */
-#define STUB_START 0x100000UL
+#define STUB_START stub_start
 #define STUB_CODE STUB_START
 #define STUB_DATA (STUB_CODE + UM_KERN_PAGE_SIZE)
 #define STUB_END (STUB_DATA + UM_KERN_PAGE_SIZE)
@@ -46,6 +46,7 @@ extern unsigned long long highmem;
 extern unsigned long brk_start;
 
 extern unsigned long host_task_size;
+extern unsigned long stub_start;
 
 extern int linux_main(int argc, char **argv);
 extern void uml_finishsetup(void);
diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index e8fd5d540b05..4d8498100341 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -26,9 +26,7 @@ void flush_thread(void)
 
 	arch_flush_thread(&current->thread.arch);
 
-	ret = unmap(&current->mm->context.id, 0, STUB_START, 0, &data);
-	ret = ret || unmap(&current->mm->context.id, STUB_END,
-			   host_task_size - STUB_END, 1, &data);
+	ret = unmap(&current->mm->context.id, 0, TASK_SIZE, 1, &data);
 	if (ret) {
 		printk(KERN_ERR "flush_thread - clearing address space failed, "
 		       "err = %d\n", ret);
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index d9961163da66..125df465e8ea 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -14,47 +14,6 @@
 #include <os.h>
 #include <skas.h>
 
-static int init_stub_pte(struct mm_struct *mm, unsigned long proc,
-			 unsigned long kernel)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pgd = pgd_offset(mm, proc);
-
-	p4d = p4d_alloc(mm, pgd, proc);
-	if (!p4d)
-		goto out;
-
-	pud = pud_alloc(mm, p4d, proc);
-	if (!pud)
-		goto out_pud;
-
-	pmd = pmd_alloc(mm, pud, proc);
-	if (!pmd)
-		goto out_pmd;
-
-	pte = pte_alloc_map(mm, pmd, proc);
-	if (!pte)
-		goto out_pte;
-
-	*pte = mk_pte(virt_to_page(kernel), __pgprot(_PAGE_PRESENT));
-	*pte = pte_mkread(*pte);
-	return 0;
-
- out_pte:
-	pmd_free(mm, pmd);
- out_pmd:
-	pud_free(mm, pud);
- out_pud:
-	p4d_free(mm, p4d);
- out:
-	return -ENOMEM;
-}
-
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
  	struct mm_context *from_mm = NULL;
@@ -98,52 +57,6 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	return ret;
 }
 
-void uml_setup_stubs(struct mm_struct *mm)
-{
-	int err, ret;
-
-	ret = init_stub_pte(mm, STUB_CODE,
-			    (unsigned long) __syscall_stub_start);
-	if (ret)
-		goto out;
-
-	ret = init_stub_pte(mm, STUB_DATA, mm->context.id.stack);
-	if (ret)
-		goto out;
-
-	mm->context.stub_pages[0] = virt_to_page(__syscall_stub_start);
-	mm->context.stub_pages[1] = virt_to_page(mm->context.id.stack);
-
-	/* dup_mmap already holds mmap_lock */
-	err = install_special_mapping(mm, STUB_START, STUB_END - STUB_START,
-				      VM_READ | VM_MAYREAD | VM_EXEC |
-				      VM_MAYEXEC | VM_DONTCOPY | VM_PFNMAP,
-				      mm->context.stub_pages);
-	if (err) {
-		printk(KERN_ERR "install_special_mapping returned %d\n", err);
-		goto out;
-	}
-	return;
-
-out:
-	force_sigsegv(SIGSEGV);
-}
-
-void arch_exit_mmap(struct mm_struct *mm)
-{
-	pte_t *pte;
-
-	pte = virt_to_pte(mm, STUB_CODE);
-	if (pte != NULL)
-		pte_clear(mm, STUB_CODE, pte);
-
-	pte = virt_to_pte(mm, STUB_DATA);
-	if (pte == NULL)
-		return;
-
-	pte_clear(mm, STUB_DATA, pte);
-}
-
 void destroy_context(struct mm_struct *mm)
 {
 	struct mm_context *mmu = &mm->context;
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 5be1b0da9f3b..bc38f79ca3a3 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -125,9 +125,6 @@ static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
 	struct host_vm_op *last;
 	int fd = -1, ret = 0;
 
-	if (virt + len > STUB_START && virt < STUB_END)
-		return -EINVAL;
-
 	if (hvc->userspace)
 		fd = phys_mapping(phys, &offset);
 	else
@@ -165,9 +162,6 @@ static int add_munmap(unsigned long addr, unsigned long len,
 	struct host_vm_op *last;
 	int ret = 0;
 
-	if (addr + len > STUB_START && addr < STUB_END)
-		return -EINVAL;
-
 	if (hvc->index != 0) {
 		last = &hvc->ops[hvc->index - 1];
 		if ((last->type == MUNMAP) &&
@@ -195,9 +189,6 @@ static int add_mprotect(unsigned long addr, unsigned long len,
 	struct host_vm_op *last;
 	int ret = 0;
 
-	if (addr + len > STUB_START && addr < STUB_END)
-		return -EINVAL;
-
 	if (hvc->index != 0) {
 		last = &hvc->ops[hvc->index - 1];
 		if ((last->type == MPROTECT) &&
@@ -232,9 +223,6 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 
 	pte = pte_offset_kernel(pmd, addr);
 	do {
-		if ((addr >= STUB_START) && (addr < STUB_END))
-			continue;
-
 		r = pte_read(*pte);
 		w = pte_write(*pte);
 		x = pte_exec(*pte);
@@ -478,9 +466,6 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 
 	address &= PAGE_MASK;
 
-	if (address >= STUB_START && address < STUB_END)
-		goto kill;
-
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
 		goto kill;
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 9c7e6d7ea1b3..8a0d566f6472 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -236,6 +236,7 @@ void uml_finishsetup(void)
 }
 
 /* Set during early boot */
+unsigned long stub_start;
 unsigned long task_size;
 EXPORT_SYMBOL(task_size);
 
@@ -267,6 +268,10 @@ int __init linux_main(int argc, char **argv)
 		add_arg(DEFAULT_COMMAND_LINE);
 
 	host_task_size = os_get_top_address();
+	/* reserve two pages for the stubs */
+	host_task_size -= 2 * PAGE_SIZE;
+	stub_start = host_task_size;
+
 	/*
 	 * TASK_SIZE needs to be PGDIR_SIZE aligned or else exit_mmap craps
 	 * out
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 623b0aeadf4c..fba674fac8b7 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -251,10 +251,6 @@ static int userspace_tramp(void *stack)
 	signal(SIGTERM, SIG_DFL);
 	signal(SIGWINCH, SIG_IGN);
 
-	/*
-	 * This has a pte, but it can't be mapped in with the usual
-	 * tlb_flush mechanism because this is part of that mechanism
-	 */
 	fd = phys_mapping(to_phys(__syscall_stub_start), &offset);
 	addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
 		      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
diff --git a/arch/x86/um/os-Linux/task_size.c b/arch/x86/um/os-Linux/task_size.c
index e62174638f00..1dc9adc20b1c 100644
--- a/arch/x86/um/os-Linux/task_size.c
+++ b/arch/x86/um/os-Linux/task_size.c
@@ -145,7 +145,7 @@ unsigned long os_get_top_address(void)
 unsigned long os_get_top_address(void)
 {
 	/* The old value of CONFIG_TOP_ADDR */
-	return 0x7fc0000000;
+	return 0x7fc0002000;
 }
 
 #endif
-- 
2.26.2

