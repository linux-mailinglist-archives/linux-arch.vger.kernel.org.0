Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B38689A34
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 14:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjBCNwX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 08:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjBCNwS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 08:52:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DE6DA1455;
        Fri,  3 Feb 2023 05:52:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38BA01474;
        Fri,  3 Feb 2023 05:52:42 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AFCD3F71E;
        Fri,  3 Feb 2023 05:51:56 -0800 (PST)
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
Subject: [RFC PATCH 02/32] ACPI: Move ACPI_HOTPLUG_CPU to be enabled per architecture
Date:   Fri,  3 Feb 2023 13:50:13 +0000
Message-Id: <20230203135043.409192-3-james.morse@arm.com>
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

arm64 doesn't support physical hotadd of CPUs that were not present at boot.
Much of the platform description is in static tables which do not have
update methods. arm64 does support HOTPLUG_CPU, which is backed by a
firmware interface to turn CPUs on and off.

acpi_processor_hotadd_init() and acpi_processor_remove() are for adding
and removing CPUs that were not present at boot. arm64 systems that do this
are not supported as there is currently insufficient information in the
platform description. (e.g. did the GICR get removed too?)

arm64 currently relies on the MADT enabled flag check in map_gicc_mpidr()
to prevent CPUs that were not described as present at boot from being
added to the system. Adding support for virtual CPU hotplug (where the
vCPUs have been present the whole time) would require this check to be
removed, possibly allowing physical CPUs to be added.

Disable ACPI_HOTPLUG_CPU for arm64 by removing 'default y' and selecting
it on the other three ACPI architectures. This allows the weak definitions
of some symbols to be removed.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/ia64/Kconfig                |  1 +
 arch/loongarch/Kconfig           |  1 +
 arch/loongarch/include/asm/cpu.h |  7 +++++++
 arch/x86/Kconfig                 |  1 +
 drivers/acpi/Kconfig             |  1 -
 drivers/acpi/acpi_processor.c    | 18 ------------------
 6 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index d7e4a24e8644..deabb8843aea 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -15,6 +15,7 @@ config IA64
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ACPI
+	select ACPI_HOTPLUG_CPU if ACPI
 	select ACPI_NUMA if NUMA
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 9cc8b84f7eb0..075aa50e5d5f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -5,6 +5,7 @@ config LOONGARCH
 	select ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_MCFG if ACPI
+	select ACPI_HOTPLUG_CPU if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
index 754f28506791..da79862ff1f3 100644
--- a/arch/loongarch/include/asm/cpu.h
+++ b/arch/loongarch/include/asm/cpu.h
@@ -124,4 +124,11 @@ enum cpu_type_enum {
 #define LOONGARCH_CPU_GUESTID		BIT_ULL(CPU_FEATURE_GUESTID)
 #define LOONGARCH_CPU_HYPERVISOR	BIT_ULL(CPU_FEATURE_HYPERVISOR)
 
+#if !defined(__ASSEMBLY__)
+#ifdef CONFIG_HOTPLUG_CPU
+extern int arch_register_cpu(int num);
+extern void arch_unregister_cpu(int);
+#endif
+#endif /* ! __ASSEMBLY__ */
+
 #endif /* _ASM_CPU_H */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..6a520c22c3eb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -59,6 +59,7 @@ config X86
 	#
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
+	select ACPI_HOTPLUG_CPU			if ACPI
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ccbeab9500ec..4845e5b525ac 100644
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
index 6737b1cbf6d6..16b314340e68 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -150,24 +150,6 @@ static int acpi_processor_errata(void)
 
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

