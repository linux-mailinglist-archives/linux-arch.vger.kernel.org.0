Return-Path: <linux-arch+bounces-2516-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF68F85C54E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 20:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66CB1C21BA1
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 19:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0103D14A4CC;
	Tue, 20 Feb 2024 19:59:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3076C9C;
	Tue, 20 Feb 2024 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459163; cv=none; b=Jc+WI7OdsLxprygrQrGQI1ktCxotW8F4+3+d4isX2F3qe3aUWI7onEqQOaQnzpTm0rOrk6PPejLlY3BN1a95YC2M6zAu37IbetKmoAgCDHnT21aLnAbtxeKozsBnca9z5BEZJeik5LAuu9488lMcV0t70ezmXqAFvDg9IGiSP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459163; c=relaxed/simple;
	bh=gTFvzomr2SRYgEzay2hZVATAf6NMiZMviM+Vp+HoWxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6zf/em8jAVd52GqZPgdAdTZ/5Uq/QhxHH6a5uYVvW2GkO/Vx/z1JtAVigozBHWpCAxYxqeim/SCTVJyjPPZRSw6fhESBWhsO3V6jwGi16fD65cWZdbfvbJoQLygQ0l+4djFVV1oEfTtZHFNMyTTQKr9XWSUgxyXa5PXPYiZ1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59a134e29d2so427376eaf.0;
        Tue, 20 Feb 2024 11:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708459161; x=1709063961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+V6DSEmqeSEaDPjDjO9NLLJHviZ8vUVb/gdG26wrMI=;
        b=XyuhrIqC8IaKysFUubsuGrJso66nYb/0Y0hPTBMMXISh62JzNM23sNC313lf9CosPj
         pJPXzYNPzyqtzZuVEiNp3y+m7EX2pP46WQ3dqe5sem3lVUZwxWa95cHOt1PuRw4fm5Qj
         1FYkfGjTzrma6LirRgFDQ784brNnHIkWdMUrJ1tuRVh/10YsVGLXBkDSjzHRvChI7/sg
         gTZYB69d490grMaMb5oE5gTlYnF63ipGxiXnlQ8FDy3Ll/tqnaWmSomtS3T/l5obsALP
         nePUBW2S770d1wq9LXOyKH8HNwczCvMtFxOh370bH3b2fUXNWH80vR8e9//GXdFYudQj
         iBRg==
X-Forwarded-Encrypted: i=1; AJvYcCWGqSHlaySd72VpGEhZENfm8VcphDtAaD2SbbLj9egnYA4Qti6sFUxpoVfP3/QfKp9iZkw5jB2L6ZCDHPyI9j6xW7BVIK/xjWHmmahzT+Ol/G90FaLACooUBZygVhzb938VzgtYJ26UwMbFWwkGJpOjmjk+OQxnzt8cVS2ymSfTILO1avbdP2OlcB9FQ2KqXCVhy+FT28vTHTTPgb6wh6yihlihd9RHbNxfOMHEPXAzA7rTnWATReeUlaT5DxxIKd+4BhDizQ061CDhtL6goZUzxavAVmc7rGPLn+AvOHsIsCY7beE83lJbr4HEABtnQgt+e4srDDikQxIKSrGg9XdCj8tpKiyonvcH2r1vYRtO
X-Gm-Message-State: AOJu0YwMm7rfUEa5Xy7tdCwB3Gl+CyigAtGcfAeTccVyx0LzAgQzr6+o
	WWl892gB2LwuC0ihisoNMcqXEOVfbAEHWemixUOsa0qArewj+fn9D5GNCMTRYZgf1CQCH70cS0P
	ovzXs/978Retn4i0rGJaUP0gXIEc=
