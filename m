Return-Path: <linux-arch+bounces-1346-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A661B82ABE9
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 11:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1ACC1C2326C
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E212E78;
	Thu, 11 Jan 2024 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BYZDBswK"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18C13FE2;
	Thu, 11 Jan 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pDZNBMDn2+p6BZE/RBnm0b+eYsTn5JNJblyxFwWjLwk=; b=BYZDBswK7aOutgUjZLmuntw9C6
	/yYD+iZVGMuStm1/46YVQPXa4jHRv6Z8U/xIa+GSGAwKVe34SOytP3Tx9xGkr72yv80XAwvbHV0bI
	sPo8k0+woUMNdoNp9uCH8fzeyQBvulH5ie2B1EvuuxPpAgFAxaDTDH6o16MImnNWfDZMt4MUpeydd
	4Z4CGcT1w4kbIrcckE3oSmD9z4loTIDryx40alX5lGpP8DdcjKsh3Da0sjJdRoK9DB6NjVdi+llFX
	fk+jEeT0JRIaRq95XtNKWwqN3BzgOn30vMAbYjbfZoJNdvcaRvtz18LFYQCvuQFlzqBBOaeWenMGv
	Od4lYmnQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57484)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNsGM-0006OP-2L;
	Thu, 11 Jan 2024 10:26:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNsGN-0006HT-CT; Thu, 11 Jan 2024 10:26:15 +0000
Date: Thu, 11 Jan 2024 10:26:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or
 functional) devices
Message-ID: <ZZ/CR/6Voec066DR@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk>
 <20231215161539.00000940@Huawei.com>
 <5760569.DvuYhMxLoT@kreacher>
 <20240102143925.00004361@Huawei.com>
 <20240111101949.000075dc@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111101949.000075dc@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 11, 2024 at 10:19:49AM +0000, Jonathan Cameron wrote:
> On Tue, 2 Jan 2024 14:39:25 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Fri, 15 Dec 2023 20:47:31 +0100
> > "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > 
> > > On Friday, December 15, 2023 5:15:39 PM CET Jonathan Cameron wrote:  
> > > > On Fri, 15 Dec 2023 15:31:55 +0000
> > > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > >     
> > > > > On Thu, Dec 14, 2023 at 07:37:10PM +0100, Rafael J. Wysocki wrote:    
> > > > > > On Thu, Dec 14, 2023 at 7:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:      
> > > > > > >
> > > > > > > On Thu, Dec 14, 2023 at 7:10 PM Russell King (Oracle)
> > > > > > > <linux@armlinux.org.uk> wrote:      
> > > > > > > > I guess we need something like:
> > > > > > > >
> > > > > > > >         if (device->status.present)
> > > > > > > >                 return device->device_type != ACPI_BUS_TYPE_PROCESSOR ||
> > > > > > > >                        device->status.enabled;
> > > > > > > >         else
> > > > > > > >                 return device->status.functional;
> > > > > > > >
> > > > > > > > so we only check device->status.enabled for processor-type devices?      
> > > > > > >
> > > > > > > Yes, something like this.      
> > > > > > 
> > > > > > However, that is not sufficient, because there are
> > > > > > ACPI_BUS_TYPE_DEVICE devices representing processors.
> > > > > > 
> > > > > > I'm not sure about a clean way to do it ATM.      
> > > > > 
> > > > > Ok, how about:
> > > > > 
> > > > > static bool acpi_dev_is_processor(const struct acpi_device *device)
> > > > > {
> > > > > 	struct acpi_hardware_id *hwid;
> > > > > 
> > > > > 	if (device->device_type == ACPI_BUS_TYPE_PROCESSOR)
> > > > > 		return true;
> > > > > 
> > > > > 	if (device->device_type != ACPI_BUS_TYPE_DEVICE)
> > > > > 		return false;
> > > > > 
> > > > > 	list_for_each_entry(hwid, &device->pnp.ids, list)
> > > > > 		if (!strcmp(ACPI_PROCESSOR_OBJECT_HID, hwid->id) ||
> > > > > 		    !strcmp(ACPI_PROCESSOR_DEVICE_HID, hwid->id))
> > > > > 			return true;
> > > > > 
> > > > > 	return false;
> > > > > }
> > > > > 
> > > > > and then:
> > > > > 
> > > > > 	if (device->status.present)
> > > > > 		return !acpi_dev_is_processor(device) || device->status.enabled;
> > > > > 	else
> > > > > 		return device->status.functional;
> > > > > 
> > > > > ?
> > > > >     
> > > > Changing it to CPU only for now makes sense to me and I think this code snippet should do the
> > > > job.  Nice and simple.    
> > > 
> > > Well, except that it does checks that are done elsewhere slightly
> > > differently, which from the maintenance POV is not nice.
> > > 
> > > Maybe something like the appended patch (untested).  
> > 
> > Hi Rafael,
> > 
> > As far as I can see that's functionally equivalent, so looks good to me.
> > I'm not set up to test this today though, so will defer to Russell on whether
> > there is anything missing
> > 
> > Thanks for putting this together.
> 
> This is rather embarrassing...
> 
> I span this up on a QEMU instance with some prints to find out we need
> the !acpi_device_is_processor() restriction.
> On my 'random' test setup it fails on one device. ACPI0017 - which I
> happen to know rather well. It's the weird pseudo device that lets
> a CXL aware OS know there is a CEDT table to probe.
> 
> Whilst I really don't like that hack (it is all about making software
> distribution of out of tree modules easier rather than something
> fundamental), I'm the CXL QEMU maintainer :(
> 
> Will fix that, but it shows there is at least one broken firmware out
> there.
> 
> On plus side, Rafael's code seems to work as expected and lets that
> buggy firwmare carry on working :) So lets pretend the bug in qemu
> is a deliberate test case!

Lol, thanks for a test case and showing that Rafael's approach is
indeed necessary.

Would your test quality for a tested-by for this? For reference, this
is my current version below with Rafael's update:

8<====
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] ACPI: Only enumerate enabled (or functional) processor
 devices

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
---
 drivers/acpi/acpi_processor.c | 11 ++++++++
 drivers/acpi/device_pm.c      |  2 +-
 drivers/acpi/device_sysfs.c   |  2 +-
 drivers/acpi/internal.h       |  4 ++-
 drivers/acpi/property.c       |  2 +-
 drivers/acpi/scan.c           | 49 ++++++++++++++++++++++++++++-------
 6 files changed, 56 insertions(+), 14 deletions(-)

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
index 866c7c4ed233..9388d4c8674a 100644
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
@@ -107,7 +109,6 @@ int acpi_device_setup_files(struct acpi_device *dev);
 void acpi_device_remove_files(struct acpi_device *dev);
 void acpi_device_add_finalize(struct acpi_device *device);
 void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
-bool acpi_device_is_present(const struct acpi_device *adev);
 bool acpi_device_is_battery(struct acpi_device *adev);
 bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 					const struct device *dev);
@@ -119,6 +120,7 @@ int acpi_bus_register_early_device(int type);
 const struct acpi_device *acpi_companion_match(const struct device *dev);
 int __acpi_device_uevent_modalias(const struct acpi_device *adev,
 				  struct kobj_uevent_env *env);
+bool acpi_device_is_processor(const struct acpi_device *adev);
 
 /* --------------------------------------------------------------------------
                                   Power Resource
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
index 02bb2cce423f..f94d1f744bcc 100644
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
@@ -1938,6 +1933,18 @@ static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
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
@@ -2381,16 +2388,38 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
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
+	if (device->status.functional)
+		return true;
+
+	if (!device->status.present)
+		return false;
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


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

