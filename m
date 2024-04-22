Return-Path: <linux-arch+bounces-3900-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3018AD4A5
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 21:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398C01F21B4C
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644BD15531C;
	Mon, 22 Apr 2024 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3u8AYCA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30623155307;
	Mon, 22 Apr 2024 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813024; cv=none; b=Q5h6EXy28+SN3oymXnNL5E0I1/ggVzTxiJedgXNIZYfV9NqTkelAGQNf3z/GDCELRa2ARXUvh4rCpLeGlGPv8XP7ItVRa+s5Lm41oFDLSwvvtb8FY7gceHdxhD5f/RsHPAt31KNFy9ThS5PPMnDJMvQ/qAukJCmZ0326IP5IGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813024; c=relaxed/simple;
	bh=xr5Uhja78DTlat29wuEJWkFNot6eT4eX2GLpPmEimFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4Dj5ty9HezRIfCj9bWZjPy+swz9SHTzmasKxZvJ010j9PfyWV+t8daYXVKALXkK3te16waO1U9HU3b3zOfuF4WnaSAPSX/k1Yyds/P4dzeKBZmu9d3jAunUJbCmT6yeOvZ3JV+cxfDrjZRR9MCTccJakARtMdl4dnbQpke7KqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3u8AYCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C4EC4AF0C;
	Mon, 22 Apr 2024 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713813023;
	bh=xr5Uhja78DTlat29wuEJWkFNot6eT4eX2GLpPmEimFo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I3u8AYCAMeEZCdeNFQjGY0Fzjk1kTkDnwULJptJPBdSIr8PJHA8E2VZ2xdg20aR0X
	 IsgzWC2am9NEkW0AsGb2v0fJ52Y26jsfKqjG8nTt58VuAgohpQVa1hDiy1+lNONOmi
	 3AikdQXQtPi7TBEnpSqgSsfMbFhRWTmHMjzcJU3yrjFNQlN9hsXqpk87XT9cNXZlDG
	 O+aFL85Q7RgnBvbjYH0bqEj+3Rc7vW311VgW3rLDkexz7D2STu72DiqAvb6Dv8YIsJ
	 mll/lKgroBVm/ONoG4dvYPD365rpZ98i+B/Z7g2AaNYb4qCZbnYvUZbq6mJpPUIbuY
	 bANwacZE5Se9g==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6eb50bbd8ceso781385a34.1;
        Mon, 22 Apr 2024 12:10:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUy1Wfvp5w8ps03QMlXNEX7rvkA42+IWVAv05YhEztJCu/o0Em3ZmUVQHT52rkk6Rm5qHEm5U0tfSKUGWBOWOylQNJ9ONHNWbDPjYm2arF2QumvdT7vAgP8/XqGO5eTmd9qnsFii3jnSWhSAdQfoAdiB/E7wzNn02a6npncm9Zb3w7l6vky87gyrZFzsWt5CXdvhG6n5VOvUG0a7lkRw==
X-Gm-Message-State: AOJu0Yys1KUkMPIucCZ3wA/3SQYUKriXKg3lY2vVdC1GytqvIVpX76W0
	lqWAXzn1G0KSR6vkz0D6NGLbUEBeUUz5EqvPpneRTjCB8X6fr17WtTG/6oPH7bNmQS6nMYb219d
	L1u4hJReqKtKIWw1sJjLWhWrE9qM=
X-Google-Smtp-Source: AGHT+IGddIzuXRIOq0vcaD27xeni4nJNgz8BRaRjdkma7vizXw+C3Ho4ufbzOxRg6uAQwtupRrmwkhqM8niU4Ra55DE=
X-Received: by 2002:a05:6871:2010:b0:233:abab:6d7e with SMTP id
 rx16-20020a056871201000b00233abab6d7emr13258560oab.1.1713813022998; Mon, 22
 Apr 2024 12:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com> <20240418135412.14730-9-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240418135412.14730-9-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 21:10:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jmbxc=WMtx+d_sdwUtS+KUgabqgW-q_Au19fzDV-yrQQ@mail.gmail.com>
Message-ID: <CAJZ5v0jmbxc=WMtx+d_sdwUtS+KUgabqgW-q_Au19fzDV-yrQQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/16] ACPI: Add post_eject to struct acpi_scan_handler
 for cpu hotplug
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

On Thu, Apr 18, 2024 at 3:58=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> struct acpi_scan_handler has a detach callback that is used to remove
> a driver when a bus is changed. When interacting with an eject-request,
> the detach callback is called before _EJ0.
>
> This means the ACPI processor driver can't use _STA to determine if a
> CPU has been made not-present, or some of the other _STA bits have been
> changed. acpi_processor_remove() needs to know the value of _STA after
> _EJ0 has been called.
>
> Add a post_eject callback to struct acpi_scan_handler. This is called
> after acpi_scan_hot_remove() has successfully called _EJ0. Because
> acpi_scan_check_and_detach() also clears the handler pointer,
> it needs to be told if the caller will go on to call
> acpi_bus_post_eject(), so that acpi_device_clear_enumerated()
> and clearing the handler pointer can be deferred.
> An extra flag is added to flags field introduced in the previous
> patch to achieve this.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

