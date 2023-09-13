Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8113A79EEDA
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjIMQlD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjIMQj5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:39:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 827F61BE1;
        Wed, 13 Sep 2023 09:39:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 758D8C15;
        Wed, 13 Sep 2023 09:40:12 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6006F3F5A1;
        Wed, 13 Sep 2023 09:39:33 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 21/35] ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
Date:   Wed, 13 Sep 2023 16:38:09 +0000
Message-Id: <20230913163823.7880-22-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

struct acpi_scan_handler has a detach callback that is used to remove
a driver when a bus is changed. When interacting with an eject-request,
the detach callback is called before _EJ0.

This means the ACPI processor driver can't use _STA to determine if a
CPU has been made not-present, or some of the other _STA bits have been
changed. acpi_processor_remove() needs to know the value of _STA after
_EJ0 has been called.

Add a post_eject callback to struct acpi_scan_handler. This is called
after acpi_scan_hot_remove() has successfully called _EJ0. Because
acpi_bus_trim_one() also clears the handler pointer, it needs to be
told if the caller will go on to call acpi_bus_post_eject(), so
that acpi_device_clear_enumerated() and clearing the handler pointer
can be deferred. The existing not-used pointer is used for this.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/acpi_processor.c |  4 +--
 drivers/acpi/scan.c           | 52 ++++++++++++++++++++++++++++++-----
 include/acpi/acpi_bus.h       |  1 +
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 22a15a614f95..00dcc23d49a8 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -459,7 +459,7 @@ static int acpi_processor_add(struct acpi_device *device,
 
 #ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 /* Removal */
-static void acpi_processor_remove(struct acpi_device *device)
+static void acpi_processor_post_eject(struct acpi_device *device)
 {
 	struct acpi_processor *pr;
 
@@ -627,7 +627,7 @@ static struct acpi_scan_handler processor_handler = {
 	.ids = processor_device_ids,
 	.attach = acpi_processor_add,
 #ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
-	.detach = acpi_processor_remove,
+	.post_eject = acpi_processor_post_eject,
 #endif
 	.hotplug = {
 		.enabled = true,
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a675333618ae..b6d2f01640a9 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -244,18 +244,28 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
 	return 0;
 }
 
-static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
+/**
+ * acpi_bus_trim_one() - Detach scan handlers and drivers from ACPI device
+ *                       objects.
+ * @adev:       Root of the ACPI namespace scope to walk.
+ * @eject:      Pointer to a bool that indicates if this was due to an
+ *              eject-request.
+ *
+ * Must be called under acpi_scan_lock.
+ * If @eject points to true, clearing the device enumeration is deferred until
+ * acpi_bus_post_eject() is called.
+ */
+static int acpi_bus_trim_one(struct acpi_device *adev, void *eject)
 {
 	struct acpi_scan_handler *handler = adev->handler;
+	bool is_eject = *(bool *)eject;
 
-	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
+	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, eject);
 
 	adev->flags.match_driver = false;
 	if (handler) {
 		if (handler->detach)
 			handler->detach(adev);
-
-		adev->handler = NULL;
 	} else {
 		device_release_driver(&adev->dev);
 	}
@@ -265,7 +275,12 @@ static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
 	 */
 	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
 	adev->flags.initialized = false;
-	acpi_device_clear_enumerated(adev);
+
+	/* For eject this is deferred to acpi_bus_post_eject() */
+	if (!is_eject) {
+		adev->handler = NULL;
+		acpi_device_clear_enumerated(adev);
+	}
 
 	return 0;
 }
@@ -278,15 +293,36 @@ static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
  */
 void acpi_bus_trim(struct acpi_device *adev)
 {
-	acpi_bus_trim_one(adev, NULL);
+	bool eject = false;
+
+	acpi_bus_trim_one(adev, &eject);
 }
 EXPORT_SYMBOL_GPL(acpi_bus_trim);
 
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
+	acpi_device_clear_enumerated(adev);
+
+	return 0;
+}
+
 static int acpi_scan_hot_remove(struct acpi_device *device)
 {
 	acpi_handle handle = device->handle;
 	unsigned long long sta;
 	acpi_status status;
+	bool eject = true;
 
 	if (device->handler && device->handler->hotplug.demand_offline) {
 		if (!acpi_scan_is_offline(device, true))
@@ -299,7 +335,7 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 
 	acpi_handle_debug(handle, "Ejecting\n");
 
-	acpi_bus_trim(device);
+	acpi_bus_trim_one(device, &eject);
 
 	acpi_evaluate_lck(handle, 0);
 	/*
@@ -322,6 +358,8 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 	} else if (sta & ACPI_STA_DEVICE_ENABLED) {
 		acpi_handle_warn(handle,
 			"Eject incomplete - status 0x%llx\n", sta);
+	} else {
+		acpi_bus_post_eject(device, NULL);
 	}
 
 	return 0;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 254685085c82..1b7e1acf925b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -127,6 +127,7 @@ struct acpi_scan_handler {
 	bool (*match)(const char *idstr, const struct acpi_device_id **matchid);
 	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
 	void (*detach)(struct acpi_device *dev);
+	void (*post_eject)(struct acpi_device *dev);
 	void (*bind)(struct device *phys_dev);
 	void (*unbind)(struct device *phys_dev);
 	struct acpi_hotplug_profile hotplug;
-- 
2.39.2

