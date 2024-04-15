Return-Path: <linux-arch+bounces-3682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4AB8A4E71
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 14:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C331F21B73
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 12:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6B56BB33;
	Mon, 15 Apr 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZcnAW3D"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA1F67A1A;
	Mon, 15 Apr 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182683; cv=none; b=MfaVl7xrghrOgBnVEdgVlj6NjaLSL8HO2p018Eys6hWZl3ULgNLAwAXv2OwtZ2HaZC7+4xOtc3hwfuf2k2fNkTYP2f2TFdBUYQZ/dksVHwWV4y5YmtEbuMdlaGK1KyMT+CPH2fETgqCORJwnth0JxSCNaRtge8Mi1a9ERVkcbCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182683; c=relaxed/simple;
	bh=zxSWuVQ4qPJ/JWgr6RsUAwDlHj9kr4x2STKpQY4GRpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVtMa3rKy495SXa/pewvLZ1r9+Ta/ieeVx2Rv0uiN2H5OtdJdJNdHVU1S5NBK4C6TFDnY1m1u3cj3CotoKM+EDQjczvLGtCyZRyiTRbcjhb5V2l4U0fPkD0CxbBTYzIy/1+70sxj3e7qTPdctd+kk7FuMihrfkQ58vxzK46Bhg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZcnAW3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44ADC4AF09;
	Mon, 15 Apr 2024 12:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713182682;
	bh=zxSWuVQ4qPJ/JWgr6RsUAwDlHj9kr4x2STKpQY4GRpQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WZcnAW3DM/t5uNJHwDpzQgF/DdxDNH4SSsPG/5kvEBwOERFW4ALhis0GbakZelWsc
	 1tG3Giw34ZvNieqhBm9FNWQjrt+0dd1PgZJfXWUtQ5+MwUivxS2FfWhj+yCBFLoX6K
	 pauWKKfbAJJEJIQt9L2g4mrJ6mnEcOwWwHFXY9AsDdo+hEBzqEmMPB53EmQLxBoxul
	 oZigKx2YUovY3hnuBcCgQEiQSkUySwjV22VOHSRMDlT/rx+2Uptj5eyBhgXP2EnVVq
	 uq0gT+JcY+PI/x4L+XirckCUjf8utSO/zznnQfApe2xZdmNSiJ9ZJLSS6JLEt/jbVW
	 09Rws4baXKz9Q==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-22f0429c1ebso232770fac.0;
        Mon, 15 Apr 2024 05:04:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaKDB3/WuD1j2F/gd5y1jxllxZT2AdM+tctMq8U0uRTSbGMyLyljR3doHu1SYn/nLrmiFy+23SfFly9pM2kS5dcl7Z6ozSpvqQ/pFGlXRQpR/4WC3PfNOUcTF+LlJJ5ILeSpJ+en600h2C1HRkmYswZHe6ZFypMN0QBYpqSrM+WukRkzNsRjy74XiTpQcXmvV6IhccaLPjwKPgnXYkgA==
X-Gm-Message-State: AOJu0Yzb0pb6NgQbCVgnJsd3aVAbwKs7CEEkZWvXDBgnOC2oyjai93QD
	0CeNON3KtOUb65otGY+Zobe5gQY5USrHbjP95ts75Jb5CU8Sx5cdvNbiqAZWBtsdoYe9d0ri3Su
	2dVCF8GFTwXlkV8Es0+7/hnj5lFQ=
X-Google-Smtp-Source: AGHT+IEkp/4VXULeXEC9FnSc/V5Jc4RCWgrOVooQ09Z3RvlUiDj/6NLoWqN3h0YUMsPI5WfHYSfRAVQHsSH53GjQUC0=
X-Received: by 2002:a05:6871:7420:b0:234:5785:bca with SMTP id
 nw32-20020a056871742000b0023457850bcamr4810815oac.3.1713182682148; Mon, 15
 Apr 2024 05:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-4-Jonathan.Cameron@huawei.com> <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
 <ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk> <87bk6ez4hj.ffs@tglx>
 <ZhmtO6zBExkQGZLk@shell.armlinux.org.uk> <878r1iyxkr.ffs@tglx>
 <20240415094552.000008d7@Huawei.com> <CAJZ5v0ireu4pOedLjMjK2NrLkq_2vySpdgEgGccQEiFC5=otWQ@mail.gmail.com>
 <20240415125649.00001354@huawei.com>
