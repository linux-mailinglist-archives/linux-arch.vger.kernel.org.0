Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA28287B80
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgJHSRA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 14:17:00 -0400
Received: from foss.arm.com ([217.140.110.172]:42710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgJHSQ7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Oct 2020 14:16:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6B78D6E;
        Thu,  8 Oct 2020 11:16:58 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5188D3F802;
        Thu,  8 Oct 2020 11:16:57 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>
Subject: [RFC PATCH 2/3] arm64: Add support for asymmetric AArch32 EL0 configurations
Date:   Thu,  8 Oct 2020 19:16:40 +0100
Message-Id: <20201008181641.32767-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008181641.32767-1-qais.yousef@arm.com>
References: <20201008181641.32767-1-qais.yousef@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When the CONFIG_ASYMMETRIC_AARCH32 option is enabled (EXPERT), the type
of the ARM64_HAS_32BIT_EL0 capability becomes WEAK_LOCAL_CPU_FEATURE.
The kernel will now return true for system_supports_32bit_el0() and
checks 32-bit tasks are affined to AArch32 capable CPUs only in
do_notify_resume(). If the affinity contains a non-capable AArch32 CPU,
the tasks will get SIGKILLed. If the last CPU supporting 32-bit is
offlined, the kernel will SIGKILL any scheduled 32-bit tasks (the
alternative is to prevent offlining through a new .cpu_disable feature
entry).

In addition to the relaxation of the ARM64_HAS_32BIT_EL0 capability,
this patch factors out the 32-bit cpuinfo and features setting into
separate functions: __cpuinfo_store_cpu_32bit(),
init_cpu_32bit_features(). The cpuinfo of the booting CPU
(boot_cpu_data) is now updated on the first 32-bit capable CPU even if
it is a secondary one. The ID_AA64PFR0_EL0_64BIT_ONLY feature is relaxed
to FTR_NONSTRICT and FTR_HIGHER_SAFE when the asymmetric AArch32 support
is enabled. The compat_elf_hwcaps are only verified for the
AArch32-capable CPUs to still allow hotplugging AArch64-only CPUs.

Make sure that KVM never sees the asymmetric 32bit system. Guest can
still ignore ID registers and force run 32bit at EL0.

Co-developed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 arch/arm64/Kconfig                   | 14 ++++++
 arch/arm64/include/asm/cpu.h         |  2 +
 arch/arm64/include/asm/cpucaps.h     |  3 +-
 arch/arm64/include/asm/cpufeature.h  | 20 +++++++-
 arch/arm64/include/asm/thread_info.h |  5 +-
 arch/arm64/kernel/cpufeature.c       | 66 +++++++++++++++-----------
 arch/arm64/kernel/cpuinfo.c          | 71 ++++++++++++++++++----------
 arch/arm64/kernel/process.c          | 17 +++++++
 arch/arm64/kernel/signal.c           | 18 +++++++
 arch/arm64/kvm/arm.c                 |  5 +-
 arch/arm64/kvm/guest.c               |  2 +-
 arch/arm64/kvm/sys_regs.c            | 14 +++++-
 12 files changed, 176 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..591853504dc4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1868,6 +1868,20 @@ config DMI
 
 endmenu
 
+config ASYMMETRIC_AARCH32
+	bool "Allow support for asymmetric AArch32 support"
+	depends on COMPAT && EXPERT
+	help
+	  Enable this option to allow support for asymmetric AArch32 EL0
+	  CPU configurations. Once the AArch32 EL0 support is detected
+	  on a CPU, the feature is made available to user space to allow
+	  the execution of 32-bit (compat) applications. If the affinity
+	  of the 32-bit application contains a non-AArch32 capable CPU
+	  or the last AArch32 capable CPU is offlined, the application
+	  will be killed.
+
+	  If unsure say N.
+
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 7faae6ff3ab4..c920fa45e502 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -15,6 +15,7 @@
 struct cpuinfo_arm64 {
 	struct cpu	cpu;
 	struct kobject	kobj;
+	bool		aarch32_valid;
 	u32		reg_ctr;
 	u32		reg_cntfrq;
 	u32		reg_dczid;
@@ -65,6 +66,7 @@ void cpuinfo_store_cpu(void);
 void __init cpuinfo_store_boot_cpu(void);
 
 void __init init_cpu_features(struct cpuinfo_arm64 *info);
+void init_cpu_32bit_features(struct cpuinfo_arm64 *info);
 void update_cpu_features(int cpu, struct cpuinfo_arm64 *info,
 				 struct cpuinfo_arm64 *boot);
 
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 07b643a70710..d3b6a5dce456 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -64,7 +64,8 @@
 #define ARM64_BTI				54
 #define ARM64_HAS_ARMv8_4_TTL			55
 #define ARM64_HAS_TLB_RANGE			56
+#define ARM64_HAS_ASYM_32BIT_EL0		57
 
-#define ARM64_NCAPS				57
+#define ARM64_NCAPS				58
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 89b4f0142c28..fa2413715041 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -17,6 +17,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/bug.h>
+#include <linux/cpumask.h>
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 
@@ -582,9 +583,26 @@ static inline bool cpu_supports_mixed_endian_el0(void)
 	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
 }
 
-static inline bool system_supports_32bit_el0(void)
+static inline bool system_supports_sym_32bit_el0(void)
 {
 	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
+
+}
+
+static inline bool system_supports_asym_32bit_el0(void)
+{
+#ifdef CONFIG_ASYMMETRIC_AARCH32
+	return !cpus_have_const_cap(ARM64_HAS_32BIT_EL0) &&
+	       cpus_have_const_cap(ARM64_HAS_ASYM_32BIT_EL0);
+#else
+	return false;
+#endif
+}
+
+static inline bool system_supports_32bit_el0(void)
+{
+	return system_supports_sym_32bit_el0() ||
+	       system_supports_asym_32bit_el0();
 }
 
 static inline bool system_supports_4kb_granule(void)
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 5e784e16ee89..312974ab2c85 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -67,6 +67,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
+#define TIF_CHECK_32BIT_AFFINITY 6	/* Check thread affinity for asymmetric AArch32 */
 #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
@@ -95,11 +96,13 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_32BIT		(1 << TIF_32BIT)
+#define _TIF_CHECK_32BIT_AFFINITY (1 << TIF_CHECK_32BIT_AFFINITY)
 #define _TIF_SVE		(1 << TIF_SVE)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
-				 _TIF_UPROBE | _TIF_FSCHECK)
+				 _TIF_UPROBE | _TIF_FSCHECK | \
+				 _TIF_CHECK_32BIT_AFFINITY)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6424584be01e..d46732113305 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -63,7 +63,6 @@
 #define pr_fmt(fmt) "CPU features: " fmt
 
 #include <linux/bsearch.h>
