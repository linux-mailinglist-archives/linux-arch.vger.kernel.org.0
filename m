Return-Path: <linux-arch+bounces-3544-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B9989FC60
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043A41F25F8A
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0A1173330;
	Wed, 10 Apr 2024 15:59:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC215DBA9;
	Wed, 10 Apr 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764747; cv=none; b=Yn6aMDK1J9NepSyYZAeEf8exfWwta5r1Tts3ipsgPn9/XIL5rBqZ83m/suYEgO/lkEHrY0seDzlShK8wTnu594rZXXrgAEn9YzN3DojoSBwFkUFqAp6Etx266eYdeYqO/ENSX0JSoK4R35rP/UFMoHyRsVNYPJ+hs58EFZ/Ek10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764747; c=relaxed/simple;
	bh=xfuJ3ry5n91qJc92j6kBa5Z9W5YhchcmI5daF8Z4UqY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3CudGzcCa84BvuYwipZaYA0DCgyK0O8kow+kyKvYUgCHxfWtbtynoyPuBk7mHSEAtvgymIYYy9BBSxiTrFyRznUwEF0VXVv6ZRnm+7b7hCBXk+FfgXVCcvIn7dlEfmPEz+GOporlrqwHAidBaMfufRPo0is8NSPMojr2vmCB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VF6sR73psz6J9yF;
	Wed, 10 Apr 2024 23:57:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 32165140DD4;
	Wed, 10 Apr 2024 23:58:56 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 16:58:55 +0100
Date: Wed, 10 Apr 2024 16:58:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
	<justin.he@arm.com>, James Morse <james.morse@arm.com>, Miguel Luis
	<miguel.luis@oracle.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Message-ID: <20240410165854.00002973@huawei.com>
In-Reply-To: <CAJZ5v0hRPFd7jmhJdCu8jVCRc4hZRUt9sKm6iWfynZH1mX7rCg@mail.gmail.com>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
	<E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
	<CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
	<20240322185327.00002416@Huawei.com>
	<20240410134318.0000193c@huawei.com>
	<CAJZ5v0ggD042sfz3jDXQVDUxQZu_AWaF2ox-Me8CvFeRB8nczw@mail.gmail.com>
	<20240410145005.00003050@Huawei.com>
	<CAJZ5v0hRPFd7jmhJdCu8jVCRc4hZRUt9sKm6iWfynZH1mX7rCg@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Apr 2024 16:19:50 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Apr 10, 2024 at 3:50=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 10 Apr 2024 15:28:18 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > =20
> > > On Wed, Apr 10, 2024 at 2:43=E2=80=AFPM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote: =20
> > > > =20
> > > > > > =20
> > > > > > > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > > > > > > index 47de0f140ba6..13d052bf13f4 100644
> > > > > > > --- a/drivers/base/cpu.c
> > > > > > > +++ b/drivers/base/cpu.c
> > > > > > > @@ -553,7 +553,11 @@ static void __init cpu_dev_register_gene=
ric(void)
> > > > > > >  {
> > > > > > >         int i, ret;
> > > > > > >
> > > > > > > -       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> > > > > > > +       /*
> > > > > > > +        * When ACPI is enabled, CPUs are registered via
> > > > > > > +        * acpi_processor_get_info().
> > > > > > > +        */
> > > > > > > +       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_=
disabled)
> > > > > > >                 return; =20
> > > > > >
> > > > > > Honestly, this looks like a quick hack to me and it absolutely
> > > > > > requires an ACK from the x86 maintainers to go anywhere. =20
> > > > > Will address this separately.
> > > > > =20
> > > >
> > > > So do people prefer this hack, or something along lines of the foll=
owing?
> > > >
> > > > static int __init cpu_dev_register_generic(void)
> > > > {
> > > >         int i, ret =3D 0;
> > > >
> > > >         for_each_online_cpu(i) {
> > > >                 if (!get_cpu_device(i)) {
> > > >                         ret =3D arch_register_cpu(i);
> > > >                         if (ret)
> > > >                                 pr_warn("register_cpu %d failed (%d=
)\n", i, ret);
> > > >                 }
> > > >         }
> > > >         //Probably just eat the error.
> > > >         return 0;
> > > > }
> > > > subsys_initcall_sync(cpu_dev_register_generic); =20
> > >
> > > I would prefer something like the above.
> > >
> > > I actually thought that arch_register_cpu() might return something
> > > like -EPROBE_DEFER when it cannot determine whether or not the CPU is
> > > really available. =20
> >
> > Ok. That would end up looking much more like the original code I think.
> > So we wouldn't have this late registration at all, or keep it for DT
> > on arm64?  I'm not sure that's a clean solution though leaves
> > the x86 path alone. =20
>=20
> I'm not sure why DT on arm64 would need to do late registration.

