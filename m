Return-Path: <linux-arch+bounces-3537-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C4389F9BA
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 16:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B911C211DF
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A1F15ADB0;
	Wed, 10 Apr 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5PUTdDH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8315ECEA;
	Wed, 10 Apr 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758803; cv=none; b=urMbRKSyZub3GgAWUGHx98bZPwDVufi7qhhKK1bYrW/8XqhtKf5qhrAu1tW7G44fet4dEOKn0CXyFCE2/fPe8PDHTm4zds/ab51wtxKsvgGVGGO1jyHgeO+KOM7jMRxmODXE3Zoh41RBTN6GNq2DTzqvE/0M7fC1oF261Lv5VDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758803; c=relaxed/simple;
	bh=OvoVNaySrcXw62YX7UG0Hd2hLfS04EbJaAtBVkIIqd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEZ6/gold/9XgML9VlulN89X4WvxRHpKk1ClhQXsW77K8KMSIZYzDpuI+hJWjvSifIzm4PziVqpGjPn7a4sBp5RkSIiL2yafMVkym4ig/fcR3BBPIv6Bf49rNSFriVHS4kMoFEdEKAyAQMK9UTynmRmBwHgmoS/wd/Vff5PaCnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5PUTdDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1516BC43330;
	Wed, 10 Apr 2024 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758803;
	bh=OvoVNaySrcXw62YX7UG0Hd2hLfS04EbJaAtBVkIIqd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s5PUTdDHBVvTl0uWmYq/RKh8Aa8mIAETnLABi1L3GGcnVaDiAnN6DgdGTb4B1wwpX
	 PQBJDnMksAax6GHrRfANFcQkVRxHXdz4xI6wV4SD/31BCwju1b3UJZhIIQ/i6+NuvZ
	 AuCnnYt9U0fNVXvhwVsQPkJs9aysHYSdYvsHGQA6fyUgQwG86k6t+qDtL1nznrMudT
	 dq/2gTJxzeqm7Jrd1OgDua4rSQnMVIlwNufz86jQyLGE0aUwkFmQn2ySsUivHJHam+
	 5YdthBMby3c3qh9i3I47xtQsKEH+xSnd5/uOT+TTvCQwFW5oKjEm3i7aISHe3EGTs8
	 7WHVpWvOL640Q==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-22ec8db3803so548192fac.1;
        Wed, 10 Apr 2024 07:20:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzkfJeDHqYDufJHMAXVe4eQ3YxQggxVytyCcrlZKh8T+xk/BsN6a9tOPOYqOW4+1Dx7I7qdCJXHpj7pY3gBbRvLQjBXyBm0CmAH40YJlZf4hLyGwNhRw7HPFiY1UGhgk4GCSvSzFf6veAHhPd+YAyI8s//YR6RK7hLE1h7uLFxEW9Qze7PnvXA3jYiOScwH61CVCSi4XgvPbLaWspx+IeNvmtlq2JjwEaVN2EXzbu3caBk1ckKj3XGBGrDr+bDts3Sx6Qo8GgIjG2E+cLMbd5uRsO8BQgPKjqacpMKme6zcnn72ASxhCVrPkf/O7zRX9wWTRqzXqvwbP1bGQTQdUmOUXk6aK49yQ/5Q6LjJpED
X-Gm-Message-State: AOJu0Yz6NiBOJIk4oTwJHT0+XhUQZRxPWc78yavsZVRYQ712E9cV4EbT
	B/TErijrVyff83TyGsDu95Zi9vrZq61R/YLjs2H02+126z5Sd2cVxMJDDiBhz+4DFWlpnvxOQ4p
	h8IPaEZqHE3+8NhHTrpW6yxKzcWo=
X-Google-Smtp-Source: AGHT+IFUbYvctHLscpPyYTlJqJkvjz7Lv1BPzvm+G1krAlpB1R6DPKUMcWT+4z93yfQwfckyfvgV5dE3NAZ750FVX1Q=
X-Received: by 2002:a05:6870:9e47:b0:22e:b175:3c22 with SMTP id
 pt7-20020a0568709e4700b0022eb1753c22mr3170425oab.1.1712758802087; Wed, 10 Apr
 2024 07:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk> <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
 <20240322185327.00002416@Huawei.com> <20240410134318.0000193c@huawei.com>
 <CAJZ5v0ggD042sfz3jDXQVDUxQZu_AWaF2ox-Me8CvFeRB8nczw@mail.gmail.com> <20240410145005.00003050@Huawei.com>
