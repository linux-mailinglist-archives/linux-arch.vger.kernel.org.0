Return-Path: <linux-arch+bounces-3733-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219528A7274
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 19:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34011F23255
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 17:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7EB133422;
	Tue, 16 Apr 2024 17:35:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF311327FB;
	Tue, 16 Apr 2024 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288910; cv=none; b=FjMQWTKT78d7YKHeWMqIdCDxzYNeemwk/I8yyv5uHlbuwC+A2DojC2LhvROT5pklawV0wpk82iJcUJaiKkAS5hCMObE7Zv0rf3YADgo26mTlXxB5+rWujaYBq2+aB7W779VWoiw494rsikPTK8B/7kgpfmtpyZKVr+U6rtz8nKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288910; c=relaxed/simple;
	bh=Z7BK1ffY1oFsL11vJXHcwMHmQHUgwlPvHa/5kupznIc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rd2fGRHEhYMLy2hPL0iPECZ5e7lUIJ7LJBHbvhBCCdi7/FpFxmMicltBdLK47qdL5sMdyC2uNracLnLiVwrkqGdX8YHpN72UP7pdUdbxFpy6FAOGBDSzzetX0603wMf1o8CVOeisgTAA0QO6t7NwVGijzDQYCFMS7SiQkoBOgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VJrdq4sLxz6K8xC;
	Wed, 17 Apr 2024 01:30:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 185F11400D3;
	Wed, 17 Apr 2024 01:35:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Apr
 2024 18:35:03 +0100
Date: Tue, 16 Apr 2024 18:35:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linuxarm@huawei.com>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Miguel Luis
	<miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: Re: [PATCH v5 02/18] ACPI: processor: Set the ACPI_COMPANION for
 the struct cpu instance
Message-ID: <20240416183502.00007527@Huawei.com>
In-Reply-To: <CAJZ5v0huAAa5UpK4kqR-Uz4ALfY-wQ-gv7CC8C-kx9UDFvCgUw@mail.gmail.com>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
	<20240412143719.11398-3-Jonathan.Cameron@huawei.com>
	<CAJZ5v0izN5naWY7sTi16whds9ubXkLpgqV2gePQs869BoJTCDA@mail.gmail.com>
	<20240415164854.0000264f@Huawei.com>
	<CAJZ5v0hd+CNsnH9xY+UX0iy_AEaqUqJj4KdR=+yvtvy5FQEy5Q@mail.gmail.com>
	<CAJZ5v0j6gMaHamrCvrF8s+SgC0QVtG+naXhA4Dwg0t1YJvh4Uw@mail.gmail.com>
	<20240415175057.00002e11@Huawei.com>
	<20240415183454.000072f6@Huawei.com>
	<CAJZ5v0huAAa5UpK4kqR-Uz4ALfY-wQ-gv7CC8C-kx9UDFvCgUw@mail.gmail.com>
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

On Mon, 15 Apr 2024 19:41:43 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Mon, Apr 15, 2024 at 7:35=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 15 Apr 2024 17:50:57 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > =20
> > > On Mon, 15 Apr 2024 18:19:17 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > =20
> > > > On Mon, Apr 15, 2024 at 6:16=E2=80=AFPM Rafael J. Wysocki <rafael@k=
ernel.org> wrote: =20
> > > > >
> > > > > On Mon, Apr 15, 2024 at 5:49=E2=80=AFPM Jonathan Cameron
> > > > > <Jonathan.Cameron@huawei.com> wrote: =20
> > > > > >
> > > > > > On Fri, 12 Apr 2024 20:10:54 +0200
> > > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > > > =20
> > > > > > > On Fri, Apr 12, 2024 at 4:38=E2=80=AFPM Jonathan Cameron
> > > > > > > <Jonathan.Cameron@huawei.com> wrote: =20
> > > > > > > >
> > > > > > > > The arm64 specific arch_register_cpu() needs to access the =
_STA
> > > > > > > > method of the DSDT object so make it available by assigning=
 the
