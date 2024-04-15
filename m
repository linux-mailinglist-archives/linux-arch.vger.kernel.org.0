Return-Path: <linux-arch+bounces-3683-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA568A4EEE
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 14:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E533F282F6C
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 12:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76556A34F;
	Mon, 15 Apr 2024 12:23:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00B6996E;
	Mon, 15 Apr 2024 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183839; cv=none; b=byVFUvwpBku2X3/LbKmHo+9PnhkMxmAn0TRN/h0lu4V6pjijS/qw1q/FIlyS8KEoqKpIdlxZ+Miu5iq5urEElSY8AO9wyt/H7b2yW/YD4p5vZxXJyAsE6rXSvvF1FoQYpwUC/+MMJ3al3e+QoUku8JSCB64VSX8U6WtedHTehN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183839; c=relaxed/simple;
	bh=GLJ03ff3Zv4xzsF6ZFjbP5uhXTQUo05/PY9g0wHCrVQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQ7pH/cxbimFAJL2QeLeD8QDmU8j/yaPEm4p2yzom7J2MZWpSHbokR27GUeVTqxpl978JPwwkahEtBesI26IbYo4t0Nuz/OwEDDc6qCY0Z5/nf4HKeCZ5QtD1ro4oKnxGC1S54EEqacmFc9mIhkNQUaUrwRv2dCuyMLKvvMNlAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VJ5rl6H3wz6JBZl;
	Mon, 15 Apr 2024 20:21:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 024BC140B33;
	Mon, 15 Apr 2024 20:23:54 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Apr
 2024 13:23:53 +0100
Date: Mon, 15 Apr 2024 13:23:51 +0100
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
Message-ID: <20240415132351.00007439@huawei.com>
In-Reply-To: <CAJZ5v0iNSmV6EsBOc5oYWSTR9UvFOeg8_mj8Ofhum4Tonb3kNQ@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Apr 2024 14:04:26 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Mon, Apr 15, 2024 at 1:56=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 15 Apr 2024 13:37:08 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > =20
> > > On Mon, Apr 15, 2024 at 10:46=E2=80=AFAM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote: =20
> > > >
> > > > On Sat, 13 Apr 2024 01:23:48 +0200
> > > > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > =20
> > > > > Russell!
> > > > >
> > > > > On Fri, Apr 12 2024 at 22:52, Russell King (Oracle) wrote: =20
> > > > > > On Fri, Apr 12, 2024 at 10:54:32PM +0200, Thomas Gleixner wrote=
: =20
> > > > > >> > As for the cpu locking, I couldn't find anything in arch_reg=
ister_cpu()
> > > > > >> > that depends on the cpu_maps_update stuff nor needs the cpus=
_write_lock
> > > > > >> > being taken - so I've no idea why the "make_present" case ta=
kes these
> > > > > >> > locks. =20
> > > > > >>
> > > > > >> Anything which updates a CPU mask, e.g. cpu_present_mask, afte=
r early
> > > > > >> boot must hold the appropriate write locks. Otherwise it would=
 be
> > > > > >> possible to online a CPU which just got marked present, but the
> > > > > >> registration has not completed yet. =20
> > > > > >
> > > > > > Yes. As far as I've been able to determine, arch_register_cpu()
> > > > > > doesn't manipulate any of the CPU masks. All it seems to be doi=
ng
> > > > > > is initialising the struct cpu, registering the embedded struct
> > > > > > device, and setting up the sysfs links to its NUMA node.
> > > > > >
> > > > > > There is nothing obvious in there which manipulates any CPU mas=
ks, and
> > > > > > this is rather my fundamental point when I said "I couldn't find
> > > > > > anything in arch_register_cpu() that depends on ...".
> > > > > >
> > > > > > If there is something, then comments in the code would be a use=
ful aid
> > > > > > because it's highly non-obvious where such a manipulation is lo=
cated,
> > > > > > and hence why the locks are necessary. =20
> > > > >
> > > > > acpi_processor_hotadd_init()
> > > > > ...
> > > > >          acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->=
id);
> > > > >
> > > > > That ends up in fiddling with cpu_present_mask.
> > > > >
> > > > > I grant you that arch_register_cpu() is not, but it might rely on=
 the
