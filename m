Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D409C79EEEE
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjIMQmS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjIMQlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:41:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54B932D64;
        Wed, 13 Sep 2023 09:40:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CEEB1FB;
        Wed, 13 Sep 2023 09:40:38 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 516783F5A1;
        Wed, 13 Sep 2023 09:39:59 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 34/35] ACPI: Add _OSC bits to advertise OS support for toggling CPU present/enabled
Date:   Wed, 13 Sep 2023 16:38:22 +0000
Message-Id: <20230913163823.7880-35-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Platform firmware can disabled a CPU, or make it not-present by making
an eject-request notification, then waiting for the os to make it offline
and call _EJx. After the firmware updates _STA with the new status.

Not all operating systems support this. For arm64 making CPUs not-present
has never been supported. For all ACPI architectures, making CPUs disabled
has recently been added. Firmware can't know what the OS has support for.

Add two new _OSC bits to advertise whether the OS supports the _STA enabled
or present bits being toggled for CPUs. This will be important for arm64
if systems that support physical CPU hotplug ever appear as arm64 linux
doesn't currently support this, so firmware shouldn't try.

Advertising this support to firmware is useful for cloud orchestrators
to know whether they can scale a particular VM by adding CPUs.

Signed-off-by: James Morse <james.morse@arm.com>
---
I'm assuming ia64 with physical hotplug machines once existed, and
that Loongarch machines with support for this don't.
---
 arch/ia64/Kconfig             |  1 +
 arch/x86/Kconfig              |  1 +
 drivers/acpi/Kconfig          |  9 +++++++++
 drivers/acpi/acpi_processor.c | 14 +++++++++++++-
 drivers/acpi/bus.c            | 16 ++++++++++++++++
 include/linux/acpi.h          |  4 ++++
 6 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 54972f9fe804..13df676bad67 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -17,6 +17,7 @@ config IA64
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ACPI
 	select ACPI_HOTPLUG_PRESENT_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
+	select ACPI_HOTPLUG_IGNORE_OSC  if ACPI
 	select ACPI_NUMA if NUMA
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 295a7a3debb6..5fea3ce9594e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -61,6 +61,7 @@ config X86
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ACPI_HOTPLUG_PRESENT_CPU		if ACPI_PROCESSOR && HOTPLUG_CPU
+	select ACPI_HOTPLUG_IGNORE_OSC		if ACPI && HOTPLUG_CPU
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 417f9f3077d2..c49978b4b11f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -310,6 +310,15 @@ config ACPI_HOTPLUG_PRESENT_CPU
 	depends on ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_CONTAINER
 
+config ACPI_HOTPLUG_IGNORE_OSC
+	bool
+	depends on ACPI_HOTPLUG_PRESENT_CPU
+	help
+	  Ignore whether firmware acknowledged support for toggling the CPU
+	  present bit in _STA. Some architectures predate the _OSC bits, so
+	  firmware doesn't know to do this.
+
+
 config ACPI_PROCESSOR_AGGREGATOR
 	tristate "Processor Aggregator"
 	depends on ACPI_PROCESSOR
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index b49859eab01a..87926f22c857 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -181,6 +181,18 @@ static void __init acpi_pcc_cpufreq_init(void)
 static void __init acpi_pcc_cpufreq_init(void) {}
 #endif /* CONFIG_X86 */
 
+static bool acpi_processor_hotplug_present_supported(void)
+{
+	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
+		return false;
+
+	/* x86 systems pre-date the _OSC bit */
+	if (IS_ENABLED(CONFIG_ACPI_HOTPLUG_IGNORE_OSC))
+		return true;
+
+	return osc_sb_hotplug_present_support_acked;
+}
+
 /* Initialization */
 static int acpi_processor_make_present(struct acpi_processor *pr)
 {
@@ -188,7 +200,7 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
 	acpi_status status;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU)) {
+	if (!acpi_processor_hotplug_present_supported()) {
 		pr_err_once("Changing CPU present bit is not supported\n");
 		return -ENODEV;
 	}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f41dda2d3493..123c28c2eda3 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -298,6 +298,13 @@ EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
 
 bool osc_sb_cppc2_support_acked;
 
+/*
+ * ACPI 6.? Proposed Operating System Capabilities for modifying CPU
+ * present/enable.
+ */
+bool osc_sb_hotplug_enabled_support_acked;
+bool osc_sb_hotplug_present_support_acked;
+
 static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 static void acpi_bus_osc_negotiate_platform_control(void)
 {
@@ -346,6 +353,11 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 
 	if (!ghes_disable)
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
+
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_ENABLED_SUPPORT;
+	if (IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_PRESENT_SUPPORT;
+
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
@@ -383,6 +395,10 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
 		osc_cpc_flexible_adr_space_confirmed =
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
+		osc_sb_hotplug_enabled_support_acked =
+			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_HOTPLUG_ENABLED_SUPPORT;
+		osc_sb_hotplug_present_support_acked =
+			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_HOTPLUG_PRESENT_SUPPORT;
 	}
 
 	kfree(context.ret.pointer);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 92cb25349a18..2ba7e0b10bcf 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -580,12 +580,16 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
 #define OSC_SB_PRM_SUPPORT			0x00200000
 #define OSC_SB_FFH_OPR_SUPPORT			0x00400000
+#define OSC_SB_HOTPLUG_ENABLED_SUPPORT		0x00800000
+#define OSC_SB_HOTPLUG_PRESENT_SUPPORT		0x01000000
 
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
 extern bool osc_sb_native_usb4_support_confirmed;
 extern bool osc_sb_cppc2_support_acked;
 extern bool osc_cpc_flexible_adr_space_confirmed;
+extern bool osc_sb_hotplug_enabled_support_acked;
+extern bool osc_sb_hotplug_present_support_acked;
 
 /* USB4 Capabilities */
 #define OSC_USB_USB3_TUNNELING			0x00000001
-- 
2.39.2

