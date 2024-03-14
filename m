Return-Path: <linux-arch+bounces-3003-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EA287C264
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 19:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F3B1F21956
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 18:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BDE74BFC;
	Thu, 14 Mar 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aT+EGtJi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aANVTI7h"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F81A38D0;
	Thu, 14 Mar 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710439718; cv=none; b=c4t+ooFvZgijDPpbqXKkYVO6xlSlD5C0vd2zYOeZT2Gqpp9ZlpPUWL4yZiLSwSjVzZbK6I2OQxQrxfsN2UV77BhqzZ/wNwMiHSaYYFNNIzkifXT/PMAVzYzUfhCwgxyWuQKU7n3040zBwhEXJtng9z74B4ry1qUIYPeedOGNKfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710439718; c=relaxed/simple;
	bh=HLUOAUrDzV7DxVMN0MxM0Ufj95FkyixguL4INhuBVIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uT0ic7rvpSc6AGlbfv2xFftqIM7SWKabOwvloMNBXB0bW5jXdohIEVQ2y8aRxs58Yh8r+czhC7uuQ3a+BgagN9sFvsJC3h6/MJjj1PS3qn/YAgmeaxN1D4S8XcGSN5QoFN/t46z52VxoxTE1LoRuCKN3N61ZcttcSKu4O8X6jhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aT+EGtJi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aANVTI7h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710439714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16cvIJ2YvrUsZ0d98Y92QlX/G3wvBrRS0NjV/OMLMF4=;
	b=aT+EGtJiZ6UV2DD69bc5zMIFik3LjX0gRQevRffKSrctx83zDViJLxkoZbTy/c+DU6erXG
	qR9l7T75X4gscByXW86TV4KxUUKj9PutGsU3P3xeAZy2ia7K7tW7bNaXrOPiYefLCTq6c1
	ga3Z/h5Jku3Gn3ubdF2kah4KEv0rkReBNV0u1rbVCPg3fOMB0SJEBqWEKswuJQ+1M+vhZt
	u57XuBdkQL3rVhAg5/fLqx6ABr1gsQcXXKGeu62KDom1RvD1GQpYs79mRgiSr2ZTwVd6FX
	SPof07+UkpcadZP3/SZU6xNvgzBHO368LMS21EDCcknbd4nyteFq8juE9J+c3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710439714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16cvIJ2YvrUsZ0d98Y92QlX/G3wvBrRS0NjV/OMLMF4=;
	b=aANVTI7hO3beW0DN3UGlouKtV7eAeXMpaQPSq4Ug8yXUSCJiVIu0U8mGdMayo0DmPS1EYY
	9jDtVtgKUWu1rtCg==
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, luto@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, geert@linux-m68k.org,
 peterz@infradead.org, hannes@cmpxchg.org, sohil.mehta@intel.com,
 rick.p.edgecombe@intel.com, nphamcs@gmail.com, palmer@sifive.com,
 keescook@chromium.org, legion@kernel.org, mark.rutland@arm.com,
 mszeredi@redhat.com, casey@schaufler-ca.com, reibax@gmail.com,
 davem@davemloft.net, brauner@kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
In-Reply-To: <CAMuE1bH_H9E+Zx365G9AtmWSmhW-kPPB+-=8s2rH4hpxqE+dHQ@mail.gmail.com>
References: <20240314090540.14091-1-maimon.sagi@gmail.com>
 <87a5n1m5j1.ffs@tglx>
 <CAMuE1bH_H9E+Zx365G9AtmWSmhW-kPPB+-=8s2rH4hpxqE+dHQ@mail.gmail.com>
Date: Thu, 14 Mar 2024 19:08:33 +0100
Message-ID: <874jd8n0ta.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sagi!

On Thu, Mar 14 2024 at 14:19, Sagi Maimon wrote:
> On Thu, Mar 14, 2024 at 1:12=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> On Thu, Mar 14 2024 at 11:05, Sagi Maimon wrote:
>> > Some user space applications need to read a couple of different clocks.
>> > Each read requires moving from user space to kernel space.
>> > Reading each clock separately (syscall) introduces extra
>> > unpredictable/unmeasurable delay. Minimizing this delay contributes to=
 user
>> > space actions on these clocks (e.g. synchronization etc).
>>
>> I asked for a proper description of the actual problem several times now
>> and you still provide some handwaving blurb. Feel free to ignore me, but
>> then please don't be surprised if I ignore you too.
>>
> Nobody is ignoring your notes, and I address any notes given by any
> maintainer in the most serious way.
> As far as explaining the actual problem this is the best that I can,
> but let me try to explain better:
> We did many tests with different CPU loading and compared sampling the
> same clock twice,
> once in user space and once by using the system call.
> We have noticed an improvement up to hundreds of nanoseconds while
> using the system call.
> Those results improved our ability to sync different PHCs

So let me express how I understand the problem - as far as I decoded it
from your writeups:

  Synchronizing two PHCs requires to read timestamps from both and
  correlate them. Currently this requires several seperate system calls.
  This is subject to unmeasurable delays due to system call overhead,
  preemption and interrupts which makes the correlation imprecise.

  Therefore you want a system call, which samples two clocks at once, to
  make the correlation more precise.