This was me falsely thinking better to do it close together for
DT and ACPI. It definitely doesn't need to (or it wouldn't work today!)

>=20
> There is this chain of calls in the mainline today:
>=20
> driver_init()
>   cpu_dev_init()
>     cpu_dev_register_generic()
>=20
> the last of which registers CPUs on arm64/DT systems IIUC. I don't see
> a need to change this behavior.
>=20
> On arm64/ACPI, though, arch_register_cpu() cannot make progress until
> it can look into the ACPI Namespace, so I would just make it return
> -EPROBE_DEFER or equivalent then and the ACPI enumeration will find
> the CPU and basically treat it as one that has just appeared.

Ok so giving this a go...

Arm 64 version of arch_register_cpu() ended up as the following
(obviously needs cleaning up, bikeshedding of naming etc)

int arch_register_cpu(int cpu)
{
        struct cpu *c =3D &per_cpu(cpu_devices, cpu);
        acpi_handle acpi_handle =3D ACPI_HANDLE(&c->dev);
        int ret;

	printk("!!!!! INTO arch_register_cpu() %px\n", ACPI_HANDLE(&c->dev));

        if (!acpi_disabled && !acpi_handle)
                return -EPROBE_DEFER;
        if (acpi_handle) {
                ret =3D acpi_sta_enabled(acpi_handle);
                if (ret) {
                        printk("Have handle, not enabled\n");
                        /* Not enabled */
                        return ret;
                }
        }
        printk("!!!!! onwards arch_register_cpu()\n");

        c->hotpluggable =3D arch_cpu_is_hotpluggable(cpu);

        return register_cpu(c, cpu);
}

with new utility function in drivers/acpi/utils.c

int acpi_sta_enabled(acpi_handle handle)
{
       unsigned long long sta;
       bool present, enabled;
       acpi_status status;

       if (acpi_has_method(handle, "_STA")) {
               status =3D acpi_evaluate_integer(handle, "_STA", NULL, &sta);
               if (ACPI_FAILURE(status))
                       return -ENODEV;

               present =3D sta & ACPI_STA_DEVICE_PRESENT;
               enabled =3D sta & ACPI_STA_DEVICE_ENABLED;
               if (!present || !enabled) {
                       return -EPROBE_DEFER;
               }
               return 0;
       }
       return 0; /* No _STA means always on! */
}
	struct cpu *c =3D &per_cpu(cpu_devices, pr->id);=09
	ACPI_COMPANION_SET(&c->dev, device);

in acpi_processor_get_info() and that calls

static int acpi_processor_make_enabled(struct acpi_processor *pr)
{
        int ret;

        if (invalid_phys_cpuid(pr->phys_id))
                return -ENODEV;

        cpus_write_lock();
        ret =3D arch_register_cpu(pr->id);
        cpus_write_unlock();

        return ret;
}

I think setting the ACPI handle should be harmless on other architectures.
It seems like the obvious one to set it to for cpu->dev.

Brief tests on same set of DT and ACPI on x86 and arm64 seem fine.

>=20
> > If we get rid of this catch all, solution would be to move the
> > !acpi_disabled check into the arm64 version of arch_cpu_register()
> > because we would only want the delayed registration path to be
> > used on ACPI cases where the question of CPU availability can't
> > yet be resolved. =20
>=20
> Exactly.
>=20
> This is similar (if not equivalent even) to a CPU becoming available
> between the cpu_dev_register_generic() call and the ACPI enumeration.

>=20
> > >
> > > Then, the ACPI processor enumeration path may take care of registering
> > > CPU that have not been registered so far and in the more-or-less the
> > > same way regardless of the architecture (modulo some arch-specific
> > > stuff). =20
> >
> > If I understand correctly, in acpi_processor_get_info() we'd end up
> > with a similar check on whether it was already registered (the x86 path)
> > or had be deferred (arm64 / acpi).
> > =20
> > >
> > > In the end, it should be possible to avoid changing the behavior of
> > > x86 and loongarch in this series. =20
> >
> > Possible, yes, but result if I understand correctly is we end up with
> > very different flows and replication of functionality between the
> > early registration and the late one. I'm fine with that if you prefer i=
t! =20
>=20
> But that's what is there today, isn't it?

Agreed - but I was previously thinking we could move everything late.
I'm fine with just keeping the two flows separate.

>=20
> I think this can be changed to reduce the duplication, but I'd prefer
> to do that later, when the requisite functionality is in place and we
> just do the consolidation.  In that case, if anything goes wrong, we
> can take a step back and reconsider without deferring the arm64 CPU
> hotplug support.

Great. That plan certainly works for me :)

Thanks for quick replies and help getting this headed in right direction.

+CC Miguel who is also looking at some of this series. Sorry Miguel,
was assuming you were on the thread and never checked :(

Jonathan



