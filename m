Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BA779EEAB
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjIMQkj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjIMQjw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:39:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58AE72134;
        Wed, 13 Sep 2023 09:39:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5612CC15;
        Wed, 13 Sep 2023 09:40:06 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37C573F5A1;
        Wed, 13 Sep 2023 09:39:27 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 18/35] ACPI: Rename ACPI_HOTPLUG_CPU to include 'present'
Date:   Wed, 13 Sep 2023 16:38:06 +0000
Message-Id: <20230913163823.7880-19-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The code behind ACPI_HOTPLUG_CPU allows a not-present CPU to become
present. This isn't the only use of HOTPLUG_CPU. On arm64 and riscv
CPUs can be taken offline as a power saving measure.

On arm64 an offline CPU may be disabled by firmware, preventing it from
being brought back online, but it remains present throughout.

Adding code to prevent user-space trying to online these disabled CPUs
needs some additional terminology.

Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_CPU to reflect
that it makes possible CPUs present.

HOTPLUG_CPU is untouched as this is only about the ACPI mechanism.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/ia64/Kconfig                          |  2 +-
 arch/ia64/include/asm/acpi.h               |  2 +-
 arch/ia64/kernel/acpi.c                    |  6 +++---
 arch/ia64/kernel/setup.c                   |  2 +-
 arch/loongarch/configs/loongson3_defconfig |  2 +-
 arch/loongarch/kernel/acpi.c               |  4 ++--
 arch/x86/Kconfig                           |  2 +-
 arch/x86/kernel/acpi/boot.c                |  4 ++--
 drivers/acpi/Kconfig                       |  4 ++--
 drivers/acpi/acpi_processor.c              | 10 +++++-----
 include/acpi/processor.h                   |  2 +-
 include/linux/acpi.h                       |  6 +++---
 12 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index a3bfd42467ab..54972f9fe804 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -16,7 +16,7 @@ config IA64
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ACPI
-	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
+	select ACPI_HOTPLUG_PRESENT_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_NUMA if NUMA
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index 58500a964238..482ea994d1e1 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -52,7 +52,7 @@ extern unsigned int is_cpu_cpei_target(unsigned int cpu);
 extern void set_cpei_target_cpu(unsigned int cpu);
 extern unsigned int get_cpei_target_cpu(void);
 extern void prefill_possible_map(void);
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 extern int additional_cpus;
 #else
 #define additional_cpus 0
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 15f6cfddcc08..35881bf4b016 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -194,7 +194,7 @@ acpi_parse_plat_int_src(union acpi_subtable_headers * header,
 	return 0;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 unsigned int can_cpei_retarget(void)
 {
 	extern int cpe_vector;
@@ -711,7 +711,7 @@ int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
 /*
  *  ACPI based hotplug CPU support
  */
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 {
 #ifdef CONFIG_ACPI_NUMA
@@ -820,7 +820,7 @@ int acpi_unmap_cpu(int cpu)
 	return (0);
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
-#endif				/* CONFIG_ACPI_HOTPLUG_CPU */
+#endif				/* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
 
 #ifdef CONFIG_ACPI_NUMA
 static acpi_status acpi_map_iosapic(acpi_handle handle, u32 depth,
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 5a55ac82c13a..44591716d07b 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -569,7 +569,7 @@ setup_arch (char **cmdline_p)
 #ifdef CONFIG_ACPI_NUMA
 	acpi_numa_init();
 	acpi_numa_fixup();
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 	prefill_possible_map();
 #endif
 	per_cpu_scan_finalize((cpumask_empty(&early_cpu_possible_map) ?
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index a3b52aaa83b3..ef3bc76313e4 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -59,7 +59,7 @@ CONFIG_ACPI_SPCR_TABLE=y
 CONFIG_ACPI_TAD=y
 CONFIG_ACPI_DOCK=y
 CONFIG_ACPI_IPMI=m
-CONFIG_ACPI_HOTPLUG_CPU=y
+CONFIG_ACPI_HOTPLUG_PRESENT_CPU=y
 CONFIG_ACPI_PCI_SLOT=y
 CONFIG_ACPI_HOTPLUG_MEMORY=y
 CONFIG_EFI_ZBOOT=y
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 9450e09073eb..b5153e395ad9 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -289,7 +289,7 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 	memblock_reserve(addr, size);
 }
 
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 
 #include <acpi/processor.h>
 
@@ -341,4 +341,4 @@ int acpi_unmap_cpu(int cpu)
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
 
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 133ea5f561b5..295a7a3debb6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -60,7 +60,7 @@ config X86
 	#
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
-	select ACPI_HOTPLUG_CPU			if ACPI_PROCESSOR && HOTPLUG_CPU
+	select ACPI_HOTPLUG_PRESENT_CPU		if ACPI_PROCESSOR && HOTPLUG_CPU
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 2a0ea38955df..84dd4133754b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -814,7 +814,7 @@ static void __init acpi_set_irq_model_ioapic(void)
 /*
  *  ACPI based hotplug support for CPU
  */
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 #include <acpi/processor.h>
 
 static int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
@@ -863,7 +863,7 @@ int acpi_unmap_cpu(int cpu)
 	return (0);
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
-#endif				/* CONFIG_ACPI_HOTPLUG_CPU */
+#endif				/* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
 
 int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
 {
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 8456d48ba702..417f9f3077d2 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -305,7 +305,7 @@ config ACPI_IPMI
 	  To compile this driver as a module, choose M here:
 	  the module will be called as acpi_ipmi.
 
-config ACPI_HOTPLUG_CPU
+config ACPI_HOTPLUG_PRESENT_CPU
 	bool
 	depends on ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_CONTAINER
@@ -399,7 +399,7 @@ config ACPI_PCI_SLOT
 
 config ACPI_CONTAINER
 	bool "Container and Module Devices"
-	default (ACPI_HOTPLUG_MEMORY || ACPI_HOTPLUG_CPU)
+	default (ACPI_HOTPLUG_MEMORY || ACPI_HOTPLUG_PRESENT_CPU)
 	help
 	  This driver supports ACPI Container and Module devices (IDs
 	  ACPI0004, PNP0A05, and PNP0A06).
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 867782bc50b0..75257fae10e7 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -182,7 +182,7 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 #endif /* CONFIG_X86 */
 
 /* Initialization */
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
 	unsigned long long sta;
@@ -227,7 +227,7 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
 	return -ENODEV;
 }
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
 
 static int acpi_processor_get_info(struct acpi_device *device)
 {
@@ -461,7 +461,7 @@ static int acpi_processor_add(struct acpi_device *device,
 	return result;
 }
 
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 /* Removal */
 static void acpi_processor_remove(struct acpi_device *device)
 {
@@ -505,7 +505,7 @@ static void acpi_processor_remove(struct acpi_device *device)
 	free_cpumask_var(pr->throttling.shared_cpu_map);
 	kfree(pr);
 }
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
 
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
 bool __init processor_physically_present(acpi_handle handle)
@@ -630,7 +630,7 @@ static const struct acpi_device_id processor_device_ids[] = {
 static struct acpi_scan_handler processor_handler = {
 	.ids = processor_device_ids,
 	.attach = acpi_processor_add,
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 	.detach = acpi_processor_remove,
 #endif
 	.hotplug = {
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 94181fe9780a..fd6913370c72 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -465,7 +465,7 @@ extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
 extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
 #endif
 
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 extern int arch_register_cpu(int cpu);
 extern void arch_unregister_cpu(int cpu);
 #endif
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a73246c3c35e..651dd43976a9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -316,12 +316,12 @@ static inline int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 }
 #endif
 
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
 		 int *pcpu);
 int acpi_unmap_cpu(int cpu);
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
@@ -644,7 +644,7 @@ static inline u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
 #define ACPI_GSB_ACCESS_ATTRIB_RAW_PROCESS	0x0000000F
 
 /* Enable _OST when all relevant hotplug operations are enabled */
-#if defined(CONFIG_ACPI_HOTPLUG_CPU) &&			\
+#if defined(CONFIG_ACPI_HOTPLUG_PRESENT_CPU) &&			\
 	defined(CONFIG_ACPI_HOTPLUG_MEMORY) &&		\
 	defined(CONFIG_ACPI_CONTAINER)
 #define ACPI_HOTPLUG_OST
-- 
2.39.2

