Return-Path: <linux-arch+bounces-3674-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509EE8A4D5F
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 13:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846E2B20BBB
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 11:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8FD5D734;
	Mon, 15 Apr 2024 11:11:47 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CFF487A5;
	Mon, 15 Apr 2024 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179507; cv=none; b=mRJ0VIwAG2+/G+0TzhUt2I1B7vc94Xr5R5mbZ5nkjhuqB1/fqOvsUsaByQjoipGnOsapFeoQzeVczu+zyHzpDjRB9A2oa8hlwmW9WLjWeKBCMf9Nno3V7TdpQm/OZ0kg29x6iOU9H2VfjsUiN8qbLqkwQV3oOYryMrNjW47Yiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179507; c=relaxed/simple;
	bh=kS+1QAOTVoycQvIh0KEGN55kyIWIw1t53L8ZDJk/ubI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/EJVuQjOX4ESPFCXZ8AiMP1ttH0aU1hkbDKjwPzHziLuAzMAyphdnuEaJy4zvHESWU3vYVpmhQQ/AeXJArTLO8pYLcqkQa5FNdkMXqW8wj4zrUTupyCDQlHuaJCMIPR+0OS9cE8udMkDhFEXljzFRPlzbQ1ZjcgflgNc80sSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VJ4FS2BBfz6K68f;
	Mon, 15 Apr 2024 19:09:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BA5231400E7;
	Mon, 15 Apr 2024 19:11:41 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Apr
 2024 12:11:41 +0100
Date: Mon, 15 Apr 2024 12:11:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
Message-ID: <20240415121140.00006bc7@huawei.com>
In-Reply-To: <20240415115203.0000011b@Huawei.com>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
	<20240412143719.11398-4-Jonathan.Cameron@huawei.com>
	<CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
	<20240415115203.0000011b@Huawei.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Apr 2024 11:52:03 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 12 Apr 2024 20:30:40 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>=20