> > > > > external locking too. I could not be bothered to figure that out.
> > > > > =20
> > > > > >> Define "real hotplug" :)
> > > > > >>
> > > > > >> Real physical hotplug does not really exist. That's at least t=
rue for
> > > > > >> x86, where the physical hotplug support was chased for a while=
, but
> > > > > >> never ended up in production.
> > > > > >>
> > > > > >> Though virtualization happily jumped on it to hot add/remove C=
PUs
> > > > > >> to/from a guest.
> > > > > >>
> > > > > >> There are limitations to this and we learned it the hard way o=
n X86. At
> > > > > >> the end we came up with the following restrictions:
> > > > > >>
> > > > > >>     1) All possible CPUs have to be advertised at boot time vi=
a firmware
> > > > > >>        (ACPI/DT/whatever) independent of them being present at=
 boot time
> > > > > >>        or not.
> > > > > >>
> > > > > >>        That guarantees proper sizing and ensures that associat=
ions
> > > > > >>        between hardware entities and software representations =
and the
> > > > > >>        resulting topology are stable for the lifetime of a sys=
tem.
> > > > > >>
> > > > > >>        It is really required to know the full topology of the =
system at
> > > > > >>        boot time especially with hybrid CPUs where some of the=
 cores
> > > > > >>        have hyperthreading and the others do not.
> > > > > >>
> > > > > >>
> > > > > >>     2) Hot add can only mark an already registered (possible) =
CPU
> > > > > >>        present. Adding non-registered CPUs after boot is not p=
ossible.
> > > > > >>
> > > > > >>        The CPU must have been registered in #1 already to ensu=
re that
> > > > > >>        the system topology does not suddenly change in an inco=
mpatible
> > > > > >>        way at run-time.
> > > > > >>
> > > > > >> The same restriction would apply to real physical hotplug. I d=
on't think
> > > > > >> that's any different for ARM64 or any other architecture. =20
> > > > > >
> > > > > > This makes me wonder whether the Arm64 has been barking up the =
wrong
> > > > > > tree then, and whether the whole "present" vs "enabled" thing c=
omes
> > > > > > from a misunderstanding as far as a CPU goes.
> > > > > >
> > > > > > However, there is a big difference between the two. On x86, a p=
rocessor
> > > > > > is just a processor. On Arm64, a "processor" is a slice of the =
system
> > > > > > (includes the interrupt controller, PMUs etc) and we must enume=
rate
> > > > > > those even when the processor itself is not enabled. This is th=
e whole
> > > > > > reason there's a difference between "present" and "enabled" and=
 why
> > > > > > there's a difference between x86 cpu hotplug and arm64 cpu hotp=
lug.
> > > > > > The processor never actually goes away in arm64, it's just prev=
ented
> > > > > > from being used. =20
> > > > >
> > > > > It's the same on X86 at least in the physical world. =20
> > > >
> > > > There were public calls on this via the Linaro Open Discussions gro=
up,
> > > > so I can talk a little about how we ended up here.  Note that (in my
> > > > opinion) there is zero chance of this changing - it took us well ov=
er
> > > > a year to get to this conclusion.  So if we ever want ARM vCPU HP
> > > > we need to work within these constraints.
> > > >
> > > > The ARM architecture folk (the ones defining the ARM ARM, relevant =
ACPI
> > > > specs etc, not the kernel maintainers) are determined that they want
> > > > to retain the option to do real physical CPU hotplug in the future
> > > > with all the necessary work around dynamic interrupt controller
> > > > initialization, debug and many other messy corners. =20
> > >
> > > That's OK, but the difference is not in the ACPi CPU enumeration/remo=
val code.
> > > =20
> > > > Thus anything defined had to be structured in a way that was 'diffe=
rent'
> > > > from that. =20
> > >
> > > Apparently, that's where things got confused.
> > > =20
> > > > I don't mind the proposed flattening of the 2 paths if the ARM kern=
el
> > > > maintainers are fine with it but it will remove the distinctions and
> > > > we will need to be very careful with the CPU masks - we can't handle
> > > > them the same as x86 does. =20
> > >
> > > At the ACPI code level, there is no distinction.
> > >
> > > A CPU that was not available before has just become available.  The
> > > platform firmware has notified the kernel about it and now
> > > acpi_processor_add() runs.  Why would it need to use different code
> > > paths depending on what _STA bits were clear before? =20
> >
> > I think we will continue to disagree on this.  To my mind and from the
> > ACPI specification, they are two different state transitions with diffe=
rent
> > required actions. =20
>=20
> Well, please be specific: What exactly do you mean here and which
> parts of the spec are you talking about?

