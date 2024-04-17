Return-Path: <linux-arch+bounces-3767-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47588A8857
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 17:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0357E1C223D3
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915E61487E4;
	Wed, 17 Apr 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4l8Kfwj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3C1487D6;
	Wed, 17 Apr 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369589; cv=none; b=XZo+GTERHiv+TYEDWZRjH8P7AUTrK6h9oKxMzbxBv7kLzgsRW8XwmCCD1Whr8ANSidSpkY2hqe9Y1tO5Dj9SOxkR6B9q3ydTjtnQQqcIVwAMyy4rCIU5T5bvL+AdcP1oyCPNYPoIwQl/z/JJFaPotGGywSD0hFjEt1C7lrgRIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369589; c=relaxed/simple;
	bh=gb50RbRpjXShl8LUS+BeL4GCX3tp8IZmzIWGi8zYb2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkVRTcbiDJvnAryzbKwx3C3EY+H4M2v1whUeR2xPAI2uXS1bj0n0mNOMqSEbaF8qt4g7zyNpBeAgHEClVkZvrosp/2Wwk0vhRAzDZEqBX95HAEUHgBz4ctk8ubGmezsg8f17BXsiKlncxpKfdXmm2wdNvMAKsVyRK8igzLy64Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4l8Kfwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB142C3277B;
	Wed, 17 Apr 2024 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713369588;
	bh=gb50RbRpjXShl8LUS+BeL4GCX3tp8IZmzIWGi8zYb2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q4l8KfwjEoNkNho1LWmswicc037/5eLapUE1VdcnRjqsXf8kRf0HTOQ1vemvysLkq
	 nxSlOVXxaTvzUU4WGz+NsOV7WikcvXX/KpoOIM/hYAGiTFHllUuWs6WKXcRYlu40ay
	 Pkk5SexD4tDL5hFv+E+DFLx7ljNUmUVVS/S51IDNgzk9RWqyY0S/Wf610Lb2MEG6iv
	 8njR9H1fvEyqRoKeJ2VE+PTWKcb0r6CFLdn1+LVQLI7a0uGrk1PDKO3ETe3vKFTRF1
	 83XTe7sVhrm9hMtuQwJCgk+lSDiIbZetzmoiSU4xZuCDP3zQH03lwcjO61rG9K2w9M
	 mp3ADjRQmANDQ==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6eb7a4d64e8so1256222a34.0;
        Wed, 17 Apr 2024 08:59:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyHdSF7N5029EjotteOR0k3Sy2cqLurPRwuoc8gWfra1S5kvbEBtxsydnzeClnC8oCpLysP1VfxFV/M4h/VdGrG72bSF9G3/+4SwaRAVQg9rlV3fo1+KGD7jNBcytw3T6JFxDgDlbnWm+euRjeQjG+BZA0xWz6YdYTlHVOWTuN/z5z61C1ddvE75dHUxDz435ALAHBk8JMtk7EcU3VLg==
X-Gm-Message-State: AOJu0YyguV55iiiRxV3jm4+MrmsU6aXlSzk2Jje4VC4DDob8/x0j1IIh
	bYUctcNA6vTVbJT9r+tmuDi1j758RK0hjDVNNSqG5FqBuc0qhhc8kA4CsS60eTfJTfJYehqmn5n
	hOBppvQulvHsRXEyWBx9xQkULK+4=
X-Google-Smtp-Source: AGHT+IHAKhIHZsoDLSQEnmwhBQgjZcL36nblFqE1AGDjJdp3XQsw26v26OKEFMG9SrKLYedvqajXqzGXp9/n6TzlelM=
X-Received: by 2002:a4a:9c56:0:b0:5aa:14ff:4128 with SMTP id
 c22-20020a4a9c56000000b005aa14ff4128mr25133ook.1.1713369588078; Wed, 17 Apr
 2024 08:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
 <20240417131909.7925-7-Jonathan.Cameron@huawei.com> <22ace9b108ee488eb017f5b3e8facb8d@huawei.com>
 <20240417163842.0000415e@Huawei.com>
In-Reply-To: <20240417163842.0000415e@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 17:59:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gJL0mucnN9Na2pCg0ckcTO8cNtpnAcnPD5w9eavUMQcg@mail.gmail.com>
Message-ID: <CAJZ5v0gJL0mucnN9Na2pCg0ckcTO8cNtpnAcnPD5w9eavUMQcg@mail.gmail.com>
Subject: Re: [PATCH v6 06/16] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Salil Mehta <salil.mehta@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Linuxarm <linuxarm@huawei.com>, 
	"justin.he@arm.com" <justin.he@arm.com>, "jianyong.wu@arm.com" <jianyong.wu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 5:38=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 17 Apr 2024 16:03:51 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>
