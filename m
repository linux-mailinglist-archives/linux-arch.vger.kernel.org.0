Return-Path: <linux-arch+bounces-3643-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2B98A35B7
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 20:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB76B1F24943
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ECF1E516;
	Fri, 12 Apr 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQQWusNG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47B11373;
	Fri, 12 Apr 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946653; cv=none; b=jCB88+WcXzXZzeBHVpHm10L/huksWSM83Cab7jGly6O34+6zTWX/q9YvDosBshEGOScXzRzPcozfx0up/DfOF/Pf6eQOsTCrf4Sd53FZJS5ESZ/1WprYa0AGRRbtmk7GpL0oRIYUttHnz7HSR4NNbQQYBEcwwTSH4L+RecDFxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946653; c=relaxed/simple;
	bh=PjJ0r1jv+Gy40inFGbGqF8OvINrRwJDv/80NI2l5XUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyiTICiL6xXiCMPv9mH7f3bocIF5FVjOCOTppTV/ZQjRg9YO0+qK/Itu1MkeRvzEg4/TAvRLpuMFir+dX392l1d2kgmQLLUxSuO/uFDf6MtKCs1AJDrdSzqw8W4mw4fOvCNAQAcEuMF/XlqfizqHZGujq0lSfVamFYWaY5bg6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQQWusNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A33C32781;
	Fri, 12 Apr 2024 18:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712946653;
	bh=PjJ0r1jv+Gy40inFGbGqF8OvINrRwJDv/80NI2l5XUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZQQWusNG6ExBvY436QlvONSgQH5kbBgDfbHpEXf21tXhje42q0jreHJC9+TdiOZTb
	 /AEVXF46pkLyBL0qmtps6lIkaCDRZE06wX4rAI9ukziCq86KHNjF+ssi2wG5/ccvIw
	 z19wt8wvGtJ8ZjwjOfLaLcex6/4MwD1lfR6DDBFkZ5fsnZiWIJN++FbgCcL7ko1EwI
	 9btL93ZH4JI9iDwfPNB9Y7u2Tc9fw5RxLDg/eqbtvcoFWufEQBMk1DExUfDwCFJtww
	 C7jYNeF52ysH7D2f2zo8BxxoyzRfqvk9xpAkNeCFmpKFwgtuNH//JHaOqaPCClC0fq
	 2nJ877KMWCiDg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22f0429c1ebso147229fac.0;
        Fri, 12 Apr 2024 11:30:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlaTHQ9Hjw/DzQxEBKg4UlrdgfFJhtYSva8DYtuPpDPiiDZ77SwX/xfSI98wQE+t2Z2fYzlrJRCLjPw+OfoD270KtF1c3BDSaf8IVQSw+8auXQGRTiMuow1mKGZz7aTkaGui6HEUHjTjS40Hppqyak4W2iCYoODAAbQfe66EzWeR8Taug=
X-Gm-Message-State: AOJu0YzgOscM/5SbHG2tms3LuyvdOtVzshCp23WenZl+rT1rjAMB6lW3
	DriTI14iNGOn9jM3/J1lRjtYsA9bQkKWzhOH2OMPiVufZ8z2e3XJoUdwhpGizBywtTkj2kO6ueX
	SVKt+cUilMtJtD/+Rv4Q/9A9OhUM=
X-Google-Smtp-Source: AGHT+IFDKbKacACQlXu+Vha1dYER/o7zLL0gXJIc6Jg1rU5tcmimRio9VrXjAKDGAGecTYjA8A0m0vMnHNM03elbI48=
X-Received: by 2002:a05:6871:612:b0:229:ee6d:77da with SMTP id
 w18-20020a056871061200b00229ee6d77damr3536849oan.2.1712946652664; Fri, 12 Apr
 2024 11:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com> <20240412143719.11398-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240412143719.11398-4-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Apr 2024 20:30:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
Message-ID: <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
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
> From: James Morse <james.morse@arm.com>
>
> The arm64 specific arch_register_cpu() call may defer CPU registration
> until the ACPI interpreter is available and the _STA method can
> be evaluated.
>
> If this occurs, then a second attempt is made in
> acpi_processor_get_info(). Note that the arm64 specific call has
> not yet been added so for now this will never be successfully
> called.
>
> Systems can still be booted with 'acpi=3Doff', or not include an
> ACPI description at all as in these cases arch_register_cpu()
> will not have deferred registration when first called.
>
> This moves the CPU register logic back to a subsys_initcall(),
> while the memory nodes will have been registered earlier.
> Note this is where the call was prior to the cleanup series so
> there should be no side effects of moving it back again for this
> specific case.
>
> [PATCH 00/21] Initial cleanups for vCPU HP.
> https://lore.kernel.org/all/ZVyz%2FVe5pPu8AWoA@shell.armlinux.org.uk/
>
> e.g. 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEVICES")
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v5: Update commit message to make it clear this is moving the
>     init back to where it was until very recently.
>
>     No longer change the condition in the earlier registration point
>     as that will be handled by the arm64 registration routine
>     deferring until called again here.
> ---
>  drivers/acpi/acpi_processor.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 93e029403d05..c78398cdd060 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -317,6 +317,18 @@ static int acpi_processor_get_info(struct acpi_devic=
e *device)
>
>         c =3D &per_cpu(cpu_devices, pr->id);
>         ACPI_COMPANION_SET(&c->dev, device);
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
> --

I am still unsure why there need to be two paths calling
arch_register_cpu() in acpi_processor_get_info().

Just below the comment partially pulled into the patch context above,
there is this code:

if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
         int ret =3D acpi_processor_hotadd_init(pr);

        if (ret)
                return ret;
}

For the sake of the argument, fold acpi_processor_hotadd_init() into
it and drop the redundant _STA check from it:

if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
        if (invalid_phys_cpuid(pr->phys_id))
                return -ENODEV;

        cpu_maps_update_begin();
        cpus_write_lock();

       ret =3D acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
       if (ret) {
                cpus_write_unlock();
                cpu_maps_update_done();
                return ret;
       }
       ret =3D arch_register_cpu(pr->id);
       if (ret) {
                acpi_unmap_cpu(pr->id);

                cpus_write_unlock();
                cpu_maps_update_done();
                return ret;
       }
      pr_info("CPU%d has been hot-added\n", pr->id);
      pr->flags.need_hotplug_init =3D 1;

      cpus_write_unlock();
      cpu_maps_update_done();
}

so I'm not sure why this cannot be combined with the new code.

Say acpi_map_cpu) / acpi_unmap_cpu() are turned into arch calls.
What's the difference then?  The locking, which should be fine if I'm
not mistaken and need_hotplug_init that needs to be set if this code
runs after the processor driver has loaded AFAICS.

