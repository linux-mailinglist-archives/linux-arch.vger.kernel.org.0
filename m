Return-Path: <linux-arch+bounces-7957-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592829980F5
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 10:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6D51F24A6B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9DC1C9DFB;
	Thu, 10 Oct 2024 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ruzYYtm9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/rDK7l4q"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDCD1C9DE6;
	Thu, 10 Oct 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549907; cv=none; b=BN0ZMjTGKCQsdyqJqhRggBQGB0gkXplL5x/x033orq4qGzna1XKc/RN+FgWucI0s2xj4uz5KZ28YsNFwKH6I4bHdWMaPL2jluZNIUBz2DUhTljaVrBjYKi7FxUFWTwZOqx93dnAvYN1SYMYoSId1L0mGZpCwpZcogXeRTDlDKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549907; c=relaxed/simple;
	bh=j7TeGcDF05fWn50UB2+Oy0CdxmJH2BnWKPt/16fC/cQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=Gk1h8hSwr3Yg5EcRO9C9BdqbtX5DwPs+MRHPnE+ShdzRe37cxo15L+dKw9zEj6yl4sdxC/t0Ohbi8NlnBaK0B611gGhCZrVMQMqrGmSeVihLmwbNEHIZvK0rvE8s55gTzWhCzj4Wzmt3K/zL+45cwV7pYEIk+yWkadrH/okm5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ruzYYtm9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/rDK7l4q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728549903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=BKpdwUGaSDegaZLoIC8YGxo08yUdK0GJo6wLsl47Fhk=;
	b=ruzYYtm9W2hNUO4rfcepcXiaG2GEImFVVvroK3qALBiThRzPpTvCgpmq7EMIhAxmrzHM9d
	HFySorK+3VslmY81mnKEfXvPaUGS+ykw7P+0TVcXLVHAWXM6yRnfYeaW+2aWgBTJDKgGpy
	/yPRoi/SefhEilLHr5FkxU2ohx4/H/DFC4dyXrsr5AthjUvey63hBPyITY2ODRtzNiulJ8
	NCkaUXNfspc3gpeq21l7khdcT3e7px6gMqMv39yw89ovsxaOJhhSMJPjtb3qeE1E2X4HjB
	SGvrPwIXRtNcuZ71DjsHsyKExWOmKLaTHzXfkygFDrTJ5FdPjU4llXB3iuTqhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728549903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=BKpdwUGaSDegaZLoIC8YGxo08yUdK0GJo6wLsl47Fhk=;
	b=/rDK7l4qrzgFebvmIH5xq54HEpeECLCF5AsDx29xSapJwn/vCTHkSJ5j9TkkJOZNsXVn5W
	eRVws1MLbQ0f5CBw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 05/15] timers: Update function descriptions of
 sleep/delay related functions
In-Reply-To: <ZwMF_y62yJ-bmNL9@pavilion.home>
Date: Thu, 10 Oct 2024 10:45:03 +0200
Message-ID: <87wmig9wj4.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Wed, Sep 11, 2024 at 07:13:31AM +0200, Anna-Maria Behnsen a =C3=A9crit=
 :