> > >  From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > >  Sent: Wednesday, April 17, 2024 2:19 PM
> > >
> > >  From: James Morse <james.morse@arm.com>
> > >
> > >  The arm64 specific arch_register_cpu() call may defer CPU registrati=
on until
> > >  the ACPI interpreter is available and the _STA method can be evaluat=
ed.
> > >
> > >  If this occurs, then a second attempt is made in acpi_processor_get_=
info().
> > >  Note that the arm64 specific call has not yet been added so for now =
this will
> > >  be called for the original hotplug case.
> > >
> > >  For architectures that do not defer until the ACPI Processor driver =
loads
> > >  (e.g. x86), for initially present CPUs there will already be a CPU d=
evice. If
> > >  present do not try to register again.
> > >
> > >  Systems can still be booted with 'acpi=3Doff', or not include an ACP=
I
> > >  description at all as in these cases arch_register_cpu() will not ha=
ve
> > >  deferred registration when first called.
> > >
> > >  This moves the CPU register logic back to a subsys_initcall(), while=
 the
> > >  memory nodes will have been registered earlier.
> > >  Note this is where the call was prior to the cleanup series so there=
 should be
> > >  no side effects of moving it back again for this specific case.
> > >
> > >  [PATCH 00/21] Initial cleanups for vCPU HP.
> > >  https://lore.kernel.org/all/ZVyz%2FVe5pPu8AWoA@shell.armlinux.org.uk=
/
> > >
> > >  e.g. 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEVICES=
")
> > >
> > >  Signed-off-by: James Morse <james.morse@arm.com>
> > >  Reviewed-by: Gavin Shan <gshan@redhat.com>
> > >  Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > >  Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > >  Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > >  Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > >  Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >  Signed-off-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
> > >  ---
> > >  v6: Squash the two paths for conventional CPU Hotplug and arm64
> > >      vCPU HP.
> > >  v5: Update commit message to make it clear this is moving the
> > >      init back to where it was until very recently.
> > >
> > >      No longer change the condition in the earlier registration point
> > >      as that will be handled by the arm64 registration routine
> > >      deferring until called again here.
> > >  ---
> > >   drivers/acpi/acpi_processor.c | 12 +++++++++++-
> > >   1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > >  diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proce=
ssor.c
> > >  index 7ecb13775d7f..0cac77961020 100644
> > >  --- a/drivers/acpi/acpi_processor.c
> > >  +++ b/drivers/acpi/acpi_processor.c
> > >  @@ -356,8 +356,18 @@ static int acpi_processor_get_info(struct
> > >  acpi_device *device)
> > >      *
> > >      *  NOTE: Even if the processor has a cpuid, it may not be presen=
t
> > >      *  because cpuid <-> apicid mapping is persistent now.
> > >  +   *
> > >  +   *  Note this allows 3 flows, it is up to the arch_register_cpu()
> > >  +   *  call to reject any that are not supported on a given architec=
ture.
> > >  +   *  A) CPU becomes present.
> > >  +   *  B) Previously invalid logical CPU ID (Same as becoming presen=
t)
> > >  +   *  C) CPU already present and now being enabled (and wasn't
> > >  registered
> > >  +   *     early on an arch that doesn't defer to here)
> > >      */
> > >  -  if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> > >  +  if ((!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> > >  +       !get_cpu_device(pr->id)) ||
> > >  +      invalid_logical_cpuid(pr->id) ||
> > >  +      !cpu_present(pr->id)) {
> >
> >
> Hi Salil,
>
> Thanks for quick review!
>
> > Logic is clear but it is ugly. We should turn them into macro or inline=
.
>
> You've found the 'ugly' in this approach vs keeping them separate.
>
> For this version I wanted to keep it clear that indeed this condition
> is a complex mess of different things (and to let people compare
> it easily with the two paths in v5 to convinced themselves this
> is the same)
>
> It's also a little tricky to do, so will need some thought.
>
> I don't think a simple acpi_cpu_is_hotplug() condition is useful
> as it just moves the complexity away from where a reader is looking
> and it would only be used in this one case.
>
> It doesn't separate well into finer grained subconditions because
> (C) is a messy case of the vCPU HP case and a not done
> something else earlier.  The disadvantage of only deferring for
> arm64 and not other architectures.
>
> The best I can quickly come up with is something like this:
> #define acpi_cpu_not_present(cpu) \
>         (invalid_logical_cpuid(cpu) || !cpu_present(cpu))
> #define acpi_cpu_not_enabled(cpu) \
>         (!invalid_logical_cpuid(cpu) || cpu_present(cpu))
>
>         if ((apci_cpu_not_enabled(pr->id) && !get_cpu_device(pr->id) ||
>             acpi_cpu_not_present(pr->id))
>
> Which would still need the same amount of documentation. The
> code still isn't enough for me to immediately be able to see
> what is going on.
>
> So maybe worth it... I'm not sure.  Rafael, you get to keep this
> fun, what would you prefer?

I would use a static inline function returning bool to carry out these
checks with comments explaining the different cases in which 'true'
needs to be returned.

