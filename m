Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F551B2982
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgDUO0v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 10:26:51 -0400
Received: from foss.arm.com ([217.140.110.172]:36106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbgDUO0v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 10:26:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C096A11B3;
        Tue, 21 Apr 2020 07:26:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D69753F68F;
        Tue, 21 Apr 2020 07:26:48 -0700 (PDT)
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
Subject: [PATCH v3 21/23] arm64: mte: Check the DT memory nodes for MTE support
Date:   Tue, 21 Apr 2020 15:26:01 +0100
Message-Id: <20200421142603.3894-22-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421142603.3894-1-catalin.marinas@arm.com>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
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
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
---

Notes:
    New in v3.
    
    Ongoing (internal) discussions on whether this is the right approach.
    The issue needs to be solved similarly for ACPI systems.

 arch/arm64/boot/dts/arm/fvp-base-revc.dts |  1 +
 arch/arm64/kernel/cpufeature.c            | 51 ++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

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
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d2fe8ff72324..a32aad1d5b57 100644
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
@@ -1412,6 +1414,51 @@ static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 #endif
 
 #ifdef CONFIG_ARM64_MTE
+static bool has_usable_mte(const struct arm64_cpu_capabilities *entry,
+			   int scope)
+{
+	struct device_node *np;
+	bool memory_checked = false;
+	bool mte_capable = true;
+
+	if (!has_cpuid_feature(entry, scope))
+		return false;
+
+	/*
+	 * If !SCOPE_SYSTEM, return true as per the above CPUID check (late
+	 * CPU bring-up/hotplug). Otherwise, perform addtional checks on the
+	 * system memory MTE support.
+	 */
+	if (scope != SCOPE_SYSTEM)
+		return true;
+
+	if (!acpi_disabled) {
+		pr_warn("MTE not supported on ACPI systems\n");
+		return false;
+	}
+
+	/* check the "memory" nodes for MTE support */
+	for_each_node_by_type(np, "memory") {
+		memory_checked = true;
+		mte_capable &= of_property_read_bool(np, "arm,armv8.5-memtag");
+	}
+
+	if (!memory_checked || !mte_capable) {
+		pr_warn("System memory is not MTE-capable\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool has_hwcap_mte(const struct arm64_cpu_capabilities *entry,
+			  int scope)
+{
+	if (scope == SCOPE_SYSTEM)
+		return system_supports_mte();
+	return this_cpu_has_cap(ARM64_MTE);
+}
+
 static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 {
 	u64 mair;
@@ -1828,7 +1875,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "Memory Tagging Extension",
 		.capability = ARM64_MTE,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.matches = has_cpuid_feature,
+		.matches = has_usable_mte,
 		.sys_reg = SYS_ID_AA64PFR1_EL1,
 		.field_pos = ID_AA64PFR1_MTE_SHIFT,
 		.min_field_value = ID_AA64PFR1_MTE,
@@ -1950,7 +1997,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_MULTI_CAP(ptr_auth_hwcap_gen_matches, CAP_HWCAP, KERNEL_HWCAP_PACG),
 #endif
 #ifdef CONFIG_ARM64_MTE
-	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_MTE_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_MTE, CAP_HWCAP, KERNEL_HWCAP_MTE),
+	HWCAP_CAP_MATCH(has_hwcap_mte, CAP_HWCAP, KERNEL_HWCAP_MTE),
 #endif /* CONFIG_ARM64_MTE */
 	{},
 };
