Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069DE2AC745
	for <lists+linux-arch@lfdr.de>; Mon,  9 Nov 2020 22:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgKIVai (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Nov 2020 16:30:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgKIVai (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Nov 2020 16:30:38 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFD8420789;
        Mon,  9 Nov 2020 21:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604957437;
        bh=1/2eLc4nDueBEVDmyzBDNZaa49IvSMcjE1BbzXnZqAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2bZ52jcwnMLh2TDwi73X26MH5zS32Cwz8ZQzuBpJCa6bbe+AgkdIhIRxrld0G1oS
         mG0h8Ak8BUO8kNL4X2+OYyE+/rX4gsBodhn+StTRorFjVDOBeg8h2+iINODYMSBhgw
         Vu5BAziduVqDcw1AP4ginal6EGm6Ap2C1YK2RLT8=
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
Subject: [PATCH v2 1/6] arm64: cpuinfo: Split AArch32 registers out into a separate struct
Date:   Mon,  9 Nov 2020 21:30:17 +0000
Message-Id: <20201109213023.15092-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109213023.15092-1-will@kernel.org>
References: <20201109213023.15092-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for late initialisation of the "sanitised" AArch32 register
state, move the AArch32 registers out of 'struct cpuinfo' and into their
own struct definition.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/cpu.h   | 44 +++++++++++----------
 arch/arm64/kernel/cpufeature.c | 71 ++++++++++++++++++----------------
 arch/arm64/kernel/cpuinfo.c    | 53 +++++++++++++------------
 3 files changed, 89 insertions(+), 79 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 7faae6ff3ab4..f4e01aa0f442 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -12,26 +12,7 @@
 /*
  * Records attributes of an individual CPU.
  */
-struct cpuinfo_arm64 {
-	struct cpu	cpu;
-	struct kobject	kobj;
-	u32		reg_ctr;
-	u32		reg_cntfrq;
-	u32		reg_dczid;
-	u32		reg_midr;
-	u32		reg_revidr;
-
-	u64		reg_id_aa64dfr0;
-	u64		reg_id_aa64dfr1;
-	u64		reg_id_aa64isar0;
-	u64		reg_id_aa64isar1;
-	u64		reg_id_aa64mmfr0;
-	u64		reg_id_aa64mmfr1;
-	u64		reg_id_aa64mmfr2;
-	u64		reg_id_aa64pfr0;
-	u64		reg_id_aa64pfr1;
-	u64		reg_id_aa64zfr0;
-
+struct cpuinfo_32bit {
 	u32		reg_id_dfr0;
 	u32		reg_id_dfr1;
 	u32		reg_id_isar0;
@@ -54,6 +35,29 @@ struct cpuinfo_arm64 {
 	u32		reg_mvfr0;
 	u32		reg_mvfr1;
 	u32		reg_mvfr2;
+};
+
+struct cpuinfo_arm64 {
+	struct cpu	cpu;
+	struct kobject	kobj;
+	u32		reg_ctr;
+	u32		reg_cntfrq;
+	u32		reg_dczid;
+	u32		reg_midr;
+	u32		reg_revidr;
+
+	u64		reg_id_aa64dfr0;
+	u64		reg_id_aa64dfr1;
+	u64		reg_id_aa64isar0;
+	u64		reg_id_aa64isar1;
+	u64		reg_id_aa64mmfr0;
+	u64		reg_id_aa64mmfr1;
+	u64		reg_id_aa64mmfr2;
+	u64		reg_id_aa64pfr0;
+	u64		reg_id_aa64pfr1;
+	u64		reg_id_aa64zfr0;
+
+	struct cpuinfo_32bit	aarch32;
 
 	/* pseudo-ZCR for recording maximum ZCR_EL1 LEN value: */
 	u64		reg_zcr;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index dcc165b3fc04..d4a7e84b1513 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -819,6 +819,31 @@ static void __init init_cpu_hwcaps_indirect_list(void)
 
 static void __init setup_boot_cpu_capabilities(void);
 
+static void __init init_32bit_cpu_features(struct cpuinfo_32bit *info)
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
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
 {
 	/* Before we start using the tables, make sure it is sorted */
@@ -838,29 +863,8 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
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
+	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
+		init_32bit_cpu_features(&info->aarch32);
 
 	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
 		init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
@@ -931,20 +935,12 @@ static void relax_cpu_ftr_reg(u32 sys_id, int field)
 	WARN_ON(!ftrp->width);
 }
 
-static int update_32bit_cpu_features(int cpu, struct cpuinfo_arm64 *info,
-				     struct cpuinfo_arm64 *boot)
+static int update_32bit_cpu_features(int cpu, struct cpuinfo_32bit *info,
+				     struct cpuinfo_32bit *boot)
 {
 	int taint = 0;
 	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
 
-	/*
-	 * If we don't have AArch32 at all then skip the checks entirely
-	 * as the register values may be UNKNOWN and we're not going to be
-	 * using them for anything.
-	 */
-	if (!id_aa64pfr0_32bit_el0(pfr0))
-		return taint;
-
 	/*
 	 * If we don't have AArch32 at EL1, then relax the strictness of
 	 * EL1-dependent register fields to avoid spurious sanity check fails.
@@ -1091,10 +1087,17 @@ void update_cpu_features(int cpu,
 	}
 
 	/*
+	 * If we don't have AArch32 at all then skip the checks entirely
+	 * as the register values may be UNKNOWN and we're not going to be
+	 * using them for anything.
+	 *
 	 * This relies on a sanitised view of the AArch64 ID registers
 	 * (e.g. SYS_ID_AA64PFR0_EL1), so we call it last.
 	 */
-	taint |= update_32bit_cpu_features(cpu, info, boot);
+	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
+		taint |= update_32bit_cpu_features(cpu, &info->aarch32,
+						   &boot->aarch32);
+	}
 
 	/*
 	 * Mismatched CPU features are a recipe for disaster. Don't even
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 77605aec25fe..8ce33742ad6a 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -344,6 +344,32 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 	pr_info("Detected %s I-cache on CPU%d\n", icache_policy_str[l1ip], cpu);
 }
 
+static void __cpuinfo_store_cpu_32bit(struct cpuinfo_32bit *info)
+{
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
 static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 {
 	info->reg_cntfrq = arch_timer_get_cntfrq();
@@ -371,31 +397,8 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
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
+	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
+		__cpuinfo_store_cpu_32bit(&info->aarch32);
 
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    id_aa64pfr0_sve(info->reg_id_aa64pfr0))
-- 
2.29.2.222.g5d2a92d10f8-goog

