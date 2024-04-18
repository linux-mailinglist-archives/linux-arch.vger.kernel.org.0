Return-Path: <linux-arch+bounces-3790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04468A9BBA
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 15:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB1B1C2324A
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B031649CC;
	Thu, 18 Apr 2024 13:54:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709771635D0;
	Thu, 18 Apr 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448490; cv=none; b=TWt7gjoeEtVpnheDGA0emMbEP39/soqxvY+YyWY7Q6hh314mutbfL7pnA/pj8wS/SkGHyCxWsNY+5CUe4ivkSvNHtirfvpl3qiT/dNZa0V2wW13CbrAK8ud+6OSM9YzVjDvJmKWy1jCd0gavvFgNzzNVk31v8pQpBSI7ANuMmFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448490; c=relaxed/simple;
	bh=paN2ZGFym5I7Te0qPjdv46j8+ois1fpA2WR9szVVfgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8uaS41yO/XAD5BBZF/UOtsG+O95/GIGy66ybDzaGWk20bN1WEHmgfPbZVl20k0i8dBql9qneHqCNqJ3Boo21RTqj69H08UzL8L/xaQlxG3SWwvsbBcn33k29hM5WKwkIV/8HTPn77UdBLFONHWurPBsyPHioLZM1i/YXsYyitY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKzfd3DFCz6K7SP;
	Thu, 18 Apr 2024 21:49:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 95891140519;
	Thu, 18 Apr 2024 21:54:44 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 14:54:43 +0100
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
Subject: [PATCH v7 01/16] ACPI: processor: Simplify initial onlining to use same path for cold and hotplug
Date: Thu, 18 Apr 2024 14:53:57 +0100
Message-ID: <20240418135412.14730-2-Jonathan.Cameron@huawei.com>
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

Separate code paths, combined with a flag set in acpi_processor.c to
indicate a struct acpi_processor was for a hotplugged CPU ensured that
per CPU data was only set up the first time that a CPU was initialized.
This appears to be unnecessary as the paths can be combined by letting
the online logic also handle any CPUs online at the time of driver load.

Motivation for this change, beyond simplification, is that ARM64
virtual CPU HP uses the same code paths for hotplug and cold path in
acpi_processor.c so had no easy way to set the flag for hotplug only.
Removing this necessity will enable ARM64 vCPU HP to reuse the existing
code paths.

Leave noisy pr_info() in place but update it to not state the CPU
was hotplugged.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v7: No change.
v6: New patch.
RFT: I have very limited test resources for x86 and other
architectures that may be affected by this change.
---
 drivers/acpi/acpi_processor.c   |  1 -
 drivers/acpi/processor_driver.c | 44 ++++++++++-----------------------
 include/acpi/processor.h        |  2 +-
 3 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7a0dd35d62c9..7fc924aeeed0 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -216,7 +216,6 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	 * gets online for the first time.
 	 */
 	pr_info("CPU%d has been hot-added\n", pr->id);
-	pr->flags.need_hotplug_init = 1;
 
 out:
 	cpus_write_unlock();
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 67db60eda370..55782eac3ff1 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -33,7 +33,6 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Processor Driver");
 MODULE_LICENSE("GPL");
 
-static int acpi_processor_start(struct device *dev);
 static int acpi_processor_stop(struct device *dev);
 
 static const struct acpi_device_id processor_device_ids[] = {
@@ -47,7 +46,6 @@ static struct device_driver acpi_processor_driver = {
 	.name = "processor",
 	.bus = &cpu_subsys,
 	.acpi_match_table = processor_device_ids,
-	.probe = acpi_processor_start,
 	.remove = acpi_processor_stop,
 };
 
@@ -115,12 +113,10 @@ static int acpi_soft_cpu_online(unsigned int cpu)
 	 * CPU got physically hotplugged and onlined for the first time:
 	 * Initialize missing things.
 	 */
-	if (pr->flags.need_hotplug_init) {
+	if (!pr->flags.previously_online) {
 		int ret;
 
-		pr_info("Will online and init hotplugged CPU: %d\n",
-			pr->id);
-		pr->flags.need_hotplug_init = 0;
+		pr_info("Will online and init CPU: %d\n", pr->id);
 		ret = __acpi_processor_start(device);
 		WARN(ret, "Failed to start CPU: %d\n", pr->id);
 	} else {
@@ -167,9 +163,6 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (!pr)
 		return -ENODEV;
 
-	if (pr->flags.need_hotplug_init)
-		return 0;
-
 	result = acpi_cppc_processor_probe(pr);
 	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
 		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
@@ -185,32 +178,21 @@ static int __acpi_processor_start(struct acpi_device *device)
 
 	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
 					     acpi_processor_notify, device);
-	if (ACPI_SUCCESS(status))
-		return 0;
+	if (!ACPI_SUCCESS(status)) {
+		result = -ENODEV;
+		goto err_thermal_exit;
+	}
+	pr->flags.previously_online = 1;
 
-	result = -ENODEV;
-	acpi_processor_thermal_exit(pr, device);
+	return 0;
 
+err_thermal_exit:
+	acpi_processor_thermal_exit(pr, device);
 err_power_exit:
 	acpi_processor_power_exit(pr);
 	return result;
 }
 
-static int acpi_processor_start(struct device *dev)
-{
-	struct acpi_device *device = ACPI_COMPANION(dev);
-	int ret;
-
-	if (!device)
-		return -ENODEV;
-
-	/* Protect against concurrent CPU hotplug operations */
-	cpu_hotplug_disable();
-	ret = __acpi_processor_start(device);
-	cpu_hotplug_enable();
-	return ret;
-}
-
 static int acpi_processor_stop(struct device *dev)
 {
 	struct acpi_device *device = ACPI_COMPANION(dev);
@@ -279,9 +261,9 @@ static int __init acpi_processor_driver_init(void)
 	if (result < 0)
 		return result;
 
-	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
-					   "acpi/cpu-drv:online",
-					   acpi_soft_cpu_online, NULL);
+	result = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				   "acpi/cpu-drv:online",
+				   acpi_soft_cpu_online, NULL);
 	if (result < 0)
 		goto err;
 	hp_online = result;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 3f34ebb27525..e6f6074eadbf 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -217,7 +217,7 @@ struct acpi_processor_flags {
 	u8 has_lpi:1;
 	u8 power_setup_done:1;
 	u8 bm_rld_set:1;
-	u8 need_hotplug_init:1;
+	u8 previously_online:1;
 };
 
 struct acpi_processor {
-- 
2.39.2


