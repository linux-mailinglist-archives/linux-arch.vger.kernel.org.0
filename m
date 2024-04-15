Return-Path: <linux-arch+bounces-3705-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE308A5803
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 18:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01231C21DF3
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65183CC1;
	Mon, 15 Apr 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbCZMT16"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD296839FF;
	Mon, 15 Apr 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199126; cv=none; b=GvUBofUdn4vnTVOTstTaEusXEzG1Z9B9Ulp48u/hzJmlrgD1A1FJJwh4FfdWJSeg866+2ju4qhyM6euvrbal7oZ8K4e83ihYaHbmJHbJwhEaR2rO312b42gpy3rBhSppIikEt4F6mF1Mc9ofeuPpcqWcSr+asJlq2e4BXSkgVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199126; c=relaxed/simple;
	bh=Lpx9X63RcWaMhevdMPaLew097twR5vCrOTnF5fq9zys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/zoQJputTXbxXbD2u0brjPLf2xgEao9w7zRlUdPLJvRzgvozdV224h3NxihhxwC7aTLSmyvc3dpOSFA2fnvQR4Qn63EjjAW87OaZ23lEEVVb47tTfXSN1lOt02WBlNJzhmwfaPYUBHT8awhUhP5eeUEMfz/hK80ux1fUwirIfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbCZMT16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DC3C2BD11;
	Mon, 15 Apr 2024 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713199126;
	bh=Lpx9X63RcWaMhevdMPaLew097twR5vCrOTnF5fq9zys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jbCZMT16nkEFIamNUzFLIS1t1TUffLYUw1JYfdsgn6ZC+cY68TRiEvjqBxOzpJ2qt
	 knuP7pBKvCW7krs9+fuYKq6EDtmM1XCtCZhRqTObQHFqfNk9vq4E9VNsvUln5KOBVT
	 EPOZ3RiHw8Glc7JlsoabosI0H64/IJxhfiYkyibjyLkNiR4FcZToRpdGZBReFubEC7
	 R0ttczF3TpwKacbHDh4MEL2WGLZL31d0dEOevqBkoMV591UBI6H5HB3Qu3vIQOtdif
	 hCizRATcigTBrHpdDA5FsrqAoG7LDqPhN7AZLRtzBf8rLjIuSxPu5rrqR6qu9CfJNf
	 qo1wq0VXFei7g==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ac4470de3bso920535eaf.0;
        Mon, 15 Apr 2024 09:38:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAYeVXO9rOhmOwzRpJCeKCVZDv4cxc5cNZNzqb++/9/OpeN2psx1w0wZEhcQBie9qZZTAXfkzZg3q45m/ajO3ZbInlR0RIfmymgz9eVsdgZ5riphaqm2QtfJGvgo/aipxs0FOydylWAwZDujYrPoUB0CBbtm9/mbGkpheCUPewIKSe7HAHve2Qhc0slA9EgF56yiQwSz+XJxJGTQyxnQ==
X-Gm-Message-State: AOJu0YyePvkfKr9TyWutIwInCaD0Ng8X4o21yQnn/55wCLAC/LGwieaR
	P+YZmdRsl+UH75yLUuL8+16lZGFP3xwO4Da18HY3v/6KIM4YfNksdcVTOiOVz/xZZwFLh04fB8r
	UWEL6LLe7Z4/eM3rV4FsQTQP9fe4=
X-Google-Smtp-Source: AGHT+IGW4F0+RZbfD36o5CV291sGx/jb8GJoYXEZBX2BL9iEWrZ+TqZtEUx29AUS7W1wxRe/e9490drwz63npigYgHE=
X-Received: by 2002:a05:6870:4584:b0:233:abab:6d7e with SMTP id
 y4-20020a056870458400b00233abab6d7emr11003312oao.1.1713199125541; Mon, 15 Apr
 2024 09:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-4-Jonathan.Cameron@huawei.com> <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
 <ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk> <87bk6ez4hj.ffs@tglx>
 <e80bfa8cb9b74997a4214e531366c71d@huawei.com> <CAJZ5v0hgABc=c6L4ctTHZ+5afeQTM1-bXhxthEKGxs8hG8R=YQ@mail.gmail.com>
 <454d0d5c4ddd403c82610725b8e633d8@huawei.com>
In-Reply-To: <454d0d5c4ddd403c82610725b8e633d8@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 18:38:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iQ-z5+fh5hGrDEFuD=CD+YMMWTV3EazxnknWLnZj2Wyg@mail.gmail.com>
Message-ID: <CAJZ5v0iQ-z5+fh5hGrDEFuD=CD+YMMWTV3EazxnknWLnZj2Wyg@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, 
	Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>, 
	"justin.he@arm.com" <justin.he@arm.com>, "jianyong.wu@arm.com" <jianyong.wu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 5:31=E2=80=AFPM Salil Mehta <salil.mehta@huawei.com=
