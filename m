Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7B97D556F
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 17:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbjJXPSa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbjJXPR4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 11:17:56 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C71706;
        Tue, 24 Oct 2023 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KZXjVtVQneKo3WIqS1cOw+7u76KHDqdKIkimTnmicMQ=; b=oQXL+ztbtib67CufbaV6bwZs0x
        1aL5xpdM/v7yUBuXAU31sRvFyvboD1hASYO/YHcx/XBuWnD2BvD0svJ0CTG88QmZbmHA8WpJK7vyR
        u9Ipxy5PZEQGUEvJKgUUZA0C1LGpUqRvoV+X42HCHIEkkNg9HYYD8IY55sMBHRhkcN5EFbmyAjw7k
        4BTeBQvpcRokJmDvLDgmgSo9QmxbE1J+UgRsJmHOpl+3xAVjCTei9RXRVw+s9E2ZZFNUWuYCr8KhR
        PU0lqiYWbU1Ayp+ml6gmwkv6xQ0F7ytwCwVr8hU7+uKss0XUB0vKE+ib1JYApv930jkP7XApTB1BE
        QoWDP9Tw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35394 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJ8z-0004MI-1r;
        Tue, 24 Oct 2023 16:16:33 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJ91-00AqPG-0U; Tue, 24 Oct 2023 16:16:35 +0100
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
Subject: [PATCH 05/39] ACPI: Move ACPI_HOTPLUG_CPU to be disabled on arm64 and
 riscv
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJ91-00AqPG-0U@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:16:35 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: James Morse <james.morse@arm.com>

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
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC:
 * Expanded conditions to avoid ACPI_HOTPLUG_CPU being enabled when
   HOTPLUG_CPU isn't.
---
 arch/ia64/Kconfig             |  1 +
 arch/loongarch/Kconfig        |  1 +
 arch/x86/Kconfig              |  1 +
 drivers/acpi/Kconfig          |  1 -
 drivers/acpi/acpi_processor.c | 18 ------------------
 5 files changed, 3 insertions(+), 19 deletions(-)

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
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..18729edc879d 100644
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
index 0f5218e361df..4fe2ef54088c 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -184,24 +184,6 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 
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
2.30.2