>> A lot of commonly used functions for inserting a sleep or delay lack a
>> proper function description. Add function descriptions to all of them to
>> have important information in a central place close to the code.
>>=20
>> No functional change.
>>=20
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-arch@vger.kernel.org
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> ---
>> v2:
>>  - Fix typos
>>  - Fix proper usage of kernel-doc return formatting
>> ---
>>  include/asm-generic/delay.h | 41 +++++++++++++++++++++++++++++++----
>>  include/linux/delay.h       | 48 ++++++++++++++++++++++++++++++--------=
--
>>  kernel/time/sleep_timeout.c | 53 ++++++++++++++++++++++++++++++++++++++=
++-----
>>  3 files changed, 120 insertions(+), 22 deletions(-)
>>=20
>> diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
>> index e448ac61430c..70a1b20f3e1a 100644
>> --- a/include/asm-generic/delay.h
>> +++ b/include/asm-generic/delay.h
>> @@ -12,11 +12,39 @@ extern void __const_udelay(unsigned long xloops);
>>  extern void __delay(unsigned long loops);
>>=20=20
>>  /*
>> - * The weird n/20000 thing suppresses a "comparison is always false due=
 to
>> - * limited range of data type" warning with non-const 8-bit arguments.
>> + * Implementation details:
>> + *
>> + * * The weird n/20000 thing suppresses a "comparison is always false d=
ue to
>> + *   limited range of data type" warning with non-const 8-bit arguments.
>> + * * 0x10c7 is 2**32 / 1000000 (rounded up) -> udelay
>> + * * 0x5 is 2**32 / 1000000000 (rounded up) -> ndelay
>
> I can't say I'm less confused about these values but at least it
> brings a bit of light in the horizon...

:) This will be cleaned up in a second step all over the place as
suggested by Thomas already in v1. But for now, the aim is only to fix
fsleep and especially the outdated documentation of delay and sleep
related functions.

>>   */
>>=20=20
>> -/* 0x10c7 is 2**32 / 1000000 (rounded up) */
>> +/**
>> + * udelay - Inserting a delay based on microseconds with busy waiting
>> + * @usec:	requested delay in microseconds
>> + *
>> + * When delaying in an atomic context ndelay(), udelay() and mdelay() a=
re the
>> + * only valid variants of delaying/sleeping to go with.
>> + *
>> + * When inserting delays in non atomic context which are shorter than t=
he time
>> + * which is required to queue e.g. an hrtimer and to enter then the sch=
eduler,
>> + * it is also valuable to use udelay(). But is not simple to specify a =
generic
>
> But it is*
>
>> + * threshold for this which will fit for all systems, but an approximat=
ion would
>
> But but?

change those two sentences into: But it is not simple to specify a
generic threshold for this which will fit for all systems. An
approximation is a threshold for all delays up to 10 microseconds.

>> + * be a threshold for all delays up to 10 microseconds.
>> + *
>> + * When having a delay which is larger than the architecture specific
>> + * %MAX_UDELAY_MS value, please make sure mdelay() is used. Otherwise a=
 overflow
>> + * risk is given.
>> + *
>> + * Please note that ndelay(), udelay() and mdelay() may return early fo=
r several
>> + * reasons (https://lists.openwall.net/linux-kernel/2011/01/09/56):
>> + *
>> + * #. computed loops_per_jiffy too low (due to the time taken to execut=
e the
>> + *    timer interrupt.)
>> + * #. cache behaviour affecting the time it takes to execute the loop f=
unction.
>> + * #. CPU clock rate changes.
>> + */
>>  #define udelay(n)							\
>>  	({								\
>>  		if (__builtin_constant_p(n)) {				\
>> diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
>> index 560d17c30aa5..21f412350b15 100644
>> --- a/kernel/time/sleep_timeout.c
>> +++ b/kernel/time/sleep_timeout.c
>> @@ -281,7 +281,34 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout);
>>=20=20
>>  /**
>>   * msleep - sleep safely even with waitqueue interruptions
>> - * @msecs: Time in milliseconds to sleep for
>> + * @msecs:	Requested sleep duration in milliseconds
>> + *
>> + * msleep() uses jiffy based timeouts for the sleep duration. The accur=
acy of
>> + * the resulting sleep duration depends on:
>> + *
>> + * * HZ configuration
>> + * * sleep duration (as granularity of a bucket which collects timers i=
ncreases
>> + *   with the timer wheel levels)
>> + *
>> + * When the timer is queued into the second level of the timer wheel th=
e maximum
>> + * additional delay will be 12.5%. For explanation please check the det=
ailed
>> + * description about the basics of the timer wheel. In case this is acc=
urate
>> + * enough check which sleep length is selected to make sure required ac=
curacy is
>> + * given. Please use therefore the following simple steps:
>> + *
>> + * #. Decide which slack is fine for the requested sleep duration - but=
 do not
>> + *    use values shorter than 1/8
>
> I'm confused, what means 1/x for a slack value? 1/8 means 125 msecs? I'm =
not
> even I understand what you mean by slack. Is it the bucket_expiry - expir=
y?

I was confused as well and had to read it twice... I would propose to
rephrase the whole function description:


/**
 * msleep - sleep safely even with waitqueue interruptions
 * @msecs:	Requested sleep duration in milliseconds
 *
 * msleep() uses jiffy based timeouts for the sleep duration. Because of the
 * design of the timer wheel, the maximum additional percentage delay (slac=
k) is
 * 12.5%. This is only valid for timers which will end up in the second or a
 * higher level of the timer wheel. For explanation of those 12.5% please c=
heck
 * the detailed description about the basics of the timer wheel.
 *
 * The slack of timers which will end up in the first level depends on:
 *
 * * sleep duration (msecs)
 * * HZ configuration
 *
 * To make sure the sleep duration with the slack is accurate enough, a sla=
ck
 * value is required (because of the design of the timer wheel it is not
 * possible to define a value smaller than 12.5%). The following check makes
 * clear, whether the sleep duration with the defined slack and with the HZ
 * configuration will meet the constraints:
 *
 *  ``msecs >=3D (MSECS_PER_TICK / slack)``
 *
 * Examples:
 *
 * * ``HZ=3D1000`` with ``slack=3D25%``: ``MSECS_PER_TICK / slack =3D 1 / (=
1/4) =3D 4``:
 *   all sleep durations greater or equal 4ms will meet the constraints.
 * * ``HZ=3D1000`` with ``slack=3D12.5%``: ``MSECS_PER_TICK / slack =3D 1 /=
 (1/8) =3D 8``:
 *   all sleep durations greater or equal 8ms will meet the constraints.
 * * ``HZ=3D250`` with ``slack=3D25%``: ``MSECS_PER_TICK / slack =3D 4 / (1=
/4) =3D 16``:
 *   all sleep durations greater or equal 16ms will meet the constraints.
 * * ``HZ=3D250`` with ``slack=3D12.5%``: ``MSECS_PER_TICK / slack =3D 4 / =
(1/8) =3D 32``:
 *   all sleep durations greater or equal 32ms will meet the constraints.
 *
 * See also the signal aware variant msleep_interruptible().
 */

>
> But I'm still lost...
>

Hopefully no longer :)

Thanks,

	Anna-Maria



