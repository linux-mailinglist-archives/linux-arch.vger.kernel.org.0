Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90A72AC746
	for <lists+linux-arch@lfdr.de>; Mon,  9 Nov 2020 22:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgKIVal (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Nov 2020 16:30:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgKIVal (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Nov 2020 16:30:41 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86F2820867;
        Mon,  9 Nov 2020 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604957439;
        bh=WJv0JQ9C3g/91756bM21vM7lc5zLmTn5Tm4O359rpYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0NmpYWDJiObd96/FoYAkAr6ayn1y3hJWrV22ThfDD0/3VsumnY5V5KQD7YmudmNMm
         CrnddNMiZ1h8rs7GkWtziAp1J2k2XstJhPS00XxXPEz2xRro7EhhinLt2k0aBYeRjc
         rdXlSL3v8TPItHmTeX5lJSUswW5hY6EmZXBH+2/c=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com
Subject: [PATCH v2 2/6] arm64: Allow mismatched 32-bit EL0 support
Date:   Mon,  9 Nov 2020 21:30:18 +0000
Message-Id: <20201109213023.15092-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109213023.15092-1-will@kernel.org>
References: <20201109213023.15092-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When confronted with a mixture of CPUs, some of which support 32-bit
applications and others which don't, we quite sensibly treat the system
as 64-bit only for userspace and prevent execve() of 32-bit binaries.

Unfortunately, some crazy folks have decided to build systems like this
with the intention of running 32-bit applications, so relax our
sanitisation logic to continue to advertise 32-bit support to userspace
on these systems and track the real 32-bit capable cores in a cpumask
instead. For now, the default behaviour remains but will be tied to
a command-line option in a later patch.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/cpucaps.h    |   2 +-
 arch/arm64/include/asm/cpufeature.h |   8 ++-
 arch/arm64/kernel/cpufeature.c      | 103 ++++++++++++++++++++++++++--
 3 files changed, 104 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index e7d98997c09c..e6f0eb4643a0 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -20,7 +20,7 @@
 #define ARM64_ALT_PAN_NOT_UAO			10
 #define ARM64_HAS_VIRT_HOST_EXTN		11
 #define ARM64_WORKAROUND_CAVIUM_27456		12
-#define ARM64_HAS_32BIT_EL0			13
+#define ARM64_HAS_32BIT_EL0_DO_NOT_USE		13
 #define ARM64_HARDEN_EL2_VECTORS		14
 #define ARM64_HAS_CNP				15
 #define ARM64_HAS_NO_FPSIMD			16
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 97244d4feca9..f447d313a9c5 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -604,9 +604,15 @@ static inline bool cpu_supports_mixed_endian_el0(void)
 	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
 }
 
+const struct cpumask *system_32bit_el0_cpumask(void);
+DECLARE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
+
 static inline bool system_supports_32bit_el0(void)
 {
-	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
+	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+
+	return id_aa64pfr0_32bit_el0(pfr0) ||
+	       static_branch_unlikely(&arm64_mismatched_32bit_el0);
 }
 
 static inline bool system_supports_4kb_granule(void)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d4a7e84b1513..264998972627 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -104,6 +104,24 @@ DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
 bool arm64_use_ng_mappings = false;
 EXPORT_SYMBOL(arm64_use_ng_mappings);
 
+/*
+ * Permit PER_LINUX32 and execve() of 32-bit binaries even if not all CPUs
+ * support it?
+ */
+static bool __read_mostly allow_mismatched_32bit_el0;
+
+/*
+ * Static branch enabled only if allow_mismatched_32bit_el0 is set and we have
+ * seen at least one CPU capable of 32-bit EL0.
+ */
+DEFINE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
+
+/*
+ * Mask of CPUs supporting 32-bit EL0.
+ * Only valid if arm64_mismatched_32bit_el0 is enabled.
+ */
+static cpumask_var_t cpu_32bit_el0_mask __cpumask_var_read_mostly;
+
 /*
  * Flag to indicate if we have computed the system wide
  * capabilities based on the boot time active CPUs. This
@@ -756,7 +774,7 @@ static void __init sort_ftr_regs(void)
  * Any bits that are not covered by an arm64_ftr_bits entry are considered
  * RES0 for the system-wide value, and must strictly match.
  */
-static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
+static void init_cpu_ftr_reg(u32 sys_reg, u64 new)
 {
 	u64 val = 0;
 	u64 strict_mask = ~0x0ULL;
@@ -819,7 +837,7 @@ static void __init init_cpu_hwcaps_indirect_list(void)
 
 static void __init setup_boot_cpu_capabilities(void);
 
-static void __init init_32bit_cpu_features(struct cpuinfo_32bit *info)
+static void init_32bit_cpu_features(struct cpuinfo_32bit *info)
 {
 	init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
 	init_cpu_ftr_reg(SYS_ID_DFR1_EL1, info->reg_id_dfr1);
@@ -935,6 +953,25 @@ static void relax_cpu_ftr_reg(u32 sys_id, int field)
 	WARN_ON(!ftrp->width);
 }
 
+static void update_compat_elf_hwcaps(void);
+
+static void update_mismatched_32bit_el0_cpu_features(struct cpuinfo_arm64 *info,
+						     struct cpuinfo_arm64 *boot)
+{
+	static bool boot_cpu_32bit_regs_overridden = false;
+
+	if (!allow_mismatched_32bit_el0 || boot_cpu_32bit_regs_overridden)
+		return;
+
+	if (id_aa64pfr0_32bit_el0(boot->reg_id_aa64pfr0))
+		return;
+
+	boot->aarch32 = info->aarch32;
+	init_32bit_cpu_features(&boot->aarch32);
+	update_compat_elf_hwcaps();
+	boot_cpu_32bit_regs_overridden = true;
+}
+
 static int update_32bit_cpu_features(int cpu, struct cpuinfo_32bit *info,
 				     struct cpuinfo_32bit *boot)
 {
@@ -1095,6 +1132,7 @@ void update_cpu_features(int cpu,
 	 * (e.g. SYS_ID_AA64PFR0_EL1), so we call it last.
 	 */
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
+		update_mismatched_32bit_el0_cpu_features(info, boot);
 		taint |= update_32bit_cpu_features(cpu, &info->aarch32,
 						   &boot->aarch32);
 	}
@@ -1196,6 +1234,52 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 	return feature_matches(val, entry);
 }
 
+static int enable_mismatched_32bit_el0(unsigned int cpu)
+{
+	if (id_aa64pfr0_32bit_el0(per_cpu(cpu_data, cpu).reg_id_aa64pfr0)) {
+		cpumask_set_cpu(cpu, cpu_32bit_el0_mask);
+		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
+	}
+
+	return 0;
+}
+
+static int __init init_32bit_el0_mask(void)
+{
+	if (!allow_mismatched_32bit_el0)
+		return 0;
+
+	if (!alloc_cpumask_var(&cpu_32bit_el0_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	return cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				 "arm64/mismatched_32bit_el0:online",
+				 enable_mismatched_32bit_el0, NULL);
+}
+early_initcall(init_32bit_el0_mask);
+
+const struct cpumask *system_32bit_el0_cpumask(void)
+{
+	if (!system_supports_32bit_el0())
+		return cpu_none_mask;
+
+	if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
+		return cpu_32bit_el0_mask;
+
+	return cpu_present_mask;
+}
+
+static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	if (!has_cpuid_feature(entry, scope))
+		return allow_mismatched_32bit_el0;
+
+	if (scope == SCOPE_SYSTEM)
+		pr_info("detected: 32-bit EL0 Support\n");
+
+	return true;
+}
+
 static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	bool has_sre;
@@ -1803,10 +1887,9 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	},
 #endif	/* CONFIG_ARM64_VHE */
 	{
-		.desc = "32-bit EL0 Support",
-		.capability = ARM64_HAS_32BIT_EL0,
+		.capability = ARM64_HAS_32BIT_EL0_DO_NOT_USE,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.matches = has_cpuid_feature,
+		.matches = has_32bit_el0,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_EL0_SHIFT,
@@ -2299,7 +2382,7 @@ static const struct arm64_cpu_capabilities compat_elf_hwcaps[] = {
 	{},
 };
 
-static void __init cap_set_elf_hwcap(const struct arm64_cpu_capabilities *cap)
+static void cap_set_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 {
 	switch (cap->hwcap_type) {
 	case CAP_HWCAP:
@@ -2344,7 +2427,7 @@ static bool cpus_have_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 	return rc;
 }
 
-static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
+static void setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 {
 	/* We support emulation of accesses to CPU ID feature registers */
 	cpu_set_named_feature(CPUID);
@@ -2353,6 +2436,12 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 			cap_set_elf_hwcap(hwcaps);
 }
 
+static void update_compat_elf_hwcaps(void)
+{
+	if (system_capabilities_finalized())
+		setup_elf_hwcaps(compat_elf_hwcaps);
+}
+
 static void update_cpu_capabilities(u16 scope_mask)
 {
 	int i;
-- 
2.29.2.222.g5d2a92d10f8-goog

