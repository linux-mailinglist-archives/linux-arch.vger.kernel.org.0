Return-Path: <linux-arch+bounces-2505-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E6285C151
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 17:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8864B20F72
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2D678B76;
	Tue, 20 Feb 2024 16:24:15 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF0A78B6B;
	Tue, 20 Feb 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446255; cv=none; b=PyiebT/xvHKe2LvQWAsKIaJsjQl/HHXOux5ice/QZwDW3vBIS/NjFQ1u7a8j4fX/2DbqDEHVgh1aluXAcf+v79CJRYk0il4FHr+NF3G6vfhtCzXWvCvtme3rrxyq4KihTWvZTTwGlh8gq6x+FcL0UhITfnCQ0a48dcFklcZW0Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446255; c=relaxed/simple;
	bh=X1LmlBpp9/hB3Wl48tFmyVRbajeTNCx4reU1tnbF/qg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIQ8NmtzidtZOc4ClQwhBtiqD4TkubBUbjuOglT3UEc9IjT+wWaBygarDXaoKBvTBfx6Dtwqpxv+vgJxJfp778XjMZkXv+3ScsvhKHztpI7x7FIzG+VsUNaFu0uUNufQBJyVA48qFViyfpC6NjyOfc9gavkC8zfWjevlEjnWH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfPkb0bShz6J9dD;
	Wed, 21 Feb 2024 00:19:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B52E1400DD;
	Wed, 21 Feb 2024 00:24:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 16:24:07 +0000
Date: Tue, 20 Feb 2024 16:24:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, <linux-csky@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, <jianyong.wu@arm.com>,
	<justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Message-ID: <20240220162406.00005b59@Huawei.com>
In-Reply-To: <ZdTBtt0oR6Q1RcAB@shell.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
	<E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
	<CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
	<ZdSMk93c1I6x973h@shell.armlinux.org.uk>
	<ZdTBtt0oR6Q1RcAB@shell.armlinux.org.uk>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 20 Feb 2024 15:13:58 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Feb 20, 2024 at 11:27:15AM +0000, Russell King (Oracle) wrote:
