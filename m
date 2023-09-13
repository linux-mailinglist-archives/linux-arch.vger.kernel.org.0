Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270D979EE6B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjIMQjA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjIMQi7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:38:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C7F71BC8;
        Wed, 13 Sep 2023 09:38:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4743E1FB;
        Wed, 13 Sep 2023 09:39:32 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C3E83F5A1;
        Wed, 13 Sep 2023 09:38:53 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 01/35] ACPI: Move ACPI_HOTPLUG_CPU to be disabled on arm64 and riscv
Date:   Wed, 13 Sep 2023 16:37:49 +0000
Message-Id: <20230913163823.7880-2-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Neither arm64 nor riscv support physical hotadd of CPUs that were not
present at boot. For arm64 much of the platform description is in static
tables which do not have update methods. arm64 does support HOTPLUG_CPU,
which is backed by a firmware interface to turn CPUs on and off.

acpi_processor_hotadd_init() and acpi_processor_remove() are for adding
and removing CPUs that were not present at boot. arm64 systems that do this
are not supported as there is currently insufficient information in the
platform description. (e.g. did the GICR get removed too?)

arm64 currently relies on the MADT enabled flag check in map_gicc_mpidr()
to prevent CPUs that were not described as present at boot from being
added to the system. Similarly, riscv relies on the same check in
map_rintc_hartid(). Both architectures also rely on the weak 'always fails'
definitions of acpi_map_cpu() and arch_register_cpu().

Subsequent changes will redefine ACPI_HOTPLUG_CPU as making possible
CPUs present. Neither arm64 nor riscv support this.

Disable ACPI_HOTPLUG_CPU for arm64 and riscv by removing 'default y' and
selecting it on the other three ACPI architectures. This allows the weak
definitions of some symbols to be removed.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since RFC:
 * Expanded conditions to avoid ACPI_HOTPLUG_CPU being enabled when
   HOTPLUG_CPU isn't.
---
 arch/ia64/Kconfig                |  1 +
 arch/loongarch/Kconfig           |  1 +
 arch/loongarch/include/asm/cpu.h |  7 +++++++
 arch/x86/Kconfig                 |  1 +
 drivers/acpi/Kconfig             |  1 -
 drivers/acpi/acpi_processor.c    | 18 ------------------
 6 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 53faa122b0f4..a3bfd42467ab 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -16,6 +16,7 @@ config IA64
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ACPI
+	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_NUMA if NUMA
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index e14396a2ddcb..2bddd202470e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -5,6 +5,7 @@ config LOONGARCH
 	select ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_MCFG if ACPI
+	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_PPTT if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_BINFMT_ELF_STATE
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
index 48b9f7168bcc..7afe8cbb844e 100644
--- a/arch/loongarch/include/asm/cpu.h
+++ b/arch/loongarch/include/asm/cpu.h
@@ -128,4 +128,11 @@ enum cpu_type_enum {
 #define LOONGARCH_CPU_HYPERVISOR	BIT_ULL(CPU_FEATURE_HYPERVISOR)
 #define LOONGARCH_CPU_PTW		BIT_ULL(CPU_FEATURE_PTW)
 
+#if !defined(__ASSEMBLY__)
+#ifdef CONFIG_HOTPLUG_CPU
+int arch_register_cpu(int num);
+void arch_unregister_cpu(int cpu);
+#endif
+#endif /* ! __ASSEMBLY__ */
+
 #endif /* _ASM_CPU_H */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 982b777eadc7..a0100a1ab4a0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -60,6 +60,7 @@ config X86
 	#
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
+	select ACPI_HOTPLUG_CPU			if ACPI_PROCESSOR && HOTPLUG_CPU
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index cee82b473dc5..8456d48ba702 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -309,7 +309,6 @@ config ACPI_HOTPLUG_CPU
 	bool
 	depends on ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_CONTAINER
-	default y
 
 config ACPI_PROCESSOR_AGGREGATOR
 	tristate "Processor Aggregator"
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index c711db8a9c33..c0839bcf78c1 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -183,24 +183,6 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 
 /* Initialization */
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
-int __weak acpi_map_cpu(acpi_handle handle,
-		phys_cpuid_t physid, u32 acpi_id, int *pcpu)
-{
-	return -ENODEV;
-}
-
-int __weak acpi_unmap_cpu(int cpu)
-{
-	return -ENODEV;
-}
-
-int __weak arch_register_cpu(int cpu)
-{
-	return -ENODEV;
-}
-
-void __weak arch_unregister_cpu(int cpu) {}
-
 static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
 	unsigned long long sta;
-- 
2.39.2

