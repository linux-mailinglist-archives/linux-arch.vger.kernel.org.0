Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C725C29CB83
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 22:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374483AbgJ0Vva (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 17:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505991AbgJ0Vva (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 17:51:30 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C6512223C;
        Tue, 27 Oct 2020 21:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603835489;
        bh=GAUTwFhizKAw0Z9lmj6Hxux2DjN4LfuQzDBctcI63WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0mMOxqkq/GUDbYIwo0xjmXYRUaxpVGR9HvrBC+6y58kagcN3uPDfrh0WpegeVNStj
         AMPFd4AwowY2CUbeu33+hYtnS0Utv1gdyjaYS1xRmNgFeKJpWCETAm2HIjOgozQ48F
         /lOaSIpsTdUK/kAMY0WJzHH6dOct60Qc31iCFoyY=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: [PATCH 2/6] arm64: Allow mismatched 32-bit EL0 support
Date:   Tue, 27 Oct 2020 21:51:14 +0000
Message-Id: <20201027215118.27003-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027215118.27003-1-will@kernel.org>
References: <20201027215118.27003-1-will@kernel.org>
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
 arch/arm64/include/asm/cpufeature.h |  3 ++
 arch/arm64/kernel/cpufeature.c      | 54 +++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f7e7144af174..aeab42cb917e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -582,6 +582,9 @@ static inline bool cpu_supports_mixed_endian_el0(void)
 	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
 }
 
+const struct cpumask *system_32bit_el0_cpumask(void);
+bool system_has_mismatched_32bit_el0(void);
+
 static inline bool system_supports_32bit_el0(void)
 {
 	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index dcc165b3fc04..2e2219cbd54c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -104,6 +104,10 @@ DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
 bool arm64_use_ng_mappings = false;
 EXPORT_SYMBOL(arm64_use_ng_mappings);
 
+static bool __read_mostly __allow_mismatched_32bit_el0;
+/* Mask of CPUs supporting 32-bit EL0. Only valid if we allow a mismatch */
+static cpumask_var_t cpu_32bit_el0_mask __cpumask_var_read_mostly;
+
 /*
  * Flag to indicate if we have computed the system wide
  * capabilities based on the boot time active CPUs. This
@@ -942,8 +946,11 @@ static int update_32bit_cpu_features(int cpu, struct cpuinfo_arm64 *info,
 	 * as the register values may be UNKNOWN and we're not going to be
 	 * using them for anything.
 	 */
-	if (!id_aa64pfr0_32bit_el0(pfr0))
-		return taint;
+	if (!id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
+		return 0;
+
+	if (__allow_mismatched_32bit_el0)
+		cpumask_set_cpu(cpu, cpu_32bit_el0_mask);
 
 	/*
 	 * If we don't have AArch32 at EL1, then relax the strictness of
@@ -1193,6 +1200,47 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 	return feature_matches(val, entry);
 }
 
+static int __init init_32bit_el0_mask(void)
+{
+	if (!__allow_mismatched_32bit_el0)
+		return 0;
+
+	if (!alloc_cpumask_var(&cpu_32bit_el0_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	if (id_aa64pfr0_32bit_el0(per_cpu(cpu_data, 0).reg_id_aa64pfr0))
+		cpumask_set_cpu(0, cpu_32bit_el0_mask);
+
+	return 0;
+}
+early_initcall(init_32bit_el0_mask);
+
+const struct cpumask *system_32bit_el0_cpumask(void)
+{
+	if (__allow_mismatched_32bit_el0)
+		return cpu_32bit_el0_mask;
+
+	return system_supports_32bit_el0() ? cpu_present_mask : cpu_none_mask;
+}
+
+bool system_has_mismatched_32bit_el0(void)
+{
+	u64 reg;
+	unsigned int fld;
+
+	if (!__allow_mismatched_32bit_el0)
+		return false;
+
+	reg = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64PFR0_EL0_SHIFT);
+	return fld == ID_AA64PFR0_EL0_64BIT_ONLY;
+}
+
+static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	return has_cpuid_feature(entry, scope) || __allow_mismatched_32bit_el0;
+}
+
 static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	bool has_sre;
@@ -1803,7 +1851,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "32-bit EL0 Support",
 		.capability = ARM64_HAS_32BIT_EL0,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.matches = has_cpuid_feature,
+		.matches = has_32bit_el0,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_EL0_SHIFT,
-- 
2.29.0.rc2.309.g374f81d7ae-goog