> > > > > > > > appropriate handle to the struct cpu instance.
> > > > > > > >
> > > > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.co=
m>
> > > > > > > > ---
> > > > > > > >  drivers/acpi/acpi_processor.c | 3 +++
> > > > > > > >  1 file changed, 3 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/a=
cpi_processor.c
> > > > > > > > index 7a0dd35d62c9..93e029403d05 100644
> > > > > > > > --- a/drivers/acpi/acpi_processor.c
> > > > > > > > +++ b/drivers/acpi/acpi_processor.c
> > > > > > > > @@ -235,6 +235,7 @@ static int acpi_processor_get_info(stru=
ct acpi_device *device)
> > > > > > > >         union acpi_object object =3D { 0 };
> > > > > > > >         struct acpi_buffer buffer =3D { sizeof(union acpi_o=
bject), &object };
> > > > > > > >         struct acpi_processor *pr =3D acpi_driver_data(devi=
ce);
> > > > > > > > +       struct cpu *c;
> > > > > > > >         int device_declaration =3D 0;
> > > > > > > >         acpi_status status =3D AE_OK;
> > > > > > > >         static int cpu0_initialized;
> > > > > > > > @@ -314,6 +315,8 @@ static int acpi_processor_get_info(stru=
ct acpi_device *device)
> > > > > > > >                         cpufreq_add_device("acpi-cpufreq");
> > > > > > > >         }
> > > > > > > >
> > > > > > > > +       c =3D &per_cpu(cpu_devices, pr->id);
> > > > > > > > +       ACPI_COMPANION_SET(&c->dev, device); =20
> > > > > > >
> > > > > > > This is also set for per_cpu(cpu_sys_devices, pr->id) in
> > > > > > > acpi_processor_add(), via acpi_bind_one(). =20
> > > > > >
> > > > > > Hi Rafael,
> > > > > >
> > > > > > cpu_sys_devices gets filled with a pointer to this same structu=
re.
> > > > > > The contents gets set in register_cpu() so at this point
> > > > > > it doesn't point anywhere.  As a side note register_cpu()
> > > > > > memsets to zero the value I set it to in the code above which i=
sn't
> > > > > > great, particularly as I want to use this in post_eject for
> > > > > > arm64.
> > > > > >
> > > > > > We could make a copy of the handle and put it back after
> > > > > > the memset in register_cpu() but that is also ugly.
> > > > > > It's the best I've come up with to make sure this is still set
> > > > > > come remove time but is rather odd. =20
> > > > > > >
> > > > > > > Moreover, there is some pr->id validation in acpi_processor_a=
dd(), so
> > > > > > > it seems premature to use it here this way.
> > > > > > >
> > > > > > > I think that ACPI_COMPANION_SET() should be called from here =
on
> > > > > > > per_cpu(cpu_sys_devices, pr->id) after validating pr->id (so =
the
> > > > > > > pr->id validation should all be done here) and then NULL can =
be passed
> > > > > > > as acpi_dev to acpi_bind_one() in acpi_processor_add().  Then=
, there
> > > > > > > will be one physical device corresponding to the processor AC=
PI device
> > > > > > > and no confusion. =20
> > > > > >
> > > > > > I'm fairly sure this is pointing to the same device but agreed =
this
> > > > > > is a tiny bit confusing. However we can't use cpu_sys_devices a=
t this point
> > > > > > so I'm not immediately seeing a cleaner solution :( =20
> > > > >
> > > > > Well, OK.
> > > > >
> > > > > Please at least consider doing the pr->id validation checks before
> > > > > setting the ACPI companion for &per_cpu(cpu_devices, pr->id).
> > > > >
> > > > > Also, acpi_bind_one() needs to be called on the "physical" devices
> > > > > passed to ACPI_COMPANION_SET() (with NULL as the second argument)=
 for
