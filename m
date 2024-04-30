Return-Path: <linux-arch+bounces-4078-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B38B79B0
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B89728701E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9391802A7;
	Tue, 30 Apr 2024 14:27:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9217332A;
	Tue, 30 Apr 2024 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487264; cv=none; b=hxgeBzPSr1IKoSx8GSUglOg70Fqmu1It3di59yCyr31Bc1qaG97XM62gwNv1U11s5n8LejZiKi34TeYdUUcNtXwGU0gfcYf2Diua2pP7knyJy7P/9dd3z0hhVT8Thw21blaQZSBq6wu92ie+G1IK/CWqhr2Q04Tx2Z5YwI9T4Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487264; c=relaxed/simple;
	bh=QFBDRYQGiPf2dW9lDb7IqEdBA7uyiyQh2PJe9eZc8ZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbmTrZ4VEmj1nTpIEAzMyPPVEks+5POMn84vY/XoYrYvV+edmVoFHtrsXAr5VGFc+1nJAVo1C3Lg472nuRMgmRC6KFOW0vPpvz0Vsfc8fUuAKnRLmXG+u1NMO8uQFy4y7lvoQgE3VPPUHL740yVVR+qlJQDaG0zUmdkFlHCbukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTMsq4Bwkz6GD3R;
	Tue, 30 Apr 2024 22:25:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D3976140A30;
	Tue, 30 Apr 2024 22:27:40 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 15:27:40 +0100
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
	<maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Gavin Shan
	<gshan@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v9 06/19] ACPI: processor: Move checks and availability of acpi_processor earlier
Date: Tue, 30 Apr 2024 15:24:21 +0100
Message-ID: <20240430142434.10471-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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
v9: Add back a blank line accidentally removed in code move.
    Fix up error returns so that the new cleanup in processor_add()
    is triggered on detection of the bios bug.
    Combined with the previous 2 patches, should solve the leak
    that Gavin identified.
---
 drivers/acpi/acpi_processor.c | 80 +++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 16e36e55a560..4a79b42d649e 100644
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
+
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
 
@@ -198,8 +228,16 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	if (ret)
 		goto out;
 
+	if (!acpi_processor_set_per_cpu(pr, device)) {
+		ret = -EINVAL;
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
@@ -217,7 +255,8 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	return ret;
 }
 #else
-static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
+static inline int acpi_processor_hotadd_init(struct acpi_processor *pr,
+					     struct acpi_device *device)
 {
 	return -ENODEV;
 }
@@ -316,10 +355,13 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  because cpuid <-> apicid mapping is persistent now.
 	 */
 	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
-		int ret = acpi_processor_hotadd_init(pr);
+		int ret = acpi_processor_hotadd_init(pr, device);
 
 		if (ret)
 			return ret;
+	} else {
+		if (!acpi_processor_set_per_cpu(pr, device))
+			return -EINVAL;
 	}
 
 	/*
@@ -365,8 +407,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
  * (cpu_data(cpu)) values, like CPU feature flags, family, model, etc.
  * Such things have to be put in and set up by the processor driver's .probe().
  */
-static DEFINE_PER_CPU(void *, processor_device_array);
-
 static int acpi_processor_add(struct acpi_device *device,
 					const struct acpi_device_id *id)
 {
@@ -395,28 +435,6 @@ static int acpi_processor_add(struct acpi_device *device,
 	if (result) /* Processor is not physically present or unavailable */
 		goto err_clear_driver_data;
 
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
-		goto err_clear_driver_data;
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
@@ -470,10 +488,6 @@ static void acpi_processor_remove(struct acpi_device *device)
 	device_release_driver(pr->dev);
 	acpi_unbind_one(pr->dev);
 
-	/* Clean up. */
-	per_cpu(processor_device_array, pr->id) = NULL;
-	per_cpu(processors, pr->id) = NULL;
-
 	cpu_maps_update_begin();
 	cpus_write_lock();
 
@@ -481,6 +495,10 @@ static void acpi_processor_remove(struct acpi_device *device)
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


