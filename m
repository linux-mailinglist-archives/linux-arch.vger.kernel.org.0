Return-Path: <linux-arch+bounces-4008-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EF08B394B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 15:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94AB1C2344A
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF891487F5;
	Fri, 26 Apr 2024 13:58:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF21448E7;
	Fri, 26 Apr 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139892; cv=none; b=K1TtiJY3uzI6pgoDvsXsbzG7fJn0cSerKZ19TayIWj/+TpLS4Uck0vLbvibivP8CGVMPRjL/dIO8bPe3xCgq1QuTNBULyZNqRTG/lSaCJXS27bkEwT9YK4fYH1M4xZawV95nvlOxPnJCzNhaGI0zMOvU4gP4/50BFv7gZGkk4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139892; c=relaxed/simple;
	bh=V9GVilWzfJ+4aTQ/OXX0bRfR8bpous4HD5NWXweavP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgcBVIRDTTU1nqDYjL+oCUZ9Yr572sZo3BfyDCp+cKxowUfPci3uVqIEhhEqhsWJeCJJQBxq0rNpNGNtN099qGpWKP86rMvJM3vXFG4sxTGjOyqW6a5tpWYqOcNVX8HysDEFfh0/q1tibCsbGmwVkYgO0vnRTkSKi0JcZRzjLUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQvPm0qvfz6K6D4;
	Fri, 26 Apr 2024 21:55:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D2289140A70;
	Fri, 26 Apr 2024 21:58:08 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 14:58:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v8 13/16] arm64: arch_register_cpu() variant to check if an ACPI handle is now available.
Date: Fri, 26 Apr 2024 14:51:23 +0100
Message-ID: <20240426135126.12802-14-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

The ARM64 architecture does not support physical CPU HP today.
To avoid any possibility of a bug against such an architecture if defined
in future, check for the physical CPU HP case (not present) and
return an error on any such attempt.

On ARM64 virtual CPU Hotplug relies on the status value that can be
queried via the AML method _STA for the CPU object.

There are two conditions in which the CPU can be registered.
1) ACPI disabled.
2) ACPI enabled and the acpi_handle is available.
   _STA evaluates to the CPU is both enabled and present.
   (Note that in absence of the _STA method they are always in this
    state).

If neither of these conditions is met the CPU is not 'yet' ready
to be used and -EPROBE_DEFER is returned.

Success occurs in the early attempt to register the CPUs if we
are booting with DT (no concept yet of vCPU HP) if not it succeeds
for already enabled CPUs when the ACPI Processor driver attaches to
them.  Finally it may succeed via the CPU Hotplug code indicating that
the CPU is now enabled.

For ACPI if CONFIG_ACPI_PROCESSOR the only path to get to
arch_register_cpu() with that handle set is via
acpi_processor_hot_add_init() which is only called from an ACPI bus
scan in which _STA has already been queried there is no need to
repeat it here. Add a comment to remind us of this in the future.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
V8: No change. (tags collected only)
---
 arch/arm64/kernel/smp.c | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dc0e0b3ec2d4..ccb6ad347df9 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -504,6 +504,59 @@ static int __init smp_cpu_setup(int cpu)
 static bool bootcpu_valid __initdata;
 static unsigned int cpu_count = 1;
 
+int arch_register_cpu(int cpu)
+{
+	acpi_handle acpi_handle = acpi_get_processor_handle(cpu);
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+
+	if (!acpi_disabled && !acpi_handle &&
+	    IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU))
+		return -EPROBE_DEFER;
+
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+	/* For now block anything that looks like physical CPU Hotplug */
+	if (invalid_logical_cpuid(cpu) || !cpu_present(cpu)) {
+		pr_err_once("Changing CPU present bit is not supported\n");
+		return -ENODEV;
+	}
+#endif
+
+	/*
+	 * Availability of the acpi handle is sufficient to establish
+	 * that _STA has aleady been checked. No need to recheck here.
+	 */
+	c->hotpluggable = arch_cpu_is_hotpluggable(cpu);
+
+	return register_cpu(c, cpu);
+}
+
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+void arch_unregister_cpu(int cpu)
+{
+	acpi_handle acpi_handle = acpi_get_processor_handle(cpu);
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+	acpi_status status;
+	unsigned long long sta;
+
+	if (!acpi_handle) {
+		pr_err_once("Removing a CPU without associated ACPI handle\n");
+		return;
+	}
+
+	status = acpi_evaluate_integer(acpi_handle, "_STA", NULL, &sta);
+	if (ACPI_FAILURE(status))
+		return;
+
+	/* For now do not allow anything that looks like physical CPU HP */
+	if (cpu_present(cpu) && !(sta & ACPI_STA_DEVICE_PRESENT)) {
+		pr_err_once("Changing CPU present bit is not supported\n");
+		return;
+	}
+
+	unregister_cpu(c);
+}
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+
 #ifdef CONFIG_ACPI
 static struct acpi_madt_generic_interrupt cpu_madt_gicc[NR_CPUS];
 
-- 
2.39.2


