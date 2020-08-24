Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4589725077B
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 20:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgHXS2N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 14:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgHXS2L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 14:28:11 -0400
Received: from localhost.localdomain (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6749320767;
        Mon, 24 Aug 2020 18:28:07 +0000 (UTC)
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
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: [PATCH v8 03/28] arm64: mte: CPU feature detection and initial sysreg configuration
Date:   Mon, 24 Aug 2020 19:27:33 +0100
Message-Id: <20200824182758.27267-4-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824182758.27267-1-catalin.marinas@arm.com>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Add the cpufeature and hwcap entries to detect the presence of MTE. Any
secondary CPU not supporting the feature, if detected on the boot CPU,
will be parked.

Add the minimum SCTLR_EL1 and HCR_EL2 bits for enabling MTE. The Normal
Tagged memory type is configured in MAIR_EL1 before the MMU is enabled
in order to avoid disrupting other CPUs in the CnP domain.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
---

Notes:
    v8:
    - Move the SCTLR_EL1, MAIR_EL1, GCR_EL1 and TFSR*_EL1 initialisation to
      __cpu_setup before the MMU is enabled. While early MAIR_EL1 is
      desirable to avoid conflicting with other CPUs in a CnP domain the
      TFSR_EL1 and GCR_EL1 will only come in handy later when support for
      in-kernel MTE is added.
    
    v7:
    - Hide the MTE ID register field for guests until MTE gains support for KVM.

 arch/arm64/include/asm/cpucaps.h    |  3 ++-
 arch/arm64/include/asm/cpufeature.h |  6 ++++++
 arch/arm64/include/asm/hwcap.h      |  2 +-
 arch/arm64/include/asm/kvm_arm.h    |  2 +-
 arch/arm64/include/asm/sysreg.h     |  1 +
 arch/arm64/include/uapi/asm/hwcap.h |  2 +-
 arch/arm64/kernel/cpufeature.c      | 17 +++++++++++++++++
 arch/arm64/kernel/cpuinfo.c         |  2 +-
 arch/arm64/kvm/sys_regs.c           |  2 ++
 arch/arm64/mm/proc.S                | 24 ++++++++++++++++++++++++
 10 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 07b643a70710..1937653b05a3 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -64,7 +64,8 @@
 #define ARM64_BTI				54
 #define ARM64_HAS_ARMv8_4_TTL			55
 #define ARM64_HAS_TLB_RANGE			56
+#define ARM64_MTE				57
 
-#define ARM64_NCAPS				57
+#define ARM64_NCAPS				58
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 89b4f0142c28..680b5b36ddd5 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -681,6 +681,12 @@ static __always_inline bool system_uses_irq_prio_masking(void)
 	       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
 }
 
+static inline bool system_supports_mte(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_MTE) &&
+		cpus_have_const_cap(ARM64_MTE);
+}
+
 static inline bool system_has_prio_mask_debugging(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 22f73fe09030..0d4a6741b6a5 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -95,7 +95,7 @@
 #define KERNEL_HWCAP_DGH		__khwcap2_feature(DGH)
 #define KERNEL_HWCAP_RNG		__khwcap2_feature(RNG)
 #define KERNEL_HWCAP_BTI		__khwcap2_feature(BTI)
-/* reserved for KERNEL_HWCAP_MTE	__khwcap2_feature(MTE) */
+#define KERNEL_HWCAP_MTE		__khwcap2_feature(MTE)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 8a1cbfd544d6..6c3b2fc922bb 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -78,7 +78,7 @@
 			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
 			 HCR_FMO | HCR_IMO)
 #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
-#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK)
+#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
 /* TCR_EL2 Registers bits */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6fa9aa477e76..daf030a05de0 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -613,6 +613,7 @@
 			 SCTLR_EL1_SA0  | SCTLR_EL1_SED  | SCTLR_ELx_I    |\
 			 SCTLR_EL1_DZE  | SCTLR_EL1_UCT                   |\
 			 SCTLR_EL1_NTWE | SCTLR_ELx_IESB | SCTLR_EL1_SPAN |\
