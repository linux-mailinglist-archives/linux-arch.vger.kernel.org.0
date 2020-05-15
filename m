Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857B61D4FC1
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 16:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgEOOAi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 10:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEOOA3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 10:00:29 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D25C05BD09;
        Fri, 15 May 2020 07:00:28 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3942D450; Fri, 15 May 2020 16:00:26 +0200 (CEST)
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
Subject: [PATCH v3 6/7] mm: Remove vmalloc_sync_(un)mappings()
Date:   Fri, 15 May 2020 16:00:22 +0200
Message-Id: <20200515140023.25469-7-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515140023.25469-1-joro@8bytes.org>
References: <20200515140023.25469-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

These functions are not needed anymore because the vmalloc and ioremap
mappings are now synchronized when they are created or teared down.

Remove all callers and function definitions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c      | 37 -------------------------------------
 drivers/acpi/apei/ghes.c |  6 ------
 include/linux/vmalloc.h  |  2 --
 kernel/notifier.c        |  1 -
 kernel/trace/trace.c     | 12 ------------
 mm/nommu.c               | 12 ------------
 mm/vmalloc.c             | 21 ---------------------
 7 files changed, 91 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index edeb2adaf31f..255fc631b042 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -214,26 +214,6 @@ void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 	}
 }
 
-static void vmalloc_sync(void)
-{
-	unsigned long address;
-
-	if (SHARED_KERNEL_PMD)
-		return;
-
-	arch_sync_kernel_mappings(VMALLOC_START, VMALLOC_END);
-}
-
-void vmalloc_sync_mappings(void)
-{
-	vmalloc_sync();
-}
-
-void vmalloc_sync_unmappings(void)
-{
-	vmalloc_sync();
-}
-
 /*
  * 32-bit:
  *
@@ -336,23 +316,6 @@ static void dump_pagetable(unsigned long address)
 
 #else /* CONFIG_X86_64: */
 
-void vmalloc_sync_mappings(void)
-{
-	/*
-	 * 64-bit mappings might allocate new p4d/pud pages
-	 * that need to be propagated to all tasks' PGDs.
-	 */
-	sync_global_pgds(VMALLOC_START & PGDIR_MASK, VMALLOC_END);
-}
-
-void vmalloc_sync_unmappings(void)
-{
-	/*
-	 * Unmappings never allocate or free p4d/pud pages.
-	 * No work is required here.
-	 */
-}
-
 /*
  * 64-bit:
  *
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 24c9642e8fc7..aabe9c5ee515 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -167,12 +167,6 @@ int ghes_estatus_pool_init(int num_ghes)
 	if (!addr)
 		goto err_pool_alloc;
 
-	/*
-	 * New allocation must be visible in all pgd before it can be found by
-	 * an NMI allocating from the pool.
-	 */
-	vmalloc_sync_mappings();
-
 	rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
 	if (rc)
 		goto err_pool_add;
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c80bdb8a6b55..82c9a2ddcfa9 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -141,8 +141,6 @@ extern int remap_vmalloc_range_partial(struct vm_area_struct *vma,
 
 extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 							unsigned long pgoff);
-void vmalloc_sync_mappings(void);
-void vmalloc_sync_unmappings(void);
 
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 5989bbb93039..84c987dfbe03 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -519,7 +519,6 @@ NOKPROBE_SYMBOL(notify_die);
 
 int register_die_notifier(struct notifier_block *nb)
 {
-	vmalloc_sync_mappings();
 	return atomic_notifier_chain_register(&die_chain, nb);
 }
 EXPORT_SYMBOL_GPL(register_die_notifier);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 29615f15a820..f12e99b387b2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8527,18 +8527,6 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	allocate_snapshot = false;
 #endif
 
-	/*
-	 * Because of some magic with the way alloc_percpu() works on
-	 * x86_64, we need to synchronize the pgd of all the tables,
-	 * otherwise the trace events that happen in x86_64 page fault
-	 * handlers can't cope with accessing the chance that a
-	 * alloc_percpu()'d memory might be touched in the page fault trace
-	 * event. Oh, and we need to audit all other alloc_percpu() and vmalloc()
-	 * calls in tracing, because something might get triggered within a
-	 * page fault trace event!
-	 */
-	vmalloc_sync_mappings();
-
 	return 0;
 }
 
diff --git a/mm/nommu.c b/mm/nommu.c
index 318df4e236c9..b4267e1471f3 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -369,18 +369,6 @@ void vm_unmap_aliases(void)
 }
 EXPORT_SYMBOL_GPL(vm_unmap_aliases);
 
-/*
- * Implement a stub for vmalloc_sync_[un]mapping() if the architecture
- * chose not to have one.
- */
-void __weak vmalloc_sync_mappings(void)
-{
-}
-
-void __weak vmalloc_sync_unmappings(void)
-{
-}
-
 struct vm_struct *alloc_vm_area(size_t size, pte_t **ptes)
 {
 	BUG();
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 184f5a556cf7..901540e4773b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1332,12 +1332,6 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	if (unlikely(valist == NULL))
 		return false;
 
-	/*
-	 * First make sure the mappings are removed from all page-tables
-	 * before they are freed.
-	 */
-	vmalloc_sync_unmappings();
-
 	/*
 	 * TODO: to calculate a flush range without looping.
 	 * The list can be up to lazy_max_pages() elements.
@@ -3177,21 +3171,6 @@ int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 }
 EXPORT_SYMBOL(remap_vmalloc_range);
 
-/*
- * Implement stubs for vmalloc_sync_[un]mappings () if the architecture chose
- * not to have one.
- *
- * The purpose of this function is to make sure the vmalloc area
- * mappings are identical in all page-tables in the system.
- */
-void __weak vmalloc_sync_mappings(void)
-{
-}
-
-void __weak vmalloc_sync_unmappings(void)
-{
-}
-
 static int f(pte_t *pte, unsigned long addr, void *data)
 {
 	pte_t ***p = data;
-- 
2.17.1

