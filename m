Return-Path: <linux-arch+bounces-13062-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4C5B1AC2C
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 03:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6C5189419C
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 01:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC03194C75;
	Tue,  5 Aug 2025 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJgUhaft"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6321A41;
	Tue,  5 Aug 2025 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754358172; cv=none; b=j1BAVkNGH0DgVzZjhICOTCt/0nL11o0ySUFjMrrihhlMj/DKZx5SGxMMBrU2ROXuhOEAy4zbyXJ96qY4HWdkZc62vFXFzCUHqWCav+PIR8SdEBGbYaz4B8wLg6bLF4HeLFGAmj7miJdUWxnOcycGjyIVP01LEh2j+F3IWWnREIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754358172; c=relaxed/simple;
	bh=A5tKN3NLpcLEeueckta1xLRcBSJYSWJ62gCGhkJsv2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHZAmv+ua70U6DzGLYsphnW/XMLyNnF0Dwyg26i6dDFq+PnZeUIy3LiIiBd6oMUDvw9GFPa/v0UtKtUMTeNPEMMu+xxWC88UpS8BKdWSc3yjWG03a7chFUKXMhZc2wwdVa1yUs/jaZlBGnBV2x7OwPsr4rAoqB9Z0+zlUQLI6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJgUhaft; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b1fd59851baso3019397a12.0;
        Mon, 04 Aug 2025 18:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754358170; x=1754962970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgA3wTIY3p2v+ZvIoW59y3MZ0N8fTU9gK+ub/4KiV+Q=;
        b=NJgUhaftr5oDUyfCFFdbtG8aDoHgW43Bco40KlC+hCH1XS8Q98LDbao8AT7PJitPyM
         JCqcb1sJ3hsVq+vHaGRiu6mckZjx2Ums1cHSuL/z90HDNhXUni1Wh5xi0IlPHtSNQW/F
         rVztuJvWa9VpdRbKwTbRx602wdR/FBRTveLuwQqYdJb+IZbUgw+LgMAmq1FBHJyrTPyD
         DTDY0OM22C2w5zGqiOEM2nD5719h3MXKJee3rEFqyVphUsCFg9sk8EV2H0aAvibbTjMb
         d9gW7S7Z8nD7Rjp1ZTBo96igpMswF8arKW6xrZb017Nr9gjT92eS/usOXYOzQ8XO+mCP
         GGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754358170; x=1754962970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgA3wTIY3p2v+ZvIoW59y3MZ0N8fTU9gK+ub/4KiV+Q=;
        b=BG8yz1IhPGcYT3yriZum+RwpihboPGw1KiReXdbqaEJcnSncEjjH8Is+Xt+/JY1BQD
         2HdkFH5P3+9Yklv9g2urjXCGqybTOsUGRvBYXDCpkRHHC5bUzZOiUSPNT0YB+Bq6T1g2
         3qAYVayXN7gNJ6B1OXWoPkYgcnXF6J4VIBep1gW11tEgf2RWK/8+vRpIioDZs/hhPw1G
         lr4QGZM8G23SOxAsNeb0LR8s2zQ6QxdyNENYNZF/R2jiCPs8DWyI+6OACwR4ofK1Pi/C
         rGy6Dye9YvC3cConm+SsGv7fugzYuMSSFHk0XYUIS90GmgXphsiIYkDCwL+/0+ETLnzZ
         hpFw==
X-Forwarded-Encrypted: i=1; AJvYcCVT4Jv39w/e2/GQyMlC31Pb8oB6Qag0HQG6jKwyHOQViV63+IMWeTbaU8VwoKlcYqeBXmP5+ziPFazJsFRk@vger.kernel.org, AJvYcCWJnMnBugc/flSGpjsy5a8+QMUSg2kkWJ+jTvNrQCIua9GDZKNpE++TVbnVdytLGfToHT0xLf/nVCbI@vger.kernel.org, AJvYcCXuaXppDBeoV//boTIG0obL08ouMWViQbZf7Ui2u+ex+U2rchUYfFFH66gb0FHSNGJXk16Zu1/jtpbWRajD@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7MJoeb/nrHfZlSLYiuUpGoVP7b+nvrab1cY56yt+ZkmMtFOM
	NKMxJeF7677kUJS1n1MrcmgwMPuOjXOcUPkC1STqy6nMl4MY+tM/eL8UNIVGkKSCUPnGEiLsy/o
	q0zdvpxRgYtWcsj141pA44pPYiuKqND8=
