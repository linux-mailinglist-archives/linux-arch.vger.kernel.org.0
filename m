Return-Path: <linux-arch+bounces-3109-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A94887369
	for <lists+linux-arch@lfdr.de>; Fri, 22 Mar 2024 19:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA06B223AD
	for <lists+linux-arch@lfdr.de>; Fri, 22 Mar 2024 18:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576AA74431;
	Fri, 22 Mar 2024 18:53:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5D74407;
	Fri, 22 Mar 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133621; cv=none; b=doptbeJHyqnBlXt8H8WQ+busEPM3L20lQ3ez15Wg5MYVNisLKAJb0M4rmsofVkkxPbDA/uDgg6OBGRAfTxvxTGxe8H1PkDXV40d6d5S1tPKg2NmTtApRsHHjyt1xtg6Ic6mDkgtcLytSpgcfzxqirfqB09w8/h+uW0x+0+Rj6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133621; c=relaxed/simple;
	bh=82RQYANYJuMNTPGQtKxqLwhxuDAzIWGQjTW9EV+4+ZU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBjDL9TNQ2+rJrPEdlXzeWkxPF/Le6azpM9YTsUxfkVhf898oCy99X/gMOVjaartQm9urUFn0cweyjBzGmLtxkryI38OMxddWQHnl3DTQWROWXX0mMjegnKfDOi6bfu1RIH6Fouii0rE7Q8TatONa8Y1cnrn+I8SlaQtffFSEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V1Wfp02xRz6K62w;
	Sat, 23 Mar 2024 02:52:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A1251400CF;
	Sat, 23 Mar 2024 02:53:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 22 Mar
 2024 18:53:28 +0000
Date: Fri, 22 Mar 2024 18:53:27 +0000
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
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Message-ID: <20240322185327.00002416@Huawei.com>
In-Reply-To: <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
	<E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
	<CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 20:22:29 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Jan 31, 2024 at 5:50=E2=80=AFPM Russell King <rmk+kernel@armlinux=
.org.uk> wrote:
> >
> > From: James Morse <james.morse@arm.com>
> >
> > To allow ACPI to skip the call to arch_register_cpu() when the _STA
> > value indicates the CPU can't be brought online right now, move the
> > arch_register_cpu() call into acpi_processor_get_info().
> >
> > Systems can still be booted with 'acpi=3Doff', or not include an
> > ACPI description at all. For these, the CPUs continue to be
> > registered by cpu_dev_register_generic().
> >
> > This moves the CPU register logic back to a subsys_initcall(),
> > while the memory nodes will have been registered earlier.
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
> > index cf7c1cca69dd..a68c475cdea5 100644
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
> >          *  less than the max # of CPUs. They should be ignored _iff =20
>=20
> This is interesting, because right below there is the following code:
>=20
>     if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
>         int ret =3D acpi_processor_hotadd_init(pr);
>=20
>         if (ret)
>             return ret;
>     }
>=20
> and acpi_processor_hotadd_init() essentially calls arch_register_cpu()
> with some extra things around it (more about that below).
>=20
> I do realize that acpi_processor_hotadd_init() is defined under
> CONFIG_ACPI_HOTPLUG_CPU, so for the sake of the argument let's
> consider an architecture where CONFIG_ACPI_HOTPLUG_CPU is set.
>=20
> So why are the two conditionals that almost contradict each other both
> needed?  It looks like the new code could be combined with
> acpi_processor_hotadd_init() to do the right thing in all cases.

I jumped on to the end of this series to look at this as the two legs
look more similar at that point. I'll figure out how to drive
any changes through the series once the end goal is clear.

To make testing easy I made the acpi_process_make_enabled() look as
much like acpi_process_make_present() as possible.

>=20
> Now, acpi_processor_hotadd_init() does some extra things that look
> like they should be done by the new code too.
>=20
> 1. It checks invalid_phys_cpuid() which appears to be a good idea to me.

Indeed that is sensible. Not sure there is a path to here where it fails,
but defense in depth is good.

>=20
> 2. It uses locking around arch_register_cpu() which doesn't seem
> unreasonable either.

Seems reasonable, though exactly what this protecting is unclear to me
- is the arch_register_cpu() and/or the acpi_map_cpu().
Whilst it would be nice to be sure, appears harmless, so let us
take it for consistency if nothing else.

The cpu_maps_update_begin()/end() calls though aren't necessary as
we aren't touching the cpu_present or cpu_online masks.


>=20
> 3. It calls acpi_map_cpu() and I'm not sure why this is not done by
> the new code.

Doesn't exist except on x86 and longarch as Russell mentioned. So let's
see what it does (on x86)  So we are into the realm of interfaces that
look generic but really aren't :(  I particularly like the
generic_processor_info() which isn't particularly generic.

1. cpu =3D acpi_register_lapic()

Docs say: Register a local apic and generates a logic cpu number

2. generic_processor_info() in arch/x86/kernel/acpi/acpi.c

Checks against nr_cpus_ids - maybe that bit is useful

Allocate_logical_cpuid().
Digging in, it seems to do similar to setting __cpu_logical_map on arm64.
That's done in acpi_map_gic_cpu_interface, which happens when MADT is
parsed and I believe it's one of the the things we need to do whether
or not the CPU is enabled at boot. So already done.

acpi_processor_set_pdc() -- configure _PDC support (which I'd never heard
of before now).  Deprecated in ACPI 3.0. Given we are using stuff only added
in 6.5 we can probably skip that even if it would be harmless.

acpi_map_cpu2node() -- evalulate _PXM and set __apicid_to_node[]
entry. That is only used from x86 code. Not sure what equivalent would be.
Also numa_set_node(cpu, nid);  Which again sounds a lot more generic than
it is. Load of x86 specific stuff + set_cpu_numa_node() which is generic
and for ARM64 (and anything using CONFIG_GENERIC_ARCH_NUMA) is called
by numa_store_cpu_info() either from early_map_cpu_to_node() or smp_prepare=
_cpus()
which is called for_each_possible_cpu() and hence has already been done.

So conclusion on this one is there doesn't seem to be anything to do.
We could provide a __weak function or an ARM64 specific one that does
nothing or gate it on an appropriate config variable.  However, given
I presume 'future' ARM64 support for CPU hotplug will want to do something
in these calls, perhaps a better bet is to pass a bool into the function
to indicate these should be skipped if present is not changing.

Having done that, we end up with code that is messy enough we are
better off keeping them as separate functions, though they may
look a little more similar than in this version.

There is a final thing in here you didn't mention
setting pr->flags.need_hotplug_init
which causes extra stuff to occur in processor_driver.c
The extra stuff doesn't seem to be necessary for the enable case
despite being needed for change of present status.
I haven't figured this bit out yet (I need to mess around on x86
to understand what goes wrong if you don't use that flag).


>=20
> The only thing that can be dropped from it is the _STA check AFAICS,
> because acpi_processor_add() won't even be called if the CPU is not
> present (and not enabled after the first patch).
>=20
> So why does the code not do 1 - 3 above?
I agree with 1 and 2, reasoning for 3 given above.

>=20
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
> >                 return; =20
>=20
> Honestly, this looks like a quick hack to me and it absolutely
> requires an ACK from the x86 maintainers to go anywhere.
Will address this separately.

>=20
> >
> >         for_each_present_cpu(i) {
> > -- =20


