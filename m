Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823361CB208
	for <lists+linux-arch@lfdr.de>; Fri,  8 May 2020 16:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgEHOlF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 10:41:05 -0400
Received: from 8bytes.org ([81.169.241.247]:41756 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgEHOk4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 10:40:56 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6C5F34F2; Fri,  8 May 2020 16:40:51 +0200 (CEST)
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
Subject: [RFC PATCH 6/7] mm: Remove vmalloc_sync_(un)mappings()
Date:   Fri,  8 May 2020 16:40:42 +0200
Message-Id: <20200508144043.13893-7-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508144043.13893-1-joro@8bytes.org>
References: <20200508144043.13893-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

These functions are not needed anymore because the vmalloc and ioremap
mappings are now synchronized when they are created or teared down.

Remove all callers and function definitions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/fault.c      | 37 -------------------------------------
 drivers/acpi/apei/ghes.c |  6 ------
 include/linux/vmalloc.h  |  2 --
 kernel/notifier.c        |  1 -
 mm/nommu.c               | 12 ------------
 mm/vmalloc.c             | 21 ---------------------
 6 files changed, 79 deletions(-)

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
index eb364000cb03..9063cdeb15bb 100644
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

