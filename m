Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359391D574D
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgEORRK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 13:17:10 -0400
Received: from foss.arm.com ([217.140.110.172]:59604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgEORRI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:17:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAD4B11D4;
        Fri, 15 May 2020 10:17:07 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 03E223F305;
        Fri, 15 May 2020 10:17:05 -0700 (PDT)
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
        Rob Herring <Rob.Herring@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 23/26] arm64: mte: Check the DT memory nodes for MTE support
Date:   Fri, 15 May 2020 18:16:09 +0100
Message-Id: <20200515171612.1020-24-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515171612.1020-1-catalin.marinas@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Even if the ID_AA64PFR1_EL1 register advertises the presence of MTE, it
is not guaranteed that the memory system on the SoC supports the
feature. In the absence of system-wide MTE support, the behaviour is
undefined and the kernel should not enable the MTE memory type in
MAIR_EL1.

For FDT, add an 'arm,armv8.5-memtag' property to the /memory nodes and
check for its presence during MTE probing. For example:

	memory@80000000 {
		device_type = "memory";
		arm,armv8.5-memtag;
		reg = <0x00000000 0x80000000 0 0x80000000>,
		      <0x00000008 0x80000000 0 0x80000000>;
	};

If the /memory nodes are not present in DT or if at least one node does
not support MTE, the feature will be disabled. On EFI systems, it is
assumed that the memory description matches the EFI memory map (if not,
it is considered a firmware bug).

MTE is not currently supported on ACPI systems.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Rob Herring <Rob.Herring@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---

Notes:
    Ongoing (internal) discussions on whether this is the right approach.
    The issue may need to be solved similarly for ACPI systems.
    
    v4:
    - Reworked the CPUID field handling to ensure that it is not exposed to
      user (via MRS emulation) when the feature is not described in the DT.
      Previously, only the HWCAP was hidden.
    
    New in v3.

 arch/arm64/boot/dts/arm/fvp-base-revc.dts |  1 +
 arch/arm64/include/asm/cpufeature.h       |  6 ++-
 arch/arm64/kernel/cpufeature.c            | 59 ++++++++++++++++++++---
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 66381d89c1ce..c620a289f15e 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -94,6 +94,7 @@
 
 	memory@80000000 {
 		device_type = "memory";
+		arm,armv8.5-memtag;
 		reg = <0x00000000 0x80000000 0 0x80000000>,
 		      <0x00000008 0x80000000 0 0x80000000>;
 	};
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index afc315814563..0a24d36bf231 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -61,6 +61,7 @@ struct arm64_ftr_bits {
 	u8		shift;
 	u8		width;
 	s64		safe_val; /* safe value for FTR_EXACT features */
+	s64		(*filter)(const struct arm64_ftr_bits *, s64);
 };
 
 /*
@@ -542,7 +543,10 @@ cpuid_feature_extract_field(u64 features, int field, bool sign)
 
 static inline s64 arm64_ftr_value(const struct arm64_ftr_bits *ftrp, u64 val)
 {
-	return (s64)cpuid_feature_extract_field_width(val, ftrp->shift, ftrp->width, ftrp->sign);
+	s64 fval = (s64)cpuid_feature_extract_field_width(val, ftrp->shift, ftrp->width, ftrp->sign);
+	if (ftrp->filter)
+		fval = ftrp->filter(ftrp, fval);
+	return fval;
 }
 
 static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d2fe8ff72324..aaadc1cbc006 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "CPU features: " fmt
 
+#include <linux/acpi.h>
 #include <linux/bsearch.h>
 #include <linux/cpumask.h>
 #include <linux/crash_dump.h>
@@ -14,6 +15,7 @@
 #include <linux/stop_machine.h>
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/of.h>
 #include <linux/cpu.h>
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
@@ -87,23 +89,28 @@ DEFINE_STATIC_KEY_ARRAY_FALSE(cpu_hwcap_keys, ARM64_NCAPS);
 EXPORT_SYMBOL(cpu_hwcap_keys);
 
 #define __ARM64_FTR_BITS(SIGNED, VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
-	{						\
 		.sign = SIGNED,				\
 		.visible = VISIBLE,			\
 		.strict = STRICT,			\
 		.type = TYPE,				\
 		.shift = SHIFT,				\
 		.width = WIDTH,				\
-		.safe_val = SAFE_VAL,			\
-	}
+		.safe_val = SAFE_VAL
 
 /* Define a feature with unsigned values */
 #define ARM64_FTR_BITS(VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
-	__ARM64_FTR_BITS(FTR_UNSIGNED, VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL)
+	{ __ARM64_FTR_BITS(FTR_UNSIGNED, VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL), }
 
 /* Define a feature with a signed value */
 #define S_ARM64_FTR_BITS(VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
-	__ARM64_FTR_BITS(FTR_SIGNED, VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL)
+	{ __ARM64_FTR_BITS(FTR_SIGNED, VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL), }
+
+/* Define a feature with a filter function to process the field value */
+#define FILTERED_ARM64_FTR_BITS(SIGNED, VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL, filter_fn) \
+	{											\
+		__ARM64_FTR_BITS(SIGNED, VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL),	\
+		.filter = filter_fn,								\
+	}
 
 #define ARM64_FTR_END					\
 	{						\
@@ -118,6 +125,42 @@ static void cpu_enable_cnp(struct arm64_cpu_capabilities const *cap);
 
 static bool __system_matches_cap(unsigned int n);
 
+#ifdef CONFIG_ARM64_MTE
+s64 mte_ftr_filter(const struct arm64_ftr_bits *ftrp, s64 val)
+{
+	struct device_node *np;
+	static bool memory_checked = false;
+	static bool mte_capable = true;
+
+	/* EL0-only MTE is not supported by Linux, don't expose it */
+	if (val < ID_AA64PFR1_MTE)
+		return ID_AA64PFR1_MTE_NI;
+
+	if (memory_checked)
+		return mte_capable ? val : ID_AA64PFR1_MTE_NI;
+
+	if (!acpi_disabled) {
+		pr_warn("MTE not supported on ACPI systems\n");
+		return ID_AA64PFR1_MTE_NI;
+	}
+
+	/* check the DT "memory" nodes for MTE support */
+	for_each_node_by_type(np, "memory") {
+		memory_checked = true;
+		mte_capable &= of_property_read_bool(np, "arm,armv8.5-memtag");
+	}
+
+	if (!memory_checked || !mte_capable) {
+		pr_warn("System memory is not MTE-capable\n");
+		memory_checked = true;
+		mte_capable = false;
+		return ID_AA64PFR1_MTE_NI;
+	}
+
+	return val;
+}
+#endif
+
 /*
  * NOTE: Any changes to the visibility of features should be kept in
  * sync with the documentation of the CPU feature register ABI.
@@ -182,8 +225,10 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SSBS_SHIFT, 4, ID_AA64PFR1_SSBS_PSTATE_NI),
-	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_MTE),
-		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MTE_SHIFT, 4, ID_AA64PFR1_MTE_NI),
+#ifdef CONFIG_ARM64_MTE
+	FILTERED_ARM64_FTR_BITS(FTR_UNSIGNED, FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE,
+				ID_AA64PFR1_MTE_SHIFT, 4, ID_AA64PFR1_MTE_NI, mte_ftr_filter),
+#endif
 	ARM64_FTR_END,
 };
 
