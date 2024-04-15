Return-Path: <linux-arch+bounces-3679-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D758A4E1F
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 13:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B83A1F218BE
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B316C634E2;
	Mon, 15 Apr 2024 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIBNFBEq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A27664AB;
	Mon, 15 Apr 2024 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181969; cv=none; b=jYd+LheeuNwheZp/FZAGIh/gquUblaQCQdfrlZAmJziPE4d8asnN7aRN3GD2DXtGTJxnGfaxVV7x583zjKhVxtXK9w5J36rJhUpRWOd3R5ZEfVeLJHFokLUebkWjExs2VUsU5yFJelMqiooD9BgOtR7Ks+oZUW6Dt+3ki1ibIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181969; c=relaxed/simple;
	bh=KDOa3WMhDZdCJkFOdWTeMccO2m7M+we4CfSTwKFdtC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ra1Fcbi+nlF1ttI1df1p8rauowE0yAkqMXh6EBuegRyZqtLknFEIquBzjFFEr1oKa43JHavxZRG3hC8db+joT+u8Hj31G+AAugjIAm+6J0FtejSMHDU9VVGL7g8rsXkG9y/otJIPbNDDktn/iEis0RuzXlgyjcbBdwaVjCkuFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIBNFBEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34221C4AF08;
	Mon, 15 Apr 2024 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713181969;
	bh=KDOa3WMhDZdCJkFOdWTeMccO2m7M+we4CfSTwKFdtC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oIBNFBEqx27wE7YnGIQL5va6oghRoZsIBk7dZ6Y5YkGZkdDFq4eDbeUPvBrLFcHn4
	 g5NJ7sRS4UXG4ffu2FelF0itZGK5ioO5lI3bMll3lxU1khEN2T5lW3rgtIOrN4ZeXf
	 TJwahAR67LD6xbc3xp9ohfJnvmGcu68Qva+e6KZQiiqao8LrBDnKwqX7kJtZzFdb0b
	 /HMr7hn7XF/tO/Isb1UBK2KM8WEDXrc+UD0L8n+VDZ/QnuFX+f6s1RgaJGUSt4Kpzu
	 Qoaucfj4WbGqk5fQy/mxpDk0TDnsX4JMuDMlNS5sSPFw04yeHQv2hVUpa6NJVWAMKe
	 ut7WP5Mi6Hu4Q==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c6febc1506so339349b6e.1;
        Mon, 15 Apr 2024 04:52:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVC97vZ/pAjRm847xsihsorRTnYhSn/LM47mIY3aLwMAlIsb7j/k1bP3OLBD6fO24xWlnDmISG1bCuSevirthGVvYqIpPg3J6sCP4L0md0Z3i0lgL4wZkL9amTVL76a7CtfSx/jsSPdMrz0kBgPY+HG/wrpUOIU9sxOBPDxNskWMFQBKRZGxvwK2QW1EYsbiKOy+ZegbSIDNH6wjcI8A==
X-Gm-Message-State: AOJu0YzLCQAgka9iUqnh8IP35OZbh1kvyLhHne9gIFZ7PYRFvU3yc/Um
	B6hhrWxoqGQW2lYAAeRYEiF4AafJ5muuSc+b6VtwRKWXDc19mbPhgxtmMuLtynAaCFsOClWMKmr
	fYQH692beLNeazPWn/8zK7CK1cDI=
X-Google-Smtp-Source: AGHT+IHAqEAgDmmyxpmlL7R5uR0Ay/up7sqUWFs77wqXP3g7U1JKzh9PgyufuKdVSAZm4f9VaPPIEoUIWvDgb5wmreo=
X-Received: by 2002:a05:6871:460a:b0:22e:d06b:5d8f with SMTP id
 nf10-20020a056871460a00b0022ed06b5d8fmr11074172oab.3.1713181968497; Mon, 15
 Apr 2024 04:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-4-Jonathan.Cameron@huawei.com> <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
 <20240415115203.0000011b@Huawei.com>
