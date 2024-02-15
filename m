Return-Path: <linux-arch+bounces-2409-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF49856D94
	for <lists+linux-arch@lfdr.de>; Thu, 15 Feb 2024 20:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657322850A9
	for <lists+linux-arch@lfdr.de>; Thu, 15 Feb 2024 19:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63123139598;
	Thu, 15 Feb 2024 19:22:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9113699A;
	Thu, 15 Feb 2024 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024963; cv=none; b=X28GDQojdEgXZ6/Uy+yFWD1QO9QmT3EtTAOUdmNhh1diIwMwloFkl8pd5h6FiE4JCd94VqEaTHqtMlL0i0vZWpBhHsiHOVZHeCYOIuUslTiY/RnwLwdQbEmXecPOHDGNllVtB0vIn+3n0KnYookX2BD/lUDmyltVGBVZ3zbKZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024963; c=relaxed/simple;
	bh=gCJhOtMnRU8UWRkUPUSVOlRb9/TApbJfHXnwR2CW2HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmGPgXXC4zRaPFVcF0GYC39c6mcnrKAExCMOxLeCU0Ep87Z0fWuwPuT7q2Z5Ygh9m7BTDUP5Gf8Z1yCUb5O4WxIR1c/zPJT53Q7OtuhIiBfffGl3FpuqW4raU3jeT8PlodfSJ1bS+loNQ/4LvSNX24kAmosOqUhnmfEEsRTYdfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e2f6c7e623so142059a34.1;
        Thu, 15 Feb 2024 11:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708024960; x=1708629760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atg7WI78HsTq5644XbnZluXts4d5OR/FFe0QfcIw1Ag=;
        b=LD5KmZ/ub5r7pzqKRFVE0hPX3wJ4C13NOakKTw+4RR6ZrGdFx3Uk8QArcDbQZPPhGK
         znxYzjj/NhLT/xisBkREF87qLw37ckwWLQPkm7hX2x4egNm3zYI1Z8n/q70AsEvUV1pf
         SNn1eCKPCcsRsRhJlFyhS96ikm65rBNerz5UUCv1b+XEZQMl8loRUnFeHeQNW5J9lIv9
         IGHGE/eg5lehrfoTP8DDKtuTLpqLVqzP/dPcZpPEsvFF3iPe9v7szUhMdu4tJODpwGOt
         smyBV/krU/wgrNgyeWesXAv6NHD0PDBSFeTtbKT5VenTmy0t02jAJJF1qQvO+QiFp+Zo
         hicA==
X-Forwarded-Encrypted: i=1; AJvYcCX95oqFx5SPRBC1R71HfnWTOuHkTmkoAtNyXc6waEK6Gd6BhWP1mZ6P2wAbtHNqseNLytMA4Ddm8zmkFur+mq3oJGC3e0tj8lsHHuN+3JMdFsfKOt+mG2v+W6iElZlNsBXqDOPJWCAe1ApVVIToS1Q/8oebxQD+AdlGcIey9jFiUBML9apv//T0lb3IvDCwXfxWcWGi9mz7ZGRcd6DpIUdbHMS6De1MnD1fcramzepqYCHEzC1uMCUuhWU7cw9BbL7FO0W7XYAb9QSsSwIR+G5heSMfW63k/MlQ7noJuz6xAYvIYCQOwRMbgFTTgy4BrGWPIV8gDw==
X-Gm-Message-State: AOJu0YwcPIrHfe5K3FnvwO4AYkBOryDotGVy5phuXX96dGxeiskM5B8r
	2iajjG8sbl/+DqvR9AZbwdDtVEsxFYHXRuyw38evylrdJfmIfW7jS5GUe68Z7fKPz0VczDq8cyT
	IZY5AwOfb6zyJSdCltfIudYnO/MYlcLbmxWI=
X-Google-Smtp-Source: AGHT+IGH9nzxfJPZ0b9LL7NeSQVmLFmBC+x3c+fnaZmT/Dcf6w2GoSt64Z11xwqZfq7drVdSJDbhPxjptv1uaDnhYPo=
X-Received: by 2002:a05:6820:1f8d:b0:59c:d8cd:ecee with SMTP id
 eq13-20020a0568201f8d00b0059cd8cdeceemr110694oob.1.1708024960621; Thu, 15 Feb
 2024 11:22:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk> <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Feb 2024 20:22:29 +0100
Message-ID: <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from acpi_processor_get_info()
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:50=E2=80=AFPM Russell King <rmk+kernel@armlinux.o=
rg.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> To allow ACPI to skip the call to arch_register_cpu() when the _STA
> value indicates the CPU can't be brought online right now, move the
> arch_register_cpu() call into acpi_processor_get_info().
>
> Systems can still be booted with 'acpi=3Doff', or not include an
> ACPI description at all. For these, the CPUs continue to be
> registered by cpu_dev_register_generic().
>
> This moves the CPU register logic back to a subsys_initcall(),
> while the memory nodes will have been registered earlier.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>  * Fixup comment in acpi_processor_get_info() (Gavin Shan)
>  * Add comment in cpu_dev_register_generic() (Gavin Shan)
> ---
>  drivers/acpi/acpi_processor.c | 12 ++++++++++++
>  drivers/base/cpu.c            |  6 +++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index cf7c1cca69dd..a68c475cdea5 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -314,6 +314,18 @@ static int acpi_processor_get_info(struct acpi_devic=
e *device)
>                         cpufreq_add_device("acpi-cpufreq");
>         }
>
> +       /*
> +        * Register CPUs that are present. get_cpu_device() is used to sk=
ip
> +        * duplicate CPU descriptions from firmware.
> +        */
> +       if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> +           !get_cpu_device(pr->id)) {
> +               int ret =3D arch_register_cpu(pr->id);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
>         /*
>          *  Extra Processor objects may be enumerated on MP systems with
>          *  less than the max # of CPUs. They should be ignored _iff

This is interesting, because right below there is the following code:

    if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
        int ret =3D acpi_processor_hotadd_init(pr);

        if (ret)
            return ret;
    }

and acpi_processor_hotadd_init() essentially calls arch_register_cpu()
with some extra things around it (more about that below).

I do realize that acpi_processor_hotadd_init() is defined under
CONFIG_ACPI_HOTPLUG_CPU, so for the sake of the argument let's
consider an architecture where CONFIG_ACPI_HOTPLUG_CPU is set.

So why are the two conditionals that almost contradict each other both
needed?  It looks like the new code could be combined with
acpi_processor_hotadd_init() to do the right thing in all cases.

Now, acpi_processor_hotadd_init() does some extra things that look
like they should be done by the new code too.

1. It checks invalid_phys_cpuid() which appears to be a good idea to me.

2. It uses locking around arch_register_cpu() which doesn't seem
unreasonable either.

3. It calls acpi_map_cpu() and I'm not sure why this is not done by
the new code.

The only thing that can be dropped from it is the _STA check AFAICS,
because acpi_processor_add() won't even be called if the CPU is not
present (and not enabled after the first patch).

So why does the code not do 1 - 3 above?

> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 47de0f140ba6..13d052bf13f4 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -553,7 +553,11 @@ static void __init cpu_dev_register_generic(void)
>  {
>         int i, ret;
>
> -       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> +       /*
> +        * When ACPI is enabled, CPUs are registered via
> +        * acpi_processor_get_info().
> +        */
> +       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disabled)
>                 return;

Honestly, this looks like a quick hack to me and it absolutely
requires an ACK from the x86 maintainers to go anywhere.

>
>         for_each_present_cpu(i) {
> --

