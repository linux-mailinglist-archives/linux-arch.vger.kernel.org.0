Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261FD25077A
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 20:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHXS2N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 14:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHXS2H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 14:28:07 -0400
Received: from localhost.localdomain (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B41620FC3;
        Mon, 24 Aug 2020 18:28:04 +0000 (UTC)
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
        Andrew Morton <akpm@linux-foundation.org>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: [PATCH v8 02/28] arm64: mte: Use Normal Tagged attributes for the linear map
Date:   Mon, 24 Aug 2020 19:27:32 +0100
Message-Id: <20200824182758.27267-3-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824182758.27267-1-catalin.marinas@arm.com>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Once user space is given access to tagged memory, the kernel must be
able to clear/save/restore tags visible to the user. This is done via
the linear mapping, therefore map it as such. The new MT_NORMAL_TAGGED
index for MAIR_EL1 is initially mapped as Normal memory and later
changed to Normal Tagged via the cpufeature infrastructure. From a
mismatched attribute aliases perspective, the Tagged memory is
considered a permission and it won't lead to undefined behaviour.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
---

Notes:
    v8:
    - Defer the MAIR_EL1 initialisation to the patch introducing the
      cpufeature checks.
    - Remove the system_supports_mte() check in pgattr_change_is_safe()
      since MT_NORMAL_TAGGED will be used even if MTE is not present (but
      mapped to Normal Cacheable memory).
    
    v5:
    - Move the clearing of the zero page since clear_page() to a later
      patch.
    
    v3:
    - Restrict the safe attribute change in pgattr_change_is_safe() only to
      Normal to/from Normal-Tagged (old version allow any other type as long
      as old or new was Normal(-Tagged)).

 arch/arm64/include/asm/memory.h       |  1 +
 arch/arm64/include/asm/pgtable-prot.h |  2 ++
 arch/arm64/mm/dump.c                  |  4 ++++
 arch/arm64/mm/mmu.c                   | 20 ++++++++++++++++++--
 arch/arm64/mm/proc.S                  |  8 ++++++--
 5 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index afa722504bfd..1e0a78266410 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -133,6 +133,7 @@
 #define MT_NORMAL_NC		3
 #define MT_NORMAL		4
 #define MT_NORMAL_WT		5
+#define MT_NORMAL_TAGGED	6
 
 /*
  * Memory types for Stage-2 translation
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 4d867c6446c4..afd8b9fc76f2 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -50,6 +50,7 @@ extern bool arm64_use_ng_mappings;
 #define PROT_NORMAL_NC		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_NC))
 #define PROT_NORMAL_WT		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_WT))
 #define PROT_NORMAL		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL))
+#define PROT_NORMAL_TAGGED	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_TAGGED))
 
 #define PROT_SECT_DEVICE_nGnRE	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_DEVICE_nGnRE))
 #define PROT_SECT_NORMAL	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
@@ -59,6 +60,7 @@ extern bool arm64_use_ng_mappings;
 #define _HYP_PAGE_DEFAULT	_PAGE_DEFAULT
 
 #define PAGE_KERNEL		__pgprot(PROT_NORMAL)
+#define PAGE_KERNEL_TAGGED	__pgprot(PROT_NORMAL_TAGGED)
 #define PAGE_KERNEL_RO		__pgprot((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY)
 #define PAGE_KERNEL_ROX		__pgprot((PROT_NORMAL & ~(PTE_WRITE | PTE_PXN)) | PTE_RDONLY)
 #define PAGE_KERNEL_EXEC	__pgprot(PROT_NORMAL & ~PTE_PXN)
diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 0b8da1cc1c07..ba6d1d89f9b2 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -169,6 +169,10 @@ static const struct prot_bits pte_bits[] = {
 		.mask	= PTE_ATTRINDX_MASK,
 		.val	= PTE_ATTRINDX(MT_NORMAL),
 		.set	= "MEM/NORMAL",
+	}, {
+		.mask	= PTE_ATTRINDX_MASK,
+		.val	= PTE_ATTRINDX(MT_NORMAL_TAGGED),
+		.set	= "MEM/NORMAL-TAGGED",
 	}
 };
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62fea1b6..936c4762dadf 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -122,7 +122,7 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
 	 * The following mapping attributes may be updated in live
 	 * kernel mappings without the need for break-before-make.
 	 */
-	static const pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
+	pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
 
 	/* creating or taking down mappings is always safe */
 	if (old == 0 || new == 0)
@@ -136,6 +136,17 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
 	if (old & ~new & PTE_NG)
 		return false;
 
+	/*
+	 * Changing the memory type between Normal and Normal-Tagged is safe
+	 * since Tagged is considered a permission attribute from the
+	 * mismatched attribute aliases perspective.
+	 */
+	if (((old & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL) ||
+	     (old & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED)) &&
+	    ((new & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL) ||
+	     (new & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED)))
+		mask |= PTE_ATTRINDX_MASK;
+
 	return ((old ^ new) & ~mask) == 0;
 }
 
@@ -491,7 +502,12 @@ static void __init map_mem(pgd_t *pgdp)
 		if (memblock_is_nomap(reg))
 			continue;
 
-		__map_memblock(pgdp, start, end, PAGE_KERNEL, flags);
+		/*
+		 * The linear map must allow allocation tags reading/writing
+		 * if MTE is present. Otherwise, it has the same attributes as
+		 * PAGE_KERNEL.
+		 */
+		__map_memblock(pgdp, start, end, PAGE_KERNEL_TAGGED, flags);
 	}
 
 	/*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 796e47a571e6..4817ed52e343 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -44,14 +44,18 @@
 #define TCR_KASAN_FLAGS 0
 #endif
 
-/* Default MAIR_EL1 */
+/*
+ * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
+ * changed during __cpu_setup to Normal Tagged if the system supports MTE.
+ */
 #define MAIR_EL1_SET							\
 	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
 	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
 	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
 	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
 	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT))
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
 
 #ifdef CONFIG_CPU_PM
 /**
