Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43543689A6A
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 14:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjBCNx3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 08:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjBCNwh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 08:52:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9E2EA147C;
        Fri,  3 Feb 2023 05:52:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B326A15A1;
        Fri,  3 Feb 2023 05:53:04 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0DB03F71E;
        Fri,  3 Feb 2023 05:52:18 -0800 (PST)
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
Subject: [RFC PATCH 07/32] ia64/topology: Switch over to GENERIC_CPU_DEVICES
Date:   Fri,  3 Feb 2023 13:50:18 +0000
Message-Id: <20230203135043.409192-8-james.morse@arm.com>
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

ia64 has its own arch specific data structure for cpus: struct ia64_cpu.
This has one member, making ia64's cpu_devices the same as that
provided be GENERIC_CPU_DEVICES.
ia64 craetes a percpu struct ia64_cpu called cpu_devices, which has no
users. Instead it uses the struct ia64_cpu named sysfs_cpus allocated at
boot.

Remove the arch specific structure allocation and initialisation.
ia64's arch_register_cpu() now overrides the weak version from
GENERIC_CPU_DEVICES, and uses the percpu cpu_devices defined by
core code.

All uses of sysfs_cpus are changed to use the percpu cpu_devices.

This is an intermediate step to the logic being moved to drivers/acpi,
where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/ia64/Kconfig           |  1 +
 arch/ia64/include/asm/cpu.h |  6 ------
 arch/ia64/kernel/topology.c | 35 +++++------------------------------
 3 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index deabb8843aea..146a2226e2a3 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -40,6 +40,7 @@ config IA64
 	select HAVE_FUNCTION_DESCRIPTORS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HUGETLB_PAGE_SIZE_VARIABLE if HUGETLB_PAGE
+	select GENERIC_CPU_DEVICES
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_IRQ_SHOW
diff --git a/arch/ia64/include/asm/cpu.h b/arch/ia64/include/asm/cpu.h
index a3e690e685e5..6e9786c6ec98 100644
--- a/arch/ia64/include/asm/cpu.h
+++ b/arch/ia64/include/asm/cpu.h
@@ -7,12 +7,6 @@
 #include <linux/topology.h>
 #include <linux/percpu.h>
 
-struct ia64_cpu {
-	struct cpu cpu;
-};
-
-DECLARE_PER_CPU(struct ia64_cpu, cpu_devices);
-
 DECLARE_PER_CPU(int, cpu_state);
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
index 94a848b06f15..8f5cafde2bc9 100644
--- a/arch/ia64/kernel/topology.c
+++ b/arch/ia64/kernel/topology.c
@@ -26,8 +26,6 @@
 #include <asm/numa.h>
 #include <asm/cpu.h>
 
-static struct ia64_cpu *sysfs_cpus;
-
 void arch_fix_phys_package_id(int num, u32 slot)
 {
 #ifdef CONFIG_SMP
@@ -41,50 +39,27 @@ EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);
 #ifdef CONFIG_HOTPLUG_CPU
 int __ref arch_register_cpu(int num)
 {
+	struct cpu *cpu = &per_cpu(cpu_devices, num);
+
 	/*
 	 * If CPEI can be re-targeted or if this is not
 	 * CPEI target, then it is hotpluggable
 	 */
 	if (can_cpei_retarget() || !is_cpu_cpei_target(num))
-		sysfs_cpus[num].cpu.hotpluggable = 1;
+		cpu->hotpluggable = 1;
 	map_cpu_to_node(num, node_cpuid[num].nid);
-	return register_cpu(&sysfs_cpus[num].cpu, num);
+	return register_cpu(cpu, num);
 }
 EXPORT_SYMBOL(arch_register_cpu);
 
 void __ref arch_unregister_cpu(int num)
 {
-	unregister_cpu(&sysfs_cpus[num].cpu);
+	unregister_cpu(&per_cpu(cpu_devices, num));
 	unmap_cpu_from_node(num, cpu_to_node(num));
 }
 EXPORT_SYMBOL(arch_unregister_cpu);
-#else
-static int __init arch_register_cpu(int num)
-{
-	return register_cpu(&sysfs_cpus[num].cpu, num);
-}
 #endif /*CONFIG_HOTPLUG_CPU*/
 
-
-static int __init topology_init(void)
-{
-	int i, err = 0;
-
-	sysfs_cpus = kcalloc(NR_CPUS, sizeof(struct ia64_cpu), GFP_KERNEL);
-	if (!sysfs_cpus)
-		panic("kzalloc in topology_init failed - NR_CPUS too big?");
-
-	for_each_present_cpu(i) {
-		if((err = arch_register_cpu(i)))
-			goto out;
-	}
-out:
-	return err;
-}
-
-subsys_initcall(topology_init);
-
-
 /*
  * Export cpu cache information through sysfs
  */
-- 
2.30.2

