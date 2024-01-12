Return-Path: <linux-arch+bounces-1363-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B582BF7A
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 12:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7C71F264E6
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 11:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810546A010;
	Fri, 12 Jan 2024 11:52:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0CF67E86;
	Fri, 12 Jan 2024 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBKZd3vRHz6K8Xc;
	Fri, 12 Jan 2024 19:49:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 350581408FF;
	Fri, 12 Jan 2024 19:52:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 11:52:07 +0000
Date: Fri, 12 Jan 2024 11:52:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	<linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or
 functional) devices
Message-ID: <20240112115205.000043b0@Huawei.com>
In-Reply-To: <ZZ/CR/6Voec066DR@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk>
	<20231215161539.00000940@Huawei.com>
	<5760569.DvuYhMxLoT@kreacher>
	<20240102143925.00004361@Huawei.com>
	<20240111101949.000075dc@Huawei.com>
	<ZZ/CR/6Voec066DR@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 11 Jan 2024 10:26:15 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Jan 11, 2024 at 10:19:49AM +0000, Jonathan Cameron wrote:
> > On Tue, 2 Jan 2024 14:39:25 +0000
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >  =20
> > > On Fri, 15 Dec 2023 20:47:31 +0100
> > > "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > >  =20
> > > > On Friday, December 15, 2023 5:15:39 PM CET Jonathan Cameron wrote:=
   =20
> > > > > On Fri, 15 Dec 2023 15:31:55 +0000
> > > > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > > >      =20
> > > > > > On Thu, Dec 14, 2023 at 07:37:10PM +0100, Rafael J. Wysocki wro=
te:     =20
> > > > > > > On Thu, Dec 14, 2023 at 7:16=E2=80=AFPM Rafael J. Wysocki <ra=
fael@kernel.org> wrote:       =20
> > > > > > > >
> > > > > > > > On Thu, Dec 14, 2023 at 7:10=E2=80=AFPM Russell King (Oracl=
e)
> > > > > > > > <linux@armlinux.org.uk> wrote:       =20
> > > > > > > > > I guess we need something like:
> > > > > > > > >
> > > > > > > > >         if (device->status.present)
> > > > > > > > >                 return device->device_type !=3D ACPI_BUS_=
TYPE_PROCESSOR ||
> > > > > > > > >                        device->status.enabled;
> > > > > > > > >         else
> > > > > > > > >                 return device->status.functional;
> > > > > > > > >
> > > > > > > > > so we only check device->status.enabled for processor-typ=
e devices?       =20
> > > > > > > >
> > > > > > > > Yes, something like this.       =20
> > > > > > >=20
> > > > > > > However, that is not sufficient, because there are
> > > > > > > ACPI_BUS_TYPE_DEVICE devices representing processors.
> > > > > > >=20
> > > > > > > I'm not sure about a clean way to do it ATM.       =20
> > > > > >=20
> > > > > > Ok, how about:
> > > > > >=20
> > > > > > static bool acpi_dev_is_processor(const struct acpi_device *dev=
ice)
> > > > > > {
> > > > > > 	struct acpi_hardware_id *hwid;
> > > > > >=20
> > > > > > 	if (device->device_type =3D=3D ACPI_BUS_TYPE_PROCESSOR)
> > > > > > 		return true;
> > > > > >=20
> > > > > > 	if (device->device_type !=3D ACPI_BUS_TYPE_DEVICE)
> > > > > > 		return false;
> > > > > >=20
> > > > > > 	list_for_each_entry(hwid, &device->pnp.ids, list)
> > > > > > 		if (!strcmp(ACPI_PROCESSOR_OBJECT_HID, hwid->id) ||
> > > > > > 		    !strcmp(ACPI_PROCESSOR_DEVICE_HID, hwid->id))
> > > > > > 			return true;
> > > > > >=20
> > > > > > 	return false;
> > > > > > }
> > > > > >=20
> > > > > > and then:
> > > > > >=20
> > > > > > 	if (device->status.present)
> > > > > > 		return !acpi_dev_is_processor(device) || device->status.enabl=
ed;
> > > > > > 	else
> > > > > > 		return device->status.functional;
> > > > > >=20
> > > > > > ?
> > > > > >      =20
> > > > > Changing it to CPU only for now makes sense to me and I think thi=
s code snippet should do the
> > > > > job.  Nice and simple.     =20
> > > >=20
> > > > Well, except that it does checks that are done elsewhere slightly
> > > > differently, which from the maintenance POV is not nice.
> > > >=20
> > > > Maybe something like the appended patch (untested).   =20
> > >=20
> > > Hi Rafael,
> > >=20
> > > As far as I can see that's functionally equivalent, so looks good to =
me.
> > > I'm not set up to test this today though, so will defer to Russell on=
 whether
