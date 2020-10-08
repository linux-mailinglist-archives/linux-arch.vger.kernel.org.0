Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B41287B82
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 20:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgJHSRC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 14:17:02 -0400
Received: from foss.arm.com ([217.140.110.172]:42724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgJHSRC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Oct 2020 14:17:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FEFC1529;
        Thu,  8 Oct 2020 11:17:01 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 110683F802;
        Thu,  8 Oct 2020 11:16:59 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>
Subject: [RFC PATCH 3/3] arm64: Handle AArch32 tasks running on non AArch32 cpu
Date:   Thu,  8 Oct 2020 19:16:41 +0100
Message-Id: <20201008181641.32767-4-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008181641.32767-1-qais.yousef@arm.com>
References: <20201008181641.32767-1-qais.yousef@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Asym AArch32 system, if a task has invalid cpus in its affinity, we
try to fix the cpumask silently and let it continue to run. If the
cpumask doesn't contain any valid cpu, we have no choice but to send
SIGKILL.

This patch can be omitted if user-space can guarantee the cpumask of
all AArch32 apps only contains AArch32 capable CPUs.

The biggest challenge in user space managing the affinity is handling
apps who try to modify their own CPU affinity via sched_setaffinity().
Without this change they could trigger a SIGKILL if they unknowingly
affine to the wrong set of CPUs. Only by enforcing all 32bit apps to
a cpuset user space can guarantee apps can't escape this affinity.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 arch/arm64/Kconfig                  |  8 ++++----
 arch/arm64/include/asm/cpufeature.h |  2 ++
 arch/arm64/kernel/cpufeature.c      | 11 +++++++++++
 arch/arm64/kernel/signal.c          | 25 ++++++++++++++++++++-----
 4 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 591853504dc4..ad6d52dd8ac0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1875,10 +1875,10 @@ config ASYMMETRIC_AARCH32
 	  Enable this option to allow support for asymmetric AArch32 EL0
 	  CPU configurations. Once the AArch32 EL0 support is detected
 	  on a CPU, the feature is made available to user space to allow
-	  the execution of 32-bit (compat) applications. If the affinity
-	  of the 32-bit application contains a non-AArch32 capable CPU
-	  or the last AArch32 capable CPU is offlined, the application
-	  will be killed.
+	  the execution of 32-bit (compat) applications by migrating
+	  them to the capable CPUs. Offlining such CPUs leads to 32-bit
+	  applications being killed. Similarly if the affinity contains
+	  no 32-bit capable CPU.
 
 	  If unsure say N.
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index fa2413715041..57275e47cd3d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -376,6 +376,8 @@ cpucap_multi_entry_cap_matches(const struct arm64_cpu_capabilities *entry,
 	return false;
 }
 
+extern cpumask_t aarch32_el0_mask;
+
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d46732113305..4c0858c13e6d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1721,6 +1721,16 @@ cpucap_panic_on_conflict(const struct arm64_cpu_capabilities *cap)
 	return !!(cap->type & ARM64_CPUCAP_PANIC_ON_CONFLICT);
 }
 
+#ifdef CONFIG_ASYMMETRIC_AARCH32
+cpumask_t aarch32_el0_mask;
+
+static void cpu_enable_aarch32_el0(struct arm64_cpu_capabilities const *cap)
+{
+	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU))
+		cpumask_set_cpu(smp_processor_id(), &aarch32_el0_mask);
+}
+#endif
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -1799,6 +1809,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_32BIT_EL0,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
+		.cpu_enable = cpu_enable_aarch32_el0,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_EL0_SHIFT,
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index cf94cc248fbe..7e97f1589f33 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -908,13 +908,28 @@ static void do_signal(struct pt_regs *regs)
 	restore_saved_sigmask();
 }
 
-static void check_aarch32_cpumask(void)
+static void set_32bit_cpus_allowed(void)
 {
+	cpumask_var_t cpus_allowed;
+	int ret = 0;
+
+	if (cpumask_subset(current->cpus_ptr, &aarch32_el0_mask))
+		return;
+
 	/*
-	 * If the task moved to uncapable CPU, SIGKILL it.
+	 * On asym aarch32 systems, if the task has invalid cpus in its mask,
+	 * we try to fix it by removing the invalid ones.
 	 */
-	if (!this_cpu_has_cap(ARM64_HAS_32BIT_EL0)) {
-		pr_warn_once("CPU affinity contains CPUs that are not capable of running 32-bit tasks\n");
+	if (!alloc_cpumask_var(&cpus_allowed, GFP_ATOMIC)) {
+		ret = -ENOMEM;
+	} else {
+		cpumask_and(cpus_allowed, current->cpus_ptr, &aarch32_el0_mask);
+		ret = set_cpus_allowed_ptr(current, cpus_allowed);
+		free_cpumask_var(cpus_allowed);
+	}
+
+	if (ret) {
+		pr_warn_once("Failed to fixup affinity of running 32-bit task\n");
 		force_sig(SIGKILL);
 	}
 }
@@ -944,7 +959,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 			if (IS_ENABLED(CONFIG_ASYMMETRIC_AARCH32) &&
 			    thread_flags & _TIF_CHECK_32BIT_AFFINITY) {
 				clear_thread_flag(TIF_CHECK_32BIT_AFFINITY);
-				check_aarch32_cpumask();
+				set_32bit_cpus_allowed();
 			}
 
 			if (thread_flags & _TIF_UPROBE)
-- 
2.17.1

