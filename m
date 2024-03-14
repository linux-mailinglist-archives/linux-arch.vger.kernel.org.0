Return-Path: <linux-arch+bounces-2993-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECBE87BBBF
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 12:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421371C21585
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145B36EB51;
	Thu, 14 Mar 2024 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RxskWsvF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MvU6loUP"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2316EB4B;
	Thu, 14 Mar 2024 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414727; cv=none; b=e3hH2VCatAkU8DkCGwD+OLXB3CjhAM6fv+pEHlaidL6K6fU26oStlPEMB1B7h/eUK5nPTfvjMTUGVQCRFNZ7hvdUUVvvM4thF5sMKu6VuXm5YHJpHFRZllohxW32H0oH4Np2pTufy6yumJ5Wlw0oBb5wCuK8ip1rIvCPnGS7tNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414727; c=relaxed/simple;
	bh=Hoagb8gyqy/PzjnvIW63L0OXtOniHbnY8hLDZ8e4uFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T8Vk6bi9n9rbJj9BKc0VWU2fyrzRTncA+DH200SXum2LLQLsnenkq/xGqAJDJiCeD1d42yCKiMI44EM6Z0GXeoXglrFtL8M0RvbvxfOHIUYQev/YcA0jL+/mXf37Rak2FAlhsicEl/w5vku5m8KpfqIFar+sXLHhh60CUSk3gjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RxskWsvF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MvU6loUP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710414723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lu8ShuVKrbKop4FD3bkCAEtWnvqRDPJHCFNcL+UaYi8=;
	b=RxskWsvFct1xDfovunWFgKvRWEnWBvg0zgcbmQ/E0rTl+JnkFh9tgM8JT9KMqLNesWAUnR
	LHose+OfcJAfomC2Vx1bqxlmcbn7nUMnwJeuOuRMa5qOw5GM34pW6rMyCaEoWBCVHGi0Qu
	WoVFSNwMj8PCNUk5PCKFQmhHY8bQbWs6jFUipa156cLdcyrjRso53uO8Sz2S9b+ugdiWdt
	o04ixfs0/apgXVsMyNr6vz+HDqag0+4rXGVtqJvVm2Pzlu0+w3Cvwap4X/jd6kLzR+GBsk
	MGIAgyuXpEwlwf3PTTAnwY47cLas6p5ZWTbZVR0YC2TWPY90cR4shQStdiyUng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710414723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lu8ShuVKrbKop4FD3bkCAEtWnvqRDPJHCFNcL+UaYi8=;
	b=MvU6loUPlrEqABbRXdEdBF47XWDU0NetaiAbJ+5WZ3AYjCNvKURZuhSJILweMcpNZ+Rnml
	dIXni+5EIbTnNtDw==
To: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
 luto@kernel.org, datglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 geert@linux-m68k.org, peterz@infradead.org, hannes@cmpxchg.org,
 sohil.mehta@intel.com, rick.p.edgecombe@intel.com, nphamcs@gmail.com,
 palmer@sifive.com, maimon.sagi@gmail.com, keescook@chromium.org,
 legion@kernel.org, mark.rutland@arm.com, mszeredi@redhat.com,
 casey@schaufler-ca.com, reibax@gmail.com, davem@davemloft.net,
 brauner@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
In-Reply-To: <20240314090540.14091-1-maimon.sagi@gmail.com>
References: <20240314090540.14091-1-maimon.sagi@gmail.com>
Date: Thu, 14 Mar 2024 12:12:02 +0100
Message-ID: <87a5n1m5j1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14 2024 at 11:05, Sagi Maimon wrote:
> Some user space applications need to read a couple of different clocks.
> Each read requires moving from user space to kernel space.
> Reading each clock separately (syscall) introduces extra
> unpredictable/unmeasurable delay. Minimizing this delay contributes to us=
er
> space actions on these clocks (e.g. synchronization etc).

I asked for a proper description of the actual problem several times now
and you still provide some handwaving blurb. Feel free to ignore me, but
then please don't be surprised if I ignore you too.