+			 SCTLR_ELx_ITFSB| SCTLR_ELx_ATA  | SCTLR_EL1_ATA0 |\
 			 ENDIAN_SET_EL1 | SCTLR_EL1_UCI  | SCTLR_EL1_RES1)
 
 /* MAIR_ELx memory attributes (used by Linux) */
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 912162f73529..b8f41aa234ee 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -74,6 +74,6 @@
 #define HWCAP2_DGH		(1 << 15)
 #define HWCAP2_RNG		(1 << 16)
 #define HWCAP2_BTI		(1 << 17)
-/* reserved for HWCAP2_MTE	(1 << 18) */
+#define HWCAP2_MTE		(1 << 18)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a389b999482e..00cdf8c2e8c1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -227,6 +227,8 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MPAMFRAC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_RASFRAC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_MTE),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MTE_SHIFT, 4, ID_AA64PFR1_MTE_NI),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SSBS_SHIFT, 4, ID_AA64PFR1_SSBS_PSTATE_NI),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_BTI),
 				    FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_BT_SHIFT, 4, 0),
@@ -2121,6 +2123,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sign = FTR_UNSIGNED,
 	},
 #endif
+#ifdef CONFIG_ARM64_MTE
+	{
+		.desc = "Memory Tagging Extension",
+		.capability = ARM64_MTE,
+		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64PFR1_EL1,
+		.field_pos = ID_AA64PFR1_MTE_SHIFT,
+		.min_field_value = ID_AA64PFR1_MTE,
+		.sign = FTR_UNSIGNED,
+	},
+#endif /* CONFIG_ARM64_MTE */
 	{},
 };
 
@@ -2237,6 +2251,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_MULTI_CAP(ptr_auth_hwcap_addr_matches, CAP_HWCAP, KERNEL_HWCAP_PACA),
 	HWCAP_MULTI_CAP(ptr_auth_hwcap_gen_matches, CAP_HWCAP, KERNEL_HWCAP_PACG),
 #endif
+#ifdef CONFIG_ARM64_MTE
+	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_MTE_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_MTE, CAP_HWCAP, KERNEL_HWCAP_MTE),
+#endif /* CONFIG_ARM64_MTE */
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 393c6fb1f1cb..5ce478c0b4b1 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -93,7 +93,7 @@ static const char *const hwcap_str[] = {
 	"dgh",
 	"rng",
 	"bti",
-	/* reserved for "mte" */
+	"mte",
 	NULL
 };
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 077293b5115f..59b91f58efec 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1131,6 +1131,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 		if (!vcpu_has_sve(vcpu))
 			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
 		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
+	} else if (id == SYS_ID_AA64PFR1_EL1) {
+		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
 	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
 		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
 			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 4817ed52e343..23c326a06b2d 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -18,6 +18,7 @@
 #include <asm/cpufeature.h>
 #include <asm/alternative.h>
 #include <asm/smp.h>
+#include <asm/sysreg.h>
 
 #ifdef CONFIG_ARM64_64K_PAGES
 #define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
@@ -425,6 +426,29 @@ SYM_FUNC_START(__cpu_setup)
 	 * Memory region attributes
 	 */
 	mov_q	x5, MAIR_EL1_SET
+#ifdef CONFIG_ARM64_MTE
+	/*
+	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
+	 * (ID_AA64PFR1_EL1[11:8] > 1).
+	 */
+	mrs	x10, ID_AA64PFR1_EL1
+	ubfx	x10, x10, #ID_AA64PFR1_MTE_SHIFT, #4
+	cmp	x10, #ID_AA64PFR1_MTE
+	b.lt	1f
+
+	/* Normal Tagged memory type at the corresponding MAIR index */
+	mov	x10, #MAIR_ATTR_NORMAL_TAGGED
+	bfi	x5, x10, #(8 *  MT_NORMAL_TAGGED), #8
+
+	/* initialize GCR_EL1: all non-zero tags excluded by default */
+	mov	x10, #(SYS_GCR_EL1_RRND | SYS_GCR_EL1_EXCL_MASK)
+	msr_s	SYS_GCR_EL1, x10
+
+	/* clear any pending tag check faults in TFSR*_EL1 */
+	msr_s	SYS_TFSR_EL1, xzr
+	msr_s	SYS_TFSRE0_EL1, xzr
+1:
+#endif
 	msr	mair_el1, x5
 	/*
 	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
