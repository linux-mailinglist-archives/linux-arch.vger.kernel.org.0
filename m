Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322681CB203
	for <lists+linux-arch@lfdr.de>; Fri,  8 May 2020 16:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgEHOk7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 10:40:59 -0400
Received: from 8bytes.org ([81.169.241.247]:41758 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgEHOk6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 10:40:58 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 85B084D9; Fri,  8 May 2020 16:40:51 +0200 (CEST)
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
        Joerg Roedel <jroedel@suse.de>, joro@8bytes.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH 7/7] x86/mm: Remove vmalloc faulting
Date:   Fri,  8 May 2020 16:40:43 +0200
Message-Id: <20200508144043.13893-8-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508144043.13893-1-joro@8bytes.org>
References: <20200508144043.13893-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Remove fault handling on vmalloc areas, as the vmalloc code now takes
care of synchronizing changes to all page-tables in the system.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/switch_to.h |  23 ------
 arch/x86/kernel/setup_percpu.c   |   6 +-
 arch/x86/mm/fault.c              | 134 -------------------------------
 arch/x86/mm/pti.c                |   8 +-
 4 files changed, 4 insertions(+), 167 deletions(-)

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
-- 
2.17.1