X-Gm-Gg: ASbGncsokmiYfrMwxKkcrGbMJR511im9toq0cyjyuvdtnMGG+95rcojeM1VPEscIezL
	Z5JUOmEpVgJImT72NAjWkqIEhjgWSa6p5t8CX3WHA6EWxKsKjTw7wOEKh3HBTzWtLf9rA9zK8B7
	NY7O+UUMOx7nMYh6O32xOrrUGTlYcRIKO5B2MJanmW9SuqhnqaCsXcA6d250tgtQht4oCimlih+
	Dpj
X-Google-Smtp-Source: AGHT+IE+jnpPJqP9IPRC6Y9poG4IJEJQHAJVgk83zhVf1d1nyXr85oxXNNZ0NlsM3TH8iLUQjrmJwz7IKpywZpm1rJg=
X-Received: by 2002:a17:90b:3bcb:b0:315:fefe:bebf with SMTP id
 98e67ed59e1d1-321161f7bbfmr15753075a91.13.1754358169957; Mon, 04 Aug 2025
 18:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726134250.4414-1-ltykernel@gmail.com> <20250726134250.4414-3-ltykernel@gmail.com>
 <SN6PR02MB41575303B0EA2150B8089F35D45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41575303B0EA2150B8089F35D45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Tue, 5 Aug 2025 09:42:13 +0800
X-Gm-Features: Ac12FXw4YNblJ192oUSKBDq4JWe8x5VdvQY9rx1YszetstyUkWys6V3JwB5NJO4
Message-ID: <CAMvTesA87H11YFOMu4Z+FG89a5i+bjy6qy7sHHR-EALuLG9+bg@mail.gmail.com>
Subject: Re: [RFC PATCH V4 2/4] drivers/hv: Allow vmbus message synic
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

On Mon, Jul 28, 2025 at 10:45=E2=80=AFPM Michael Kelley <mhklinux@outlook.c=
om> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Saturday, July 26, 2025 6:43=
 AM
> >
>
> Nit: The patch "Subject:" prefix here should be "Drivers: hv:" with no sl=
ash, as
> it was in v3 of the patch. That's admittedly not consistent with "x86/hyp=
erv:"
> that is used for the other patches in this series, but it is consistent w=
ith historical
> practice for the files in the drivers/hv folder. You have to look at past=
 commits
> for a particular file to see what the typical prefix is.
>
> Michael
>
> > When Secure AVIC is enabled, VMBus driver should
> > call x2apic Secure AVIC interface to allow Hyper-V
> > to inject VMBus message interrupt.
> >
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> > Change since RFC V3:
> >        - Disable VMBus Message interrupt via hv_enable_
> >                coco_interrupt() in the hv_synic_disable_regs().
> > ---
> >  arch/x86/hyperv/hv_apic.c      | 5 +++++
> >  drivers/hv/hv.c                | 2 ++
> >  drivers/hv/hv_common.c         | 5 +++++
> >  include/asm-generic/mshyperv.h | 1 +
> >  4 files changed, 13 insertions(+)
> >
> > diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> > index e669053b637d..a8de503def37 100644
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
> > index 308c8f279df8..aa384dbf38ac 100644
> > --- a/drivers/hv/hv.c
> > +++ b/drivers/hv/hv.c
> > @@ -310,6 +310,7 @@ void hv_synic_enable_regs(unsigned int cpu)
> >       if (vmbus_irq !=3D -1)
> >               enable_percpu_irq(vmbus_irq, 0);
> >       shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE=
_SINT);
> > +     hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
> >
> >       shared_sint.vector =3D vmbus_interrupt;
> >       shared_sint.masked =3D false;
>
> Something I just noticed. The existing code in hv_synic_enable_regs()
> is reading the SINT MSR, updating some values, and then writing back
> the SINT MSR. Those steps act as a unit to update the MSR. You've added
> the call to hv_enable_coco_interrupts() in the middle of that unit, which
> implies there might be a reason for it. If there's not a reason, I would
> expect the call to hv_enable_coco_interrupt() to be before the unit,
> not in the middle of it.
>
> > @@ -342,6 +343,7 @@ void hv_synic_disable_regs(unsigned int cpu)
> >       union hv_synic_scontrol sctrl;
> >
> >       shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE=
_SINT);
> > +     hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);
>
> Same here with the hv_enable_coco_interrupt() call in the middle
> of the unit that is updating the SINT MSR. In the disable path, I would
> have expected hv_enable_coco_interrupt() to be *after* the unit so
> that disable operations are in reverse order of the corresponding enable
> operation.
>

Agree. Have updated in the RFC V5 series. Thanks for your suggestion, Micha=
el!

--
Thanks
Tianyu Lan

