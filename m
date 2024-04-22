Return-Path: <linux-arch+bounces-3893-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5AB8AD452
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 20:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782A42872B8
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEBB157A57;
	Mon, 22 Apr 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULN97FhV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E52155334;
	Mon, 22 Apr 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811603; cv=none; b=N0eMWHuGiKWIDzoVycrQX2wCUxeZuKUWbQOR3O8hh9eocJegKd02P7QNVZpB+daZ0HSuyVBrHlHxy2nCmCWwLDjSz10W04DXw3zKPyDRun+B/qBFhSljReEhmMc33/7IgnAp/DIS9RW18HMqxM4H66dN90w/BnCbtVr0ct+1X0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811603; c=relaxed/simple;
	bh=N900p0AA4Gj2ka7kPwyA1nPYs1lshTu/dBwgZ7ZyDfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DH5GvgQI8Y4YfJVA2Gs0Nbsj1VeFqX2Io74FJ9CsysqRblvFe3Vs9ZFXKSoZLg7ocuFYybtwjIT1It22Teiq9WYSOCD86FyI5egOOQUYO/oRJZGskEzM5tQxzS1Zp6+KQbkccj3pO7Jc+IsliorOCfR9u8zpfbbK9w/rn03yj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULN97FhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3ADC4AF08;
	Mon, 22 Apr 2024 18:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713811603;
	bh=N900p0AA4Gj2ka7kPwyA1nPYs1lshTu/dBwgZ7ZyDfU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ULN97FhVdNfET8mkchoUJo7WdV66EI7mzFEF1lsRkSlqDG+gpAQABpRslrsJfCDBL
	 y7oMVKEBzRwd0d6NQSI2LGavm/zJMYvb5WQfzbGSxV55zqqL9c8Hd0pKPmRZFdmInI
	 vUUhV1FB4PEylph35IkhP2ogWn1D9fboh28UECFCYVvDVw8g2YvfwX5Y8k0ifOPNQb
	 EXdckpeIMOCUCOMpQ7kuIAIBzQFrKtsHIfIATwGhvpwN8JzoQhqq6EIWKZhyCdOQgZ
	 2r81mCmcIfBw4cPitlEySlY039SRZNgFlyg2C9bH8tB6bGjP6tJpAjFIUIHJO3+YZp
	 gppskfjTrMuvg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c751391320so68735b6e.3;
        Mon, 22 Apr 2024 11:46:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXoVzp9qqhDp2vIzGqEs7kvXWmClMzvJEoHUVzeLaEkh03WYhoWgWroTJ7OlSOm6sEINAy/Iw3vIXJ1lrIxMUA9dEtArKeK5LucKRwe1kWs45+rAlAwsbOEDv+p9Yddt5yIAs31BYgV2KEhPXyAPbfwA1v7B+UAlbZsB4YTV0TnJkBgc20hfbUFXVNl/AuqGywTMtP6Hnclbd2QqWmRsg==
X-Gm-Message-State: AOJu0Yw8w93NB+Nq3uQWDARD4mOiAhu0JAlQcIGpJ5kMlzfgDdy15uSG
	FAtDMeX5YzpZblli0yP9g6EXwrfad+RTJzAvWiJ4P+x5ZXGR/xE99V2UMCtA/MzMdsFQivJNh9c
	57m/YJG1benyIr8rKYCyrqeDvkyc=
X-Google-Smtp-Source: AGHT+IFPgOe8ULWuvYcbF8vz2a93mVviOXf9qv95GFOeoCEFC8u/XjGJwHUKi+S9n2GACxOH6R+xy6O8qM2nNJJ8ELU=
X-Received: by 2002:a05:6820:e07:b0:5aa:14ff:4128 with SMTP id
 el7-20020a0568200e0700b005aa14ff4128mr11063972oob.1.1713811602518; Mon, 22
 Apr 2024 11:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com> <20240418135412.14730-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240418135412.14730-2-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 20:46:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hrXHbv8JGydxwD1PP_M1GOm040=+OTDFLcpy3bmzf24A@mail.gmail.com>
Message-ID: <CAJZ5v0hrXHbv8JGydxwD1PP_M1GOm040=+OTDFLcpy3bmzf24A@mail.gmail.com>
Subject: Re: [PATCH v7 01/16] ACPI: processor: Simplify initial onlining to
 use same path for cold and hotplug
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com, justin.he@arm.com, 
	jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 3:54=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Separate code paths, combined with a flag set in acpi_processor.c to
> indicate a struct acpi_processor was for a hotplugged CPU ensured that
> per CPU data was only set up the first time that a CPU was initialized.
> This appears to be unnecessary as the paths can be combined by letting
> the online logic also handle any CPUs online at the time of driver load.
>
> Motivation for this change, beyond simplification, is that ARM64
> virtual CPU HP uses the same code paths for hotplug and cold path in
> acpi_processor.c so had no easy way to set the flag for hotplug only.
> Removing this necessity will enable ARM64 vCPU HP to reuse the existing
> code paths.
>
> Leave noisy pr_info() in place but update it to not state the CPU
> was hotplugged.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

