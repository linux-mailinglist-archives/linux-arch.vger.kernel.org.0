Return-Path: <linux-arch+bounces-3719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CE98A664E
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 10:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DFAAB2324D
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C488289C;
	Tue, 16 Apr 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESy0l+YV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB7205E10;
	Tue, 16 Apr 2024 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256761; cv=none; b=rykVCSJDUq4tnljy8t5xRQ+aPbYR3eADsrDxoCP36OvAgIzIuNGYr2RGJxZQA/UZCPowQtQDcLq4cBQrHLm4GdivK88prDgyqN36D7VClIIPXwzuL1LMZUcdIQ1WSxl8qCBs0nA5J0xlzAprye3pgIObhz7uXdhRaSPLA1IHrc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256761; c=relaxed/simple;
	bh=VLcr7turOPRMgRs/A8QlWs0P9uv2o5oZwAVIsW3GaQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCJPC6zgV7PU5E1TTzS6Zf0PXVJCKYwBstgUyOv0hfHro31hPCNuZPHSi5P/9zRFMlMHH6rY5f/XbpGFXaRmBjs0/FaAfIQV6Pv0qvMd26bMwnFPT9qGZzVw7/1YzaAuyD8wYbumhY899IjTJ6eBj8HLvyXzzT84XUvSFv4qcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESy0l+YV; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso4097581276.0;
        Tue, 16 Apr 2024 01:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713256759; x=1713861559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULx2+CdWwJ5T12P64Gy2FAgavzRX9V/iUSqZ7uInxDo=;
        b=ESy0l+YVtOFKjF6QsnZqMQAQ7r95qSZr78fooEkzy5IH1axmGv6kAPIJOoNtMiA+b0
         tu7hGTGReOKeLjIdfuX56WQITDbYyTrjOafNfYLI/cu/i2t9Gx8HBuJ6DhQWuD93owmQ
         7xbAa2DqDB175uhCbRehYli2SsU94Mdru4RaAUbf/hTPTMJTYVTUNwpepxyE8DPURSzS
         VK/pZJ3R8KCpPUYQdv8UIEv0JU6wtTvwBcIgDZn2x7YyOe2H4r+v/BOKVDXwNpcdUUIz
         ksQjfvP9mak7IZb76IbewnKKXqBbubfQZOpm6s6F/fbj4DGMT4ome+esgqID9I+6Sl3D
         xslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713256759; x=1713861559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULx2+CdWwJ5T12P64Gy2FAgavzRX9V/iUSqZ7uInxDo=;
        b=cnaasOsHjL8e6tw2xCiuw97+M2bJKEqXV94j7Ky0F162aAP9oVaOFmUjDykOis7mnJ
         dj59a94KQ4p6g/QRJwLadeMwpLlDgGPENjbVl/MuCDiy4xjuBnjyWZ2DmLh2PL55vhQB
         1SUNQGRuOyGVZC39U8WJ4J6s5dFx/fkgPWfiQPmdC+9UNWJvR2xVm0jRzm1Hrl02sqpr
         muOCKVxgUerorYFubzsTWYtMY6tMv5wxvp/vV/WQOVFsuiPTpsXuBmKXiZlkDdL7jci7
         D9mGz1ICPwfVEF5zMe6T6O7zaqsxzcr/Gud+aHUw1iJ7LBE6j3YEcTpPeHm5w/ktNJ0h
         1zDg==
X-Forwarded-Encrypted: i=1; AJvYcCWYPDOHFk7hByW74VUiIOZ8ibcTskFSWwaKpWkd99zml1T6GQd/ymUjMLSRL9MfXc0eB3LHPKxL1nK6QmxiH5kLkC/9XLdO3RNJNNKO1RewMvbwf859QQFgQv6Bd9on2InMc6HFjwl7hhvj7sjCxKwdtUmHazF7LpLmb9/P2Acm4/1u6DPvtMjD0POXGqs321ocOWazwEUBotbzhA==
X-Gm-Message-State: AOJu0YzDktCxj/A+c2sAeYA3auRwpRL3Q9spxVMvqzgicII59SDx8t3V
	zgntY/asH8Fv9JHuMLjMzwUwztqBWz6FG2rt1rVjJ0Hy+EvrGZZLEvZrAIZGoIr8UouC+RpVNwH
	AwwCvfElpSzkjKvCIXilxdM4Gwds=
