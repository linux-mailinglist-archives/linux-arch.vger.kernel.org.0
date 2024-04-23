Return-Path: <linux-arch+bounces-3908-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7F38AE106
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 11:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269CD28274C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5F258AA1;
	Tue, 23 Apr 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBqEG+4V"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB151016;
	Tue, 23 Apr 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864687; cv=none; b=uELwyPpvpQ+Z+nmgosR5Y2rdyG7z4LjnIvq7E2InAbh8FPeIjKCu8PqJIhOeK2voCrGChX86MOqk7T+Wsb1bKGVeFxKDgg8Uw73aZZ295ockl9KCL5eANMNjo/ukhUsrbi4BHu9mV/2HSSpqYtJ8jyt/tYggQBxlNvKrgGKZMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864687; c=relaxed/simple;
	bh=mCfFITSMnCflHebZWGZOERjPx9rq/bpE5SXgFwiJHz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNjfUV7Rb26yDi6gQDmnhc1lsxs0giivxl6sKYxuMngzHKfNkpNwiZ1+a8Iep7NJ/Go04mqKrexhSCe6PlHokaAnMcOsZ260DSeWk0Fu9pgjXHcJuo9dkRqc2KrtNYje0KTcrkoiZAxDhsbvgf3ou60sZ7Z0Biouoy4hteF4lPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBqEG+4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE49C4AF0B;
	Tue, 23 Apr 2024 09:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713864687;
	bh=mCfFITSMnCflHebZWGZOERjPx9rq/bpE5SXgFwiJHz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LBqEG+4VDH76Wzj3j/0ieKNlwWtnLoLwDo9wtFs4I19rtyemYkNNiQy4RqnBHyChx
	 RR0fJjUL7C/bNvPLRLhBJKhs5MbowPS72vAoU1iHj6M2rYygNsh1nPK4Llt+Flsq4g
	 RvgARe4pRKfaSCsmwB0nWtIv9W4+Uakle2S7TLmoo9DIzqy0QpOU7I3ha2wXygqe8q
	 ssPoPWXf6+XL3YV7hnVlgVeLLJUpaUdBx2k8wDtuu+XHyBX9T69k+tEbG+Ct/q64FA
	 +YWnSfjz7+6hYZ9bZfKMsIEYwXg2o15zuxJw9bnMXgcMTtPx5Niozg1vCNJmJj60B1
	 fQV5eu3Hr/sew==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5af12f48b72so213066eaf.3;
        Tue, 23 Apr 2024 02:31:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVBxHV2PYsi+wvnh6oua8yZR6JmcJjisXi51Ng5fLYKTsoFBITm8yzOsBxAzD7k0ATjl1aIPIO6S8zasGGr3rvAcAMX1OW9rpgc287tGjNAoymSkqX759rJPJr5CgH1JkJjYyg05Wdi2LQQejJB50X41sWlgF9YnqiHIOai+iRflTg2TGISt7Y6gGduX6cxzavmEhCLoWdbLU2gwrLJw==
X-Gm-Message-State: AOJu0YwYdNgyxmrqvC9Shvd6kzB/N1GkrmjIgtkMG0zrGlQBpY2koHTU
	i9yrg28qlg4PAhOlN1B6dNz/XSt0PsCTgVMD11CiI3AjTcvvEPp7jC68x/0NmzsnoBwqXAlcvXN
	0SfwXbkqNUtaXbWtdE4v/Ht1g/fo=
X-Google-Smtp-Source: AGHT+IHjVLpX2cYW6/cy3xUrXl+khsjki6+LuDCfZn16luHLntfkxzCHaR4p6xIi9+3OexMVeuKhREaD/0OB+bvFSRo=
X-Received: by 2002:a05:6870:d68c:b0:22e:77b6:4f9d with SMTP id
 z12-20020a056870d68c00b0022e77b64f9dmr15761595oap.3.1713864686690; Tue, 23
 Apr 2024 02:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-4-Jonathan.Cameron@huawei.com> <c13f7424-3a7f-4c3e-3e8d-81e9fcf0caf7@huawei.com>
In-Reply-To: <c13f7424-3a7f-4c3e-3e8d-81e9fcf0caf7@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Apr 2024 11:31:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gDJzCTkUP3i8H3pivrCHdU4-qVf3SVCvTF9hQyKJHtBQ@mail.gmail.com>
Message-ID: <CAJZ5v0gDJzCTkUP3i8H3pivrCHdU4-qVf3SVCvTF9hQyKJHtBQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/16] ACPI: processor: Drop duplicated check on _STA
 (enabled + present)
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, Russell King <linux@armlinux.org.uk>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, 
	James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com, justin.he@arm.com, 
	jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 8:49=E2=80=AFAM Hanjun Guo <guohanjun@huawei.com> w=
rote:
>
> On 2024/4/18 21:53, Jonathan Cameron wrote:
> > The ACPI bus scan will only result in acpi_processor_add() being called
> > if _STA has already been checked and the result is that the
> > processor is enabled and present.  Hence drop this additional check.
> >
> > Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > ---
> > v7: No change
> > v6: New patch to drop this unnecessary code. Now I think we only
> >      need to explicitly read STA to print a warning in the ARM64
> >      arch_unregister_cpu() path where we want to know if the
> >      present bit has been unset as well.
> > ---
> >   drivers/acpi/acpi_processor.c | 6 ------
> >   1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processo=
r.c
> > index 7fc924aeeed0..ba0a6f0ac841 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -186,17 +186,11 @@ static void __init acpi_pcc_cpufreq_init(void) {}
> >   #ifdef CONFIG_ACPI_HOTPLUG_CPU
> >   static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> >   {
> > -     unsigned long long sta;
> > -     acpi_status status;
> >       int ret;
> >
> >       if (invalid_phys_cpuid(pr->phys_id))
> >               return -ENODEV;
> >
> > -     status =3D acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
> > -     if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT))
> > -             return -ENODEV;
> > -
> >       cpu_maps_update_begin();
> >       cpus_write_lock();
>
> Since the status bits were checked before acpi_processor_add() being
> called, do we need to remove the if (!acpi_device_is_enabled(device))
> check in acpi_processor_add() as well?

No, because its caller only checks the present bit.  The function
itself checks the enabled bit.

