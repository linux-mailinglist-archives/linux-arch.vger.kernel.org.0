Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF40B689A66
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 14:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjBCNy1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 08:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjBCNxg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 08:53:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 246E0A2A67;
        Fri,  3 Feb 2023 05:52:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 627A415DB;
        Fri,  3 Feb 2023 05:53:17 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9523C3F71E;
        Fri,  3 Feb 2023 05:52:31 -0800 (PST)
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
Subject: [RFC PATCH 10/32] arch_topology: Make register_cpu_capacity_sysctl() tolerant to late CPUs
Date:   Fri,  3 Feb 2023 13:50:21 +0000
Message-Id: <20230203135043.409192-11-james.morse@arm.com>
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

register_cpu_capacity_sysctl() adds a property to sysfs that describes
the CPUs capacity. This is done from a subsys_initcall() that assumes
all possible CPUs are registered.

With CPU hotplug, possible CPUs aren't registered until they become
present, (or for arm64 enabled). This leads to messages during boot:
| register_cpu_capacity_sysctl: too early to get CPU1 device!
and once these CPUs are added to the system, the file is missing.

Move this to a cpuhp callback, so that the file is created once
CPUs are brought online. This covers CPUs that are added late by
mechanisms like hotplug.
One observable difference is the file is now missing for offline CPUs.

Signed-off-by: James Morse <james.morse@arm.com>
---
If the offline CPUs thing is a problem for the tools that consume
this value, we'd need to move cpu_capacity to be part of cpu.c's
common_cpu_attr_groups.
---
 drivers/base/arch_topology.c | 38 ++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7d6e6657ffa..83a46bc3105d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -220,20 +220,34 @@ static DECLARE_WORK(update_topology_flags_work, update_topology_flags_workfn);
 
 static DEVICE_ATTR_RO(cpu_capacity);
 
+static int cpu_capacity_sysctl_add(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	if (!cpu_dev)
+		return -ENOENT;
+
+	device_create_file(cpu_dev, &dev_attr_cpu_capacity);
+
+	return 0;
+}
+
+static int cpu_capacity_sysctl_remove(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	if (!cpu_dev)
+		return -ENOENT;
+
+	device_remove_file(cpu_dev, &dev_attr_cpu_capacity);
+
+	return 0;
+}
+
 static int register_cpu_capacity_sysctl(void)
 {
-	int i;
-	struct device *cpu;
-
-	for_each_possible_cpu(i) {
-		cpu = get_cpu_device(i);
-		if (!cpu) {
-			pr_err("%s: too early to get CPU%d device!\n",
-			       __func__, i);
-			continue;
-		}
-		device_create_file(cpu, &dev_attr_cpu_capacity);
-	}
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "topology/cpu-capacity",
+			  cpu_capacity_sysctl_add, cpu_capacity_sysctl_remove);
 
 	return 0;
 }
-- 
2.30.2