-#include <linux/cpumask.h>
 #include <linux/crash_dump.h>
 #include <linux/sort.h>
 #include <linux/stop_machine.h>
@@ -753,7 +752,7 @@ static void __init sort_ftr_regs(void)
  * Any bits that are not covered by an arm64_ftr_bits entry are considered
  * RES0 for the system-wide value, and must strictly match.
  */
-static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
+static void init_cpu_ftr_reg(u32 sys_reg, u64 new)
 {
 	u64 val = 0;
 	u64 strict_mask = ~0x0ULL;
@@ -835,30 +834,6 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
 	init_cpu_ftr_reg(SYS_ID_AA64ZFR0_EL1, info->reg_id_aa64zfr0);
 
-	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
-		init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
-		init_cpu_ftr_reg(SYS_ID_DFR1_EL1, info->reg_id_dfr1);
-		init_cpu_ftr_reg(SYS_ID_ISAR0_EL1, info->reg_id_isar0);
-		init_cpu_ftr_reg(SYS_ID_ISAR1_EL1, info->reg_id_isar1);
-		init_cpu_ftr_reg(SYS_ID_ISAR2_EL1, info->reg_id_isar2);
-		init_cpu_ftr_reg(SYS_ID_ISAR3_EL1, info->reg_id_isar3);
-		init_cpu_ftr_reg(SYS_ID_ISAR4_EL1, info->reg_id_isar4);
-		init_cpu_ftr_reg(SYS_ID_ISAR5_EL1, info->reg_id_isar5);
-		init_cpu_ftr_reg(SYS_ID_ISAR6_EL1, info->reg_id_isar6);
-		init_cpu_ftr_reg(SYS_ID_MMFR0_EL1, info->reg_id_mmfr0);
-		init_cpu_ftr_reg(SYS_ID_MMFR1_EL1, info->reg_id_mmfr1);
-		init_cpu_ftr_reg(SYS_ID_MMFR2_EL1, info->reg_id_mmfr2);
-		init_cpu_ftr_reg(SYS_ID_MMFR3_EL1, info->reg_id_mmfr3);
-		init_cpu_ftr_reg(SYS_ID_MMFR4_EL1, info->reg_id_mmfr4);
-		init_cpu_ftr_reg(SYS_ID_MMFR5_EL1, info->reg_id_mmfr5);
-		init_cpu_ftr_reg(SYS_ID_PFR0_EL1, info->reg_id_pfr0);
-		init_cpu_ftr_reg(SYS_ID_PFR1_EL1, info->reg_id_pfr1);
-		init_cpu_ftr_reg(SYS_ID_PFR2_EL1, info->reg_id_pfr2);
-		init_cpu_ftr_reg(SYS_MVFR0_EL1, info->reg_mvfr0);
-		init_cpu_ftr_reg(SYS_MVFR1_EL1, info->reg_mvfr1);
-		init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
-	}
-
 	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
 		init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
 		sve_init_vq_map();
