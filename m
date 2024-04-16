Return-Path: <linux-arch+bounces-3734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AEF8A7286
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 19:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586E21C20EBF
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE26133406;
	Tue, 16 Apr 2024 17:41:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7829131737;
	Tue, 16 Apr 2024 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289282; cv=none; b=mBQOKTsNvUbnGDYPlgXSj8Ztb8EtgX1Rv4C8hG7mBcZN4r3wP1Hi9jRoyphQ3DpnK5YOMcLJnZodYa/cFd1w0IJvVo+UqtpY7KZvsP0I+7pgMG/aOjivLzOklIxbLJFzR1JY+Bd6czsrmF8PlX+0jxJ6a/QdBYiOSx04gTqeZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289282; c=relaxed/simple;
	bh=PL6dW1OmdZKSKrdUnzvGHxEVG+YXRu2Tvx5hFRoJ4Lk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UW9O8D2tESp5eGwcMzIAW1AiKWJYKMP8T/HeKesXDHQllm6u0DFSkwblN73UIPZupWghVgr4g3uAhaF3mZAbt+ARTkWHav9UtYTB39p8x1EUcPAzkdKth8G6ka1vt0CWCPgW33jo3JdmFkAkKv+i4XToO66tLdhwRoeZJMzWgF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VJrrR6CLbz6J9Th;
	Wed, 17 Apr 2024 01:39:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FBD71400D5;
	Wed, 17 Apr 2024 01:41:17 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Apr
 2024 18:41:16 +0100
Date: Tue, 16 Apr 2024 18:41:16 +0100
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
Message-ID: <20240416184116.0000513c@huawei.com>
In-Reply-To: <20240415132351.00007439@huawei.com>
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
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Apr 2024 13:23:51 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 15 Apr 2024 14:04:26 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>=20
> > On Mon, Apr 15, 2024 at 1:56=E2=80=AFPM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote: =20
> > >
> > > On Mon, 15 Apr 2024 13:37:08 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >   =20
> > > > On Mon, Apr 15, 2024 at 10:46=E2=80=AFAM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:   =20
> > > > >
> > > > > On Sat, 13 Apr 2024 01:23:48 +0200
> > > > > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > >   =20
> > > > > > Russell!
> > > > > >
> > > > > > On Fri, Apr 12 2024 at 22:52, Russell King (Oracle) wrote:   =20
> > > > > > > On Fri, Apr 12, 2024 at 10:54:32PM +0200, Thomas Gleixner wro=
te:   =20
> > > > > > >> > As for the cpu locking, I couldn't find anything in arch_r=
egister_cpu()
> > > > > > >> > that depends on the cpu_maps_update stuff nor needs the cp=
us_write_lock
> > > > > > >> > being taken - so I've no idea why the "make_present" case =
takes these
> > > > > > >> > locks.   =20
> > > > > > >>
> > > > > > >> Anything which updates a CPU mask, e.g. cpu_present_mask, af=
ter early
> > > > > > >> boot must hold the appropriate write locks. Otherwise it wou=
ld be
> > > > > > >> possible to online a CPU which just got marked present, but =
the
> > > > > > >> registration has not completed yet.   =20
> > > > > > >
> > > > > > > Yes. As far as I've been able to determine, arch_register_cpu=
()
> > > > > > > doesn't manipulate any of the CPU masks. All it seems to be d=
oing
> > > > > > > is initialising the struct cpu, registering the embedded stru=
ct
> > > > > > > device, and setting up the sysfs links to its NUMA node.
> > > > > > >
> > > > > > > There is nothing obvious in there which manipulates any CPU m=
asks, and
> > > > > > > this is rather my fundamental point when I said "I couldn't f=
ind
> > > > > > > anything in arch_register_cpu() that depends on ...".
> > > > > > >
> > > > > > > If there is something, then comments in the code would be a u=
seful aid
> > > > > > > because it's highly non-obvious where such a manipulation is =
located,
> > > > > > > and hence why the locks are necessary.   =20
> > > > > >
> > > > > > acpi_processor_hotadd_init()
> > > > > > ...
> > > > > >          acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr=
->id);
> > > > > >
> > > > > > That ends up in fiddling with cpu_present_mask.
> > > > > >
> > > > > > I grant you that arch_register_cpu() is not, but it might rely =
on the
> > > > > > external locking too. I could not be bothered to figure that ou=
t.
> > > > > >   =20
> > > > > > >> Define "real hotplug" :)
> > > > > > >>
> > > > > > >> Real physical hotplug does not really exist. That's at least=
 true for
> > > > > > >> x86, where the physical hotplug support was chased for a whi=
le, but
> > > > > > >> never ended up in production.
> > > > > > >>
> > > > > > >> Though virtualization happily jumped on it to hot add/remove=
 CPUs
> > > > > > >> to/from a guest.
> > > > > > >>
> > > > > > >> There are limitations to this and we learned it the hard way=
 on X86. At