In-Reply-To: <20240415125649.00001354@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 14:04:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iNSmV6EsBOc5oYWSTR9UvFOeg8_mj8Ofhum4Tonb3kNQ@mail.gmail.com>
Message-ID: <CAJZ5v0iNSmV6EsBOc5oYWSTR9UvFOeg8_mj8Ofhum4Tonb3kNQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, Miguel Luis <miguel.luis@oracle.com>, 
	James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linuxarm@huawei.com, justin.he@arm.com, 
	jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 1:56=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 15 Apr 2024 13:37:08 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Mon, Apr 15, 2024 at 10:46=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Sat, 13 Apr 2024 01:23:48 +0200
> > > Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > > Russell!
> > > >
> > > > On Fri, Apr 12 2024 at 22:52, Russell King (Oracle) wrote:
> > > > > On Fri, Apr 12, 2024 at 10:54:32PM +0200, Thomas Gleixner wrote:
> > > > >> > As for the cpu locking, I couldn't find anything in arch_regis=
ter_cpu()
> > > > >> > that depends on the cpu_maps_update stuff nor needs the cpus_w=
rite_lock
> > > > >> > being taken - so I've no idea why the "make_present" case take=
s these
> > > > >> > locks.
> > > > >>
> > > > >> Anything which updates a CPU mask, e.g. cpu_present_mask, after =
early
> > > > >> boot must hold the appropriate write locks. Otherwise it would b=
e
> > > > >> possible to online a CPU which just got marked present, but the
> > > > >> registration has not completed yet.
> > > > >
> > > > > Yes. As far as I've been able to determine, arch_register_cpu()
> > > > > doesn't manipulate any of the CPU masks. All it seems to be doing
> > > > > is initialising the struct cpu, registering the embedded struct
> > > > > device, and setting up the sysfs links to its NUMA node.
> > > > >
> > > > > There is nothing obvious in there which manipulates any CPU masks=
, and
> > > > > this is rather my fundamental point when I said "I couldn't find
> > > > > anything in arch_register_cpu() that depends on ...".
> > > > >
> > > > > If there is something, then comments in the code would be a usefu=
l aid
> > > > > because it's highly non-obvious where such a manipulation is loca=
ted,
> > > > > and hence why the locks are necessary.
> > > >
> > > > acpi_processor_hotadd_init()
> > > > ...
> > > >          acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id=
);
> > > >
> > > > That ends up in fiddling with cpu_present_mask.
> > > >
> > > > I grant you that arch_register_cpu() is not, but it might rely on t=
he
> > > > external locking too. I could not be bothered to figure that out.
> > > >
> > > > >> Define "real hotplug" :)
> > > > >>
> > > > >> Real physical hotplug does not really exist. That's at least tru=
e for
> > > > >> x86, where the physical hotplug support was chased for a while, =
but
> > > > >> never ended up in production.
> > > > >>
> > > > >> Though virtualization happily jumped on it to hot add/remove CPU=
s
> > > > >> to/from a guest.
> > > > >>
> > > > >> There are limitations to this and we learned it the hard way on =
X86. At
> > > > >> the end we came up with the following restrictions:
> > > > >>
> > > > >>     1) All possible CPUs have to be advertised at boot time via =
firmware
> > > > >>        (ACPI/DT/whatever) independent of them being present at b=
oot time
> > > > >>        or not.
> > > > >>
> > > > >>        That guarantees proper sizing and ensures that associatio=
ns
> > > > >>        between hardware entities and software representations an=
d the
> > > > >>        resulting topology are stable for the lifetime of a syste=
m.
> > > > >>
> > > > >>        It is really required to know the full topology of the sy=
stem at
> > > > >>        boot time especially with hybrid CPUs where some of the c=
ores
> > > > >>        have hyperthreading and the others do not.
> > > > >>
> > > > >>
> > > > >>     2) Hot add can only mark an already registered (possible) CP=
U
> > > > >>        present. Adding non-registered CPUs after boot is not pos=
sible.
> > > > >>
> > > > >>        The CPU must have been registered in #1 already to ensure=
 that
