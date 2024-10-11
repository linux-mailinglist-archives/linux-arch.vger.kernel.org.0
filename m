Return-Path: <linux-arch+bounces-8028-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7073A99A12F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 12:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8561EB221A1
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924220FA8A;
	Fri, 11 Oct 2024 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cmF1IqQn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oFbJuqFM"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB028EB;
	Fri, 11 Oct 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642025; cv=none; b=CEjHSEzD4Lvlt7INNarrtl8Wqqr3JQMIwzx0yG9t3pfACfFSXynoPDUVRbRyHtLrhpheSFS8Wmszfr6xiNWU36Pl3P+Ggkv2V1m7HmSsudznktVB7yA0Jzwb+OU9CKtAuGIBbrd67rQ108RyTiEXCnp0iQGaP15xvg0rgyry2+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642025; c=relaxed/simple;
	bh=0O1MS/Ua/m0+5WKWzH2CdOiGk5PfgHdhplaLIDTDzhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GmWkZe5+pjTlA6aTVpDE6Qa9Er4DTQTWYWzc9OlXztxXj+zHNnPFJsRK3ErHchoPwJa35d3z48PWZXElMNhVZ93YqE91eDo62JeteFsOvcEJS3Nu2gXfMOi9sXgxi13uon3n5XwKW8Ruh5GQR/yxIV7mctTS6EybB6hjf32d0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cmF1IqQn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oFbJuqFM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728642021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oodZ5BUT0swgpoEj0E73/1KWpBNCNQiVFaoHa8h8MzY=;
	b=cmF1IqQnlLgkwUeMhQDR84FmE3UdJqv8fwBPpMadxrH1/YN4x/Qa+a6FLQjL0YzuQCfqL0
	dZsidzEe2o7X4B2TewsBM4Y3Ec+d8mXblgrGhdtxVcgDEZfYLFCl4UklA5ywCJUqK8M+5n
	4KWjsk7vkgkKo8zP0tQ3DUw9PoFI9Ee/Bnwr7ySr5bjmhj0Tl71mBDL9ryBGW1tHymUwrA
	6N9up5Lv9rGr7N20PNNOhvK26yXOKuE8uprHxdV8TQNqacXF6GMjawhJge93ROmEkXe3mk
	tJ24kF/WyNjgAAOywKwgkYgvdIIihNVnkFJ/niCUJAR8GfW8GpeogO9bpmttdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728642021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oodZ5BUT0swgpoEj0E73/1KWpBNCNQiVFaoHa8h8MzY=;
	b=oFbJuqFMU46RZWroKP/1/DHEpiYx5cHKNzgTfLKJHDctOTsOf+uRmHPni7H5/IiK7kWwFy
	zSJGyYWOzuBIGZBw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 05/15] timers: Update function descriptions of
 sleep/delay related functions
In-Reply-To: <ZwfKNNpjYnn2OGWG@localhost.localdomain>
References: <ZwMF_y62yJ-bmNL9@pavilion.home> <87wmig9wj4.fsf@somnus>
 <ZwfKNNpjYnn2OGWG@localhost.localdomain>