Right? For the further comments I assume this is what you are trying to
say and to solve.

So far so good, except that I do not agree with that reasoning at all:

   1. The delays are measurable and as precise as the cross time stamp
      mechanism (hardware or software based) allows.

   2. The system call overhead is completely irrelevant.

   3. The time deltas between the sample points are irrelevant within a
      reasonable upper bound to the time delta between the two outer
      sample points.

   4. The alledged higher precision is based on a guesstimate and not on
      correctness. Just because it behaves slightly better in testing
      does not make it any more correct.

   5. The problem can be solved with maximal possible accuracy by using
      the existing PTP IOCTLs.

See below.

>> Also why does reading two random clocks make any sense at all? Your code
>> allows to read CLOCK_TAI and CLOCK_THREAD_CPUTIME_ID. What for?
>>
> Initially we needed to sync some different PHCs for our user space
> application, that is why we came with this idea.
> The first idea was an IOCTL that returned samples of several PHCs for
> the need of synchronization.
> Richard Cochran suggested a system call instead, which will add the
> ability to get various system clocks, while this
> implementation is more complex then IOCTL, I think that he was right,
> for future usage.

Which future usage? We are not introducing swiss army knife interfaces
just because there might be an illusional use case somewhere in the
unspecified future.

Adding a system call needs a proper design and justification. Handwaving
future usage is not enough.

Documentation/process/adding-syscalls.rst is very clear about what is
required for a new system call.

>> This needs to be split up into:
>>
>>      1) Infrastructure in posix-timers.c
>>      2) Wire up the syscall in x86
>>      3) Infrastructure in posix-clock.c
>>      4) Usage in ptp_clock.c
>>
>> and not as a big lump of everything.
>>
> I know, but I think the benefit worth it

It's worth it because it makes review easier. It's well documented in
the process documentation that patches should do one thing and not a
whole lump of changes.

>> > +             if (!error) {
>> > +                     if (clock_b =3D=3D CLOCK_MONOTONIC_RAW) {
>> > +                             ts_b =3D ktime_to_timespec64(xtstamp_a1.=
sys_monoraw);
>> > +                             ts_a1 =3D ktime_to_timespec64(xtstamp_a1=
.device);
>> > +                             goto out;
>> > +                     } else if (clock_b =3D=3D CLOCK_REALTIME) {
>> > +                             ts_b =3D ktime_to_timespec64(xtstamp_a1.=
sys_realtime);
>> > +                             ts_a1 =3D ktime_to_timespec64(xtstamp_a1=
.device);
>> > +                             goto out;
>> > +                     } else {
>> > +                             crosstime_support_a =3D true;
>>
>> Right. If clock_b is anything else than CLOCK_MONOTONIC_RAW or
>> CLOCK_REALTIME then this is true.
>>
>> > +                     }
>> > +             }
>>
>> So in case of an error, this just keeps going with an uninitialized
>> xtstamp_a1 and if the clock_b part succeeds it continues and operates on
>> garbage.
>>
> On error  xtstamp_a1 will be taken again using clock_get_crosstimespec
> so no one will be operating on garbage.

It will not, because crosstime_support_a =3D=3D false. It will therefore
fall back to kc_a->clock_get_timespec(), no?

Sorry, I misread the code vs. using the uninitialized value, but this is
just unneccesary hard to follow.

>> > +     if (crosstime_support_a)
>> > +             error =3D kc_a->clock_get_crosstimespec(clock_a, &xtstam=
p_a2);
>> > +     else
>> > +             error =3D kc_a->clock_get_timespec(clock_a, &ts_a2);
>> > +
>> > +     if (error)
>> > +             return error;
>>
>> The logic and the code flow here are unreadable garbage and there are
>> zero comments what this is supposed to do.
>>
> I will add comments.
> please no need to use negative words like "garbage" (not the first time),
> please keep it professional and civilized.

Let me rephrase:

The code and the logic is incomprehensible unless I waste an unjustified
amount of time to decode it. Sorry, I don't have that time.

