Return-Path: <linux-arch+bounces-3556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519908A0962
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 09:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4F7282408
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 07:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210B613DDB6;
	Thu, 11 Apr 2024 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALAdr+l0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4613DBA8;
	Thu, 11 Apr 2024 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819516; cv=none; b=EjAboDk9LTxJ6HZ4+TVOy77MdzOyci8JUwqzP//81k7YqxrOn2mQ7AcU/dQRVt+ythjfforv3l5uzyyhzhp0yGVTNXlv3TZS8lsjKqn4QBKrPXcYcA91KkoYnINvlaNAzcWlSfAp37kucRg+oJC6Ksa64yqe8YMfefzQciMVW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819516; c=relaxed/simple;
	bh=foAx51dmM/Nc1MbYnYMHtZiVXid4Ya2CqTPwNkd5KJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJPqXFzB95226khYICDx2FXaJcMKqaDBmU4oZtFXmnL7cHFu0YZu5/gG+/itJxP8fIYmsebEbrfgi/eYAdWrVToSjSljp/wm/q9E1JUGhW3NOoL0W1oZ1XINqL2Aa/Gz9VZjEvGIDc9YKeWvZt9KtSzE7KecZoOl/r25SbCurQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALAdr+l0; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dde0b30ebe2so6418370276.0;
        Thu, 11 Apr 2024 00:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712819513; x=1713424313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTHSIMuZ7gmHtraT80hduj6De1QkHuQBkMKb5QVg53s=;
        b=ALAdr+l0yZPbysZv0x1C4ckegg8FMJq6WmadwKlmhHW3RSipYga3zCdIOG2OStcdfR
         4kniwQKrCsmzd849bdbIA/27C7wbmT6YHPTFqydegA8ae3KmVIfJEVsj/NNbDB5drNtD
         UTTjuT4FS+l2OY5nEz9mJrlxTB7MDQZhRSc4huFLHBkS6xsibXUhnaATjhMQNXGbbseP
         9tBxh66XN8rh2FKoVOfLi6kFiJqTkJb3XsgoI7lEQB15uZGAnjCW6JlTX0ytuFRQhGgm
         imMHTc/CrbcU7QtGosx004CZQLKZDgOtJpg0+J3tzyajKCcMIsTSm8jQ6hGE9st06CRX
         SeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819513; x=1713424313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTHSIMuZ7gmHtraT80hduj6De1QkHuQBkMKb5QVg53s=;
        b=LC17VC7zCXpiKevNMMOMO9XmLak/2NnX4FjCA9ZFvH0Qif+Jqxqz+lYbtQ2ehpt8+F
         jNmnRPnPGmr/WqR2JEz6zB70zZaLlKLTRzGVm3g6fwZrVlSR94l352sCB0eVszty1v18
         7OBD3oF1SwD+6+VhVj8TNrGDOu7YodvOxc/Oy73Bm6f4LzcOyHbS8NcL0kl9TSmqqE5a
         6LUZmKjjDRed7NwC7RaxgGLyusMWQr0q3MnHmC0M0ao+I2v4wAGjYNfFhImRpI+3TgpB
         UHEN7n1QZob73WYnQpb9d2ynxyeVzhPR6dW/V7/Fxt6NXRLDq0lu33NBDE9W17JMCbWg
         rr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG8beQpUR9PMLX81QZ4mJnJoaOzJnLMcBTVFomjo59V+uas2fUIrDncP6nXSjjAe0qmz7CjSHt7arrZMQrZOVJ9iHGc7E2EaNPOK22W+QFOI72HUMjTBunObrMcjbQvnWNl05IR6GJqmSTSQW6JT5PHKT1Y7JjBzYr5mC8Y0SLasM/VtP0o9ZZefvqqF7KwSmmQArOYa3fAYl0hw==
X-Gm-Message-State: AOJu0YzGZh5zhJcMcHY96pszbIzTN4YA7by/k4zOLyrHk65Tm5kNntLR
	gEKJUXphiNMiytBbx83/hTrhcUeDBI20idL60Nz5u5cgKBlz8UUuPtOCwiw3n1CEfah1i5DLYy+
	1BQSTEH0U8AECcC5Z+Bu/iSIx1y4=
X-Google-Smtp-Source: AGHT+IFrTcyKKJbRPGiPRaGZMd0mdJY3O5OdCMRcLAvdIxKOb5KeqUye7ddtBV9WNYbK4UH+ovB44WPSoycCvCmtq0Q=
X-Received: by 2002:a25:814d:0:b0:dcd:1d44:f6c1 with SMTP id
 j13-20020a25814d000000b00dcd1d44f6c1mr4641650ybm.16.1712819513073; Thu, 11
 Apr 2024 00:11:53 -0700 (PDT)
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
 <871q7md0ak.ffs@tglx> <CAF2d9jikELOQa_9Kk+oF_=_7NZTn9DuAw=s9KQR6-EfWTiW5RQ@mail.gmail.com>
In-Reply-To: <CAF2d9jikELOQa_9Kk+oF_=_7NZTn9DuAw=s9KQR6-EfWTiW5RQ@mail.gmail.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Thu, 11 Apr 2024 10:11:41 +0300
Message-ID: <CAMuE1bFkmj70DO66PfvBPjM1d_JDEwTkOyz6o6wO_C0uyJ_0zw@mail.gmail.com>
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
To: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, richardcochran@gmail.com, luto@kernel.org, 
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

Hi Mahesh
What is the status of your patch?
if your patch is upstreamed , then it will have all I need.
But, If not , I will upstream my patch.
BR,

