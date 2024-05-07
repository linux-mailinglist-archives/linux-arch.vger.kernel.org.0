Return-Path: <linux-arch+bounces-4251-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDB58BEC09
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 20:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57C71F22EF7
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA2B16D9AC;
	Tue,  7 May 2024 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1PjAJAT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4042C14EC5F;
	Tue,  7 May 2024 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108235; cv=none; b=Ysy/dQuC9K5niB01pPvNZf0N1dT6hlWkTPEwPAOoH8kNq8EhB5UGo2KxSgDyOHbSDtW76+ueW0K2Fb528PV+uMRj1VI9wQJqF593GhF+HuhqERllUcbqmZW0vdBy3slZddpnMV1fTe3lDHca1NBn7lB66vrkjJ7h4kfMR8q3VX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108235; c=relaxed/simple;
	bh=7MldFMh0WRj0UvMnQBIzOVOdcBxV2CBitHg5VApEhc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrCPIbTxBPDMkC2MWp14jLmaWVdlvTHisWO3d85D3l/zHhtNyE8NoDERyqgDTs+lcGePVxHJ3QhVFfMCBYmdWKBHbPaE/ojrypePKMMiyk7bl9NRuvlQBFeglZchL4FQa0+2H/7VeuD8pFLod8qhsEiy2elVkzdpE7R0Tlv901I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1PjAJAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE65DC4DDE2;
	Tue,  7 May 2024 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715108234;
	bh=7MldFMh0WRj0UvMnQBIzOVOdcBxV2CBitHg5VApEhc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E1PjAJATWxldderSnURjfd5HR/y8+qH1w0WIr+8S2MGugZWT4/EHbg5T+2yCdlhPJ
	 1YZvCtvIRMdL6LDwFx0bHiaF7Vy80YYgIue5irmvWPzuhz9ZbWwRlTuHkuMWHeo7H6
	 cq0oxGRSif7PjbmWyqU1CAE8zASFCak0QK1lSoZypeJHvgMprLl6/euUz/elG+LWWN
	 dIgPK0l/fjyywfbs9ErgMueVxpD1uGy0/smS851r1KvY3VLjEZ2GJjWJa8ElcI0ceb
	 m/ujPN0giZxnajz5d0LixljIgTEHKdTc/L9LQYWjexTXZmBtaVw23NTzjAfRwySQ4T
	 UhzImpdv2U3SA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a9ef9ba998so796483eaf.1;
        Tue, 07 May 2024 11:57:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyaxOA2JSXIiVfV+QECowVW6sJPBrqTuyng2mjSJm2jqvDkvt86g4/9kkZhw6nGOZe13P8qvj0boxP5wTDZsG4Qp9Zqj3IL9zYNj48AJUEfHk71DdYTxvUl4Sz3fbO4NGnUkdq55KsYzfouTceGrhb/0VC7BFWqQza4KLzvRG5RlD8zFBXNdfygUxndyaDzucBIypGtdpbX7w84Q5S3w==
X-Gm-Message-State: AOJu0YzcAW7TCOrKQJ77css2eLd4une7YVQVuE5CpBKyxK1eT3LwmjW2
	PznBWgUFMKebYc9xTnN3BMGInj70hxJgSDDeYCmUVdgjV0uCCcbTCH6A1UEgd9a0h7EK6ZlnBqq
	Ghq4fReCTe1uSPvNi0VR6vCbUo04=
X-Google-Smtp-Source: AGHT+IEFc40TEOusB0UJmLy29APzgs2yTSEpGQKKhB7KODeTniFYUYTrhBWiV95uhhheO//w8101/x52LKU2Lo07/PI=
X-Received: by 2002:a05:6820:1f92:b0:5ac:6fc1:c2cb with SMTP id
 006d021491bc7-5b24caad211mr401694eaf.0.1715108234007; Tue, 07 May 2024
 11:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com> <20240430142434.10471-6-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240430142434.10471-6-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 May 2024 20:57:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j3RV-6b8sTv2GoyuSNPX863x1xp4koF7imJDgbOdWXeg@mail.gmail.com>
Message-ID: <CAJZ5v0j3RV-6b8sTv2GoyuSNPX863x1xp4koF7imJDgbOdWXeg@mail.gmail.com>
Subject: Re: [PATCH v9 05/19] ACPI: processor: Fix memory leaks in error paths
 of processor_add()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Gavin Shan <gshan@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com, 
	justin.he@arm.com, jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:27=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> If acpi_processor_get_info() returned an error, pr and the associated
> pr->throttling.shared_cpu_map were leaked.
>
> The unwind code was in the wrong order wrt to setup, relying on
> some unwind actions having no affect (clearing variables that were
> never set etc).  That makes it harder to reason about so reorder
> and add appropriate labels to only undo what was actually set up
> in the first place.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you!

>
> ---
> v9: New patch in response to Gavin noticing a memory leak later in the
>     series.
> ---
>  drivers/acpi/acpi_processor.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 5f062806ca40..16e36e55a560 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -393,7 +393,7 @@ static int acpi_processor_add(struct acpi_device *dev=
ice,
>
>         result =3D acpi_processor_get_info(device);
>         if (result) /* Processor is not physically present or unavailable=
 */
> -               return result;
> +               goto err_clear_driver_data;
>
>         BUG_ON(pr->id >=3D nr_cpu_ids);
>
> @@ -408,7 +408,7 @@ static int acpi_processor_add(struct acpi_device *dev=
ice,
>                         "BIOS reported wrong ACPI id %d for the processor=
\n",
>                         pr->id);
>                 /* Give up, but do not abort the namespace scan. */
> -               goto err;
> +               goto err_clear_driver_data;
>         }
>         /*
>          * processor_device_array is not cleared on errors to allow buggy=
 BIOS
> @@ -420,12 +420,12 @@ static int acpi_processor_add(struct acpi_device *d=
evice,
>         dev =3D get_cpu_device(pr->id);
>         if (!dev) {
>                 result =3D -ENODEV;
> -               goto err;
> +               goto err_clear_per_cpu;
>         }
>
>         result =3D acpi_bind_one(dev, device);
>         if (result)
> -               goto err;
> +               goto err_clear_per_cpu;
>
>         pr->dev =3D dev;
>
> @@ -436,10 +436,11 @@ static int acpi_processor_add(struct acpi_device *d=
evice,
>         dev_err(dev, "Processor driver could not be attached\n");
>         acpi_unbind_one(dev);
>
> - err:
> -       free_cpumask_var(pr->throttling.shared_cpu_map);
> -       device->driver_data =3D NULL;
> + err_clear_per_cpu:
>         per_cpu(processors, pr->id) =3D NULL;
> + err_clear_driver_data:
> +       device->driver_data =3D NULL;
> +       free_cpumask_var(pr->throttling.shared_cpu_map);
>   err_free_pr:
>         kfree(pr);
>         return result;
> --
> 2.39.2
>

