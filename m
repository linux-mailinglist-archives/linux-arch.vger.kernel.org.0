Return-Path: <linux-arch+bounces-3051-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F388138E
	for <lists+linux-arch@lfdr.de>; Wed, 20 Mar 2024 15:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42741B23542
	for <lists+linux-arch@lfdr.de>; Wed, 20 Mar 2024 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D7248792;
	Wed, 20 Mar 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8FA6zDN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F65481A0;
	Wed, 20 Mar 2024 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945765; cv=none; b=Ztlt/8n1UMpdZLR6vyck4ydvRIWn6g2Nw7nZZH/Fdy6IwxzpehhkpeFLbr4LKpX7YL0TRFU83HquJwil2wQi/XN9uATVSdVPliOg4l0g1v+wQ2fVZMC1hnjjvWByslgKNKQov0p6cw8tyubvf35F9cNkLC8IWusTYcebUgH0cew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945765; c=relaxed/simple;
	bh=MIsF5kkI3SJJdhDgYKRsR2pkphwYmwvVJzj4oC6fWfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upnUFI8GV+DvIfYMIZ4AJnX2K0gTrEHxO9lWyCy6Qxhq6TBtzszqjLstdzC/7KsFqeBJ0oCIJ+qV91lv94Cpi89hAG8xajMAuAtVMsPzTgGmECmPkt3D1UjIyR9AOwtyf81Gd+Bb+1TCccJ09xoV5MDxAdCyCDuAjtMawtMxnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8FA6zDN; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-609ed7ca444so64626107b3.1;
        Wed, 20 Mar 2024 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710945763; x=1711550563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBp7t6RwweSP3AcjkYZsGsSbnooWBNVHZWHK5RKW3Ig=;
        b=K8FA6zDNP8sb4Kl9PzWxERB00pxRsewRqknsjaDDUPbMK0tyrYNRifbpVdrTT7C9FA
         X2CS07XSOTojEoea28CvVV3fKWcystd+b1IstluqFdfuxWCCpwLwlWbRBLmM45oohscQ
         xutkyYrw3fZbIvReZqIrzXGyoC6DsVGN3Y1G8Ukb1TS84CMnSBiS+NCXO3uT3zZpkneP
         Rh6MZAse3C1Ep+SPhKEgn/MkZCnKGFjXfzeB2G74Q6mF+c1WYruQFUhIV4oZG3cyOYMW
         NX7iXw33K3YvtlvXOzusV1QFM/kkn0+QpiUpoCvcx61o2Ot9frSOXeUGqXDtQHDMnoZs
         Y+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710945763; x=1711550563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBp7t6RwweSP3AcjkYZsGsSbnooWBNVHZWHK5RKW3Ig=;
        b=o5z6SJCcn9gYLEh0dJorvv5EJNrYSz+DEKRnmqSj1wTEJ85H/jeJE5O1tpatTT2yt5
         7+DKcUjFUSItSzARm1tG8rUka3+e7oc3iWaQIulhfpTJfneIaUvk7V+KdamCJaFTLuUH
         vnS4pR9qDCqqZQ3RnBM51jjZggXtu+s+hiS65skF0M5iF41EUgQzxys6s9RxP/vFVTT6
         vXVrFQJd2QcIhCCBP4vPr6DKFwsOh/3iQX1Z7U2UjrpbeaSx2V7cnRWh0EKWPHWDZKH3
         8LhbKfRBBJ+wis36STS8+oEatGrhoqS2CZ76ob1N1A2yJDlb1ksUfTPwgXkZLHNpIZUy
         /DFg==
X-Forwarded-Encrypted: i=1; AJvYcCVj3nvO/wSQ2G7i7l0Ntzwp9O17OLB1qCkfiPKqJcnNeDUZRDKo3e+5EY8Lhy3Sd6of0qWS1MuEc+GnJbD594T4nRWRsb82FBXwZrYwdmVGYitzIdHjUDAyjLLzvh8IOhRx0GFytI8IpfWEVhOpT0dbHAwWzL6/53iVKfQNDDJ8slNR67PNiIhJxGw26OlWvErV4D9ecqa6Ga/WOA==
X-Gm-Message-State: AOJu0YwlBvNO7myqb/OMdoxm+pApGhWPnqo62OWSjE0diO/4u4xHgAW5
	NkecETtBzkuSjt2rBDrVXBcuYJDWpluTDaFl/q9IQZ5jcrDlWXBD6T4MT/DBy0j3ti9DDezcuIh
	D6xGr6tic/g0jO8xdIHfBKEXGHW0=
