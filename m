Return-Path: <linux-arch+bounces-2479-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCEE85A013
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 10:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CAD1F229C7
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43D524A08;
	Mon, 19 Feb 2024 09:45:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB972375D;
	Mon, 19 Feb 2024 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335918; cv=none; b=vEzQdW/H3kQimOGN401qOJoTrRExSAeUmsLqg+dvezjtuBA5C6fwBPWYqA3zDBKik+tb/eS/ikOS5AmDhB+xomxc43XNRI4OsCpklTaK48uJ4NtoXlrlaXu25/21OwYvJCc4NPRmpcC2LVoiLuLJCIHO7CfR0X2OOSRfkZEOuZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335918; c=relaxed/simple;
	bh=QJM4j0j0pchCDOEJ6x+rLSknxQZs8Iclh87YDcHRPKc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Furk+Ji464h3OqbE+qYJZPK9bXtLQTAhVCN48jwEdWbws39q/4N3hoaVHwGyB5aV7KIs5BGbAyIz/VKH/IwaedqJU7kbIwlujbOU1bEtsLsW6l1IVimlZsFtsgaVjhBJOw/wuYG1QRZ/V/DFWv/Ao0Gy9MMppqQTMrtfmKkzxMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdcxZ6qlqz6K97K;
	Mon, 19 Feb 2024 17:41:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E8D83140DDB;
	Mon, 19 Feb 2024 17:45:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 09:45:11 +0000
Date: Mon, 19 Feb 2024 09:45:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, <linux-csky@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, <jianyong.wu@arm.com>,
	<justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v4 01/15] ACPI: Only enumerate enabled (or
 functional) processor devices
Message-ID: <20240219094510.00004843@Huawei.com>
In-Reply-To: <CAJZ5v0hY_LXp41WMVPhiLosPe7YVzF38Uz=EhmJqVwqFn==Upw@mail.gmail.com>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
	<E1rVDmP-0027YJ-EW@rmk-PC.armlinux.org.uk>
	<CAJZ5v0hY_LXp41WMVPhiLosPe7YVzF38Uz=EhmJqVwqFn==Upw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 21:10:39 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Jan 31, 2024 at 5:49=E2=80=AFPM Russell King <rmk+kernel@armlinux=
