Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028481B7B4B
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgDXQRs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 12:17:48 -0400
Received: from foss.arm.com ([217.140.110.172]:39006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgDXQRs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 12:17:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C983731B;
        Fri, 24 Apr 2020 09:17:46 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A1733F68F;
        Fri, 24 Apr 2020 09:17:44 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:17:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Rob Herring <Rob.Herring@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [PATCH v3 21/23] arm64: mte: Check the DT memory nodes for MTE
 support
Message-ID: <20200424161742.GE5551@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-22-catalin.marinas@arm.com>
 <20200424135735.GB5551@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424135735.GB5551@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 24, 2020 at 02:57:36PM +0100, Catalin Marinas wrote:
> On Tue, Apr 21, 2020 at 03:26:01PM +0100, Catalin Marinas wrote:
> > Even if the ID_AA64PFR1_EL1 register advertises the presence of MTE, it
> > is not guaranteed that the memory system on the SoC supports the
> > feature. In the absence of system-wide MTE support, the behaviour is
> > undefined and the kernel should not enable the MTE memory type in
> > MAIR_EL1.
> > 
> > For FDT, add an 'arm,armv8.5-memtag' property to the /memory nodes and
> > check for its presence during MTE probing. For example:
> > 
> > 	memory@80000000 {
> > 		device_type = "memory";
> > 		arm,armv8.5-memtag;
> > 		reg = <0x00000000 0x80000000 0 0x80000000>,
> > 		      <0x00000008 0x80000000 0 0x80000000>;
> > 	};
> > 
> > If the /memory nodes are not present in DT or if at least one node does
> > not support MTE, the feature will be disabled. On EFI systems, it is
> > assumed that the memory description matches the EFI memory map (if not,
> > it is considered a firmware bug).
> > 
> > MTE is not currently supported on ACPI systems.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Rob Herring <Rob.Herring@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> 
> This patch turns out to be incomplete. While it does not expose the
> HWCAP2_MTE to user when the above DT property is not present, it still
> allows user access to the ID_AA64PFR1_EL1.MTE field (via MRS emulations)
> since it is marked as visible.

Attempt below at moving the check to the CPUID fields setup. This way we
can avoid the original patch entirely since the sanitised id regs will
have a zero MTE field if DT doesn't support it.

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
index a32aad1d5b57..b0f37c77ec77 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -89,23 +89,28 @@ DEFINE_STATIC_KEY_ARRAY_FALSE(cpu_hwcap_keys, ARM64_NCAPS);
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
@@ -120,6 +125,42 @@ static void cpu_enable_cnp(struct arm64_cpu_capabilities const *cap);
 
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
@@ -184,8 +225,10 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 
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
 

-- 
Catalin
