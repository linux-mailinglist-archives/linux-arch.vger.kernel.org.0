Return-Path: <linux-arch+bounces-979-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CFD81115B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 13:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AC1281EFE
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 12:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4F29409;
	Wed, 13 Dec 2023 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="R6N7nL3H"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93011A4;
	Wed, 13 Dec 2023 04:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7Aiu0hOT23ckQkcqYvFjFK3dZgn3o0k6iEaEs/f0wM4=; b=R6N7nL3Hj7r6PGZF3AQxR9xYGp
	hz3VIljNGb8hg0+7xDjuT8525pBUgeBD+UIlhqsF/zdkVX1vEA4PMefDHWLw6eESWX/1AaRvJ2xvp
	drQL6SkAjAlAaI2V+skWX+NQheiaNGiyFmbcghDlNq53IdbfD3RGfOI0sr2M81PLbH2+OjiOQSuF6
	/Gyjb/SKH6KmE2xRrQzd43ITzOIHYT2giKcTbiBo+f70SVHRLq3gSmUv6s13SFY3S3PO1NASAJuRf
	0QsynTB3Sjo9SskZetDQ+UgL519HLUw4PT5wxDx035hqiXN3EfAgIHCFhMU5KolSLXbJDE1D9hsuC
	deJdumJQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36776 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rDOfq-0008Cl-1H;
	Wed, 13 Dec 2023 12:49:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rDOfs-00DvjY-HQ; Wed, 13 Dec 2023 12:49:16 +0000
In-Reply-To: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
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
	James Morse <james.morse@arm.com>
Subject: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or functional)
 devices
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rDOfs-00DvjY-HQ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 13 Dec 2023 12:49:16 +0000

From: James Morse <james.morse@arm.com>

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
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
If this change causes problems on deployed hardware, I suggest an
arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
acpi_dev_ready_for_enumeration() to only check the present bit.

Changes since RFC v2:
 * Incorporate comment suggestion by Gavin Shan.
Other review comments from Jonathan Cameron not yet addressed.
---
 drivers/acpi/device_pm.c    |  2 +-
 drivers/acpi/device_sysfs.c |  2 +-
 drivers/acpi/internal.h     |  1 -
 drivers/acpi/property.c     |  2 +-
 drivers/acpi/scan.c         | 24 ++++++++++++++----------
 5 files changed, 17 insertions(+), 14 deletions(-)

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
index 6979a3f9f90a..14d6948fd88a 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1420,7 +1420,7 @@ static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 	if (!is_acpi_device_node(fwnode))
 		return false;
 
-	return acpi_device_is_present(to_acpi_device_node(fwnode));
+	return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnode));
 }
 
 static const void *
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 02bb2cce423f..728649a2a251 100644
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
@@ -1913,11 +1913,6 @@ static bool acpi_device_should_be_hidden(acpi_handle handle)
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
@@ -2381,16 +2376,25 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
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
+	 * enumerated. Note that the enabled bit can't be sert until the present
+	 * bit is set.
+	 */
+	if (device->status.present)
+		return device->status.enabled;
+	else
+		return device->status.functional;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
 
-- 
2.30.2


