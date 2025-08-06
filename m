Return-Path: <linux-arch+bounces-13085-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC4AB1C995
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 18:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B778B16DFAD
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5628BAB9;
	Wed,  6 Aug 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfaGPGz9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D7C2A1D1;
	Wed,  6 Aug 2025 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754496324; cv=none; b=XMtsuvOC2AuKL7BotnQhne/1JZjyfKIfbwdl9JacqIevZ652YI0TEnbpIeCZ0ICynLOO3X9xvIznkdtphv5aAve4pS2UbJoVcHjdq1LdhgVOTXdNVL8y1GIFvdKfHNOXbNTky/v1jK6VvMA/dOiIvmPT+pOP8Ev2hFkXfCbNypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754496324; c=relaxed/simple;
	bh=PhwHG+EYFOVRG5uXkt7IEDkcKqrpvkAxqGQnnryKl0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmEKaIj3P8Lm2yTUhLI3QfAuMFOGAXXiNuNM7L2xP+hkHseLEIdt3BXrvEZU/dpfURtK1SB0hSDG/LTqFIiWp79IczUJBom4FCvcu5haUEtYwErnNC96rervTeo94WBSF9obuROIi6ubz2+JLtmDQ0WsDbAgkGk6wYoj2LLknKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfaGPGz9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32129c4e9a4so104302a91.1;
        Wed, 06 Aug 2025 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754496323; x=1755101123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mIOK50dkPBYkubxS1HC0J6F3j7e4NYAAxh00VWx4Sg=;
        b=HfaGPGz9zVBEaxMuBSzx7ZGwjtxXiQt/fH10UnSQHunTRX0/+n0qYuP2H9eq+18MzR
         Djn/qDL6veJjfW2FVUxqyJ5qRbyrgSS4BaDDJIugkWTqfJ2PIvwxvVdt5bcQ6va5wxwQ
         8mP1dktbLjYNDxGo44HyhLjx88jJKg5t+A0PujnUpdJHowVu2i2a/6uo/6uXIgSfCsiB
         3D3kmOzRkKKVPOKa2l7NOzcmgwT3j7u3F6N4OhKYd/nOSvmuHRiD+ZSFyq1M7oipyW5Y
         /Jh6irqKKKH3w4BK7QcUdNoFBQyLFY5vmQTZy5PRjJuxNft82YCVjXbmdyUGniNIWtBC
         +wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754496323; x=1755101123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mIOK50dkPBYkubxS1HC0J6F3j7e4NYAAxh00VWx4Sg=;
        b=oEE3uAX+pSyBfNYpJ1p6P2BFkzWEVAQfajYhulr6pyQKum6b278jNPOWkQiPmDfh3F
         ue1rZZQMYmd15E5iPXiBm9nMGM3DCXSixXLKXX950U8wnXswNtg7efbtiR0n0wu2rSIm
         W/Ii3+sxoNM7JpeJPUySa4SL6naYDk4QKnUP73GhaDS71JDfPXOkTdd55Jir6TZeZnGE
         x9QxMLAOFFIrUpYgDzdcsPYIMOEZU9B/kYS+33zCIDAezVE/YMfpSXDEfLIBolDYA4ai
         W8whOMdDXGNjS1nAiZu1jLHaWscV8codKpnvKn4IntWpSXKAE/3SiG/9OqPH7K1m9U5l
         B7hg==
X-Forwarded-Encrypted: i=1; AJvYcCUsWDZXxKIXV+mFNwOl/z7DkwoFfdnEWGL1R7n2V5YQLNZ6T4VlOxPmqNiaanNbKNx81jtIhCL2QNaW87yk@vger.kernel.org, AJvYcCW4TCMqoS4S6p27y41UYUY8XS/LEeWWf1B0BqlJLt1Hv95FTmj0FZfvPwt80vKIEd+R1WRhOOPsF8C1tYyZ@vger.kernel.org, AJvYcCXDgEVXPOjuurA2f9M1liqSxZ/pf+QLoju+QXBhFGafuv2MQehDZ2loygBpLKjIxtXkMykRBmYfDo1o@vger.kernel.org
X-Gm-Message-State: AOJu0YwULy2xynv3qkP5DBUJMXuOGt401O6D4RqR3qgdo+AKMHp7o75H
	HWz4bzfFTC1LiBPZjSM6A1GxG8w8yBC9xUuaSgFwaupD3xd6u0k1fDaHVZOiGc2HYBI/tNZE4ce
	HeOGhznHmXjyEX/1DFFIaN8FAbNEe+VM=