X-Google-Smtp-Source: AGHT+IEsQiFWtlat7AgEDVCBHwwgcLmaG/w2KzYaiwhVotv2pJm229/hp83EtQU74NoUMqGwHEKW0dLOXF0BVHTW5FY=
X-Received: by 2002:a25:b2a2:0:b0:dd1:2dee:ea21 with SMTP id
 k34-20020a25b2a2000000b00dd12deeea21mr14589569ybj.8.1710945762460; Wed, 20
 Mar 2024 07:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314090540.14091-1-maimon.sagi@gmail.com> <87a5n1m5j1.ffs@tglx>
 <CAMuE1bH_H9E+Zx365G9AtmWSmhW-kPPB+-=8s2rH4hpxqE+dHQ@mail.gmail.com> <874jd8n0ta.ffs@tglx>
In-Reply-To: <874jd8n0ta.ffs@tglx>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Wed, 20 Mar 2024 16:42:31 +0200
Message-ID: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
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

On Thu, Mar 14, 2024 at 8:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Sagi!
>
> On Thu, Mar 14 2024 at 14:19, Sagi Maimon wrote:
> > On Thu, Mar 14, 2024 at 1:12=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> On Thu, Mar 14 2024 at 11:05, Sagi Maimon wrote:
> >> > Some user space applications need to read a couple of different cloc=
ks.
> >> > Each read requires moving from user space to kernel space.
> >> > Reading each clock separately (syscall) introduces extra
> >> > unpredictable/unmeasurable delay. Minimizing this delay contributes =
to user
> >> > space actions on these clocks (e.g. synchronization etc).
> >>
> >> I asked for a proper description of the actual problem several times n=
ow
> >> and you still provide some handwaving blurb. Feel free to ignore me, b=
ut
> >> then please don't be surprised if I ignore you too.
> >>
> > Nobody is ignoring your notes, and I address any notes given by any
> > maintainer in the most serious way.
> > As far as explaining the actual problem this is the best that I can,
> > but let me try to explain better:
> > We did many tests with different CPU loading and compared sampling the
> > same clock twice,
> > once in user space and once by using the system call.
> > We have noticed an improvement up to hundreds of nanoseconds while
> > using the system call.
> > Those results improved our ability to sync different PHCs
>
> So let me express how I understand the problem - as far as I decoded it
> from your writeups:
>
>   Synchronizing two PHCs requires to read timestamps from both and
>   correlate them. Currently this requires several seperate system calls.
>   This is subject to unmeasurable delays due to system call overhead,
>   preemption and interrupts which makes the correlation imprecise.
>
>   Therefore you want a system call, which samples two clocks at once, to
>   make the correlation more precise.
>
> Right? For the further comments I assume this is what you are trying to
> say and to solve
You are right.
>
> So far so good, except that I do not agree with that reasoning at all:
>
>    1. The delays are measurable and as precise as the cross time stamp
>       mechanism (hardware or software based) allows.
>

Most of the PHCs do not support crosstime stamps.

>    2. The system call overhead is completely irrelevant.
>

You are right in case of long preemption, but in other cases it is relevant=
.

>    3. The time deltas between the sample points are irrelevant within a
>       reasonable upper bound to the time delta between the two outer
>       sample points.
>

See below

>    4. The alledged higher precision is based on a guesstimate and not on
>       correctness. Just because it behaves slightly better in testing
>       does not make it any more correct.
>

See below

>    5. The problem can be solved with maximal possible accuracy by using
>       the existing PTP IOCTLs.
>
> See below.
>
> >> Also why does reading two random clocks make any sense at all? Your co=
de
> >> allows to read CLOCK_TAI and CLOCK_THREAD_CPUTIME_ID. What for?
> >>
> > Initially we needed to sync some different PHCs for our user space
> > application, that is why we came with this idea.
> > The first idea was an IOCTL that returned samples of several PHCs for
> > the need of synchronization.
> > Richard Cochran suggested a system call instead, which will add the
> > ability to get various system clocks, while this
> > implementation is more complex then IOCTL, I think that he was right,
> > for future usage.
>
> Which future usage? We are not introducing swiss army knife interfaces
> just because there might be an illusional use case somewhere in the
> unspecified future.
>
> Adding a system call needs a proper design and justification. Handwaving
> future usage is not enough.
>
> Documentation/process/adding-syscalls.rst is very clear about what is
> required for a new system call.
>
> >> This needs to be split up into:
> >>
> >>      1) Infrastructure in posix-timers.c
> >>      2) Wire up the syscall in x86
> >>      3) Infrastructure in posix-clock.c
> >>      4) Usage in ptp_clock.c
> >>
> >> and not as a big lump of everything.
> >>
> > I know, but I think the benefit worth it
>
> It's worth it because it makes review easier. It's well documented in
> the process documentation that patches should do one thing and not a
> whole lump of changes.
>

No problem it will be split into two different patches.