No objections:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ----
> v7:
>  - No change.
> v6:
>  - Switch to flags.
> Russell, you hadn't signed off on this when posting last time.
> Do you want to insert a suitable tag now?
> v5:
>  - Rebase to take into account the changes to scan handling in the
>    meantime.
> ---
>  drivers/acpi/acpi_processor.c |  4 ++--
>  drivers/acpi/scan.c           | 30 +++++++++++++++++++++++++++---
>  include/acpi/acpi_bus.h       |  1 +
>  3 files changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 4e65011e706c..beb1761db579 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -471,7 +471,7 @@ static int acpi_processor_add(struct acpi_device *dev=
ice,
>
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
>  /* Removal */
> -static void acpi_processor_remove(struct acpi_device *device)
> +static void acpi_processor_post_eject(struct acpi_device *device)
>  {
>         struct acpi_processor *pr;
>
> @@ -639,7 +639,7 @@ static struct acpi_scan_handler processor_handler =3D=
 {
>         .ids =3D processor_device_ids,
>         .attach =3D acpi_processor_add,
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
> -       .detach =3D acpi_processor_remove,
> +       .post_eject =3D acpi_processor_post_eject,
>  #endif
>         .hotplug =3D {
>                 .enabled =3D true,
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 1ec9677e6c2d..3ec54624664a 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -245,6 +245,7 @@ static int acpi_scan_try_to_offline(struct acpi_devic=
e *device)
>  }
>
>  #define ACPI_SCAN_CHECK_FLAG_STATUS    BIT(0)
> +#define ACPI_SCAN_CHECK_FLAG_EJECT     BIT(1)
>
>  static int acpi_scan_check_and_detach(struct acpi_device *adev, void *p)
>  {
> @@ -273,8 +274,6 @@ static int acpi_scan_check_and_detach(struct acpi_dev=
ice *adev, void *p)
>         if (handler) {
>                 if (handler->detach)
>                         handler->detach(adev);
> -
> -               adev->handler =3D NULL;
>         } else {
>                 device_release_driver(&adev->dev);
>         }
> @@ -284,6 +283,28 @@ static int acpi_scan_check_and_detach(struct acpi_de=
vice *adev, void *p)
>          */
>         acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
>         adev->flags.initialized =3D false;
> +
> +       /* For eject this is deferred to acpi_bus_post_eject() */
> +       if (!(flags & ACPI_SCAN_CHECK_FLAG_EJECT)) {
> +               adev->handler =3D NULL;
> +               acpi_device_clear_enumerated(adev);
> +       }
> +       return 0;
> +}
> +
> +static int acpi_bus_post_eject(struct acpi_device *adev, void *not_used)
> +{
> +       struct acpi_scan_handler *handler =3D adev->handler;
> +
> +       acpi_dev_for_each_child_reverse(adev, acpi_bus_post_eject, NULL);
> +
> +       if (handler) {
> +               if (handler->post_eject)
> +                       handler->post_eject(adev);
> +
> +               adev->handler =3D NULL;
> +       }
> +
>         acpi_device_clear_enumerated(adev);
>
>         return 0;
> @@ -301,6 +322,7 @@ static int acpi_scan_hot_remove(struct acpi_device *d=
evice)
>         acpi_handle handle =3D device->handle;
>         unsigned long long sta;
>         acpi_status status;
> +       uintptr_t flags =3D ACPI_SCAN_CHECK_FLAG_EJECT;
>
>         if (device->handler && device->handler->hotplug.demand_offline) {
>                 if (!acpi_scan_is_offline(device, true))
> @@ -313,7 +335,7 @@ static int acpi_scan_hot_remove(struct acpi_device *d=
evice)
>
>         acpi_handle_debug(handle, "Ejecting\n");
>
> -       acpi_bus_trim(device);
> +       acpi_scan_check_and_detach(device, (void *)flags);
>
>         acpi_evaluate_lck(handle, 0);
>         /*
> @@ -336,6 +358,8 @@ static int acpi_scan_hot_remove(struct acpi_device *d=
evice)
>         } else if (sta & ACPI_STA_DEVICE_ENABLED) {
>                 acpi_handle_warn(handle,
>                         "Eject incomplete - status 0x%llx\n", sta);
> +       } else {
> +               acpi_bus_post_eject(device, NULL);
>         }
>
>         return 0;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index e7796f373d0d..51a4b936f19e 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -129,6 +129,7 @@ struct acpi_scan_handler {
>         bool (*match)(const char *idstr, const struct acpi_device_id **ma=
tchid);
>         int (*attach)(struct acpi_device *dev, const struct acpi_device_i=
d *id);
>         void (*detach)(struct acpi_device *dev);
> +       void (*post_eject)(struct acpi_device *dev);
>         void (*bind)(struct device *phys_dev);
>         void (*unbind)(struct device *phys_dev);
>         struct acpi_hotplug_profile hotplug;
> --
> 2.39.2
>