@@ -877,6 +852,31 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	setup_boot_cpu_capabilities();
 }
 
+void init_cpu_32bit_features(struct cpuinfo_arm64 *info)
+{
+	init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
+	init_cpu_ftr_reg(SYS_ID_DFR1_EL1, info->reg_id_dfr1);
+	init_cpu_ftr_reg(SYS_ID_ISAR0_EL1, info->reg_id_isar0);
+	init_cpu_ftr_reg(SYS_ID_ISAR1_EL1, info->reg_id_isar1);
+	init_cpu_ftr_reg(SYS_ID_ISAR2_EL1, info->reg_id_isar2);
+	init_cpu_ftr_reg(SYS_ID_ISAR3_EL1, info->reg_id_isar3);
+	init_cpu_ftr_reg(SYS_ID_ISAR4_EL1, info->reg_id_isar4);
+	init_cpu_ftr_reg(SYS_ID_ISAR5_EL1, info->reg_id_isar5);
+	init_cpu_ftr_reg(SYS_ID_ISAR6_EL1, info->reg_id_isar6);
+	init_cpu_ftr_reg(SYS_ID_MMFR0_EL1, info->reg_id_mmfr0);
+	init_cpu_ftr_reg(SYS_ID_MMFR1_EL1, info->reg_id_mmfr1);
+	init_cpu_ftr_reg(SYS_ID_MMFR2_EL1, info->reg_id_mmfr2);
+	init_cpu_ftr_reg(SYS_ID_MMFR3_EL1, info->reg_id_mmfr3);
+	init_cpu_ftr_reg(SYS_ID_MMFR4_EL1, info->reg_id_mmfr4);
+	init_cpu_ftr_reg(SYS_ID_MMFR5_EL1, info->reg_id_mmfr5);
+	init_cpu_ftr_reg(SYS_ID_PFR0_EL1, info->reg_id_pfr0);
+	init_cpu_ftr_reg(SYS_ID_PFR1_EL1, info->reg_id_pfr1);
+	init_cpu_ftr_reg(SYS_ID_PFR2_EL1, info->reg_id_pfr2);
+	init_cpu_ftr_reg(SYS_MVFR0_EL1, info->reg_mvfr0);
+	init_cpu_ftr_reg(SYS_MVFR1_EL1, info->reg_mvfr1);
+	init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
+}
+
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
 {
 	const struct arm64_ftr_bits *ftrp;
@@ -1804,6 +1804,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64PFR0_EL0_SHIFT,
 		.min_field_value = ID_AA64PFR0_EL0_32BIT_64BIT,
 	},
