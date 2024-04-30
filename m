Return-Path: <linux-arch+bounces-4063-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A5A8B6F70
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 12:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3BFCB20628
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 10:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9D129E66;
	Tue, 30 Apr 2024 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOMDnN4z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5FB128828;
	Tue, 30 Apr 2024 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472272; cv=none; b=dYlgXjiiA0PonDuJr0QNdU8MU/VxFQX5xIhDnHbqZM2bNperrIS7Bq2tUCgdmZ15un6CgchdK0XRCUKPWMiRyOaQsgte2O0IlpRn4AMJY/LIwA+na4it7qG8e3OUEOCXCNpGiGJiYxT9upWVQfyYLjmwSV6+3n/G1Z4zrfQwdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472272; c=relaxed/simple;
	bh=gh1e1+58nQTAHuiHjenBUZr1umrL/earshHRi+u3ptQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hm5nN1Egy+DxZkg5cmGn+zR2+/ka7SuShWxlb0/5feok9YdEAJNGLUw7tAWY/vDkswIRqahJZUcPFPlPpVF6l2m9TtnAtnydCtvkDTpmNLdZBVM/juN8ZXYF0k6pxFJyxyjIR5v25GqcPVNlGiXyzK5zG48lkO/6BhkA4084Qlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOMDnN4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7080CC4AF19;
	Tue, 30 Apr 2024 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714472271;
	bh=gh1e1+58nQTAHuiHjenBUZr1umrL/earshHRi+u3ptQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uOMDnN4z5lMd6tjSaLzA/DFWBEvDW+SBX4PpUAzvzHJkcTmyc8M7ZBmkZpLQI2Zyn
	 BnKLXz97gHSXI+FFqxt9Q7MKB1t0bSZ5meSj4zn9x9aQbZpnTcOmwbm+FC5QBepynT
	 C01hW+5LH2TYdPZFs916JOsvt/kLLt0ZXRmNFBJyVBLhq1F5wKFYNEwEUPiS/M7iDb
	 SvWO3imquNMFqr9tcgL2T/t0b4mhuj5WBYR1Ln3ThRc6qVdqwl/UzBzDbm8vHLEauf
	 +WHWwOBIkFxtumcMcwlfY9A2uMGOZCyN1V0ZE8dIcwSDKH+19pi165NhRCjz9hRE63
	 vTPXCwUJ46PCw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5afbcf21abdso314320eaf.1;
        Tue, 30 Apr 2024 03:17:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgICQFTuGScR8mdFdlMsB8kU+2gCcxNLhvQTToZAwdmHbFL+HxVmDffqPr/tBCCSkmdJ4tyFMfSqEYGpsgIr2QbfFGnP5ZQfFg96WSYSLThpyVRWhZiqNxqctVV+pFTRvAln76AscUZIUoGE8JCPB9nSeL3hGeH607VCf8tC683nRKEtOPPCcBlS1sytzY2NwcjVECftiqDnP1b/TP/w==
X-Gm-Message-State: AOJu0YylsrJjxHFE5HEjsPb2CJBiOSYH4qTPwms0qtUR333EMTP3DxqN
	A58+Szfxx8Zj6NfDg+MmSjJwEwdTJ8vBroLL5cSSps3Szs2bMr6NODuprcUvMxRApKW8DyQvjfo
	wwr+gX7Nua2+NCBBwMxRU8xG7Mjg=
X-Google-Smtp-Source: AGHT+IFbUf4jSJ2cquloo0eC1JK3eLNbPJXNhvDmh9dDYgHoYqwLG9wYGAGPLglbvHkUXR8LZA+PzrHFJeSP3syddME=
X-Received: by 2002:a4a:d247:0:b0:5aa:6b2e:36f0 with SMTP id
 e7-20020a4ad247000000b005aa6b2e36f0mr14368609oos.0.1714472270695; Tue, 30 Apr
 2024 03:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
 <20240426135126.12802-5-Jonathan.Cameron@huawei.com> <80a2e07f-ecb2-48af-b2be-646f17e0e63e@redhat.com>
 <20240430102838.00006e04@Huawei.com> <20240430111341.00003dba@huawei.com>
In-Reply-To: <20240430111341.00003dba@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 12:17:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i5jpJswD7KV5RPm_HvzB+B=Rt3gY0s_Z3fn5wbJz0ebw@mail.gmail.com>
Message-ID: <CAJZ5v0i5jpJswD7KV5RPm_HvzB+B=Rt3gY0s_Z3fn5wbJz0ebw@mail.gmail.com>
Subject: Re: [PATCH v8 04/16] ACPI: processor: Move checks and availability of
 acpi_processor earlier
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gavin Shan <gshan@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, Russell King <linux@armlinux.org.uk>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, 
	James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com, justin.he@arm.com, 
	jianyong.wu@arm.com, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:13=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 30 Apr 2024 10:28:38 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Tue, 30 Apr 2024 14:17:24 +1000
