Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F7A38757E
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348042AbhERJtF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348044AbhERJtC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:49:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD116613AE;
        Tue, 18 May 2021 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331264;
        bh=V6IT4Uwp4gdlW8G/j6emkgNX4YIaIlSDqdG7WubTP4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DhCL5j847ycJqdF280cSaRPsUnPhwczG91CdOA2D/0j2VX+2GeK8K6laPwEue4EpX
         J2AN7RuPJceyLgIkivtTuw024KdTwQFOIJYHhj4VIKFC7abwrnjBsubXqwDYKif1RJ
         ttEsVah9Ve09lzXS34l+4BzYmEABsIxYZEAs5R2qnG2jE65pSWSs5StQnX7deg2EXj
         MPbvkLqEXckrqCs6uWM8P31kpm/k41C1yxJbcn7VGneyVf41xR5etdy8/wo2RBCtme
         wd5H0ajsOhntJRY50Sh3GKCs8P3DtnDRsXScoYrn57jbE+fmYb5Z2RVWJXNzXJi2vc
         c4PSdhXAwWufw==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: [PATCH v6 02/21] arm64: Allow mismatched 32-bit EL0 support
Date:   Tue, 18 May 2021 10:47:06 +0100
Message-Id: <20210518094725.7701-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
References: <20210518094725.7701-1-will@kernel.org>
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
 arch/arm64/include/asm/cpucaps.h    |   3 +-
 arch/arm64/include/asm/cpufeature.h |   8 +-
 arch/arm64/kernel/cpufeature.c      | 114 ++++++++++++++++++++++++----
 3 files changed, 110 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index b0c5eda0498f..b87461490977 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -18,7 +18,8 @@
 #define ARM64_HAS_NO_HW_PREFETCH		8
 #define ARM64_HAS_VIRT_HOST_EXTN		11
 #define ARM64_WORKAROUND_CAVIUM_27456		12
-#define ARM64_HAS_32BIT_EL0			13
+/* Unreliable: use system_supports_32bit_el0() instead. */
+#define ARM64_HAS_32BIT_EL0_DO_NOT_USE		13
 #define ARM64_SPECTRE_V3A			14
 #define ARM64_HAS_CNP				15
 #define ARM64_HAS_NO_FPSIMD			16
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 338840c00e8e..603bf4160cd6 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -630,9 +630,15 @@ static inline bool cpu_supports_mixed_endian_el0(void)
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
+	return static_branch_unlikely(&arm64_mismatched_32bit_el0) ||
+	       id_aa64pfr0_32bit_el0(pfr0);
 }
 
 static inline bool system_supports_4kb_granule(void)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a4db25cd7122..4194a47de62d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -107,6 +107,24 @@ DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
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
@@ -767,7 +785,7 @@ static void __init sort_ftr_regs(void)
  * Any bits that are not covered by an arm64_ftr_bits entry are considered
  * RES0 for the system-wide value, and must strictly match.
  */
-static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
+static void init_cpu_ftr_reg(u32 sys_reg, u64 new)
 {
 	u64 val = 0;
 	u64 strict_mask = ~0x0ULL;
@@ -863,7 +881,7 @@ static void __init init_cpu_hwcaps_indirect_list(void)
 
 static void __init setup_boot_cpu_capabilities(void);
 
-static void __init init_32bit_cpu_features(struct cpuinfo_32bit *info)
+static void init_32bit_cpu_features(struct cpuinfo_32bit *info)
 {
 	init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
 	init_cpu_ftr_reg(SYS_ID_DFR1_EL1, info->reg_id_dfr1);
@@ -979,6 +997,22 @@ static void relax_cpu_ftr_reg(u32 sys_id, int field)
 	WARN_ON(!ftrp->width);
 }
 
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
+	boot_cpu_32bit_regs_overridden = true;
+}
+
 static int update_32bit_cpu_features(int cpu, struct cpuinfo_32bit *info,
 				     struct cpuinfo_32bit *boot)
 {
@@ -1139,6 +1173,7 @@ void update_cpu_features(int cpu,
 	 * (e.g. SYS_ID_AA64PFR0_EL1), so we call it last.
 	 */
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
+		update_mismatched_32bit_el0_cpu_features(info, boot);
 		taint |= update_32bit_cpu_features(cpu, &info->aarch32,
 						   &boot->aarch32);
 	}
@@ -1251,6 +1286,28 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 	return feature_matches(val, entry);
 }
 
+const struct cpumask *system_32bit_el0_cpumask(void)
+{
+	if (!system_supports_32bit_el0())
+		return cpu_none_mask;
+
+	if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
+		return cpu_32bit_el0_mask;
+
+	return cpu_possible_mask;
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
@@ -1869,10 +1926,9 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_copy_el2regs,
 	},
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
@@ -2381,7 +2437,7 @@ static const struct arm64_cpu_capabilities compat_elf_hwcaps[] = {
 	{},
 };
 
-static void __init cap_set_elf_hwcap(const struct arm64_cpu_capabilities *cap)
+static void cap_set_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 {
 	switch (cap->hwcap_type) {
 	case CAP_HWCAP:
@@ -2426,7 +2482,7 @@ static bool cpus_have_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 	return rc;
 }
 
-static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
+static void setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 {
 	/* We support emulation of accesses to CPU ID feature registers */
 	cpu_set_named_feature(CPUID);
@@ -2601,7 +2657,7 @@ static void check_early_cpu_features(void)
 }
 
 static void
-verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
+__verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 {
 
 	for (; caps->matches; caps++)
@@ -2612,6 +2668,14 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 		}
 }
 
+static void verify_local_elf_hwcaps(void)
+{
+	__verify_local_elf_hwcaps(arm64_elf_hwcaps);
+
+	if (id_aa64pfr0_32bit_el0(read_cpuid(ID_AA64PFR0_EL1)))
+		__verify_local_elf_hwcaps(compat_elf_hwcaps);
+}
+
 static void verify_sve_features(void)
 {
 	u64 safe_zcr = read_sanitised_ftr_reg(SYS_ZCR_EL1);
@@ -2676,11 +2740,7 @@ static void verify_local_cpu_capabilities(void)
 	 * on all secondary CPUs.
 	 */
 	verify_local_cpu_caps(SCOPE_ALL & ~SCOPE_BOOT_CPU);
-
-	verify_local_elf_hwcaps(arm64_elf_hwcaps);
-
-	if (system_supports_32bit_el0())
-		verify_local_elf_hwcaps(compat_elf_hwcaps);
+	verify_local_elf_hwcaps();
 
 	if (system_supports_sve())
 		verify_sve_features();
@@ -2815,6 +2875,34 @@ void __init setup_cpu_features(void)
 			ARCH_DMA_MINALIGN);
 }
 
+static int enable_mismatched_32bit_el0(unsigned int cpu)
+{
+	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
+	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
+
+	if (cpu_32bit) {
+		cpumask_set_cpu(cpu, cpu_32bit_el0_mask);
+		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
+		setup_elf_hwcaps(compat_elf_hwcaps);
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
+	if (!zalloc_cpumask_var(&cpu_32bit_el0_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	return cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				 "arm64/mismatched_32bit_el0:online",
+				 enable_mismatched_32bit_el0, NULL);
+}
+subsys_initcall_sync(init_32bit_el0_mask);
+
 static void __maybe_unused cpu_enable_cnp(struct arm64_cpu_capabilities const *cap)
 {
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
-- 
2.31.1.751.gd2f1c929bd-goog

