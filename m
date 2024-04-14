Return-Path: <linux-arch+bounces-3657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CD88A4243
	for <lists+linux-arch@lfdr.de>; Sun, 14 Apr 2024 14:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364082813BE
	for <lists+linux-arch@lfdr.de>; Sun, 14 Apr 2024 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36AD3D552;
	Sun, 14 Apr 2024 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVsDCXHA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB11DFFC;
	Sun, 14 Apr 2024 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713097375; cv=none; b=m8mFxqLpKss+bA1S/18O/wwY35qXejd84MtuRFRGrVlANGmxC0zAgyEBFvNQfx8yMCAUg3MmqKj4Im1SPGdE/niHFXHZHfSvgwzMMLo7njUQrprQE/uqF+SthpQiI8T+0b6Z7GfnTZJCJYNbBAWmPxFwq5Yab/NvgU9rnJZWTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713097375; c=relaxed/simple;
	bh=NC5Ytsxcs11gEIqHytslMyEn9aXFalZkOWXm5iVXEVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyey5y7q8KatJj1lPMVB/O7EErPDQpO3ZvM+qadbSrddPmkCLsWC+fo6svX93NXo/lnnTZRtvG95FWTN2sMe4zyq70gyqunPeuNEHKky+FQ0Pz+pFzhIpz2qxiXxrBWkMHNB1T5N5P5lBmQAPVOYs30CNK7MZ7WqvEygB51FskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVsDCXHA; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc73148611so2522799276.3;
        Sun, 14 Apr 2024 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713097373; x=1713702173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzrMyAVHgTkg0bJxNTlEU4zupCONFG+gsbkWcp1riEA=;
        b=iVsDCXHAnnxT0bBCFZuJYkBeGneggM5fhaDxl9gFatiRwoO1fCi1oUc/QY41Nq5bWR
         TcnKKWMBL/tJVTV9RhYff++6XdlCJeXCNmkvWytX4iPmjmy5x7i/89SoM1OMNx0MHbtb
         Eda3gZ3VWvSBTuic36JUMxBVBGAgBJxwSwKeUfxwW0cTmrCRvwz1aPQmLgKwC6seSPaW
         yCqQhY+xRm4yqidTvA3uwsQGeh6cL7sPC2i7cVvZJIlaGkKRHydJdfUbBKqxokUlGZP5
         e9AiXDa0oF0Euq+mLYTEtCa3mSye+U6FhS5SD9H1a0X55YgL8rgvgNbqxsleO9mw/iNr
         eEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713097373; x=1713702173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzrMyAVHgTkg0bJxNTlEU4zupCONFG+gsbkWcp1riEA=;
        b=MeZ3C7dWx/cIMk8UQELbU8l+2o/tqtGG2CgVw9YgTx1KZ/QVEtzBL9bzzvMxC/+ao3
         OZi5T5kHGeFNyK6Cwzy6pbHcG808rw7ZTJPbSV1pXeFpaEDV6LEz22FwIbqeEM4kod6m
         +ljJo+O6Eyxt1P6F7/REuKGWmJVLt346XzP5/UEP79pEun8xL/4wKmU2LZ2/jbE2/IYA
         Un4t+g+GfMqpny9Kqnf44bxIcqtelQSWLf1b0kbTdhaOmxNc0+0PVgxe+zLSCT36xpq6
         B/RukasPymlm2jU1RFAO38+GGBMSX81gU8jGRp9CFKLNjrw34DztZaqvd1v7tfcw/Aqp
         pIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu0xcbsF1J1uQAyv6MIhhc2vyQIje0W2JT0YpC7lAkOK3GslQyY9rd4WOjzFG+ivAU/CynQQ+zpDwWGaS2kHN7LwQ4hzLAo18kUE80j8UV7bOvunk8onGzVB+CcVA80RBVWWDzqGfF+JV4oXALuMgah1ZwRIIM7u3qeOyaIu8Ia8rsltqp7INOsUaYXciA/+2F1dNOJOzW765cCA==
X-Gm-Message-State: AOJu0YwUu217tc2ff4Mleb5IuEqapyM3XwmXckYhl6/nGgaUUKjrsSRu
	3G8SN9Cr85D+H5sAr76sYUyiWQi+CwS4Yr9l63ed2/U3gaN7vlD9c5i8+ZiDjSRbkB9C/naG+y9
	wlFQYMjWj5HOTB504YP/y824xde8=
