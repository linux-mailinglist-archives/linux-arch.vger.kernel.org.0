Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691DB7D5621
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjJXPXc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjJXPWz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 11:22:55 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8164E2100;
        Tue, 24 Oct 2023 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C8oV1vsdSDENaxaUmj7dFWaDsKlGe2+ZjpG8GFhmEsc=; b=PbsD3/k+M70fv+mWOtGt9coYsu
        sfB5GOXL7yCxlr6x/z9yUFi/1THx8n4UsyevlGmkRDYoW3lBfjG+pddi9tXX6s1gM5nRwSzAfcsV8
        nU6I7qbXPa2bMRAKnw8b/4HzsyybENUw2n8BF54UPzrAPZDbbaW0tRNVhXo/d1USKEHRxzSGnmac6
        4HrpF6eylltm7rJUN7hAgfaz7p4CLs0uAkMXvF75vR4Ep9AYHySaw157NwTF25s3XQVbcayS6o/qa
        PEcUeKRzAC3pO69f859squ9StsTB/TQRP8B6virbL7/UoUzhppsHZul1iVuSc0PnKot+ArOOKWv1L
        7Cs41H2w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41538 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJBe-0004X6-0d;
        Tue, 24 Oct 2023 16:19:18 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJBf-00AqSQ-Mi; Tue, 24 Oct 2023 16:19:19 +0100
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH 37/39] ACPI: Add _OSC bits to advertise OS support for
 toggling CPU present/enabled
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJBf-00AqSQ-Mi@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:19:19 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: James Morse <james.morse@arm.com>

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
index 3b30305407ac..a7267d8a4d3d 100644
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
index 2a859f597a94..026f358b7b28 100644
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
index 5dabb426481f..539412ff59a1 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -182,6 +182,18 @@ static void __init acpi_pcc_cpufreq_init(void)
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
@@ -189,7 +201,7 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
 	acpi_status status;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU)) {
+	if (!acpi_processor_hotplug_present_supported()) {
 		pr_err_once("Changing CPU present bit is not supported\n");
 		return -ENODEV;
 	}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a4aa53b7e2bb..b42f17bfbb09 100644
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
index ed1ef5d8687f..53515ff1318f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -579,12 +579,16 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
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
2.30.2

