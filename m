Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18BC2AF8BB
	for <lists+linux-arch@lfdr.de>; Wed, 11 Nov 2020 20:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgKKTKu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Nov 2020 14:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgKKTKu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Nov 2020 14:10:50 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E88FB206FB;
        Wed, 11 Nov 2020 19:10:46 +0000 (UTC)
Date:   Wed, 11 Nov 2020 19:10:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201111191043.GA5125@gaia>
References: <20201109213023.15092-1-will@kernel.org>
 <20201109213023.15092-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109213023.15092-3-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will,

On Mon, Nov 09, 2020 at 09:30:18PM +0000, Will Deacon wrote:
> +static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
> +{
> +	if (!has_cpuid_feature(entry, scope))
> +		return allow_mismatched_32bit_el0;

I still don't like overriding the cpufeature mechanism in this way. What about
something like below? It still doesn't fit perfectly but at least the
capability represents what was detected in the system. We then decide in
system_supports_32bit_el0() whether to allow asymmetry. There is an
extra trick to park a non-AArch32 capable CPU in has_32bit_el0() if it
comes up late and the feature has already been advertised with
!allow_mismatched_32bit_el0.

I find it clearer, though I probably stared at it more than at your
patch ;).

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 97244d4feca9..0e0427997063 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -604,9 +604,13 @@ static inline bool cpu_supports_mixed_endian_el0(void)
 	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
 }
 
+extern bool allow_mismatched_32bit_el0;
+extern bool mismatched_32bit_el0;
+
 static inline bool system_supports_32bit_el0(void)
 {
-	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
+	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0) &&
+		(!mismatched_32bit_el0 || allow_mismatched_32bit_el0);
 }
 
 static inline bool system_supports_4kb_granule(void)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b7b6804cb931..67534327f92b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -104,6 +104,13 @@ DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
 bool arm64_use_ng_mappings = false;
 EXPORT_SYMBOL(arm64_use_ng_mappings);
 
+/*
+ * Permit PER_LINUX32 and execve() of 32-bit binaries even if not all CPUs
+ * support it?
+ */
+bool __read_mostly allow_mismatched_32bit_el0;
+bool mismatched_32bit_el0;
+
 /*
  * Flag to indicate if we have computed the system wide
  * capabilities based on the boot time active CPUs. This
@@ -1193,6 +1200,35 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 	return feature_matches(val, entry);
 }
 
+static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	if (has_cpuid_feature(entry, scope))
+		return true;
+
+	if (system_capabilities_finalized() && !allow_mismatched_32bit_el0) {
+		pr_crit("CPU%d: Asymmetric AArch32 not supported\n",
+			smp_processor_id());
+		cpu_die_early();
+	}
+
+	mismatched_32bit_el0 = true;
+	return false;
+}
+
+static int __init report_32bit_el0(void)
+{
+	if (!system_supports_32bit_el0())
+		return 0;
+
+	if (mismatched_32bit_el0)
+		pr_info("detected: asymmetric 32-bit EL0 support\n");
+	else
+		pr_info("detected: 32-bit EL0 support\n");
+
+	return 0;
+}
+core_initcall(report_32bit_el0);
+
 static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	bool has_sre;
@@ -1800,10 +1836,9 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	},
 #endif	/* CONFIG_ARM64_VHE */
 	{
-		.desc = "32-bit EL0 Support",
 		.capability = ARM64_HAS_32BIT_EL0,
-		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.matches = has_cpuid_feature,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		.matches = has_32bit_el0,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_EL0_SHIFT,


-- 
Catalin
