Return-Path: <linux-arch+bounces-1232-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96378821DFD
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 15:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC19283925
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533312E74;
	Tue,  2 Jan 2024 14:39:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9614267;
	Tue,  2 Jan 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T4Fn71b29z6JB5q;
	Tue,  2 Jan 2024 22:37:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CBC821400DB;
	Tue,  2 Jan 2024 22:39:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Jan
 2024 14:39:27 +0000
Date: Tue, 2 Jan 2024 14:39:25 +0000
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
Message-ID: <20240102143925.00004361@Huawei.com>
In-Reply-To: <5760569.DvuYhMxLoT@kreacher>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk>
	<20231215161539.00000940@Huawei.com>
	<5760569.DvuYhMxLoT@kreacher>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 15 Dec 2023 20:47:31 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Friday, December 15, 2023 5:15:39 PM CET Jonathan Cameron wrote:
> > On Fri, 15 Dec 2023 15:31:55 +0000
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >  =20
> > > On Thu, Dec 14, 2023 at 07:37:10PM +0100, Rafael J. Wysocki wrote: =20
> > > > On Thu, Dec 14, 2023 at 7:16=E2=80=AFPM Rafael J. Wysocki <rafael@k=
ernel.org> wrote:   =20
> > > > >
> > > > > On Thu, Dec 14, 2023 at 7:10=E2=80=AFPM Russell King (Oracle)
> > > > > <linux@armlinux.org.uk> wrote:   =20
> > > > > > I guess we need something like:
> > > > > >
> > > > > >         if (device->status.present)
> > > > > >                 return device->device_type !=3D ACPI_BUS_TYPE_P=
ROCESSOR ||
> > > > > >                        device->status.enabled;
> > > > > >         else
> > > > > >                 return device->status.functional;
> > > > > >
> > > > > > so we only check device->status.enabled for processor-type devi=
ces?   =20
> > > > >
> > > > > Yes, something like this.   =20
> > > >=20
> > > > However, that is not sufficient, because there are
> > > > ACPI_BUS_TYPE_DEVICE devices representing processors.
> > > >=20
> > > > I'm not sure about a clean way to do it ATM.   =20
> > >=20
> > > Ok, how about:
> > >=20
> > > static bool acpi_dev_is_processor(const struct acpi_device *device)
> > > {
> > > 	struct acpi_hardware_id *hwid;
> > >=20
> > > 	if (device->device_type =3D=3D ACPI_BUS_TYPE_PROCESSOR)
> > > 		return true;
> > >=20
> > > 	if (device->device_type !=3D ACPI_BUS_TYPE_DEVICE)
> > > 		return false;
> > >=20
> > > 	list_for_each_entry(hwid, &device->pnp.ids, list)
> > > 		if (!strcmp(ACPI_PROCESSOR_OBJECT_HID, hwid->id) ||
> > > 		    !strcmp(ACPI_PROCESSOR_DEVICE_HID, hwid->id))
> > > 			return true;
> > >=20
> > > 	return false;
> > > }
> > >=20
> > > and then:
> > >=20
> > > 	if (device->status.present)
> > > 		return !acpi_dev_is_processor(device) || device->status.enabled;
> > > 	else
> > > 		return device->status.functional;
> > >=20
> > > ?
> > >  =20
> > Changing it to CPU only for now makes sense to me and I think this code=
 snippet should do the
> > job.  Nice and simple. =20
>=20
> Well, except that it does checks that are done elsewhere slightly
> differently, which from the maintenance POV is not nice.
>=20
> Maybe something like the appended patch (untested).

Hi Rafael,

As far as I can see that's functionally equivalent, so looks good to me.
I'm not set up to test this today though, so will defer to Russell on wheth=
er
there is anything missing

Thanks for putting this together.

Jonathan

>=20
> ---
>  drivers/acpi/acpi_processor.c |   11 +++++++++++
>  drivers/acpi/internal.h       |    3 +++
>  drivers/acpi/scan.c           |   24 +++++++++++++++++++++++-
>  3 files changed, 37 insertions(+), 1 deletion(-)
>=20
> Index: linux-pm/drivers/acpi/acpi_processor.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/acpi_processor.c
> +++ linux-pm/drivers/acpi/acpi_processor.c
> @@ -644,6 +644,17 @@ static struct acpi_scan_handler processo
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
> Index: linux-pm/drivers/acpi/internal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -62,6 +62,8 @@ void acpi_sysfs_add_hotplug_profile(stru
>  int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler,
>  				       const char *hotplug_profile_name);
>  void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, boo=
l val);
> +bool acpi_scan_check_handler(const struct acpi_device *adev,
> +			     struct acpi_scan_handler *handler);
> =20
>  #ifdef CONFIG_DEBUG_FS
>  extern struct dentry *acpi_debugfs_dir;
> @@ -133,6 +135,7 @@ int acpi_bus_register_early_device(int t
>  const struct acpi_device *acpi_companion_match(const struct device *dev);
>  int __acpi_device_uevent_modalias(const struct acpi_device *adev,
>  				  struct kobj_uevent_env *env);
> +bool acpi_device_is_processor(const struct acpi_device *adev);
> =20
>  /* ---------------------------------------------------------------------=
-----
>                                    Power Resource
> Index: linux-pm/drivers/acpi/scan.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1938,6 +1938,19 @@ static bool acpi_scan_handler_matching(s
>  	return false;
>  }
> =20
> +bool acpi_scan_check_handler(const struct acpi_device *adev,
> +			     struct acpi_scan_handler *handler)
> +{
> +	struct acpi_hardware_id *hwid;
> +
> +	list_for_each_entry(hwid, &adev->pnp.ids, list) {
> +		if (acpi_scan_handler_matching(handler, hwid->id, NULL))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static struct acpi_scan_handler *acpi_scan_match_handler(const char *ids=
tr,
>  					const struct acpi_device_id **matchid)
>  {
> @@ -2410,7 +2423,16 @@ bool acpi_dev_ready_for_enumeration(cons
>  	if (device->flags.honor_deps && device->dep_unmet)
>  		return false;
> =20
> -	return acpi_device_is_present(device);
> +	if (device->status.functional)
> +		return true;
> +
> +	if (!device->status.present)
> +		return false;
> +
> +	if (device->status.enabled)
> +		return true; /* Fast path. */
> +
> +	return !acpi_device_is_processor(device);
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
> =20
>=20
>=20
>=20