X-Google-Smtp-Source: AGHT+IFEVWcuOTZaUbB0YtEa95vMeA6CLZt+FHpk+AcHJ2Mh/Pssv0ffdkJ0b+NvBNH99Q+SN4zocbYW2Cype01NQz0=
X-Received: by 2002:a05:6820:1f8c:b0:59f:f650:61bb with SMTP id
 eq12-20020a0568201f8c00b0059ff65061bbmr3732586oob.0.1708459161081; Tue, 20
 Feb 2024 11:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk> <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
 <ZdSMk93c1I6x973h@shell.armlinux.org.uk> <ZdTBtt0oR6Q1RcAB@shell.armlinux.org.uk>
 <20240220162406.00005b59@Huawei.com>
In-Reply-To: <20240220162406.00005b59@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Feb 2024 20:59:09 +0100
Message-ID: <CAJZ5v0i0c3bg8E9yuRk00VAEW5isZ4N-mbnhRuTR8aiFLXo1_A@mail.gmail.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from acpi_processor_get_info()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:24=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 20 Feb 2024 15:13:58 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>
> > On Tue, Feb 20, 2024 at 11:27:15AM +0000, Russell King (Oracle) wrote:
> > > On Thu, Feb 15, 2024 at 08:22:29PM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Jan 31, 2024 at 5:50=E2=80=AFPM Russell King <rmk+kernel@ar=
mlinux.org.uk> wrote:
> > > > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_pr=
ocessor.c
> > > > > index cf7c1cca69dd..a68c475cdea5 100644
> > > > > --- a/drivers/acpi/acpi_processor.c
> > > > > +++ b/drivers/acpi/acpi_processor.c
> > > > > @@ -314,6 +314,18 @@ static int acpi_processor_get_info(struct ac=
pi_device *device)
> > > > >                         cpufreq_add_device("acpi-cpufreq");
> > > > >         }
> > > > >
> > > > > +       /*
> > > > > +        * Register CPUs that are present. get_cpu_device() is us=
ed to skip
> > > > > +        * duplicate CPU descriptions from firmware.
> > > > > +        */
> > > > > +       if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id)=
 &&
