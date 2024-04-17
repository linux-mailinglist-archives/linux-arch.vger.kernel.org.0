Return-Path: <linux-arch+bounces-3747-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E148A8445
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 15:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C63B2277D
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F37F13F00A;
	Wed, 17 Apr 2024 13:21:17 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C913DDA0;
	Wed, 17 Apr 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360077; cv=none; b=EEbUAvb4cHl66Pzyyx8dJiHqBmvWyw0ITW5Ck0ZDgesp5DPpInqRkPqrsA3ffea9ciVOs6WGd2zPyGyhZgBljv2Zz/+zuWZWd2NxrOLNZ0G8z916Rt6ei5ibIKAayO2qLeduRoK0LiGZirf5KMUNv7iujTaXs6pk6FMiCIGeL8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360077; c=relaxed/simple;
	bh=po6Hc5e1p+MvPE/nWcSH1E+iwLSt7JRmOnwakjjl7jE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIxXbgyZMIH2WIRiOjUy9ShDdyg1vaZAo0Vqn8cu2H7DAaaQy6Fb1aKkEk7WF0tIO2Tfcit2TF6pUpMGHKTXfDN5fmPBU6Q0IuzCDB5zU6MiZv4CvhvOyZyHxERgFq8h+wc4MMDYx0EYXW3wYXTnWeKZbJNrmQoi9wScarhl9xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKLyR2Xwrz6K7JW;
	Wed, 17 Apr 2024 21:16:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 660BC140CF4;
	Wed, 17 Apr 2024 21:21:13 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 14:21:12 +0100
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
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v6 04/16] ACPI: processor: Move checks and availability of acpi_processor earlier
Date: Wed, 17 Apr 2024 14:18:57 +0100
Message-ID: <20240417131909.7925-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Make the per_cpu(processors, cpu) entries available earlier so that
they are available in arch_register_cpu() as ARM64 will need access
to the acpi_handle to distinguish between acpi_processor_add()
and earlier registration attempts (which will fail as _STA cannot
be checked).

Reorder the remove flow to clear this per_cpu() after
arch_unregister_cpu() has completed, allowing it to be used in
there as well.

Note that on x86 for the CPU hotplug case, the pr->id prior to
acpi_map_cpu() may be invalid. Thus the per_cpu() structures
must be initialized after that call or after checking the ID
is valid (not hotplug path).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v6: As per discussion in v5 thread, don't use the cpu->dev and
    make this data available earlier by moving the assignment checks
    int acpi_processor_get_info().
---
 drivers/acpi/acpi_processor.c | 79 +++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index ba0a6f0ac841..2c164451ab53 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -184,7 +184,35 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 
 /* Initialization */
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
-static int acpi_processor_hotadd_init(struct acpi_processor *pr)
+static DEFINE_PER_CPU(void *, processor_device_array);
+
+static void acpi_processor_set_per_cpu(struct acpi_processor *pr,
+				       struct acpi_device *device)
+{
+	BUG_ON(pr->id >= nr_cpu_ids);
+	/*
+	 * Buggy BIOS check.
+	 * ACPI id of processors can be reported wrongly by the BIOS.
+	 * Don't trust it blindly
+	 */
+	if (per_cpu(processor_device_array, pr->id) != NULL &&
+	    per_cpu(processor_device_array, pr->id) != device) {
+		dev_warn(&device->dev,
+			 "BIOS reported wrong ACPI id %d for the processor\n",
+			 pr->id);
+		/* Give up, but do not abort the namespace scan. */
+		return;
+	}
+	/*
+	 * processor_device_array is not cleared on errors to allow buggy BIOS
+	 * checks.
+	 */
+	per_cpu(processor_device_array, pr->id) = device;
+	per_cpu(processors, pr->id) = pr;
+}
+
+static int acpi_processor_hotadd_init(struct acpi_processor *pr,
+				      struct acpi_device *device)
 {
 	int ret;
 
@@ -198,6 +226,8 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	if (ret)
 		goto out;
 
+	acpi_processor_set_per_cpu(pr, device);
+
 	ret = arch_register_cpu(pr->id);
 	if (ret) {
 		acpi_unmap_cpu(pr->id);
@@ -217,7 +247,8 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	return ret;
 }
 #else
-static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
+static inline int acpi_processor_hotadd_init(struct acpi_processor *pr,
+					     struct acpi_device *device)
 {
 	return -ENODEV;
 }
@@ -232,6 +263,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	acpi_status status = AE_OK;
 	static int cpu0_initialized;
 	unsigned long long value;
+	int ret;
 
 	acpi_processor_errata();
 
@@ -316,10 +348,12 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  because cpuid <-> apicid mapping is persistent now.
 	 */
 	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
-		int ret = acpi_processor_hotadd_init(pr);
+		ret = acpi_processor_hotadd_init(pr, device);
 
 		if (ret)
-			return ret;
+			goto err;
+	} else {
+		acpi_processor_set_per_cpu(pr, device);
 	}
 
 	/*
@@ -357,6 +391,10 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		arch_fix_phys_package_id(pr->id, value);
 
 	return 0;
+
+err:
+	per_cpu(processors, pr->id) = NULL;
+	return ret;
 }
 
 /*
@@ -365,8 +403,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
  * (cpu_data(cpu)) values, like CPU feature flags, family, model, etc.
  * Such things have to be put in and set up by the processor driver's .probe().
  */
-static DEFINE_PER_CPU(void *, processor_device_array);
-
 static int acpi_processor_add(struct acpi_device *device,
 					const struct acpi_device_id *id)
 {
@@ -395,28 +431,6 @@ static int acpi_processor_add(struct acpi_device *device,
 	if (result) /* Processor is not physically present or unavailable */
 		return 0;
 
-	BUG_ON(pr->id >= nr_cpu_ids);
-
-	/*
-	 * Buggy BIOS check.
-	 * ACPI id of processors can be reported wrongly by the BIOS.
-	 * Don't trust it blindly
-	 */
-	if (per_cpu(processor_device_array, pr->id) != NULL &&
-	    per_cpu(processor_device_array, pr->id) != device) {
-		dev_warn(&device->dev,
-			"BIOS reported wrong ACPI id %d for the processor\n",
-			pr->id);
-		/* Give up, but do not abort the namespace scan. */
-		goto err;
-	}
-	/*
-	 * processor_device_array is not cleared on errors to allow buggy BIOS
-	 * checks.
-	 */
-	per_cpu(processor_device_array, pr->id) = device;
-	per_cpu(processors, pr->id) = pr;
-
 	dev = get_cpu_device(pr->id);
 	if (!dev) {
 		result = -ENODEV;
@@ -469,15 +483,16 @@ static void acpi_processor_remove(struct acpi_device *device)
 	device_release_driver(pr->dev);
 	acpi_unbind_one(pr->dev);
 
-	/* Clean up. */
-	per_cpu(processor_device_array, pr->id) = NULL;
-	per_cpu(processors, pr->id) = NULL;
-
 	cpu_maps_update_begin();
 	cpus_write_lock();
 
 	/* Remove the CPU. */
 	arch_unregister_cpu(pr->id);
+
+	/* Clean up. */
+	per_cpu(processor_device_array, pr->id) = NULL;
+	per_cpu(processors, pr->id) = NULL;
+
 	acpi_unmap_cpu(pr->id);
 
 	cpus_write_unlock();
-- 
2.39.2


