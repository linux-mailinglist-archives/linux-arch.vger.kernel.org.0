Return-Path: <linux-arch+bounces-3637-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9298A312A
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 16:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4CBB26776
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216CF14388E;
	Fri, 12 Apr 2024 14:45:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7C142E97;
	Fri, 12 Apr 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933101; cv=none; b=tabs24PG2aJa70W7OuCEEeHo0aXvkjEFkeRzaQBgB+sgjoLMVI5O8iDyQsLmcDFs30HwUV+pbnAGSwraMRLrR5J5Dubdsb808DgPOUrQl+aRpiKd48pW9FegMfIvaWF3GNBIC6c6ljsiJbj+8Y2cTUZkMQy94n9Mb9RY4HH+x60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933101; c=relaxed/simple;
	bh=zPPqCIBLFIrD7nGYgb70z0Tk7OlI8MxKknjXzceK0ss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fj+ohnbQ+FUc5wtSRQvcFO0UB6+XwsMiXiWIVtMusvDvt2N9GckTh82cpnFjbkROukoljLS3MqAXciVk6d6p7+jaYw3OOf0TdkPWgszVSug6713O91W6eilDmRYHSJRg7bKoK23zUQwBQbNodWEM4upp+WUoeHf80SeQYP4u9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGK74578bz6J6Xr;
	Fri, 12 Apr 2024 22:43:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B48B1402CD;
	Fri, 12 Apr 2024 22:44:57 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 15:44:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, Miguel
 Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: <linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v5 15/18] arm64: arch_register_cpu() variant to allow checking of ACPI _STA
Date: Fri, 12 Apr 2024 15:37:16 +0100
Message-ID: <20240412143719.11398-16-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On ARM64 virtual CPU Hotplug relies on the status value that can be
queried via the AML method _STA for the CPU object.

There are two conditions in which the CPU can be registered.
1) ACPI disabled.
2) ACPI enabled and the acpi_handle is available.
   _STA evaluates to the CPU is both enabled and present.
   (Note that in absences of the _STA method they are always in this
    state).

If neither of these conditions is met the CPU is not 'yet' ready
to be used and -EPROBE_DEFER is returned.

Success occurs in the early attempt to register the CPUs if we
are booting with DT (no concept yet of vCPU HP) if not it succeeds
for already enabled CPUs when the ACPI Processor driver attaches to
them.  Finally it may succeed via the CPU Hotplug code indicating that
the CPU is now enabled.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v5: New patch.
---
 arch/arm64/kernel/smp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dc0e0b3ec2d4..68f2e7974815 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -504,6 +504,26 @@ static int __init smp_cpu_setup(int cpu)
 static bool bootcpu_valid __initdata;
 static unsigned int cpu_count = 1;
 
+int arch_register_cpu(int cpu)
+{
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+	acpi_handle acpi_handle = ACPI_HANDLE(&c->dev);
+	int ret;
+
+	if (!acpi_disabled && !acpi_handle)
+		return -EPROBE_DEFER;
+	if (acpi_handle) {
+		ret = acpi_sta_enabled(acpi_handle);
+		if (ret) {
+			/* Not enabled */
+			return ret;
+		}
+	}
+	c->hotpluggable = arch_cpu_is_hotpluggable(cpu);
+
+	return register_cpu(c, cpu);
+}
+
 #ifdef CONFIG_ACPI
 static struct acpi_madt_generic_interrupt cpu_madt_gicc[NR_CPUS];
 
-- 
2.39.2


