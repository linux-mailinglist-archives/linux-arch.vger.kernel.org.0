Return-Path: <linux-arch+bounces-3793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E6C8A9BCB
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437C21F23FD3
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B2F1635C3;
	Thu, 18 Apr 2024 13:56:20 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139EB161900;
	Thu, 18 Apr 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448580; cv=none; b=G2gJtX7YXE4F+WVzzOFHYaQec2HWzVxEhWaY32nVak8CHUKaqQVqnXqkdDUs5AVVmtGC+kYE/itP/SO88P0x5ia+h0uZVB0D/d49U/LOAVkfgBhVJ1gyp+lyJMRVotUp89xETNg69x9thfkUzM8+Df1d3zU3o/nB6/p9CI9X9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448580; c=relaxed/simple;
	bh=5RgsOScvkUjas7kOIZs8AaBnCXl2yaDDWXRqeR1JYww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIq/7hMTJuwd7fS2X1g9VokImXLtdldNCzBcvLlU7cwKU4DK1md+YwpQuKZmOvI7Tl7emDhs6d3UcdMc60Esb3LHyDNJpzkn/I49yfswmyw6af7dWPQlqzwTkfmeAu5tLY+OVUArW3Y/kjAMlDYWGzNV97sbFZLl4MoDyO4tKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKzlp0kLHz6D8yY;
	Thu, 18 Apr 2024 21:54:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D8522140B55;
	Thu, 18 Apr 2024 21:56:16 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 14:56:16 +0100
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
Subject: [PATCH v7 04/16] ACPI: processor: Move checks and availability of acpi_processor earlier
Date: Thu, 18 Apr 2024 14:54:00 +0100
Message-ID: <20240418135412.14730-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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
v7: Swap order with acpi_unmap_cpu() in acpi_processor_remove()
    to keep it in reverse order of the setup path. (thanks Salil)
    Fix an issue with placement of CONFIG_ACPI_HOTPLUG_CPU guards.
v6: As per discussion in v5 thread, don't use the cpu->dev and
    make this data available earlier by moving the assignment checks
    int acpi_processor_get_info().
---
 drivers/acpi/acpi_processor.c | 78 +++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index ba0a6f0ac841..ac7ddb30f10e 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -183,8 +183,36 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 #endif /* CONFIG_X86 */
 
 /* Initialization */
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
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
-static int acpi_processor_hotadd_init(struct acpi_processor *pr)
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
@@ -469,10 +483,6 @@ static void acpi_processor_remove(struct acpi_device *device)
 	device_release_driver(pr->dev);
 	acpi_unbind_one(pr->dev);
 
-	/* Clean up. */
-	per_cpu(processor_device_array, pr->id) = NULL;
-	per_cpu(processors, pr->id) = NULL;
-
 	cpu_maps_update_begin();
 	cpus_write_lock();
 
@@ -480,6 +490,10 @@ static void acpi_processor_remove(struct acpi_device *device)
 	arch_unregister_cpu(pr->id);
 	acpi_unmap_cpu(pr->id);
 
+	/* Clean up. */
+	per_cpu(processor_device_array, pr->id) = NULL;
+	per_cpu(processors, pr->id) = NULL;
+
 	cpus_write_unlock();
 	cpu_maps_update_done();
 
-- 
2.39.2


