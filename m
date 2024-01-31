Return-Path: <linux-arch+bounces-1930-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC8A8444EE
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 17:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC66B25D0C
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 16:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B86E12BEBF;
	Wed, 31 Jan 2024 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="defBAnfO"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01684A2D;
	Wed, 31 Jan 2024 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719793; cv=none; b=HZ2BD/8D55VwY2HB4wPEMhKYs+na30lTDm42hjFtxRGtBNF8irIIRWl9SLzptVHvGFy0P9g8gl/uiXX5605+hs9IV1CcfORuanvgGasuVM9i5yLdk/hOTTIWcW0D63OULHEC8L+tdZeUwBheK1vVKilxlsMWX7oTY7h5Fs/cTUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719793; c=relaxed/simple;
	bh=gGObTp4kKFpEA5e0b3OHSfUfMgKFRW7LI9ouIHiEdKw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=O4S5kDHxqNXV3WLeU2NSEy8HuxSl9yDLuZxX6STKhb0pF5RaXANIobELjTKEOYcMJjwmLmMlmqL+cGt2eoQLFZw3q9deWo7+qKqimLQVA83UcBJClf+vjtYB6y+5Q446Kw5P0TplDW7oB0tEg8UFHRIEF2F0PsEcqI4wT7LfZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=defBAnfO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IHdulM/J52riJ6IqdG8NJSU+46WzMLMKZMZaDlyRtLs=; b=defBAnfOpLV4eK7fAS3ZSQVYE0
	aQBKPX+BtcWj7dd3qPmYikdVsTMPbZk0vDtHjtamGpdqX0ZzyW9zz/+MTNxdVAalAHWwGaOKnAwac
	LSxESWDXQPBDsDQQDmYTyXh7/F2v6TFAVdvDzgwa7sDIqOnNPrBubRPqrjVLcjAPLd+i7D0C5FudH
	Jtrm3YlMrxC8XS5cxPWLx9xs6jtXAad8kM24OAXjJ7DBBS2WuIAQfq46mL6RUsDtaJDTQ0sq1izEF
	qeCuO0OwOu7ZocU+74BKkBhUxr8LdfnstyXg+KjOdZp8feq24bIw2RpkRTMI4nxRSAjuVRBZdU+NQ
	pTkn7gTg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36830 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVDmQ-0003TW-1V;
	Wed, 31 Jan 2024 16:49:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVDmP-0027YJ-EW; Wed, 31 Jan 2024 16:49:41 +0000
In-Reply-To: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: linux-pm@vger.kernel.org,
	 loongarch@lists.linux.dev,
	 linux-acpi@vger.kernel.org,
	 linux-arch@vger.kernel.org,
	 linux-kernel@vger.kernel.org,
	 linux-arm-kernel@lists.infradead.org,
	 linux-riscv@lists.infradead.org,
	 kvmarm@lists.linux.dev,
	 x86@kernel.org,
	 acpica-devel@lists.linuxfoundation.org,
	 linux-csky@vger.kernel.org,
	 linux-doc@vger.kernel.org,
	 linux-ia64@vger.kernel.org,
	 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	 Jean-Philippe Brucker <jean-philippe@linaro.org>,
	 jianyong.wu@arm.com,
	 justin.he@arm.com,
	 James Morse <james.morse@arm.com>,
	 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH RFC v4 01/15] ACPI: Only enumerate enabled (or functional)
 processor devices
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVDmP-0027YJ-EW@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 31 Jan 2024 16:49:41 +0000

From: James Morse <james.morse@arm.com>

Today the ACPI enumeration code 'visits' all devices that are present.

This is a problem for arm64, where CPUs are always present, but not
always enabled. When a device-check occurs because the firmware-policy
has changed and a CPU is now enabled, the following error occurs:
| acpi ACPI0007:48: Enumeration failure

This is ultimately because acpi_dev_ready_for_enumeration() returns
true for a device that is not enabled. The ACPI Processor driver
will not register such CPUs as they are not 'decoding their resources'.

ACPI allows a device to be functional instead of maintaining the
present and enabled bit, but we can't simply check the enabled bit
for all devices since firmware can be buggy.

If ACPI indicates that the device is present and enabled, then all well
and good, we can enumate it. However, if the device is present and not
enabled, then we also check whether the device is a processor device
to limit the impact of this new check to just processor devices.

This avoids enumerating present && functional processor devices that
are not enabled.

Signed-off-by: James Morse <james.morse@arm.com>
Co-developed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Incorporate comment suggestion by Gavin Shan.
Changes since RFC v3:
 * Fixed "sert" typo.
