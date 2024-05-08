Return-Path: <linux-arch+bounces-4262-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BE78BF8F8
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 10:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDDA1C20DE8
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41C4524AF;
	Wed,  8 May 2024 08:44:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695FC9476;
	Wed,  8 May 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157864; cv=none; b=eWsJrTOETcxfyvZBZRLzfDJ+S8/Qp2nD2zcWPvwXIY029nR7SnfbM2oYpFuQ8io5XqB+OfDXNNLFjGk4Sczi7O4sMVhnWfPVO3Lrc2+jmkx27svcn0rA11g1mwFi6oRrRh8idJr6xUmdRqcWEfxD8g0QU1HydoBygf0DDxoMbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157864; c=relaxed/simple;
	bh=T5zecpj4li0OuIWBMVUt5WCfBkgXJbSbJgxIbR51vqs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRswTxxyLC8rm9PIKjNZp+4cp1VyJ6qoFVNYchE1oZIF5QCfKiXwcpwl1PyLAexLWSFVud7jiqq8OsKCeg4HZji0EmJ5Ughbcj9x1K2hpiZpNUuICauGyl129Q6kxIxuZBMBGeKALhVGBK+C7qKT/y6MOKMQ5w5/wu/oR5Knrb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZ7sK1b83z6K6Kl;
	Wed,  8 May 2024 16:41:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 44CD0140B54;
	Wed,  8 May 2024 16:44:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 8 May
 2024 09:44:13 +0100
Date: Wed, 8 May 2024 09:44:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Miguel Luis
	<miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, "Gavin
 Shan" <gshan@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: Re: [PATCH v9 06/19] ACPI: processor: Move checks and availability
 of acpi_processor earlier
Message-ID: <20240508094411.00001b92@Huawei.com>
In-Reply-To: <CAJZ5v0g-Aenoj5H+pNPtoqTgV5U7K5RGNjdOnqobqxkyL5NMVQ@mail.gmail.com>
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
	<20240430142434.10471-7-Jonathan.Cameron@huawei.com>
	<CAJZ5v0g-Aenoj5H+pNPtoqTgV5U7K5RGNjdOnqobqxkyL5NMVQ@mail.gmail.com>
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

On Tue, 7 May 2024 21:04:26 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Apr 30, 2024 at 4:27=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > Make the per_cpu(processors, cpu) entries available earlier so that
> > they are available in arch_register_cpu() as ARM64 will need access
> > to the acpi_handle to distinguish between acpi_processor_add()
> > and earlier registration attempts (which will fail as _STA cannot
> > be checked).
> >
> > Reorder the remove flow to clear this per_cpu() after
> > arch_unregister_cpu() has completed, allowing it to be used in
> > there as well.
> >
> > Note that on x86 for the CPU hotplug case, the pr->id prior to
> > acpi_map_cpu() may be invalid. Thus the per_cpu() structures
> > must be initialized after that call or after checking the ID
> > is valid (not hotplug path).
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> =20
>=20
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> One nit below.

Thanks.  Given timing, this is looking like 6.11 material.
I'll tidy this up and post a v10 in a couple of weeks (so around
rc1 time). Maybe we'll pick up some more tags for the ARM
specific bits in the meantime.

Thanks for all your help!

Jonathan