> >> > +             if (!error) {
> >> > +                     if (clock_b =3D=3D CLOCK_MONOTONIC_RAW) {
> >> > +                             ts_b =3D ktime_to_timespec64(xtstamp_a=
1.sys_monoraw);
> >> > +                             ts_a1 =3D ktime_to_timespec64(xtstamp_=
a1.device);
> >> > +                             goto out;
> >> > +                     } else if (clock_b =3D=3D CLOCK_REALTIME) {
> >> > +                             ts_b =3D ktime_to_timespec64(xtstamp_a=
1.sys_realtime);
> >> > +                             ts_a1 =3D ktime_to_timespec64(xtstamp_=
a1.device);
> >> > +                             goto out;
> >> > +                     } else {
> >> > +                             crosstime_support_a =3D true;
> >>
> >> Right. If clock_b is anything else than CLOCK_MONOTONIC_RAW or
> >> CLOCK_REALTIME then this is true.
> >>
> >> > +                     }
> >> > +             }
> >>
> >> So in case of an error, this just keeps going with an uninitialized
> >> xtstamp_a1 and if the clock_b part succeeds it continues and operates =
on
> >> garbage.
> >>
> > On error  xtstamp_a1 will be taken again using clock_get_crosstimespec
> > so no one will be operating on garbage.
>
> It will not, because crosstime_support_a =3D=3D false. It will therefore
> fall back to kc_a->clock_get_timespec(), no?
>
> Sorry, I misread the code vs. using the uninitialized value, but this is
> just unneccesary hard to follow.
>
> >> > +     if (crosstime_support_a)
> >> > +             error =3D kc_a->clock_get_crosstimespec(clock_a, &xtst=
amp_a2);
> >> > +     else
> >> > +             error =3D kc_a->clock_get_timespec(clock_a, &ts_a2);
> >> > +
> >> > +     if (error)
> >> > +             return error;
> >>
> >> The logic and the code flow here are unreadable garbage and there are
> >> zero comments what this is supposed to do.
> >>
> > I will add comments.
> > please no need to use negative words like "garbage" (not the first time=
),
> > please keep it professional and civilized.
>
> Let me rephrase:
>
> The code and the logic is incomprehensible unless I waste an unjustified
> amount of time to decode it. Sorry, I don't have that time.
>
> >> > +     if (crosstime_support_a) {
> >> > +             ktime_a =3D ktime_sub(xtstamp_a2.device, xtstamp_a1.de=
vice);
> >> > +             ts_offs_err =3D ktime_divns(ktime_a, 2);
> >> > +             ktime_a =3D ktime_add_ns(xtstamp_a1.device, (u64)ts_of=
fs_err);
> >> > +             ts_a1 =3D ktime_to_timespec64(ktime_a);
> >>
> >> This is just wrong.
> >>
> >>      read(a1);
> >>      read(b);
> >>      read(a2);
> >>
> >> You _CANNOT_ assume that (a1 + ((a2 - a1) / 2) is anywhere close to th=
e
> >> point in time where 'b' is read. This code is preemtible and
> >> interruptible. I explained this to you before.
> >>
> >> Your explanation in the comment above the function is just wishful
> >> thinking.
> >>
> > you explained it before, but still it is better then two consecutive
> > user space calls which are also preemptible
> > and the userspace to kernel context switch time is added.
>
> It might be marginally better, but it is still just _pretending_ that it
> does the right thing, is correct and better than the existing IOCTLs.
>
> If your user space implementation has the same algorithm, then I'm
> absolutely not surprised that the results are not useful. Why?
>
> You simply cannot use the midpoint of the outer samples if you want to
> have precise results if there is no guarantee that b was sampled exactly
> in the midpoint of a1 and a2. A hardware implementation might give that
> guarantee, but the kernel cannot.
>
> But why using the midpoint in the first place?
>
> There is absolutely no reason to do so because the sampling points a1, b
> and a2 can be precisely determined with the precision of the cross time
> stamp mechanism, which is best with a hardware based cross time stamp
> obviously.
>
> The whole point of ptp::info::getcrosststamp() is to get properly
> correlated clock samples of
>
>       1) PHC clock
>       2) CLOCK_MONOTONIC_RAW
>       3) CLOCK_REALTIME
>
> So if you take 3 samples:
>
>    get_cross_timestamp(a1);
>    get_cross_timestamp(b);
>    get_cross_timestamp(a2);
>
> then each of them provides:
>
>     - device time
>     - correlated CLOCK_MONOTONIC_RAW
>     - correlated CLOCK_REALTIME
>
> Ergo the obvious thing to do is:
>
>     d1 =3D b.sys_monoraw - a1.sys_monoraw;
>     d2 =3D a2.sys_monoraw - a1.sys_monoraw;
>
>     tsa =3D a1.device + ((a2.device - a1.device) * d1) / d2;
>
> Which is maximaly precise under the assumption that in the time between
> the sample points a1 and a2 neither the system clock nor the PCH clocks
> are changing their frequency significantly. That is a valid assumption
> when you put a reasonable upper bound on d2.
>