X-Gm-Gg: ASbGncsy0cyozYL+f2e/jSisPq8XzzJgsKnhFGqB6qEsD0uVNalW7AZSIhlthiEFNDq
	7wU9/6ToT7iapR9OPIKf933pnfee0Bg4/mjvP1fakaIvjIH7uU9k690/4qWDGpa5+BOno5h0KkC
	KH8L4tsqhcIrmLfVdGcSD+MeLPIjFsAoHZn09MLjgHPib4rJVLCtFyZ33eEhzzVhIy7CCF4MAlM
	ckHIjH4W9yNomU=
X-Google-Smtp-Source: AGHT+IGAB9zEBN9WyI1cOqR8gsShigz2DOPciDd134KjWnUqYPaBIAixD49cDE6AL0Ceby+ICO9OTnyOVztal+CLDGk=
X-Received: by 2002:a17:90b:3e84:b0:312:1c83:58fb with SMTP id
 98e67ed59e1d1-32166e24168mr3970705a91.1.1754496322361; Wed, 06 Aug 2025
 09:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806121855.442103-1-ltykernel@gmail.com> <20250806121855.442103-3-ltykernel@gmail.com>
 <SN6PR02MB41577D7BFC7FA078880979A5D42DA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41577D7BFC7FA078880979A5D42DA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 7 Aug 2025 00:04:45 +0800
X-Gm-Features: Ac12FXzgB4ZlCcmb1NTN1lJxRIunYBc-Z8YR70b8_09nzYK16W-8MlX8Y0jCCYw
Message-ID: <CAMvTesAmCyO6XF-sRtMKw=TwKgeqaEkMQTmtkZbA7P-zeqDg6Q@mail.gmail.com>
Subject: Re: [RFC PATCH V6 2/4 Resend] Drivers: hv: Allow vmbus message synic
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

On Wed, Aug 6, 2025 at 10:11=E2=80=AFPM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, August 6, 2025 5:=
19 AM
> >
> > When Secure AVIC is enabled, VMBus driver should
> > call x2apic Secure AVIC interface to allow Hyper-V
> > to inject VMBus message interrupt.
> >
> > Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> > Change since RFC V5:
> >        - Rmove extra line and move hv_enable_coco_interrupt()
> >          just after hv_set_msr() in the hv_synic_disable_regs().
> >
> > Change since RFC V4:
> >         - Change the order to call hv_enable_coco_interrupt()
> >         in the hv_synic_enable/disable_regs().
> >       - Update commit title "Drivers/hv:" to "Drivers: hv:"
> >
> > Change since RFC V3:
> >        - Disable VMBus Message interrupt via hv_enable_
> >                coco_interrupt() in the hv_synic_disable_regs().
> > ---
> >  arch/x86/hyperv/hv_apic.c      | 5 +++++
> >  drivers/hv/hv.c                | 7 ++++++-
> >  drivers/hv/hv_common.c         | 5 +++++
> >  include/asm-generic/mshyperv.h | 1 +
> >  4 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> > index 01bc02cc0590..c9808a51fa37 100644
> > --- a/arch/x86/hyperv/hv_apic.c
> > +++ b/arch/x86/hyperv/hv_apic.c
> > @@ -54,6 +54,11 @@ static void hv_apic_icr_write(u32 low, u32 id)
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
> > index 308c8f279df8..d68a96de1626 100644
> > --- a/drivers/hv/hv.c
> > +++ b/drivers/hv/hv.c
> > @@ -312,10 +312,13 @@ void hv_synic_enable_regs(unsigned int cpu)
> >       shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE=
_SINT);
> >
> >       shared_sint.vector =3D vmbus_interrupt;
> > +
>
> The spurious blank line is still here.
>
> >       shared_sint.masked =3D false;
> >       shared_sint.auto_eoi =3D hv_recommend_using_aeoi();
> >       hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint=
64);
> >
> > +     hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
> > +
> >       /* Enable the global synic bit */
> >       sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
> >       sctrl.enable =3D 1;
> > @@ -342,7 +345,6 @@ void hv_synic_disable_regs(unsigned int cpu)
> >       union hv_synic_scontrol sctrl;
> >
> >       shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE=
_SINT);
> > -
> >       shared_sint.masked =3D 1;
> >
> >       /* Need to correctly cleanup in the case of SMP!!! */
> > @@ -350,6 +352,9 @@ void hv_synic_disable_regs(unsigned int cpu)
> >       hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint=
64);
> >
> >       simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
> > +
> > +     hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);
> > +
>
> This line is still in the wrong place. Maybe you accidentally resent
> the previous version of the patch instead of the version with your
> intended changes?
>
> Michael
Hi Michael:
      I just sent out an update version. Sorry for confusion.
--=20
Thanks
Tianyu Lan

