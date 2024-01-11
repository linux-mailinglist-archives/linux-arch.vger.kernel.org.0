Return-Path: <linux-arch+bounces-1345-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C6182ABCF
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 11:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BEF1F224EF
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 10:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2643A1429F;
	Thu, 11 Jan 2024 10:20:02 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C801426C;
	Thu, 11 Jan 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T9gZf0gDvz6K8Kq;
	Thu, 11 Jan 2024 18:17:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C7501400CD;
	Thu, 11 Jan 2024 18:19:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Jan
 2024 10:19:50 +0000
Date: Thu, 11 Jan 2024 10:19:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>, "Rafael J. Wysocki"
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
Message-ID: <20240111101949.000075dc@Huawei.com>
In-Reply-To: <20240102143925.00004361@Huawei.com>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk>
	<20231215161539.00000940@Huawei.com>
	<5760569.DvuYhMxLoT@kreacher>
	<20240102143925.00004361@Huawei.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 2 Jan 2024 14:39:25 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 15 Dec 2023 20:47:31 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>=20
> > On Friday, December 15, 2023 5:15:39 PM CET Jonathan Cameron wrote: =20
> > > On Fri, 15 Dec 2023 15:31:55 +0000
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > >    =20
> > > > On Thu, Dec 14, 2023 at 07:37:10PM +0100, Rafael J. Wysocki wrote: =
  =20
> > > > > On Thu, Dec 14, 2023 at 7:16=E2=80=AFPM Rafael J. Wysocki <rafael=
@kernel.org> wrote:     =20
> > > > > >
> > > > > > On Thu, Dec 14, 2023 at 7:10=E2=80=AFPM Russell King (Oracle)
> > > > > > <linux@armlinux.org.uk> wrote:     =20
> > > > > > > I guess we need something like:
> > > > > > >
> > > > > > >         if (device->status.present)
> > > > > > >                 return device->device_type !=3D ACPI_BUS_TYPE=
_PROCESSOR ||
> > > > > > >                        device->status.enabled;
> > > > > > >         else
> > > > > > >                 return device->status.functional;
> > > > > > >
> > > > > > > so we only check device->status.enabled for processor-type de=
vices?     =20
> > > > > >
> > > > > > Yes, something like this.     =20
> > > > >=20
> > > > > However, that is not sufficient, because there are
> > > > > ACPI_BUS_TYPE_DEVICE devices representing processors.
> > > > >=20
> > > > > I'm not sure about a clean way to do it ATM.     =20
> > > >=20
> > > > Ok, how about:
> > > >=20
> > > > static bool acpi_dev_is_processor(const struct acpi_device *device)
> > > > {
> > > > 	struct acpi_hardware_id *hwid;
> > > >=20
> > > > 	if (device->device_type =3D=3D ACPI_BUS_TYPE_PROCESSOR)
> > > > 		return true;
> > > >=20
> > > > 	if (device->device_type !=3D ACPI_BUS_TYPE_DEVICE)
> > > > 		return false;
> > > >=20
> > > > 	list_for_each_entry(hwid, &device->pnp.ids, list)
> > > > 		if (!strcmp(ACPI_PROCESSOR_OBJECT_HID, hwid->id) ||
> > > > 		    !strcmp(ACPI_PROCESSOR_DEVICE_HID, hwid->id))
> > > > 			return true;
> > > >=20
> > > > 	return false;
> > > > }
> > > >=20
> > > > and then:
> > > >=20
> > > > 	if (device->status.present)
> > > > 		return !acpi_dev_is_processor(device) || device->status.enabled;
> > > > 	else
> > > > 		return device->status.functional;
> > > >=20
> > > > ?
> > > >    =20
> > > Changing it to CPU only for now makes sense to me and I think this co=
de snippet should do the
> > > job.  Nice and simple.   =20
> >=20
> > Well, except that it does checks that are done elsewhere slightly
> > differently, which from the maintenance POV is not nice.
> >=20
> > Maybe something like the appended patch (untested). =20
>=20
> Hi Rafael,
>=20
> As far as I can see that's functionally equivalent, so looks good to me.
> I'm not set up to test this today though, so will defer to Russell on whe=
ther
> there is anything missing
>=20
> Thanks for putting this together.

This is rather embarrassing...

