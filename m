Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC63E79EE97
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjIMQjk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjIMQjZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:39:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F6151BF0;
        Wed, 13 Sep 2023 09:39:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4008E1007;
        Wed, 13 Sep 2023 09:39:48 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 459803F5A1;
        Wed, 13 Sep 2023 09:39:09 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 09/35] LoongArch: Switch over to GENERIC_CPU_DEVICES
Date:   Wed, 13 Sep 2023 16:37:57 +0000
Message-Id: <20230913163823.7880-10-james.morse@arm.com>
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

This allows topology_init() to be removed.

This is an intermediate step to the logic being moved to drivers/acpi,
where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/loongarch/Kconfig           |  1 +
 arch/loongarch/kernel/topology.c | 29 ++---------------------------
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 2bddd202470e..5bed51adc68c 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -72,6 +72,7 @@ config LOONGARCH
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_DEVICES
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_IOREMAP if !ARCH_IOREMAP
diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
index caa7cd859078..8e4441c1ff39 100644
--- a/arch/loongarch/kernel/topology.c
+++ b/arch/loongarch/kernel/topology.c
@@ -7,20 +7,13 @@
 #include <linux/percpu.h>
 #include <asm/bootinfo.h>
 
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
-
 #ifdef CONFIG_HOTPLUG_CPU
 int arch_register_cpu(int cpu)
 {
-	int ret;
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 
-	c->hotpluggable = 1;
-	ret = register_cpu(c, cpu);
-	if (ret < 0)
-		pr_warn("register_cpu %d failed (%d)\n", cpu, ret);
-
-	return ret;
+	c->hotpluggable = !io_master(cpu);
+	return register_cpu(c, cpu);
 }
 EXPORT_SYMBOL(arch_register_cpu);
 
@@ -33,21 +26,3 @@ void arch_unregister_cpu(int cpu)
 }
 EXPORT_SYMBOL(arch_unregister_cpu);
 #endif
-
-static int __init topology_init(void)
-{
-	int i, ret;
-
-	for_each_present_cpu(i) {
-		struct cpu *c = &per_cpu(cpu_devices, i);
-
-		c->hotpluggable = !io_master(i);
-		ret = register_cpu(c, i);
-		if (ret < 0)
-			pr_warn("topology_init: register_cpu %d failed (%d)\n", i, ret);
-	}
-
-	return 0;
-}
-
-subsys_initcall(topology_init);
-- 
2.39.2

