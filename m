Return-Path: <linux-arch+bounces-3742-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738968A8124
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 12:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A13E284B1D
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 10:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B13C13C667;
	Wed, 17 Apr 2024 10:39:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2E1386B3;
	Wed, 17 Apr 2024 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350394; cv=none; b=X6a2K2X1KBLSjqIWMy/FgW3tWkirZsKchtf23Lf094ivZcLWX/yoTyUgfH+9eQWnYdX+a1VFmS8e4LirCtkpc4rnKPrguU+FP1/jHmw7q46oqwJCkAD6Nt1rALU05Uf4mQ7TYwscgWk3RHCVECHih8X3lCnGK2RKXUGpWEu/ZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350394; c=relaxed/simple;
	bh=/XtRZN0ydfLzBjIUi0ukfwL5IcMWRM7rSQeDti6Shk4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9TtkrhxMJcRrVFFt8h89/V3ASP21nSjplc4r8cenk6GhV4owuGwI9ipwoz7GfS930HTXT5ogys/1/LiKZh2Aoi4mRq0e2VZs1vjkp3V2KkHSzom9lYBUiYz4ozv0p6jiMxmirxvFZ9hxS9W8+VuJ418/uj+3WDDNdiaKhhfBAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKHRc1ST4z6JB7k;
	Wed, 17 Apr 2024 18:37:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C2D22140A46;
	Wed, 17 Apr 2024 18:39:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 11:39:47 +0100
Date: Wed, 17 Apr 2024 11:39:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
Message-ID: <20240417113946.00000edb@Huawei.com>
In-Reply-To: <CAJZ5v0iK61_ihUZX_tXoSGdhpYDWFhEBbEuFf6WFiiD0QSeTDg@mail.gmail.com>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
	<20240412143719.11398-4-Jonathan.Cameron@huawei.com>
	<CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
	<ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk>
	<87bk6ez4hj.ffs@tglx>
	<ZhmtO6zBExkQGZLk@shell.armlinux.org.uk>
	<878r1iyxkr.ffs@tglx>
	<20240415094552.000008d7@Huawei.com>
	<CAJZ5v0ireu4pOedLjMjK2NrLkq_2vySpdgEgGccQEiFC5=otWQ@mail.gmail.com>
	<20240415125649.00001354@huawei.com>
	<CAJZ5v0iNSmV6EsBOc5oYWSTR9UvFOeg8_mj8Ofhum4Tonb3kNQ@mail.gmail.com>
	<20240415132351.00007439@huawei.com>
	<20240416184116.0000513c@huawei.com>
	<CAJZ5v0iK61_ihUZX_tXoSGdhpYDWFhEBbEuFf6WFiiD0QSeTDg@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 16 Apr 2024 21:02:02 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Apr 16, 2024 at 7:41=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 15 Apr 2024 13:23:51 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > =20
> > > On Mon, 15 Apr 2024 14:04:26 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote: =20
>=20
> [cut]
>=20
> > > > > I'm still very much stuck on the hotadd_init flag however, so any=
 suggestions
> > > > > on that would be very welcome! =20
> > > >
> > > > I need to do some investigation which will take some time I suppose=
. =20
> > >
> > > I'll do so as well once I've gotten the rest sorted out.  That whole
> > > structure seems overly complex and liable to race, though maybe suffi=
cient
> > > locking happens to be held that it's not a problem. =20
> >
> > Back to this a (maybe) last outstanding problem.
> >
> > Superficially I think we might be able to get around this by always
> > doing the setup in the initial online. In brief that looks something the
> > below code.  Relying on the cpu hotplug callback registration calling
> > the acpi_soft_cpu_online for all instances that are already online.
> >
> > Very lightly tested on arm64 and x86 with cold and hotplugged CPUs.
> > However this is all in emulation and I don't have access to any signifi=
cant
> > x86 test farms :( So help will be needed if it's not immediately obviou=
s why
> > we can't do this. =20
>=20
> AFAICS, this should work.  At least I don't see why it wouldn't.
>=20
> > Of course, I'm open to other suggestions!
> >
> > For now I'll put a tidied version of this one is as an RFC with the res=
t of v6.
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processo=
r.c
> > index 06e718b650e5..97ca53b516d0 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -340,7 +340,7 @@ static int acpi_processor_get_info(struct acpi_devi=
ce *device)
> >          */
> >         per_cpu(processor_device_array, pr->id) =3D device;
> >         per_cpu(processors, pr->id) =3D pr;
> > -
> > +       pr->flags.need_hotplug_init =3D 1;
> >         /*
> >          *  Extra Processor objects may be enumerated on MP systems with
> >          *  less than the max # of CPUs. They should be ignored _iff
> > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_d=
river.c
> > index 67db60eda370..930f911fc435 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -206,7 +206,7 @@ static int acpi_processor_start(struct device *dev)
> >
> >         /* Protect against concurrent CPU hotplug operations */
> >         cpu_hotplug_disable();
> > -       ret =3D __acpi_processor_start(device);
> > +       //      ret =3D __acpi_processor_start(device);
> >         cpu_hotplug_enable();
> >         return ret;
> >  } =20
>=20
> So it looks like acpi_processor_start() is not necessary any more, is it?

Absolutely.  This needs cleaning up beyond this hack.

Given pr has been initialized to 0, flipping the flag to be something
like 'initialized' and having the driver set it on first online rather than
in acpi_processor.c will clean it up further.

Jonathan
>=20
> > @@ -279,7 +279,7 @@ static int __init acpi_processor_driver_init(void)
> >         if (result < 0)
> >                 return result;
> >
> > -       result =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> > +       result =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> >                                            "acpi/cpu-drv:online",
> >                                            acpi_soft_cpu_online, NULL);
> >         if (result < 0) =20
> > >
> > > Jonathan =20
>=20
> Thanks!