> wrote:
>
> >  From: Rafael J. Wysocki <rafael@kernel.org>
> >  Sent: Monday, April 15, 2024 1:51 PM
> >
> >  On Mon, Apr 15, 2024 at 1:51=E2=80=AFPM Salil Mehta <salil.mehta@huawe=
i.com>
> >  wrote:
> >  >

[cut]

> >  > >  Though virtualization happily jumped on it to hot add/remove CPUs
> >  > > to/from  a guest.
> >  > >
> >  > >  There are limitations to this and we learned it the hard way on
> >  > > X86. At the  end we came up with the following restrictions:
> >  > >
> >  > >      1) All possible CPUs have to be advertised at boot time via f=
irmware
> >  > >         (ACPI/DT/whatever) independent of them being present at bo=
ot time
> >  > >         or not.
> >  > >
> >  > >         That guarantees proper sizing and ensures that association=
s
> >  > >         between hardware entities and software representations and=
 the
> >  > >         resulting topology are stable for the lifetime of a system=
.
> >  > >
> >  > >         It is really required to know the full topology of the sys=
tem at
> >  > >         boot time especially with hybrid CPUs where some of the co=
res
> >  > >         have hyperthreading and the others do not.
> >  > >
> >  > >
> >  > >      2) Hot add can only mark an already registered (possible) CPU
> >  > >         present. Adding non-registered CPUs after boot is not poss=
ible.
> >  > >
> >  > >         The CPU must have been registered in #1 already to ensure =
that
> >  > >         the system topology does not suddenly change in an incompa=
tible
> >  > >         way at run-time.
> >  > >
> >  > >  The same restriction would apply to real physical hotplug. I don'=
t
> >  > > think that's  any different for ARM64 or any other architecture.
> >  >
> >  >
> >  > There is a difference:
> >  >
> >  > 1.   ARM arch does not allows for any processor to be NOT present. H=
ence,  because of
> >  > this restriction any of its related per-cpu components must be prese=
nt
> >  > and enumerated at the boot time as well (exposed by firmware and
> >  > ACPI). This means all the enumerated processors will be marked as
> >  > 'present' but they might exist in NOT enabled (_STA.enabled=3D0) sta=
te.
> >  >
> >  > There was one clear difference and please correct me if I'm wrong
> >  > here,  for x86, the LAPIC associated with the x86 core can be brough=
t online later even after boot?
> >  >
> >  > But for ARM Arch, processors and its corresponding per-cpu component=
s
> >  > like redistributors all need to be present and enumerated during the
> >  > boot time. Redistributors are part of ALWAYS-ON power domain.
> >
> >  OK
> >
> >  So what exactly is the problem with this and what does
> >  acpi_processor_add() have to do with it?
>
>
> For ARM Arch, during boot time, it should add processor as if no hotplug =
exists. But later,
> in context to the (fake) hotplug trigger from the virtualizer as a result=
 of the CPU (un)plug
> action  it should just end up in registering the already present CPU with=
 the Linux Driver Model.

So let me repeat this last time: acpi_processor_add() cannot do that,
because (as defined today) it rejects CPUs with the "enabled" bit
clear in _STA.

> >
> >  Do you want the per-CPU structures etc. to be created from the
> >  acpi_processor_add() path?
>
>
> I referred to the components related to ARM CPU Arch like redistributors =
etc.
> which will get initialized in context to Arch specific _init code not her=
e. This
> i.e. acpi_processor_add() is arch agnostic code common to all architectur=
es.
>
> [ A digression: You do have _weak functions which can be overridden to ar=
ch specific
>  handling like  arch_(un)map_cpu() etc. but we can't use those to defer i=
nitialize
>  the CPU related components - ARM Arch constraint!]

Not right now, but they can be added I suppose.

>
> >
> >  This plain won't work because acpi_processor_add(), as defined in the
> >  mainline kernel today (and the Jonathan's patches don't change that
> >  AFAICS), returns an error for processor devices with the "enabled" bit=
 clear
> >  in _STA (it returns an error if the "present" bit is clear too, but th=
at's
> >  obvious), so it only gets to calling arch_register_cpu() if
> >  *both* "present" and "enabled" _STA bits are set for the given process=
or
> >  device.
>
>
> If you are referring to the _STA check in the XX_hot_add_init() then in t=
he current
> kernel code it only checks for the ACPI_STA_DEVICE_PRESENT flag and not
> the ACPI_STA_DEVICE_ENABLED flag(?).