You are right.
In fact, we are running this calculation on a user space application.
We use the new system call to get pairs of mono and PHC and then run
that calculation in user space.
That is why the system call returns pairs of clock samples and not the
diff between them.

> Even when the device does not implement getcrosststamp() then loop based
> sampling like it is implemented in the PTP_SYS_OFFSET[_EXTENDED] IOTCLs
> is providing reasonably accurate results to the extent possible.
>
> Your algorithm is imprecise by definition and you can apply as much
> testing as you want, it won't become magically correct. It's still a
> guesstimate, i.e. an estimate made without using adequate or complete
> information.
>
> Now why a new syscall?
>
> This can be done from user space with existing interfaces and the very
> same precision today:
>
>      ioctl(fda, PTP_SYS_OFFSET*, &a1);
>      ioctl(fdb, PTP_SYS_OFFSET*, &b);
>      ioctl(fda, PTP_SYS_OFFSET*, &a2);
>
>      u64 d1 =3D timespec_delta_ns(b.sys_monoraw, a1.sys_monoraw);
>      u64 d2 =3D timespec_delta_ns(a2.sys_monoraw, a1.sys_monoraw);
>      u64 td =3D (timespec_delta_ns(a2.device, a1.device) * d1) / d2
>
>      tsa =3D timespec_add_ns(a1.device, td);
>      tsb =3D b.device;
>
> with the extra benefit of:
>
>      1) The correct CLOCK_REALTIME at that sample point,
>         i.e. b.sys_realtime
>
>      2) The correct CLOCK_MONOTONIC_RAW at that sample point,
>         i.e. b.sys_monoraw
>
If PTP_SYS_OFFSET IOCTL returns sys_monoraw, then you are right, but
unfortunately the only IOCTL that returns sys_monoraw is
PTP_SYS_OFFSET_PRECISE (getcrosststamp)
And most of the drivers does not support it.

> It works with PTP_SYS_OFFSET_PRECISE and PTP_SYS_OFFSET[_EXTENDED], with
> the obvious limitations of PTP_SYS_OFFSET[_EXTENDED], which are still
> vastly superior to your proposed (a2 - a1) / 2 guestimate which is just
> reading the PCH clocks with clock_get_timespec().
>
It only works with PTP_SYS_OFFSET_PRECISE (which most of the NIC
drivers does not support and I take it under consideration in my
system call),
PTP_SYS_OFFSET_EXTENDED ioctl returns system time before, PHC, system
time after , and no monotic raw.

> It is completely independent of the load, the syscall overhead and the
> actual time delta between the sample points when you apply a reasonable
> upper bound for d2, i.e. the time delta between the sample points a1 and
> a2 to eliminate the issue that system clock and/or the PCH clocks change
> their frequency significantly during that time. You'd need to do that in
> the kernel too.
>
> The actual frequency difference between PCH A and system clock is
> completely irrelevant when the frequencies of both are stable accross
> the sample period.
>
> You might still argue that the time delta between the sample points a1
> and a2 matters and is slightly shorter in the kernel, but that is a
> non-argument because:
>
>   1) The kernel implementation does not guarantee atomicity of the
>      consecutive samples either. The time delta is just statistically
>      better, which is obviously useless when you want to make
>      guarantees.
>
>   2) It does not matter when the time delta is slightly larger because
>      you need a large frequency change of the involved clocks in the
>      sample interval between the sample points a1 and a2 to make an
>      actual difference in the resulting accuracy.
>
>      A typical temperature drift of a high quality cyrstal is less than
>      1ppm per degree Celsius and even if you assume that the overall
>      system drift is 10ppm per degree Celsius then still the actual
>      error for a bound time delta between the sample points a1 and a2 is
>      just somewhere in the irrelevant noise, unless you manage to blow
>      torch or ice spray your crystals during the sample interval.
>
>      If your clocks are not stable enough then nothing can cure it and
>      you cannot do high precision timekeeping with them.
>

You are right in case of long preemption (which still the system call
is better), but in other cases it is relevant.

> So what is your new syscall solving that can't be done with the existing
> IOCTLs other than providing worse precision results based on
> guesstimates and some handwavy future use for random clock ids?
>
> Nothing as far as I can tell, but I might be missing something important
> here.
>
Few points to consider:
1) Most of the PHCs do not support cross time stamping.
2) Users can implement your suggested code in user space while using
the new system call to get pairs of mono and PHC
     . This is what we did already in user space.
3) User with less tight requirement will benefit high accuracy with
the new system call

> Thanks,
>
>         tglx
> ---
> arch/x86/kernel/tsc.c:119: "Math is hard, let's go shopping." - John Stul=
tz

