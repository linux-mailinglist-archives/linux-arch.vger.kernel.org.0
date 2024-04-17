Return-Path: <linux-arch+bounces-3774-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2998A8AB3
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 20:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BCE2842B9
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F9172BCA;
	Wed, 17 Apr 2024 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGnr7c8x"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E0172BC3;
	Wed, 17 Apr 2024 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376804; cv=none; b=SMADWL2EdP3KhvZ9n2AmO+txVSZbLPO0tKWJTowBb2XqE8e1ZUy3fFOnB8yO/NBucxJIegZu/F/Wt0E1hV0gMjMNnxArD8P0msml12X4zLKSafYjdP8dRzH9q6UpwoBmAlhu1aD/h6IShJOmYNUMuV3ffkAOA3pMugE++5/FOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376804; c=relaxed/simple;
	bh=V0BYQUyy2073cKbq7Zjbzjmt5xR8pfFi/NSeHZlp01Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DO2WYFMMiDkd3icyJonB4M+iSjdPB3gNp+Rdve9tvwWJ6kF9TLsfzocHzMOhOxT0Xoc17/+sBlR7DkdHLam7JbhcqIf2hcYu0JDzc6WcvaAAip1BBC9T1kBzIMK7OKnRCy+Ah2xkGZtELjtqB+xFDw4wYS4spNw3n2mKLRfpTOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGnr7c8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C405C4AF0B;
	Wed, 17 Apr 2024 18:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713376803;
	bh=V0BYQUyy2073cKbq7Zjbzjmt5xR8pfFi/NSeHZlp01Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FGnr7c8xW1ja2beitV6j7TSVXEClBXGeuoYYYo+4BL1tArgGcQP5L4R8AefJk1IGR
	 se4oVF4uENvFjiSrUcS1ssP0KSCGSCgmxLpDd//6EeNVe4xnY115ZMOg5Xr8M3OlJ5
	 QEf98OxHPbIfe3J5gvFcZOFpKV3x5ZTv/hXrLPaGJLgBfIR5U/1gm8uBZaaoGTzeZu
	 INAqd+JPua/GnSsm7TTIIPcS1FstY+kYv4GppdET9dmI9awVR1gItMCOR3OAjPR5/P
	 2az3JjBkaQ/VEdpdoSDNRxAFqDNx2IQLCMtY2YLKXGx4eB4jnNngnSGqR9y0BLkS0/
	 1UCKEG0xdm2YQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ac4470de3bso6624eaf.0;
        Wed, 17 Apr 2024 11:00:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkAmENu17wghWPxipxIgefaJa3onlQR8ThE7eyJG2678EMyF7XRDfj3n0HM2VWH3xk+onwxD9B9JK6dcvmG0wU9V+hO9dzSbo/bxP7Ll1pd168/9/0aQtm+FGj23vpP4ApeNXJqxs/55MjGQapH/l6bcDVsRyWtI2bDndk2TfCxPupDHp+Frf0XLuTjJ9DNBQ2gVnBUaePpML+Yaphaw==
X-Gm-Message-State: AOJu0YyGFwzRR9DFbmWaz3W6FpHK24sGBuyilyJVyV9UrhIu5Z7gjvGF
	z3h5E58YnI5L3wDRBjJwXenhBR+r1Y2M29JaW8B4ckxQrdfdni9jyS9TDXm7/XeplKgeKCZsRNP
	FAOKqGGnjsm48sNFcpVFTzbvBYzI=
X-Google-Smtp-Source: AGHT+IGdb9fVf0nDkCZ4moh+SZ4JXNUOMFl73Fzy+XXkB7kFSkI6i9jMBSPuRrApwYio0wFQm8gC4I1C99yI4wOC8po=
X-Received: by 2002:a4a:b447:0:b0:5a4:7790:61b4 with SMTP id
 h7-20020a4ab447000000b005a4779061b4mr499834ooo.0.1713376802449; Wed, 17 Apr
 2024 11:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
 <20240417131909.7925-7-Jonathan.Cameron@huawei.com> <22ace9b108ee488eb017f5b3e8facb8d@huawei.com>
 <20240417163842.0000415e@Huawei.com> <CAJZ5v0gJL0mucnN9Na2pCg0ckcTO8cNtpnAcnPD5w9eavUMQcg@mail.gmail.com>
 <20240417180939.00003db7@huawei.com>
