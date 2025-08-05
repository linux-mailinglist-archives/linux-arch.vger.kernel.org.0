Return-Path: <linux-arch+bounces-13071-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C979FB1BAE8
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 21:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3793A2D6A
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 19:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7901221D5B6;
	Tue,  5 Aug 2025 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGDkJkzA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED54AE55A;
	Tue,  5 Aug 2025 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421932; cv=none; b=ZawckzMzlrxPcY76e3tbykLJbbx87oBR8UZ+bdu7MtPkIRWm9EZNWQUpBvCKo+Ha5JzCRAql8Rm/G24YjKkZK7KuDduh/POWkzD4fnCdUeDvNU1BPTKdFZStsUyBdP/zzg0NYsXcgrFRECNdOBFXuNZc/ADu6vS7ea7OkOxMc2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421932; c=relaxed/simple;
	bh=IvAMGyYMul8YuDgB7guuqrH196efXLWCMYxChU+1zrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0TCKZduM5Cyyrx0fStFIslSUWQ8JJMhdOQX+CqJIwCSn+0Mw/O4K3r/g0uk68XJKtKrwveYFfk/oK2yXXcVoIlGpqeEN6qVaM+ii4yl3jzlBOuxT7pi1f/oHZZ8abH/BpYdCWY8Sq9kDTjLftX19Jawparpo4W+IN/nQ/UnTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGDkJkzA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24009eeb2a7so47045735ad.0;
        Tue, 05 Aug 2025 12:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754421930; x=1755026730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXUb4RrbMp7wNFmrUkG/OHb3oHVhCrLGH9v6ErBeJY4=;
        b=OGDkJkzAXSXgPMNSjcU+BuKUPMKE/z0nAWFafRlHcrVhi2fUNpZnsBov6YLp0ddU52
         TjtPGEYdOSsK4fRQ8dlSkY3031pDgZbrBj60NHuVo91ehpwbi2PRXOPKayDS8LUUZppN
         gKlR8yBqJjHeYQnYEVeeOtiCMQvXXYjx9+sRVP4QDp8kEuD21q/o+qYp8CL2YEds1uIg
         QS7NA41umCCOYPxzWFWkndTpJYsxFuPLYvfyROhljSLYbBhip1gfkQO+9Oz8mEzW4+QM
         Yu/7PpkvV9LsdfsUH8KlyJ+CmUmazYQCmJGbx2O83bw1i47lRJhLSTfn9C0K4k5NwdAG
         w9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754421930; x=1755026730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXUb4RrbMp7wNFmrUkG/OHb3oHVhCrLGH9v6ErBeJY4=;
        b=wG9+OGEILOHbjP7EmBSLLMeo78KXaIDkd6EQz3aN17cukXp1hsLbDNSkiePcrrruE0
         Eptt/r+NJlPm9XoRoQXgDrQVZMEi9fzdOEabhyqGQPpicjsTUs4o0uBt7hVPxKBF1xPx
         +wflXsy05cK0J2GQq+XFLtViPaeiFdIdBdqSP2J53IAkh5pbat6URRooZp4j6NaqTeaJ
         WQkpAIHEJd6Z+6Hpk7COqtL+Ibe3E3YBncMJf3q9jnaNqj0OPtqMUkbvizBuFlgAkvSl
         IymBKRhL4K1E8TOH5xPfYv11Fkni1YgUkKuwdXQfjHuMiP0jLtmDTbh77WuYJ31lRt8Z
         Mwqg==
X-Forwarded-Encrypted: i=1; AJvYcCUgGQHaK+C1gi4QtauO+syQEuVMet1V5Eco9AekFGlbdlUt9g/ABrtZhRDK5TbDDGhFjOslqpaYm/vt@vger.kernel.org, AJvYcCVc4zkx3NZ+dAAv0ruHBPd5RPbJOGseHPf4865wyk+GcrYrwYUzCoaAT0wK+QCnD/d/Q9ueP+VA/kQsQ9Pi@vger.kernel.org, AJvYcCXPNI9FoWbV8GdfvISBqVgKtNcubitxxpQmHxQF7J76pu+20OWgcr/rGB9c3KkIdFoKuxPhQjU0yh10y8d8@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3R/TUvQWSzKiObDAHHasSK0sac1VEOliAje4p68wvolY/eqO
	P2HHY/NSRDZHOqiATvxWONDp6PTdcS0UQt8entN/kE8jAXiExQ0tFVGQyw8xMjaCy9x2zrim+/V
	ftZFIbDPOvPre7f33vS0CXPe65wlTVTU=
