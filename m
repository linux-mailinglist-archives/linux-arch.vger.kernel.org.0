Return-Path: <linux-arch+bounces-983-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5704E81117D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 13:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F83281F3D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED02A29439;
	Wed, 13 Dec 2023 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o2knhIkw"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC037A4;
	Wed, 13 Dec 2023 04:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DDcdVazneM/u7wMj0E+j+LVt0/sG+/pUc+Ol6c0oUAM=; b=o2knhIkwo9iXzfmsPtqSYX3GtZ
	82mkAYgR4tZL2XDDxQhWg2TXvFkydzxSO+QtMU6aght4+jecATwSJPaT6MOwZeS2Ar+iELpliTHfp
	fCdlENl4Al65j5dZUj6eh5X8CVOib3wPeL8+uRxbxXBGCLYKKhg4H1igrdD98NeZssawKNbd44Y2Z
	SL6LFSQIHbW0euxInaGWgMRpmE7cVcBK4FS/cpANOuJLiiRfLAbQJenZVhnVlS5Ce7og2+qK0NJpx
	VrHNwjSHqRrWUHXwJj3/H/VjCIzjKpqQvhqJJPgpkfimj1TGxDLx4y3VzkfdM21OZAwUSFU/cnnPj
	LT9Gj5Fg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58164 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rDOgA-0008Db-38;
	Wed, 13 Dec 2023 12:49:35 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rDOgD-00Dvk2-3h; Wed, 13 Dec 2023 12:49:37 +0000
In-Reply-To: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: linux-pm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	kvmarm@lists.linux.dev,
	x86@kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com,
	justin.he@arm.com,
	James Morse <james.morse@arm.com>
Subject: [PATCH RFC v3 05/21] ACPI: Rename ACPI_HOTPLUG_CPU to include
 'present'
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 13 Dec 2023 12:49:37 +0000

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
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Add Loongarch update
Changes since RFC v3:
 * Dropped ia64 changes
---
 arch/loongarch/Kconfig                     |  2 +-
 arch/loongarch/configs/loongson3_defconfig |  2 +-
 arch/loongarch/kernel/acpi.c               |  4 ++--
 arch/x86/Kconfig                           |  2 +-
 arch/x86/kernel/acpi/boot.c                |  4 ++--
 drivers/acpi/Kconfig                       |  4 ++--
 drivers/acpi/acpi_processor.c              | 10 +++++-----
 include/linux/acpi.h                       |  6 +++---
 8 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 15d05dd2b7f3..b1e87b90468d 100644
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
index 33795e4a5bd6..85d37b143077 100644
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
index 8330c4ac26b3..64fc7c475ab0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -59,7 +59,7 @@ config X86
 	#
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
-	select ACPI_HOTPLUG_CPU			if ACPI_PROCESSOR && HOTPLUG_CPU
+	select ACPI_HOTPLUG_PRESENT_CPU		if ACPI_PROCESSOR && HOTPLUG_CPU
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1a0dd80d81ac..33d259ddd188 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -826,7 +826,7 @@ static void __init acpi_set_irq_model_ioapic(void)
 /*
  *  ACPI based hotplug support for CPU
  */
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
+#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 #include <acpi/processor.h>
 
 static int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
@@ -875,7 +875,7 @@ int acpi_unmap_cpu(int cpu)
 	return (0);
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
-#endif				/* CONFIG_ACPI_HOTPLUG_CPU */
+#endif				/* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
 
 int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
 {
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a3acfc750fce..9c5a43d0aff4 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -306,7 +306,7 @@ config ACPI_IPMI
 	  To compile this driver as a module, choose M here:
 	  the module will be called as acpi_ipmi.
 
-config ACPI_HOTPLUG_CPU
+config ACPI_HOTPLUG_PRESENT_CPU
 	bool
 	depends on ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_CONTAINER
@@ -400,7 +400,7 @@ config ACPI_PCI_SLOT
 
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
index 4db54e928b36..36071bc11acd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -301,12 +301,12 @@ static inline int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
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
@@ -629,7 +629,7 @@ static inline u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
 #define ACPI_GSB_ACCESS_ATTRIB_RAW_PROCESS	0x0000000F
 
 /* Enable _OST when all relevant hotplug operations are enabled */
-#if defined(CONFIG_ACPI_HOTPLUG_CPU) &&			\
+#if defined(CONFIG_ACPI_HOTPLUG_PRESENT_CPU) &&			\
 	defined(CONFIG_ACPI_HOTPLUG_MEMORY) &&		\
 	defined(CONFIG_ACPI_CONTAINER)
 #define ACPI_HOTPLUG_OST
-- 
2.30.2


