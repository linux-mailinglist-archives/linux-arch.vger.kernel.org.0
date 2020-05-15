Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FD31D4FBE
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgEOOAa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 10:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726171AbgEOOA3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 10:00:29 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0BC061A0C;
        Fri, 15 May 2020 07:00:29 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6A84E47C; Fri, 15 May 2020 16:00:26 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, joro@8bytes.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 7/7] x86/mm: Remove vmalloc faulting
Date:   Fri, 15 May 2020 16:00:23 +0200
Message-Id: <20200515140023.25469-8-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515140023.25469-1-joro@8bytes.org>
References: <20200515140023.25469-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Remove fault handling on vmalloc areas, as the vmalloc code now takes
care of synchronizing changes to all page-tables in the system.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/switch_to.h |  23 ------
 arch/x86/kernel/setup_percpu.c   |   6 +-
 arch/x86/mm/fault.c              | 134 -------------------------------
 arch/x86/mm/pti.c                |   8 +-
 arch/x86/mm/tlb.c                |  37 ---------
 5 files changed, 4 insertions(+), 204 deletions(-)

diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 0e059b73437b..9f69cc497f4b 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -12,27 +12,6 @@ struct task_struct *__switch_to_asm(struct task_struct *prev,
 __visible struct task_struct *__switch_to(struct task_struct *prev,
 					  struct task_struct *next);
 
-/* This runs runs on the previous thread's stack. */
-static inline void prepare_switch_to(struct task_struct *next)
-{
-#ifdef CONFIG_VMAP_STACK
-	/*
-	 * If we switch to a stack that has a top-level paging entry
-	 * that is not present in the current mm, the resulting #PF will
-	 * will be promoted to a double-fault and we'll panic.  Probe
-	 * the new stack now so that vmalloc_fault can fix up the page
-	 * tables if needed.  This can only happen if we use a stack
-	 * in vmap space.
-	 *
-	 * We assume that the stack is aligned so that it never spans
-	 * more than one top-level paging entry.
-	 *
-	 * To minimize cache pollution, just follow the stack pointer.
-	 */
-	READ_ONCE(*(unsigned char *)next->thread.sp);
-#endif
-}
-
 asmlinkage void ret_from_fork(void);
 
 /*
@@ -67,8 +46,6 @@ struct fork_frame {
 
 #define switch_to(prev, next, last)					\
 do {									\
-	prepare_switch_to(next);					\
-									\
 	((last) = __switch_to_asm((prev), (next)));			\
 } while (0)
 
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index e6d7894ad127..fd945ce78554 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -287,9 +287,9 @@ void __init setup_per_cpu_areas(void)
 	/*
 	 * Sync back kernel address range again.  We already did this in
 	 * setup_arch(), but percpu data also needs to be available in
-	 * the smpboot asm.  We can't reliably pick up percpu mappings
-	 * using vmalloc_fault(), because exception dispatch needs
-	 * percpu data.
+	 * the smpboot asm and arch_sync_kernel_mappings() doesn't sync to
+	 * swapper_pg_dir on 32-bit. The per-cpu mappings need to be available
+	 * there too.
 	 *
 	 * FIXME: Can the later sync in setup_cpu_entry_areas() replace
 	 * this call?
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 255fc631b042..dffe8e4d3140 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -214,44 +214,6 @@ void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 	}
 }
 
-/*
- * 32-bit:
- *
- *   Handle a fault on the vmalloc or module mapping area
- */
-static noinline int vmalloc_fault(unsigned long address)
-{
-	unsigned long pgd_paddr;
-	pmd_t *pmd_k;
-	pte_t *pte_k;
-
-	/* Make sure we are in vmalloc area: */
-	if (!(address >= VMALLOC_START && address < VMALLOC_END))
-		return -1;
-
-	/*
-	 * Synchronize this task's top level page-table
-	 * with the 'reference' page table.
-	 *
-	 * Do _not_ use "current" here. We might be inside
-	 * an interrupt in the middle of a task switch..
-	 */
-	pgd_paddr = read_cr3_pa();
-	pmd_k = vmalloc_sync_one(__va(pgd_paddr), address);
-	if (!pmd_k)
-		return -1;
-
-	if (pmd_large(*pmd_k))
-		return 0;
-
-	pte_k = pte_offset_kernel(pmd_k, address);
-	if (!pte_present(*pte_k))
-		return -1;
-
-	return 0;
-}
-NOKPROBE_SYMBOL(vmalloc_fault);
-
 /*
  * Did it hit the DOS screen memory VA from vm86 mode?
  */
@@ -316,79 +278,6 @@ static void dump_pagetable(unsigned long address)
 
 #else /* CONFIG_X86_64: */
 
-/*
- * 64-bit:
- *
- *   Handle a fault on the vmalloc area
- */
-static noinline int vmalloc_fault(unsigned long address)
-{
-	pgd_t *pgd, *pgd_k;
-	p4d_t *p4d, *p4d_k;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	/* Make sure we are in vmalloc area: */
-	if (!(address >= VMALLOC_START && address < VMALLOC_END))
-		return -1;
-
-	/*
-	 * Copy kernel mappings over when needed. This can also
-	 * happen within a race in page table update. In the later
-	 * case just flush:
-	 */
-	pgd = (pgd_t *)__va(read_cr3_pa()) + pgd_index(address);
-	pgd_k = pgd_offset_k(address);
-	if (pgd_none(*pgd_k))
-		return -1;
-
-	if (pgtable_l5_enabled()) {
-		if (pgd_none(*pgd)) {
-			set_pgd(pgd, *pgd_k);
-			arch_flush_lazy_mmu_mode();
-		} else {
-			BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_k));
-		}
-	}
-
-	/* With 4-level paging, copying happens on the p4d level. */
-	p4d = p4d_offset(pgd, address);
-	p4d_k = p4d_offset(pgd_k, address);
-	if (p4d_none(*p4d_k))
-		return -1;
-
-	if (p4d_none(*p4d) && !pgtable_l5_enabled()) {
-		set_p4d(p4d, *p4d_k);
-		arch_flush_lazy_mmu_mode();
-	} else {
-		BUG_ON(p4d_pfn(*p4d) != p4d_pfn(*p4d_k));
-	}
-
-	BUILD_BUG_ON(CONFIG_PGTABLE_LEVELS < 4);
-
-	pud = pud_offset(p4d, address);
-	if (pud_none(*pud))
-		return -1;
-
-	if (pud_large(*pud))
-		return 0;
-
-	pmd = pmd_offset(pud, address);
-	if (pmd_none(*pmd))
-		return -1;
-
-	if (pmd_large(*pmd))
-		return 0;
-
-	pte = pte_offset_kernel(pmd, address);
-	if (!pte_present(*pte))
-		return -1;
-
-	return 0;
-}
-NOKPROBE_SYMBOL(vmalloc_fault);
-
 #ifdef CONFIG_CPU_SUP_AMD
 static const char errata93_warning[] =
 KERN_ERR 
