Return-Path: <linux-arch+bounces-3680-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8DD8A4E2C
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 13:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62868B226D5
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F52664AB;
	Mon, 15 Apr 2024 11:56:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F995FDA5;
	Mon, 15 Apr 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182215; cv=none; b=ErARA5idBV7i8UV3RCDeUrVC1XZD5ImkdATqyTwJXd0as2atQNX1ceyAyHIhEInOBn4rBPQVBtQDv94ioytdm9HR2Y1gZb5sZzimeX7kPEVU5vHzwjP1q6WX/RfMbpv/Wupns4g/+P/wwWmeGbb0UPlep2L1FoYvswDI54FMtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182215; c=relaxed/simple;
	bh=3PbiwocKW9jT+UQzH6Zw7Q5By8Uhz7RrY9qiNOe4l2I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GukShcndG66XEK3RhA+zi8ZbV7+oQZDNtZ4iu5nQAD2wHfOxjXnnpDjiZqSxuprv2ntHwFtsj0Klztsn9nPLkxQz8KflcZwYUMudGhTxe9N8efA+Ov6miPhZOlgXUcDtEl45UailhNfsMf+FOCDhs/xUMI52dlug8AO3oGUPx2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VJ5B467msz6K9Rc;
	Mon, 15 Apr 2024 19:51:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 76ECD1404FC;
	Mon, 15 Apr 2024 19:56:51 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Apr
 2024 12:56:50 +0100
Date: Mon, 15 Apr 2024 12:56:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Message-ID: <20240415125649.00001354@huawei.com>
In-Reply-To: <CAJZ5v0ireu4pOedLjMjK2NrLkq_2vySpdgEgGccQEiFC5=otWQ@mail.gmail.com>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
	<20240412143719.11398-4-Jonathan.Cameron@huawei.com>
	<CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
	<ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk>
	<87bk6ez4hj.ffs@tglx>
	<ZhmtO6zBExkQGZLk@shell.armlinux.org.uk>
	<878r1iyxkr.ffs@tglx>
	<20240415094552.000008d7@Huawei.com>
	<CAJZ5v0ireu4pOedLjMjK2NrLkq_2vySpdgEgGccQEiFC5=otWQ@mail.gmail.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Apr 2024 13:37:08 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Mon, Apr 15, 2024 at 10:46=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Sat, 13 Apr 2024 01:23:48 +0200
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > =20
> > > Russell!
> > >
> > > On Fri, Apr 12 2024 at 22:52, Russell King (Oracle) wrote: =20
> > > > On Fri, Apr 12, 2024 at 10:54:32PM +0200, Thomas Gleixner wrote: =20
> > > >> > As for the cpu locking, I couldn't find anything in arch_registe=
r_cpu()
> > > >> > that depends on the cpu_maps_update stuff nor needs the cpus_wri=
te_lock
> > > >> > being taken - so I've no idea why the "make_present" case takes =
these
> > > >> > locks. =20
> > > >>
> > > >> Anything which updates a CPU mask, e.g. cpu_present_mask, after ea=
rly
> > > >> boot must hold the appropriate write locks. Otherwise it would be
> > > >> possible to online a CPU which just got marked present, but the
> > > >> registration has not completed yet. =20
> > > >
> > > > Yes. As far as I've been able to determine, arch_register_cpu()
> > > > doesn't manipulate any of the CPU masks. All it seems to be doing
> > > > is initialising the struct cpu, registering the embedded struct
> > > > device, and setting up the sysfs links to its NUMA node.
> > > >
> > > > There is nothing obvious in there which manipulates any CPU masks, =
and
> > > > this is rather my fundamental point when I said "I couldn't find
> > > > anything in arch_register_cpu() that depends on ...".
> > > >
> > > > If there is something, then comments in the code would be a useful =
aid
> > > > because it's highly non-obvious where such a manipulation is locate=
d,
> > > > and hence why the locks are necessary. =20
> > >
> > > acpi_processor_hotadd_init()
> > > ...
> > >          acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
> > >
> > > That ends up in fiddling with cpu_present_mask.
> > >
> > > I grant you that arch_register_cpu() is not, but it might rely on the
> > > external locking too. I could not be bothered to figure that out.
> > > =20
> > > >> Define "real hotplug" :)
> > > >>
> > > >> Real physical hotplug does not really exist. That's at least true =
for
> > > >> x86, where the physical hotplug support was chased for a while, but
> > > >> never ended up in production.
> > > >>
> > > >> Though virtualization happily jumped on it to hot add/remove CPUs
> > > >> to/from a guest.
> > > >>
> > > >> There are limitations to this and we learned it the hard way on X8=
6. At
> > > >> the end we came up with the following restrictions:
> > > >>
> > > >>     1) All possible CPUs have to be advertised at boot time via fi=
rmware
> > > >>        (ACPI/DT/whatever) independent of them being present at boo=
t time
> > > >>        or not.
> > > >>
> > > >>        That guarantees proper sizing and ensures that associations
> > > >>        between hardware entities and software representations and =
the
> > > >>        resulting topology are stable for the lifetime of a system.
> > > >>
> > > >>        It is really required to know the full topology of the syst=
em at
> > > >>        boot time especially with hybrid CPUs where some of the cor=
es
> > > >>        have hyperthreading and the others do not.
> > > >>
> > > >>
> > > >>     2) Hot add can only mark an already registered (possible) CPU
> > > >>        present. Adding non-registered CPUs after boot is not possi=
ble.
> > > >>
> > > >>        The CPU must have been registered in #1 already to ensure t=
hat
> > > >>        the system topology does not suddenly change in an incompat=
ible
> > > >>        way at run-time.
> > > >>
> > > >> The same restriction would apply to real physical hotplug. I don't=
 think