LGTM, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v7: No change.
> v6: New patch.
> RFT: I have very limited test resources for x86 and other
> architectures that may be affected by this change.
> ---
>  drivers/acpi/acpi_processor.c   |  1 -
>  drivers/acpi/processor_driver.c | 44 ++++++++++-----------------------
>  include/acpi/processor.h        |  2 +-
>  3 files changed, 14 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 7a0dd35d62c9..7fc924aeeed0 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -216,7 +216,6 @@ static int acpi_processor_hotadd_init(struct acpi_pro=
cessor *pr)
>          * gets online for the first time.
>          */
>         pr_info("CPU%d has been hot-added\n", pr->id);
> -       pr->flags.need_hotplug_init =3D 1;
>
>  out:
>         cpus_write_unlock();
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index 67db60eda370..55782eac3ff1 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -33,7 +33,6 @@ MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI Processor Driver");
>  MODULE_LICENSE("GPL");
>
> -static int acpi_processor_start(struct device *dev);
>  static int acpi_processor_stop(struct device *dev);
>
>  static const struct acpi_device_id processor_device_ids[] =3D {
> @@ -47,7 +46,6 @@ static struct device_driver acpi_processor_driver =3D {
>         .name =3D "processor",
>         .bus =3D &cpu_subsys,
>         .acpi_match_table =3D processor_device_ids,
> -       .probe =3D acpi_processor_start,
>         .remove =3D acpi_processor_stop,
>  };
>
> @@ -115,12 +113,10 @@ static int acpi_soft_cpu_online(unsigned int cpu)
>          * CPU got physically hotplugged and onlined for the first time:
>          * Initialize missing things.
>          */
> -       if (pr->flags.need_hotplug_init) {
> +       if (!pr->flags.previously_online) {
>                 int ret;
>
> -               pr_info("Will online and init hotplugged CPU: %d\n",
> -                       pr->id);
> -               pr->flags.need_hotplug_init =3D 0;
> +               pr_info("Will online and init CPU: %d\n", pr->id);
>                 ret =3D __acpi_processor_start(device);
>                 WARN(ret, "Failed to start CPU: %d\n", pr->id);
>         } else {
> @@ -167,9 +163,6 @@ static int __acpi_processor_start(struct acpi_device =
*device)
>         if (!pr)
>                 return -ENODEV;
>
> -       if (pr->flags.need_hotplug_init)
> -               return 0;
> -
>         result =3D acpi_cppc_processor_probe(pr);
>         if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
>                 dev_dbg(&device->dev, "CPPC data invalid or not present\n=
");
> @@ -185,32 +178,21 @@ static int __acpi_processor_start(struct acpi_devic=
e *device)
>
>         status =3D acpi_install_notify_handler(device->handle, ACPI_DEVIC=
E_NOTIFY,
>                                              acpi_processor_notify, devic=
e);
> -       if (ACPI_SUCCESS(status))
> -               return 0;
> +       if (!ACPI_SUCCESS(status)) {
> +               result =3D -ENODEV;
> +               goto err_thermal_exit;
> +       }
> +       pr->flags.previously_online =3D 1;
>
> -       result =3D -ENODEV;
> -       acpi_processor_thermal_exit(pr, device);
> +       return 0;
>
> +err_thermal_exit:
> +       acpi_processor_thermal_exit(pr, device);
>  err_power_exit:
>         acpi_processor_power_exit(pr);
>         return result;
>  }
>
> -static int acpi_processor_start(struct device *dev)
> -{
> -       struct acpi_device *device =3D ACPI_COMPANION(dev);
> -       int ret;
> -
> -       if (!device)
> -               return -ENODEV;
> -
> -       /* Protect against concurrent CPU hotplug operations */
> -       cpu_hotplug_disable();
> -       ret =3D __acpi_processor_start(device);
> -       cpu_hotplug_enable();
> -       return ret;
> -}
> -
>  static int acpi_processor_stop(struct device *dev)
>  {
>         struct acpi_device *device =3D ACPI_COMPANION(dev);
> @@ -279,9 +261,9 @@ static int __init acpi_processor_driver_init(void)
>         if (result < 0)
>                 return result;
>
> -       result =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> -                                          "acpi/cpu-drv:online",
> -                                          acpi_soft_cpu_online, NULL);
> +       result =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +                                  "acpi/cpu-drv:online",
> +                                  acpi_soft_cpu_online, NULL);
>         if (result < 0)
>                 goto err;
>         hp_online =3D result;
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 3f34ebb27525..e6f6074eadbf 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -217,7 +217,7 @@ struct acpi_processor_flags {
>         u8 has_lpi:1;
>         u8 power_setup_done:1;
>         u8 bm_rld_set:1;
> -       u8 need_hotplug_init:1;
> +       u8 previously_online:1;
>  };
>
>  struct acpi_processor {
> --