@@ -1227,29 +1116,6 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	 */
 	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
 
-	/*
-	 * We can fault-in kernel-space virtual memory on-demand. The
-	 * 'reference' page table is init_mm.pgd.
-	 *
-	 * NOTE! We MUST NOT take any locks for this case. We may
-	 * be in an interrupt or a critical region, and should
-	 * only copy the information from the master page table,
-	 * nothing more.
-	 *
-	 * Before doing this on-demand faulting, ensure that the
-	 * fault is not any of the following:
-	 * 1. A fault on a PTE with a reserved bit set.
-	 * 2. A fault caused by a user-mode access.  (Do not demand-
-	 *    fault kernel memory due to user-mode accesses).
-	 * 3. A fault caused by a page-level protection violation.
-	 *    (A demand fault would be on a non-present page which
-	 *     would have X86_PF_PROT==0).
-	 */
-	if (!(hw_error_code & (X86_PF_RSVD | X86_PF_USER | X86_PF_PROT))) {
-		if (vmalloc_fault(address) >= 0)
-			return;
-	}
-
 	/* Was the fault spurious, caused by lazy TLB invalidation? */
 	if (spurious_kernel_fault(hw_error_code, address))
 		return;
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 843aa10a4cb6..da0fb17a1a36 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -448,13 +448,7 @@ static void __init pti_clone_user_shared(void)
 		 * the sp1 and sp2 slots.
 		 *
 		 * This is done for all possible CPUs during boot to ensure
-		 * that it's propagated to all mms.  If we were to add one of
-		 * these mappings during CPU hotplug, we would need to take
-		 * some measure to make sure that every mm that subsequently
-		 * ran on that CPU would have the relevant PGD entry in its
-		 * pagetables.  The usual vmalloc_fault() mechanism would not
-		 * work for page faults taken in entry_SYSCALL_64 before RSP
-		 * is set up.
+		 * that it's propagated to all mms.
 		 */
 
 		unsigned long va = (unsigned long)&per_cpu(cpu_tss_rw, cpu);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 66f96f21a7b6..f3fe261e5936 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -161,34 +161,6 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	local_irq_restore(flags);
 }
 
-static void sync_current_stack_to_mm(struct mm_struct *mm)
-{
-	unsigned long sp = current_stack_pointer;
-	pgd_t *pgd = pgd_offset(mm, sp);
-
-	if (pgtable_l5_enabled()) {
-		if (unlikely(pgd_none(*pgd))) {
-			pgd_t *pgd_ref = pgd_offset_k(sp);
-
-			set_pgd(pgd, *pgd_ref);
-		}
-	} else {
-		/*
-		 * "pgd" is faked.  The top level entries are "p4d"s, so sync
-		 * the p4d.  This compiles to approximately the same code as
-		 * the 5-level case.
-		 */
-		p4d_t *p4d = p4d_offset(pgd, sp);
-
-		if (unlikely(p4d_none(*p4d))) {
-			pgd_t *pgd_ref = pgd_offset_k(sp);
-			p4d_t *p4d_ref = p4d_offset(pgd_ref, sp);
-
-			set_p4d(p4d, *p4d_ref);
-		}
-	}
-}
-
 static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
@@ -377,15 +349,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 */
 		cond_ibpb(tsk);
 
-		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
-			/*
-			 * If our current stack is in vmalloc space and isn't
-			 * mapped in the new pgd, we'll double-fault.  Forcibly
-			 * map it.
-			 */
-			sync_current_stack_to_mm(next);
-		}
-
 		/*
 		 * Stop remote flushes for the previous mm.
 		 * Skip kernel threads; we never send init_mm TLB flushing IPIs,
-- 
2.17.1

