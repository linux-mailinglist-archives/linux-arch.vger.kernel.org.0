Return-Path: <linux-arch+bounces-2994-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1C587BC9D
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 13:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308CA1C21425
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC846F50F;
	Thu, 14 Mar 2024 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EReA0AEb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4133B193;
	Thu, 14 Mar 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418793; cv=none; b=jSHRSuOip65yS8O8M3MRlpASzi0Q85vjzE9NWmKTdtWgrlRLC328EQ363Pve83OhDYqcXr10ZZ85EutrKJolZo9S4b6VDTk0EACdmdJPwcSZz1IxNxtvx0S81ayW1A1F1GMocO2Nk5mITdMu40X9kQ3YEBdNZwY2aY1NCM/3Psg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418793; c=relaxed/simple;
	bh=RJhM/5Rw12tnBSRvNA0nhz/HX/5C846tTEwlh5KGSCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLjd4BrLoGZm5vcrsf4VSKGLdxGUsHXdqWjRkZqsVX1CqQz8cAw+vaP/xnL2onfHOIAjJFJLEKzv7aG1Yr7aK4C/bp2ztRLHT3Ts6gaq5yPp9Ypot8bTxiqIEyxscwP/+Z5pAzKiHIu9mdwghzo2j7nQx3/OL0DXmn+htDOqh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EReA0AEb; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so1840585276.0;
        Thu, 14 Mar 2024 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710418790; x=1711023590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpDfYtkAi2dUnRakoQXldfdVgiXVNVhVCrs/LNZD8P8=;
        b=EReA0AEbbW0b3D4wPz6vwjW/5MQCK53/bVAOc1MrDTUaLlvhd9MZ9SMtabm2drkY+r
         8iFRyFyJwq3JX/TokTM5zr4KQ3ge9R4xlYkYRFxa2lDnSUbhE5d/571+Z9niX7dityWc
         m0/uN3ydF2uDlnRVwGn65Y9J6kwAhsHfDgWJCrv3JzyrHNiazmgXVf9Kqj+KMZ3VEcX2
         XQRsQ7ZnlFvE9FU5aWAALWVqG3yPM+A8+QsYc0y1jY7UQGP+Gmukv0E67aHv2kn9zk0E
         eVJo46l6SIV6SW0U4EpolH5BZCmbdHR6rqK15hhxDrtO8Jkuk0JmhduqxqQjBfGvntVq
         3QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710418790; x=1711023590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpDfYtkAi2dUnRakoQXldfdVgiXVNVhVCrs/LNZD8P8=;
        b=fDXaSAzZw4vHm12Tq9lPNjhbVNa8iYBC3OJJKE/v3OXmLTe2Ys/MGaAmVfx+F0ONnU
         gvc2AI3rATGm6UcuEB+wm3UxVyNecUve9WE5tLTOmo7NS8nRyD1L/6sb1dQydxOtbmyH
         mjMKl7eI5JU8coH6kI4EcqZCGygPkO5IJ5gQkcM24rJyHf1JoIKNM1NUEG8n8FMmg+al
         gAC4f4XepFVesFtxZE8FjBQadrjzhjpQA0p2RJfYexju95zIgvl7xbMfG656aNOoGspW
         /ZjLWUKNMmiUwv+djX1rq/XEgREdH7p5YCRXxAA/J6NPys0WmFJ3HbHEzuDX9mB3IO3Z
         f3nw==
X-Forwarded-Encrypted: i=1; AJvYcCWP/nDNX6BGdeH9T8MoQMneXZ7DKBohtmU2rjFO9db08FkxOTnbWWscUEcj9ostD7RCZiIb9jSKXL+ikZQtMn3ZiYRNlv5LApccc9oOFmpUKeI/RQUbTyvm2AaS627B7oDVIlHdTJFGR96TcY1zpRVGx/n+Jr3jfwmN3tSaEN2GOZwwYni9//Ay5G6GfXVFdaRGKETP/bTRkxwbHw==
X-Gm-Message-State: AOJu0Yzd34SuG+3U43SjhzgYblI3hKNLdILJ/L1NfatYICCa0c2jEJGf
	4lQUAIi/hzph3vhSXX4JNwA8hG73Veuo8+2sidK7d98arqyK0ihJ/gQzs5QncS9oBuIXkdYrVRa
	7fE/0R8hXTf8LGWKv8tBdrDG0QZ4=