+#ifdef CONFIG_ASYMMETRIC_AARCH32
+	{
+		.capability = ARM64_HAS_ASYM_32BIT_EL0,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64PFR0_EL0_SHIFT,
+		.min_field_value = ID_AA64PFR0_EL0_32BIT_64BIT,
+	},
+#endif
 #ifdef CONFIG_KVM
 	{
 		.desc = "32-bit EL1 Support",
@@ -2576,7 +2587,8 @@ static void verify_local_cpu_capabilities(void)
 
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 
-	if (system_supports_32bit_el0())
+	if (system_supports_32bit_el0() &&
+	    this_cpu_has_cap(ARM64_HAS_32BIT_EL0))
 		verify_local_elf_hwcaps(compat_elf_hwcaps);
 
 	if (system_supports_sve())
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index d0076c2159e6..b7f69cbbc088 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -362,32 +362,6 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_aa64pfr1 = read_cpuid(ID_AA64PFR1_EL1);
 	info->reg_id_aa64zfr0 = read_cpuid(ID_AA64ZFR0_EL1);
 
-	/* Update the 32bit ID registers only if AArch32 is implemented */
-	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
-		info->reg_id_dfr0 = read_cpuid(ID_DFR0_EL1);
-		info->reg_id_dfr1 = read_cpuid(ID_DFR1_EL1);
-		info->reg_id_isar0 = read_cpuid(ID_ISAR0_EL1);
-		info->reg_id_isar1 = read_cpuid(ID_ISAR1_EL1);
-		info->reg_id_isar2 = read_cpuid(ID_ISAR2_EL1);
-		info->reg_id_isar3 = read_cpuid(ID_ISAR3_EL1);
-		info->reg_id_isar4 = read_cpuid(ID_ISAR4_EL1);
-		info->reg_id_isar5 = read_cpuid(ID_ISAR5_EL1);
-		info->reg_id_isar6 = read_cpuid(ID_ISAR6_EL1);
-		info->reg_id_mmfr0 = read_cpuid(ID_MMFR0_EL1);
-		info->reg_id_mmfr1 = read_cpuid(ID_MMFR1_EL1);
-		info->reg_id_mmfr2 = read_cpuid(ID_MMFR2_EL1);
-		info->reg_id_mmfr3 = read_cpuid(ID_MMFR3_EL1);
-		info->reg_id_mmfr4 = read_cpuid(ID_MMFR4_EL1);
-		info->reg_id_mmfr5 = read_cpuid(ID_MMFR5_EL1);
-		info->reg_id_pfr0 = read_cpuid(ID_PFR0_EL1);
-		info->reg_id_pfr1 = read_cpuid(ID_PFR1_EL1);
-		info->reg_id_pfr2 = read_cpuid(ID_PFR2_EL1);
-
-		info->reg_mvfr0 = read_cpuid(MVFR0_EL1);
-		info->reg_mvfr1 = read_cpuid(MVFR1_EL1);
-		info->reg_mvfr2 = read_cpuid(MVFR2_EL1);
-	}
-
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    id_aa64pfr0_sve(info->reg_id_aa64pfr0))
 		info->reg_zcr = read_zcr_features();
@@ -395,10 +369,51 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	cpuinfo_detect_icache_policy(info);
 }
 
