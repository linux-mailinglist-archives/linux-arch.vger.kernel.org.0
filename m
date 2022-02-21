Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BDD4BD64D
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 07:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbiBUGj2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 01:39:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345289AbiBUGj0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 01:39:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A108275FC;
        Sun, 20 Feb 2022 22:39:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 165901396;
        Sun, 20 Feb 2022 22:39:03 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.49.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 325CA3F70D;
        Sun, 20 Feb 2022 22:38:59 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 05/30] arm64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 21 Feb 2022 12:08:14 +0530
Message-Id: <1645425519-9034-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
References: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed. This also localizes both
arch_filter_pgprot and arch_vm_get_page_prot() helpers, unsubscribing from
ARCH_HAS_FILTER_PGPROT as well. Moved both these localized functions near
vm_get_page_prot().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig                    |  2 +-
 arch/arm64/include/asm/mman.h         | 24 ---------
 arch/arm64/include/asm/pgtable-prot.h | 18 -------
 arch/arm64/include/asm/pgtable.h      | 11 ----
 arch/arm64/mm/mmap.c                  | 78 +++++++++++++++++++++++++++
 5 files changed, 79 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2e5d2eac6fc6..7153d5fff603 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -23,7 +23,6 @@ config ARM64
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_FAST_MULTIPLIER
-	select ARCH_HAS_FILTER_PGPROT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
@@ -44,6 +43,7 @@ config ARM64
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_ELF_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index e3e28f7daf62..5966ee4a6154 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -35,30 +35,6 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
 }
 #define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
 
-static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
-{
-	pteval_t prot = 0;
-
-	if (vm_flags & VM_ARM64_BTI)
-		prot |= PTE_GP;
-
-	/*
-	 * There are two conditions required for returning a Normal Tagged
-	 * memory type: (1) the user requested it via PROT_MTE passed to
-	 * mmap() or mprotect() and (2) the corresponding vma supports MTE. We
-	 * register (1) as VM_MTE in the vma->vm_flags and (2) as
-	 * VM_MTE_ALLOWED. Note that the latter can only be set during the
-	 * mmap() call since mprotect() does not accept MAP_* flags.
-	 * Checking for VM_MTE only is sufficient since arch_validate_flags()
-	 * does not permit (VM_MTE & !VM_MTE_ALLOWED).
-	 */
-	if (vm_flags & VM_MTE)
-		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
-
-	return __pgprot(prot);
-}
-#define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
-
 static inline bool arch_validate_prot(unsigned long prot,
 	unsigned long addr __always_unused)
 {
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 7032f04c8ac6..d8ee0aa7886d 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -88,24 +88,6 @@ extern bool arm64_use_ng_mappings;
 #define PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN)
 #define PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_RDONLY | PTE_NG | PTE_PXN)
 
-#define __P000  PAGE_NONE
-#define __P001  PAGE_READONLY
-#define __P010  PAGE_READONLY
-#define __P011  PAGE_READONLY
-#define __P100  PAGE_EXECONLY
-#define __P101  PAGE_READONLY_EXEC
-#define __P110  PAGE_READONLY_EXEC
-#define __P111  PAGE_READONLY_EXEC
-
-#define __S000  PAGE_NONE
-#define __S001  PAGE_READONLY
-#define __S010  PAGE_SHARED
-#define __S011  PAGE_SHARED
-#define __S100  PAGE_EXECONLY
-#define __S101  PAGE_READONLY_EXEC
-#define __S110  PAGE_SHARED_EXEC
-#define __S111  PAGE_SHARED_EXEC
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_PROT_H */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c4ba047a82d2..94e147e5456c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1017,17 +1017,6 @@ static inline bool arch_wants_old_prefaulted_pte(void)
 }
 #define arch_wants_old_prefaulted_pte	arch_wants_old_prefaulted_pte
 
-static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
-{
-	if (cpus_have_const_cap(ARM64_HAS_EPAN))
-		return prot;
-
-	if (pgprot_val(prot) != pgprot_val(PAGE_EXECONLY))
-		return prot;
-
-	return PAGE_READONLY_EXEC;
-}
-
 static inline bool pud_sect_supported(void)
 {
 	return PAGE_SIZE == SZ_4K;
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index a38f54cd638c..bd0233d376a2 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 
 #include <asm/page.h>
+#include <asm/mman.h>
 
 /*
  * You really shouldn't be using read() or write() on /dev/mem.  This might go
@@ -38,3 +39,80 @@ int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
 	return !(((pfn << PAGE_SHIFT) + size) & ~PHYS_MASK);
 }
+
+static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return PAGE_NONE;
+	case VM_READ:
+	case VM_WRITE:
+	case VM_WRITE | VM_READ:
+		return PAGE_READONLY;
+	case VM_EXEC:
+		return PAGE_EXECONLY;
+	case VM_EXEC | VM_READ:
+	case VM_EXEC | VM_WRITE:
+	case VM_EXEC | VM_WRITE | VM_READ:
+		return PAGE_READONLY_EXEC;
+	case VM_SHARED:
+		return PAGE_NONE;
+	case VM_SHARED | VM_READ:
+		return PAGE_READONLY;
+	case VM_SHARED | VM_WRITE:
+	case VM_SHARED | VM_WRITE | VM_READ:
+		return PAGE_SHARED;
+	case VM_SHARED | VM_EXEC:
+		return PAGE_EXECONLY;
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return PAGE_READONLY_EXEC;
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
+		return PAGE_SHARED_EXEC;
+	default:
+		BUILD_BUG();
+	}
+}
+
+static pgprot_t arm64_arch_filter_pgprot(pgprot_t prot)
+{
+	if (cpus_have_const_cap(ARM64_HAS_EPAN))
+		return prot;
+
+	if (pgprot_val(prot) != pgprot_val(PAGE_EXECONLY))
+		return prot;
+
+	return PAGE_READONLY_EXEC;
+}
+
+static pgprot_t arm64_arch_vm_get_page_prot(unsigned long vm_flags)
+{
+	pteval_t prot = 0;
+
+	if (vm_flags & VM_ARM64_BTI)
+		prot |= PTE_GP;
+
+	/*
+	 * There are two conditions required for returning a Normal Tagged
+	 * memory type: (1) the user requested it via PROT_MTE passed to
+	 * mmap() or mprotect() and (2) the corresponding vma supports MTE. We
+	 * register (1) as VM_MTE in the vma->vm_flags and (2) as
+	 * VM_MTE_ALLOWED. Note that the latter can only be set during the
+	 * mmap() call since mprotect() does not accept MAP_* flags.
+	 * Checking for VM_MTE only is sufficient since arch_validate_flags()
+	 * does not permit (VM_MTE & !VM_MTE_ALLOWED).
+	 */
+	if (vm_flags & VM_MTE)
+		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
+
+	return __pgprot(prot);
+}
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	pgprot_t ret = __pgprot(pgprot_val(__vm_get_page_prot(vm_flags)) |
+			pgprot_val(arm64_arch_vm_get_page_prot(vm_flags)));
+
+	return arm64_arch_filter_pgprot(ret);
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1

