Return-Path: <linux-arch+bounces-3273-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC291890397
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 16:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6931C2DF1A
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10308130AC8;
	Thu, 28 Mar 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ7lCrn+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0C130A5C;
	Thu, 28 Mar 2024 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640468; cv=none; b=REsawGB2FxrsudO9fju1+mixqtEeh2E8er8MJPn6lMt/0+5xWUl4DDreVGmcmdKEcW6dZvBmHNVuFrhPLTS6YuZ396c1QkkZT262va/h4nD9R8baSIAqE/KZRUUaYu69vQx1exD9/u5ruhZvnUl7chFs4fPxSZNi915WRMmRPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640468; c=relaxed/simple;
	bh=EuCg3+PcgJnTD+UezIkX4/T1HGq2rvFDtjUJ26Pbhs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIInkHx09Be1WizwFTruKDCXlm3wq3IluA4iZqitqc7St1cjH1cSvUSvdLz3pPuOyfZvK5fidwJuHntI4TeqYxdrTdwGdpFNlTykSwzo/3/UcjdHg6WTWUoW33uPZzL0j+kYF8b8GxUZTOa6OmKBu3hvf3s3B4KzqrAS+Crxm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ7lCrn+; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso1183883276.1;
        Thu, 28 Mar 2024 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711640465; x=1712245265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+pR6EQUAULWyh2EPVyYWrT1tT1N65cI99EtZRHb/9o=;
        b=NQ7lCrn+bLWYvxiPpogsYtIbyNaIzjTUcsZIrnSEdUO724stbDFu2DaLlsLvqhsMdy
         lslQCcrZYa4ydFisrEweDMylUqbu+texVOCRl+1fMDd5TJOGljjIp3i/69oahNYhSZHi
         WnEWMgBl/IB3qh7HERF67BNzFyYI+PRo3UyCDescYbxaLMW4kwEZi8KQf3MoH6uBtRp/
         GtWHfKk/db574LGWAt7sxQlWM/6RgQ9jaALqyzWAuAG4mgHlzC/ykesFlD71eIIMrntm
         hDipBzjeUpEhuRSvJGODK6+eLLV0HOCA5BqXPv5xDQG/Bge62PW8fhfzLsSpOClKmUAy
         12gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711640465; x=1712245265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+pR6EQUAULWyh2EPVyYWrT1tT1N65cI99EtZRHb/9o=;
        b=roSc5ONiiNUjTK/ttjY1iBTg+M8r4Io4NFKbXF5y7P2fu1VitRzSqJF/vMNRuVAG7N
         ZSBB9FtOBYPO1jM2knYGNaIvmjD1PItMLwrAfZkJ8OgnfkGxIpjhN37cTP6mfjCoXNBt
         cOaWL1KPLyJMgfuUvozdDTusdEmCnPqbbiXJRNj0IJjf6LX7VnFNNSwbJSk/cY2KjOUn
         DNaPWk4+ALWdTTWtcn5dRjZ6wDPS4k41xf0zsYXIu7WxK3TWAe1VqZRCHtQkk9iLrnHN
         J13uqkzcbnIIW16i8cssFLG+wW5PusNvuNTWAo4WFuN1QDrCTdQBps/V7OUnEkevNLHr
         zyZw==
X-Forwarded-Encrypted: i=1; AJvYcCWsrJRXIfIIrzuuzxn8Ydkvc42sxrkO7RGFzBIBkg8vA0GKEY/U7P/mbDc9wuyZggxd+JeeilpQpRCmmgt5tT8NbxaroP2cgwmMLWDjD3P9KOzdYTEnUxuuo9rnOaK+c4WZbRk8i/qDQTG1IFpzp5lCt93hPe5UgwkHvRuztaLOt5uiuKTySxcmrGIZDatsiDycdr3dPC2anHdXhw==
X-Gm-Message-State: AOJu0YwOYwl6NWoOkCRBJ5OE90hr21W/FlUVHzSU0O7/6gNTk67367R4
	4/hP39GNLlniyMePlohr3g6o7RRqEWfwLVo1esH1OqSz2iN7nE551h2qwSoI3CZP2pKXZOSseiL
	nXtAAFclWB167eGSAPXcgJOjLfD8=