> > > > > > >> the end we came up with the following restrictions:
> > > > > > >>
> > > > > > >>     1) All possible CPUs have to be advertised at boot time =
via firmware
> > > > > > >>        (ACPI/DT/whatever) independent of them being present =
at boot time
> > > > > > >>        or not.
> > > > > > >>
> > > > > > >>        That guarantees proper sizing and ensures that associ=
ations
> > > > > > >>        between hardware entities and software representation=
s and the
> > > > > > >>        resulting topology are stable for the lifetime of a s=
ystem.
> > > > > > >>
> > > > > > >>        It is really required to know the full topology of th=
e system at
> > > > > > >>        boot time especially with hybrid CPUs where some of t=
he cores
> > > > > > >>        have hyperthreading and the others do not.
> > > > > > >>
> > > > > > >>
> > > > > > >>     2) Hot add can only mark an already registered (possible=
) CPU
> > > > > > >>        present. Adding non-registered CPUs after boot is not=
 possible.
> > > > > > >>
> > > > > > >>        The CPU must have been registered in #1 already to en=
sure that
> > > > > > >>        the system topology does not suddenly change in an in=
compatible
> > > > > > >>        way at run-time.
> > > > > > >>
> > > > > > >> The same restriction would apply to real physical hotplug. I=
 don't think
> > > > > > >> that's any different for ARM64 or any other architecture.   =
=20
> > > > > > >
> > > > > > > This makes me wonder whether the Arm64 has been barking up th=
e wrong
> > > > > > > tree then, and whether the whole "present" vs "enabled" thing=
 comes
> > > > > > > from a misunderstanding as far as a CPU goes.
> > > > > > >
> > > > > > > However, there is a big difference between the two. On x86, a=
 processor
> > > > > > > is just a processor. On Arm64, a "processor" is a slice of th=
e system
> > > > > > > (includes the interrupt controller, PMUs etc) and we must enu=
merate
> > > > > > > those even when the processor itself is not enabled. This is =
the whole
> > > > > > > reason there's a difference between "present" and "enabled" a=
nd why
> > > > > > > there's a difference between x86 cpu hotplug and arm64 cpu ho=
tplug.
> > > > > > > The processor never actually goes away in arm64, it's just pr=
evented
> > > > > > > from being used.   =20
> > > > > >
> > > > > > It's the same on X86 at least in the physical world.   =20
> > > > >
> > > > > There were public calls on this via the Linaro Open Discussions g=
roup,
> > > > > so I can talk a little about how we ended up here.  Note that (in=
 my
> > > > > opinion) there is zero chance of this changing - it took us well =
over
> > > > > a year to get to this conclusion.  So if we ever want ARM vCPU HP
> > > > > we need to work within these constraints.
> > > > >
> > > > > The ARM architecture folk (the ones defining the ARM ARM, relevan=
t ACPI
> > > > > specs etc, not the kernel maintainers) are determined that they w=
ant
> > > > > to retain the option to do real physical CPU hotplug in the future
> > > > > with all the necessary work around dynamic interrupt controller
> > > > > initialization, debug and many other messy corners.   =20
> > > >
> > > > That's OK, but the difference is not in the ACPi CPU enumeration/re=
moval code.
> > > >   =20
> > > > > Thus anything defined had to be structured in a way that was 'dif=
ferent'
> > > > > from that.   =20
> > > >
> > > > Apparently, that's where things got confused.
> > > >   =20
> > > > > I don't mind the proposed flattening of the 2 paths if the ARM ke=
rnel
> > > > > maintainers are fine with it but it will remove the distinctions =
and
> > > > > we will need to be very careful with the CPU masks - we can't han=
dle
> > > > > them the same as x86 does.   =20
> > > >
> > > > At the ACPI code level, there is no distinction.
> > > >
> > > > A CPU that was not available before has just become available.  The
> > > > platform firmware has notified the kernel about it and now
> > > > acpi_processor_add() runs.  Why would it need to use different code
> > > > paths depending on what _STA bits were clear before?   =20
> > >
> > > I think we will continue to disagree on this.  To my mind and from the
> > > ACPI specification, they are two different state transitions with dif=
ferent
> > > required actions.   =20
> >=20
> > Well, please be specific: What exactly do you mean here and which
> > parts of the spec are you talking about? =20
>=20
> Given we are moving on with your suggestion, lets leave this for now - to=
o many
> other things to do! :)
>=20
> >  =20
> > > Those state transitions are an ACPI level thing not
> > > an arch level one.  However, I want a solution that moves things forw=
ards
> > > so I'll give pushing that entirely into the arch code a try.   =20
> >=20
> > Thanks!
> >=20
> > Though I think that there is a disconnect between us that needs to be
> > clarified first. =20
>=20
> I'm fine with accepting your approach if it works and is acceptable
> to the arm kernel folk. They are getting a non trivial arch_register_cpu()
> with a bunch of ACPI specific handling in it that may come as a surprise.
>=20
> >  =20
> > > >
> > > > Yes, there is some arch stuff to be called and that arch stuff shou=
ld
> > > > figure out what to do to make things actually work.
> > > >   =20
> > > > > I'll get on with doing that, but do need input from Will / Catali=
n / James.
> > > > > There are some quirks that need calling out as it's not quite a s=
imple
> > > > > as it appears from a high level.
> > > > >
> > > > > Another part of that long discussion established that there is us=
erspace
> > > > > (Android IIRC) in which the CPU present mask must include all CPUs
> > > > > at boot. To change that would be userspace ABI breakage so we can=
't
> > > > > do that.  Hence the dance around adding yet another mask to allow=
 the