X-Google-Smtp-Source: AGHT+IE+e2VNTkyMSDp6k1loWQtZM6T24enYT8pqcu16W9GA33aPQbG37b35OZ2NpUEN4HhGUNgd35EE5adSQqE+DdY=
X-Received: by 2002:a25:2c7:0:b0:dd0:d40d:1c98 with SMTP id
 190-20020a2502c7000000b00dd0d40d1c98mr4251583ybc.17.1710418790424; Thu, 14
 Mar 2024 05:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314090540.14091-1-maimon.sagi@gmail.com> <87a5n1m5j1.ffs@tglx>
In-Reply-To: <87a5n1m5j1.ffs@tglx>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Thu, 14 Mar 2024 14:19:39 +0200
Message-ID: <CAMuE1bH_H9E+Zx365G9AtmWSmhW-kPPB+-=8s2rH4hpxqE+dHQ@mail.gmail.com>
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
To: Thomas Gleixner <tglx@linutronix.de>
Cc: richardcochran@gmail.com, luto@kernel.org, datglx@linutronix.de, 
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

hi Thomas

On Thu, Mar 14, 2024 at 1:12=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Mar 14 2024 at 11:05, Sagi Maimon wrote:
> > Some user space applications need to read a couple of different clocks.
> > Each read requires moving from user space to kernel space.
> > Reading each clock separately (syscall) introduces extra
> > unpredictable/unmeasurable delay. Minimizing this delay contributes to =
user
> > space actions on these clocks (e.g. synchronization etc).
>
> I asked for a proper description of the actual problem several times now
> and you still provide some handwaving blurb. Feel free to ignore me, but
> then please don't be surprised if I ignore you too.
>
Nobody is ignoring your notes, and I address any notes given by any
maintainer in the most serious way.
As far as explaining the actual problem this is the best that I can,
but let me try to explain better:
We did many tests with different CPU loading and compared sampling the
same clock twice,
once in user space and once by using the system call.
We have noticed an improvement up to hundreds of nanoseconds while
using the system call.
Those results improved our ability to sync different PHCs

> Also why does reading two random clocks make any sense at all? Your code
> allows to read CLOCK_TAI and CLOCK_THREAD_CPUTIME_ID. What for?
>
Initially we needed to sync some different PHCs for our user space
application, that is why we came with this idea.
The first idea was an IOCTL that returned samples of several PHCs for
the need of synchronization.
Richard Cochran suggested a system call instead, which will add the
ability to get various system clocks, while this
implementation is more complex then IOCTL, I think that he was right,
for future usage.

> This is about PTP, no?
>
yes
> Again you completely fail to explain why the existing PTP ioctls are not
> sufficient for the purpose and why you need to provide a new interface
> which is completely ill defined.
>
The same as my answer above .....

