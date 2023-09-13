Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A1079EE8F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjIMQjj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjIMQjR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:39:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42CD01BDD;
        Wed, 13 Sep 2023 09:39:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42417FEC;
        Wed, 13 Sep 2023 09:39:46 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47AE03F5A1;
        Wed, 13 Sep 2023 09:39:07 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 08/35] x86/topology: Switch over to GENERIC_CPU_DEVICES
Date:   Wed, 13 Sep 2023 16:37:56 +0000
Message-Id: <20230913163823.7880-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
overridden by the arch code, switch over to this to allow common code
to choose when the register_cpu() call is made.

x86's struct cpus come from struct x86_cpu, which has no other members
or users. Remove this and use the version defined by common code.

This is an intermediate step to the logic being moved to drivers/acpi,
where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.

Signed-off-by: James Morse <james.morse@arm.com>
----
Changes since RFC:
 * Fixed the second copy of arch_register_cpu() used for non-hotplug
---
 arch/x86/Kconfig           |  1 +
 arch/x86/include/asm/cpu.h |  4 ----
 arch/x86/kernel/topology.c | 25 ++++++-------------------
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a0100a1ab4a0..133ea5f561b5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -148,6 +148,7 @@ config X86
 	select GENERIC_CLOCKEVENTS_MIN_ADJUST
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 96dc4665e87d..f349c94510e8 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -23,10 +23,6 @@ static inline void prefill_possible_map(void) {}
 
 #endif /* CONFIG_SMP */
 
-struct x86_cpu {
-	struct cpu cpu;
-};
-
 #ifdef CONFIG_HOTPLUG_CPU
 extern void arch_unregister_cpu(int);
 extern void soft_restart_cpu(void);
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 0bab03130033..ca08a1d138f0 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -35,38 +35,25 @@
 #include <asm/io_apic.h>
 #include <asm/cpu.h>
 
-static DEFINE_PER_CPU(struct x86_cpu, cpu_devices);
-
 #ifdef CONFIG_HOTPLUG_CPU
 int arch_register_cpu(int cpu)
 {
-	struct x86_cpu *xc = per_cpu_ptr(&cpu_devices, cpu);
+	struct cpu *c = per_cpu_ptr(&cpu_devices, cpu);
 
-	xc->cpu.hotpluggable = cpu > 0;
-	return register_cpu(&xc->cpu, cpu);
+	c->hotpluggable = cpu > 0;
+	return register_cpu(c, cpu);
 }
 EXPORT_SYMBOL(arch_register_cpu);
 
 void arch_unregister_cpu(int num)
 {
-	unregister_cpu(&per_cpu(cpu_devices, num).cpu);
+	unregister_cpu(&per_cpu(cpu_devices, num));
 }
 EXPORT_SYMBOL(arch_unregister_cpu);
 #else /* CONFIG_HOTPLUG_CPU */
 
-int __init arch_register_cpu(int num)
+int arch_register_cpu(int num)
 {
-	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
+	return register_cpu(&per_cpu(cpu_devices, num), num);
 }
 #endif /* CONFIG_HOTPLUG_CPU */
-
-static int __init topology_init(void)
-{
-	int i;
-
-	for_each_present_cpu(i)
-		arch_register_cpu(i);
-
-	return 0;
-}
-subsys_initcall(topology_init);
-- 
2.39.2

