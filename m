Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6776689AB7
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 14:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjBCN4F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 08:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjBCNzL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 08:55:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F2EAA7EF7;
        Fri,  3 Feb 2023 05:53:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2529515DB;
        Fri,  3 Feb 2023 05:53:47 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53CE93F71E;
        Fri,  3 Feb 2023 05:53:01 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 17/32] ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
Date:   Fri,  3 Feb 2023 13:50:28 +0000
Message-Id: <20230203135043.409192-18-james.morse@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230203135043.409192-1-james.morse@arm.com>
References: <20230203135043.409192-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 6ab55f109417..ab0f80b83773 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -411,7 +411,7 @@ static int acpi_processor_add(struct acpi_device *device,
 
 #ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 /* Removal */
-static void acpi_processor_remove(struct acpi_device *device)
+static void acpi_processor_post_eject(struct acpi_device *device)
 {
 	struct acpi_processor *pr;
 
@@ -523,7 +523,7 @@ static struct acpi_scan_handler processor_handler = {
 	.ids = processor_device_ids,
 	.attach = acpi_processor_add,
 #ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
-	.detach = acpi_processor_remove,
+	.post_eject = acpi_processor_post_eject,
 #endif
 	.hotplug = {
 		.enabled = true,
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index cecf94192771..cd9bedb54393 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -245,18 +245,28 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
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
@@ -266,7 +276,12 @@ static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
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
@@ -279,15 +294,36 @@ static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
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
@@ -300,7 +336,7 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 
 	acpi_handle_debug(handle, "Ejecting\n");
 
-	acpi_bus_trim(device);
+	acpi_bus_trim_one(device, &eject);
 
 	acpi_evaluate_lck(handle, 0);
 	/*
@@ -323,6 +359,8 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 	} else if (sta & ACPI_STA_DEVICE_ENABLED) {
 		acpi_handle_warn(handle,
 			"Eject incomplete - status 0x%llx\n", sta);
+	} else {
+		acpi_bus_post_eject(device, NULL);
 	}
 
 	return 0;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index cd3b75e08ec3..dc4028cafd33 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -126,6 +126,7 @@ struct acpi_scan_handler {
 	bool (*match)(const char *idstr, const struct acpi_device_id **matchid);
 	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
 	void (*detach)(struct acpi_device *dev);
+	void (*post_eject)(struct acpi_device *dev);
 	void (*bind)(struct device *phys_dev);
 	void (*unbind)(struct device *phys_dev);
 	struct acpi_hotplug_profile hotplug;
-- 
2.30.2

