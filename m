Return-Path: <linux-arch+bounces-3894-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C45A8AD45D
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 20:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA86B22C45
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AAC155336;
	Mon, 22 Apr 2024 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzVBCQSx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9579154C16;
	Mon, 22 Apr 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811693; cv=none; b=PPBZWWz4lIhPyAuWb4oVI/ysOZx9zcCBafCB9t2aSXwYddFVUQUNWWhVuhMRb+ob9IyF1CLuryZ4xfB1BKQ7k5lWaXV8LhVf/2RYKZN3EVEO+Ik7x3CnmC+7WZvMgsJQBCM36yoEnInBVf/Ylz3E5q/N/w01jWYRPSm6gCxsBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811693; c=relaxed/simple;
	bh=rpA6N07dzG+TJH3XYFQyU87OVzoWXjM0LCk9vtM3N3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6UsD61ggpjKgC0P6pKW9NGoWZc5LB18zyCxAZZHD+Add1Q2YOFCiQOAh5YdZ+66NxrZ+YrGzxjLlNT+/dmeoWHHsfFgn3b/H4HvnM0XpBi7M/P5ItxBWJmB8ngMAlMYdDjdskWVrA9w1onQ1ioPASns1NC9Zlg8DKzJ9FhSA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzVBCQSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8024C4AF0F;
	Mon, 22 Apr 2024 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713811692;
	bh=rpA6N07dzG+TJH3XYFQyU87OVzoWXjM0LCk9vtM3N3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pzVBCQSxqnWh4x3MbkKicc4qA/nAbOE4JvvaoaeC+gJbzKr+ktYIyDQ3uXHJWvEr6
	 pWdbfWZDMnNIlq+UmU4CyvxIml1OXPHnHfKca0OKLH8APjPJUWQBvPYts84peEjUWK
	 qSUq+eRgJNMTFL3X7cF+ewXLP7ozXO2VNYVBPjVUHrLJpNOCvG3rDTwcNtmAtPCI7B
	 roCCL51+T9+fAp/A4jkX8IlqYFr7uF34oE2O/EatP32GpuOF5yT1f6HbMSBJpb/LSH
	 eJ5L0t3HaLJ7/Ik5iCLUxKMnFVkOvlSioYxvOHTkfdOAaY0iyvXv9n4RVNZYabHFCN
	 rmHxZ9SI8GusQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5acdbfa7a45so1536090eaf.2;
        Mon, 22 Apr 2024 11:48:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOY4qZ+EySN7WC/vyNeHGHJOiRCea/oy1t/SAmrd5d+VIOoD03cQTI8TF3QMgV6LfMwDGMRb6rbbd72XQpkcAQffQTG9eVb+TLWAmz2sYU6H++pbuV5a2wlmTK6Eblc6KEQ2HkbcB8l9G9vUHIAYYEM0jkDKlAx8joapTlxHk8XGv2z/DAe2SrtHi/cfixCeTxxK1q4UfoeJvfQaKu4g==
X-Gm-Message-State: AOJu0YzksLusupozqrOO9H/CrOj3QyLwvpwt1OqnIAbWptNLZoqjJ1Dl
	9DqZ34if4xEq8jn4sl2+BHKMVe4f1VM5eJJHJxKCPjtJpkgRiCJbjMLB682YQANsMlraegr+TfE
	BTHP7co+Cv8YJl7a/UFnZ6CPQ61w=
X-Google-Smtp-Source: AGHT+IHflqOEbu6JjhL9GA+4qsoaorYsVOPeB39pe/rPdTVl/TbW3rxr3EWdsbghxWdA3n1aLCbh5F2f8GOdraC2c/I=
X-Received: by 2002:a05:6820:2c83:b0:5aa:6b2e:36f0 with SMTP id
 dx3-20020a0568202c8300b005aa6b2e36f0mr10951143oob.0.1713811692094; Mon, 22
 Apr 2024 11:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com> <20240418135412.14730-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240418135412.14730-4-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 20:48:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g9g=W9o8=BNDP+3TEUEN4ByjQU9SJPJepE6eFrcRv2+A@mail.gmail.com>
Message-ID: <CAJZ5v0g9g=W9o8=BNDP+3TEUEN4ByjQU9SJPJepE6eFrcRv2+A@mail.gmail.com>
Subject: Re: [PATCH v7 03/16] ACPI: processor: Drop duplicated check on _STA
 (enabled + present)
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

On Thu, Apr 18, 2024 at 3:55=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> The ACPI bus scan will only result in acpi_processor_add() being called
> if _STA has already been checked and the result is that the
> processor is enabled and present.  Hence drop this additional check.
>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

LGTM, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v7: No change
> v6: New patch to drop this unnecessary code. Now I think we only
>     need to explicitly read STA to print a warning in the ARM64
>     arch_unregister_cpu() path where we want to know if the
>     present bit has been unset as well.
> ---
>  drivers/acpi/acpi_processor.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 7fc924aeeed0..ba0a6f0ac841 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -186,17 +186,11 @@ static void __init acpi_pcc_cpufreq_init(void) {}
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
>  static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  {
> -       unsigned long long sta;
> -       acpi_status status;
>         int ret;
>
>         if (invalid_phys_cpuid(pr->phys_id))
>                 return -ENODEV;
>
> -       status =3D acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
> -       if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT))
> -               return -ENODEV;
> -
>         cpu_maps_update_begin();
>         cpus_write_lock();
>
> --