X-Google-Smtp-Source: AGHT+IET4c6lp6u8b29olUcd6KiXLc13oybfXdSTTRAcRTcMuuSYBNk2BNVa+HAdDLKFCyH6rSTPX9LPKKUUTnlQEtY=
X-Received: by 2002:a25:8c10:0:b0:dc7:443d:d9da with SMTP id
 k16-20020a258c10000000b00dc7443dd9damr7424572ybl.4.1713097372924; Sun, 14 Apr
 2024 05:22:52 -0700 (PDT)
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
 <CAMuE1bFkmj70DO66PfvBPjM1d_JDEwTkOyz6o6wO_C0uyJ_0zw@mail.gmail.com> <CAF2d9jj-kwmP+LWBBmU41Yhpmc0zE1w9UAoRHj=j-wLBSOwU5Q@mail.gmail.com>
In-Reply-To: <CAF2d9jj-kwmP+LWBBmU41Yhpmc0zE1w9UAoRHj=j-wLBSOwU5Q@mail.gmail.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 14 Apr 2024 15:22:41 +0300
Message-ID: <CAMuE1bFomKFTz+E9=4=F8r0DOoPdjZYt4ofubJgXGP0rpEjnqA@mail.gmail.com>
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

On Thu, Apr 11, 2024 at 7:34=E2=80=AFPM Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=
=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=
=E0=A4=B0)
<maheshb@google.com> wrote:
>
> On Thu, Apr 11, 2024 at 12:11=E2=80=AFAM Sagi Maimon <maimon.sagi@gmail.c=
om> wrote:
> >
> > Hi Mahesh
> > What is the status of your patch?
> > if your patch is upstreamed , then it will have all I need.
> > But, If not , I will upstream my patch.
> > BR,
> >
> Hi Sagi,
>
> If you want to pursue the syscall option, then those are tangential
> and please go ahead. (I cannot stop you!)
> I'm interested in getting the "tight sandwich timestamps" that
> gettimex64() ioctl offers and I would want enhancements to
> gettimex64() done the way it was discussed in the later half of this
> thread. If you want to sign-up for that please let me know.
Hi Mahesh
I do need to modify the  PTP_SYS_OFFSET_EXTENDED ioctl for cases which
gettimex64
not supported by the driver (look at Thomas suggestion), but I need
your changes in ptp_read_system_prets.
I like to add my changes above your changes, so we won't do duplicate work.
please show me your latest patch and the status of it
Once you have upstream yours , I will add my changes on the next patch.
BR
Sagi

>
> thanks,
> --mahesh..
>
>
> > On Thu, Apr 11, 2024 at 5:56=E2=80=AFAM Mahesh Bandewar (=E0=A4=AE=E0=
=A4=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=
=A4=BE=E0=A4=B0)
> > <maheshb@google.com> wrote:
> > >
> > > On Wed, Apr 3, 2024 at 6:48=E2=80=AFAM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> > > >
> > > > On Tue, Apr 02 2024 at 16:37, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=
=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=
=E0=A4=B0) wrote:
> > > > > On Tue, Apr 2, 2024 at 3:37=E2=80=AFPM Thomas Gleixner <tglx@linu=
tronix.de> wrote:
> > > > > The modification that you have proposed (in a couple of posts bac=
k)
> > > > > would work but it's still not ideal since the pre/post ts are not
> > > > > close enough as they are currently  (properly implemented!)
> > > > > gettimex64() would have. The only way to do that would be to have
> > > > > another ioctl as I have proposed which is a superset of current
> > > > > gettimex64 and pre-post collection is the closest possible.
> > > >
> > > > Errm. What I posted as sketch _is_ using gettimex64() with the extr=
a
> > > > twist of the flag vs. a clockid (which is an implementation detail)=
 and
> > > > the difference that I carry the information in ptp_system_timestamp
> > > > instead of needing a new argument clockid to all existing callbacks
> > > > because the modification to ptp_read_prets() and postts() will just=
 be