> > Gavin Shan <gshan@redhat.com> wrote:
> >
> > > On 4/26/24 23:51, Jonathan Cameron wrote:
> > > > Make the per_cpu(processors, cpu) entries available earlier so that
> > > > they are available in arch_register_cpu() as ARM64 will need access
> > > > to the acpi_handle to distinguish between acpi_processor_add()
> > > > and earlier registration attempts (which will fail as _STA cannot
> > > > be checked).
> > > >
> > > > Reorder the remove flow to clear this per_cpu() after
> > > > arch_unregister_cpu() has completed, allowing it to be used in
> > > > there as well.
> > > >
> > > > Note that on x86 for the CPU hotplug case, the pr->id prior to
> > > > acpi_map_cpu() may be invalid. Thus the per_cpu() structures
> > > > must be initialized after that call or after checking the ID
> > > > is valid (not hotplug path).
> > > >
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > ---
> > > > v8: On buggy bios detection when setting per_cpu structures
> > > >      do not carry on.
> > > >      Fix up the clearing of per cpu structures to remove unwanted
> > > >      side effects and ensure an error code isn't use to reference t=
hem.
> > > > ---
> > > >   drivers/acpi/acpi_processor.c | 79 +++++++++++++++++++++---------=
-----
> > > >   1 file changed, 48 insertions(+), 31 deletions(-)
> > > >
> > > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proc=
essor.c
> > > > index ba0a6f0ac841..3b180e21f325 100644
> > > > --- a/drivers/acpi/acpi_processor.c
> > > > +++ b/drivers/acpi/acpi_processor.c
> > > > @@ -183,8 +183,38 @@ static void __init acpi_pcc_cpufreq_init(void)=
 {}
> > > >   #endif /* CONFIG_X86 */
> > > >
> > > >   /* Initialization */
> > > > +static DEFINE_PER_CPU(void *, processor_device_array);
> > > > +
> > > > +static bool acpi_processor_set_per_cpu(struct acpi_processor *pr,
> > > > +                                struct acpi_device *device)
> > > > +{
> > > > + BUG_ON(pr->id >=3D nr_cpu_ids);
> > >
> > > One blank line after BUG_ON() if we need to follow original implement=
ation.
> >
> > Sure unintentional - I'll put that back.
> >
> > >
> > > > + /*
> > > > +  * Buggy BIOS check.
> > > > +  * ACPI id of processors can be reported wrongly by the BIOS.
> > > > +  * Don't trust it blindly
> > > > +  */
> > > > + if (per_cpu(processor_device_array, pr->id) !=3D NULL &&
> > > > +     per_cpu(processor_device_array, pr->id) !=3D device) {
> > > > +         dev_warn(&device->dev,
> > > > +                  "BIOS reported wrong ACPI id %d for the processo=
r\n",
> > > > +                  pr->id);
> > > > +         /* Give up, but do not abort the namespace scan. */
> > >
> > > It depends on how the return value is handled by the caller if the na=
mespace
> > > is continued to be scanned. The caller can be acpi_processor_hotadd_i=
nit()
> > > and acpi_processor_get_info() after this patch is applied. So I think=
 this
> > > specific comment need to be moved to the caller.
> >
> > Good point. This gets messy and was an unintended change.
> >
> > Previously the options were:
> > 1) acpi_processor_get_info() failed for other reasons - this code was n=
ever called.
> > 2) acpi_processor_get_info() succeeded without acpi_processor_hotadd_in=
it (non hotplug)
> >    this code then ran and would paper over the problem doing a bunch of=
 cleanup under err.
> > 3) acpi_processor_get_info() succeeded with acpi_processor_hotadd_init =
called.
> >    This code then ran and would paper over the problem doing a bunch of=
 cleanup under err.
> >
> > We should maintain that or argue cleanly against it.
> >
> > This isn't helped the the fact I have no idea which cases we care about=
 for that bios
> > bug handling.  Do any of those bios's ever do hotplug?  Guess we have t=
o try and maintain
> > whatever protection this was offering.
> >
> > Also, the original code leaks data in some paths and I have limited ide=
a
> > of whether it is intentional or not. So to tidy the issue up that you'v=
e identified
> > I'll need to try and make that code consistent first.
> >
> > I suspect the only way to do that is going to be to duplicate the alloc=
ations we
> > 'want' to leak to deal with the bios bug detection.
> >
> > For example acpi_processor_get_info() failing leaks pr and pr->throttli=
ng.shared_cpu_map
> > before this series. After this series we need pr to leak because it's u=
sed for the detection
> > via processor_device_array.
> >
> > I'll work through this but it's going to be tricky to tell if we get ri=
ght.
> > Step 1 will be closing the existing leaks and then we will have somethi=
ng
> > consistent to build on.
> >
> I 'think' that fixing the original leaks makes this all much more straigh=
t forward.
> That return 0 for acpi_processor_get_info() never made sense as far as I =
can tell.
> The pr isn't used after this point.
>
> What about something along lines of.
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 161c95c9d60a..97cff4492304 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -392,8 +392,10 @@ static int acpi_processor_add(struct acpi_device *de=
vice,
>         device->driver_data =3D pr;
>
>         result =3D acpi_processor_get_info(device);
> -       if (result) /* Processor is not physically present or unavailable=
 */
> -               return 0;
> +       if (result) { /* Processor is not physically present or unavailab=
le */
> +               result =3D 0;

As per my previous message (just sent) this should be an error code,
as returning 0 from acpi_processor_add() is generally problematic.

> +               goto err_free_throttling_mask;
> +       }
>
>         BUG_ON(pr->id >=3D nr_cpu_ids);
>