X-Google-Smtp-Source: AGHT+IF1P921LdGAo5vhp3eYNIrTlOhgIF9Se8AxxFqDicdehOqenusuzF+qSXs5veXyVNb4XB1vf+bij+0dIsPcEjI=
X-Received: by 2002:a25:b117:0:b0:dc2:4397:6ad3 with SMTP id
 g23-20020a25b117000000b00dc243976ad3mr3522832ybj.44.1711640464920; Thu, 28
 Mar 2024 08:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
 <878r29hjds.ffs@tglx>
In-Reply-To: <878r29hjds.ffs@tglx>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Thu, 28 Mar 2024 17:40:53 +0200
Message-ID: <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
To: Thomas Gleixner <tglx@linutronix.de>
Cc: richardcochran@gmail.com, luto@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, 
	geert@linux-m68k.org, peterz@infradead.org, hannes@cmpxchg.org, 
	sohil.mehta@intel.com, rick.p.edgecombe@intel.com, nphamcs@gmail.com, 
	palmer@sifive.com, keescook@chromium.org, legion@kernel.org, 
	mark.rutland@arm.com, mszeredi@redhat.com, casey@schaufler-ca.com, 
	reibax@gmail.com, davem@davemloft.net, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas

On Sat, Mar 23, 2024 at 2:38=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Sagi!
>
> On Wed, Mar 20 2024 at 16:42, Sagi Maimon wrote:
> > On Thu, Mar 14, 2024 at 8:08=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> Which is maximaly precise under the assumption that in the time betwee=
n
> >> the sample points a1 and a2 neither the system clock nor the PCH clock=
s
> >> are changing their frequency significantly. That is a valid assumption
> >> when you put a reasonable upper bound on d2.
> >>
> >
> > You are right.
> > In fact, we are running this calculation on a user space application.
> > We use the new system call to get pairs of mono and PHC and then run
> > that calculation in user space.
> > That is why the system call returns pairs of clock samples and not the
> > diff between them.
>
> Please stop claiming things which are fundamentally wrong:
>
>   The proposed system call returns the PHC sample and the midpoint of
>   two CLOCK_WHATEVER samples which have been sampled before and after
>   the PHC sample.
>
>   That is fundamentally different from a pair of samples as I explained
>   to you in great length more than once by now.
>
> I understand that you can't rely on the PTP_SYS_OFFSET_PRECISE IOCTL
> alone because there is not much hardware support, but what you are
> proposing is way worse than the other two PTP_SYS_OFFSET variants.
>
> PTP_SYS_OFFSET at least gives the caller a choice of analysis of the
> interleaving system timestamps.
>
> PTP_SYS_OFFSET_EXTENDED moves the outer sample points as close as
> possible to the actual PCH read and provides both outer samples to user
> space for analysis. It was introduced for a reason, no?
>
> Your proposed system call is just declaring arbitrarily that the
> CLOCK_WHATEVER sample is exactly the midpoint of the two outer samples
> and is therefore superior and correct.
>
> It is neither superior nor correct because the midpoint is an
> ill-defined assumption as I explained to you multiple times now.
>
> Aside of that the approach loses the extended information of
> PTP_SYS_OFFSET and PTP_SYS_OFFSET_EXTENDED including the more precise
> sampling behaviour of the latter. IOW, it is ignoring and throwing away
> the effort of people who cared about making the best out of the
> limitations of hardware including the already existing algorithms to
> make sense out of it.
>
> The P at the beginning of PTP does not mean 'Potentially precise' and
> the lack of C in PTP does not mean that Correctness is overrated.
>
> The problem is that these non hardware assisted IOCTL variants sample
> only CLOCK_REALTIME and not CLOCK_MONOTONIC_RAW, which is all you need
> to solve your problem at hand, no?
>
> That's absolutely not rocket science to solve. The below sketch does
> exactly that without creating an ill-defined syscall monstrosity, at the
> same time it is fully preserving the benefits of the existing IOCTL
> variants and therefore allows to apply already existing algorithms to
> analyse that data. That's too simple and too obviously correct, right?
>
> The thing is a sketch and it's neither compiled nor tested. It's just
> for illustration and you can keep all bugs you might find in it.
>
> On top this needs an analyis whether any of the gettimex64()
> implementations does something special instead of invoking the
> ptp_read_system_prets() and ptp_read_system_postts() helpers as close as
> possible to the PCH readout, but that's not rocket science either. It's
> just 21 callbacks to look at.
>
I like your suggestion, thanks!
it is what our user space needs from the kernel and with minimum kernel cha=
nges.
I will write it, test it and upload it with your permission (it is you
idea after all).
> It might also require a new set of variant '3' IOTCLS to make that flag
> field work, but that's not going to make the change more complex and
> it's an exercise left to the experts of that IOCTL interface.
>
I think that I understand your meaning.
There is a backward compatibility problem here.
Existing user space application using PTP_SYS_OFFSET_EXTENDED ioctl
won't have any problems
because of the "extoff->rsv[0] || extoff->rsv[1] || extoff->rsv[2]"
test,  but what about all
old user space applications using: PTP_SYS_OFFSET ?
How can it be solved?
Can you explain what you meant above regarding the IOCTL?