> > arch/x86/entry/syscalls/syscall_64.tbl |   1 +
> > drivers/ptp/ptp_clock.c                |  34 ++++--
> > include/linux/posix-clock.h            |   2 +
> > include/linux/syscalls.h               |   4 +
> > include/uapi/asm-generic/unistd.h      |   5 +-
> > kernel/time/posix-clock.c              |  25 +++++
> > kernel/time/posix-timers.c             | 138 +++++++++++++++++++++++++
> > kernel/time/posix-timers.h             |   2 +
>
> This needs to be split up into:
>
>      1) Infrastructure in posix-timers.c
>      2) Wire up the syscall in x86
>      3) Infrastructure in posix-clock.c
>      4) Usage in ptp_clock.c
>
> and not as a big lump of everything.
>
I know, but I think the benefit worth it
I agree that an IOCTL won't require such a big changes in the kernel code
> > +/**
> > + * clock_compare - Get couple of clocks time stamps
>
> So the name of the syscall suggest that it compares two clocks, but the
> actual functionality is to read two clocks.
>
> This does not make any sense at all. Naming matters.
>
you are right the name was suggested by Richard when the main idea was
returning the offset between the clocks.
If you have a better name, please tell me
> > + * @clock_a: clock a ID
> > + * @clock_b: clock b ID
> > + * @tp_a:            Pointer to a user space timespec64 for clock a st=
orage
> > + * @tp_b:            Pointer to a user space timespec64 for clock b st=
orage
> > + *
> > + * clock_compare gets time sample of two clocks.
> > + * Supported clocks IDs: PHC, virtual PHC and various system clocks.
> > + *
> > + * In case of PHC that supports crosstimespec and the other clock is M=
onotonic raw
> > + * or system time, crosstimespec will be used to synchronously capture
> > + * system/device time stamp.
> > + *
> > + * In other cases: Read clock_a twice (before, and after reading clock=
_b) and
> > + * average these times =E2=80=93 to be as close as possible to the tim=
e we read clock_b.
> > + *
> > + * Returns:
> > + *   0               Success. @tp_a and @tp_b contains the time stamps
> > + *   -EINVAL         @clock a or b ID is not a valid clock ID
> > + *   -EFAULT         Copying the time stamp to @tp_a or @tp_b faulted
> > + *   -EOPNOTSUPP     Dynamic POSIX clock does not support crosstimespe=
c()
> > + **/
> > +SYSCALL_DEFINE5(clock_compare, const clockid_t, clock_a, const clockid=
_t, clock_b,
> > +             struct __kernel_timespec __user *, tp_a, struct __kernel_=
timespec __user *,
> > +             tp_b, s64 __user *, offs_err)
> > +{
> > +     struct timespec64 ts_a, ts_a1, ts_b, ts_a2;
> > +     struct system_device_crosststamp xtstamp_a1, xtstamp_a2, xtstamp_=
b;
> > +     const struct k_clock *kc_a, *kc_b;
> > +     ktime_t ktime_a;
> > +     s64 ts_offs_err =3D 0;
> > +     int error =3D 0;
> > +     bool crosstime_support_a =3D false;
> > +     bool crosstime_support_b =3D false;
>
> Please read and follow the documentation provided at:
>
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
>
> > +     kc_a =3D clockid_to_kclock(clock_a);
> > +     if (!kc_a) {
> > +             error =3D -EINVAL;
> > +             return error;
>
> What's wrong about 'return -EINVAL;' ?
>
correct will be fixed on next patch
> > +     }
> > +
> > +     kc_b =3D clockid_to_kclock(clock_b);
> > +     if (!kc_b) {
> > +             error =3D -EINVAL;
> > +             return error;
> > +     }
> > +
> > +     // In case crosstimespec supported and b clock is Monotonic raw o=
r system
> > +     // time, synchronously capture system/device time stamp
>
> Please don't use C++ comments.
>
will be fixed on next patch
> > +     if (clock_a < 0) {
>
> This is just wrong. posix-clocks ar not the only ones which have a
> negative clock id. See clockid_to_kclock()
>
> > +             error =3D kc_a->clock_get_crosstimespec(clock_a, &xtstamp=
_a1);
>
> What's a crosstimespec?
>
> This function fills in a system_device_crosststamp, so why not name it
> so that the purpose of the function is obvious?
>
correct , it will be fixed on next patch
> ptp_clock::info::getcrosststamp() has a reasonable name. So why do you
> need to come up with something which makes the code obfuscated?
>
correct , it will be fixed on next patch
> > +             if (!error) {
> > +                     if (clock_b =3D=3D CLOCK_MONOTONIC_RAW) {
> > +                             ts_b =3D ktime_to_timespec64(xtstamp_a1.s=
ys_monoraw);
> > +                             ts_a1 =3D ktime_to_timespec64(xtstamp_a1.=
device);
> > +                             goto out;
> > +                     } else if (clock_b =3D=3D CLOCK_REALTIME) {
> > +                             ts_b =3D ktime_to_timespec64(xtstamp_a1.s=
ys_realtime);
> > +                             ts_a1 =3D ktime_to_timespec64(xtstamp_a1.=
device);
> > +                             goto out;
> > +                     } else {
> > +                             crosstime_support_a =3D true;
>
> Right. If clock_b is anything else than CLOCK_MONOTONIC_RAW or
> CLOCK_REALTIME then this is true.
>
> > +                     }
> > +             }
>
> So in case of an error, this just keeps going with an uninitialized
> xtstamp_a1 and if the clock_b part succeeds it continues and operates on
> garbage.
>
On error  xtstamp_a1 will be taken again using clock_get_crosstimespec
so no one will be operating on garbage.
Please explain the problem better, because I don't see it.
> > +     }
> > +
> > +     // In case crosstimespec supported and a clock is Monotonic raw o=
r system
> > +     // time, synchronously capture system/device time stamp
> > +     if (clock_b < 0) {
> > +             // Synchronously capture system/device time stamp
> > +             error =3D kc_b->clock_get_crosstimespec(clock_b, &xtstamp=
_b);
> > +             if (!error) {
> > +                     if (clock_a =3D=3D CLOCK_MONOTONIC_RAW) {
> > +                             ts_a1 =3D ktime_to_timespec64(xtstamp_b.s=
ys_monoraw);
> > +                             ts_b =3D ktime_to_timespec64(xtstamp_b.de=
vice);
> > +                             goto out;
> > +                     } else if (clock_a =3D=3D CLOCK_REALTIME) {
> > +                             ts_a1 =3D ktime_to_timespec64(xtstamp_b.s=
ys_realtime);
> > +                             ts_b =3D ktime_to_timespec64(xtstamp_b.de=
vice);
> > +                             goto out;
> > +                     } else {
> > +                             crosstime_support_b =3D true;
> > +                     }
> > +             }
> > +     }
> > +
> > +     if (crosstime_support_a)
> > +             error =3D kc_a->clock_get_crosstimespec(clock_a, &xtstamp=
_a1);
>
> What? crosstime_support_a is only true when the exactly same call
> returned success. Why does it need to be called here again?
>
I wanted to take the three samples as close as possible to each other.
minimum code between the calls, that is why the call is done again.
> > +     else
> > +             error =3D kc_a->clock_get_timespec(clock_a, &ts_a1);
> > +
> > +     if (error)
> > +             return error;
> > +
> > +     if (crosstime_support_b)
> > +             error =3D kc_b->clock_get_crosstimespec(clock_b, &xtstamp=
_b);
> > +     else
> > +             error =3D kc_b->clock_get_timespec(clock_b, &ts_b);
> > +
> > +     if (error)
> > +             return error;
> > +
> > +     if (crosstime_support_a)
> > +             error =3D kc_a->clock_get_crosstimespec(clock_a, &xtstamp=
_a2);
> > +     else
> > +             error =3D kc_a->clock_get_timespec(clock_a, &ts_a2);
> > +
> > +     if (error)
> > +             return error;
>
> The logic and the code flow here are unreadable garbage and there are
> zero comments what this is supposed to do.
>
I will add comments.
please no need to use negative words like "garbage" (not the first time),
please keep it professional and civilized.
> > +     if (crosstime_support_a) {
> > +             ktime_a =3D ktime_sub(xtstamp_a2.device, xtstamp_a1.devic=
e);
> > +             ts_offs_err =3D ktime_divns(ktime_a, 2);
> > +             ktime_a =3D ktime_add_ns(xtstamp_a1.device, (u64)ts_offs_=
err);
> > +             ts_a1 =3D ktime_to_timespec64(ktime_a);
>
> This is just wrong.
>
>      read(a1);
>      read(b);
>      read(a2);
>
> You _CANNOT_ assume that (a1 + ((a2 - a1) / 2) is anywhere close to the
> point in time where 'b' is read. This code is preemtible and
> interruptible. I explained this to you before.
>
> Your explanation in the comment above the function is just wishful
> thinking.
>
you explained it before, but still it is better then two consecutive
user space calls which are also preemptible
and the userspace to kernel context switch time is added.
> > + * In other cases: Read clock_a twice (before, and after reading clock=
_b) and
> > + * average these times =E2=80=93 to be as close as possible to the tim=
e we read clock_b.
>
> Can you please sit down and provide a precise technical description of
> the problem you are trying to solve and explain your proposed solution
> at the conceptual level instead of throwing out random implementations
> every few days?
>

> Thanks,
>
>         tglx
>
>

