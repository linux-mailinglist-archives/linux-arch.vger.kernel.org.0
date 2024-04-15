Return-Path: <linux-arch+bounces-3677-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D598A4DD7
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 13:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAF21C21DA3
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8A35FDA5;
	Mon, 15 Apr 2024 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFioXq7A"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825CB1BF2A;
	Mon, 15 Apr 2024 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181045; cv=none; b=ehnYpFoLAErTnZWfueLApd8bPgo4IYtiUP0DTZK0rUjRaWHGvp+TrCPHIo36f+xN57XMYlt1U8RSetKHIWk79/7og1ECR9pNm1fWH7T/PCGt/fyuUQICrwL2CCBphUUSy/DpjHLcLfe50dhsRSGMDr0vKcAaI0Iq2JtenuvJzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181045; c=relaxed/simple;
	bh=dAuH92zwHVhX0LEVXHtXGLLI/vcbgG8GTycSwAAp+ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJZJqI2eyCs4wt89hM6rkgt4R3RE8P1BDcE2RVHMKJzucMqPPGSyPtrXoeHxpQbj+5c87nMKSKX1tq7TIYpevbNP6OeHRSEeGIbbeYggvqCWyWkzVJhSf51+fIjCuHtbGlBCyjaoos2OLi1uFJfB8Im2g6mq6OABBcu8hX74RS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFioXq7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5AEC4AF07;
	Mon, 15 Apr 2024 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713181045;
	bh=dAuH92zwHVhX0LEVXHtXGLLI/vcbgG8GTycSwAAp+ps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GFioXq7ARwQRstGBT785EZe+B3ehqo6BbhyRcNKTsqH3XqM9iUihaaocADgogTwWb
	 fSILbIp2QGwBviTkOjwdkcXgg3/Mi9Z4ntWoqlto8GZxx4VK+nzxC6G5cfH8+4F9B2
	 Yo5Msoa6OIqbk8z8LyeUe+BEkbraAiOfSvKtjOFgwdRTHaB3u2g2c6sGHvWWr48+Nu
	 1qve/s7ObaH+n5+aFgD3aokV1vAXpB2sdzlFSJYKeIiYXm9/a8YFUd2kDhquEw66IJ
	 dzvn1L3qPYvz41WURsskNynq3i2VZbGBC8l/cU5rBBf1MpofLQ14QS793yYSKOe2Iy
	 T6PZVB2xomsQA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c5f7a3a127so179087b6e.0;
        Mon, 15 Apr 2024 04:37:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWxgcoTstu16CT4g5zVaZqmMQjSMHipscVitXVokje6e+4/eZD2KXNI1GTnRrhTmug8GsmCz/Z0NotiFfRJ5ZgdVD8E2UGtWAw4Ff7NYx5KmXu1CakDXW/8MZLy4ZtLu16QrGjdr8lRtTxsriuf9DBWw/uCsI28SwQ6Wt2hmLY5Jj8tIo3/ywIHVb3lmN9iEZNN9DVC5iKgJB+CkiObg==
X-Gm-Message-State: AOJu0YyL68rXXdcCYLrSwLL97Y5Ah0HbE6GFi3HEB0kFtshiVoaHTe1Z
	MKThA18GVmYxDAQQqECtxg2CgDrz5PN2QsN0a8SWTmtVKaY5SRlY6gP8HuPnLAexXMso0TKLrCU
	KRnYYXcYKHhqQTsPnpsVaYwMm3H8=
X-Google-Smtp-Source: AGHT+IHpY14yXyTboghLMyDiioWb5anYtwdH8mgCI0DLw6hEeHHIPKqNeVrAdnvPnPPNi/0OSAEM5AVOUGvqTuo39DY=
X-Received: by 2002:a05:6870:d28d:b0:232:fa03:3736 with SMTP id
 d13-20020a056870d28d00b00232fa033736mr11562335oae.0.1713181044363; Mon, 15
 Apr 2024 04:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-4-Jonathan.Cameron@huawei.com> <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
 <ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk> <87bk6ez4hj.ffs@tglx>
 <ZhmtO6zBExkQGZLk@shell.armlinux.org.uk> <878r1iyxkr.ffs@tglx> <20240415094552.000008d7@Huawei.com>
In-Reply-To: <20240415094552.000008d7@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 13:37:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ireu4pOedLjMjK2NrLkq_2vySpdgEgGccQEiFC5=otWQ@mail.gmail.com>
Message-ID: <CAJZ5v0ireu4pOedLjMjK2NrLkq_2vySpdgEgGccQEiFC5=otWQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, Miguel Luis <miguel.luis@oracle.com>, 
	James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linuxarm@huawei.com, justin.he@arm.com, 
	jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:46=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sat, 13 Apr 2024 01:23:48 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
