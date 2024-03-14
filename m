Return-Path: <linux-arch+bounces-3001-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C733C87C099
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 16:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C193285477
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C49571B54;
	Thu, 14 Mar 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1g3KvcG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B470CDE;
	Thu, 14 Mar 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431204; cv=none; b=HjPRS+jR1t35u2mwwMOCCYO0sA3KbPx3KFwYECb1LkDmhriuv7+lQI4RZp/tzzrtCm+b0X3WeEBtrp618/jjIH5iccEknKL13jV3b429rO/Rr+sxIjdayX/1dTFivCNY2pK42fRth/uGxhc9JhKfH1/llBVPuI90pL5KaxXeLmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431204; c=relaxed/simple;
	bh=oynWwKzA+0qEynlkdHoX9Q6l9nj+lEyOj7BCH09ZPG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxyPksmHkip5xvdNKpUU5GPFL231fXdGx7+/jjixTWabYfD42Oi4s1ljtO0BvHloeCv/9vxxe3JF0ip7M4+tuv3BAXvozx6hZd6siu1AVATF56RIjaPJXOM3ROVRQW3KeppNND/hrlI9cTZHgOBB3bmXnZ1d7AEPTeG7nkieOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1g3KvcG; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so2074170276.0;
        Thu, 14 Mar 2024 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710431201; x=1711036001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/0zUkiPOILO/41SCjmzy5gU7e3o5AEa1dCgcttcrlk=;
        b=j1g3KvcGw9T60rpGCp5HJPXzWVhYQGug6KtuTvkS4aFH+pmBi0PePKj90kDeqwGPVf
         +Qwg8H3hdDeMPYkqnwpt3WUH4XXKFrO2km+nG6Tlh1sDaQubRtYxBIun2tbHT2IjvoVF
         AZjgldjObbC1GL/FoOw5DA8eNA0ftr2T8RtduJNHZJdO78u2ajYk5dXvEL8OjGQf2ahG
         fiLTXCa4UtJ5UcwNfpgWjW8Id3wt8/h6Nsociu1dlHhsyVkQa+UcUHez+ceMcpVHGAXq
         luLeOhgf46BJrGhYv2Rc94Zk3t+hMBYqtwgv2zozsdHjeuFBDs+k7CHgwmNoF8MXQH9b
         rH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710431201; x=1711036001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/0zUkiPOILO/41SCjmzy5gU7e3o5AEa1dCgcttcrlk=;
        b=iVIUgFzoUodJzpq01+MEgipRF66kDeyb65zgkLM499DeW/EPX3qOEFk0o/Lj8px/Z0
         tAw70MjyWScLAo1f28nPFoQLqKmwZoir2Q0VN+eRoGee6emBHIB2KoR/7WDkSMxFliMk
         qFcDA4hfN/ZBK6Vf0vbHpRlyK9ok/4jHbfS4nwoXS+G+Cg8d3MiZsgPOqPm+mxZF0gxb
         wDXAvLGtAmkfExPfS56MInchQeXaBI2gKfx9jNX7VMtY5jeT3i25H9K/r5h3MrdiJFHN
         KxKXuT3Eje8ORH2eZaPyUPhwNf/i0aih/cKrkIGoHhNrc2TyjAY7FhOgZJjFXjXftJj6
         sYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYxN7+JFJ8HdswOjinWKS3E7nMqw1drf0cucaqx8XGWjNVdmHyerBEGae64XEps47lneHH4//vLkWUUCmyc6w9QhSlS5XErUuDu5si1AxPZ+i5g6qLWnQdf2i17uXaq5uU16/85HTy0ymmjqTP6q+OBBxSp5clHIkZHrBWqpz34jiojQ0MluLfELiu5df5YTURsOQO8tbA+/AcYg==
X-Gm-Message-State: AOJu0YwpFY11Kvt6FU4AgfC4s5DBCALR1WZB09OiMx/5Nm7RMrq6MPuv
	QKNstZxNobFQ4Mnzu5K+ykB0cfbaXlU96qdL6N9kr83oLwa19979rlskdz0Cw/xU6yArZXygNmJ
	CUPDkAtXnyGpYa6Y40ZFw6X07rsc=
X-Google-Smtp-Source: AGHT+IFWpDcrqPH8bTrfukl8C/qZJ0doZ+8wMTevLQt0xt9L6RzqWz8jGpLBgjlktd2V0/1FHh6G74lG9WC2EQCm/OI=
X-Received: by 2002:a25:acc2:0:b0:dc7:421d:bcc0 with SMTP id
 x2-20020a25acc2000000b00dc7421dbcc0mr1406120ybd.32.1710431201553; Thu, 14 Mar
 2024 08:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314090540.14091-1-maimon.sagi@gmail.com> <87a5n1m5j1.ffs@tglx>
In-Reply-To: <87a5n1m5j1.ffs@tglx>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Thu, 14 Mar 2024 17:46:30 +0200
Message-ID: <CAMuE1bHOm2Y1bOpggStMOjZhN5TaxoC1gJea5Mdrc+mormQg0g@mail.gmail.com>
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
> Also why does reading two random clocks make any sense at all? Your code
> allows to read CLOCK_TAI and CLOCK_THREAD_CPUTIME_ID. What for?
>
> This is about PTP, no?
>
> Again you completely fail to explain why the existing PTP ioctls are not
> sufficient for the purpose and why you need to provide a new interface
> which is completely ill defined.
>
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
> > +/**
> > + * clock_compare - Get couple of clocks time stamps
>
> So the name of the syscall suggest that it compares two clocks, but the
> actual functionality is to read two clocks.
>
> This does not make any sense at all. Naming matters.
>
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
I have missed this part on prviews reply.
I have read the documentation above and I think that the variable
declarations at the beginning of a function is in reverse fir tree
order
meaning from big to small, but I guess that I am missing something,
can you please explain what is wrong with the variable declaration,
so I can fix it.
> > +     kc_a =3D clockid_to_kclock(clock_a);
> > +     if (!kc_a) {
> > +             error =3D -EINVAL;
> > +             return error;
>
> What's wrong about 'return -EINVAL;' ?
>
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
> ptp_clock::info::getcrosststamp() has a reasonable name. So why do you
> need to come up with something which makes the code obfuscated?
>
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