In-Reply-To: <20240417180939.00003db7@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 19:59:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iFpkZZ9Ky6n5OiYsiNQ8_SRJv8hH0CLwPX=N4Ucc_snQ@mail.gmail.com>
Message-ID: <CAJZ5v0iFpkZZ9Ky6n5OiYsiNQ8_SRJv8hH0CLwPX=N4Ucc_snQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/16] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Salil Mehta <salil.mehta@huawei.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Miguel Luis <miguel.luis@oracle.com>, 
	James Morse <james.morse@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Linuxarm <linuxarm@huawei.com>, 
	"justin.he@arm.com" <justin.he@arm.com>, "jianyong.wu@arm.com" <jianyong.wu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 7:09=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 17 Apr 2024 17:59:36 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Wed, Apr 17, 2024 at 5:38=E2=80=AFPM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Wed, 17 Apr 2024 16:03:51 +0100
> > > Salil Mehta <salil.mehta@huawei.com> wrote:
> > >
> > > > >  From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > > > >  Sent: Wednesday, April 17, 2024 2:19 PM
> > > > >
> > > > >  From: James Morse <james.morse@arm.com>
> > > > >
> > > > >  The arm64 specific arch_register_cpu() call may defer CPU regist=
ration until
> > > > >  the ACPI interpreter is available and the _STA method can be eva=
luated.
> > > > >
> > > > >  If this occurs, then a second attempt is made in acpi_processor_=
get_info().
> > > > >  Note that the arm64 specific call has not yet been added so for =
now this will
> > > > >  be called for the original hotplug case.
> > > > >
> > > > >  For architectures that do not defer until the ACPI Processor dri=
ver loads
> > > > >  (e.g. x86), for initially present CPUs there will already be a C=
PU device. If
> > > > >  present do not try to register again.
> > > > >
> > > > >  Systems can still be booted with 'acpi=3Doff', or not include an=
 ACPI