>=20
> > ---
> > v9: Add back a blank line accidentally removed in code move.
> >     Fix up error returns so that the new cleanup in processor_add()
> >     is triggered on detection of the bios bug.
> >     Combined with the previous 2 patches, should solve the leak
> >     that Gavin identified.
> > ---
> >  drivers/acpi/acpi_processor.c | 80 +++++++++++++++++++++--------------
> >  1 file changed, 49 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processo=
r.c
> > index 16e36e55a560..4a79b42d649e 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -183,8 +183,38 @@ static void __init acpi_pcc_cpufreq_init(void) {}
> >  #endif /* CONFIG_X86 */
> >
> >  /* Initialization */
> > +static DEFINE_PER_CPU(void *, processor_device_array);
> > +
> > +static bool acpi_processor_set_per_cpu(struct acpi_processor *pr,
> > +                                      struct acpi_device *device)
> > +{
> > +       BUG_ON(pr->id >=3D nr_cpu_ids);
> > +
> > +       /*
> > +        * Buggy BIOS check.
> > +        * ACPI id of processors can be reported wrongly by the BIOS.
> > +        * Don't trust it blindly
> > +        */
> > +       if (per_cpu(processor_device_array, pr->id) !=3D NULL &&
> > +           per_cpu(processor_device_array, pr->id) !=3D device) {
> > +               dev_warn(&device->dev,
> > +                        "BIOS reported wrong ACPI id %d for the proces=
sor\n",
> > +                        pr->id);
> > +               return false;
> > +       }
> > +       /*
> > +        * processor_device_array is not cleared on errors to allow bug=
gy BIOS
> > +        * checks.
> > +        */
> > +       per_cpu(processor_device_array, pr->id) =3D device;
> > +       per_cpu(processors, pr->id) =3D pr;
> > +
> > +       return true;
> > +}
> > +
> >  #ifdef CONFIG_ACPI_HOTPLUG_CPU
> > -static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> > +static int acpi_processor_hotadd_init(struct acpi_processor *pr,
> > +                                     struct acpi_device *device)
> >  {
> >         int ret;
> >
> > @@ -198,8 +228,16 @@ static int acpi_processor_hotadd_init(struct acpi_=
processor *pr)
> >         if (ret)
> >                 goto out;
> >
> > +       if (!acpi_processor_set_per_cpu(pr, device)) {
> > +               ret =3D -EINVAL;
> > +               acpi_unmap_cpu(pr->id);
> > +               goto out;
> > +       }
> > +
> >         ret =3D arch_register_cpu(pr->id);
> >         if (ret) {
> > +               /* Leave the processor device array in place to detect =
buggy bios */
> > +               per_cpu(processors, pr->id) =3D NULL;
> >                 acpi_unmap_cpu(pr->id);
> >                 goto out;
> >         }
> > @@ -217,7 +255,8 @@ static int acpi_processor_hotadd_init(struct acpi_p=
rocessor *pr)
> >         return ret;
> >  }
> >  #else
> > -static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
> > +static inline int acpi_processor_hotadd_init(struct acpi_processor *pr,
> > +                                            struct acpi_device *device)
> >  {
> >         return -ENODEV;
> >  }
> > @@ -316,10 +355,13 @@ static int acpi_processor_get_info(struct acpi_de=
vice *device)
> >          *  because cpuid <-> apicid mapping is persistent now.
> >          */
> >         if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> > -               int ret =3D acpi_processor_hotadd_init(pr);
> > +               int ret =3D acpi_processor_hotadd_init(pr, device);
> >
> >                 if (ret)
> >                         return ret;
> > +       } else {
> > +               if (!acpi_processor_set_per_cpu(pr, device))
> > +                       return -EINVAL;
> >         } =20
>=20
> This looks a bit odd.
>=20
> I would make acpi_processor_set_per_cpu() return 0 on success and
> -EINVAL on failure and the above would become
>=20
> if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id))
>          ret =3D acpi_processor_hotadd_init(pr, device);
> else
>         ret =3D acpi_processor_set_per_cpu(pr, device);
>=20
> if (ret)
>         return ret;
>=20
> (and of course ret needs to be defined at the beginning of the function).
>=20
> >
> >         /*
> > @@ -365,8 +407,6 @@ static int acpi_processor_get_info(struct acpi_devi=
ce *device)
> >   * (cpu_data(cpu)) values, like CPU feature flags, family, model, etc.
> >   * Such things have to be put in and set up by the processor driver's =
.probe().
> >   */
> > -static DEFINE_PER_CPU(void *, processor_device_array);
> > -
> >  static int acpi_processor_add(struct acpi_device *device,
> >                                         const struct acpi_device_id *id)
> >  {
> > @@ -395,28 +435,6 @@ static int acpi_processor_add(struct acpi_device *=
device,
> >         if (result) /* Processor is not physically present or unavailab=
le */
> >                 goto err_clear_driver_data;
> >
> > -       BUG_ON(pr->id >=3D nr_cpu_ids);
> > -
> > -       /*
> > -        * Buggy BIOS check.
> > -        * ACPI id of processors can be reported wrongly by the BIOS.
> > -        * Don't trust it blindly
> > -        */
> > -       if (per_cpu(processor_device_array, pr->id) !=3D NULL &&
> > -           per_cpu(processor_device_array, pr->id) !=3D device) {
> > -               dev_warn(&device->dev,
> > -                       "BIOS reported wrong ACPI id %d for the process=
or\n",
> > -                       pr->id);
> > -               /* Give up, but do not abort the namespace scan. */
> > -               goto err_clear_driver_data;
> > -       }
> > -       /*
> > -        * processor_device_array is not cleared on errors to allow bug=
gy BIOS
> > -        * checks.
> > -        */
> > -       per_cpu(processor_device_array, pr->id) =3D device;
> > -       per_cpu(processors, pr->id) =3D pr;
> > -
> >         dev =3D get_cpu_device(pr->id);
> >         if (!dev) {
> >                 result =3D -ENODEV;
> > @@ -470,10 +488,6 @@ static void acpi_processor_remove(struct acpi_devi=
ce *device)
> >         device_release_driver(pr->dev);
> >         acpi_unbind_one(pr->dev);
> >
> > -       /* Clean up. */
> > -       per_cpu(processor_device_array, pr->id) =3D NULL;
> > -       per_cpu(processors, pr->id) =3D NULL;
> > -
> >         cpu_maps_update_begin();
> >         cpus_write_lock();
> >
> > @@ -481,6 +495,10 @@ static void acpi_processor_remove(struct acpi_devi=
ce *device)
> >         arch_unregister_cpu(pr->id);
> >         acpi_unmap_cpu(pr->id);
> >
> > +       /* Clean up. */
> > +       per_cpu(processor_device_array, pr->id) =3D NULL;
> > +       per_cpu(processors, pr->id) =3D NULL;
> > +
> >         cpus_write_unlock();
> >         cpu_maps_update_done();
> >
> > --
> > 2.39.2
> > =20