> > Russell!
> >
> > On Fri, Apr 12 2024 at 22:52, Russell King (Oracle) wrote:
> > > On Fri, Apr 12, 2024 at 10:54:32PM +0200, Thomas Gleixner wrote:
> > >> > As for the cpu locking, I couldn't find anything in arch_register_=
cpu()
> > >> > that depends on the cpu_maps_update stuff nor needs the cpus_write=
_lock
> > >> > being taken - so I've no idea why the "make_present" case takes th=
ese
> > >> > locks.
> > >>
> > >> Anything which updates a CPU mask, e.g. cpu_present_mask, after earl=
y
> > >> boot must hold the appropriate write locks. Otherwise it would be
> > >> possible to online a CPU which just got marked present, but the
> > >> registration has not completed yet.
> > >
> > > Yes. As far as I've been able to determine, arch_register_cpu()
> > > doesn't manipulate any of the CPU masks. All it seems to be doing
> > > is initialising the struct cpu, registering the embedded struct
> > > device, and setting up the sysfs links to its NUMA node.
> > >
> > > There is nothing obvious in there which manipulates any CPU masks, an=
d
> > > this is rather my fundamental point when I said "I couldn't find
> > > anything in arch_register_cpu() that depends on ...".
> > >
> > > If there is something, then comments in the code would be a useful ai=
d
> > > because it's highly non-obvious where such a manipulation is located,
> > > and hence why the locks are necessary.
> >
> > acpi_processor_hotadd_init()
> > ...
> >          acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
> >
> > That ends up in fiddling with cpu_present_mask.
> >
> > I grant you that arch_register_cpu() is not, but it might rely on the
> > external locking too. I could not be bothered to figure that out.
> >
> > >> Define "real hotplug" :)
> > >>
> > >> Real physical hotplug does not really exist. That's at least true fo=
r
> > >> x86, where the physical hotplug support was chased for a while, but
> > >> never ended up in production.
> > >>
> > >> Though virtualization happily jumped on it to hot add/remove CPUs
> > >> to/from a guest.
> > >>
> > >> There are limitations to this and we learned it the hard way on X86.=
 At
> > >> the end we came up with the following restrictions:
> > >>
> > >>     1) All possible CPUs have to be advertised at boot time via firm=
ware
> > >>        (ACPI/DT/whatever) independent of them being present at boot =
time
> > >>        or not.
> > >>
> > >>        That guarantees proper sizing and ensures that associations
> > >>        between hardware entities and software representations and th=
e
> > >>        resulting topology are stable for the lifetime of a system.
> > >>
> > >>        It is really required to know the full topology of the system=
 at
> > >>        boot time especially with hybrid CPUs where some of the cores
> > >>        have hyperthreading and the others do not.
> > >>
> > >>
> > >>     2) Hot add can only mark an already registered (possible) CPU
> > >>        present. Adding non-registered CPUs after boot is not possibl=
e.
> > >>
> > >>        The CPU must have been registered in #1 already to ensure tha=
t
> > >>        the system topology does not suddenly change in an incompatib=
le
> > >>        way at run-time.
> > >>
> > >> The same restriction would apply to real physical hotplug. I don't t=
hink
> > >> that's any different for ARM64 or any other architecture.
> > >
> > > This makes me wonder whether the Arm64 has been barking up the wrong
> > > tree then, and whether the whole "present" vs "enabled" thing comes
> > > from a misunderstanding as far as a CPU goes.
> > >
> > > However, there is a big difference between the two. On x86, a process=
or
> > > is just a processor. On Arm64, a "processor" is a slice of the system
> > > (includes the interrupt controller, PMUs etc) and we must enumerate
> > > those even when the processor itself is not enabled. This is the whol=
e
> > > reason there's a difference between "present" and "enabled" and why
> > > there's a difference between x86 cpu hotplug and arm64 cpu hotplug.
> > > The processor never actually goes away in arm64, it's just prevented
> > > from being used.
> >
> > It's the same on X86 at least in the physical world.
>
> There were public calls on this via the Linaro Open Discussions group,
> so I can talk a little about how we ended up here.  Note that (in my
> opinion) there is zero chance of this changing - it took us well over
> a year to get to this conclusion.  So if we ever want ARM vCPU HP
> we need to work within these constraints.
>
> The ARM architecture folk (the ones defining the ARM ARM, relevant ACPI
> specs etc, not the kernel maintainers) are determined that they want
> to retain the option to do real physical CPU hotplug in the future
> with all the necessary work around dynamic interrupt controller
> initialization, debug and many other messy corners.

That's OK, but the difference is not in the ACPi CPU enumeration/removal co=
de.

> Thus anything defined had to be structured in a way that was 'different'
> from that.

Apparently, that's where things got confused.

> I don't mind the proposed flattening of the 2 paths if the ARM kernel
> maintainers are fine with it but it will remove the distinctions and
> we will need to be very careful with the CPU masks - we can't handle
> them the same as x86 does.

At the ACPI code level, there is no distinction.

A CPU that was not available before has just become available.  The
platform firmware has notified the kernel about it and now
acpi_processor_add() runs.  Why would it need to use different code
paths depending on what _STA bits were clear before?

Yes, there is some arch stuff to be called and that arch stuff should
figure out what to do to make things actually work.

> I'll get on with doing that, but do need input from Will / Catalin / Jame=
s.
> There are some quirks that need calling out as it's not quite a simple
> as it appears from a high level.
>
> Another part of that long discussion established that there is userspace
> (Android IIRC) in which the CPU present mask must include all CPUs
> at boot. To change that would be userspace ABI breakage so we can't
> do that.  Hence the dance around adding yet another mask to allow the
> OS to understand which CPUs are 'present' but not possible to online.
>
> Flattening the two paths removes any distinction between calls that
> are for real hotplug and those that are for this online capable path.

Which calls exactly do you mean?

> As a side note, the indicating bit for these flows is defined in ACPI
> for x86 from ACPI 6.3 as a flag in Processor Local APIC
> (the ARM64 definition is a cut and paste of that text).  So someone
> is interested in this distinction on x86. I can't say who but if
> you have a mantis account you can easily follow the history and it
> might be instructive to not everyone considering the current x86
> flow the right way to do it.

So a physically absent processor is different from a physically
present processor that has not been disabled.  No doubt about this.

That said, I'm still unsure why these two cases require two different
code paths in acpi_processor_add().

