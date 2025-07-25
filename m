Return-Path: <linux-arch+bounces-12958-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79575B12528
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 22:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF934E260C
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F41255E2F;
	Fri, 25 Jul 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkBUg851"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5190253F1B;
	Fri, 25 Jul 2025 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753474047; cv=none; b=Mv816WpeZHcke80LoJMQw9SdxKbShHyTuh2u5kXIyZCIJD5Pip0/e+YAyhBBRDnsrkWxQN6YSvOsSodGp9/PvfnaJdksiZ/vmNv9f0ilO9Jxl6mNmZpVAWy17pqhT0r8kCIZUGAdnpcGBRtk2E69VPg4Mt0k9yUIIaWHvwT9Lic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753474047; c=relaxed/simple;
	bh=zpFp4S9yw4pSClM+sDal9V6MFgWIVSFIiEPZ1rxMoRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5pqqkpk0IojGEJGEkACEvRUjGMkbzXFuhADkjWqhONE9PVVu3AAhanh+X6NmpDzban9VKkyBbw7ZyB7g9jOekSWSiP7IpbrUvilpTe1Tk/4RHdcD0hUjeEHmaqoaTB7ijIE4r5MszNKP5gP3m/PWU1N6q6S/VsU41buXxDvntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkBUg851; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b390136ed88so1990673a12.2;
        Fri, 25 Jul 2025 13:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753474045; x=1754078845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT5QUQKg2ALk3uV+xK+HLSPEzHUJpBc0QQCSTd1kT/c=;
        b=nkBUg851MZqaqymHCCBoqshrTDtloL7pygbByNy3jLZ8hymS/Ps8ky0LAvv++HaKHe
         rTuBAqrNHn6yJflTAt9fhiRPZnZIn0mLlDMjDCM/7/8pm9PbjCHj/Y4D79qDPNZLGIcS
         ISt/I6EZEsVZcaB8lhZ0Dp8Wr8FCusRPK0LmI0UEQQyqAECTTRAwzGLTHY9dhXJWZIQY
         5QwrJHrTArwx3opy7aAZWgkd78/4ZXu5/RU1w4mkrTGGDFMSdIumpTtcWkXGalRUzC0c
         VjXIch2sppBZA5e4R8qpwJx6xoW4nq2/PNcJmD+38GbSdIF0GE4l1hF3VFc35ULsNxaV
         aVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753474045; x=1754078845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT5QUQKg2ALk3uV+xK+HLSPEzHUJpBc0QQCSTd1kT/c=;
        b=CHh6hmhbR26Gzlc33OgJGLX6fkcCuKtKMgAQDL+fHcEG2H6/T0ZbfrW3XNLQKH5/PP
         kr84itw0RT6kcYNDoGH9ch5fhT6yUpAZt6BKE2DHbxhqDZ1zILqMi4HmmKYu0hIZM/h+
         7vU6pZ6yU5Ip5EqVU+vdaPR3Z0A7RT7RJUQ2b0zqGIaGtD1UKZTDm0Lvp01oQp5vHCZH
         1RKgyT8VoRfLv/vLGBJ6lA2uiLr6OEz9Sk4xXw+T2ZSP4+b5GUOIvUEUVEcFbPAjRqIB
         Bs8AwIsm1tqE6U18u6+uO/KEQtS3utM43bSNx9O65hhJczRxjBgUZiCmGSyonWKx/jVA
         6XZw==
X-Forwarded-Encrypted: i=1; AJvYcCUT6MNqB0IVLhFUQl4eNtoJdV0PMYuRqTymtraIfAKSmXMdnYdIk+OlqA/+fW3N54iXC530eSbS/c9S@vger.kernel.org, AJvYcCXOIMp1JmWT5pBPj5VVWQ5JJQohOKg1fxUfUSLJ8nNu6cNd1e6C3cpTIKSrUgORoly1lQYIiAvVM+attPNn@vger.kernel.org, AJvYcCXciG8BtvYpZ37H/0d3NwcaehcFGauYQgEeOQRuA6x9/ReDHImvmel7VQnfDx1c7sYjBhf50NxDEaQ6cZjR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyry10+MSc1orOzEEFTFq2bTWYTudSqVZzaPwf7BTKsSzYK+Icj
	qCc44UzhcRx3Wcw7MEEhr/ZQ5n0XWQ/mqReUoyEvrogqMq1L0gLFs1sGZ0kAwMv67Vo8WtWrF6p
	QU8z63oOAsbo6F2SUfRQemqacXyEY45w=
X-Gm-Gg: ASbGncuv0/V+D0MomQ0dRQRDTRfUbuiwSQagXu38EL+LRzXHAFIZN2YkHhFSLFQXfCe
	y/+FUh+a+gSvupns2tf1uMTp6DIsyZBum5eugzjv93rbBj5bBC/z588DgjBGP9UZaotUA9MJ0gQ
	Y0RUW9YPYs5Lw1iQicEIYpTaaDw5lNxenBXPg4L3RR999/ot9VePlTZlX0QdlrELmOq8ZyZSYWP
	gxG