>> > +     if (crosstime_support_a) {
>> > +             ktime_a =3D ktime_sub(xtstamp_a2.device, xtstamp_a1.devi=
ce);
>> > +             ts_offs_err =3D ktime_divns(ktime_a, 2);
>> > +             ktime_a =3D ktime_add_ns(xtstamp_a1.device, (u64)ts_offs=
_err);
>> > +             ts_a1 =3D ktime_to_timespec64(ktime_a);
>>
>> This is just wrong.
>>
>>      read(a1);
>>      read(b);
>>      read(a2);
>>
>> You _CANNOT_ assume that (a1 + ((a2 - a1) / 2) is anywhere close to the
>> point in time where 'b' is read. This code is preemtible and
>> interruptible. I explained this to you before.
>>
>> Your explanation in the comment above the function is just wishful
>> thinking.
>>
> you explained it before, but still it is better then two consecutive
> user space calls which are also preemptible
> and the userspace to kernel context switch time is added.

It might be marginally better, but it is still just _pretending_ that it
does the right thing, is correct and better than the existing IOCTLs.

If your user space implementation has the same algorithm, then I'm
absolutely not surprised that the results are not useful. Why?

You simply cannot use the midpoint of the outer samples if you want to
have precise results if there is no guarantee that b was sampled exactly
in the midpoint of a1 and a2. A hardware implementation might give that
guarantee, but the kernel cannot.

But why using the midpoint in the first place?

There is absolutely no reason to do so because the sampling points a1, b
and a2 can be precisely determined with the precision of the cross time
stamp mechanism, which is best with a hardware based cross time stamp
obviously.

The whole point of ptp::info::getcrosststamp() is to get properly
correlated clock samples of

      1) PHC clock
      2) CLOCK_MONOTONIC_RAW
      3) CLOCK_REALTIME

So if you take 3 samples:

   get_cross_timestamp(a1);
   get_cross_timestamp(b);
   get_cross_timestamp(a2);
=20=20=20
then each of them provides:

    - device time
    - correlated CLOCK_MONOTONIC_RAW
    - correlated CLOCK_REALTIME

Ergo the obvious thing to do is:

    d1 =3D b.sys_monoraw - a1.sys_monoraw;
    d2 =3D a2.sys_monoraw - a1.sys_monoraw;
=20=20=20=20
    tsa =3D a1.device + ((a2.device - a1.device) * d1) / d2;
=20=20=20=20
Which is maximaly precise under the assumption that in the time between
the sample points a1 and a2 neither the system clock nor the PCH clocks
are changing their frequency significantly. That is a valid assumption
when you put a reasonable upper bound on d2.

Even when the device does not implement getcrosststamp() then loop based
sampling like it is implemented in the PTP_SYS_OFFSET[_EXTENDED] IOTCLs
is providing reasonably accurate results to the extent possible.

Your algorithm is imprecise by definition and you can apply as much
testing as you want, it won't become magically correct. It's still a
guesstimate, i.e. an estimate made without using adequate or complete
information.

Now why a new syscall?

This can be done from user space with existing interfaces and the very
same precision today:

     ioctl(fda, PTP_SYS_OFFSET*, &a1);
     ioctl(fdb, PTP_SYS_OFFSET*, &b);
     ioctl(fda, PTP_SYS_OFFSET*, &a2);

     u64 d1 =3D timespec_delta_ns(b.sys_monoraw, a1.sys_monoraw);
     u64 d2 =3D timespec_delta_ns(a2.sys_monoraw, a1.sys_monoraw);
     u64 td =3D (timespec_delta_ns(a2.device, a1.device) * d1) / d2

     tsa =3D timespec_add_ns(a1.device, td);
     tsb =3D b.device;

with the extra benefit of:

     1) The correct CLOCK_REALTIME at that sample point,
        i.e. b.sys_realtime

     2) The correct CLOCK_MONOTONIC_RAW at that sample point,
        i.e. b.sys_monoraw

It works with PTP_SYS_OFFSET_PRECISE and PTP_SYS_OFFSET[_EXTENDED], with
the obvious limitations of PTP_SYS_OFFSET[_EXTENDED], which are still
vastly superior to your proposed (a2 - a1) / 2 guestimate which is just
reading the PCH clocks with clock_get_timespec().

It is completely independent of the load, the syscall overhead and the
actual time delta between the sample points when you apply a reasonable
upper bound for d2, i.e. the time delta between the sample points a1 and
a2 to eliminate the issue that system clock and/or the PCH clocks change
their frequency significantly during that time. You'd need to do that in
the kernel too.

The actual frequency difference between PCH A and system clock is
completely irrelevant when the frequencies of both are stable accross
the sample period.

You might still argue that the time delta between the sample points a1
and a2 matters and is slightly shorter in the kernel, but that is a
non-argument because:

  1) The kernel implementation does not guarantee atomicity of the
     consecutive samples either. The time delta is just statistically
     better, which is obviously useless when you want to make
     guarantees.

  2) It does not matter when the time delta is slightly larger because
     you need a large frequency change of the involved clocks in the
     sample interval between the sample points a1 and a2 to make an
     actual difference in the resulting accuracy.

     A typical temperature drift of a high quality cyrstal is less than
     1ppm per degree Celsius and even if you assume that the overall
     system drift is 10ppm per degree Celsius then still the actual
     error for a bound time delta between the sample points a1 and a2 is
     just somewhere in the irrelevant noise, unless you manage to blow
     torch or ice spray your crystals during the sample interval.

     If your clocks are not stable enough then nothing can cure it and
     you cannot do high precision timekeeping with them.

So what is your new syscall solving that can't be done with the existing
IOCTLs other than providing worse precision results based on
guesstimates and some handwavy future use for random clock ids?

Nothing as far as I can tell, but I might be missing something important
here.

Thanks,

        tglx
---
arch/x86/kernel/tsc.c:119: "Math is hard, let's go shopping." - John Stultz

