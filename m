Return-Path: <linux-arch+bounces-3999-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1008B3905
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 15:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D7F2876BD
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F9C1487D5;
	Fri, 26 Apr 2024 13:53:33 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3A140389;
	Fri, 26 Apr 2024 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139613; cv=none; b=ayMyOdTTJXGwIyCT1XSGOGk7xw1P5VhM98awaNg/QGaEkeTaKO85QfeIhDwLmzT8gMwBPCFcrWwusnV69qJBYKYc1DyPEzf+2TfM7acoz1zqoiKxmZqFtHeSFQ7kkVwtPE1fw2CweP7v6PbrcYchqsQKURGy9LBrMgutt8n4p7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139613; c=relaxed/simple;
	bh=L4AJqhcz4JyUcgl/balbPTr8ZkFOqiMjxbdfQ3jG8+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WND2S3qIGj+3JXo3SvfmWq9/Swfq6Z1TWg3AImwt7K1nbAKb3eINk3gNvh34sEdEPVRMnbq1ixMENkOL0EMIkLAk+c/fOV+AEinIp8uVR9o9CKBHwyRdoW/i39XjTD/UjbtfGV0qrJ8yZLzzEDm59XGCUB0Fdj22CU3YhGWm/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQvM13cXQz6DB7r;
	Fri, 26 Apr 2024 21:53:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BC9D140C72;
	Fri, 26 Apr 2024 21:53:29 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 14:53:28 +0100
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
Subject: [PATCH v8 04/16] ACPI: processor: Move checks and availability of acpi_processor earlier
Date: Fri, 26 Apr 2024 14:51:14 +0100
Message-ID: <20240426135126.12802-5-Jonathan.Cameron@huawei.com>
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
v8: On buggy bios detection when setting per_cpu structures
    do not carry on.
    Fix up the clearing of per cpu structures to remove unwanted
    side effects and ensure an error code isn't use to reference them.
---
 drivers/acpi/acpi_processor.c | 79 +++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index ba0a6f0ac841..3b180e21f325 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -183,8 +183,38 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 #endif /* CONFIG_X86 */
 
 /* Initialization */
+static DEFINE_PER_CPU(void *, processor_device_array);
+
+static bool acpi_processor_set_per_cpu(struct acpi_processor *pr,
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
+		return false;
+	}
+	/*
+	 * processor_device_array is not cleared on errors to allow buggy BIOS
+	 * checks.
+	 */
+	per_cpu(processor_device_array, pr->id) = device;
+	per_cpu(processors, pr->id) = pr;
+
+	return true;
+}
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
-static int acpi_processor_hotadd_init(struct acpi_processor *pr)
+static int acpi_processor_hotadd_init(struct acpi_processor *pr,
+				      struct acpi_device *device)
 {
 	int ret;
 
@@ -198,8 +228,15 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	if (ret)
 		goto out;
 
+	if (!acpi_processor_set_per_cpu(pr, device)) {
+		acpi_unmap_cpu(pr->id);
+		goto out;
+	}
+
 	ret = arch_register_cpu(pr->id);
 	if (ret) {
+		/* Leave the processor device array in place to detect buggy bios */
+		per_cpu(processors, pr->id) = NULL;
 		acpi_unmap_cpu(pr->id);
 		goto out;
 	}
@@ -217,7 +254,8 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	return ret;
 }
 #else
-static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
+static inline int acpi_processor_hotadd_init(struct acpi_processor *pr,
+					     struct acpi_device *device)
 {
 	return -ENODEV;
 }
@@ -316,10 +354,13 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  because cpuid <-> apicid mapping is persistent now.
 	 */
 	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
-		int ret = acpi_processor_hotadd_init(pr);
+		int ret = acpi_processor_hotadd_init(pr, device);
 
 		if (ret)
 			return ret;
+	} else {
+		if (!acpi_processor_set_per_cpu(pr, device))
+			return 0;
 	}
 
 	/*
@@ -365,8 +406,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
  * (cpu_data(cpu)) values, like CPU feature flags, family, model, etc.
  * Such things have to be put in and set up by the processor driver's .probe().
  */
-static DEFINE_PER_CPU(void *, processor_device_array);
-
 static int acpi_processor_add(struct acpi_device *device,
 					const struct acpi_device_id *id)
 {
@@ -395,28 +434,6 @@ static int acpi_processor_add(struct acpi_device *device,
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
@@ -469,10 +486,6 @@ static void acpi_processor_remove(struct acpi_device *device)
 	device_release_driver(pr->dev);
 	acpi_unbind_one(pr->dev);
 
-	/* Clean up. */
-	per_cpu(processor_device_array, pr->id) = NULL;
-	per_cpu(processors, pr->id) = NULL;
-
 	cpu_maps_update_begin();
 	cpus_write_lock();
 
@@ -480,6 +493,10 @@ static void acpi_processor_remove(struct acpi_device *device)
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