> > On Fri, Apr 12, 2024 at 4:38=E2=80=AFPM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote: =20
> > >
> > > From: James Morse <james.morse@arm.com>
> > >
> > > The arm64 specific arch_register_cpu() call may defer CPU registration
> > > until the ACPI interpreter is available and the _STA method can
> > > be evaluated.
> > >
> > > If this occurs, then a second attempt is made in
> > > acpi_processor_get_info(). Note that the arm64 specific call has
> > > not yet been added so for now this will never be successfully
> > > called.
> > >
> > > Systems can still be booted with 'acpi=3Doff', or not include an
> > > ACPI description at all as in these cases arch_register_cpu()
> > > will not have deferred registration when first called.
> > >
> > > This moves the CPU register logic back to a subsys_initcall(),
> > > while the memory nodes will have been registered earlier.
> > > Note this is where the call was prior to the cleanup series so
> > > there should be no side effects of moving it back again for this
> > > specific case.
> > >
> > > [PATCH 00/21] Initial cleanups for vCPU HP.
> > > https://lore.kernel.org/all/ZVyz%2FVe5pPu8AWoA@shell.armlinux.org.uk/
> > >
> > > e.g. 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEVICES")
> > >
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > > v5: Update commit message to make it clear this is moving the
> > >     init back to where it was until very recently.
> > >
> > >     No longer change the condition in the earlier registration point
> > >     as that will be handled by the arm64 registration routine
> > >     deferring until called again here.
> > > ---
> > >  drivers/acpi/acpi_processor.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proces=
sor.c
> > > index 93e029403d05..c78398cdd060 100644
> > > --- a/drivers/acpi/acpi_processor.c
> > > +++ b/drivers/acpi/acpi_processor.c
> > > @@ -317,6 +317,18 @@ static int acpi_processor_get_info(struct acpi_d=
evice *device)
> > >
> > >         c =3D &per_cpu(cpu_devices, pr->id);
> > >         ACPI_COMPANION_SET(&c->dev, device);
> > > +       /*
> > > +        * Register CPUs that are present. get_cpu_device() is used t=
o skip
> > > +        * duplicate CPU descriptions from firmware.
> > > +        */
> > > +       if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> > > +           !get_cpu_device(pr->id)) {
> > > +               int ret =3D arch_register_cpu(pr->id);
> > > +
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +
> > >         /*
> > >          *  Extra Processor objects may be enumerated on MP systems w=
ith
> > >          *  less than the max # of CPUs. They should be ignored _iff
> > > --   =20
> >=20
> > I am still unsure why there need to be two paths calling
> > arch_register_cpu() in acpi_processor_get_info(). =20
>=20
> I replied further down the thread, but the key point was to maintain
> the strong distinction between 'what' was done in a real hotplug
> path vs one where onlining was all.  We can relax that but it goes
> contrary to the careful dance that was needed to get any agreement
> to the ARM architecture aspects of this.
>=20
> >=20
> > Just below the comment partially pulled into the patch context above,
> > there is this code:
> >=20
> > if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> >          int ret =3D acpi_processor_hotadd_init(pr);
> >=20
> >         if (ret)
> >                 return ret;
> > }
> >=20
> > For the sake of the argument, fold acpi_processor_hotadd_init() into
> > it and drop the redundant _STA check from it: =20
>=20
> If we combine these, the _STA check is necessary because we will call this
> path for delayed onlining of ARM64 CPUs (if the earlier registration code
> call or arch_register_cpu() returned -EPROBE defer). That's the only way
> we know that a given CPU is online capable but firmware is saying we can't
> bring it online yet (it may be be vHP later).

For arm64 ignore this comment. I'd forgotten we moved it into the arch
specific code last week.  May need similar on x86 I'm not 100% sure.

>=20
> >=20
> > if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> >         if (invalid_phys_cpuid(pr->phys_id))
> >                 return -ENODEV;
> >=20
> >         cpu_maps_update_begin();
> >         cpus_write_lock();
> >=20
> >        ret =3D acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->=
id); =20
>=20
> I read that call as
> 	acpi_map_cpu_for_physical_cpu_hotplug()
> but we could make it equivalent of.
> 	acpi_map_cpu_for_whatever_cpu_hotplug()
> (I'm not proposing those names though ;)
>=20
> in which case it is fine to just stub it out on ARM64.
> >        if (ret) {
> >                 cpus_write_unlock();
> >                 cpu_maps_update_done();
> >                 return ret;
> >        }
> >        ret =3D arch_register_cpu(pr->id);
> >        if (ret) {
> >                 acpi_unmap_cpu(pr->id);
> >=20
> >                 cpus_write_unlock();
> >                 cpu_maps_update_done();
> >                 return ret;
> >        }
> >       pr_info("CPU%d has been hot-added\n", pr->id);
> >       pr->flags.need_hotplug_init =3D 1; =20
> This one needs more careful handling because we are calling this
> for non hotplug cases on arm64 in which case we end up setting this
> for initially online CPUs - thus if we offline and online them
> again via sysfs /sys/bus/cpu/device/cpuX/online it goes through the
> hotplug path and should not.
>=20
> So I need a way to detect if we are hotplugging the cpu or not.
> Is there a standard way to do this?  I haven't figured out how
> to use flags in drivers to communicate this state.
>=20
> >=20
> >       cpus_write_unlock();
> >       cpu_maps_update_done();
> > }
> >=20
> > so I'm not sure why this cannot be combined with the new code.
> >=20
> > Say acpi_map_cpu) / acpi_unmap_cpu() are turned into arch calls.
> > What's the difference then?  The locking, which should be fine if I'm
> > not mistaken and need_hotplug_init that needs to be set if this code
> > runs after the processor driver has loaded AFAICS. =20
>=20
> That's the bit that I'm currently finding a challenge. Is there a clean
> way to detect that?
>=20
> Jonathan
>=20
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


