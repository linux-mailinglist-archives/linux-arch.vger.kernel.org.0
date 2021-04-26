Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DAC36B141
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 12:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhDZKJP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 06:09:15 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:33778 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232766AbhDZKJB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Apr 2021 06:09:01 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 422D6C043E;
        Mon, 26 Apr 2021 10:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1619431697; bh=qDN/qUPHbR2jazBXaOLiYF2dvCU/A8yXaTIGWr7NH4g=;
        h=From:To:Cc:Subject:Date:From;
        b=MTdbJ2BbetKq35kjaEx/aeHXyjkrbVvj/WMOCssrSANrusf0p8qnM/ECEihZ80ZeH
         NXu/92ik15OBSQ2GAT5qXJ20gL+wiv2wBxh6QlnqetnUYZB8ShaGt36BY+7bO+nVsK
         C6X9GNgYfjcyyVcPYNirGy0Bms4E49gJ/p0hIJuTL2Cy0V3+Le3WWewR2mNkxoCVoO
         9cLpJx3csyd90mWYcJFksHFwb++Q2RdNtPsVeAoWDjX/VuQLYQPWS5j8jZLJtvCkOW
         sRSf6hXCt/Y2LI4dVdSVv7mTh9SQYGZ2IaFAQl/8IQ9DuXuML4QKneuWApaWpmUAg7
         vg8banKUhA2ig==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id AAA13A005E;
        Mon, 26 Apr 2021 10:08:12 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vladimir Isaev <Vladimir.Isaev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>
Subject: [PATCH] ARC: Use 40-bit physical page mask for PAE
Date:   Mon, 26 Apr 2021 13:08:01 +0300
Message-Id: <20210426100801.41308-1-isaev@synopsys.com>
X-Mailer: git-send-email 2.16.2
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

32-bit PAGE_MASK can not be used as a mask for physical addresses
when PAE is enabled. PHYSICAL_PAGE_MASK must be used for physical
addresses instead of PAGE_MASK.

Signed-off-by: Vladimir Isaev <isaev@synopsys.com>
---
 arch/arc/include/asm/pgtable.h   | 12 +++---------
 arch/arc/include/uapi/asm/page.h |  7 +++++++
 arch/arc/mm/ioremap.c            |  4 ++--
 arch/arc/mm/tlb.c                |  2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 163641726a2b..25c95fbc7021 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -107,8 +107,8 @@
 #define ___DEF (_PAGE_PRESENT | _PAGE_CACHEABLE)
 
 /* Set of bits not changed in pte_modify */
-#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_SPECIAL)
-
+#define _PAGE_CHG_MASK	(PHYSICAL_PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | \
+							       _PAGE_SPECIAL)
 /* More Abbrevaited helpers */
 #define PAGE_U_NONE     __pgprot(___DEF)
 #define PAGE_U_R        __pgprot(___DEF | _PAGE_READ)
@@ -132,13 +132,7 @@
 #define PTE_BITS_IN_PD0		(_PAGE_GLOBAL | _PAGE_PRESENT | _PAGE_HW_SZ)
 #define PTE_BITS_RWX		(_PAGE_EXECUTE | _PAGE_WRITE | _PAGE_READ)
 
-#ifdef CONFIG_ARC_HAS_PAE40
-#define PTE_BITS_NON_RWX_IN_PD1	(0xff00000000 | PAGE_MASK | _PAGE_CACHEABLE)
-#define MAX_POSSIBLE_PHYSMEM_BITS 40
-#else
-#define PTE_BITS_NON_RWX_IN_PD1	(PAGE_MASK | _PAGE_CACHEABLE)
-#define MAX_POSSIBLE_PHYSMEM_BITS 32
-#endif
+#define PTE_BITS_NON_RWX_IN_PD1	(PHYSICAL_PAGE_MASK | _PAGE_CACHEABLE)
 
 /**************************************************************************
  * Mapping of vm_flags (Generic VM) to PTE flags (arch specific)
diff --git a/arch/arc/include/uapi/asm/page.h b/arch/arc/include/uapi/asm/page.h
index 2a97e2718a21..8fecf2a2b592 100644
--- a/arch/arc/include/uapi/asm/page.h
+++ b/arch/arc/include/uapi/asm/page.h
@@ -33,5 +33,12 @@
 
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
+#ifdef CONFIG_ARC_HAS_PAE40
+#define MAX_POSSIBLE_PHYSMEM_BITS 40
+#define PHYSICAL_PAGE_MASK	(0xff00000000ull | PAGE_MASK)
+#else
+#define MAX_POSSIBLE_PHYSMEM_BITS 32
+#define PHYSICAL_PAGE_MASK	PAGE_MASK
+#endif
 
 #endif /* _UAPI__ASM_ARC_PAGE_H */
diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
index fac4adc90204..eb109d57d544 100644
--- a/arch/arc/mm/ioremap.c
+++ b/arch/arc/mm/ioremap.c
@@ -71,8 +71,8 @@ void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
 	prot = pgprot_noncached(prot);
 
 	/* Mappings have to be page-aligned */
-	off = paddr & ~PAGE_MASK;
-	paddr &= PAGE_MASK;
+	off = paddr & ~PHYSICAL_PAGE_MASK;
+	paddr &= PHYSICAL_PAGE_MASK;
 	size = PAGE_ALIGN(end + 1) - paddr;
 
 	/*
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 9bb3c24f3677..15a3b92e9e72 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -576,7 +576,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long vaddr_unaligned,
 		      pte_t *ptep)
 {
 	unsigned long vaddr = vaddr_unaligned & PAGE_MASK;
-	phys_addr_t paddr = pte_val(*ptep) & PAGE_MASK;
+	phys_addr_t paddr = pte_val(*ptep) & PHYSICAL_PAGE_MASK;
 	struct page *page = pfn_to_page(pte_pfn(*ptep));
 
 	create_tlb(vma, vaddr, ptep);
-- 
2.16.2