> > > > > +           !get_cpu_device(pr->id)) {
> > > > > +               int ret =3D arch_register_cpu(pr->id);
> > > > > +
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > > > +       }
> > > > > +
> > > > >         /*
> > > > >          *  Extra Processor objects may be enumerated on MP syste=
ms with
> > > > >          *  less than the max # of CPUs. They should be ignored _=
iff
> > > >
> > > > This is interesting, because right below there is the following cod=
e:
> > > >
> > > >     if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> > > >         int ret =3D acpi_processor_hotadd_init(pr);
> > > >
> > > >         if (ret)
> > > >             return ret;
> > > >     }
> > > >
> > > > and acpi_processor_hotadd_init() essentially calls arch_register_cp=
u()
> > > > with some extra things around it (more about that below).
> > > >
> > > > I do realize that acpi_processor_hotadd_init() is defined under
> > > > CONFIG_ACPI_HOTPLUG_CPU, so for the sake of the argument let's
> > > > consider an architecture where CONFIG_ACPI_HOTPLUG_CPU is set.
> > > >
> > > > So why are the two conditionals that almost contradict each other b=
oth
> > > > needed?  It looks like the new code could be combined with
> > > > acpi_processor_hotadd_init() to do the right thing in all cases.
> > > >
> > > > Now, acpi_processor_hotadd_init() does some extra things that look
> > > > like they should be done by the new code too.
> > > >
> > > > 1. It checks invalid_phys_cpuid() which appears to be a good idea t=
o me.
> > > >
> > > > 2. It uses locking around arch_register_cpu() which doesn't seem
> > > > unreasonable either.
> > > >
> > > > 3. It calls acpi_map_cpu() and I'm not sure why this is not done by
> > > > the new code.
> > > >
> > > > The only thing that can be dropped from it is the _STA check AFAICS=
,
> > > > because acpi_processor_add() won't even be called if the CPU is not
> > > > present (and not enabled after the first patch).
> > > >
> > > > So why does the code not do 1 - 3 above?
> > >
> > > Honestly, I'm out of my depth with this and can't answer your
> > > questions - and I really don't want to try fiddling with this code
> > > because it's just too icky (even in its current form in mainline)
> > > to be understandable to anyone who hasn't gained a detailed knowledge
> > > of this code.
> > >
> > > It's going to require a lot of analysis - how acpi_map_cpuid() behave=
s
> > > in all circumstances, what this means for invalid_logical_cpuid() and
> > > invalid_phys_cpuid(), what paths will be taken in each case. This cod=
e
> > > is already just too hairy for someone who isn't an experienced ACPI
> > > hacker to be able to follow and I don't see an obvious way to make it
> > > more readable.
> > >
> > > James' additions make it even more complex and less readable.
> >
> > As an illustration of the problems I'm having here, I was just writing
> > a reply to this with a suggestion of transforming this code ultimately
> > to:
> >
> >       if (!get_cpu_device(pr->id)) {
> >               int ret;
> >
> >               if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id)=
)
> >                       ret =3D acpi_processor_make_enabled(pr);
> >               else
> >                       ret =3D acpi_processor_make_present(pr);
> >
> >               if (ret)
> >                       return ret;
> >       }
> >
> > (acpi_processor_make_present() would be acpi_processor_hotadd_init()
> > and acpi_processor_make_enabled() would be arch_register_cpu() at this
> > point.)
> >
> > Then I realised that's a bad idea - because we really need to check
> > that pr->id is valid before calling get_cpu_device() on it, so this
> > won't work. That leaves us with:
> >
> >       int ret;
> >
> >       if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> >               /* x86 et.al. path */
> >               ret =3D acpi_processor_make_present(pr);
> >       } else if (!get_cpu_device(pr->id)) {
> >               /* Arm64 path */
> >               ret =3D acpi_processor_make_enabled(pr);
> >       } else {
> >               ret =3D 0;
> >       }
> >
> >       if (ret)
> >               return ret;
> >
> > Now, the next transformation would be to move !get_cpu_device(pr->id)
> > into acpi_processor_make_enabled() which would eliminate one of those
> > if() legs.
> >
> > Now, if we want to somehow make the call to arch_regster_cpu() common
> > in these two paths, the next question is what are the _precise_
> > semantics of acpi_map_cpu(), particularly with respect to it
> > modifying pr->id. Is it guaranteed to always give the same result
> > for the same processor described in ACPI? What acpi_map_cpu() anyway,
> > I can find no documentation for it.
> >
> > Then there's the question whether calling acpi_unmap_cpu() should be
> > done on the failure path if arch_register_cpu() fails, which is done
> > for the x86 path but not the Arm64 path. Should it be done for the
> > Arm64 path? I've no idea, but as Arm64 doesn't implement either of
> > these two functions, I guess they could be stubbed out and thus be
> > no-ops - but then we open a hole where if pr->id is invalid, we
> > end up passing that invalid value to arch_register_cpu() which I'm
> > quite sure will explode with a negative CPU number.
> >
> > So, to my mind, what you're effectively asking for is a total rewrite
> > of all the code in and called by acpi_processor_get_info()... and that
> > is not something I am willing to do (because it's too far outside of
> > my knowledge area.)
> >
> > As I said in my reply to patch 1, I think your comments on patch 2
> > make Arm64 vcpu hotplug unachievable in a reasonable time frame, and
> > certainly outside the bounds of what I can do to progress this.
> >
> > So, at this point I'm going to stand down from further participation
> > with this patch set as I believe I've reached the limit of what I can
> > do to progress it.
> >
>
> Thanks for your hard work on this Russell - we have moved forwards.
>
> Short of anyone else stepping up I'll pick this up with
> the help of some my colleagues. As such I'm keen on getting patch
> 1 upstream ASAP so that we can exclude the need for some of the
> other workarounds from earlier versions of this series (the ones
> dropped before now).

Applied (as 6.9 material).

> We will need a little time to get up to speed on the current status
> and discussion points Russell raises above.

Sure.

I'm planning to send comments for some other patches in the series this wee=
k.

Thanks!

