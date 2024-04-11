Return-Path: <linux-arch+bounces-3555-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 643948A0642
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 04:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE600B2148D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 02:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C80013B2BA;
	Thu, 11 Apr 2024 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxT+y0HZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465DA13B2A9
	for <linux-arch@vger.kernel.org>; Thu, 11 Apr 2024 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804181; cv=none; b=Mf5rfeqdiIvb3KwWa1zB8wpcdPP3eAPjZ2jxN0MGLQmhVQh+4i/hrZACWgwdwzTu9t37FUpevFQKhBrV1KI+TXhKqYU+DAhrAnRKfZplewIxW0b9DiMNPPR4euYe6lpRNrbn6HkQbO/FuujWOCZvTFYdLJpAle88Op0zsqIhIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804181; c=relaxed/simple;
	bh=jx8+ooV5my4Q6K7euqhV6oG0a3jRIgwqYetTzXsy+hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O13JU/azzRVAQOVJ3r+QIRTmpJ3T0JYnsvZ/iVTzXGO40fVu0pBaHv8p5g0kQncGtF2ZbuagtB0OAa68luur6Nm294Sr8LdiwBQ9KzbwcMp2Lq8C55G3JZaYwzaBUxFwdn3mO1IHIc5tFocc3+KbYULu8bjESLRbahLiyLj9nDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxT+y0HZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3458b699d6cso1911442f8f.0
        for <linux-arch@vger.kernel.org>; Wed, 10 Apr 2024 19:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712804178; x=1713408978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qbyf/euTmiNGW8pvKkKUHn4sW3bbcSI8r8fIchG044=;
        b=BxT+y0HZG4+D+BsULeg0XvWU4YRV5UyVST0by3wZXiN/CiEMI65tYi1lruUgmTiRMs
         9snjaD8QvgqJMIxoSO0jpgf2FYpqwL4ZpHT9JKUTR1ac7xrxR4hv81y1JDjkk5elHpEP
         gt6pxVMo/9Z4qx46B0gPSd9YY6OOLWnY+GWzCAfJpPezF4sXTnWrXACD1EiDR2WmfLJ0
         /hVfHDW4R/bFuTm7xq0l6KOe1u9pnojoyukTZd+G+V38yUmj3c+0WEZB6qNvqSrwEtFh
         BA12LKqzzyghgIjZhFdvv48jgDOAJV3g41nhCjnpXufzLeykUiYMyAT9lVsff/lSKBii
         KDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712804178; x=1713408978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qbyf/euTmiNGW8pvKkKUHn4sW3bbcSI8r8fIchG044=;
        b=WXG3g/rGl4vXjt99hoqW9FKm8OSwef+xmfvtlUWY/BO8BgrTKy+eCTrbEfqXg8f0g6
         gxFjIyo7xnVRLroOE9d2dFCJmoJ2DRZaCC5rJ4rX+GA+j/JKznD1FQoeZUm8UtcIa0ab
         8m4uGXsdrJySG2hzpexe7YOxoRk+mcwPEEMOL90PIZkEONPVhy7AEAv5ZYqSqHdeKFVn
         TO5FqoTvJO9jj9e6zBMPO7BoVSiAVTYiZkJ5yt12a7ec45uJgQzXSHqZ/PdMDS1LU8xH
         xmXFruMDzSIjBhEpTYLPsTtYANMlFn8DFxhB9D1pZ7ZIkzuk5YnfFAn9QjnaVGqrzMrS
         Ne8g==
X-Forwarded-Encrypted: i=1; AJvYcCVaNeviux5toOmErpb7PYfyK3RNzUlJ9yjGG5qE2jG766sVNxZHDl3pObBpKQYjgTX11wmwFpsRIZ7iF9hHgwgHhP9X0MVc4/Dz0w==
X-Gm-Message-State: AOJu0YwNXlnsscD92zri4nPBaSJ0AF4itNbkz0HcNZ2C1e3fmgpTsoZq
	IPiAcIidsXjFoVx+9TELHh2g/sd6VJfq4JbFLNAHRa9Bw6CcdkPAepszsWnPqvt4pZhHWhZ9cI6
	xZeQNMyBY6/PeW/PhOT7tslx5qcAZprADdxxK
X-Google-Smtp-Source: AGHT+IFxuXt9UBEWXXgbRU8fOZj4UJ+rfzcNBZ+VF99Gt2Ea8Ur3sokyKWUs7w62nRqlpaPSw/4OIFVwxPf1qq70f9k=
X-Received: by 2002:a5d:526a:0:b0:342:61ee:bee1 with SMTP id
 l10-20020a5d526a000000b0034261eebee1mr2658282wrc.23.1712804177444; Wed, 10
 Apr 2024 19:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
 <878r29hjds.ffs@tglx> <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
 <87o7asdd65.ffs@tglx> <CAF2d9jjA8iM1AoPUhQPK62tdd7gPnCnt51f_NMhOAs546rU3dA@mail.gmail.com>
 <87il10ce1g.ffs@tglx> <CAF2d9jj6km7aVSqgcOE-b-A-WDH2TJNGzGy-5MRyw5HrzbqhaA@mail.gmail.com>
 <877chfcrx3.ffs@tglx> <CAF2d9jjg0PEgPorXdrBHVkvz-fmUV7UXUPqnpQGVEvgXTpHY0A@mail.gmail.com>
 <871q7md0ak.ffs@tglx>