No, I am not.  I'm referring to this code in 6.9-rc4:

static int acpi_processor_add(struct acpi_device *device,
                    const struct acpi_device_id *id)
{
    struct acpi_processor *pr;
    struct device *dev;
    int result =3D 0;

    if (!acpi_device_is_enabled(device))
        return -ENODEV;

    ...
}

where acpi_device_is_enabled() is defined as follows:

bool acpi_device_is_enabled(const struct acpi_device *adev)
{
    return adev->status.present && adev->status.enabled;
}

> The code being reviewed has changed
> exactly that behavior for 2 legs i.e. make-present and make-enabled legs.

I'm not sure what you mean here, but the code above means that
acpi_processor_add) does not distinguish between CPU with the
"present" bit clear (in which case the "enabled" bit must also be
clear as per the spec) and CPUs with the "present" bit set and the
"enabled" bit clear.  These two cases are handled in the same way.

> I'm open to further address your point clearly.

I hope that the above is clear enough.

> >
> >  That, BTW, is why I keep saying that from the ACPI CPU enumeration cod=
e
> >  perspective, there is no difference between "present" and "enabled".
>
>
> Agreed but there is still a subtle difference.  Enumeration happens once =
and
> for all the processors during the boot time. And as confirmed by yourself=
 and
> Thomas as well that even in x86 arch all the processors will be discovere=
d and
> their topology fixed during the boot time which is effectively the same b=
ehavior
> as in the ARM Arch. But ARM assumes those 'present' bits in the present m=
asks
> to be set during the boot time which is not like x86(?).  Hence, 'present=
 cpu' Bits
> will always be equal to 'possible cpu' Bits. This is a constraint put by =
the ARM
> maintainers and looks unshakable.

Yes, there are differences between architectures, but the ACPI code is
(or at least should be) architecture-agnostic (as you said somewhere
above).  So why does this matter for the ACPI code?

> >
> >  > 2.  Agreed regarding the topology. Are you suggesting that we must
> >  > call arch_register_cpu() during boot time for all the 'present' CPUs=
?
> >  > Even if that's the case, we might still want to defer registration o=
f
> >  > the cpu device (register_cpu() API) with the Linux device model. Lat=
er
> >  > is what we are doing to hide/unhide the CPUs from the user while
> >  STA.Enabled Bit is toggled due to CPU (un)plug action.
> >
> >  There are two ways to approach this IMV, and both seem to be valid in
> >  principle.
> >
> >  One would be to treat CPUs with the "enabled" bit clear as not present=
 and
> >  create all of the requisite data structures for them when they become
> >  available (in analogy with the "real hot-add" case).
>
>
> Right. This one is out-of-scope for ARM Arch as we cannot defer any Arch
> specific sizing and initializations after boot i.e. when processor_add() =
gets
> called again later as a trigger of CPU plug action at the Virtualizer.
>
>
> >
> >  The alternative one is to create all of the requisite data structures =
for the
> >  CPUs that you find during boot, but register CPU devices for those hav=
ing
> >  the "enabled" _STA bit set.
>
>
> Correct. and we defer the registration for CPUs with online-capable Bit
> set in the ACPI MADT/GICC data structure. These CPUs basically form
> set of hot-pluggable CPUs on ARM.
>
>
> >
> >  It looks like you have chosen the second approach, which is fine with =
me
> >  (although personally, I would rather choose the first one), but then y=
our
> >  arch code needs to arrange for the requisite CPU data structures etc. =
to be
> >  set up before acpi_processor_add() gets called because, as per the abo=
ve,
> >  the latter just rejects CPUs with the "enabled" _STA bit clear.
>
> Yes, correct. First one is not possible - at least for now and to have th=
at it will
> require lot of rework especially at GIC. But there are many other arch co=
mponents
> (like timers, PMUs, etc.) whose behavior needs to be specified somewhere =
in the
> architecture as well. All these are closely coupled with the ARM CPU arch=
itecture.
> (it's beyond this discussion and lets leave that to ARM folks).
>
> This patch-set has a change to deal with ACPI _STA.Enabled Bit accordingl=
y.

Well, I'm having a hard time with this.

As far as CPU enumeration goes, if the "enabled" bit is clear in _STA,
it does not happen at all.  Both on ARM and on x86.

Now tell me why there need to be two separate code paths calling
arch_register_cpu() in acpi_processor_add()?

I see no reason whatsoever.

Moreover, I see reasons why there needs to be only one such code path.

Please feel free to prove me wrong.

Thanks!