> > > > > the reference counting and physical device lookup to work.
> > > > >
> > > > > Please also note that acpi_primary_dev_companion() should return
> > > > > per_cpu(cpu_sys_devices, pr->id) for the processor ACPI device, w=
hich
> > > > > depends on the order of acpi_bind_one() calls involving the same =
ACPI
> > > > > device. =20
> > > >
> > > > Of course, if the value set by ACPI_COMPANION_SET() is cleared
> > > > subsequently, the above is not needed, but then using
> > > > ACPI_COMPANION_SET() is questionable overall. =20
> > >
> > > Agreed + smoothing over that by stashing and putting it back doesn't
> > > work because there is an additional call to acpi_bind_one() inbetween
> > > here and the one you reference.
> > >
> > > The arch_register_cpu() calls end up calling register_cpu() /
> > > device_register() / acpi_device_notify() / acpi_bind_one()
> > >
> > > With current code that fails (silently) =20
>=20
> And that's why there is an explicit acpi_bind_one() invocation in
> acpi_processor_add().
>=20
> > > If I make sure the handle is set before register_cpu() then it
> > > succeeds, but we end up with duplicate sysfs files etc because we
> > > bind twice. =20
>=20
> Right, I should have recalled that earlier.
>=20
> > > I think the only way around this is larger reorganization of the
> > > CPU hotplug code to pull the arch_register_cpu() call to where
> > > the acpi_bind_one() call is.  However that changes a lot more than I'=
d like
> > > (and I don't have it working yet). =20
>=20
> I see.
>=20
> > > Alternatively find somewhere else to stash the handle, or just add it=
 as
> > > a parameter to arch_register_cpu(). Right now this feels the easier
> > > path to me. arch_register_cpu(int cpu, acpi_handle handle)
> > >
> > > Would that be a path you'd consider? =20
> >
> > Another option would be to do the per_cpu(processors, pr->id) =3D pr
> > a few lines earlier than currently and access that directly from the
> > arch_register_cpu() call.  Similarly remove that reference a bit later =
and
> > use it in arch_unregister_cpu().
> >
> > This seems like the simplest solution, but I may be missing something. =
=20
>=20
> This should work AFAICS, but I'd move the entire piece of code between
> BUG_ON() and setting per_cpu(processors, pr->id) inclusive:

Hi Rafael,

Unfortunately this is more complex on x86 than I realized :(

On x86 the initial pr->id is invalid, which is one of the conditions
that leads to acpi_processor_hotadd_init() being called.
It only become valid after acpi_map_cpu() in acpi_processor_hotadd_init().

So the best I can immediately come up with is to factor out these checks an=
d the
setting of the per_cpu structures and set them either in acpi_processor_hot=
add_init()
or in an else for the non hotplug / normal registration path (where the pr-=
>id is valid).

Naturally found this on my final set of tests...

A little ugly but not 'too bad'.=20

Jonathan
p.s. No one minds if I break x86, right?





>=20
>     BUG_ON(pr->id >=3D nr_cpu_ids);
>=20
>     /*
>      * Buggy BIOS check.
>      * ACPI id of processors can be reported wrongly by the BIOS.
>      * Don't trust it blindly
>      */
>     if (per_cpu(processor_device_array, pr->id) !=3D NULL &&
>         per_cpu(processor_device_array, pr->id) !=3D device) {
>         dev_warn(&device->dev,
>             "BIOS reported wrong ACPI id %d for the processor\n",
>             pr->id);
>         /* Give up, but do not abort the namespace scan. */
>         goto err;
>     }
>     /*
>      * processor_device_array is not cleared on errors to allow buggy BIOS
>      * checks.
>      */
>     per_cpu(processor_device_array, pr->id) =3D device;
>     per_cpu(processors, pr->id) =3D pr;
>=20
> into acpi_processor_get_info(), right after the point where pr->id is set.