X-Google-Smtp-Source: AGHT+IEEmVdiu9Gd0tesh6Kak+5mFQ5Pf9yXtyzs9shjKlhDRu6+XMRfxl925MhXSV+0qTM5vV7kF11Bs519Pn3G++U=
X-Received: by 2002:a25:7405:0:b0:de3:ec94:2e94 with SMTP id
 p5-20020a257405000000b00de3ec942e94mr3904813ybc.15.1713256758911; Tue, 16 Apr
 2024 01:39:18 -0700 (PDT)
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
 <CAMuE1bFkmj70DO66PfvBPjM1d_JDEwTkOyz6o6wO_C0uyJ_0zw@mail.gmail.com>
 <CAF2d9jj-kwmP+LWBBmU41Yhpmc0zE1w9UAoRHj=j-wLBSOwU5Q@mail.gmail.com>
 <CAMuE1bFomKFTz+E9=4=F8r0DOoPdjZYt4ofubJgXGP0rpEjnqA@mail.gmail.com> <CAF2d9jg0X_HKSZbiwPTEXdmrhY49D1zfT3Q4xzNAqv1z+TYXtA@mail.gmail.com>
In-Reply-To: <CAF2d9jg0X_HKSZbiwPTEXdmrhY49D1zfT3Q4xzNAqv1z+TYXtA@mail.gmail.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Tue, 16 Apr 2024 11:39:07 +0300
Message-ID: <CAMuE1bHj2w0HLyxj0eQ-OOg+=qqyFoxeb5Ko0G81DEXVLtNjdw@mail.gmail.com>
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

Thanks

On Mon, Apr 15, 2024 at 8:23=E2=80=AFPM Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=
=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=
=E0=A4=B0)
<maheshb@google.com> wrote:
>
> On Sun, Apr 14, 2024 at 5:22=E2=80=AFAM Sagi Maimon <maimon.sagi@gmail.co=
m> wrote:
> >
> > On Thu, Apr 11, 2024 at 7:34=E2=80=AFPM Mahesh Bandewar (=E0=A4=AE=E0=
=A4=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=
=A4=BE=E0=A4=B0)
> > <maheshb@google.com> wrote:
> > >
> > > On Thu, Apr 11, 2024 at 12:11=E2=80=AFAM Sagi Maimon <maimon.sagi@gma=
il.com> wrote:
> > > >
> > > > Hi Mahesh
> > > > What is the status of your patch?
> > > > if your patch is upstreamed , then it will have all I need.
> > > > But, If not , I will upstream my patch.
> > > > BR,
> > > >
> > > Hi Sagi,
> > >
> > > If you want to pursue the syscall option, then those are tangential
> > > and please go ahead. (I cannot stop you!)
> > > I'm interested in getting the "tight sandwich timestamps" that
> > > gettimex64() ioctl offers and I would want enhancements to
> > > gettimex64() done the way it was discussed in the later half of this
> > > thread. If you want to sign-up for that please let me know.
> > Hi Mahesh
> > I do need to modify the  PTP_SYS_OFFSET_EXTENDED ioctl for cases which
> > gettimex64
> > not supported by the driver (look at Thomas suggestion), but I need
> > your changes in ptp_read_system_prets.
> > I like to add my changes above your changes, so we won't do duplicate w=
ork.
> > please show me your latest patch and the status of it
> > Once you have upstream yours , I will add my changes on the next patch.
>
> OK, in that case let me post the patch since your changes would need
> pieces from it.
>
> thanks,
> --mahesh..
>
> > BR
> > Sagi
> >
> > >
> > > thanks,
> > > --mahesh..
> > >
> > >
> > > > On Thu, Apr 11, 2024 at 5:56=E2=80=AFAM Mahesh Bandewar (=E0=A4=AE=
=E0=A4=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=
=E0=A4=BE=E0=A4=B0)
> > > > <maheshb@google.com> wrote:
> > > > >
> > > > > On Wed, Apr 3, 2024 at 6:48=E2=80=AFAM Thomas Gleixner <tglx@linu=
tronix.de> wrote:
> > > > > >
> > > > > > On Tue, Apr 02 2024 at 16:37, Mahesh Bandewar (=E0=A4=AE=E0=A4=
=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=
=BE=E0=A4=B0) wrote:
> > > > > > > On Tue, Apr 2, 2024 at 3:37=E2=80=AFPM Thomas Gleixner <tglx@=
linutronix.de> wrote:
> > > > > > > The modification that you have proposed (in a couple of posts=
 back)