In-Reply-To: <871q7md0ak.ffs@tglx>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Wed, 10 Apr 2024 19:55:50 -0700
Message-ID: <CAF2d9jikELOQa_9Kk+oF_=_7NZTn9DuAw=s9KQR6-EfWTiW5RQ@mail.gmail.com>
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com, luto@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, arnd@arndb.de, geert@linux-m68k.org, peterz@infradead.org, 
	hannes@cmpxchg.org, sohil.mehta@intel.com, rick.p.edgecombe@intel.com, 
	nphamcs@gmail.com, palmer@sifive.com, keescook@chromium.org, 
	legion@kernel.org, mark.rutland@arm.com, mszeredi@redhat.com, 
	casey@schaufler-ca.com, reibax@gmail.com, davem@davemloft.net, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 6:48=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Tue, Apr 02 2024 at 16:37, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=
=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=
=B0) wrote:
> > On Tue, Apr 2, 2024 at 3:37=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> > The modification that you have proposed (in a couple of posts back)
> > would work but it's still not ideal since the pre/post ts are not
> > close enough as they are currently  (properly implemented!)
> > gettimex64() would have. The only way to do that would be to have
> > another ioctl as I have proposed which is a superset of current
> > gettimex64 and pre-post collection is the closest possible.
>
> Errm. What I posted as sketch _is_ using gettimex64() with the extra
> twist of the flag vs. a clockid (which is an implementation detail) and
> the difference that I carry the information in ptp_system_timestamp
> instead of needing a new argument clockid to all existing callbacks
> because the modification to ptp_read_prets() and postts() will just be
> sufficient, no?
>
OK, that makes sense.

> For the case where the driver does not provide gettimex64() then the
> extension of the original offset ioctl is still providing a better
> mechanism than the proposed syscall.
>
> I also clearly said that all drivers should be converted over to
> gettimex64().
>
I agree. Honestly that should have been mandatory and
ptp_register_clock() should fail otherwise! Probably should have been
part of gettimex64 implementation :(

I don't think we can do anything other than just hoping all driver
implementations include gettimex64 implementation.

> > Having said that, the 'flag' modification proposal is a good backup
> > for the drivers that don't have good implementation (close enough but
> > not ideal). Also, you don't need a new ioctl-op. So if we really want
> > precision, I believe, we need a new ioctl op (with supporting
> > implementation similar to the mlx4 code above). but we want to save
> > the new ioctl-op and have less precision then proposed modification
> > would work fine.
>
> I disagree. The existing gettimex64() is good enough if the driver
> implements it correctly today. If not then those drivers need to be
> fixed independent of this.
>
> So assumed that a driver does:
>
> gettimex64()
>    ptp_prets(sts);
>    read_clock();
>    ptp_postts(sts);
>
> today then having:
>
> static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts=
)
> {
>         if (sts) {
>                 if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
>                         ktime_get_raw_ts64(&sts->pre_ts);
>                 else
>                         ktime_get_real_ts64(&sts->pre_ts);
>         }
> }
>
> static inline void ptp_read_system_postts(struct ptp_system_timestamp *st=
s)
> {
>         if (sts) {
>                 if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
>                         ktime_get_raw_ts64(&sts->post_ts);
>                 else
>                         ktime_get_real_ts64(&sts->post_ts);
>         }
> }
>
> or
>
> static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts=
)
> {
>         if (sts) {
>                 switch (sts->clockid) {
>                 case CLOCK_MONOTONIC_RAW:
>                         time_get_raw_ts64(&sts->pre_ts);
>                         break;
>                 case CLOCK_REALTIME:
>                         ktime_get_real_ts64(&sts->pre_ts);
>                         break;
>                 }
>         }
> }
>
> static inline void ptp_read_system_postts(struct ptp_system_timestamp *st=
s)
> {
>         if (sts) {
>                 switch (sts->clockid) {
>                 case CLOCK_MONOTONIC_RAW:
>                         time_get_raw_ts64(&sts->post_ts);
>                         break;
>                 case CLOCK_REALTIME:
>                         ktime_get_real_ts64(&sts->post_ts);
>                         break;
>                 }
>         }
> }
>
> is doing the exact same thing as your proposal but without touching any
> driver which implements gettimex64() correctly at all.
>
I see. Yes, this makes sense.

> While your proposal requires to touch every single driver for no reason,
> no?
>
> It is just an implementation detail whether you use a flag or a
> clockid. You can carry the clockid for the clocks which actually can be
> read in that context in a reserved field of PTP_SYS_OFFSET_EXTENDED:
>
> struct ptp_sys_offset_extended {
>         unsigned int    n_samples; /* Desired number of measurements. */
>         clockid_t       clockid;
>         unsigned int    rsv[2];    /* Reserved for future use. */
> };
>
> and in the IOCTL:
>
>         if (extoff->clockid !=3D CLOCK_MONOTONIC_RAW)
>                 return -EINVAL;
>
>         sts.clockid =3D extoff->clockid;
>
> and it all just works, no?
>
Yes, this should work. However, I didn't check if struct
ptp_system_timestamp is used in some other context.

> I have no problem to decide that PTP_SYS_OFFSET will not get this
> treatment and the drivers have to be converted over to
> PTP_SYS_OFFSET_EXTENDED.
>
> But adding yet another callback just to carry a clockid as argument is a
> more than pointless exercise as I demonstrated.
>
Agreed. As I said, I thought we cannot change the gettimex64() without
breaking the compatibility but the fact that CLOCK_REALTIME is "0"
works well for the backward compatibility case.

I can spin up an updated patch/series that updates gettimex64
implementation instead of adding a new ioctl-op If you all agree.

thanks,
--mahesh..

> Thanks,
>
>         tglx

