Return-Path: <linux-arch+bounces-3638-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EE48A312C
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 16:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB17C1C214EA
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E851414386F;
	Fri, 12 Apr 2024 14:45:31 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FCB8614D;
	Fri, 12 Apr 2024 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933131; cv=none; b=g4ZMM/QDr22nvfBeRrPgjQ8n+/xcthaUvEpa9Nx+DgmzHba7JIx7GaTx9LXl+GQ9XX2o0Bsww82fj8Uskhqk5FT7xu+B3K/tJWewuddEpWANL3em6/qz8SMlCZo+SaiGh22kWMrZzCj86D1zJSnwph/AZD2dziLfExtQFQNZPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933131; c=relaxed/simple;
	bh=Zh2SqBQq28G/7th8Ws/9M8NeB0ZeAz1H/E9UJ16xcjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eU7XxUiUpns0Nm+7IT4Afh2V37iwpKX4hYbFPgxsCd4i1/kn2YKZH63KypCilWwzD3RBu2MqYk5Y8pfvdnHc6Zw3Ej+CczmUk6ZksBmY4UI8Rcnv/Zre7SAXhomV3ewKy1+DSKPGAB+B8yRi9jgXFOhMMNBhNd8uSB/dZk+P6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGK7g2hZzz6J6WZ;
	Fri, 12 Apr 2024 22:43:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A8CC41402CD;
	Fri, 12 Apr 2024 22:45:27 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 15:45:27 +0100
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
Subject: [PATCH v5 16/18] ACPI: add support to (un)register CPUs based on the _STA enabled bit
Date: Fri, 12 Apr 2024 15:37:17 +0100
Message-ID: <20240412143719.11398-17-Jonathan.Cameron@huawei.com>
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

From: James Morse <james.morse@arm.com>

acpi_processor_get_info() registers all present CPUs. Registering a
CPU is what creates the sysfs entries and triggers the udev
notifications.

arm64 virtual machines that support 'virtual cpu hotplug' use the
enabled bit to indicate whether the CPU can be brought online, as
the existing ACPI tables require all hardware to be described and
present.

If firmware describes a CPU as present, but disabled, skip the
registration. Such CPUs are present, but can't be brought online for
whatever reason. (e.g. firmware/hypervisor policy).

Once firmware sets the enabled bit, the CPU can be registered and
brought online by user-space. Online CPUs, or CPUs that are missing
an _STA method must always be registered.

When firmware clears the enabled bit, we need to unregister the CPU
for symetry. As this is dependent on hotplug CPU being support, and
arch_unregister_cpu() only exists when hotplug CPU is supported,
we need to add a check for that configuration symbol.

Note that some elements in the *make_present() and *make_not_present()
paths are not appropriate for the *enabled() paths beause they
are related to elements such as interrupt controller setup that
are done for all present (but not enabled) CPUs at boot.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5:
   Make the enable and present paths look much more like each other.
   Whilst similar, I think combining the two paths any more will
   lead to less readable code by implying they are more similar than
   they actually should be.
---
 drivers/acpi/acpi_processor.c | 46 +++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 3fb167ee9807..ffa2bc63da40 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -226,6 +226,24 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
 	return ret;
 }
 
+static int acpi_processor_make_enabled(struct acpi_processor *pr)
+{
+	int ret;
+
+	if (invalid_phys_cpuid(pr->phys_id))
+		return -ENODEV;
+
+	cpus_write_lock();
+	ret = arch_register_cpu(pr->id);
+	cpus_write_unlock();
+
+	if (ret)
+		return ret;
+
+	pr_info("CPU%d has been hot-added (onlined)\n", pr->id);
+	return 0;
+}
+
 static int acpi_processor_get_info(struct acpi_device *device)
 {
 	union acpi_object object = { 0 };
@@ -319,7 +337,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 */
 	if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
 	    !get_cpu_device(pr->id)) {
-		int ret = arch_register_cpu(pr->id);
+		int ret = acpi_processor_make_enabled(pr);
 
 		if (ret)
 			return ret;
@@ -463,6 +481,27 @@ static int acpi_processor_add(struct acpi_device *device,
 	return result;
 }
 
+static void acpi_processor_make_not_enabled(struct acpi_device *device)
+{
+	struct acpi_processor *pr;
+
+	pr = acpi_driver_data(device);
+	if (pr->id >= nr_cpu_ids)
+		goto out;
+
+	device_release_driver(pr->dev);
+	per_cpu(processor_device_array, pr->id) = NULL;
+	per_cpu(processors, pr->id) = NULL;
+	cpus_write_lock();
+	arch_unregister_cpu(pr->id);
+	cpus_write_unlock();
+
+	try_offline_node(cpu_to_node(pr->id));
+out:
+	free_cpumask_var(pr->throttling.shared_cpu_map);
+	kfree(pr);
+}
+
 /* Removal */
 static void acpi_processor_make_not_present(struct acpi_device *device)
 {
@@ -515,7 +554,7 @@ static void acpi_processor_post_eject(struct acpi_device *device)
 	unsigned long long sta;
 	acpi_status status;
 
-	if (!device)
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) || !device)
 		return;
 
 	pr = acpi_driver_data(device);
@@ -530,6 +569,9 @@ static void acpi_processor_post_eject(struct acpi_device *device)
 		acpi_processor_make_not_present(device);
 		return;
 	}
+
+	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_ENABLED))
+		acpi_processor_make_not_enabled(device);
 }
 
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
-- 
2.39.2


