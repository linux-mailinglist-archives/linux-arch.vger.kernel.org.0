Return-Path: <linux-arch+bounces-4073-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECA58B797F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 16:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3A728396F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A7152791;
	Tue, 30 Apr 2024 14:25:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DDB152790;
	Tue, 30 Apr 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487111; cv=none; b=T+iLHUC3pN372tqFe2kt0qGyVTbfZ4xdIf5WzOl9cITnF5NhZESGi3KuIcNXOT4oP2kUi+Qmu9W5FRDa15PZac5gaEjlAzi2PBjpLu2EXncyCu5cEcHHEiuzYII3omuZ2CKXQ4XbeocdSS6Jlws5f1eUni8X8ixh+tPiHbbs5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487111; c=relaxed/simple;
	bh=HMZlCUL/E3r5RYZfblx4Jrbq5YazgaWcAdZ/Fn3sYrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCrkNZUR9hEn6mgnKviP9+r6wPViSVgyke7twgL3KUQNTwWzMVBT30n91DmdSZfRryBK1iG+SfSSArsW2CiTFw11pdNFIHZZcnF2/jxXYTVOOqWg4NMZ/F568nPCMtuqNwgnMXdPcoRtIkQkDDCGfqKtIriT2GNmAwlQsM54jrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTMsY1kvsz6DB58;
	Tue, 30 Apr 2024 22:24:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B781140B2F;
	Tue, 30 Apr 2024 22:25:07 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 15:25:06 +0100
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
Subject: [PATCH v9 01/19] ACPI: processor: Simplify initial onlining to use same path for cold and hotplug
Date: Tue, 30 Apr 2024 15:24:16 +0100
Message-ID: <20240430142434.10471-2-Jonathan.Cameron@huawei.com>
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

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v9: Drop overly noisy pr_info() print and tidy up a stale comment about
    the flag that no longer exists. Leave in place the note about delayed
    init.
---
 drivers/acpi/acpi_processor.c   |  7 +++---
 drivers/acpi/processor_driver.c | 43 +++++++++------------------------
 include/acpi/processor.h        |  2 +-
 3 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7a0dd35d62c9..b2f0b6c19482 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -211,12 +211,11 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	}
 
 	/*
-	 * CPU got hot-added, but cpu_data is not initialized yet.  Set a flag
-	 * to delay cpu_idle/throttling initialization and do it when the CPU
-	 * gets online for the first time.
+	 * CPU got hot-added, but cpu_data is not initialized yet. Do
+	 * cpu_idle/throttling initialization when the CPU gets online for
+	 * the first time.
 	 */
 	pr_info("CPU%d has been hot-added\n", pr->id);
-	pr->flags.need_hotplug_init = 1;
 
 out:
 	cpus_write_unlock();
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 67db60eda370..cb52dd000b95 100644
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
 
@@ -115,12 +113,9 @@ static int acpi_soft_cpu_online(unsigned int cpu)
 	 * CPU got physically hotplugged and onlined for the first time:
 	 * Initialize missing things.
 	 */
-	if (pr->flags.need_hotplug_init) {
+	if (!pr->flags.previously_online) {
 		int ret;
 
-		pr_info("Will online and init hotplugged CPU: %d\n",
-			pr->id);
-		pr->flags.need_hotplug_init = 0;
 		ret = __acpi_processor_start(device);
 		WARN(ret, "Failed to start CPU: %d\n", pr->id);
 	} else {
@@ -167,9 +162,6 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (!pr)
 		return -ENODEV;
 
-	if (pr->flags.need_hotplug_init)
-		return 0;
-
 	result = acpi_cppc_processor_probe(pr);
 	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
 		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
@@ -185,32 +177,21 @@ static int __acpi_processor_start(struct acpi_device *device)
 
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
@@ -279,9 +260,9 @@ static int __init acpi_processor_driver_init(void)
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


