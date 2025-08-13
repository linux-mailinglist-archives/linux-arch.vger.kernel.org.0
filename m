Return-Path: <linux-arch+bounces-13158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DACEB24CE9
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 17:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382323B9DEF
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 15:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC79166F0C;
	Wed, 13 Aug 2025 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPn287vW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAC13D521;
	Wed, 13 Aug 2025 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097615; cv=none; b=Evucz+47rxUt3sb0B8LqqjBadLnr2XaRnaLu1ziqsrFAIJHLlHv88Ls2AYlg4C/TrFgLg59RZlqBTTnT8xfTFMqtAa6x3m2r5Y6MRBYDhvkIMYq4jhgdUORAql6duUFJ52TuVP6tXaEfptYgsI6BuZcad4CPlCkOW3CyfNLFDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097615; c=relaxed/simple;
	bh=n8uCtdj/fj0Tro3Vd8lry5aqPnmCV8xzd5v6829fC1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PENhhe5ebeSiKoMkRmvASdjDTV72z/e99yLhvJfxr7Nu2wqiBvN8oLz+CCj5Imj4UVuFdirzOLTmPJLyKBx8/rvPTK+DpKSzn3Rd5lPjDBqtYMRbWr0Wshu+6apmgBL11RdGBJDLX3BsOKOzqXJYvb3G9/uir1PqTJ12QEDWqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPn287vW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23ffa7b3b30so65326755ad.1;
        Wed, 13 Aug 2025 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755097614; x=1755702414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwVojY45JYi9vnlro6DBkZxNkkEnRXLJVTFQe0/ZUzc=;
        b=gPn287vWwZizcZBPmAev0w2WTAshNAlBl2/fMIb4pDtqzaDPskxhlg7aqmxnFWMpu3
         MnbFIXIMrtAp94Qy9ykLdR143/Wd4TGe45cNZTKZB3MVD6sz3CNlVTBdT7WhPO/ygn80
         x4sDy68vIKIxODXPF0EgUSG+TFwcWSNQTXwUKxYdsROpTrSggLsjW7TfrTzDwzosDDeo
         zZw94LhtcbFj0lr25tMH0RZ5lbhHsqVz96WfiHJ6mg+g5pQN+0eVvT4yrhRi4OvBKB7D
         9hYbJ94D7jPXgf6/Js+hL2jJ/pCONjI199c4vmkPHnfLSXQTA88bsiS/z5M0iR2maDoJ
         hx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097614; x=1755702414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwVojY45JYi9vnlro6DBkZxNkkEnRXLJVTFQe0/ZUzc=;
        b=PDUWXtB6Ny/8FNm2oRVjdvfz8poORD9XFqiuMFIm+8fS47LemgbFPSI1sOi/iltQer
         5G1JYYM4VUnvS+/1h0lmJ7s52u+Me/55aYz7+xhjL+27H/YMMwadQ9d9nQENnd04Ea4D
         vWiatVSZ9bZ/cf1A5uSyqQhIOCOkM6KR7gascoW6rrYlCnLjbZiRniKT9Hav2f0ZbUcz
         /YJbo33HqYbGy6It9C3WHToPkopFIEeVV+LGn7HAc4X/ucDUJfWpbMBjPgP889Aqtc+F
         oMbEng8dtzCmXPEvfF0q5Aoa7nY/7KX0YONOjAa5CxuF/RVvA3NyKjuWTwE3f4NQSMlN
         71Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWtcnmVSo9BqDtA6lx31iGvj0mFuJP4EX+UGqnvKkjuJsFbdEUoLnk55UyEAXhROWh+s+faIGu1SLmo@vger.kernel.org, AJvYcCXY9GWUFg5qNDTDE1R6/z9uQ2IQ5TFgfrTC3V0thiTNlOG5u2k3rGtuKA2xwlSEJCa/Qp56cErULk4CE3Ho@vger.kernel.org, AJvYcCXtfyiluFGcerQAn10Aji1wM/JzAeYLieDNZuKJ79R4pL7IDz1roEG5F4Wyf5vS18p2WzxW/Y1+WFlLkoYS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3447UJxOnSyckoO6BnE0jLDuR4i4aV+qSvLcLeWjeTWjB5Bk
	jS0nc/jqaS0+Mewhi6TgWZ83HMi6k3CC0Ywb/3YZ9DcmIEFqb6HAuGNsxa1tL1K9VirmFrJBsS2
	8Fv9BtMYhli7EyOPqyFZL1wwy/WzCfp4=