In-Reply-To: <20240410145005.00003050@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Apr 2024 16:19:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hRPFd7jmhJdCu8jVCRc4hZRUt9sKm6iWfynZH1mX7rCg@mail.gmail.com>
Message-ID: <CAJZ5v0hRPFd7jmhJdCu8jVCRc4hZRUt9sKm6iWfynZH1mX7rCg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from acpi_processor_get_info()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, 
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 3:50=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 10 Apr 2024 15:28:18 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Wed, Apr 10, 2024 at 2:43=E2=80=AFPM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > > >
> > > > > > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > > > > > index 47de0f140ba6..13d052bf13f4 100644
> > > > > > --- a/drivers/base/cpu.c
> > > > > > +++ b/drivers/base/cpu.c
> > > > > > @@ -553,7 +553,11 @@ static void __init cpu_dev_register_generi=
c(void)
> > > > > >  {
> > > > > >         int i, ret;
> > > > > >
> > > > > > -       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> > > > > > +       /*
> > > > > > +        * When ACPI is enabled, CPUs are registered via
> > > > > > +        * acpi_processor_get_info().
> > > > > > +        */
> > > > > > +       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_di=
sabled)
> > > > > >                 return;
> > > > >
> > > > > Honestly, this looks like a quick hack to me and it absolutely
> > > > > requires an ACK from the x86 maintainers to go anywhere.
> > > > Will address this separately.
> > > >
> > >
> > > So do people prefer this hack, or something along lines of the follow=
ing?
> > >
> > > static int __init cpu_dev_register_generic(void)
> > > {
> > >         int i, ret =3D 0;
> > >
> > >         for_each_online_cpu(i) {
> > >                 if (!get_cpu_device(i)) {
> > >                         ret =3D arch_register_cpu(i);
> > >                         if (ret)
> > >                                 pr_warn("register_cpu %d failed (%d)\=
n", i, ret);
> > >                 }
> > >         }
> > >         //Probably just eat the error.
> > >         return 0;
> > > }
> > > subsys_initcall_sync(cpu_dev_register_generic);
> >
> > I would prefer something like the above.
> >
> > I actually thought that arch_register_cpu() might return something
> > like -EPROBE_DEFER when it cannot determine whether or not the CPU is
> > really available.
>
> Ok. That would end up looking much more like the original code I think.
> So we wouldn't have this late registration at all, or keep it for DT
> on arm64?  I'm not sure that's a clean solution though leaves
> the x86 path alone.

I'm not sure why DT on arm64 would need to do late registration.

There is this chain of calls in the mainline today:

driver_init()
  cpu_dev_init()
    cpu_dev_register_generic()

the last of which registers CPUs on arm64/DT systems IIUC. I don't see
a need to change this behavior.

On arm64/ACPI, though, arch_register_cpu() cannot make progress until
it can look into the ACPI Namespace, so I would just make it return
-EPROBE_DEFER or equivalent then and the ACPI enumeration will find
the CPU and basically treat it as one that has just appeared.

> If we get rid of this catch all, solution would be to move the
> !acpi_disabled check into the arm64 version of arch_cpu_register()
> because we would only want the delayed registration path to be
> used on ACPI cases where the question of CPU availability can't
> yet be resolved.

Exactly.

This is similar (if not equivalent even) to a CPU becoming available
between the cpu_dev_register_generic() call and the ACPI enumeration.

> >
> > Then, the ACPI processor enumeration path may take care of registering
> > CPU that have not been registered so far and in the more-or-less the
> > same way regardless of the architecture (modulo some arch-specific
> > stuff).
>
> If I understand correctly, in acpi_processor_get_info() we'd end up
> with a similar check on whether it was already registered (the x86 path)
> or had be deferred (arm64 / acpi).
>
> >
> > In the end, it should be possible to avoid changing the behavior of
> > x86 and loongarch in this series.
>
> Possible, yes, but result if I understand correctly is we end up with
> very different flows and replication of functionality between the
> early registration and the late one. I'm fine with that if you prefer it!

But that's what is there today, isn't it?

I think this can be changed to reduce the duplication, but I'd prefer
to do that later, when the requisite functionality is in place and we
just do the consolidation.  In that case, if anything goes wrong, we
can take a step back and reconsider without deferring the arm64 CPU
hotplug support.

> >
> > > Which may look familiar at it's effectively patch 3 from v3 which was=
 dealing
> > > with CPUs missing from DSDT (something we think doesn't happen).
> > >
> > > It might be possible to elide the arch_register_cpu() in
> > > make_present() but that will mean we use different flows in this patc=
h set
> > > for the hotplug and initially present cases which is a bit messy.
> > >
> > > I've tested this lightly on arm64 and x86 ACPI + DT booting and it "s=
eems" fine.
> >
> > Sounds promising.
>
> Possibly not that relevant though if proposal is to drop this approach. :=
(
> At least I now have test setups!

Great!