> > > > >  description at all as in these cases arch_register_cpu() will no=
t have
> > > > >  deferred registration when first called.
> > > > >
> > > > >  This moves the CPU register logic back to a subsys_initcall(), w=
hile the
> > > > >  memory nodes will have been registered earlier.
> > > > >  Note this is where the call was prior to the cleanup series so t=
here should be
> > > > >  no side effects of moving it back again for this specific case.
> > > > >
> > > > >  [PATCH 00/21] Initial cleanups for vCPU HP.
> > > > >  https://lore.kernel.org/all/ZVyz%2FVe5pPu8AWoA@shell.armlinux.or=
g.uk/
> > > > >
> > > > >  e.g. 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEV=
ICES")
> > > > >
> > > > >  Signed-off-by: James Morse <james.morse@arm.com>
> > > > >  Reviewed-by: Gavin Shan <gshan@redhat.com>
> > > > >  Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > > >  Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > > >  Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > > > >  Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk=
>
> > > > >  Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > >  Signed-off-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
> > > > >  ---
> > > > >  v6: Squash the two paths for conventional CPU Hotplug and arm64
> > > > >      vCPU HP.
> > > > >  v5: Update commit message to make it clear this is moving the
> > > > >      init back to where it was until very recently.
> > > > >
> > > > >      No longer change the condition in the earlier registration p=
oint
> > > > >      as that will be handled by the arm64 registration routine
> > > > >      deferring until called again here.
> > > > >  ---
> > > > >   drivers/acpi/acpi_processor.c | 12 +++++++++++-
> > > > >   1 file changed, 11 insertions(+), 1 deletion(-)
> > > > >
> > > > >  diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_p=
rocessor.c
> > > > >  index 7ecb13775d7f..0cac77961020 100644
> > > > >  --- a/drivers/acpi/acpi_processor.c
> > > > >  +++ b/drivers/acpi/acpi_processor.c
> > > > >  @@ -356,8 +356,18 @@ static int acpi_processor_get_info(struct
> > > > >  acpi_device *device)
> > > > >      *
> > > > >      *  NOTE: Even if the processor has a cpuid, it may not be pr=
esent
> > > > >      *  because cpuid <-> apicid mapping is persistent now.
> > > > >  +   *
> > > > >  +   *  Note this allows 3 flows, it is up to the arch_register_c=
pu()
> > > > >  +   *  call to reject any that are not supported on a given arch=
itecture.
> > > > >  +   *  A) CPU becomes present.
> > > > >  +   *  B) Previously invalid logical CPU ID (Same as becoming pr=
esent)
> > > > >  +   *  C) CPU already present and now being enabled (and wasn't
> > > > >  registered
> > > > >  +   *     early on an arch that doesn't defer to here)
> > > > >      */
> > > > >  -  if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> > > > >  +  if ((!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> > > > >  +       !get_cpu_device(pr->id)) ||
> > > > >  +      invalid_logical_cpuid(pr->id) ||
> > > > >  +      !cpu_present(pr->id)) {
> > > >
> > > >
> > > Hi Salil,
> > >
> > > Thanks for quick review!
> > >
> > > > Logic is clear but it is ugly. We should turn them into macro or in=
line.
> > >
> > > You've found the 'ugly' in this approach vs keeping them separate.
> > >
> > > For this version I wanted to keep it clear that indeed this condition
> > > is a complex mess of different things (and to let people compare
> > > it easily with the two paths in v5 to convinced themselves this
> > > is the same)
> > >
> > > It's also a little tricky to do, so will need some thought.
> > >
> > > I don't think a simple acpi_cpu_is_hotplug() condition is useful
> > > as it just moves the complexity away from where a reader is looking
> > > and it would only be used in this one case.
> > >
> > > It doesn't separate well into finer grained subconditions because
> > > (C) is a messy case of the vCPU HP case and a not done
> > > something else earlier.  The disadvantage of only deferring for
> > > arm64 and not other architectures.
> > >
> > > The best I can quickly come up with is something like this:
> > > #define acpi_cpu_not_present(cpu) \
> > >         (invalid_logical_cpuid(cpu) || !cpu_present(cpu))
> > > #define acpi_cpu_not_enabled(cpu) \
> > >         (!invalid_logical_cpuid(cpu) || cpu_present(cpu))
> > >
> > >         if ((apci_cpu_not_enabled(pr->id) && !get_cpu_device(pr->id) =
||
> > >             acpi_cpu_not_present(pr->id))
> > >
> > > Which would still need the same amount of documentation. The
> > > code still isn't enough for me to immediately be able to see
> > > what is going on.
> > >
> > > So maybe worth it... I'm not sure.  Rafael, you get to keep this
> > > fun, what would you prefer?
> >
> > I would use a static inline function returning bool to carry out these
> > checks with comments explaining the different cases in which 'true'
> > needs to be returned.
>
> The following makes a subtle logic change (I'll retest tomorrow) but
> I think that get_cpu_device(cpu) can never succeed in a path where
> hotadd makes sense.
>
> +/*
> + * Identify if the state transition indicates that hotadd_init
> + * should be called.
> + *
> + * For acpi_processor_add() to be called, the reported state must
> + * now be enabled and present. Conditions reflect prior state.
> + */
> +static inline bool acpi_processor_should_hotadd_init(int cpu)
> +{
> +       /* Already register, initial registration was not deferred */

"Already registered." I think.

> +       if (get_cpu_device(cpu))
> +               return false;
> +
> +       /* Processor has become present */
> +       if (!cpu_present(cpu))
> +               return true;
> +
> +       /* Logical cpuid currently invalid indicates hotadd */
> +       if (invalid_logical_cpuid(cpu))
> +               return true;
> +
> +       /*
> +        * Previously present and the logical cpu id is valid.
> +        * Deferred registration now _STA can be queries, or
> +        * Hotadd due to enabled becoming true on an online capable
> +        * CPU.
> +        */
> +       if (cpu_present(cpu))
> +               return true;

It returns true for both the cpu_present(cpu) and !cpu_present(cpu)
cases, so will it ever return false except for when
get_cpu_device(cpu) returns true?

> +
> +       return false;
> +}
> +
>  static int acpi_processor_get_info(struct acpi_device *device)
>  {
>         union acpi_object object =3D { 0 };
> @@ -356,18 +388,8 @@ static int acpi_processor_get_info(struct acpi_devic=
e *device)
>          *
>          *  NOTE: Even if the processor has a cpuid, it may not be presen=
t
>          *  because cpuid <-> apicid mapping is persistent now.
> -        *
> -        *  Note this allows 3 flows, it is up to the arch_register_cpu()
> -        *  call to reject any that are not supported on a given architec=
ture.
> -        *  A) CPU becomes present.
> -        *  B) Previously invalid logical CPU ID (Same as becoming presen=
t)
> -        *  C) CPU already present and now being enabled (and wasn't regi=
stered
> -        *     early on an arch that doesn't defer to here)
>          */
> -       if ((!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> -            !get_cpu_device(pr->id)) ||
> -           invalid_logical_cpuid(pr->id) ||
> -           !cpu_present(pr->id)) {
> +       if (acpi_processor_should_hotadd_init(pr->id)) {
>                 ret =3D acpi_processor_hotadd_init(pr, device);
>