On Thu, Apr 11, 2024 at 5:56=E2=80=AFAM Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=
=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=
=E0=A4=B0)
<maheshb@google.com> wrote:
>
> On Wed, Apr 3, 2024 at 6:48=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> >
> > On Tue, Apr 02 2024 at 16:37, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=
=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=
=B0) wrote:
> > > On Tue, Apr 2, 2024 at 3:37=E2=80=AFPM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> > > The modification that you have proposed (in a couple of posts back)
> > > would work but it's still not ideal since the pre/post ts are not
> > > close enough as they are currently  (properly implemented!)
> > > gettimex64() would have. The only way to do that would be to have
> > > another ioctl as I have proposed which is a superset of current
> > > gettimex64 and pre-post collection is the closest possible.
> >
> > Errm. What I posted as sketch _is_ using gettimex64() with the extra
> > twist of the flag vs. a clockid (which is an implementation detail) and
> > the difference that I carry the information in ptp_system_timestamp
> > instead of needing a new argument clockid to all existing callbacks
> > because the modification to ptp_read_prets() and postts() will just be
> > sufficient, no?
> >
> OK, that makes sense.
>
> > For the case where the driver does not provide gettimex64() then the
> > extension of the original offset ioctl is still providing a better
> > mechanism than the proposed syscall.
> >
> > I also clearly said that all drivers should be converted over to
> > gettimex64().
> >
> I agree. Honestly that should have been mandatory and
> ptp_register_clock() should fail otherwise! Probably should have been
> part of gettimex64 implementation :(
>
> I don't think we can do anything other than just hoping all driver
> implementations include gettimex64 implementation.
>
> > > Having said that, the 'flag' modification proposal is a good backup
> > > for the drivers that don't have good implementation (close enough but
> > > not ideal). Also, you don't need a new ioctl-op. So if we really want
> > > precision, I believe, we need a new ioctl op (with supporting
> > > implementation similar to the mlx4 code above). but we want to save
> > > the new ioctl-op and have less precision then proposed modification
> > > would work fine.
> >
> > I disagree. The existing gettimex64() is good enough if the driver
> > implements it correctly today. If not then those drivers need to be
> > fixed independent of this.
> >
> > So assumed that a driver does:
> >
> > gettimex64()
> >    ptp_prets(sts);
> >    read_clock();
> >    ptp_postts(sts);
> >
> > today then having:
> >
> > static inline void ptp_read_system_prets(struct ptp_system_timestamp *s=
ts)
> > {
> >         if (sts) {
> >                 if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
> >                         ktime_get_raw_ts64(&sts->pre_ts);
> >                 else
> >                         ktime_get_real_ts64(&sts->pre_ts);
> >         }
> > }
> >
> > static inline void ptp_read_system_postts(struct ptp_system_timestamp *=
sts)
> > {
> >         if (sts) {
> >                 if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
> >                         ktime_get_raw_ts64(&sts->post_ts);
> >                 else
> >                         ktime_get_real_ts64(&sts->post_ts);
> >         }
> > }
> >
> > or
> >
> > static inline void ptp_read_system_prets(struct ptp_system_timestamp *s=
ts)
> > {
> >         if (sts) {
> >                 switch (sts->clockid) {
> >                 case CLOCK_MONOTONIC_RAW:
> >                         time_get_raw_ts64(&sts->pre_ts);
> >                         break;
> >                 case CLOCK_REALTIME:
> >                         ktime_get_real_ts64(&sts->pre_ts);
> >                         break;
> >                 }
> >         }
> > }
> >
> > static inline void ptp_read_system_postts(struct ptp_system_timestamp *=
sts)
> > {
> >         if (sts) {
> >                 switch (sts->clockid) {
> >                 case CLOCK_MONOTONIC_RAW:
> >                         time_get_raw_ts64(&sts->post_ts);
> >                         break;
> >                 case CLOCK_REALTIME:
> >                         ktime_get_real_ts64(&sts->post_ts);
> >                         break;
> >                 }
> >         }
> > }
> >
> > is doing the exact same thing as your proposal but without touching any
> > driver which implements gettimex64() correctly at all.
> >
> I see. Yes, this makes sense.
>
> > While your proposal requires to touch every single driver for no reason=
,
> > no?
> >
> > It is just an implementation detail whether you use a flag or a
> > clockid. You can carry the clockid for the clocks which actually can be
> > read in that context in a reserved field of PTP_SYS_OFFSET_EXTENDED:
> >
> > struct ptp_sys_offset_extended {
> >         unsigned int    n_samples; /* Desired number of measurements. *=
/
> >         clockid_t       clockid;
> >         unsigned int    rsv[2];    /* Reserved for future use. */
> > };
> >
> > and in the IOCTL:
> >
> >         if (extoff->clockid !=3D CLOCK_MONOTONIC_RAW)
> >                 return -EINVAL;
> >
> >         sts.clockid =3D extoff->clockid;
> >
> > and it all just works, no?
> >
> Yes, this should work. However, I didn't check if struct
> ptp_system_timestamp is used in some other context.
>
> > I have no problem to decide that PTP_SYS_OFFSET will not get this
> > treatment and the drivers have to be converted over to
> > PTP_SYS_OFFSET_EXTENDED.
> >
> > But adding yet another callback just to carry a clockid as argument is =
a
> > more than pointless exercise as I demonstrated.
> >
> Agreed. As I said, I thought we cannot change the gettimex64() without
> breaking the compatibility but the fact that CLOCK_REALTIME is "0"
> works well for the backward compatibility case.
>
> I can spin up an updated patch/series that updates gettimex64
> implementation instead of adding a new ioctl-op If you all agree.
>
> thanks,
> --mahesh..
>
> > Thanks,
> >
> >         tglx

