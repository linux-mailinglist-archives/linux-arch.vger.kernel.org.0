Return-Path: <linux-arch+bounces-1426-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E47B836FF7
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 19:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD90B25036
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 18:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEEF47799;
	Mon, 22 Jan 2024 17:44:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05F47A6D;
	Mon, 22 Jan 2024 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945497; cv=none; b=N/2i96pxdMTPnXr2LA8oD2oR700u8WWurtt5lBwFUVJtzKKugApZFmH7IDhhWWRSIKf7jJGxexH67AN+k/TARvBxS4O6fiK178dXT+xlVS6jXO7W3Pj8U6XJvOFlL8bS41dLPu+842uj21ANMSTARgyr7AFo/XNMOyZMs65zhx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945497; c=relaxed/simple;
	bh=1uo9SR5jLKvSqbQJuOZ/gWcBzY/vu6zvyq0QbExF35o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBE+AJHGZ+FPMfO2d+VDyqhuhgT/cfxS1OAU6WLqM04BnLa+RZybO73JN2e31BxRDVQ1Sd0NF6D1RjA3+RRPmFEcwRS1yQHRAQ/qvlT5meengAPpPkyv48VGY1a5k7QVu30vcWHwYGnJCkgL6kRSbL6WtACXQZ/zlDorwiaf9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TJcwh1ZKDz6JBTC;
	Tue, 23 Jan 2024 01:41:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 11383140A86;
	Tue, 23 Jan 2024 01:44:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 17:44:50 +0000
Date: Mon, 22 Jan 2024 17:44:49 +0000
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
Subject: Re: [PATCH RFC v3 04/21] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Message-ID: <20240122174449.00002f78@Huawei.com>
In-Reply-To: <CAJZ5v0je=-oVnSumZs=dzcyVuVUeVeTgO7yOnjGg1igyrS7EHQ@mail.gmail.com>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOg7-00Dvjq-VZ@rmk-PC.armlinux.org.uk>
	<CAJZ5v0je=-oVnSumZs=dzcyVuVUeVeTgO7yOnjGg1igyrS7EHQ@mail.gmail.com>
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

On Mon, 18 Dec 2023 21:30:50 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@armlinux=
.org.uk> wrote:
> >
> > From: James Morse <james.morse@arm.com>
> >
> > To allow ACPI to skip the call to arch_register_cpu() when the _STA
> > value indicates the CPU can't be brought online right now, move the
> > arch_register_cpu() call into acpi_processor_get_info(). =20
>=20
> This kind of looks backwards to me and has a potential to become
> super-confusing.
>=20
> I would instead add a way for the generic code to ask the platform
> firmware whether or not the given CPU is enabled and so it can be
> registered.

Hi Rafael,

The ACPI interpreter isn't up at this stage so we'd need to pull that
forwards. I'm not sure if we can pull the interpreter init early enough.

Perhaps pushing the registration back in all cases is the way to go?
Given the acpi interpretter is initialized via subsys_initcall() it would
need to be after that - I tried pushing cpu_dev_register_generic()
immediately after acpi_bus_init() and that seems fine.
We can't leave the rest of cpu_dev_init() that late because a bunch
of other stuff relies on it (CPU freq blows up first as a core_init()
on my setup).

So to make this work we need it to always move the registration later
than the necessary infrastructure, perhaps to subsys_initcall_sync()
as is done for missing CPUs (we'd need to combine the two given that
needs to run after this, or potentially just stop checking for acpi_disabled
and don't taint the kernel!).  I think this is probably the most consistent
option on basis it at least moves the registration to the same point
whatever is going on and can easily use the arch callback you suggest
to hide away the logic on deciding if a CPU is there or not.

What do you think is the best way to do this?


>=20
> > Systems can still be booted with 'acpi=3Doff', or not include ano
> > ACPI description at all. For these, the CPUs continue to be
> > registered by cpu_dev_register_generic().
> >
> > This moves the CPU register logic back to a subsys_initcall(),
> > while the memory nodes will have been registered earlier. =20
>=20
> Isn't this somewhat risky?
>=20
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > Changes since RFC v2:
> >  * Fixup comment in acpi_processor_get_info() (Gavin Shan)
> >  * Add comment in cpu_dev_register_generic() (Gavin Shan)
> > ---
> >  drivers/acpi/acpi_processor.c | 12 ++++++++++++
> >  drivers/base/cpu.c            |  6 +++++-
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processo=
r.c
> > index 0511f2bc10bc..e7ed4730cbbe 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -314,6 +314,18 @@ static int acpi_processor_get_info(struct acpi_dev=
ice *device)
> >                         cpufreq_add_device("acpi-cpufreq");
> >         }
> >
> > +       /*
> > +        * Register CPUs that are present. get_cpu_device() is used to =
skip
> > +        * duplicate CPU descriptions from firmware.
> > +        */
> > +       if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> > +           !get_cpu_device(pr->id)) {
> > +               int ret =3D arch_register_cpu(pr->id);
> > +
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> >         /*
> >          *  Extra Processor objects may be enumerated on MP systems with
> >          *  less than the max # of CPUs. They should be ignored _iff
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index 47de0f140ba6..13d052bf13f4 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -553,7 +553,11 @@ static void __init cpu_dev_register_generic(void)
> >  {
> >         int i, ret;
> >
> > -       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> > +       /*
> > +        * When ACPI is enabled, CPUs are registered via
> > +        * acpi_processor_get_info().
> > +        */
> > +       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disabled)
> >                 return;
> >
> >         for_each_present_cpu(i) {
> > --
> > 2.30.2
> >
> > =20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