Thanks,
Sagi



> Thanks,
>
>         tglx
> ---
>  drivers/ptp/ptp_chardev.c        |   36 ++++++++++++++++++++++----------=
----
>  include/linux/ptp_clock_kernel.h |   28 +++++++++++++++++++---------
>  include/uapi/linux/ptp_clock.h   |   10 ++++++++--
>  3 files changed, 49 insertions(+), 25 deletions(-)
>
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -164,9 +164,9 @@ long ptp_ioctl(struct posix_clock_contex
>         struct ptp_sys_offset_precise precise_offset;
>         struct system_device_crosststamp xtstamp;
>         struct ptp_clock_info *ops =3D ptp->info;
> +       struct ptp_system_timestamp sts =3D { };
>         struct ptp_sys_offset *sysoff =3D NULL;
>         struct timestamp_event_queue *tsevq;
> -       struct ptp_system_timestamp sts;
>         struct ptp_clock_request req;
>         struct ptp_clock_caps caps;
>         struct ptp_clock_time *pct;
> @@ -358,11 +358,13 @@ long ptp_ioctl(struct posix_clock_contex
>                         extoff =3D NULL;
>                         break;
>                 }
> -               if (extoff->n_samples > PTP_MAX_SAMPLES
> -                   || extoff->rsv[0] || extoff->rsv[1] || extoff->rsv[2]=
) {
> +               if (!extoff->n_samples || extoff->n_samples > PTP_MAX_SAM=
PLES ||
> +                   (extoff->flags & ~PTP_SYS_OFFSET_VALID_FLAGS) ||
> +                   extoff->rsv[0] || extoff->rsv[1]) {
>                         err =3D -EINVAL;
>                         break;
>                 }
> +               sts.flags =3D extoff->flags;
>                 for (i =3D 0; i < extoff->n_samples; i++) {
>                         err =3D ptp->info->gettimex64(ptp->info, &ts, &st=
s);
>                         if (err)
> @@ -386,29 +388,35 @@ long ptp_ioctl(struct posix_clock_contex
>                         sysoff =3D NULL;
>                         break;
>                 }
> -               if (sysoff->n_samples > PTP_MAX_SAMPLES) {
> +               if (!sysoff->n_samples || sysoff->n_samples > PTP_MAX_SAM=
PLES ||
> +                   (sysoff->flags & ~PTP_SYS_OFFSET_VALID_FLAGS) ||
> +                   sysoff->rsv[0] || sysoff->rsv[1]) {
>                         err =3D -EINVAL;
>                         break;
>                 }
> +               sts.flags =3D sysoff->flags;
>                 pct =3D &sysoff->ts[0];
>                 for (i =3D 0; i < sysoff->n_samples; i++) {
> -                       ktime_get_real_ts64(&ts);
> -                       pct->sec =3D ts.tv_sec;
> -                       pct->nsec =3D ts.tv_nsec;
> -                       pct++;
> -                       if (ops->gettimex64)
> -                               err =3D ops->gettimex64(ops, &ts, NULL);
> -                       else
> +                       if (ops->gettimex64) {
> +                               err =3D ops->gettimex64(ops, &ts, &sts);
> +                       } else {
> +                               ptp_read_system_prets(&sts);
>                                 err =3D ops->gettime64(ops, &ts);
> +                       }
>                         if (err)
>                                 goto out;
> +
> +                       pct->sec =3D sts.pre_ts.tv_sec;
> +                       pct->nsec =3D sts.pre_ts.tv_nsec;
> +                       pct++;
>                         pct->sec =3D ts.tv_sec;
>                         pct->nsec =3D ts.tv_nsec;
>                         pct++;
>                 }
> -               ktime_get_real_ts64(&ts);
> -               pct->sec =3D ts.tv_sec;
> -               pct->nsec =3D ts.tv_nsec;
> +               if (!ops->gettimex64)
> +                       ptp_read_system_postts(&sts);
> +               pct->sec =3D sts.post_ts.tv_sec;
> +               pct->nsec =3D sts.post_ts.tv_nsec;
>                 if (copy_to_user((void __user *)arg, sysoff, sizeof(*syso=
ff)))
>                         err =3D -EFAULT;
>                 break;
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -44,13 +44,15 @@ struct ptp_clock_request {
>  struct system_device_crosststamp;
>
>  /**
> - * struct ptp_system_timestamp - system time corresponding to a PHC time=
stamp
> - * @pre_ts: system timestamp before capturing PHC
> - * @post_ts: system timestamp after capturing PHC
> + * struct ptp_system_timestamp - System time corresponding to a PHC time=
stamp
> + * @flags:     Flags to select the system clock to sample
> + * @pre_ts:    System timestamp before capturing PHC
> + * @post_ts:   System timestamp after capturing PHC
>   */
>  struct ptp_system_timestamp {
> -       struct timespec64 pre_ts;
> -       struct timespec64 post_ts;
> +       unsigned int            flags;
> +       struct timespec64       pre_ts;
> +       struct timespec64       post_ts;
>  };
>
>  /**
> @@ -457,14 +459,22 @@ static inline ktime_t ptp_convert_timest
>
>  static inline void ptp_read_system_prets(struct ptp_system_timestamp *st=
s)
>  {
> -       if (sts)
> -               ktime_get_real_ts64(&sts->pre_ts);
> +       if (sts) {
> +               if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
> +                       ktime_get_raw_ts64(&sts->pre_ts);
> +               else
> +                       ktime_get_real_ts64(&sts->pre_ts);
> +       }
>  }
>
>  static inline void ptp_read_system_postts(struct ptp_system_timestamp *s=
ts)
>  {
> -       if (sts)
> -               ktime_get_real_ts64(&sts->post_ts);
> +       if (sts) {
> +               if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
> +                       ktime_get_raw_ts64(&sts->post_ts);
> +               else
> +                       ktime_get_real_ts64(&sts->post_ts);
> +       }
>  }
>
>  #endif
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -76,6 +76,10 @@
>   */
>  #define PTP_PEROUT_V1_VALID_FLAGS      (0)
>
> +/* Bits for PTP_SYS_OFFSET and PTP_SYS_OFFSET_EXTENDED */
> +#define PTP_SYS_OFFSET_MONO_RAW                (1U << 0)
> +#define PTP_SYS_OFFSET_VALID_FLAGS     (PTP_SYS_OFFSET_MONO_RAW)
> +
>  /*
>   * struct ptp_clock_time - represents a time value
>   *
> @@ -146,7 +150,8 @@ struct ptp_perout_request {
>
>  struct ptp_sys_offset {
>         unsigned int n_samples; /* Desired number of measurements. */
> -       unsigned int rsv[3];    /* Reserved for future use. */
> +       unsigned int flags;
> +       unsigned int rsv[2];    /* Reserved for future use. */
>         /*
>          * Array of interleaved system/phc time stamps. The kernel
>          * will provide 2*n_samples + 1 time stamps, with the last
> @@ -157,7 +162,8 @@ struct ptp_sys_offset {
>
>  struct ptp_sys_offset_extended {
>         unsigned int n_samples; /* Desired number of measurements. */
> -       unsigned int rsv[3];    /* Reserved for future use. */
> +       unsigned int flags;
> +       unsigned int rsv[2];    /* Reserved for future use. */
>         /*
>          * Array of [system, phc, system] time stamps. The kernel will pr=
ovide
>          * 3*n_samples time stamps.