> > > > > > > would work but it's still not ideal since the pre/post ts are=
 not
> > > > > > > close enough as they are currently  (properly implemented!)
> > > > > > > gettimex64() would have. The only way to do that would be to =
have
> > > > > > > another ioctl as I have proposed which is a superset of curre=
nt
> > > > > > > gettimex64 and pre-post collection is the closest possible.
> > > > > >
> > > > > > Errm. What I posted as sketch _is_ using gettimex64() with the =
extra
> > > > > > twist of the flag vs. a clockid (which is an implementation det=
ail) and
> > > > > > the difference that I carry the information in ptp_system_times=
tamp
> > > > > > instead of needing a new argument clockid to all existing callb=
acks
> > > > > > because the modification to ptp_read_prets() and postts() will =
just be
> > > > > > sufficient, no?
> > > > > >
> > > > > OK, that makes sense.
> > > > >
> > > > > > For the case where the driver does not provide gettimex64() the=
n the
> > > > > > extension of the original offset ioctl is still providing a bet=
ter
> > > > > > mechanism than the proposed syscall.
> > > > > >
> > > > > > I also clearly said that all drivers should be converted over t=
o
> > > > > > gettimex64().
> > > > > >
> > > > > I agree. Honestly that should have been mandatory and
> > > > > ptp_register_clock() should fail otherwise! Probably should have =
been
> > > > > part of gettimex64 implementation :(
> > > > >
> > > > > I don't think we can do anything other than just hoping all drive=
r
> > > > > implementations include gettimex64 implementation.
> > > > >
> > > > > > > Having said that, the 'flag' modification proposal is a good =
backup
> > > > > > > for the drivers that don't have good implementation (close en=
ough but
> > > > > > > not ideal). Also, you don't need a new ioctl-op. So if we rea=
lly want
> > > > > > > precision, I believe, we need a new ioctl op (with supporting
> > > > > > > implementation similar to the mlx4 code above). but we want t=
o save
> > > > > > > the new ioctl-op and have less precision then proposed modifi=
cation
> > > > > > > would work fine.
> > > > > >
> > > > > > I disagree. The existing gettimex64() is good enough if the dri=
ver
> > > > > > implements it correctly today. If not then those drivers need t=
o be
> > > > > > fixed independent of this.
> > > > > >
> > > > > > So assumed that a driver does:
> > > > > >
> > > > > > gettimex64()
> > > > > >    ptp_prets(sts);
> > > > > >    read_clock();
> > > > > >    ptp_postts(sts);
> > > > > >
> > > > > > today then having:
> > > > > >
> > > > > > static inline void ptp_read_system_prets(struct ptp_system_time=
stamp *sts)
> > > > > > {
> > > > > >         if (sts) {
> > > > > >                 if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
> > > > > >                         ktime_get_raw_ts64(&sts->pre_ts);
> > > > > >                 else
> > > > > >                         ktime_get_real_ts64(&sts->pre_ts);
> > > > > >         }
> > > > > > }
> > > > > >
> > > > > > static inline void ptp_read_system_postts(struct ptp_system_tim=
estamp *sts)
> > > > > > {
> > > > > >         if (sts) {
> > > > > >                 if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
> > > > > >                         ktime_get_raw_ts64(&sts->post_ts);
> > > > > >                 else
> > > > > >                         ktime_get_real_ts64(&sts->post_ts);
> > > > > >         }
> > > > > > }
> > > > > >
> > > > > > or
> > > > > >
> > > > > > static inline void ptp_read_system_prets(struct ptp_system_time=
stamp *sts)
> > > > > > {
> > > > > >         if (sts) {
> > > > > >                 switch (sts->clockid) {
> > > > > >                 case CLOCK_MONOTONIC_RAW:
> > > > > >                         time_get_raw_ts64(&sts->pre_ts);
> > > > > >                         break;
> > > > > >                 case CLOCK_REALTIME:
> > > > > >                         ktime_get_real_ts64(&sts->pre_ts);
> > > > > >                         break;
> > > > > >                 }
> > > > > >         }
> > > > > > }
> > > > > >
> > > > > > static inline void ptp_read_system_postts(struct ptp_system_tim=
estamp *sts)
> > > > > > {
> > > > > >         if (sts) {
> > > > > >                 switch (sts->clockid) {
> > > > > >                 case CLOCK_MONOTONIC_RAW:
> > > > > >                         time_get_raw_ts64(&sts->post_ts);
> > > > > >                         break;
> > > > > >                 case CLOCK_REALTIME:
> > > > > >                         ktime_get_real_ts64(&sts->post_ts);
> > > > > >                         break;
> > > > > >                 }
> > > > > >         }
> > > > > > }
> > > > > >
> > > > > > is doing the exact same thing as your proposal but without touc=
hing any
> > > > > > driver which implements gettimex64() correctly at all.
> > > > > >
> > > > > I see. Yes, this makes sense.
> > > > >
> > > > > > While your proposal requires to touch every single driver for n=
o reason,
> > > > > > no?
> > > > > >
> > > > > > It is just an implementation detail whether you use a flag or a
> > > > > > clockid. You can carry the clockid for the clocks which actuall=
y can be
> > > > > > read in that context in a reserved field of PTP_SYS_OFFSET_EXTE=
NDED:
> > > > > >
> > > > > > struct ptp_sys_offset_extended {
> > > > > >         unsigned int    n_samples; /* Desired number of measure=
ments. */
> > > > > >         clockid_t       clockid;
> > > > > >         unsigned int    rsv[2];    /* Reserved for future use. =
*/
> > > > > > };
> > > > > >
> > > > > > and in the IOCTL:
> > > > > >
> > > > > >         if (extoff->clockid !=3D CLOCK_MONOTONIC_RAW)
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > >         sts.clockid =3D extoff->clockid;
> > > > > >
> > > > > > and it all just works, no?
> > > > > >
> > > > > Yes, this should work. However, I didn't check if struct
> > > > > ptp_system_timestamp is used in some other context.
> > > > >
> > > > > > I have no problem to decide that PTP_SYS_OFFSET will not get th=
is
> > > > > > treatment and the drivers have to be converted over to
> > > > > > PTP_SYS_OFFSET_EXTENDED.
> > > > > >
> > > > > > But adding yet another callback just to carry a clockid as argu=
ment is a
> > > > > > more than pointless exercise as I demonstrated.
> > > > > >
> > > > > Agreed. As I said, I thought we cannot change the gettimex64() wi=
thout
> > > > > breaking the compatibility but the fact that CLOCK_REALTIME is "0=
"
> > > > > works well for the backward compatibility case.
> > > > >
> > > > > I can spin up an updated patch/series that updates gettimex64
> > > > > implementation instead of adding a new ioctl-op If you all agree.
> > > > >
> > > > > thanks,
> > > > > --mahesh..
> > > > >
> > > > > > Thanks,
> > > > > >
> > > > > >         tglx