I span this up on a QEMU instance with some prints to find out we need
the !acpi_device_is_processor() restriction.
On my 'random' test setup it fails on one device. ACPI0017 - which I
happen to know rather well. It's the weird pseudo device that lets
a CXL aware OS know there is a CEDT table to probe.

Whilst I really don't like that hack (it is all about making software
distribution of out of tree modules easier rather than something
fundamental), I'm the CXL QEMU maintainer :(

Will fix that, but it shows there is at least one broken firmware out
there.

On plus side, Rafael's code seems to work as expected and lets that
buggy firwmare carry on working :) So lets pretend the bug in qemu
is a deliberate test case!

Jonathan

p.s. My test setup blows up later for an unrelated reason with latest
kernel, so I'll be off debugging that for a while :(


>=20
> Jonathan
>=20
> >=20
> > ---
> >  drivers/acpi/acpi_processor.c |   11 +++++++++++
> >  drivers/acpi/internal.h       |    3 +++
> >  drivers/acpi/scan.c           |   24 +++++++++++++++++++++++-
> >  3 files changed, 37 insertions(+), 1 deletion(-)
> >=20
> > Index: linux-pm/drivers/acpi/acpi_processor.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/acpi_processor.c
> > +++ linux-pm/drivers/acpi/acpi_processor.c
> > @@ -644,6 +644,17 @@ static struct acpi_scan_handler processo
> >  	},
> >  };
> > =20
> > +bool acpi_device_is_processor(const struct acpi_device *adev)
> > +{
> > +	if (adev->device_type =3D=3D ACPI_BUS_TYPE_PROCESSOR)
> > +		return true;
> > +
> > +	if (adev->device_type !=3D ACPI_BUS_TYPE_DEVICE)
> > +		return false;
> > +
> > +	return acpi_scan_check_handler(adev, &processor_handler);
> > +}
> > +
> >  static int acpi_processor_container_attach(struct acpi_device *dev,
> >  					   const struct acpi_device_id *id)
> >  {
> > Index: linux-pm/drivers/acpi/internal.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/internal.h
> > +++ linux-pm/drivers/acpi/internal.h
> > @@ -62,6 +62,8 @@ void acpi_sysfs_add_hotplug_profile(stru
> >  int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handl=
er,
> >  				       const char *hotplug_profile_name);
> >  void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, b=
ool val);
> > +bool acpi_scan_check_handler(const struct acpi_device *adev,
> > +			     struct acpi_scan_handler *handler);
> > =20
> >  #ifdef CONFIG_DEBUG_FS
> >  extern struct dentry *acpi_debugfs_dir;
> > @@ -133,6 +135,7 @@ int acpi_bus_register_early_device(int t
> >  const struct acpi_device *acpi_companion_match(const struct device *de=
v);
> >  int __acpi_device_uevent_modalias(const struct acpi_device *adev,
> >  				  struct kobj_uevent_env *env);
> > +bool acpi_device_is_processor(const struct acpi_device *adev);
> > =20
> >  /* -------------------------------------------------------------------=
-------
> >                                    Power Resource
> > Index: linux-pm/drivers/acpi/scan.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -1938,6 +1938,19 @@ static bool acpi_scan_handler_matching(s
> >  	return false;
> >  }
> > =20
> > +bool acpi_scan_check_handler(const struct acpi_device *adev,
> > +			     struct acpi_scan_handler *handler)
> > +{
> > +	struct acpi_hardware_id *hwid;
> > +
> > +	list_for_each_entry(hwid, &adev->pnp.ids, list) {
> > +		if (acpi_scan_handler_matching(handler, hwid->id, NULL))
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  static struct acpi_scan_handler *acpi_scan_match_handler(const char *i=
dstr,
> >  					const struct acpi_device_id **matchid)
> >  {
> > @@ -2410,7 +2423,16 @@ bool acpi_dev_ready_for_enumeration(cons
> >  	if (device->flags.honor_deps && device->dep_unmet)
> >  		return false;
> > =20
> > -	return acpi_device_is_present(device);
> > +	if (device->status.functional)
> > +		return true;
> > +
> > +	if (!device->status.present)
> > +		return false;
> > +
> > +	if (device->status.enabled)
> > +		return true; /* Fast path. */
> > +
> > +	return !acpi_device_is_processor(device);
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
> > =20
> >=20
> >=20
> >  =20
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