X-Gm-Gg: ASbGncs+xcqCzgoug7y5cgoCy3BuRVOodzJRXdQLE3nbHchK7HRPpH/1NgihdU2lxR+
	1tLpzAEv4QS046ltFJwvX61ytG3zyd55aKkhu1YAAhPMqsLITwWQU3fAA+jkfaJqWedo4djNmAg
	plDDCIxSa1KvxYkmUagTxwgIUad+NxlT0Xlsx/SH459cGxN+WGWqW55nwecEhbfAyCwBRegnoli
	qz2dL/Athp4l34=
X-Google-Smtp-Source: AGHT+IGPQGDYInXHaVACpPWIrnrEzr5t50IpwU/JJrhyvSHMTDzu6RpMYb6XX8H10zagOTQBD3AS4f2Mti1152COw9Q=
X-Received: by 2002:a17:902:e743:b0:240:b073:932b with SMTP id
 d9443c01a7336-2429eeb4372mr3419625ad.23.1754421930214; Tue, 05 Aug 2025
 12:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804180525.32658-1-ltykernel@gmail.com> <20250804180525.32658-3-ltykernel@gmail.com>
 <SN6PR02MB415700541E44263490781D86D422A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB415700541E44263490781D86D422A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Wed, 6 Aug 2025 03:24:54 +0800
X-Gm-Features: Ac12FXyGficOvp7FusFhCVUGyTE2vboJ4NaTnI9WF2smhgQlijf8LtmTl1RC-Ig
Message-ID: <CAMvTesB0hAqV2P7kFegmsXdLq2mfY0LQCj3B=YH4YEd007x-Sw@mail.gmail.com>
Subject: Re: [RFC PATCH V5 2/4] Drivers: hv: Allow vmbus message synic
 interrupt injected from Hyper-V
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>, 
	"Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>, "kvijayab@amd.com" <kvijayab@amd.com>, 
	Tianyu Lan <tiala@microsoft.com>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:09=E2=80=AFAM Michael Kelley <mhklinux@outlook.com=
> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, August 4, 2025 11:05=
 AM
> >
> > When Secure AVIC is enabled, VMBus driver should
> > call x2apic Secure AVIC interface to allow Hyper-V
> > to inject VMBus message interrupt.
> >
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
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
> > index 308c8f279df8..2ff433cb5cc2 100644
> > --- a/drivers/hv/hv.c
> > +++ b/drivers/hv/hv.c
> > @@ -314,8 +314,11 @@ void hv_synic_enable_regs(unsigned int cpu)
> >       shared_sint.vector =3D vmbus_interrupt;
> >       shared_sint.masked =3D false;
> >       shared_sint.auto_eoi =3D hv_recommend_using_aeoi();
> > +
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
> I agree with Neeraj's comment on the placement of this line of code.
> As I commented on v4 of the series, the hv_synic_enable/disable_regs()
> functions have units of code that do read, modify, then write of a
> synthetic MSR, such as the SIMP, SIEFP, and SINT. It's weird to have
> hv_enable_coco_interrupt() in the middle of such a unit. In this v5,
> you fixed the issue for hv_synic_enable_regs(), but not here for
> hv_synic_disable_regs(). The call to hv_enable_coco_interrupt()
> should go after call to hv_set_msr(HV_MSR_SINT0 ....), but before
> the call to hv_get_msr(HV_MSR_SIMP) so that the read/modify/write
> units aren't mixed with other things.
>
Hi Michael:
       Thanks for your review. Agree. Will update in the next version.

--
Thanks
Tianyu Lan

