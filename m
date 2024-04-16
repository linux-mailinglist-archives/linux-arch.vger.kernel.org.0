Return-Path: <linux-arch+bounces-3736-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4108F8A743A
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 21:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E31C2187E
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 19:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF033138486;
	Tue, 16 Apr 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsZ1iD5N"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96926137748;
	Tue, 16 Apr 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294135; cv=none; b=J8532YG/+dSFdyWs350DZ7mlGmO8IBjXm3D6FKT9d/mg4jFJ0dEC9qcSp1eMYExbX2WxAKDPWKk/o3hr8HuN3wrXNSbVRKiQ52E9jNRTdfcFa0ju5K03jmYf80ijmBf4YI5SfvnxO0rdJfh7rgAEsrzIWlGidpo8VDOjMK7fWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294135; c=relaxed/simple;
	bh=xbskRV8m/+XN6NH2m8afNoKnmWeG0OzTrmA+SGInC2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVse+Dfmmqt1tdelpXUrMImcUbRqJyAbR0TrJu8PFFeNncW4Klq30+eo9yXRnrUMH4bS1Ck59Xnhv9s8+DmoSElP+0s4TwXLKt1Zq2s2dqkg0h6V4SptWl9rLwh0VbyX/0zf0aDQOwKzh/WXuktWGeH/xH6IuMqJZwlnCBj+O/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsZ1iD5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5478BC4AF0E;
	Tue, 16 Apr 2024 19:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713294135;
	bh=xbskRV8m/+XN6NH2m8afNoKnmWeG0OzTrmA+SGInC2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BsZ1iD5Nd0d4B6HXNkBHNhwT4LiiWc88yZUQZOPWqCQret+uyX993UiVDEdXnTQpZ
	 i+0iRxF78oS0mCLtwntmBow82cS81/MNHk/euznN+1VogyU2uvGQNlFiP3RAekV8ZZ
	 JUyUoVCxOUgz5WA1BpUwqxv6orExQ6CEOkIl7Ln5jgg1FrwS1lxDBRn7+JLvJ5lDsn
	 qfIZDWeWTFh5naNuIBI1NkF4/TaI7mxKxaobY5r/KUieAf/+pzCcjsTF4Wih403x9q
	 s5GnRQ7NhXx3QnWrU9BEPwOT48kAMz7YncYjrHuetrhWT0p7Kwou0NeqRGFTJ7KbSp
	 rFw6bdV4pLu+Q==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5acdbfa7a45so89186eaf.2;
        Tue, 16 Apr 2024 12:02:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpdebi6ZoqTkcKV2RNxmQnMTB4GKRTK8FXXM+4WkvGpD26OOpnf7tZyh20o/8y2g5BAt1WA1ig8oAu+N8WexL02SXP3Jf1jcWBsylmVnau1OsJE/Mygn144IbR6jEPICVdjKqaWJ4JSV0NXTg9Tf0pG0WrsHA8DUKGfxgr9E4LOEoINhmY1I0AvynvHrDWz9ENzQuBADn+adz8QOnreQ==
X-Gm-Message-State: AOJu0YxWDSA63iSWjSmIhpoqKhX6//OKcRA2UmPem1LFr/3GzbPvo3vY
	CGwbBeCWPqZXj2HKpc3IP8ZxQukAqgTiihHUjD6SVr3/NbVpnOKHSSMdDnNKqQtHrCBwshqdOKI
	GI7ksXKuwVeKFeI0HXkP91QMDZY8=
X-Google-Smtp-Source: AGHT+IGfLxmXEH+uUXC9TAUq3KwcPBawoHi+dzfu7++eeN3j3YN9GuWwKcm2PcJPtxo1jL4YEoWhIRWKjGy4htEVqRk=
X-Received: by 2002:a05:6820:4008:b0:5aa:6b2e:36f0 with SMTP id
 fh8-20020a056820400800b005aa6b2e36f0mr16275342oob.0.1713294134546; Tue, 16
 Apr 2024 12:02:14 -0700 (PDT)
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
 <20240415125649.00001354@huawei.com> <CAJZ5v0iNSmV6EsBOc5oYWSTR9UvFOeg8_mj8Ofhum4Tonb3kNQ@mail.gmail.com>
 <20240415132351.00007439@huawei.com> <20240416184116.0000513c@huawei.com>
In-Reply-To: <20240416184116.0000513c@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Apr 2024 21:02:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iK61_ihUZX_tXoSGdhpYDWFhEBbEuFf6WFiiD0QSeTDg@mail.gmail.com>
Message-ID: <CAJZ5v0iK61_ihUZX_tXoSGdhpYDWFhEBbEuFf6WFiiD0QSeTDg@mail.gmail.com>
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

On Tue, Apr 16, 2024 at 7:41=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 15 Apr 2024 13:23:51 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>
> > On Mon, 15 Apr 2024 14:04:26 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:

[cut]

> > > > I'm still very much stuck on the hotadd_init flag however, so any s=
uggestions
> > > > on that would be very welcome!
> > >
> > > I need to do some investigation which will take some time I suppose.
> >
> > I'll do so as well once I've gotten the rest sorted out.  That whole
> > structure seems overly complex and liable to race, though maybe suffici=
ent
> > locking happens to be held that it's not a problem.
>
> Back to this a (maybe) last outstanding problem.
>
> Superficially I think we might be able to get around this by always
> doing the setup in the initial online. In brief that looks something the
> below code.  Relying on the cpu hotplug callback registration calling
> the acpi_soft_cpu_online for all instances that are already online.
>
> Very lightly tested on arm64 and x86 with cold and hotplugged CPUs.
> However this is all in emulation and I don't have access to any significa=
nt
> x86 test farms :( So help will be needed if it's not immediately obvious =
why
> we can't do this.

AFAICS, this should work.  At least I don't see why it wouldn't.

> Of course, I'm open to other suggestions!
>
> For now I'll put a tidied version of this one is as an RFC with the rest =
of v6.
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 06e718b650e5..97ca53b516d0 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -340,7 +340,7 @@ static int acpi_processor_get_info(struct acpi_device=
 *device)
>          */
>         per_cpu(processor_device_array, pr->id) =3D device;
>         per_cpu(processors, pr->id) =3D pr;
> -
> +       pr->flags.need_hotplug_init =3D 1;
>         /*
>          *  Extra Processor objects may be enumerated on MP systems with
>          *  less than the max # of CPUs. They should be ignored _iff
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index 67db60eda370..930f911fc435 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -206,7 +206,7 @@ static int acpi_processor_start(struct device *dev)
>
>         /* Protect against concurrent CPU hotplug operations */
>         cpu_hotplug_disable();
> -       ret =3D __acpi_processor_start(device);
> +       //      ret =3D __acpi_processor_start(device);
>         cpu_hotplug_enable();
>         return ret;
>  }

So it looks like acpi_processor_start() is not necessary any more, is it?

> @@ -279,7 +279,7 @@ static int __init acpi_processor_driver_init(void)
>         if (result < 0)
>                 return result;
>
> -       result =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +       result =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>                                            "acpi/cpu-drv:online",
>                                            acpi_soft_cpu_online, NULL);
>         if (result < 0)
> >
> > Jonathan

Thanks!