> > > > > OS to understand which CPUs are 'present' but not possible to onl=
ine.
> > > > >
> > > > > Flattening the two paths removes any distinction between calls th=
at
> > > > > are for real hotplug and those that are for this online capable p=
ath.   =20
> > > >
> > > > Which calls exactly do you mean?   =20
> > >
> > > At the moment he distinction does not exist (because x86 only supports
> > > fake physical CPU HP and arm64 only vCPU HP / online capable), but if
> > > the architecture is defined for arm64 physical hotplug in the future
> > > we would need to do interrupt controller bring up + a lot of other st=
uff.
> > >
> > > It may be possible to do that in the arch code - will be hard to veri=
fy
> > > that until that arch is defined  Today all I need to do is ensure that
> > > any attempt to do present bit setting for ARM64 returns an error.
> > > That looks to be straight forward.   =20
> >=20
> > OK
> >  =20
> > >   =20
> > > >   =20
> > > > > As a side note, the indicating bit for these flows is defined in =
ACPI
> > > > > for x86 from ACPI 6.3 as a flag in Processor Local APIC
> > > > > (the ARM64 definition is a cut and paste of that text).  So someo=
ne
> > > > > is interested in this distinction on x86. I can't say who but if
> > > > > you have a mantis account you can easily follow the history and it
> > > > > might be instructive to not everyone considering the current x86
> > > > > flow the right way to do it.   =20
> > > >
> > > > So a physically absent processor is different from a physically
> > > > present processor that has not been disabled.  No doubt about this.
> > > >
> > > > That said, I'm still unsure why these two cases require two differe=
nt
> > > > code paths in acpi_processor_add().   =20
> > >
> > > It might be possible to push the checking down into arch_register_cpu=
()
> > > and have that for now reject any attempt to do physical CPU HP on arm=
64.
> > > It is that gate that is vital to getting this accepted by ARM.
> > >
> > > I'm still very much stuck on the hotadd_init flag however, so any sug=
gestions
> > > on that would be very welcome!   =20
> >=20
> > I need to do some investigation which will take some time I suppose. =20
>=20
> I'll do so as well once I've gotten the rest sorted out.  That whole
> structure seems overly complex and liable to race, though maybe sufficient
> locking happens to be held that it's not a problem.

Back to this a (maybe) last outstanding problem.

Superficially I think we might be able to get around this by always
doing the setup in the initial online. In brief that looks something the
below code.  Relying on the cpu hotplug callback registration calling
the acpi_soft_cpu_online for all instances that are already online.

Very lightly tested on arm64 and x86 with cold and hotplugged CPUs.
However this is all in emulation and I don't have access to any significant
x86 test farms :( So help will be needed if it's not immediately obvious why
we can't do this.

Of course, I'm open to other suggestions!

For now I'll put a tidied version of this one is as an RFC with the rest of=
 v6.

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 06e718b650e5..97ca53b516d0 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -340,7 +340,7 @@ static int acpi_processor_get_info(struct acpi_device *=
device)
         */
        per_cpu(processor_device_array, pr->id) =3D device;
        per_cpu(processors, pr->id) =3D pr;
-
+       pr->flags.need_hotplug_init =3D 1;
        /*
         *  Extra Processor objects may be enumerated on MP systems with
         *  less than the max # of CPUs. They should be ignored _iff
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_drive=
r.c
index 67db60eda370..930f911fc435 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -206,7 +206,7 @@ static int acpi_processor_start(struct device *dev)

        /* Protect against concurrent CPU hotplug operations */
        cpu_hotplug_disable();
-       ret =3D __acpi_processor_start(device);
+       //      ret =3D __acpi_processor_start(device);
        cpu_hotplug_enable();
        return ret;
 }
@@ -279,7 +279,7 @@ static int __init acpi_processor_driver_init(void)
        if (result < 0)
                return result;

-       result =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+       result =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
                                           "acpi/cpu-drv:online",
                                           acpi_soft_cpu_online, NULL);
        if (result < 0)
>=20
> Jonathan
>=20
>=20
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