> > > there is anything missing
> > >=20
> > > Thanks for putting this together. =20
> >=20
> > This is rather embarrassing...
> >=20
> > I span this up on a QEMU instance with some prints to find out we need
> > the !acpi_device_is_processor() restriction.
> > On my 'random' test setup it fails on one device. ACPI0017 - which I
> > happen to know rather well. It's the weird pseudo device that lets
> > a CXL aware OS know there is a CEDT table to probe.
> >=20
> > Whilst I really don't like that hack (it is all about making software
> > distribution of out of tree modules easier rather than something
> > fundamental), I'm the CXL QEMU maintainer :(
> >=20
> > Will fix that, but it shows there is at least one broken firmware out
> > there.
> >=20
> > On plus side, Rafael's code seems to work as expected and lets that
> > buggy firwmare carry on working :) So lets pretend the bug in qemu
> > is a deliberate test case! =20
>=20
> Lol, thanks for a test case and showing that Rafael's approach is
> indeed necessary.
>=20
> Would your test quality for a tested-by for this? For reference, this
> is my current version below with Rafael's update:

Sure. This matches what I have.

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


>=20
> 8<=3D=3D=3D=3D
> From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Subject: [PATCH] ACPI: Only enumerate enabled (or functional) processor
>  devices
>=20
> From: James Morse <james.morse@arm.com>
>=20
> Today the ACPI enumeration code 'visits' all devices that are present.
>=20
> This is a problem for arm64, where CPUs are always present, but not
> always enabled. When a device-check occurs because the firmware-policy
> has changed and a CPU is now enabled, the following error occurs:
> | acpi ACPI0007:48: Enumeration failure
>=20
> This is ultimately because acpi_dev_ready_for_enumeration() returns
> true for a device that is not enabled. The ACPI Processor driver
> will not register such CPUs as they are not 'decoding their resources'.
>=20
> ACPI allows a device to be functional instead of maintaining the
> present and enabled bit, but we can't simply check the enabled bit
> for all devices since firmware can be buggy.
>=20
> If ACPI indicates that the device is present and enabled, then all well
> and good, we can enumate it. However, if the device is present and not
> enabled, then we also check whether the device is a processor device
> to limit the impact of this new check to just processor devices.
>=20
> This avoids enumerating present && functional processor devices that
> are not enabled.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> Co-developed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>  * Incorporate comment suggestion by Gavin Shan.
> Changes since RFC v3:
>  * Fixed "sert" typo.
> Changes since RFC v3 (smaller series):
>  * Restrict checking the enabled bit to processor devices, update
>    commit comments.
>  * Use Rafael's suggestion in
>    https://lore.kernel.org/r/5760569.DvuYhMxLoT@kreacher
> ---
>  drivers/acpi/acpi_processor.c | 11 ++++++++
>  drivers/acpi/device_pm.c      |  2 +-
>  drivers/acpi/device_sysfs.c   |  2 +-
>  drivers/acpi/internal.h       |  4 ++-
>  drivers/acpi/property.c       |  2 +-
>  drivers/acpi/scan.c           | 49 ++++++++++++++++++++++++++++-------
>  6 files changed, 56 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 4fe2ef54088c..cf7c1cca69dd 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -626,6 +626,17 @@ static struct acpi_scan_handler processor_handler =
=3D {
>  	},
>  };
> =20
> +bool acpi_device_is_processor(const struct acpi_device *adev)
> +{
> +	if (adev->device_type =3D=3D ACPI_BUS_TYPE_PROCESSOR)
> +		return true;
> +
> +	if (adev->device_type !=3D ACPI_BUS_TYPE_DEVICE)
> +		return false;
> +
> +	return acpi_scan_check_handler(adev, &processor_handler);
> +}
> +
>  static int acpi_processor_container_attach(struct acpi_device *dev,
>  					   const struct acpi_device_id *id)
>  {
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 3b4d048c4941..e3c80f3b3b57 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -313,7 +313,7 @@ int acpi_bus_init_power(struct acpi_device *device)
>  		return -EINVAL;
> =20
>  	device->power.state =3D ACPI_STATE_UNKNOWN;
> -	if (!acpi_device_is_present(device)) {
> +	if (!acpi_dev_ready_for_enumeration(device)) {
>  		device->flags.initialized =3D false;
>  		return -ENXIO;
>  	}
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 23373faa35ec..a0256d2493a7 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -141,7 +141,7 @@ static int create_pnp_modalias(const struct acpi_devi=
ce *acpi_dev, char *modalia
>  	struct acpi_hardware_id *id;
> =20
>  	/* Avoid unnecessarily loading modules for non present devices. */
> -	if (!acpi_device_is_present(acpi_dev))
> +	if (!acpi_dev_ready_for_enumeration(acpi_dev))
>  		return 0;
> =20
>  	/*
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 866c7c4ed233..9388d4c8674a 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -62,6 +62,8 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug=
_profile *hotplug,
>  int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler,
>  				       const char *hotplug_profile_name);
>  void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, boo=
l val);
> +bool acpi_scan_check_handler(const struct acpi_device *adev,
> +			     struct acpi_scan_handler *handler);
> =20
>  #ifdef CONFIG_DEBUG_FS
>  extern struct dentry *acpi_debugfs_dir;
> @@ -107,7 +109,6 @@ int acpi_device_setup_files(struct acpi_device *dev);
>  void acpi_device_remove_files(struct acpi_device *dev);
>  void acpi_device_add_finalize(struct acpi_device *device);
>  void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
> -bool acpi_device_is_present(const struct acpi_device *adev);
>  bool acpi_device_is_battery(struct acpi_device *adev);
>  bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>  					const struct device *dev);
> @@ -119,6 +120,7 @@ int acpi_bus_register_early_device(int type);
>  const struct acpi_device *acpi_companion_match(const struct device *dev);
>  int __acpi_device_uevent_modalias(const struct acpi_device *adev,
>  				  struct kobj_uevent_env *env);
> +bool acpi_device_is_processor(const struct acpi_device *adev);
> =20
>  /* ---------------------------------------------------------------------=
-----
>                                    Power Resource
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 6979a3f9f90a..14d6948fd88a 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1420,7 +1420,7 @@ static bool acpi_fwnode_device_is_available(const s=
truct fwnode_handle *fwnode)
>  	if (!is_acpi_device_node(fwnode))
>  		return false;
> =20
> -	return acpi_device_is_present(to_acpi_device_node(fwnode));
> +	return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnode));
>  }
> =20
>  static const void *
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 02bb2cce423f..f94d1f744bcc 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device =
*adev)
>  	int error;
> =20
>  	acpi_bus_get_status(adev);
> -	if (acpi_device_is_present(adev)) {
> +	if (acpi_dev_ready_for_enumeration(adev)) {
>  		/*
>  		 * This function is only called for device objects for which
>  		 * matching scan handlers exist.  The only situation in which
> @@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *ad=
ev, void *not_used)
>  	int error;
> =20
>  	acpi_bus_get_status(adev);
> -	if (!acpi_device_is_present(adev)) {
> +	if (!acpi_dev_ready_for_enumeration(adev)) {
>  		acpi_scan_device_not_enumerated(adev);
>  		return 0;
>  	}
> @@ -1913,11 +1913,6 @@ static bool acpi_device_should_be_hidden(acpi_hand=
le handle)
>  	return true;
>  }
> =20
> -bool acpi_device_is_present(const struct acpi_device *adev)
> -{
> -	return adev->status.present || adev->status.functional;
> -}
> -
>  static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
>  				       const char *idstr,
>  				       const struct acpi_device_id **matchid)
> @@ -1938,6 +1933,18 @@ static bool acpi_scan_handler_matching(struct acpi=
_scan_handler *handler,
>  	return false;
>  }
> =20
> +bool acpi_scan_check_handler(const struct acpi_device *adev,
> +			     struct acpi_scan_handler *handler)
> +{
> +	struct acpi_hardware_id *hwid;
> +
> +	list_for_each_entry(hwid, &adev->pnp.ids, list)
> +		if (acpi_scan_handler_matching(handler, hwid->id, NULL))
> +			return true;
> +
> +	return false;
> +}
> +
>  static struct acpi_scan_handler *acpi_scan_match_handler(const char *ids=
tr,
>  					const struct acpi_device_id **matchid)
>  {
> @@ -2381,16 +2388,38 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
>   * acpi_dev_ready_for_enumeration - Check if the ACPI device is ready fo=
r enumeration
>   * @device: Pointer to the &struct acpi_device to check
>   *
> - * Check if the device is present and has no unmet dependencies.
> + * Check if the device is functional or enabled and has no unmet depende=
ncies.
>   *
> - * Return true if the device is ready for enumeratino. Otherwise, return=
 false.
> + * Return true if the device is ready for enumeration. Otherwise, return=
 false.
>   */
>  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
>  {
>  	if (device->flags.honor_deps && device->dep_unmet)
>  		return false;
> =20
> -	return acpi_device_is_present(device);
> +	/*
> +	 * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to return
> +	 * (!present && functional) for certain types of devices that should be
> +	 * enumerated. Note that the enabled bit should not be set unless the
> +	 * present bit is set.
> +	 *
> +	 * However, limit this only to processor devices to reduce possible
> +	 * regressions with firmware.
> +	 */
> +	if (device->status.functional)
> +		return true;
> +
> +	if (!device->status.present)
> +		return false;
> +
> +	/*
> +	 * Fast path - if enabled is set, avoid the more expensive test to
> +	 * check whether this device is a processor.
> +	 */
> +	if (device->status.enabled)
> +		return true;
> +
> +	return !acpi_device_is_processor(device);
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
> =20


