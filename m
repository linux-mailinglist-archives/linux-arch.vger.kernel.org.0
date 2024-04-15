Return-Path: <linux-arch+bounces-3697-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598788A56C1
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 17:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE301C21388
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF5A7C085;
	Mon, 15 Apr 2024 15:49:02 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C509529414;
	Mon, 15 Apr 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196142; cv=none; b=l1fSsgS5rAX9GAlXXnwc0mSgijcTiiLMfbnrOYVxszzwt7UmaoDZjd2JsnGyx1M5eW1T9irl88sOrRiVzJtpJV43I9ou9PAVyK8nj1aGOtCg7uZyFE2B+yDxCjEhB+w4w2gP7gWyQMOoBu7QgSwarhEaZd0/bsE7yv+bYeGmLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196142; c=relaxed/simple;
	bh=vckgdI60nnlCSg5BIZOilFflwMtdNqSLeCq6LHe17G4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqiukTx+uV917eXhw9N1i0RErGxbTY2SzKuHuBncCu99aqJ0j79tocp1PRnmwgDpfcikD6pUG4wq1zbeZyLnYsOnurwBKxJso+CbyiZiq9Kr/nq4vFoZ321Q6Cg9Z8P1+9bXjOIMv7RCN41LHb3VbycMi8HoEIJpfkyULlKCKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VJBPK5lr5z6D8gk;
	Mon, 15 Apr 2024 23:47:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D426140CF4;
	Mon, 15 Apr 2024 23:48:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Apr
 2024 16:48:55 +0100
Date: Mon, 15 Apr 2024 16:48:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: Re: [PATCH v5 02/18] ACPI: processor: Set the ACPI_COMPANION for
 the struct cpu instance
Message-ID: <20240415164854.0000264f@Huawei.com>
In-Reply-To: <CAJZ5v0izN5naWY7sTi16whds9ubXkLpgqV2gePQs869BoJTCDA@mail.gmail.com>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
	<20240412143719.11398-3-Jonathan.Cameron@huawei.com>
	<CAJZ5v0izN5naWY7sTi16whds9ubXkLpgqV2gePQs869BoJTCDA@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 12 Apr 2024 20:10:54 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Fri, Apr 12, 2024 at 4:38=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > The arm64 specific arch_register_cpu() needs to access the _STA
> > method of the DSDT object so make it available by assigning the
> > appropriate handle to the struct cpu instance.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/acpi/acpi_processor.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processo=
r.c
> > index 7a0dd35d62c9..93e029403d05 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -235,6 +235,7 @@ static int acpi_processor_get_info(struct acpi_devi=
ce *device)
> >         union acpi_object object =3D { 0 };
> >         struct acpi_buffer buffer =3D { sizeof(union acpi_object), &obj=
ect };
> >         struct acpi_processor *pr =3D acpi_driver_data(device);
> > +       struct cpu *c;
> >         int device_declaration =3D 0;
> >         acpi_status status =3D AE_OK;
> >         static int cpu0_initialized;
> > @@ -314,6 +315,8 @@ static int acpi_processor_get_info(struct acpi_devi=
ce *device)
> >                         cpufreq_add_device("acpi-cpufreq");
> >         }
> >
> > +       c =3D &per_cpu(cpu_devices, pr->id);
> > +       ACPI_COMPANION_SET(&c->dev, device); =20
>=20
> This is also set for per_cpu(cpu_sys_devices, pr->id) in
> acpi_processor_add(), via acpi_bind_one().

Hi Rafael,

cpu_sys_devices gets filled with a pointer to this same structure.
The contents gets set in register_cpu() so at this point
it doesn't point anywhere.  As a side note register_cpu()
memsets to zero the value I set it to in the code above which isn't
great, particularly as I want to use this in post_eject for
arm64.

We could make a copy of the handle and put it back after
the memset in register_cpu() but that is also ugly.
It's the best I've come up with to make sure this is still set
come remove time but is rather odd.

>=20
> Moreover, there is some pr->id validation in acpi_processor_add(), so
> it seems premature to use it here this way.
>=20
> I think that ACPI_COMPANION_SET() should be called from here on
> per_cpu(cpu_sys_devices, pr->id) after validating pr->id (so the
> pr->id validation should all be done here) and then NULL can be passed
> as acpi_dev to acpi_bind_one() in acpi_processor_add().  Then, there
> will be one physical device corresponding to the processor ACPI device
> and no confusion.

I'm fairly sure this is pointing to the same device but agreed this
is a tiny bit confusing. However we can't use cpu_sys_devices at this point
so I'm not immediately seeing a cleaner solution :(

Jonathan

>=20
> >         /*
> >          *  Extra Processor objects may be enumerated on MP systems with
> >          *  less than the max # of CPUs. They should be ignored _iff
> > --
> > 2.39.2
> > =20


