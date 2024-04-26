Return-Path: <linux-arch+bounces-4003-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6318A8B3930
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 15:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F45F1C23C82
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 13:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841DA148FEE;
	Fri, 26 Apr 2024 13:55:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A21487E7;
	Fri, 26 Apr 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139738; cv=none; b=WNMQzsJVEiPKNR0JoLoojv6y/xjsiTq55ShKxTX9CAcRNUVPxNvfDgtPS0xlUArEna2zT49+fZDSFOulpYJFg8BOemGK9TLcbYiKfoA9FDVQpbw8TAVnU2/Rmh7fCWxwIMe3eUErP2E2H1OzIz7bc2QrocidRCTeqDPX8qiuTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139738; c=relaxed/simple;
	bh=hEA5/Ucs+6BfCQuaOqwWg2FdB+Ojyaz3tsyjeG3E9BI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMHjHJzmCrSl4mS4vwDJZsPI+L8xZQs0OHfGULVNKLaBayqR1WiayKrkhQSNDyaiBOZSH9fXiPOZpBCw9NvO55XpNuPpBtdKP9dwz96l0DIyksu0NZAN0N8/Lf8RiU1Cqe01ZcEaKUFwNSkP9wruDFHS9dCrAGGSq/Pzu1k6RZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQvLm6XS2z6K6J9;
	Fri, 26 Apr 2024 21:53:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DCAF140A70;
	Fri, 26 Apr 2024 21:55:33 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 14:55:32 +0100
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
Subject: [PATCH v8 08/16] ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
Date: Fri, 26 Apr 2024 14:51:18 +0100
Message-ID: <20240426135126.12802-9-Jonathan.Cameron@huawei.com>
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

From: James Morse <james.morse@arm.com>

struct acpi_scan_handler has a detach callback that is used to remove
a driver when a bus is changed. When interacting with an eject-request,
the detach callback is called before _EJ0.

This means the ACPI processor driver can't use _STA to determine if a
CPU has been made not-present, or some of the other _STA bits have been
changed. acpi_processor_remove() needs to know the value of _STA after
_EJ0 has been called.

Add a post_eject callback to struct acpi_scan_handler. This is called
after acpi_scan_hot_remove() has successfully called _EJ0. Because
acpi_scan_check_and_detach() also clears the handler pointer,
it needs to be told if the caller will go on to call
acpi_bus_post_eject(), so that acpi_device_clear_enumerated()
and clearing the handler pointer can be deferred.
An extra flag is added to flags field introduced in the previous
patch to achieve this.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v8: No change.
---
 drivers/acpi/acpi_processor.c |  4 ++--
 drivers/acpi/scan.c           | 30 +++++++++++++++++++++++++++---
 include/acpi/acpi_bus.h       |  1 +
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 88108aecbcfa..179d0dcc3847 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -475,7 +475,7 @@ static int acpi_processor_add(struct acpi_device *device,
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Removal */
-static void acpi_processor_remove(struct acpi_device *device)
+static void acpi_processor_post_eject(struct acpi_device *device)
 {
 	struct acpi_processor *pr;
 
@@ -643,7 +643,7 @@ static struct acpi_scan_handler processor_handler = {
 	.ids = processor_device_ids,
 	.attach = acpi_processor_add,
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
-	.detach = acpi_processor_remove,
+	.post_eject = acpi_processor_post_eject,
 #endif
 	.hotplug = {
 		.enabled = true,
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb5427caf0f4..7ebb3f9cea42 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -245,6 +245,7 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
 }
 
 #define ACPI_SCAN_CHECK_FLAG_STATUS	BIT(0)
+#define ACPI_SCAN_CHECK_FLAG_EJECT	BIT(1)
 
 static int acpi_scan_check_and_detach(struct acpi_device *adev, void *p)
 {
@@ -273,8 +274,6 @@ static int acpi_scan_check_and_detach(struct acpi_device *adev, void *p)
 	if (handler) {
 		if (handler->detach)
 			handler->detach(adev);
-
-		adev->handler = NULL;
 	} else {
 		device_release_driver(&adev->dev);
 	}
@@ -284,6 +283,28 @@ static int acpi_scan_check_and_detach(struct acpi_device *adev, void *p)
 	 */
 	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
 	adev->flags.initialized = false;
+
+	/* For eject this is deferred to acpi_bus_post_eject() */
+	if (!(flags & ACPI_SCAN_CHECK_FLAG_EJECT)) {
+		adev->handler = NULL;
+		acpi_device_clear_enumerated(adev);
+	}
+	return 0;
+}
+
+static int acpi_bus_post_eject(struct acpi_device *adev, void *not_used)
+{
+	struct acpi_scan_handler *handler = adev->handler;
+
+	acpi_dev_for_each_child_reverse(adev, acpi_bus_post_eject, NULL);
+
+	if (handler) {
+		if (handler->post_eject)
+			handler->post_eject(adev);
+
+		adev->handler = NULL;
+	}
+
 	acpi_device_clear_enumerated(adev);
 
 	return 0;
@@ -301,6 +322,7 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 	acpi_handle handle = device->handle;
 	unsigned long long sta;
 	acpi_status status;
+	uintptr_t flags = ACPI_SCAN_CHECK_FLAG_EJECT;
 
 	if (device->handler && device->handler->hotplug.demand_offline) {
 		if (!acpi_scan_is_offline(device, true))
@@ -313,7 +335,7 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 
 	acpi_handle_debug(handle, "Ejecting\n");
 
-	acpi_bus_trim(device);
+	acpi_scan_check_and_detach(device, (void *)flags);
 
 	acpi_evaluate_lck(handle, 0);
 	/*
@@ -336,6 +358,8 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 	} else if (sta & ACPI_STA_DEVICE_ENABLED) {
 		acpi_handle_warn(handle,
 			"Eject incomplete - status 0x%llx\n", sta);
+	} else {
+		acpi_bus_post_eject(device, NULL);
 	}
 
 	return 0;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 5de954e2b18a..d5c0fb413697 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -129,6 +129,7 @@ struct acpi_scan_handler {
 	bool (*match)(const char *idstr, const struct acpi_device_id **matchid);
 	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
 	void (*detach)(struct acpi_device *dev);
+	void (*post_eject)(struct acpi_device *dev);
 	void (*bind)(struct device *phys_dev);
 	void (*unbind)(struct device *phys_dev);
 	struct acpi_hotplug_profile hotplug;
-- 
2.39.2


