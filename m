Return-Path: <linux-arch+bounces-3642-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B04D8A3567
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 20:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 299C5B2271F
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447214E2FE;
	Fri, 12 Apr 2024 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDoa0lyh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9431014E2F5;
	Fri, 12 Apr 2024 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945467; cv=none; b=YnpE69NsX9r8nEjUKhK2Rmh6Wmtl/zegruSKEw4GgH19yEoU+mQnX2TZPuT/80L4kEcaJgHA6G8y7PDJVAFDagYv3QDMlOozMqVK6yE8I52yYAh11POeqQob9gt6PbfSfMkgn2B6ovLaQFpzLR6ZBPRq7l6p5piEnL3POhsCbWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945467; c=relaxed/simple;
	bh=w0Rj2BE2ik1TfBrDf8LZJAbgRfaaZayTzrNsUAR3K2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2+0aM1WOg8qSEgCt+S1ol1dY1/smwWMpQx84KUUPXoX69mLjS0c7oBr2HKtV8FuEr2TjAtQvR9KsPADQb0a3IbspfkkQsPcVgBsBhRActwNqkb7n8N6JhVz8i/5UD1zlot0dNJ7+exkX4bOEV9xH35Qugrq1F5ULaiW5WL1u1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDoa0lyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39808C32781;
	Fri, 12 Apr 2024 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712945467;
	bh=w0Rj2BE2ik1TfBrDf8LZJAbgRfaaZayTzrNsUAR3K2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KDoa0lyhtKdtCX/st2OM4yzUUFYH/wZdlPwfOk+/h8yG51SmuMko1dILZUaYH2o1m
	 zQI3FRfCn/Hn+EN8T9pDEMxHFseYAmF9CSISfO9ZwiJPDeXtTPKj+rDaNAyokflBfS
	 GTG4Dx+gn0cE091MRS9iZmeAxI2qMgvpwdGeEeY42wYLjOTm9feo+Mz2e9S5ZyQb5b
	 ABCjuloula+NpOC95mrh3iqQfkSHIVDusunVEqmZXpMlqjaFIBvcMQ27MtXFcDHNrK
	 +ik/LaCgimMKWnS1KZWhL+Rjs0uyr+OKK5KwxK9aOia+mvN/lXBmGyhG+Ieuo/kg0F
	 rjoNjC118QESA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22f211d761bso40762fac.0;
        Fri, 12 Apr 2024 11:11:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUa5gwbFpCROVoXBIOhp7dDWVTuEmSRd30XnVa3QIqDSso9wuOx0NimMocTricRCBb+vsKq+1LKmZKXoZz5w0KyDjn1O61avkdJcv/QyVaxcvUNmH2VJ1MPpo3KixI07liz3D8o+d6Uts/NzQJEB2kKLOjZu0fdh3q6ocpjRRSUo6HXlYE=
X-Gm-Message-State: AOJu0YxH6jNr7KHK4CaSEDVuvj4JLWU6ag4HGZHbLiSvvCfVsql6OAU0
	uF91aWe74GGaWcEg5eeGXFy4qnCzWguTtn/NjdxXjB+WqWhIYIKHBuxpM+OZLm2Bq7a1dasrnOL
	baHMjPsveyo9VSDt/Xl4zw6oDKZc=
X-Google-Smtp-Source: AGHT+IGKtcKlSO2lFAIq6OKvn2JNPJn0Ga+grmKCMWsQcAXz9raUofNuscAxbTpGInOFPwn5aIKNB4YKf2Ez0fmcZl8=
X-Received: by 2002:a05:6870:9a97:b0:22e:6e96:ed41 with SMTP id
 hp23-20020a0568709a9700b0022e6e96ed41mr3822217oab.2.1712945466524; Fri, 12
 Apr 2024 11:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com> <20240412143719.11398-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240412143719.11398-3-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Apr 2024 20:10:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0izN5naWY7sTi16whds9ubXkLpgqV2gePQs869BoJTCDA@mail.gmail.com>
Message-ID: <CAJZ5v0izN5naWY7sTi16whds9ubXkLpgqV2gePQs869BoJTCDA@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] ACPI: processor: Set the ACPI_COMPANION for the
 struct cpu instance
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, Russell King <linux@armlinux.org.uk>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, 
	James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linuxarm@huawei.com, justin.he@arm.com, 
	jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 4:38=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> The arm64 specific arch_register_cpu() needs to access the _STA
> method of the DSDT object so make it available by assigning the
> appropriate handle to the struct cpu instance.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/acpi_processor.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 7a0dd35d62c9..93e029403d05 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -235,6 +235,7 @@ static int acpi_processor_get_info(struct acpi_device=
 *device)
>         union acpi_object object =3D { 0 };
>         struct acpi_buffer buffer =3D { sizeof(union acpi_object), &objec=
t };
>         struct acpi_processor *pr =3D acpi_driver_data(device);
> +       struct cpu *c;
>         int device_declaration =3D 0;
>         acpi_status status =3D AE_OK;
>         static int cpu0_initialized;
> @@ -314,6 +315,8 @@ static int acpi_processor_get_info(struct acpi_device=
 *device)
>                         cpufreq_add_device("acpi-cpufreq");
>         }
>
> +       c =3D &per_cpu(cpu_devices, pr->id);
> +       ACPI_COMPANION_SET(&c->dev, device);

This is also set for per_cpu(cpu_sys_devices, pr->id) in
acpi_processor_add(), via acpi_bind_one().

Moreover, there is some pr->id validation in acpi_processor_add(), so
it seems premature to use it here this way.

I think that ACPI_COMPANION_SET() should be called from here on
per_cpu(cpu_sys_devices, pr->id) after validating pr->id (so the
pr->id validation should all be done here) and then NULL can be passed
as acpi_dev to acpi_bind_one() in acpi_processor_add().  Then, there
will be one physical device corresponding to the processor ACPI device
and no confusion.

>         /*
>          *  Extra Processor objects may be enumerated on MP systems with
>          *  less than the max # of CPUs. They should be ignored _iff
> --
> 2.39.2
>