Date: Fri, 11 Oct 2024 12:20:20 +0200
Message-ID: <875xpzvt3v.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Thu, Oct 10, 2024 at 10:45:03AM +0200, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Frederic Weisbecker <frederic@kernel.org> writes:
>> >> @@ -281,7 +281,34 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout);
>> >>=20=20
>> >>  /**
>> >>   * msleep - sleep safely even with waitqueue interruptions
>> >> - * @msecs: Time in milliseconds to sleep for
>> >> + * @msecs:	Requested sleep duration in milliseconds
>> >> + *
>> >> + * msleep() uses jiffy based timeouts for the sleep duration. The ac=
curacy of
>> >> + * the resulting sleep duration depends on:
>> >> + *
>> >> + * * HZ configuration
>> >> + * * sleep duration (as granularity of a bucket which collects timer=
s increases
>> >> + *   with the timer wheel levels)
>> >> + *
>> >> + * When the timer is queued into the second level of the timer wheel=
 the maximum
>> >> + * additional delay will be 12.5%. For explanation please check the =
detailed
>> >> + * description about the basics of the timer wheel. In case this is =
accurate
>> >> + * enough check which sleep length is selected to make sure required=
 accuracy is
>> >> + * given. Please use therefore the following simple steps:
>> >> + *
>> >> + * #. Decide which slack is fine for the requested sleep duration - =
but do not
>> >> + *    use values shorter than 1/8
>> >
>> > I'm confused, what means 1/x for a slack value? 1/8 means 125 msecs? I=
'm not
>> > even I understand what you mean by slack. Is it the bucket_expiry - ex=
piry?
>>=20
>> I was confused as well and had to read it twice... I would propose to
>> rephrase the whole function description:
>>=20
>>=20
>> /**
>>  * msleep - sleep safely even with waitqueue interruptions
>>  * @msecs:	Requested sleep duration in milliseconds
>>  *
>>  * msleep() uses jiffy based timeouts for the sleep duration. Because of=
 the
>>  * design of the timer wheel, the maximum additional percentage delay (s=
lack) is
>>  * 12.5%. This is only valid for timers which will end up in the second =
or a
>>  * higher level of the timer wheel. For explanation of those 12.5% pleas=
e check
>>  * the detailed description about the basics of the timer wheel.
>
> I've never realized this constant worst percentage of slack. Would be nic=
e to mention
> that somewhere in kernel/time/timer.c

Yes, we can explicitly add it (I will put it on the TODO list). It's
possible to calculate it on your own with the overview of levels and
granularity,...

> However this doesn't need a second to apply. It only takes crossing level=
s above
> 0. Or am I missing something?

s/the second/level 1/

more clear? Then it's the same number as used in the timer wheel
documentation.

>>  *
>>  * The slack of timers which will end up in the first level depends on:
>>  *

Same here: s/the first level/level 0/

>>  * * sleep duration (msecs)
>>  * * HZ configuration
>>  *
>>  * To make sure the sleep duration with the slack is accurate enough, a =
slack
>>  * value is required (because of the design of the timer wheel it is not
>
> But where is it required?

The callsite has to decide which accuracy/slack is required for their
use case (this was also part of the discussion which leads to this
queue).

>>  * possible to define a value smaller than 12.5%). The following check m=
akes
>>  * clear, whether the sleep duration with the defined slack and with the=
 HZ
>>  * configuration will meet the constraints:
>>  *
>>  *  ``msecs >=3D (MSECS_PER_TICK / slack)``
>>  *
>>  * Examples:
>>  *
>>  * * ``HZ=3D1000`` with ``slack=3D25%``: ``MSECS_PER_TICK / slack =3D 1 =
/ (1/4) =3D 4``:
>>  *   all sleep durations greater or equal 4ms will meet the constraints.
>>  * * ``HZ=3D1000`` with ``slack=3D12.5%``: ``MSECS_PER_TICK / slack =3D =
1 / (1/8) =3D 8``:
>>  *   all sleep durations greater or equal 8ms will meet the constraints.
>>  * * ``HZ=3D250`` with ``slack=3D25%``: ``MSECS_PER_TICK / slack =3D 4 /=
 (1/4) =3D 16``:
>>  *   all sleep durations greater or equal 16ms will meet the constraints.
>>  * * ``HZ=3D250`` with ``slack=3D12.5%``: ``MSECS_PER_TICK / slack =3D 4=
 / (1/8) =3D 32``:
>>  *   all sleep durations greater or equal 32ms will meet the constraints.
>
> But who defines those slacks and where? I'm even more confused now...

I think I know where the confusion comes from. I rephrase it once more
and turned around the calculation:

/**
 * msleep - sleep safely even with waitqueue interruptions
 * @msecs:	Requested sleep duration in milliseconds
 *
 * msleep() uses jiffy based timeouts for the sleep duration. Because of the
 * design of the timer wheel, the maximum additional percentage delay (slac=
k) is
 * 12.5%. This is only valid for timers which will end up in level 1 or a
 * higher level of the timer wheel. For explanation of those 12.5% please c=
heck
 * the detailed description about the basics of the timer wheel.
 *
 * The slack of timers which will end up in level 0 depends on sleep
 * duration (msecs) and HZ configuration and can be calculated in the
 * following way (with the timer wheel design restriction that the slack
 * is not less than 12.5%):
 *
 *   ``slack =3D MSECS_PER_TICK / msecs``
 *
 * When the allowed slack of the callsite is known, the calculation
 * could be turned around to find the minimal allowed sleep duration to meet
 * the constraints. For example:
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

Hopefully this attempt clarifies the confusion?