Given we are moving on with your suggestion, lets leave this for now - too =
many
other things to do! :)

>=20
> > Those state transitions are an ACPI level thing not
> > an arch level one.  However, I want a solution that moves things forwar=
ds
> > so I'll give pushing that entirely into the arch code a try. =20
>=20
> Thanks!
>=20
> Though I think that there is a disconnect between us that needs to be
> clarified first.

I'm fine with accepting your approach if it works and is acceptable
to the arm kernel folk. They are getting a non trivial arch_register_cpu()
with a bunch of ACPI specific handling in it that may come as a surprise.

>=20
> > >
> > > Yes, there is some arch stuff to be called and that arch stuff should
> > > figure out what to do to make things actually work.
> > > =20
> > > > I'll get on with doing that, but do need input from Will / Catalin =
/ James.
> > > > There are some quirks that need calling out as it's not quite a sim=
ple
> > > > as it appears from a high level.
> > > >
> > > > Another part of that long discussion established that there is user=
space
> > > > (Android IIRC) in which the CPU present mask must include all CPUs
> > > > at boot. To change that would be userspace ABI breakage so we can't
> > > > do that.  Hence the dance around adding yet another mask to allow t=
he
> > > > OS to understand which CPUs are 'present' but not possible to onlin=
e.
> > > >
> > > > Flattening the two paths removes any distinction between calls that
> > > > are for real hotplug and those that are for this online capable pat=
h. =20
> > >
> > > Which calls exactly do you mean? =20
> >
> > At the moment he distinction does not exist (because x86 only supports
> > fake physical CPU HP and arm64 only vCPU HP / online capable), but if
> > the architecture is defined for arm64 physical hotplug in the future
> > we would need to do interrupt controller bring up + a lot of other stuf=
f.
> >
> > It may be possible to do that in the arch code - will be hard to verify
> > that until that arch is defined  Today all I need to do is ensure that
> > any attempt to do present bit setting for ARM64 returns an error.
> > That looks to be straight forward. =20
>=20
> OK
>=20
> > =20
> > > =20
> > > > As a side note, the indicating bit for these flows is defined in AC=
PI
> > > > for x86 from ACPI 6.3 as a flag in Processor Local APIC
> > > > (the ARM64 definition is a cut and paste of that text).  So someone
> > > > is interested in this distinction on x86. I can't say who but if
> > > > you have a mantis account you can easily follow the history and it
> > > > might be instructive to not everyone considering the current x86
> > > > flow the right way to do it. =20
> > >
> > > So a physically absent processor is different from a physically
> > > present processor that has not been disabled.  No doubt about this.
> > >
> > > That said, I'm still unsure why these two cases require two different
> > > code paths in acpi_processor_add(). =20
> >
> > It might be possible to push the checking down into arch_register_cpu()
> > and have that for now reject any attempt to do physical CPU HP on arm64.
> > It is that gate that is vital to getting this accepted by ARM.
> >
> > I'm still very much stuck on the hotadd_init flag however, so any sugge=
stions
> > on that would be very welcome! =20
>=20
> I need to do some investigation which will take some time I suppose.

I'll do so as well once I've gotten the rest sorted out.  That whole
structure seems overly complex and liable to race, though maybe sufficient
locking happens to be held that it's not a problem.

Jonathan




