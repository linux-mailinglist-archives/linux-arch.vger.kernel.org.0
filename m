Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04279EE9F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjIMQkJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjIMQjk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:39:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 381D1210B;
        Wed, 13 Sep 2023 09:39:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38273C15;
        Wed, 13 Sep 2023 09:39:58 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DA263F5A1;
        Wed, 13 Sep 2023 09:39:19 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 14/35] ACPI: Only enumerate enabled (or functional) devices
Date:   Wed, 13 Sep 2023 16:38:02 +0000
Message-Id: <20230913163823.7880-15-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Today the ACPI enumeration code 'visits' all devices that are present.

This is a problem for arm64, where CPUs are always present, but not
always enabled. When a device-check occurs because the firmware-policy
has changed and a CPU is now enabled, the following error occurs:
| acpi ACPI0007:48: Enumeration failure

This is ultimately because acpi_dev_ready_for_enumeration() returns
true for a device that is not enabled. The ACPI Processor driver
will not register such CPUs as they are not 'decoding their resources'.

Change acpi_dev_ready_for_enumeration() to also check the enabled bit.
ACPI allows a device to be functional instead of maintaining the
present and enabled bit. Make this behaviour an explicit check with
a reference to the spec, and then check the present and enabled bits.
This is needed to avoid enumerating present && functional devices that
are not enabled.

Signed-off-by: James Morse <james.morse@arm.com>
---
If this change causes problems on deployed hardware, I suggest an
arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
acpi_dev_ready_for_enumeration() to only check the present bit.
---
 drivers/acpi/device_pm.c    |  2 +-
 drivers/acpi/device_sysfs.c |  2 +-
 drivers/acpi/internal.h     |  1 -
 drivers/acpi/property.c     |  2 +-
 drivers/acpi/scan.c         | 23 +++++++++++++----------
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index f007116a8427..76c38478a502 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -313,7 +313,7 @@ int acpi_bus_init_power(struct acpi_device *device)
 		return -EINVAL;
 
 	device->power.state = ACPI_STATE_UNKNOWN;
-	if (!acpi_device_is_present(device)) {
+	if (!acpi_dev_ready_for_enumeration(device)) {
 		device->flags.initialized = false;
 		return -ENXIO;
 	}
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index b9bbf0746199..16e586d74aa2 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -141,7 +141,7 @@ static int create_pnp_modalias(const struct acpi_device *acpi_dev, char *modalia
 	struct acpi_hardware_id *id;
 
 	/* Avoid unnecessarily loading modules for non present devices. */
-	if (!acpi_device_is_present(acpi_dev))
+	if (!acpi_dev_ready_for_enumeration(acpi_dev))
 		return 0;
 
 	/*
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 866c7c4ed233..a1b45e345bcc 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -107,7 +107,6 @@ int acpi_device_setup_files(struct acpi_device *dev);
 void acpi_device_remove_files(struct acpi_device *dev);
 void acpi_device_add_finalize(struct acpi_device *device);
 void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
-bool acpi_device_is_present(const struct acpi_device *adev);
 bool acpi_device_is_battery(struct acpi_device *adev);
 bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 					const struct device *dev);
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 413e4fcadcaf..e03f00b98701 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1418,7 +1418,7 @@ static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 	if (!is_acpi_device_node(fwnode))
 		return false;
 
-	return acpi_device_is_present(to_acpi_device_node(fwnode));
+	return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnode));
 }
 
 static const void *
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 17ab875a7d4e..f898591ce05f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
 	int error;
 
 	acpi_bus_get_status(adev);
-	if (acpi_device_is_present(adev)) {
+	if (acpi_dev_ready_for_enumeration(adev)) {
 		/*
 		 * This function is only called for device objects for which
 		 * matching scan handlers exist.  The only situation in which
@@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
 	int error;
 
 	acpi_bus_get_status(adev);
-	if (!acpi_device_is_present(adev)) {
+	if (!acpi_dev_ready_for_enumeration(adev)) {
 		acpi_scan_device_not_enumerated(adev);
 		return 0;
 	}
@@ -1908,11 +1908,6 @@ static bool acpi_device_should_be_hidden(acpi_handle handle)
 	return true;
 }
 
-bool acpi_device_is_present(const struct acpi_device *adev)
-{
-	return adev->status.present || adev->status.functional;
-}
-
 static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
 				       const char *idstr,
 				       const struct acpi_device_id **matchid)
@@ -2375,16 +2370,24 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
  * acpi_dev_ready_for_enumeration - Check if the ACPI device is ready for enumeration
  * @device: Pointer to the &struct acpi_device to check
  *
- * Check if the device is present and has no unmet dependencies.
+ * Check if the device is functional or enabled and has no unmet dependencies.
  *
- * Return true if the device is ready for enumeratino. Otherwise, return false.
+ * Return true if the device is ready for enumeration. Otherwise, return false.
  */
 bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
 {
 	if (device->flags.honor_deps && device->dep_unmet)
 		return false;
 
-	return acpi_device_is_present(device);
+	/*
+	 * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to return
+	 * (!present && functional) for certain types of devices that should be
+	 * enumerated.
+	 */
+	if (!device->status.present && !device->status.enabled)
+		return device->status.functional;
+
+	return device->status.present && device->status.enabled;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
 
-- 
2.39.2