> > > > >>        the system topology does not suddenly change in an incomp=
atible
> > > > >>        way at run-time.
> > > > >>
> > > > >> The same restriction would apply to real physical hotplug. I don=
't think
> > > > >> that's any different for ARM64 or any other architecture.
> > > > >
> > > > > This makes me wonder whether the Arm64 has been barking up the wr=
ong
> > > > > tree then, and whether the whole "present" vs "enabled" thing com=
es
> > > > > from a misunderstanding as far as a CPU goes.
> > > > >
> > > > > However, there is a big difference between the two. On x86, a pro=
cessor
> > > > > is just a processor. On Arm64, a "processor" is a slice of the sy=
stem
> > > > > (includes the interrupt controller, PMUs etc) and we must enumera=
te
> > > > > those even when the processor itself is not enabled. This is the =
whole
> > > > > reason there's a difference between "present" and "enabled" and w=
hy
> > > > > there's a difference between x86 cpu hotplug and arm64 cpu hotplu=
g.
> > > > > The processor never actually goes away in arm64, it's just preven=
ted
> > > > > from being used.
> > > >
> > > > It's the same on X86 at least in the physical world.
> > >
> > > There were public calls on this via the Linaro Open Discussions group=
,
> > > so I can talk a little about how we ended up here.  Note that (in my
> > > opinion) there is zero chance of this changing - it took us well over
> > > a year to get to this conclusion.  So if we ever want ARM vCPU HP
> > > we need to work within these constraints.
> > >
> > > The ARM architecture folk (the ones defining the ARM ARM, relevant AC=
PI
> > > specs etc, not the kernel maintainers) are determined that they want
> > > to retain the option to do real physical CPU hotplug in the future
> > > with all the necessary work around dynamic interrupt controller
> > > initialization, debug and many other messy corners.
> >
> > That's OK, but the difference is not in the ACPi CPU enumeration/remova=
l code.
> >
> > > Thus anything defined had to be structured in a way that was 'differe=
nt'
> > > from that.
> >
> > Apparently, that's where things got confused.
> >
> > > I don't mind the proposed flattening of the 2 paths if the ARM kernel
> > > maintainers are fine with it but it will remove the distinctions and
> > > we will need to be very careful with the CPU masks - we can't handle
> > > them the same as x86 does.
> >
> > At the ACPI code level, there is no distinction.
> >
> > A CPU that was not available before has just become available.  The
> > platform firmware has notified the kernel about it and now
> > acpi_processor_add() runs.  Why would it need to use different code
> > paths depending on what _STA bits were clear before?
>
> I think we will continue to disagree on this.  To my mind and from the
> ACPI specification, they are two different state transitions with differe=
nt
> required actions.

Well, please be specific: What exactly do you mean here and which
parts of the spec are you talking about?

> Those state transitions are an ACPI level thing not
> an arch level one.  However, I want a solution that moves things forwards
> so I'll give pushing that entirely into the arch code a try.

Thanks!

Though I think that there is a disconnect between us that needs to be
clarified first.

> >
> > Yes, there is some arch stuff to be called and that arch stuff should
> > figure out what to do to make things actually work.
> >
> > > I'll get on with doing that, but do need input from Will / Catalin / =
James.
> > > There are some quirks that need calling out as it's not quite a simpl=
e
> > > as it appears from a high level.
> > >
> > > Another part of that long discussion established that there is usersp=
ace
> > > (Android IIRC) in which the CPU present mask must include all CPUs
> > > at boot. To change that would be userspace ABI breakage so we can't
> > > do that.  Hence the dance around adding yet another mask to allow the
> > > OS to understand which CPUs are 'present' but not possible to online.
> > >
> > > Flattening the two paths removes any distinction between calls that
> > > are for real hotplug and those that are for this online capable path.
> >
> > Which calls exactly do you mean?
>
> At the moment he distinction does not exist (because x86 only supports
> fake physical CPU HP and arm64 only vCPU HP / online capable), but if
> the architecture is defined for arm64 physical hotplug in the future
> we would need to do interrupt controller bring up + a lot of other stuff.
>
> It may be possible to do that in the arch code - will be hard to verify
> that until that arch is defined  Today all I need to do is ensure that
> any attempt to do present bit setting for ARM64 returns an error.
> That looks to be straight forward.

OK

>
> >
> > > As a side note, the indicating bit for these flows is defined in ACPI
> > > for x86 from ACPI 6.3 as a flag in Processor Local APIC
> > > (the ARM64 definition is a cut and paste of that text).  So someone
> > > is interested in this distinction on x86. I can't say who but if
> > > you have a mantis account you can easily follow the history and it
> > > might be instructive to not everyone considering the current x86
> > > flow the right way to do it.
> >
> > So a physically absent processor is different from a physically
> > present processor that has not been disabled.  No doubt about this.
> >
> > That said, I'm still unsure why these two cases require two different
> > code paths in acpi_processor_add().
>
> It might be possible to push the checking down into arch_register_cpu()
> and have that for now reject any attempt to do physical CPU HP on arm64.
> It is that gate that is vital to getting this accepted by ARM.
>
> I'm still very much stuck on the hotadd_init flag however, so any suggest=
ions
> on that would be very welcome!

I need to do some investigation which will take some time I suppose.

