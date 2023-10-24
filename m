Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694A87D55DC
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjJXPVw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 11:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjJXPU4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 11:20:56 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F341729;
        Tue, 24 Oct 2023 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vECmaHWgtT+VWGMDLxY5TxzMLfeNlC2K5UVE+IQcxNw=; b=Y78pzseSLXCscQxrNvh+BfkBuo
        iHV71gI40WanxTsErZdNb9quyQWhQJfLgKj0dZgYISDmpx/5IutyGYcZdPYkBt6bXNLM6NcrY56d5
        S3Iv0fOs6APQjOulpNE2+1dpIhqEsqj21Z/K96aS5iZMA5abAE27dds2TKlXTyBFyrJNsopay/QyE
        qs+mql4k3z2M/nX3yCGk9OIcqI/AdypnXyq3Zdm0HUn1/hPVQDrNTUeIjn4UQ8cxHj8VST3lFMzBW
        5Tr1SPZgh7okEjTYowxX0x9EPv9HNC2jVc5Zo2621tCc1bYf+26YvF+uB01IEEaFe5zcuPauPUHXe
        P6/73H1Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50182 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJAP-0004SH-0J;
        Tue, 24 Oct 2023 16:18:01 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJAQ-00AqQy-G0; Tue, 24 Oct 2023 16:18:02 +0100
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 22/39] ACPI: Rename ACPI_HOTPLUG_CPU to include 'present'
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJAQ-00AqQy-G0@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:18:02 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: James Morse <james.morse@arm.com>

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
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Add Loongarch update
---
 arch/ia64/Kconfig                          |  2 +-
 arch/ia64/include/asm/acpi.h               |  2 +-
 arch/ia64/kernel/acpi.c                    |  6 +++---
 arch/ia64/kernel/setup.c                   |  2 +-
 arch/loongarch/Kconfig                     |  2 +-
 arch/loongarch/configs/loongson3_defconfig |  2 +-
 arch/loongarch/kernel/acpi.c               |  4 ++--
 arch/x86/Kconfig                           |  2 +-
 arch/x86/kernel/acpi/boot.c                |  4 ++--
 drivers/acpi/Kconfig                       |  4 ++--
 drivers/acpi/acpi_processor.c              | 10 +++++-----
 include/linux/acpi.h                       |  6 +++---
 12 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 06692e1c7c62..3b30305407ac 100644
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
index 41e8fe55cd98..381ce50fa54c 100644
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
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 5bed51adc68c..754c22214c4c 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -5,7 +5,7 @@ config LOONGARCH
 	select ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_MCFG if ACPI
-	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
+	select ACPI_HOTPLUG_PRESENT_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_PPTT if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_BINFMT_ELF_STATE
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
index 8e00a754e548..dfa56119b56f 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -288,7 +288,7 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 	memblock_reserve(addr, size);
 }
 
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 
 #include <acpi/processor.h>
 
@@ -340,4 +340,4 @@ int acpi_unmap_cpu(int cpu)
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
 
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a11c0aea5176..2a859f597a94 100644
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
index e7ed4730cbbe..c8e960ff0aca 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -183,7 +183,7 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 #endif /* CONFIG_X86 */
 
 /* Initialization */
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
 	unsigned long long sta;
@@ -228,7 +228,7 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
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
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ebfea7bf663d..48ee36086577 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -321,12 +321,12 @@ static inline int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
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
@@ -649,7 +649,7 @@ static inline u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
 #define ACPI_GSB_ACCESS_ATTRIB_RAW_PROCESS	0x0000000F
 
 /* Enable _OST when all relevant hotplug operations are enabled */
-#if defined(CONFIG_ACPI_HOTPLUG_CPU) &&			\
+#if defined(CONFIG_ACPI_HOTPLUG_PRESENT_CPU) &&			\
 	defined(CONFIG_ACPI_HOTPLUG_MEMORY) &&		\
 	defined(CONFIG_ACPI_CONTAINER)
 #define ACPI_HOTPLUG_OST
-- 
2.30.2

