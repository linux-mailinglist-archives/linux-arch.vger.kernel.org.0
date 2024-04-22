Return-Path: <linux-arch+bounces-3899-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332C08AD49B
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 21:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6A51F25396
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 19:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9178B1552FD;
	Mon, 22 Apr 2024 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDXCxd3s"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639071552F2;
	Mon, 22 Apr 2024 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812757; cv=none; b=gQfLiKHGyLThQkCLQqcyZX8rwdCgTP+NYlTNafLcejP+mjKxH2WqwZo3dmTuAQulUzqDdd/XJrnJx1HTMPi2qxl3j1cYraTWjVU6htvg5ByZATK0xgnPUvsgu39RApRlC94qVK0OW6p6YdSRhLEu1b2CwVMePqGtY51Hm8bf5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812757; c=relaxed/simple;
	bh=olqbjtMO2lYQFKdnW9FhBNUoQLhAMSlCx3EdoK7BvxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnPOPqmX1bBviROfsGh/Lrf9hNfkwooEZRorfMbOQ30E9qH5nhJkq8qTlVZILnPp9HWruHKwEcXphafGN9FKSdmy7de9cBqfj6P19Sxpd2K0bfMbn+R510e5oTnOuR1IJyZAgWYuMtw1ZW0JkxhKsXwIXrYpZ9jgY64swWJ/BfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDXCxd3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C49C4AF0C;
	Mon, 22 Apr 2024 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713812757;
	bh=olqbjtMO2lYQFKdnW9FhBNUoQLhAMSlCx3EdoK7BvxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uDXCxd3sZnTu0YXjlb27OMBo2Ww2PBVIwA+q8lUNvApEq/PWHI1QUkVnqx5Ydl+j3
	 1FjK1hRE44LaOBxQDRMXqtuoal3S/5FElxlVHf9ogy7p/ZycNb/RIsXvkUXdQwMsgH
	 bXarTEys6i+IEP2d/uWh3ep3Ka9wJjL3OT95V4VfT2+IHY2cGsvcMsAjiZ91945MkB
	 lZlu0/ba4iregoy927lvLlmniSLuG0+IYbHNX1JXlUwm7besyDoAHgOi1UI/tQo7iL
	 7p1RJcHEg/MuH0jb5LtTG964ydw10G2NUg1ov9MYBCCVDmuIJEgbNOkuCvwi4ymjQe
	 1Q0y51v50ZUaw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aca32d3f78so935099eaf.1;
        Mon, 22 Apr 2024 12:05:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsRhF5ErfgVVyaHznnvTO2DC9VuN0BiemfKZWysoVkGxfAlJays5ddFvWFNuKFNxDYLuyDhyfbekjcdx6ydgVboeCWHFCjjc9Qa2oVllkXDgKal1GI1TcNj5JLTSXOUid6ST2vSB6wFgGME8YFi3tfe/xqLi4qMNdxDK3VzvYv7Wnj467n04yx9WmjCT9GuTWIZne7CB0OLso+RTs0Qg==
X-Gm-Message-State: AOJu0Yx3H2P72KE05BNTXqLnHjdss0hthhYpCaMI7ugUFNfDq8DRyn0K
	WWAa0iMulpaZgLYxLtm9jrqLa79npQxNq30qEc/99z4t8sFMLp+jcwPQ337w/nrOL4VXa4Jl425
	HdbD7WSZEyT9675+YP3f5TvihxiM=
X-Google-Smtp-Source: AGHT+IFQupzOqLQf3rypOOXDX+7ylfjySYUjvK8/UL2sIHZWqWZ3BDV9Q5+/PQPXaF+OFzkdf7PFFmoR2i+wYA/uyXY=
X-Received: by 2002:a4a:5581:0:b0:5aa:3e4f:f01e with SMTP id
 e123-20020a4a5581000000b005aa3e4ff01emr12662466oob.1.1713812756200; Mon, 22
 Apr 2024 12:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com> <20240418135412.14730-8-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240418135412.14730-8-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 21:05:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jOoH7nP-5uaK9XVL_zf7Uh5SZnoupRyxK1qxwUdwq_dA@mail.gmail.com>
Message-ID: <CAJZ5v0jOoH7nP-5uaK9XVL_zf7Uh5SZnoupRyxK1qxwUdwq_dA@mail.gmail.com>
Subject: Re: [PATCH v7 07/16] ACPI: scan: switch to flags for acpi_scan_check_and_detach()
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

On Thu, Apr 18, 2024 at 3:57=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Precursor patch adds the ability to pass a uintptr_t of flags into
> acpi_scan_check_and detach() so that additional flags can be
> added to indicate whether to defer portions of the eject flow.
> The new flag follows in the next patch.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I have no specific heartburn related to this, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v7: No change
> v6: Based on internal feedback switch to less invasive change
>     to using flags rather than a struct.
> ---
>  drivers/acpi/scan.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index d1464324de95..1ec9677e6c2d 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -244,13 +244,16 @@ static int acpi_scan_try_to_offline(struct acpi_dev=
ice *device)
>         return 0;
>  }
>
> -static int acpi_scan_check_and_detach(struct acpi_device *adev, void *ch=
eck)
> +#define ACPI_SCAN_CHECK_FLAG_STATUS    BIT(0)
> +
> +static int acpi_scan_check_and_detach(struct acpi_device *adev, void *p)
>  {
>         struct acpi_scan_handler *handler =3D adev->handler;
> +       uintptr_t flags =3D (uintptr_t)p;
>
> -       acpi_dev_for_each_child_reverse(adev, acpi_scan_check_and_detach,=
 check);
> +       acpi_dev_for_each_child_reverse(adev, acpi_scan_check_and_detach,=
 p);
>
> -       if (check) {
> +       if (flags & ACPI_SCAN_CHECK_FLAG_STATUS) {
>                 acpi_bus_get_status(adev);
>                 /*
>                  * Skip devices that are still there and take the enabled
> @@ -288,7 +291,9 @@ static int acpi_scan_check_and_detach(struct acpi_dev=
ice *adev, void *check)
>
>  static void acpi_scan_check_subtree(struct acpi_device *adev)
>  {
> -       acpi_scan_check_and_detach(adev, (void *)true);
> +       uintptr_t flags =3D ACPI_SCAN_CHECK_FLAG_STATUS;
> +
> +       acpi_scan_check_and_detach(adev, (void *)flags);
>  }
>
>  static int acpi_scan_hot_remove(struct acpi_device *device)
> @@ -2601,7 +2606,9 @@ EXPORT_SYMBOL(acpi_bus_scan);
>   */
>  void acpi_bus_trim(struct acpi_device *adev)
>  {
> -       acpi_scan_check_and_detach(adev, NULL);
> +       uintptr_t flags =3D 0;
> +
> +       acpi_scan_check_and_detach(adev, (void *)flags);
>  }
>  EXPORT_SYMBOL_GPL(acpi_bus_trim);
>
> --

