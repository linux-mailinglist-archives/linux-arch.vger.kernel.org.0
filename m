Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4779EE71
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjIMQjC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjIMQjB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:39:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C20519B1;
        Wed, 13 Sep 2023 09:38:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4588CC15;
        Wed, 13 Sep 2023 09:39:34 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A6263F5A1;
        Wed, 13 Sep 2023 09:38:55 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 02/35] drivers: base: Use present CPUs in GENERIC_CPU_DEVICES
Date:   Wed, 13 Sep 2023 16:37:50 +0000
Message-Id: <20230913163823.7880-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Three of the five ACPI architectures create sysfs entries using
register_cpu() for present CPUs, whereas arm64, riscv and all
GENERIC_CPU_DEVICES do this for possible CPUs.

Registering a CPU is what causes them to show up in sysfs.

It makes very little sense to register all possible CPUs. Registering
a CPU is what triggers the udev notifications allowing user-space to
react to newly added CPUs.

To allow all five ACPI architectures to use GENERIC_CPU_DEVICES, change
it to use for_each_present_cpu(). Making the ACPI architectures use
GENERIC_CPU_DEVICES is a pre-requisite step to centralise their
cpu_register() logic, before moving it into the ACPI processor driver.
When ACPI is disabled this work would be done by
cpu_dev_register_generic().

Of the ACPI architectures that register possible CPUs, arm64 and riscv
do not support making possible CPUs present as they use the weak 'always
fails' version of arch_register_cpu().

Only two of the eight architectures that use GENERIC_CPU_DEVICES have a
distinction between present and possible CPUs.

The following architectures use GENERIC_CPU_DEVICES but are not SMP,
so possible == present:
 * m68k
 * microblaze
 * nios2

The following architectures use GENERIC_CPU_DEVICES and consider
possible == present:
 * csky: setup_smp()
 * parisc: smp_prepare_boot_cpu() marks the boot cpu as present,
   processor_probe() sets possible for all CPUs and present for all CPUs
   except the boot cpu.

um appears to be a subarchitecture of x86.

The remaining architecture using GENERIC_CPU_DEVICES are:
 * openrisc and hexagon:
   where smp_init_cpus() makes all CPUs < NR_CPUS possible,
   whereas smp_prepare_cpus() only makes CPUs < setup_max_cpus present.

After this change, openrisc and hexagon systems that use the max_cpus
command line argument would not see the other CPUs present in sysfs.
This should not be a problem as these CPUs can't bre brought online as
_cpu_up() checks cpu_present().

After this change, only CPUs which are present appear in sysfs.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/base/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 9ea22e165acd..34b48f660b6b 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -533,7 +533,7 @@ static void __init cpu_dev_register_generic(void)
 #ifdef CONFIG_GENERIC_CPU_DEVICES
 	int i;
 
-	for_each_possible_cpu(i) {
+	for_each_present_cpu(i) {
 		if (register_cpu(&per_cpu(cpu_devices, i), i))
 			panic("Failed to register CPU device");
 	}
-- 
2.39.2