.org.uk> wrote:
> >
> > From: James Morse <james.morse@arm.com>
> >
> > Today the ACPI enumeration code 'visits' all devices that are present.
> >
> > This is a problem for arm64, where CPUs are always present, but not
> > always enabled. When a device-check occurs because the firmware-policy
> > has changed and a CPU is now enabled, the following error occurs:
> > | acpi ACPI0007:48: Enumeration failure
> >
> > This is ultimately because acpi_dev_ready_for_enumeration() returns
> > true for a device that is not enabled. The ACPI Processor driver
> > will not register such CPUs as they are not 'decoding their resources'.
> >
> > ACPI allows a device to be functional instead of maintaining the
> > present and enabled bit, but we can't simply check the enabled bit
> > for all devices since firmware can be buggy.
> >
> > If ACPI indicates that the device is present and enabled, then all well
> > and good, we can enumate it. However, if the device is present and not
> > enabled, then we also check whether the device is a processor device
> > to limit the impact of this new check to just processor devices.
> >
> > This avoids enumerating present && functional processor devices that
> > are not enabled.
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Co-developed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > Changes since RFC v2:
> >  * Incorporate comment suggestion by Gavin Shan.
> > Changes since RFC v3:
> >  * Fixed "sert" typo.
> > Changes since RFC v3 (smaller series):
> >  * Restrict checking the enabled bit to processor devices, update
> >    commit comments.
> >  * Use Rafael's suggestion in
> >    https://lore.kernel.org/r/5760569.DvuYhMxLoT@kreacher
> >  * Updated with a fix - see:
> >    https://lore.kernel.org/all/Zbe8WQRASx6D6RaG@shell.armlinux.org.uk/
> > ---
> >  drivers/acpi/acpi_processor.c | 11 +++++++++
> >  drivers/acpi/device_pm.c      |  2 +-
> >  drivers/acpi/device_sysfs.c   |  2 +-
> >  drivers/acpi/internal.h       |  4 ++-
> >  drivers/acpi/property.c       |  2 +-
> >  drivers/acpi/scan.c           | 46 +++++++++++++++++++++++++++--------
> >  6 files changed, 53 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processo=
r.c
> > index 4fe2ef54088c..cf7c1cca69dd 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -626,6 +626,17 @@ static struct acpi_scan_handler processor_handler =
=3D {
> >         },
> >  };
> >
> > +bool acpi_device_is_processor(const struct acpi_device *adev)
> > +{
> > +       if (adev->device_type =3D=3D ACPI_BUS_TYPE_PROCESSOR)
> > +               return true;
> > +
> > +       if (adev->device_type !=3D ACPI_BUS_TYPE_DEVICE)
> > +               return false;
> > +
> > +       return acpi_scan_check_handler(adev, &processor_handler);
> > +}
> > +
> >  static int acpi_processor_container_attach(struct acpi_device *dev,
> >                                            const struct acpi_device_id =
*id)
> >  {
> > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> > index 3b4d048c4941..e3c80f3b3b57 100644
> > --- a/drivers/acpi/device_pm.c
> > +++ b/drivers/acpi/device_pm.c
> > @@ -313,7 +313,7 @@ int acpi_bus_init_power(struct acpi_device *device)
> >                 return -EINVAL;
> >
> >         device->power.state =3D ACPI_STATE_UNKNOWN;
> > -       if (!acpi_device_is_present(device)) {
> > +       if (!acpi_dev_ready_for_enumeration(device)) {
> >                 device->flags.initialized =3D false;
> >                 return -ENXIO;
> >         }
> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index 23373faa35ec..a0256d2493a7 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -141,7 +141,7 @@ static int create_pnp_modalias(const struct acpi_de=
vice *acpi_dev, char *modalia
> >         struct acpi_hardware_id *id;
> >
> >         /* Avoid unnecessarily loading modules for non present devices.=
 */
> > -       if (!acpi_device_is_present(acpi_dev))
> > +       if (!acpi_dev_ready_for_enumeration(acpi_dev))
> >                 return 0;
> >
> >         /*
> > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > index 6588525c45ef..1bc8b6db60c5 100644
> > --- a/drivers/acpi/internal.h
> > +++ b/drivers/acpi/internal.h
> > @@ -62,6 +62,8 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotpl=
ug_profile *hotplug,
> >  int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handl=
er,
> >                                        const char *hotplug_profile_name=
);
> >  void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, b=
ool val);
> > +bool acpi_scan_check_handler(const struct acpi_device *adev,
> > +                            struct acpi_scan_handler *handler);
> >
> >  #ifdef CONFIG_DEBUG_FS
> >  extern struct dentry *acpi_debugfs_dir;
> > @@ -121,7 +123,6 @@ int acpi_device_setup_files(struct acpi_device *dev=
);
> >  void acpi_device_remove_files(struct acpi_device *dev);
> >  void acpi_device_add_finalize(struct acpi_device *device);
> >  void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
> > -bool acpi_device_is_present(const struct acpi_device *adev);
> >  bool acpi_device_is_battery(struct acpi_device *adev);
> >  bool acpi_device_is_first_physical_node(struct acpi_device *adev,
> >                                         const struct device *dev);
> > @@ -133,6 +134,7 @@ int acpi_bus_register_early_device(int type);
> >  const struct acpi_device *acpi_companion_match(const struct device *de=
v);
> >  int __acpi_device_uevent_modalias(const struct acpi_device *adev,
> >                                   struct kobj_uevent_env *env);
> > +bool acpi_device_is_processor(const struct acpi_device *adev);
> >
> >  /* -------------------------------------------------------------------=
-------
> >                                    Power Resource
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index a6ead5204046..9f8d54038770 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -1486,7 +1486,7 @@ static bool acpi_fwnode_device_is_available(const=
 struct fwnode_handle *fwnode)
> >         if (!is_acpi_device_node(fwnode))
> >                 return false;
> >
> > -       return acpi_device_is_present(to_acpi_device_node(fwnode));
> > +       return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnod=
e));
> >  }
> >
> >  static const void *
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index e6ed1ba91e5c..fd2e8b3a5749 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_devic=
e *adev)
> >         int error;
> >
> >         acpi_bus_get_status(adev);
> > -       if (acpi_device_is_present(adev)) {
> > +       if (acpi_dev_ready_for_enumeration(adev)) {
> >                 /*
> >                  * This function is only called for device objects for =
which
> >                  * matching scan handlers exist.  The only situation in=
 which
> > @@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *=
adev, void *not_used)
> >         int error;
> >
> >         acpi_bus_get_status(adev);
> > -       if (!acpi_device_is_present(adev)) {
> > +       if (!acpi_dev_ready_for_enumeration(adev)) {
> >                 acpi_scan_device_not_enumerated(adev);
> >                 return 0;
> >         }
> > @@ -1917,11 +1917,6 @@ static bool acpi_device_should_be_hidden(acpi_ha=
ndle handle)
> >         return true;
> >  }
> >
> > -bool acpi_device_is_present(const struct acpi_device *adev)
> > -{
> > -       return adev->status.present || adev->status.functional;
> > -}
> > -
> >  static bool acpi_scan_handler_matching(struct acpi_scan_handler *handl=
er,
> >                                        const char *idstr,
> >                                        const struct acpi_device_id **ma=
tchid)
> > @@ -1942,6 +1937,18 @@ static bool acpi_scan_handler_matching(struct ac=
pi_scan_handler *handler,
> >         return false;
> >  }
> >
> > +bool acpi_scan_check_handler(const struct acpi_device *adev,
> > +                            struct acpi_scan_handler *handler)
> > +{
> > +       struct acpi_hardware_id *hwid;
> > +
> > +       list_for_each_entry(hwid, &adev->pnp.ids, list)
> > +               if (acpi_scan_handler_matching(handler, hwid->id, NULL))
> > +                       return true;
> > +
> > +       return false;
> > +}
> > +
> >  static struct acpi_scan_handler *acpi_scan_match_handler(const char *i=
dstr,
> >                                         const struct acpi_device_id **m=
atchid)
> >  {
> > @@ -2405,16 +2412,35 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
> >   * acpi_dev_ready_for_enumeration - Check if the ACPI device is ready =
for enumeration
> >   * @device: Pointer to the &struct acpi_device to check
> >   *
> > - * Check if the device is present and has no unmet dependencies.
> > + * Check if the device is functional or enabled and has no unmet depen=
dencies.
> >   *
> > - * Return true if the device is ready for enumeratino. Otherwise, retu=
rn false.
> > + * Return true if the device is ready for enumeration. Otherwise, retu=
rn false.
> >   */
> >  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
> >  {
> >         if (device->flags.honor_deps && device->dep_unmet)
> >                 return false;
> >
> > -       return acpi_device_is_present(device);
> > +       /*
> > +        * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to r=
eturn
> > +        * (!present && functional) for certain types of devices that s=
hould be
> > +        * enumerated. Note that the enabled bit should not be set unle=
ss the
> > +        * present bit is set.
> > +        *
> > +        * However, limit this only to processor devices to reduce poss=
ible
> > +        * regressions with firmware.
> > +        */
> > +       if (!device->status.present)
> > +               return device->status.functional;
> > +
> > +       /*
> > +        * Fast path - if enabled is set, avoid the more expensive test=
 to
> > +        * check whether this device is a processor.
> > +        */
> > +       if (device->status.enabled)
> > +               return true;
> > +
> > +       return !acpi_device_is_processor(device);
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
> >
> > -- =20
>=20
> I can queue this up for 6.9 as it looks like the rest of the series
> will still need some work.  What do you think?

The sooner this goes in the sooner we discover if some of the bios bug
workarounds we have dropped form the series are in reality necessary
(i.e. get it into big board test farms).

So I'm definitely keen to see this go in for 6.9.

Hopefully we can make rapid progress on the rest of the series and
hammer out which of the remaining subtle differences between
the two flows are real vs code evolution issues.

Jonathan

