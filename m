Return-Path: <linux-arch+bounces-12956-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC2B124FC
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 21:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4938A5A4F64
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 19:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9484E1DDC0F;
	Fri, 25 Jul 2025 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHT67RHC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245371FC3;
	Fri, 25 Jul 2025 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473531; cv=none; b=LQ9KJHyngXNFrKz6FYhvcQ5KpzU4Sq1cIplc7x1wTEYL/UW1PuLaa6C6waxc5ecGCeS1TKVUt1PREmD81JbStLul3CmbA46WNFMSJSFobUlMWwD7YnJiGmE+G0DQxtuddRKpIoQOOeV2yXNOp9aVzEemQF7g12BOE+Jm+Z6Ti+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473531; c=relaxed/simple;
	bh=wnLDdonWkyZNp/LHwDNqvNn4gpunPL+ht6uFy+8qW5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bp23tnjkNZbdx1KfD7p4GklD5vPI9xoG0ZgkQfFz2j0jcuKQLf+W1L143QWJvyOfxa2aRYhaFZYKgy2UuTbS9LhcTl2Zzp+2v8QAwvowLm1tXOgmdlIsjSjZh+LWdt96rNb5f5ZglADKh/fUd9xPDYcw2hDqy6xz+/ZowWU1sSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHT67RHC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23c8f179e1bso29716485ad.1;
        Fri, 25 Jul 2025 12:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753473529; x=1754078329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMMc/d97/e3QXVHvtigBiPuITVHUjn0KlgtvdJ11/nw=;
        b=HHT67RHCAzl/4Vsg27Xqy8caNMtzGLfoOCHCTRm0rrMhut64kg6qvtX4WQXbRm6W1q
         KURVrjCoF7BTHkYDX4+UByHBoJtJvasyP5gVP1sBtAYMdEB4Qnmh9wjNV1BHBMLxvk60
         h4pmn4Srs89vYYXU6JLBvkuy+OQz57miVWWon9JQk2XaUKeBHZe07fwoHxxg7NOxWfFt
         aoI6DYC5l52lLrfcW4/bYkyL5KUetOMFvSxNQEvChVJgQOf39r+nDaIaDZtZ0GJXFDZ8
         H+/HoZ2vKVhisRrhzXAuBLA8bVPgRx27lost6Z/dCti0yPN3HBcKvyAbjg6iHoxEFkSY
         2ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753473529; x=1754078329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMMc/d97/e3QXVHvtigBiPuITVHUjn0KlgtvdJ11/nw=;
        b=jPW2m+fdontj5BPTT2OCMP76GBLppUHsHESqWy33hZzriXc5mAVNz1cNNCd9lyEgXZ
         Vz/lSybqL1B4rsMubfc+vqYWhka+OQM5drpN5OwYXm0V9+zqNLEAaUVxqxYY0jbOeAzT
         FOHi22bMu38NGdtEPz5AwgyoPneBG6Y3wBruWTbfpwfxWdEqgAS+RBY6VHveXPyogCB3
         KlEhDvMJDWEZ/KqCAP4dmxUZBeSvUkg16wrLf5bGbk+ojSpHXUI+6URURGxP0F3cHmek
         xpcvTuuEE5/E6vdqQ9tdhFmWPXXQ1xrPDG1zyVrjkreYrr9rQ2Xvj1Os5q/Zinl5cFgY
         C3vg==
X-Forwarded-Encrypted: i=1; AJvYcCUhUZ8GsEu5meOKt9UfhAXoi6RQ8g1sCGG+8RuuYVWtw1QAsI9xFyKjCs+9br2AwVM4scB0k5eIzR130Pq4@vger.kernel.org, AJvYcCVbbqyhs9jyOSXPFUqdphKQaTpWT0jM2o8JQjSlxO89RVSktCx59XcobbPXZEoHwq0Qgah0KsYzG5+Y@vger.kernel.org, AJvYcCWCtYz06+kkUmicFT8bCxnaGia5/qM6MnPrBC4rLBqGumjNGDq6af4nPuGq2vPXCXOE6SsrbzhVXn/hLJdC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3d3JMJ0O9x8jF+oyCs5gJNd//FQKG+1x6HvgfaQGECVQ3GEP0
	EGR/rJ7ACc7PwfM+mX8oxN0JBZkJpFVybertueN7Jp5ra/LU0z5OZvYqGuxremwCiC8Yaa89re0
	o4DsLJIYv+1ZY6dPGf++APM4MV4QGxak=
X-Gm-Gg: ASbGnctzKwTX6R7jNGlkL90xxYIF/wuHM7D9DGyrQboWyoojO/DFns2xS9NmmsCm6b8
	f7aLnI8uCEM28X6QzVCUw2r4Kt9c4rO6Tga5CpK3Z0umXQJ81zf/jb0DP6Y9/ipfr7pTjzs1d7b
	Zj7wvKdSw/qePWk/lLmifGeg31GK+YBoLrTAY2IyUmLkcV/nsSXVrjPFd4abZe0XArPajI0Puei
	Kvo
X-Google-Smtp-Source: AGHT+IF1wiCjthMJk20IwfyqQIAQUjuJSdoHbUNgqU6TW0zgoWD2fkO35n1lnbbOM1GE7XoyV4Q/L7Y61n0DPG4wGz4=
X-Received: by 2002:a17:903:22c8:b0:235:1706:1ff6 with SMTP id
 d9443c01a7336-23fb2f55dd8mr46833325ad.0.1753473529361; Fri, 25 Jul 2025
 12:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723190308.5945-1-ltykernel@gmail.com> <20250723190308.5945-4-ltykernel@gmail.com>
 <SN6PR02MB4157FC3B69C9E6FB6884CE99D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157FC3B69C9E6FB6884CE99D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Sat, 26 Jul 2025 03:58:12 +0800
X-Gm-Features: Ac12FXyLcIiVLxayLpw0fyM_Cnqrf8qCXkDeFcpC2BpAB3cqtbpaiV0IpcqDlJU
Message-ID: <CAMvTesBqMEs+9qYHLSko9L_YGi_nad4g1o1spOcFe1uqssRQag@mail.gmail.com>
Subject: Re: [RFC PATCH V3 3/4] x86/Hyper-V: Don't use auto-eoi when Secure
 AVIC is available
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
>
> I'm nit-picking, but the patch Subject: line prefix should be "x86/hyperv=
:"
> for consistency with past patches. Note that there's no capitalization
> or dash. I know not everyone is consistent on this if you look at the git=
 log
> for mshyperv.c, but I try to flag it and encourage consistency.
>
> > Hyper-V doesn't support auto-eoi with Secure AVIC.
> > So set the HV_DEPRECATING_AEOI_RECOMMENDED flag
> > to force writing the EIO register after handling an interrupt.
> >
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyp=
erv.c
> > index c78f860419d6..8f029650f16c 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -463,6 +463,8 @@ static void __init ms_hyperv_init_platform(void)
> >                ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
> >
> >       hv_identify_partition_type();
> > +     if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> > +             ms_hyperv.hints |=3D HV_DEPRECATING_AEOI_RECOMMENDED;
> >
> >       if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
> >               hv_nested =3D true;
> > --
> > 2.25.1
> >
>

Hi Michael:
  Thanks for your review. Will update.
--=20
Thanks
Tianyu Lan