Changes since RFC v3 (smaller series):
 * Restrict checking the enabled bit to processor devices, update
   commit comments.
 * Use Rafael's suggestion in
   https://lore.kernel.org/r/5760569.DvuYhMxLoT@kreacher
 * Updated with a fix - see:
   https://lore.kernel.org/all/Zbe8WQRASx6D6RaG@shell.armlinux.org.uk/
---
 drivers/acpi/acpi_processor.c | 11 +++++++++
 drivers/acpi/device_pm.c      |  2 +-
 drivers/acpi/device_sysfs.c   |  2 +-
 drivers/acpi/internal.h       |  4 ++-
 drivers/acpi/property.c       |  2 +-
 drivers/acpi/scan.c           | 46 +++++++++++++++++++++++++++--------
 6 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 4fe2ef54088c..cf7c1cca69dd 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -626,6 +626,17 @@ static struct acpi_scan_handler processor_handler = {
 	},
 };
 
+bool acpi_device_is_processor(const struct acpi_device *adev)
+{
+	if (adev->device_type == ACPI_BUS_TYPE_PROCESSOR)
+		return true;
+
+	if (adev->device_type != ACPI_BUS_TYPE_DEVICE)
+		return false;
+
+	return acpi_scan_check_handler(adev, &processor_handler);
+}
+
 static int acpi_processor_container_attach(struct acpi_device *dev,
 					   const struct acpi_device_id *id)
 {
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 3b4d048c4941..e3c80f3b3b57 100644
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
index 23373faa35ec..a0256d2493a7 100644
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
index 6588525c45ef..1bc8b6db60c5 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -62,6 +62,8 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
 int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler,
 				       const char *hotplug_profile_name);
 void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool val);
+bool acpi_scan_check_handler(const struct acpi_device *adev,
+			     struct acpi_scan_handler *handler);
 
 #ifdef CONFIG_DEBUG_FS
 extern struct dentry *acpi_debugfs_dir;
@@ -121,7 +123,6 @@ int acpi_device_setup_files(struct acpi_device *dev);
 void acpi_device_remove_files(struct acpi_device *dev);
 void acpi_device_add_finalize(struct acpi_device *device);
 void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
-bool acpi_device_is_present(const struct acpi_device *adev);
 bool acpi_device_is_battery(struct acpi_device *adev);
 bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 					const struct device *dev);
@@ -133,6 +134,7 @@ int acpi_bus_register_early_device(int type);
 const struct acpi_device *acpi_companion_match(const struct device *dev);
 int __acpi_device_uevent_modalias(const struct acpi_device *adev,
 				  struct kobj_uevent_env *env);
+bool acpi_device_is_processor(const struct acpi_device *adev);
 
 /* --------------------------------------------------------------------------
                                   Power Resource
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index a6ead5204046..9f8d54038770 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1486,7 +1486,7 @@ static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 	if (!is_acpi_device_node(fwnode))
 		return false;
 
-	return acpi_device_is_present(to_acpi_device_node(fwnode));
+	return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnode));
 }
 
 static const void *
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e6ed1ba91e5c..fd2e8b3a5749 100644
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
@@ -1917,11 +1917,6 @@ static bool acpi_device_should_be_hidden(acpi_handle handle)
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
@@ -1942,6 +1937,18 @@ static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
 	return false;
 }
 
+bool acpi_scan_check_handler(const struct acpi_device *adev,
+			     struct acpi_scan_handler *handler)
+{
+	struct acpi_hardware_id *hwid;
+
+	list_for_each_entry(hwid, &adev->pnp.ids, list)
+		if (acpi_scan_handler_matching(handler, hwid->id, NULL))
+			return true;
+
+	return false;
+}
+
 static struct acpi_scan_handler *acpi_scan_match_handler(const char *idstr,
 					const struct acpi_device_id **matchid)
 {
@@ -2405,16 +2412,35 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
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
+	 * enumerated. Note that the enabled bit should not be set unless the
+	 * present bit is set.
+	 *
+	 * However, limit this only to processor devices to reduce possible
+	 * regressions with firmware.
+	 */
+	if (!device->status.present)
+		return device->status.functional;
+
+	/*
+	 * Fast path - if enabled is set, avoid the more expensive test to
+	 * check whether this device is a processor.
+	 */
+	if (device->status.enabled)
+		return true;
+
+	return !acpi_device_is_processor(device);
 }
 EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
 
-- 
2.30.2


