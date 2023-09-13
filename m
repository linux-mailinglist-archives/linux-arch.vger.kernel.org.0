Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE6179EE79
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjIMQjL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjIMQjJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:39:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A964198B;
        Wed, 13 Sep 2023 09:39:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 437381FB;
        Wed, 13 Sep 2023 09:39:42 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47F8C3F5A1;
        Wed, 13 Sep 2023 09:39:03 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 06/35] arm64: setup: Switch over to GENERIC_CPU_DEVICES using arch_register_cpu()
Date:   Wed, 13 Sep 2023 16:37:54 +0000
Message-Id: <20230913163823.7880-7-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To allow ACPI's _STA value to hide CPUs that are present, but not
available to online right now due to VMM or firmware policy, the
register_cpu() call needs to be made by the ACPI machinery when ACPI
is in use. This allows it to hide CPUs that are unavailable from sysfs.

Switching to GENERIC_CPU_DEVICES is an intermediate step to allow all
five ACPI architectures to be modified at once.

Switch over to GENERIC_CPU_DEVICES, and provide an arch_register_cpu()
that populates the hotpluggable flag. arch_register_cpu() is also the
interface the ACPI machinery expects.

The struct cpu in struct cpuinfo_arm64 is never used directly, remove
it to use the one GENERIC_CPU_DEVICES provides.

This changes the CPUs visible in sysfs from possible to present, but
on arm64 smp_prepare_cpus() ensures these are the same.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/cpu.h |  1 -
 arch/arm64/kernel/setup.c    | 13 ++++---------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b10515c0200b..7b3990abf87a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -132,6 +132,7 @@ config ARM64
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index e749838b9c5d..887bd0d992bb 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -38,7 +38,6 @@ struct cpuinfo_32bit {
 };
 
 struct cpuinfo_arm64 {
-	struct cpu	cpu;
 	struct kobject	kobj;
 	u64		reg_ctr;
 	u64		reg_cntfrq;
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 417a8a86b2db..165bd2c0dd5a 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -402,19 +402,14 @@ static inline bool cpu_can_disable(unsigned int cpu)
 	return false;
 }
 
-static int __init topology_init(void)
+int arch_register_cpu(int num)
 {
-	int i;
+	struct cpu *cpu = &per_cpu(cpu_devices, num);
 
-	for_each_possible_cpu(i) {
-		struct cpu *cpu = &per_cpu(cpu_data.cpu, i);
-		cpu->hotpluggable = cpu_can_disable(i);
-		register_cpu(cpu, i);
-	}
+	cpu->hotpluggable = cpu_can_disable(num);
 
-	return 0;
+	return register_cpu(cpu, num);
 }
-subsys_initcall(topology_init);
 
 static void dump_kernel_offset(void)
 {
-- 
2.39.2