+static void __cpuinfo_store_cpu_32bit(struct cpuinfo_arm64 *info)
+{
+	info->aarch32_valid = true;
+
+	info->reg_id_dfr0 = read_cpuid(ID_DFR0_EL1);
+	info->reg_id_dfr1 = read_cpuid(ID_DFR1_EL1);
+	info->reg_id_isar0 = read_cpuid(ID_ISAR0_EL1);
+	info->reg_id_isar1 = read_cpuid(ID_ISAR1_EL1);
+	info->reg_id_isar2 = read_cpuid(ID_ISAR2_EL1);
+	info->reg_id_isar3 = read_cpuid(ID_ISAR3_EL1);
+	info->reg_id_isar4 = read_cpuid(ID_ISAR4_EL1);
+	info->reg_id_isar5 = read_cpuid(ID_ISAR5_EL1);
+	info->reg_id_isar6 = read_cpuid(ID_ISAR6_EL1);
+	info->reg_id_mmfr0 = read_cpuid(ID_MMFR0_EL1);
+	info->reg_id_mmfr1 = read_cpuid(ID_MMFR1_EL1);
+	info->reg_id_mmfr2 = read_cpuid(ID_MMFR2_EL1);
+	info->reg_id_mmfr3 = read_cpuid(ID_MMFR3_EL1);
+	info->reg_id_mmfr4 = read_cpuid(ID_MMFR4_EL1);
+	info->reg_id_mmfr5 = read_cpuid(ID_MMFR5_EL1);
+	info->reg_id_pfr0 = read_cpuid(ID_PFR0_EL1);
+	info->reg_id_pfr1 = read_cpuid(ID_PFR1_EL1);
+	info->reg_id_pfr2 = read_cpuid(ID_PFR2_EL1);
+
+	info->reg_mvfr0 = read_cpuid(MVFR0_EL1);
+	info->reg_mvfr1 = read_cpuid(MVFR1_EL1);
+	info->reg_mvfr2 = read_cpuid(MVFR2_EL1);
+}
+
 void cpuinfo_store_cpu(void)
 {
 	struct cpuinfo_arm64 *info = this_cpu_ptr(&cpu_data);
 	__cpuinfo_store_cpu(info);
+	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
+		__cpuinfo_store_cpu_32bit(info);
+	/*
+	 * With asymmetric AArch32 support, populate the boot CPU information
+	 * on the first 32-bit capable secondary CPU if the primary one
+	 * skipped this step.
+	 */
+	if (IS_ENABLED(CONFIG_ASYMMETRIC_AARCH32) &&
+	    !boot_cpu_data.aarch32_valid &&
+	    id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
+		__cpuinfo_store_cpu_32bit(&boot_cpu_data);
+		init_cpu_32bit_features(&boot_cpu_data);
+	}
 	update_cpu_features(smp_processor_id(), info, &boot_cpu_data);
 }
 
@@ -406,7 +421,11 @@ void __init cpuinfo_store_boot_cpu(void)
 {
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, 0);
 	__cpuinfo_store_cpu(info);
+	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
+		__cpuinfo_store_cpu_32bit(info);
 
 	boot_cpu_data = *info;
 	init_cpu_features(&boot_cpu_data);
+	if (id_aa64pfr0_32bit_el0(boot_cpu_data.reg_id_aa64pfr0))
+		init_cpu_32bit_features(&boot_cpu_data);
 }
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f1804496b935..a2f9ffb2b173 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -513,6 +513,15 @@ static void entry_task_switch(struct task_struct *next)
 	__this_cpu_write(__entry_task, next);
 }
 
+static void aarch32_thread_switch(struct task_struct *next)
+{
+	struct thread_info *ti = task_thread_info(next);
+
+	if (IS_ENABLED(CONFIG_ASYMMETRIC_AARCH32) && is_compat_thread(ti) &&
+	    !this_cpu_has_cap(ARM64_HAS_32BIT_EL0))
+		set_ti_thread_flag(ti, TIF_CHECK_32BIT_AFFINITY);
+}
+
 /*
  * ARM erratum 1418040 handling, affecting the 32bit view of CNTVCT.
  * Assuming the virtual counter is enabled at the beginning of times:
@@ -562,6 +571,7 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	uao_thread_switch(next);
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(prev, next);
+	aarch32_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
@@ -620,6 +630,13 @@ void arch_setup_new_exec(void)
 	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
 
 	ptrauth_thread_init_user(current);
+
+	/*
+	 * If exec'ing a 32-bit task, force the asymmetric 32-bit feature
+	 * check as the task may not go through a switch_to() call.
+	 */
+	if (IS_ENABLED(CONFIG_ASYMMETRIC_AARCH32) && is_compat_task())
+		set_thread_flag(TIF_CHECK_32BIT_AFFINITY);
 }
 
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 3b4f31f35e45..cf94cc248fbe 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -8,6 +8,7 @@
 
 #include <linux/cache.h>
 #include <linux/compat.h>