> > > > sufficient, no?
> > > >
> > > OK, that makes sense.
> > >
> > > > For the case where the driver does not provide gettimex64() then th=
e
> > > > extension of the original offset ioctl is still providing a better
> > > > mechanism than the proposed syscall.
> > > >
> > > > I also clearly said that all drivers should be converted over to
> > > > gettimex64().
> > > >
> > > I agree. Honestly that should have been mandatory and
> > > ptp_register_clock() should fail otherwise! Probably should have been
> > > part of gettimex64 implementation :(
> > >
> > > I don't think we can do anything other than just hoping all driver
> > > implementations include gettimex64 implementation.
> > >
> > > > > Having said that, the 'flag' modification proposal is a good back=
up
> > > > > for the drivers that don't have good implementation (close enough=
 but
> > > > > not ideal). Also, you don't need a new ioctl-op. So if we really =
want
> > > > > precision, I believe, we need a new ioctl op (with supporting
> > > > > implementation similar to the mlx4 code above). but we want to sa=
ve
> > > > > the new ioctl-op and have less precision then proposed modificati=
on
> > > > > would work fine.
> > > >
> > > > I disagree. The existing gettimex64() is good enough if the driver
> > > > implements it correctly today. If not then those drivers need to be
> > > > fixed independent of this.
> > > >
> > > > So assumed that a driver does:
> > > >
> > > > gettimex64()
> > > >    ptp_prets(sts);
> > > >    read_clock();
> > > >    ptp_postts(sts);
> > > >
> > > > today then having:
> > > >
> > > > static inline void ptp_read_system_prets(struct ptp_system_timestam=
p *sts)
> > > > {
> > > >         if (sts) {
> > > >                 if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
> > > >                         ktime_get_raw_ts64(&sts->pre_ts);
> > > >                 else
> > > >                         ktime_get_real_ts64(&sts->pre_ts);
> > > >         }
> > > > }
> > > >
> > > > static inline void ptp_read_system_postts(struct ptp_system_timesta=
mp *sts)
> > > > {
> > > >         if (sts) {
> > > >                 if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
> > > >                         ktime_get_raw_ts64(&sts->post_ts);
> > > >                 else
> > > >                         ktime_get_real_ts64(&sts->post_ts);
> > > >         }
> > > > }
> > > >
> > > > or
> > > >
> > > > static inline void ptp_read_system_prets(struct ptp_system_timestam=
p *sts)
> > > > {
> > > >         if (sts) {
> > > >                 switch (sts->clockid) {
> > > >                 case CLOCK_MONOTONIC_RAW:
> > > >                         time_get_raw_ts64(&sts->pre_ts);
> > > >                         break;
> > > >                 case CLOCK_REALTIME:
> > > >                         ktime_get_real_ts64(&sts->pre_ts);
> > > >                         break;
> > > >                 }
> > > >         }
> > > > }
> > > >
> > > > static inline void ptp_read_system_postts(struct ptp_system_timesta=
mp *sts)
> > > > {
> > > >         if (sts) {
> > > >                 switch (sts->clockid) {
> > > >                 case CLOCK_MONOTONIC_RAW:
> > > >                         time_get_raw_ts64(&sts->post_ts);
> > > >                         break;
> > > >                 case CLOCK_REALTIME:
> > > >                         ktime_get_real_ts64(&sts->post_ts);
> > > >                         break;
> > > >                 }
> > > >         }
> > > > }
> > > >
> > > > is doing the exact same thing as your proposal but without touching=
 any
> > > > driver which implements gettimex64() correctly at all.
> > > >
> > > I see. Yes, this makes sense.
> > >
> > > > While your proposal requires to touch every single driver for no re=
ason,
> > > > no?
> > > >
> > > > It is just an implementation detail whether you use a flag or a
> > > > clockid. You can carry the clockid for the clocks which actually ca=
n be
> > > > read in that context in a reserved field of PTP_SYS_OFFSET_EXTENDED=
:
> > > >
> > > > struct ptp_sys_offset_extended {
> > > >         unsigned int    n_samples; /* Desired number of measurement=
s. */
> > > >         clockid_t       clockid;
> > > >         unsigned int    rsv[2];    /* Reserved for future use. */
> > > > };
> > > >
> > > > and in the IOCTL:
> > > >
> > > >         if (extoff->clockid !=3D CLOCK_MONOTONIC_RAW)
> > > >                 return -EINVAL;
> > > >
> > > >         sts.clockid =3D extoff->clockid;
> > > >
> > > > and it all just works, no?
> > > >
> > > Yes, this should work. However, I didn't check if struct
> > > ptp_system_timestamp is used in some other context.
> > >
> > > > I have no problem to decide that PTP_SYS_OFFSET will not get this
> > > > treatment and the drivers have to be converted over to
> > > > PTP_SYS_OFFSET_EXTENDED.
> > > >
> > > > But adding yet another callback just to carry a clockid as argument=
 is a
> > > > more than pointless exercise as I demonstrated.
> > > >
> > > Agreed. As I said, I thought we cannot change the gettimex64() withou=
t
> > > breaking the compatibility but the fact that CLOCK_REALTIME is "0"
> > > works well for the backward compatibility case.
> > >
> > > I can spin up an updated patch/series that updates gettimex64
> > > implementation instead of adding a new ioctl-op If you all agree.
> > >
> > > thanks,
> > > --mahesh..
> > >
> > > > Thanks,
> > > >
> > > >         tglx