X-Gm-Gg: ASbGncsqnfWcWWCMMmuQajnO5XyF8hkofrgbxymuKjav50KJXRi138gLyxLHP96CGSI
	GPk9Hgnq7cnZyaMDudyjJaxw1GwLnwPE4bu+p9IhiJ79qSb201lkWhHg8ivLUUK+ze5i2p0X/gP
	NyCt+2qOSnBJtIi3oUH8et2+R+yHkHRhVBt6PldpE1XQbey2Q1yu4K5cTeUcXAn7Ot0UeM6vCph
	3rbMcgztX3uf2c=
X-Google-Smtp-Source: AGHT+IGt5jM8KsgQvWAKCRUjcyHUsZiq1XgOIt5+9OeSmltRiwmZ/K5rPALSJY0RpCLNr2U8hkFRnStS9IUuj/2aXQU=
X-Received: by 2002:a17:903:120e:b0:240:3f0d:f470 with SMTP id
 d9443c01a7336-2430d10d3d4mr56021575ad.20.1755097613629; Wed, 13 Aug 2025
 08:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806121855.442103-1-ltykernel@gmail.com> <aJvSfmmArKeEsD01@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <CAMvTesBngjSrvd1Zuto94NzZ-RztnAs3q9LMJohC4OepnoQRhA@mail.gmail.com> <aJyj9XkVQRxZxc-f@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
In-Reply-To: <aJyj9XkVQRxZxc-f@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Wed, 13 Aug 2025 23:06:17 +0800
X-Gm-Features: Ac12FXw47C1yoYIFa9zPfBXImnYKefzLV1z88UdGSSmNC8qIQsN3z6W5iw8FsU8
Message-ID: <CAMvTesBH-NZAQT_uTFf_NJUz4xpNjurOBJsS6QvSrAFBKtb7nA@mail.gmail.com>
Subject: Re: [RFC PATCH V6 0/4 Resend] x86/Hyper-V: Add AMD Secure AVIC for
 Hyper-V platform
To: Wei Liu <wei.liu@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, 
	Neeraj.Upadhyay@amd.com, kvijayab@amd.com, Tianyu Lan <tiala@microsoft.com>, 
	linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 10:40=E2=80=AFPM Wei Liu <wei.liu@kernel.org> wrote=
:
>
> On Wed, Aug 13, 2025 at 07:44:09PM +0800, Tianyu Lan wrote:
> > On Wed, Aug 13, 2025 at 7:47=E2=80=AFAM Wei Liu <wei.liu@kernel.org> wr=
ote:
> > >
> > > On Wed, Aug 06, 2025 at 08:18:51PM +0800, Tianyu Lan wrote:
> > > > From: Tianyu Lan <tiala@microsoft.com>
> > > [...]
> > > > Tianyu Lan (4):
> > > >   x86/hyperv: Don't use hv apic driver when Secure AVIC is availabl=
e
> > > >   Drivers: hv: Allow vmbus message synic interrupt injected from Hy=
per-V
> > > >   x86/hyperv: Don't use auto-eoi when Secure AVIC is available
> > > >   x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts
> > >
> > > Are they still RFC? They look like ready to be merged.
> > >
> > > Wei
> > Hi Wei:
> >             This patchset depends on the AMD Secure AVIC patchset. If w=
e just
> > add hv_enable_coco_interrupt() as a dummy function.  If It's acceptable=
,
> > I may send out  a new version for merge.
>
> Let's wait for the AMD Secure AVIC patchset to be merged first. You can
> then repost without the RFC tag.
>
> Thanks,
> Wei
>
> > --
> > Thanks
> > Tianyu Lan

Sure. I got it.  Thanks for your suggestion.and will update patches soon.
--
Thanks
Tianyu Lan

