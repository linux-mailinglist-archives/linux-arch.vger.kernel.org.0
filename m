Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B5F4C67CB
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 11:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiB1KvY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 05:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbiB1Kuo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 05:50:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6102666628;
        Mon, 28 Feb 2022 02:50:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CB0012FC;
        Mon, 28 Feb 2022 02:50:02 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 417303F73D;
        Mon, 28 Feb 2022 02:49:53 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-parisc@vger.kernel.org,
        openrisc@lists.librecores.org, linux-um@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH V3 09/30] arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 28 Feb 2022 16:17:32 +0530
Message-Id: <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm/Kconfig                   |  1 +
 arch/arm/include/asm/pgtable.h     | 20 +-------------
 arch/arm/lib/uaccess_with_memcpy.c |  2 +-
 arch/arm/mm/mmu.c                  | 44 ++++++++++++++++++++++++++----
 4 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c97cb40eebb..87b2e89ef3d6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -23,6 +23,7 @@ config ARM
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB || !MMU
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if CPU_V7 || CPU_V7M || CPU_V6K
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index cd1f84bb40ae..64711716cd84 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -70,7 +70,7 @@ extern void __pgd_error(const char *file, int line, pgd_t);
 #endif
 
 /*
- * The pgprot_* and protection_map entries will be fixed up in runtime
+ * The pgprot_* entries will be fixed up in runtime in vm_get_page_prot()
  * to include the cachable and bufferable bits based on memory policy,
  * as well as any architecture dependent bits like global/ASID and SMP
  * shared mapping bits.
@@ -137,24 +137,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
  *  2) If we could do execute protection, then read is implied
  *  3) write implies read permissions
  */
-#define __P000  __PAGE_NONE
-#define __P001  __PAGE_READONLY
-#define __P010  __PAGE_COPY
-#define __P011  __PAGE_COPY
-#define __P100  __PAGE_READONLY_EXEC
-#define __P101  __PAGE_READONLY_EXEC
-#define __P110  __PAGE_COPY_EXEC
-#define __P111  __PAGE_COPY_EXEC
-
-#define __S000  __PAGE_NONE
-#define __S001  __PAGE_READONLY
-#define __S010  __PAGE_SHARED
-#define __S011  __PAGE_SHARED
-#define __S100  __PAGE_READONLY_EXEC
-#define __S101  __PAGE_READONLY_EXEC
-#define __S110  __PAGE_SHARED_EXEC
-#define __S111  __PAGE_SHARED_EXEC
-
 #ifndef __ASSEMBLY__
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 106f83a5ea6d..12d8d9794a28 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -247,7 +247,7 @@ static int __init test_size_treshold(void)
 	if (!dst_page)
 		goto no_dst;
 	kernel_ptr = page_address(src_page);
-	user_ptr = vmap(&dst_page, 1, VM_IOREMAP, __pgprot(__P010));
+	user_ptr = vmap(&dst_page, 1, VM_IOREMAP, __pgprot(__PAGE_COPY));
 	if (!user_ptr)
 		goto no_vmap;
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 274e4f73fd33..9cdf45da57de 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -403,6 +403,8 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
 }
 
+static pteval_t user_pgprot;
+
 /*
  * Adjust the PMD section entries according to the CPU in use.
  */
@@ -410,7 +412,7 @@ static void __init build_mem_type_table(void)
 {
 	struct cachepolicy *cp;
 	unsigned int cr = get_cr();
-	pteval_t user_pgprot, kern_pgprot, vecs_pgprot;
+	pteval_t kern_pgprot, vecs_pgprot;
 	int cpu_arch = cpu_architecture();
 	int i;
 
@@ -627,11 +629,6 @@ static void __init build_mem_type_table(void)
 	user_pgprot |= PTE_EXT_PXN;
 #endif
 
-	for (i = 0; i < 16; i++) {
-		pteval_t v = pgprot_val(protection_map[i]);
-		protection_map[i] = __pgprot(v | user_pgprot);
-	}
-
 	mem_types[MT_LOW_VECTORS].prot_pte |= vecs_pgprot;
 	mem_types[MT_HIGH_VECTORS].prot_pte |= vecs_pgprot;
 
@@ -670,6 +667,41 @@ static void __init build_mem_type_table(void)
 	}
 }
 
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return __pgprot(pgprot_val(__PAGE_NONE) | user_pgprot);
+	case VM_READ:
+		return __pgprot(pgprot_val(__PAGE_READONLY) | user_pgprot);
+	case VM_WRITE:
+	case VM_WRITE | VM_READ:
+		return __pgprot(pgprot_val(__PAGE_COPY) | user_pgprot);
+	case VM_EXEC:
+	case VM_EXEC | VM_READ:
+		return __pgprot(pgprot_val(__PAGE_READONLY_EXEC) | user_pgprot);
+	case VM_EXEC | VM_WRITE:
+	case VM_EXEC | VM_WRITE | VM_READ:
+		return __pgprot(pgprot_val(__PAGE_COPY_EXEC) | user_pgprot);
+	case VM_SHARED:
+		return __pgprot(pgprot_val(__PAGE_NONE) | user_pgprot);
+	case VM_SHARED | VM_READ:
+		return __pgprot(pgprot_val(__PAGE_READONLY) | user_pgprot);
+	case VM_SHARED | VM_WRITE:
+	case VM_SHARED | VM_WRITE | VM_READ:
+		return __pgprot(pgprot_val(__PAGE_SHARED) | user_pgprot);
+	case VM_SHARED | VM_EXEC:
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return __pgprot(pgprot_val(__PAGE_READONLY_EXEC) | user_pgprot);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
+		return __pgprot(pgprot_val(__PAGE_SHARED_EXEC) | user_pgprot);
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
+
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
-- 
2.25.1

