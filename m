Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A171D5730
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 19:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgEORQa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 13:16:30 -0400
Received: from foss.arm.com ([217.140.110.172]:59348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgEORQ3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:16:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4A8B1042;
        Fri, 15 May 2020 10:16:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1AF863F305;
        Fri, 15 May 2020 10:16:26 -0700 (PDT)
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
        Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: [PATCH v4 03/26] arm64: mte: Use Normal Tagged attributes for the linear map
Date:   Fri, 15 May 2020 18:15:49 +0100
Message-Id: <20200515171612.1020-4-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515171612.1020-1-catalin.marinas@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
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

The empty_zero_page is cleared to ensure that the tags it contains are
already zeroed. The actual tags-aware clear_page() implementation is
part of a subsequent patch.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
---

Notes:
    v3:
    - Restrict the safe attribute change in pgattr_change_is_safe() only to
      Normal to/from Normal-Tagged (old version allow any other type as long
      as old or new was Normal(-Tagged)).

 arch/arm64/include/asm/memory.h       |  1 +
 arch/arm64/include/asm/pgtable-prot.h |  2 ++
 arch/arm64/kernel/cpufeature.c        | 30 +++++++++++++++++++++++++++
 arch/arm64/mm/dump.c                  |  4 ++++
 arch/arm64/mm/mmu.c                   | 22 ++++++++++++++++++--
 arch/arm64/mm/proc.S                  |  8 +++++--
 6 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index a1871bb32bb1..472c77a68225 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -136,6 +136,7 @@
 #define MT_NORMAL_NC		3
 #define MT_NORMAL		4
 #define MT_NORMAL_WT		5
+#define MT_NORMAL_TAGGED	6
 
 /*
  * Memory types for Stage-2 translation
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 1305e28225fc..9c924b09d5c8 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -39,6 +39,7 @@ extern bool arm64_use_ng_mappings;
 #define PROT_NORMAL_NC		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_NC))
 #define PROT_NORMAL_WT		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_WT))
 #define PROT_NORMAL		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL))
+#define PROT_NORMAL_TAGGED	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_TAGGED))
 
 #define PROT_SECT_DEVICE_nGnRE	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_DEVICE_nGnRE))
 #define PROT_SECT_NORMAL	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
@@ -48,6 +49,7 @@ extern bool arm64_use_ng_mappings;
 #define _HYP_PAGE_DEFAULT	_PAGE_DEFAULT
 
 #define PAGE_KERNEL		__pgprot(PROT_NORMAL)
+#define PAGE_KERNEL_TAGGED	__pgprot(PROT_NORMAL_TAGGED)
 #define PAGE_KERNEL_RO		__pgprot((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY)
 #define PAGE_KERNEL_ROX		__pgprot((PROT_NORMAL & ~(PTE_WRITE | PTE_PXN)) | PTE_RDONLY)
 #define PAGE_KERNEL_EXEC	__pgprot(PROT_NORMAL & ~PTE_PXN)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 512a8b24c5df..d2fe8ff72324 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1414,13 +1414,43 @@ static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 #ifdef CONFIG_ARM64_MTE
 static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 {
+	u64 mair;
+
 	/* all non-zero tags excluded by default */
 	write_sysreg_s(SYS_GCR_EL1_RRND | SYS_GCR_EL1_EXCL_MASK, SYS_GCR_EL1);
 	write_sysreg_s(0, SYS_TFSR_EL1);
 	write_sysreg_s(0, SYS_TFSRE0_EL1);
 
+	/*
+	 * Update the MT_NORMAL_TAGGED index in MAIR_EL1. Tag checking is
+	 * disabled for the kernel, so there won't be any observable effect
+	 * other than allowing the kernel to read and write tags.
+	 */
+	mair = read_sysreg_s(SYS_MAIR_EL1);
+	mair &= ~MAIR_ATTRIDX(MAIR_ATTR_MASK, MT_NORMAL_TAGGED);
+	mair |= MAIR_ATTRIDX(MAIR_ATTR_NORMAL_TAGGED, MT_NORMAL_TAGGED);
+	write_sysreg_s(mair, SYS_MAIR_EL1);
+
 	isb();
 }
+
+static int __init system_enable_mte(void)
+{
+	if (!system_supports_mte())
+		return 0;
+
+	/* Ensure the TLB does not have stale MAIR attributes */
+	flush_tlb_all();
+
+	/*
+	 * Clear the zero page (again) so that tags are reset. This needs to
+	 * be done via the linear map which has the Tagged attribute.
+	 */
+	clear_page(lm_alias(empty_zero_page));
+
+	return 0;
+}
+core_initcall(system_enable_mte);
 #endif /* CONFIG_ARM64_MTE */
 
 /* Internal helper functions to match cpu capability type */
diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 860c00ec8bd3..416a2404ac83 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -165,6 +165,10 @@ static const struct prot_bits pte_bits[] = {
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
index a374e4f51a62..37bb5b19bdf4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -121,7 +121,7 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
 	 * The following mapping attributes may be updated in live
 	 * kernel mappings without the need for break-before-make.
 	 */
-	static const pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
+	pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
 
 	/* creating or taking down mappings is always safe */
 	if (old == 0 || new == 0)
@@ -135,6 +135,19 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
 	if (old & ~new & PTE_NG)
 		return false;
 
+	if (system_supports_mte()) {
+		/*
+		 * Changing the memory type between Normal and Normal-Tagged
+		 * is safe since Tagged is considered a permission attribute
+		 * from the mismatched attribute aliases perspective.
+		 */
+		if (((old & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL) ||
+		     (old & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED)) &&
+		    ((new & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL) ||
+		     (new & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED)))
+			mask |= PTE_ATTRINDX_MASK;
+	}
+
 	return ((old ^ new) & ~mask) == 0;
 }
 
@@ -489,7 +502,12 @@ static void __init map_mem(pgd_t *pgdp)
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
index 197a9ba2d5ea..48891095eaed 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -44,14 +44,18 @@
 #define TCR_KASAN_FLAGS 0
 #endif
 
-/* Default MAIR_EL1 */
+/*
+ * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
+ * changed later to Normal Tagged if the system supports MTE.
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