> > On Thu, Feb 15, 2024 at 08:22:29PM +0100, Rafael J. Wysocki wrote: =20
> > > On Wed, Jan 31, 2024 at 5:50=E2=80=AFPM Russell King <rmk+kernel@arml=
inux.org.uk> wrote: =20
> > > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proc=
essor.c
> > > > index cf7c1cca69dd..a68c475cdea5 100644
> > > > --- a/drivers/acpi/acpi_processor.c
> > > > +++ b/drivers/acpi/acpi_processor.c
> > > > @@ -314,6 +314,18 @@ static int acpi_processor_get_info(struct acpi=
_device *device)
> > > >                         cpufreq_add_device("acpi-cpufreq");
> > > >         }
> > > >
> > > > +       /*
> > > > +        * Register CPUs that are present. get_cpu_device() is used=
 to skip
> > > > +        * duplicate CPU descriptions from firmware.
> > > > +        */
> > > > +       if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> > > > +           !get_cpu_device(pr->id)) {
> > > > +               int ret =3D arch_register_cpu(pr->id);
> > > > +
> > > > +               if (ret)
> > > > +                       return ret;
> > > > +       }
> > > > +
> > > >         /*
> > > >          *  Extra Processor objects may be enumerated on MP systems=
 with
> > > >          *  less than the max # of CPUs. They should be ignored _if=
f =20
> > >=20
> > > This is interesting, because right below there is the following code:
> > >=20
> > >     if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> > >         int ret =3D acpi_processor_hotadd_init(pr);
> > >=20
> > >         if (ret)
> > >             return ret;
> > >     }
> > >=20
> > > and acpi_processor_hotadd_init() essentially calls arch_register_cpu()
> > > with some extra things around it (more about that below).
> > >=20
> > > I do realize that acpi_processor_hotadd_init() is defined under
> > > CONFIG_ACPI_HOTPLUG_CPU, so for the sake of the argument let's
> > > consider an architecture where CONFIG_ACPI_HOTPLUG_CPU is set.
> > >=20
> > > So why are the two conditionals that almost contradict each other both
> > > needed?  It looks like the new code could be combined with
> > > acpi_processor_hotadd_init() to do the right thing in all cases.
> > >=20
> > > Now, acpi_processor_hotadd_init() does some extra things that look
> > > like they should be done by the new code too.
> > >=20
> > > 1. It checks invalid_phys_cpuid() which appears to be a good idea to =
me.
> > >=20
> > > 2. It uses locking around arch_register_cpu() which doesn't seem
> > > unreasonable either.
> > >=20
> > > 3. It calls acpi_map_cpu() and I'm not sure why this is not done by
> > > the new code.
> > >=20
> > > The only thing that can be dropped from it is the _STA check AFAICS,
> > > because acpi_processor_add() won't even be called if the CPU is not
> > > present (and not enabled after the first patch).
> > >=20
> > > So why does the code not do 1 - 3 above? =20
> >=20
> > Honestly, I'm out of my depth with this and can't answer your
> > questions - and I really don't want to try fiddling with this code
> > because it's just too icky (even in its current form in mainline)
> > to be understandable to anyone who hasn't gained a detailed knowledge
> > of this code.
> >=20
> > It's going to require a lot of analysis - how acpi_map_cpuid() behaves
> > in all circumstances, what this means for invalid_logical_cpuid() and
> > invalid_phys_cpuid(), what paths will be taken in each case. This code
> > is already just too hairy for someone who isn't an experienced ACPI
> > hacker to be able to follow and I don't see an obvious way to make it
> > more readable.
> >=20
> > James' additions make it even more complex and less readable. =20
>=20
> As an illustration of the problems I'm having here, I was just writing
> a reply to this with a suggestion of transforming this code ultimately
> to:
>=20
> 	if (!get_cpu_device(pr->id)) {
> 		int ret;
>=20
> 		if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id))
> 			ret =3D acpi_processor_make_enabled(pr);
> 		else
> 			ret =3D acpi_processor_make_present(pr);
>=20
> 		if (ret)
> 			return ret;
> 	}
>=20
> (acpi_processor_make_present() would be acpi_processor_hotadd_init()
> and acpi_processor_make_enabled() would be arch_register_cpu() at this
> point.)
>=20
> Then I realised that's a bad idea - because we really need to check
> that pr->id is valid before calling get_cpu_device() on it, so this
> won't work. That leaves us with:
>=20
> 	int ret;
>=20
> 	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> 		/* x86 et.al. path */
> 		ret =3D acpi_processor_make_present(pr);
> 	} else if (!get_cpu_device(pr->id)) {
> 		/* Arm64 path */
> 		ret =3D acpi_processor_make_enabled(pr);
> 	} else {
> 		ret =3D 0;
> 	}
>=20
> 	if (ret)
> 		return ret;
>=20
> Now, the next transformation would be to move !get_cpu_device(pr->id)
> into acpi_processor_make_enabled() which would eliminate one of those
> if() legs.
>=20
> Now, if we want to somehow make the call to arch_regster_cpu() common
> in these two paths, the next question is what are the _precise_
> semantics of acpi_map_cpu(), particularly with respect to it
> modifying pr->id. Is it guaranteed to always give the same result
> for the same processor described in ACPI? What acpi_map_cpu() anyway,
> I can find no documentation for it.
>=20
> Then there's the question whether calling acpi_unmap_cpu() should be
> done on the failure path if arch_register_cpu() fails, which is done
> for the x86 path but not the Arm64 path. Should it be done for the
> Arm64 path? I've no idea, but as Arm64 doesn't implement either of
> these two functions, I guess they could be stubbed out and thus be
> no-ops - but then we open a hole where if pr->id is invalid, we
> end up passing that invalid value to arch_register_cpu() which I'm
> quite sure will explode with a negative CPU number.
>=20
> So, to my mind, what you're effectively asking for is a total rewrite
> of all the code in and called by acpi_processor_get_info()... and that
> is not something I am willing to do (because it's too far outside of
> my knowledge area.)
>=20
> As I said in my reply to patch 1, I think your comments on patch 2
> make Arm64 vcpu hotplug unachievable in a reasonable time frame, and
> certainly outside the bounds of what I can do to progress this.
>=20
> So, at this point I'm going to stand down from further participation
> with this patch set as I believe I've reached the limit of what I can
> do to progress it.
>=20

Thanks for your hard work on this Russell - we have moved forwards.

Short of anyone else stepping up I'll pick this up with
the help of some my colleagues. As such I'm keen on getting patch
1 upstream ASAP so that we can exclude the need for some of the
other workarounds from earlier versions of this series (the ones
dropped before now).

We will need a little time to get up to speed on the current status
and discussion points Russell raises above.

Jonathan



