Return-Path: <linux-arch+bounces-4250-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9937D8BEC03
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 20:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2544DB203EE
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 18:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF7216D9A8;
	Tue,  7 May 2024 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYxYpuTJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE62C16D4E2;
	Tue,  7 May 2024 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108151; cv=none; b=KDAMGhJaHfKQ83d2lJyM+kijfTaZ4TgyPsVp0ixRi/tAOCk8d+K06O6sWWlunqSxA9aU4uVJ5dZZUILsQwz0is77JwT+HxXL5lN/8i1u4ZAH01tdAv0NyRzuqHBnOJXXyBouKye5udew7c54KcBRK5V/lqdaw5+tHKdVrtlJuOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108151; c=relaxed/simple;
	bh=s9TJ7BUa1nTYfV0K5h3xYN7O2jbjVFFreTldzhRORjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2PlQIMnZHtCfR3PdQItNPCeuNPTwaIRZuHLyXgqU0m8n1Ht8+ObYn3nvTvr1nBsXRWJZUjRjUmC1Z7DUfVaPah8h2dtBEwbKC7uMzzgDM4OOFdxHp1kCjvRt/hpjtoigtApGDx+LZjT0mRrdzZdRz3Wm5/xmYUuYlQFV62u6Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYxYpuTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF0FC4DDE3;
	Tue,  7 May 2024 18:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715108151;
	bh=s9TJ7BUa1nTYfV0K5h3xYN7O2jbjVFFreTldzhRORjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MYxYpuTJ6uS5ozOsUarhVXYgwV4QygLxiV1yGuFjhWlskfh1AY2MgxmNgLc2+qCPA
	 7oPm45NCbyVbL56RRE2CoL8xaSg4N0uf6NHmzHawqdBeOJbZHhGWYjUs06JNKqerXb
	 V4kBGr93FecfBYSiQpEyoDKueit4UuWMlPhqDq9Tz6JWnEiQb0J1Zaz70f7gA3DAuV
	 uO92Tl5SDo4maQTzrQnHEVupT5k7P9Hfu1cbWgrXtl15LG0yN4R1BkEjZ9hrgIx+qu
	 j/V65VHKYY4o/J7IhsVZcrEQdDG3c2Pc24u3qBd2tmLplh42qTXNU8VM6SWPGy2HL4
	 M+GASdaIt1nUQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ea0a6856d7so189634a34.1;
        Tue, 07 May 2024 11:55:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYUi+I2gGgTXQkzNCfhrb7l5gaJCjuFHzBSDkLZ1Lhno984o96cQye+n4S8gx0y6J/5072toVOIbug9+HwF8zW6UqzqdnvwaBzok6b2ncYEJ0VG1p0+gbqmQLuBvECfS1avUg7gRAB9l83B+0WmO0g7LURpBIRvpr8RC1CsBhFfCvEOPvQktffByXFj8jSJr2YMUyCnehPYhoLHnYjUg==
X-Gm-Message-State: AOJu0Yy5WB6DatbqfPMj/rlK6jXjyiZxG2tdK0SqS2eg5sgXc9lJ8o6y
	88GhxT3yNA1e7iW6gX8gi799xVCZ9SA4gviAFuqnICoslMOVz3C+ymF+fsgM64k6kFnb7iBycXq
	kTTmOSrHCA2CE2EZjY6+vIpzNi/Y=
X-Google-Smtp-Source: AGHT+IGm8eYgszhdxibFF67K/s34HQdmS1A/5rFstggkGk8aCZiZnDuIah8KM0kPCad7VKoxrlD1gBNnD/DaO88MGpo=
X-Received: by 2002:a4a:3158:0:b0:5b1:ff38:5ee0 with SMTP id
 006d021491bc7-5b24d470f6fmr320087eaf.1.1715108150335; Tue, 07 May 2024
 11:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com> <20240430142434.10471-5-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240430142434.10471-5-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 May 2024 20:55:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gCgWsbUDmhU2vPiz6dMwefdmRYthyxQoGiEhvPqwDpKw@mail.gmail.com>
Message-ID: <CAJZ5v0gCgWsbUDmhU2vPiz6dMwefdmRYthyxQoGiEhvPqwDpKw@mail.gmail.com>
Subject: Re: [PATCH v9 04/19] ACPI: processor: Return an error if
 acpi_processor_get_info() fails in processor_add()
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

On Tue, Apr 30, 2024 at 4:26=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Rafael observed [1] that returning 0 from processor_add() will result in
> acpi_default_enumeration() being called which will attempt to create a
> platform device, but that makes little sense when the processor is known
> to be not available.  So just return the error code from acpi_processor_g=
et_info()
> instead.
>
> Link: https://lore.kernel.org/all/CAJZ5v0iKU8ra9jR+EmgxbuNm=3DUwx2m1-8vn_=
RAZ+aCiUVLe3Pw@mail.gmail.com/ [1]
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you!

> ---
> v9: New patch following through from Gavin pointing out a memory leak lat=
er
>     in the series.
> ---
>  drivers/acpi/acpi_processor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 161c95c9d60a..5f062806ca40 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -393,7 +393,7 @@ static int acpi_processor_add(struct acpi_device *dev=
ice,
>
>         result =3D acpi_processor_get_info(device);
>         if (result) /* Processor is not physically present or unavailable=
 */
> -               return 0;
> +               return result;
>
>         BUG_ON(pr->id >=3D nr_cpu_ids);
>
> --
> 2.39.2
>