+#include <linux/cpumask.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
@@ -907,6 +908,17 @@ static void do_signal(struct pt_regs *regs)
 	restore_saved_sigmask();
 }
 
+static void check_aarch32_cpumask(void)
+{
+	/*
+	 * If the task moved to uncapable CPU, SIGKILL it.
+	 */
+	if (!this_cpu_has_cap(ARM64_HAS_32BIT_EL0)) {
+		pr_warn_once("CPU affinity contains CPUs that are not capable of running 32-bit tasks\n");
+		force_sig(SIGKILL);
+	}
+}
+
 asmlinkage void do_notify_resume(struct pt_regs *regs,
 				 unsigned long thread_flags)
 {
@@ -929,6 +941,12 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		} else {
 			local_daif_restore(DAIF_PROCCTX);
 
+			if (IS_ENABLED(CONFIG_ASYMMETRIC_AARCH32) &&
+			    thread_flags & _TIF_CHECK_32BIT_AFFINITY) {
+				clear_thread_flag(TIF_CHECK_32BIT_AFFINITY);
+				check_aarch32_cpumask();
+			}
+
 			if (thread_flags & _TIF_UPROBE)
 				uprobe_notify_resume(regs);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 22ff3373d855..17c6674a7fcd 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -644,7 +644,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 	int ret;
 
-	if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
+	if (!system_supports_sym_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
 		kvm_err("Illegal AArch32 mode at EL0, can't run.");
 		return -ENOEXEC;
 	}
@@ -815,7 +815,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 * enter 32bit mode, catch that and prevent it from running
 		 * again.
 		 */
-		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
+		if (!system_supports_sym_32bit_el0() &&
+		    vcpu_mode_is_32bit(vcpu)) {
 			kvm_err("Detected illegal AArch32 mode at EL0, exiting.");
 			ret = ARM_EXCEPTION_IL;
 		}
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index dfb5218137ca..0f67b53eaf17 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -226,7 +226,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		u64 mode = (*(u64 *)valp) & PSR_AA32_MODE_MASK;
 		switch (mode) {
 		case PSR_AA32_MODE_USR:
-			if (!system_supports_32bit_el0())
+			if (!system_supports_sym_32bit_el0())
 				return -EINVAL;
 			break;
 		case PSR_AA32_MODE_FIQ:
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 077293b5115f..0b9aaee1df59 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -670,7 +670,7 @@ static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	 */
 	val = ((pmcr & ~ARMV8_PMU_PMCR_MASK)
 	       | (ARMV8_PMU_PMCR_MASK & 0xdecafbad)) & (~ARMV8_PMU_PMCR_E);
-	if (!system_supports_32bit_el0())
+	if (!system_supports_sym_32bit_el0())
 		val |= ARMV8_PMU_PMCR_LC;
 	__vcpu_sys_reg(vcpu, r->reg) = val;
 }
@@ -722,7 +722,7 @@ static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 		val = __vcpu_sys_reg(vcpu, PMCR_EL0);
 		val &= ~ARMV8_PMU_PMCR_MASK;
 		val |= p->regval & ARMV8_PMU_PMCR_MASK;
-		if (!system_supports_32bit_el0())
+		if (!system_supports_sym_32bit_el0())
 			val |= ARMV8_PMU_PMCR_LC;
 		__vcpu_sys_reg(vcpu, PMCR_EL0) = val;
 		kvm_pmu_handle_pmcr(vcpu, val);
@@ -1131,6 +1131,16 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 		if (!vcpu_has_sve(vcpu))
 			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
 		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
+
+		if (!system_supports_sym_32bit_el0()) {
+			/*
+			 * We could be running on asym aarch32 system.
+			 * Override to present a aarch64 only system.
+			 */
+			val &= ~(0xfUL << ID_AA64PFR0_EL0_SHIFT);
+			val |= (ID_AA64PFR0_EL0_64BIT_ONLY << ID_AA64PFR0_EL0_SHIFT);
+		}
+
 	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
 		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
 			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
-- 
2.17.1