> > > >> that's any different for ARM64 or any other architecture. =20
> > > >
> > > > This makes me wonder whether the Arm64 has been barking up the wrong
> > > > tree then, and whether the whole "present" vs "enabled" thing comes
> > > > from a misunderstanding as far as a CPU goes.
> > > >
> > > > However, there is a big difference between the two. On x86, a proce=
ssor
> > > > is just a processor. On Arm64, a "processor" is a slice of the syst=
em
> > > > (includes the interrupt controller, PMUs etc) and we must enumerate
> > > > those even when the processor itself is not enabled. This is the wh=
ole
> > > > reason there's a difference between "present" and "enabled" and why
> > > > there's a difference between x86 cpu hotplug and arm64 cpu hotplug.
> > > > The processor never actually goes away in arm64, it's just prevented
> > > > from being used. =20
> > >
> > > It's the same on X86 at least in the physical world. =20
> >
> > There were public calls on this via the Linaro Open Discussions group,
> > so I can talk a little about how we ended up here.  Note that (in my
> > opinion) there is zero chance of this changing - it took us well over
> > a year to get to this conclusion.  So if we ever want ARM vCPU HP
> > we need to work within these constraints.
> >
> > The ARM architecture folk (the ones defining the ARM ARM, relevant ACPI
> > specs etc, not the kernel maintainers) are determined that they want
> > to retain the option to do real physical CPU hotplug in the future
> > with all the necessary work around dynamic interrupt controller
> > initialization, debug and many other messy corners. =20
>=20
> That's OK, but the difference is not in the ACPi CPU enumeration/removal =
code.
>=20
> > Thus anything defined had to be structured in a way that was 'different'
> > from that. =20
>=20
> Apparently, that's where things got confused.
>=20
> > I don't mind the proposed flattening of the 2 paths if the ARM kernel
> > maintainers are fine with it but it will remove the distinctions and
> > we will need to be very careful with the CPU masks - we can't handle
> > them the same as x86 does. =20
>=20
> At the ACPI code level, there is no distinction.
>=20
> A CPU that was not available before has just become available.  The
> platform firmware has notified the kernel about it and now
> acpi_processor_add() runs.  Why would it need to use different code
> paths depending on what _STA bits were clear before?

I think we will continue to disagree on this.  To my mind and from the
ACPI specification, they are two different state transitions with different
required actions.   Those state transitions are an ACPI level thing not
an arch level one.  However, I want a solution that moves things forwards
so I'll give pushing that entirely into the arch code a try.

>=20
> Yes, there is some arch stuff to be called and that arch stuff should
> figure out what to do to make things actually work.
>=20
> > I'll get on with doing that, but do need input from Will / Catalin / Ja=
mes.
> > There are some quirks that need calling out as it's not quite a simple
> > as it appears from a high level.
> >
> > Another part of that long discussion established that there is userspace
> > (Android IIRC) in which the CPU present mask must include all CPUs
> > at boot. To change that would be userspace ABI breakage so we can't
> > do that.  Hence the dance around adding yet another mask to allow the
> > OS to understand which CPUs are 'present' but not possible to online.
> >
> > Flattening the two paths removes any distinction between calls that
> > are for real hotplug and those that are for this online capable path. =
=20
>=20
> Which calls exactly do you mean?

At the moment he distinction does not exist (because x86 only supports
fake physical CPU HP and arm64 only vCPU HP / online capable), but if
the architecture is defined for arm64 physical hotplug in the future
we would need to do interrupt controller bring up + a lot of other stuff.

It may be possible to do that in the arch code - will be hard to verify
that until that arch is defined  Today all I need to do is ensure that
any attempt to do present bit setting for ARM64 returns an error.
That looks to be straight forward.


>=20
> > As a side note, the indicating bit for these flows is defined in ACPI
> > for x86 from ACPI 6.3 as a flag in Processor Local APIC
> > (the ARM64 definition is a cut and paste of that text).  So someone
> > is interested in this distinction on x86. I can't say who but if
> > you have a mantis account you can easily follow the history and it
> > might be instructive to not everyone considering the current x86
> > flow the right way to do it. =20
>=20
> So a physically absent processor is different from a physically
> present processor that has not been disabled.  No doubt about this.
>=20
> That said, I'm still unsure why these two cases require two different
> code paths in acpi_processor_add().

It might be possible to push the checking down into arch_register_cpu()
and have that for now reject any attempt to do physical CPU HP on arm64.
It is that gate that is vital to getting this accepted by ARM.

I'm still very much stuck on the hotadd_init flag however, so any suggestio=
ns
on that would be very welcome!=20

Jonathan