In-Reply-To: <20240415115203.0000011b@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 13:52:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ipGX8WL_YuB_x7=yxY1p_Q=U=9UmqwNdXcA9HgD=_1hQ@mail.gmail.com>
Message-ID: <CAJZ5v0ipGX8WL_YuB_x7=yxY1p_Q=U=9UmqwNdXcA9HgD=_1hQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, Russell King <linux@armlinux.org.uk>, 
	Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linuxarm@huawei.com, 
	justin.he@arm.com, jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 12:52=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 12 Apr 2024 20:30:40 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Fri, Apr 12, 2024 at 4:38=E2=80=AFPM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > From: James Morse <james.morse@arm.com>
> > >
> > > The arm64 specific arch_register_cpu() call may defer CPU registratio=
n
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
> > > e.g. 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEVICES"=
)
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
> > > --
> >
> > I am still unsure why there need to be two paths calling
> > arch_register_cpu() in acpi_processor_get_info().
>
> I replied further down the thread, but the key point was to maintain
> the strong distinction between 'what' was done in a real hotplug
> path vs one where onlining was all.  We can relax that but it goes
> contrary to the careful dance that was needed to get any agreement
> to the ARM architecture aspects of this.

This seems to go beyond technical territory.

As a general rule, we tend to combine code paths that look similar
instead of making them separate on purpose.  Especially with a little
to no explanation of the technical reason.

> >
> > Just below the comment partially pulled into the patch context above,
> > there is this code:
> >
> > if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> >          int ret =3D acpi_processor_hotadd_init(pr);
> >
> >         if (ret)
> >                 return ret;
> > }
> >
> > For the sake of the argument, fold acpi_processor_hotadd_init() into
> > it and drop the redundant _STA check from it:
>
> If we combine these, the _STA check is necessary because we will call thi=
s
> path for delayed onlining of ARM64 CPUs (if the earlier registration code
> call or arch_register_cpu() returned -EPROBE defer). That's the only way
> we know that a given CPU is online capable but firmware is saying we can'=
t
> bring it online yet (it may be be vHP later).

Ignoring the above as per the other message.

> >
> > if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> >         if (invalid_phys_cpuid(pr->phys_id))
> >                 return -ENODEV;
> >
> >         cpu_maps_update_begin();
> >         cpus_write_lock();
> >
> >        ret =3D acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->=
id);
>
> I read that call as
>         acpi_map_cpu_for_physical_cpu_hotplug()
> but we could make it equivalent of.
>         acpi_map_cpu_for_whatever_cpu_hotplug()

Yes.

> (I'm not proposing those names though ;)

Sure.

> in which case it is fine to just stub it out on ARM64.
> >        if (ret) {
> >                 cpus_write_unlock();
> >                 cpu_maps_update_done();
> >                 return ret;
> >        }
> >        ret =3D arch_register_cpu(pr->id);
> >        if (ret) {
> >                 acpi_unmap_cpu(pr->id);
> >
> >                 cpus_write_unlock();
> >                 cpu_maps_update_done();
> >                 return ret;
> >        }
> >       pr_info("CPU%d has been hot-added\n", pr->id);
> >       pr->flags.need_hotplug_init =3D 1;
> This one needs more careful handling because we are calling this
> for non hotplug cases on arm64 in which case we end up setting this
> for initially online CPUs - thus if we offline and online them
> again via sysfs /sys/bus/cpu/device/cpuX/online it goes through the
> hotplug path and should not.
>
> So I need a way to detect if we are hotplugging the cpu or not.
> Is there a standard way to do this?

If you mean physical hot-add, I don't think so.

What exactly do you need to do differently in the two cases?

>  I haven't figured out how to use flags in drivers to communicate this st=
ate.
>
> >
> >       cpus_write_unlock();
> >       cpu_maps_update_done();
> > }
> >
> > so I'm not sure why this cannot be combined with the new code.
> >
> > Say acpi_map_cpu) / acpi_unmap_cpu() are turned into arch calls.
> > What's the difference then?  The locking, which should be fine if I'm
> > not mistaken and need_hotplug_init that needs to be set if this code
> > runs after the processor driver has loaded AFAICS.
>
> That's the bit that I'm currently finding a challenge. Is there a clean
> way to detect that?

If you mean the need_hotplug_init flag, I'm currently a bit struggling
to convince myself that it is really needed.

