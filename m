Return-Path: <linux-arch+bounces-13069-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC3BB1B752
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 17:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A9418A0796
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECE2279DB2;
	Tue,  5 Aug 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XatkETdD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6772797A1;
	Tue,  5 Aug 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407159; cv=none; b=Y2Acz84kFrFvGZiks+zWvNFhOKmL3FEsBX19BTK6kdGpA+2uD6F6mHF2uF4QpHaU21x4gUAGM1JwWKZovBI0DdMPXv7Zk7wNr+0zBDcrmvsUKQsVU05eaqcs8n7K8H2Q10lyUHH9WO8yeaWaJ6bsStpu8HscuweeZ7DmP3TSzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407159; c=relaxed/simple;
	bh=wHMHMlFPSLCN1Jyi3xsWh4m9GZ6TUcbpqIAvd989gPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwUCLMG0T6+UpRYsMpZjlRQVbYg1/jt91hYvzVXIR0Dz0CqnVVmdSMr7R+ik6A/vLfUY6pUDmFxzM/h3XKHwaKSylGenEe0ZT/Y65/JUOLbiHHRaY5OIrr74hhM0i/BejBOGvWQOk3gspI9gFDVc9XwAyETNbGYlQJfQyuXZvRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XatkETdD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bc61152d8so4745640b3a.2;
        Tue, 05 Aug 2025 08:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754407157; x=1755011957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EouBBaRl2Yz06MrDo9MABB0gPIhy3Or6WbSg/Pp0LIY=;
        b=XatkETdDTujLlf3d0lrYpykbm677xLWdNdMgFfec5fhYMT65C400/a8rPEPok0IWL7
         x3+vfvIOCABIgE5VUlT/+OsLlKAeEQSFOeAZHLdfVUKJnFl8XT730ik0YAipNk62GHWJ
         hkcsAqbgHUUzo/e7Pi5jpCLV1UxIWeheLvhwbxnp+7OOoz0PRWsm4Y7Vf2trqPsA2Jqn
         WeAJah/E8UJsM/IoU2tauLrly4Y2GbE3jSu+EHWQlRJwP4tECA1i7tKRZl54e2x/ey1z
         nw725ev+z4AIFzeRva6E6MCVBLei27BC50+y+Y4B1iCbItoP52yqnWrsmw2qubo3eDEN
         uPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407157; x=1755011957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EouBBaRl2Yz06MrDo9MABB0gPIhy3Or6WbSg/Pp0LIY=;
        b=k91MR06e2LakGPoO2GLIYeH1lDz9qHDdxsYwYjl1F0adllQHEBbXDW+FbRyt1MrVca
         QYFUotc6/NT3ea1DGBKgm1bejAKyHoFHVuIqTxtxh1onEYBGY9Ej+jVW+KGVP0m9rYul
         4k9TOuaOuDW/L+lFo+gBEPeq3nOT7coUWluBWki+Jf8h4NKboxpjfrgj35uyYPOUGs71
         cHG8CAfwHaE8WQjcTGPBVc0uGEO48LFEIzaYVWyZm+b/EPof9qazU2m5kAWkDfeeN6lA
         zYfqCoBWU1jMA4XWYbzblL8GCtd1jKrcr7yK1WbhygCpyvjAktKhUQLpCF92iuzKFlOr
         dIug==
X-Forwarded-Encrypted: i=1; AJvYcCWCjcsAQHDj9rZ+4dj7B2vxRoqo6ESnGR7DS8CMSpycg9YFSY8KSsDdhmuzzfd8JvCFnlI7S6c9N8Ja6D+u@vger.kernel.org, AJvYcCWzbdXDUtdjAatPxa81hx3gKd5jKZxZt9AIGkbAnf1z3WyfkdNTO124sDqZarR5CLMqqqQ8YAX6+wMI@vger.kernel.org, AJvYcCXBsSW8gqrGhTrljnSiqsHFlTV5TCCl1RN/RNhNYRJymy22tqfuuzjafqfZ5axIyo7ZgLqL4R2/lcDWnZ+6@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6aZb9Oeikm4JWqJfvocYQAvek9XJDIQDacfSd09Ra3EW5gpK
	q7vQpOyp34QLrSYIReHYERAotcfMDvoIuGFg7qniC/MpZEkXgGAFQFw1PS8wOrUGJq9RUDShVJ4
	2UcMxJ8xdfF/GzBlzuCioujpaM2uvqIg=
X-Gm-Gg: ASbGnctvV6Web6fs9tCRc+R5+d9r6fC5boiWEWasvOEqpCPvtPgS/TSDGjDo1SbZUBm
	ms1Us8PMQXSTnL/d8iWzJsfEUh0YC4qUCHkT8je9LxOkjlolDLdrUR60ynk7GnK8DmLNwXTxDzT
	WSTzjVx+JFvG71Vj7o0AvBWhcopzLcIcEQZfrCu/OVKfuzgTH8GmoRoeFqxEGuPlQ991D130zfX
	Ueq
X-Google-Smtp-Source: AGHT+IECB/DYjD3rcFUbi36bniwAYNzKE1+rxQqfR7kzJGIsbEQRm+ubSm4xHqTVPMzPbqx/BeIPce0p4r5uvnZHli8=
X-Received: by 2002:a17:902:e291:b0:23f:f39b:eaf6 with SMTP id
 d9443c01a7336-24247027a37mr144006805ad.46.1754407156944; Tue, 05 Aug 2025
 08:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804180525.32658-1-ltykernel@gmail.com> <20250804180525.32658-3-ltykernel@gmail.com>
 <912536fc-15d4-4a57-91b5-ec902a93e2f4@amd.com>
In-Reply-To: <912536fc-15d4-4a57-91b5-ec902a93e2f4@amd.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Tue, 5 Aug 2025 23:18:41 +0800
X-Gm-Features: Ac12FXzhqn_xrfp-IxnNZn9DJb9prewdUwzeYK7uqklDB9WalMlkz_3S0dZ4mI4
Message-ID: <CAMvTesBzQtURO1xSoUuortdEp5kPo7ds9BX+Au-8donogWZg-g@mail.gmail.com>
Subject: Re: [RFC PATCH V5 2/4] Drivers: hv: Allow vmbus message synic
 interrupt injected from Hyper-V
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, 
	kvijayab@amd.com, Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 9:59=E2=80=AFPM Neeraj Upadhyay <Neeraj.Upadhyay@amd=
.com> wrote:
>
>
>
> On 8/4/2025 11:35 PM, Tianyu Lan wrote:
> > From: Tianyu Lan <tiala@microsoft.com>
> >
> > diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> > index 308c8f279df8..2ff433cb5cc2 100644
> > --- a/drivers/hv/hv.c
> > +++ b/drivers/hv/hv.c
> > @@ -314,8 +314,11 @@ void hv_synic_enable_regs(unsigned int cpu)
> >       shared_sint.vector =3D vmbus_interrupt;
> >       shared_sint.masked =3D false;
> >       shared_sint.auto_eoi =3D hv_recommend_using_aeoi();
> > +
>
> Nit: extra newline.

Thanks for your review. Will remove it..

>
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
>
> Nit: extra newline.
>

Will remove it..


>
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
> Nit: Maybe this should be above "simp.as_uint64 =3D hv_get_msr(HV_MSR_SIM=
P)" ?
>



--
Thanks
Tianyu Lan