Also why does reading two random clocks make any sense at all? Your code
allows to read CLOCK_TAI and CLOCK_THREAD_CPUTIME_ID. What for?

This is about PTP, no?

Again you completely fail to explain why the existing PTP ioctls are not
sufficient for the purpose and why you need to provide a new interface
which is completely ill defined.

> arch/x86/entry/syscalls/syscall_64.tbl |   1 +
> drivers/ptp/ptp_clock.c                |  34 ++++--
> include/linux/posix-clock.h            |   2 +
> include/linux/syscalls.h               |   4 +
> include/uapi/asm-generic/unistd.h      |   5 +-
> kernel/time/posix-clock.c              |  25 +++++
> kernel/time/posix-timers.c             | 138 +++++++++++++++++++++++++
> kernel/time/posix-timers.h             |   2 +

This needs to be split up into:

     1) Infrastructure in posix-timers.c
     2) Wire up the syscall in x86
     3) Infrastructure in posix-clock.c
     4) Usage in ptp_clock.c

and not as a big lump of everything.

> +/**
> + * clock_compare - Get couple of clocks time stamps

So the name of the syscall suggest that it compares two clocks, but the
actual functionality is to read two clocks.

This does not make any sense at all. Naming matters.

> + * @clock_a:	clock a ID
> + * @clock_b:	clock b ID
> + * @tp_a:		Pointer to a user space timespec64 for clock a storage
> + * @tp_b:		Pointer to a user space timespec64 for clock b storage
> + *
> + * clock_compare gets time sample of two clocks.
> + * Supported clocks IDs: PHC, virtual PHC and various system clocks.
> + *
> + * In case of PHC that supports crosstimespec and the other clock is Mon=
otonic raw
> + * or system time, crosstimespec will be used to synchronously capture
> + * system/device time stamp.
> + *
> + * In other cases: Read clock_a twice (before, and after reading clock_b=
) and
> + * average these times =E2=80=93 to be as close as possible to the time =
we read clock_b.
> + *
> + * Returns:
> + *	0		Success. @tp_a and @tp_b contains the time stamps
> + *	-EINVAL		@clock a or b ID is not a valid clock ID
> + *	-EFAULT		Copying the time stamp to @tp_a or @tp_b faulted
> + *	-EOPNOTSUPP	Dynamic POSIX clock does not support crosstimespec()
> + **/
> +SYSCALL_DEFINE5(clock_compare, const clockid_t, clock_a, const clockid_t=
, clock_b,
> +		struct __kernel_timespec __user *, tp_a, struct __kernel_timespec __us=
er *,
> +		tp_b, s64 __user *, offs_err)
> +{
> +	struct timespec64 ts_a, ts_a1, ts_b, ts_a2;
> +	struct system_device_crosststamp xtstamp_a1, xtstamp_a2, xtstamp_b;
> +	const struct k_clock *kc_a, *kc_b;
> +	ktime_t ktime_a;
> +	s64 ts_offs_err =3D 0;
> +	int error =3D 0;
> +	bool crosstime_support_a =3D false;
> +	bool crosstime_support_b =3D false;

Please read and follow the documentation provided at:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> +	kc_a =3D clockid_to_kclock(clock_a);
> +	if (!kc_a) {
> +		error =3D -EINVAL;
> +		return error;

What's wrong about 'return -EINVAL;' ?

> +	}
> +
> +	kc_b =3D clockid_to_kclock(clock_b);
> +	if (!kc_b) {
> +		error =3D -EINVAL;
> +		return error;
> +	}
> +
> +	// In case crosstimespec supported and b clock is Monotonic raw or syst=
em
> +	// time, synchronously capture system/device time stamp

Please don't use C++ comments.

> +	if (clock_a < 0) {

This is just wrong. posix-clocks ar not the only ones which have a
negative clock id. See clockid_to_kclock()

> +		error =3D kc_a->clock_get_crosstimespec(clock_a, &xtstamp_a1);

What's a crosstimespec?

This function fills in a system_device_crosststamp, so why not name it
so that the purpose of the function is obvious?

ptp_clock::info::getcrosststamp() has a reasonable name. So why do you
need to come up with something which makes the code obfuscated?

> +		if (!error) {
> +			if (clock_b =3D=3D CLOCK_MONOTONIC_RAW) {
> +				ts_b =3D ktime_to_timespec64(xtstamp_a1.sys_monoraw);
> +				ts_a1 =3D ktime_to_timespec64(xtstamp_a1.device);
> +				goto out;
> +			} else if (clock_b =3D=3D CLOCK_REALTIME) {
> +				ts_b =3D ktime_to_timespec64(xtstamp_a1.sys_realtime);
> +				ts_a1 =3D ktime_to_timespec64(xtstamp_a1.device);
> +				goto out;
> +			} else {
> +				crosstime_support_a =3D true;

Right. If clock_b is anything else than CLOCK_MONOTONIC_RAW or
CLOCK_REALTIME then this is true.

> +			}
> +		}

So in case of an error, this just keeps going with an uninitialized
xtstamp_a1 and if the clock_b part succeeds it continues and operates on
garbage.

> +	}
> +
> +	// In case crosstimespec supported and a clock is Monotonic raw or syst=
em
> +	// time, synchronously capture system/device time stamp
> +	if (clock_b < 0) {
> +		// Synchronously capture system/device time stamp
> +		error =3D kc_b->clock_get_crosstimespec(clock_b, &xtstamp_b);
> +		if (!error) {
> +			if (clock_a =3D=3D CLOCK_MONOTONIC_RAW) {
> +				ts_a1 =3D ktime_to_timespec64(xtstamp_b.sys_monoraw);
> +				ts_b =3D ktime_to_timespec64(xtstamp_b.device);
> +				goto out;
> +			} else if (clock_a =3D=3D CLOCK_REALTIME) {
> +				ts_a1 =3D ktime_to_timespec64(xtstamp_b.sys_realtime);
> +				ts_b =3D ktime_to_timespec64(xtstamp_b.device);
> +				goto out;
> +			} else {
> +				crosstime_support_b =3D true;
> +			}
> +		}
> +	}
> +
> +	if (crosstime_support_a)
> +		error =3D kc_a->clock_get_crosstimespec(clock_a, &xtstamp_a1);

What? crosstime_support_a is only true when the exactly same call
returned success. Why does it need to be called here again?

> +	else
> +		error =3D kc_a->clock_get_timespec(clock_a, &ts_a1);
> +
> +	if (error)
> +		return error;
> +
> +	if (crosstime_support_b)
> +		error =3D kc_b->clock_get_crosstimespec(clock_b, &xtstamp_b);
> +	else
> +		error =3D kc_b->clock_get_timespec(clock_b, &ts_b);
> +
> +	if (error)
> +		return error;
> +
> +	if (crosstime_support_a)
> +		error =3D kc_a->clock_get_crosstimespec(clock_a, &xtstamp_a2);
> +	else
> +		error =3D kc_a->clock_get_timespec(clock_a, &ts_a2);
> +
> +	if (error)
> +		return error;

The logic and the code flow here are unreadable garbage and there are
zero comments what this is supposed to do.

> +	if (crosstime_support_a) {
> +		ktime_a =3D ktime_sub(xtstamp_a2.device, xtstamp_a1.device);
> +		ts_offs_err =3D ktime_divns(ktime_a, 2);
> +		ktime_a =3D ktime_add_ns(xtstamp_a1.device, (u64)ts_offs_err);
> +		ts_a1 =3D ktime_to_timespec64(ktime_a);

This is just wrong.

     read(a1);
     read(b);
     read(a2);

You _CANNOT_ assume that (a1 + ((a2 - a1) / 2) is anywhere close to the
point in time where 'b' is read. This code is preemtible and
interruptible. I explained this to you before.

Your explanation in the comment above the function is just wishful
thinking.

> + * In other cases: Read clock_a twice (before, and after reading clock_b=
) and
> + * average these times =E2=80=93 to be as close as possible to the time =
we read clock_b.

Can you please sit down and provide a precise technical description of
the problem you are trying to solve and explain your proposed solution
at the conceptual level instead of throwing out random implementations
every few days?

Thanks,

        tglx



