Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2CC689A7A
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 14:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjBCNy7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 08:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjBCNy1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 08:54:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B2C0A0EB7;
        Fri,  3 Feb 2023 05:52:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39FC71FB;
        Fri,  3 Feb 2023 05:53:34 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CC463F71E;
        Fri,  3 Feb 2023 05:52:48 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 14/32] ACPI: Rename ACPI_HOTPLUG_CPU to include 'present'
Date:   Fri,  3 Feb 2023 13:50:25 +0000
Message-Id: <20230203135043.409192-15-james.morse@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230203135043.409192-1-james.morse@arm.com>
References: <20230203135043.409192-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The code behind ACPI_HOTPLUG_CPU allows a not-present CPU to become present.
This isn't the only use of HOTPLUG_CPU. On arm64 an offline CPU may be
disabled by firmware, preventing it from being brought back online, but it
remains present throughout.

Adding code to prevent user-space trying to online these disabled CPUs
needs some additional terminology.

Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_CPU to reflect
that it makes possible CPUs present.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/ia64/Kconfig             |  2 +-
 arch/ia64/include/asm/acpi.h  |  2 +-
 arch/ia64/kernel/acpi.c       |  6 +++---
 arch/ia64/kernel/setup.c      |  2 +-
 arch/x86/Kconfig              |  2 +-
 arch/x86/kernel/acpi/boot.c   |  4 ++--
 drivers/acpi/Kconfig          |  4 ++--
 drivers/acpi/acpi_processor.c | 10 +++++-----
 include/linux/acpi.h          |  6 +++---
 9 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 146a2226e2a3..f02894cafef8 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -15,7 +15,7 @@ config IA64
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ACPI
-	select ACPI_HOTPLUG_CPU if ACPI
+	select ACPI_HOTPLUG_PRESENT_CPU if ACPI
 	select ACPI_NUMA if NUMA
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index 87927eb824cc..2fcdfd4ecce8 100644
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
index 96d13cb7c19f..38b3155ce8d9 100644
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
@@ -822,7 +822,7 @@ int acpi_unmap_cpu(int cpu)
 	return (0);
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
-#endif				/* CONFIG_ACPI_HOTPLUG_CPU */
+#endif				/* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
 
 #ifdef CONFIG_ACPI_NUMA
 static acpi_status acpi_map_iosapic(acpi_handle handle, u32 depth,
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index c05728044272..1e826ed3bd56 100644
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
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e1aaee2f8412..23620969dfc0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -59,7 +59,7 @@ config X86
 	#
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
-	select ACPI_HOTPLUG_CPU			if ACPI
+	select ACPI_HOTPLUG_PRESENT_CPU	if ACPI
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..5a4869d6cd87 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -796,7 +796,7 @@ static void __init acpi_set_irq_model_ioapic(void)
 /*
  *  ACPI based hotplug support for CPU
  */
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 #include <acpi/processor.h>
 
 static int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
@@ -845,7 +845,7 @@ int acpi_unmap_cpu(int cpu)
 	return (0);
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
-#endif				/* CONFIG_ACPI_HOTPLUG_CPU */
+#endif				/* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
 
 int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
 {
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 4845e5b525ac..702b1ff1b7ad 100644
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
index a93a6c4115c4..682721594820 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -149,7 +149,7 @@ static int acpi_processor_errata(void)
 }
 
 /* Initialization */
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
 	unsigned long long sta;
@@ -194,7 +194,7 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
 	return -ENODEV;
 }
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
 
 static int acpi_processor_get_info(struct acpi_device *device)
 {
@@ -413,7 +413,7 @@ static int acpi_processor_add(struct acpi_device *device,
 	return result;
 }
 
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 /* Removal */
 static void acpi_processor_remove(struct acpi_device *device)
 {
@@ -457,7 +457,7 @@ static void acpi_processor_remove(struct acpi_device *device)
 	free_cpumask_var(pr->throttling.shared_cpu_map);
 	kfree(pr);
 }
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
 
 #ifdef CONFIG_X86
 static bool acpi_hwp_native_thermal_lvt_set;
@@ -526,7 +526,7 @@ static const struct acpi_device_id processor_device_ids[] = {
 static struct acpi_scan_handler processor_handler = {
 	.ids = processor_device_ids,
 	.attach = acpi_processor_add,
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 	.detach = acpi_processor_remove,
 #endif
 	.hotplug = {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5e6a876e17ba..0bc1eacd0dfc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -327,12 +327,12 @@ static inline int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
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
@@ -655,7 +655,7 @@ static inline u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
 #define ACPI_GSB_ACCESS_ATTRIB_RAW_PROCESS	0x0000000F
 
 /* Enable _OST when all relevant hotplug operations are enabled */
-#if defined(CONFIG_ACPI_HOTPLUG_CPU) &&			\
+#if defined(CONFIG_ACPI_HOTPLUG_PRESENT_CPU) &&			\
 	defined(CONFIG_ACPI_HOTPLUG_MEMORY) &&		\
 	defined(CONFIG_ACPI_CONTAINER)
 #define ACPI_HOTPLUG_OST
-- 
2.30.2