X-Google-Smtp-Source: AGHT+IETM9/0Sv5Fk5fdgFWKRZcjhkp47Vf+75TqKRn9xbf2G9bgjMKWkNQnSBtgG7va6qXj5j26EaUgZb80ycP16kA=
X-Received: by 2002:a17:90b:2d8c:b0:313:b78:dc14 with SMTP id
 98e67ed59e1d1-31e77635171mr5170286a91.0.1753474044826; Fri, 25 Jul 2025
 13:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723190308.5945-1-ltykernel@gmail.com> <20250723190308.5945-3-ltykernel@gmail.com>
 <SN6PR02MB4157A59A59B24DB51EAA1ECFD45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157A59A59B24DB51EAA1ECFD45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Sat, 26 Jul 2025 04:06:48 +0800
X-Gm-Features: Ac12FXzEnmcVaXrtMHRewNmk4ooVAIcqkXz64mQoW6zjhddkX2qzRuvRGQ8JQ8U
Message-ID: <CAMvTesCYNs+rEaktH_vjrxDXWgcZnfa8YF3jVcOkPN8YoSyQdw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 2/4] Drivers: hv: Allow vmbus message synic
 interrupt injected from Hyper-V
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>, 
	"Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>, Tianyu Lan <tiala@microsoft.com>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 7:34=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, July 23, 2025 12:=
03 PM
> >
> > When Secure AVIC is enabled, VMBus driver should
> > call x2apic Secure AVIC interface to allow Hyper-V
> > to inject VMBus message interrupt.
> >
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> > Change since v3
> >        - Add hv_enable_coco_interrupt() as wrapper
> >        of apic_update_vector()
> >
> >  arch/x86/hyperv/hv_apic.c      | 5 +++++
> >  drivers/hv/hv.c                | 2 ++
> >  drivers/hv/hv_common.c         | 5 +++++
> >  include/asm-generic/mshyperv.h | 1 +
> >  4 files changed, 13 insertions(+)
> >
> > diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> > index 1c48396e5389..dd6829440ea2 100644
> > --- a/arch/x86/hyperv/hv_apic.c
> > +++ b/arch/x86/hyperv/hv_apic.c
> > @@ -53,6 +53,11 @@ static void hv_apic_icr_write(u32 low, u32 id)
> >       wrmsrq(HV_X64_MSR_ICR, reg_val);
> >  }
> >
> > +void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, b=
ool set)
> > +{
> > +     apic_update_vector(cpu, vector, set);
> > +}
> > +
> >  static u32 hv_apic_read(u32 reg)
> >  {
> >       u32 reg_val, hi;
> > diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> > index 308c8f279df8..2aafe8946e5b 100644
> > --- a/drivers/hv/hv.c
> > +++ b/drivers/hv/hv.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/interrupt.h>
> >  #include <clocksource/hyperv_timer.h>
> >  #include <asm/mshyperv.h>
> > +#include <asm/apic.h>
>
> This #include is no longer needed since apic_update_vector()
> isn't being called directly. And the file doesn't exist on arm64,
> so it would create a compile error on arm64.
>
> Before submitting, I always do a test compile on arm64 with
> my patches so that errors like this are caught beforehand! :-)

Yes, good suggestion and will add compilation test on ARM64.
before sending out. Thanks.
>
> >  #include <linux/set_memory.h>
> >  #include "hyperv_vmbus.h"
> >
> > @@ -310,6 +311,7 @@ void hv_synic_enable_regs(unsigned int cpu)
> >       if (vmbus_irq !=3D -1)
> >               enable_percpu_irq(vmbus_irq, 0);
> >       shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE=
_SINT);
> > +     hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
>
> In the "RFC Patch v2" version of this patch, I had asked about whether
> the interrupt should be disabled in hv_synic_disable_regs(), so there is
> symmetry. [1] I see that in Patch 4 of this series, you are disabling the
> STIMER0 interrupt when a CPU goes offline. If disabling vmbus_interrupt
> causes a problem, I'm curious about the details.
>
Yes, that makes sense and will add it.
>
> >
> >       shared_sint.vector =3D vmbus_interrupt;
> >       shared_sint.masked =3D false;
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 49898d10faff..0f024ab3d360 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -716,6 +716,11 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param=
1, u64 param2)
> >  }
> >  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
> >
> > +void __weak hv_enable_coco_interrupt(unsigned int cpu, unsigned int ve=
ctor, bool set)
> > +{
> > +}
> > +EXPORT_SYMBOL_GPL(hv_enable_coco_interrupt);
> > +
> >  void hv_identify_partition_type(void)
> >  {
> >       /* Assume guest role */
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyp=
erv.h
> > index a729b77983fa..7907c9878369 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -333,6 +333,7 @@ bool hv_is_isolation_supported(void);
> >  bool hv_isolation_type_snp(void);
> >  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 inpu=
t_size);
> >  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> > +void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, b=
ool set);
> >  void hyperv_cleanup(void);
> >  bool hv_query_ext_cap(u64 cap_query);
> >  void hv_setup_dma_ops(struct device *dev, bool coherent);
> > --
> > 2.25.1
> >
>


--=20
Thanks
Tianyu Lan

