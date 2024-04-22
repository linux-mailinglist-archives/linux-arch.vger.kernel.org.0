Return-Path: <linux-arch+bounces-3895-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213798AD46F
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 20:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C196F2814C4
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D33154C16;
	Mon, 22 Apr 2024 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA8qqOZ7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F424154BFF;
	Mon, 22 Apr 2024 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812227; cv=none; b=JpD6kCJ0CO2gwhyy/pMHZ1cEQeYUcR6tNgp2F/I8mByEpss2QMl4Z/qH1T4BnIlhtUfL8eK30OalbGN94wRUr9H1cAfK9v4G7pVdtR7D5XM8KcUDw2h3PkIa1DIxqrDj3t2Gdma45xl89llvLV+9dwB94n3A8vXuGfLhNqOsmt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812227; c=relaxed/simple;
	bh=vUwFolvpY3txp2GkdU+PBaQbFE6hq0Faqzym3NAaAao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpC+L+XE43QsXupVcPwlLEYRNJsvHMnq3EKHWM+NdhYOOpiNjv0MnLLbPgHMorXDoNat/imrdBTsKKDRYuWOFCH4uMslA/2oWYsbKkLDEv8IbGWyB7ms3WDs2QB5xffHGMzZ4ukau0cI5YLMMZ9GLYWXr7zFd/oGZWFB6mGleZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA8qqOZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255D6C113CC;
	Mon, 22 Apr 2024 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713812227;
	bh=vUwFolvpY3txp2GkdU+PBaQbFE6hq0Faqzym3NAaAao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MA8qqOZ74UviRkAJdioSgr48hye9xY6Bj4MF2wTrP34K/4KX719GV3qOMJw/OULIr
	 e68+T+c7rxKVttGfYwgxNo9pMVrRkiLt7w8Hzn9oLQRAzXGYNsWa/veejvUxSXSYrN
	 eSeONtLNO3MeUJWyID4rXzchILd32anjOPcj4m9KD0BpKDZ1cqV/badFtrvfJBBoPY
	 ZCqPl/1fsXmFuIDbFXKZipwydtGK4iyvTYE9LA/2j7K434ls0BvRUBBFcpsq+L7WTb
	 8F2uVFKVU3cOW9CwRfumqc802CzAiJAmVR9oBZUTbvoI5HcVL/2TB7wFb9Yj96mykE
	 ZN0jV1DjbLnZQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aa17bf8cf0so70185eaf.1;
        Mon, 22 Apr 2024 11:57:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuEfaHYvrFVCPIpAwH3gAKRuQQ+Yacn5SljF3GzVo7HNWTOzW8PGylgmCUjSJN2ZzV1og/zTp+j3HG/mBOBTxV2oQAKBNJmo7bmZDekwH39JIDBJbzuAVoUnpDiJxiraPqhX5+HIs1gAEePkAKoun3M9lU1x12CUFWsVTMNj4axWfHeGcVPZPmPTDIGyIBRnnRhnPx2wMFcc58ioBvbQ==
X-Gm-Message-State: AOJu0YxBC+2GddD3DeMsS9lhmQlBcf4u+wnfo5CTmlxnx2+uzax/oHs+
	6M8+uawaXZnTl9BIMLEsXnEN+sFNuhVFon7gcxmyRfCGQ0oBoV2QnYtDI1EVC8jzfOfu1pahkwa
	4BWhh9fN9nGavVOdkzGH+4P9aOBI=
X-Google-Smtp-Source: AGHT+IHdOuYnQY1CU66WbXlCKS17koH5x+YSdGsMQyGjmqhvjXEPNtgXBP9uB5fZms+F+MbZ3xDE7g2+MTu9xtvX/vE=
X-Received: by 2002:a05:6871:821:b0:22e:8800:b8bc with SMTP id
 q33-20020a056871082100b0022e8800b8bcmr13965106oap.5.1713812226509; Mon, 22
 Apr 2024 11:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com> <20240418135412.14730-5-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240418135412.14730-5-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 20:56:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0igyOYnqAWRVeC0JrsFSDaZAaia8SLnWi0LV2OS2z9-DQ@mail.gmail.com>
Message-ID: <CAJZ5v0igyOYnqAWRVeC0JrsFSDaZAaia8SLnWi0LV2OS2z9-DQ@mail.gmail.com>
Subject: Re: [PATCH v7 04/16] ACPI: processor: Move checks and availability of
 acpi_processor earlier
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

On Thu, Apr 18, 2024 at 3:56=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Make the per_cpu(processors, cpu) entries available earlier so that
> they are available in arch_register_cpu() as ARM64 will need access
> to the acpi_handle to distinguish between acpi_processor_add()
> and earlier registration attempts (which will fail as _STA cannot
> be checked).
>
> Reorder the remove flow to clear this per_cpu() after
> arch_unregister_cpu() has completed, allowing it to be used in
> there as well.
>
> Note that on x86 for the CPU hotplug case, the pr->id prior to
> acpi_map_cpu() may be invalid. Thus the per_cpu() structures
> must be initialized after that call or after checking the ID
> is valid (not hotplug path).
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v7: Swap order with acpi_unmap_cpu() in acpi_processor_remove()
>     to keep it in reverse order of the setup path. (thanks Salil)
>     Fix an issue with placement of CONFIG_ACPI_HOTPLUG_CPU guards.
> v6: As per discussion in v5 thread, don't use the cpu->dev and
>     make this data available earlier by moving the assignment checks
>     int acpi_processor_get_info().
> ---
>  drivers/acpi/acpi_processor.c | 78 +++++++++++++++++++++--------------
>  1 file changed, 46 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index ba0a6f0ac841..ac7ddb30f10e 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -183,8 +183,36 @@ static void __init acpi_pcc_cpufreq_init(void) {}
>  #endif /* CONFIG_X86 */
>
>  /* Initialization */
> +static DEFINE_PER_CPU(void *, processor_device_array);
> +
> +static void acpi_processor_set_per_cpu(struct acpi_processor *pr,
> +                                      struct acpi_device *device)
> +{
> +       BUG_ON(pr->id >=3D nr_cpu_ids);
> +       /*
> +        * Buggy BIOS check.
> +        * ACPI id of processors can be reported wrongly by the BIOS.
> +        * Don't trust it blindly
> +        */
> +       if (per_cpu(processor_device_array, pr->id) !=3D NULL &&
> +           per_cpu(processor_device_array, pr->id) !=3D device) {
> +               dev_warn(&device->dev,
> +                        "BIOS reported wrong ACPI id %d for the processo=
r\n",
> +                        pr->id);
> +               /* Give up, but do not abort the namespace scan. */
> +               return;

In this case the caller should make acpi_pricessor_add() return 0, I
think, because otherwise it will attempt to acpi_bind_one() "pr" to
"device" which will confuse things.

So I would make this return false to indicate that.

Or just fold it into the caller and do the error handling there.

