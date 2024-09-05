Return-Path: <linux-arch+bounces-7085-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFECE96E372
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 21:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE722853D4
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 19:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482C6189523;
	Thu,  5 Sep 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ROUl1+X9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5HSfQDvu"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1318F54;
	Thu,  5 Sep 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565753; cv=none; b=poRatPrVvTs3ltmzuLwWswSvQXiVkWHbVcdZIw5GlM830Z3AnP+ZUt9S/Ruunt8Ir7r3u7etP/xRYNpIdmDKsjB0rpSRgVCK1v4GZnIPCsUWRmMeLdG3c6DPu4bY1C+OXZ9EFf2FZ3zGEq1cZzH4gCSECKvfoAH9DW3TN+ThIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565753; c=relaxed/simple;
	bh=xi6+vVg6Argwb+h34u6hLlKQyibWnMsM9TqCEb5NrlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TK2DrBd+wiIHOyAGsvXmwoyN66rMn/tXrnrmNnrfU2ZcV2dqo+bd01sXqjVQxKez5mCVOzpLi1Qa58R7bTD7O6dFfi2mZymZXSg9hZBURJKn85YFeIJE8K0zWNPq+igckT2ahVs+Fms3eI7vywo3sdd6DFmR6PcloU29t8bMgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ROUl1+X9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5HSfQDvu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725565749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bb2lPoIkNbz3lSRa6OazyFpC4pugvebqg9wdln1f6Q8=;
	b=ROUl1+X9j6Y4r9zEzpl6XR+vdygXNHZtDPqn6nLI/axTujDK180jzHIYprvKHWZ9/L7sUV
	T66CrsIzAt4yG01ekgYhvOiBN87AUBeQDzfVkEupmErBWzAEk1LoKUEiDYIFs/NGs6sZVY
	7/T1RVUv2cYHTkl35rWL1YAa0YPBTYsiZ+MMay+Lqj9y+e6DCEsrRkQr0E13AdV2XQOXQy
	Xfe6Vu7MOsmS6Jd1NUGFnRVHl0BL74g1j1d1i6qjcCG+c4Ka3OE14nLQnsZ9Q4xsFAyh+D
	GnsEqcJxYJjUOXbNCTLr1QIDuxXDFOSOUj+LuDQrrhp+bIOthdtVCFpxB5DJFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725565749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bb2lPoIkNbz3lSRa6OazyFpC4pugvebqg9wdln1f6Q8=;
	b=5HSfQDvu+LDj0RLND80XsjRAVe6pMjBALAvikesJ9bzPEaDRt9EU/po7NGPjto08Tm19zJ
	KeY9VxeHexfr1vCQ==
To: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Andrew Morton <akpm@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>
Subject: Re: [PATCH 06/15] timers: Update function descriptions of
 sleep/delay related functions
In-Reply-To: <8734me5bkn.ffs@tglx>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-6-e98760256370@linutronix.de>
 <87frqe60xj.ffs@tglx> <8734me5bkn.ffs@tglx>
Date: Thu, 05 Sep 2024 21:49:08 +0200
Message-ID: <877cbpq3t7.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> On Thu, Sep 05 2024 at 08:59, Thomas Gleixner wrote:
>> On Wed, Sep 04 2024 at 15:04, Anna-Maria Behnsen wrote:
>> However, instead of proliferating this voodoo can we please convert it
>> into something comprehensible?
>>
>> /*
>>  * The microseconds delay multiplicator is used to convert a constant
>>  * microseconds value to a <INSERT COHERENT EXPLANATION>.
>>  */
>> #define UDELAY_CONST_MULT  ((unsigned long)DIV_ROUND_UP(1ULL << 32, USEC_PER_SEC))
>>
>> /*
>>  * The maximum constant udelay value picked out of thin air
>>  * to avoid <INSERT COHERENT EXPLANATION>.
>>  */
>> #define UDELAY_CONST_MAX   20000
>>
>> /**
>>  * udelay - .....
>>  */
>> static __always_inline void udelay(unsigned long usec)
>> {
>>         /*
>> 	 * <INSERT COHERENT EXPLANATION> for this construct
>>          */
>> 	if (__builtin_constant_p(usec)) {
>> 		if (usec >= UDELAY_CONST_MAX)
>> 			__bad_udelay();
>> 		else
>> 			__const_udelay(usec * UDELAY_CONST_MULT);
>> 	} else {
>> 		__udelay(usec);
>
> And of course a these magic numeric constants have been copied all over
> the place. git grep '__const_udelay(' arch/ .... Just SH managed to use
> 0x10c6 instead of 0x10c7. 
>
> ARM has it's own udelay implementation:
>
> #define udelay(n)							\
> 	(__builtin_constant_p(n) ?					\
> 	  ((n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :		\
> 			__const_udelay((n) * UDELAY_MULT)) :		\
> 	  __udelay(n))
>
> Amazingly this uses the same comparison construct which was in the
> generic udelay implementation... Same for arc, m68k and microblaze.
>
> Plus the default implementation for mdelay() in linux/delay.h:
>
> #define mdelay(n) (\
> 	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
> 	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
>
> Oh well....
>
> What's truly amazing is that all __udelay() implementations, which
> invoke __const_udelay() under the hood, do:
>
>        __const_udelay(usec * 0x10c7);
>
> So we have an arbitrary range limit for constants, which makes the build
> fail. But the variable based udelays can hand in whatever they want and
> __udelay() happily ignores it including the possible multiplication
> overflow.
>
> That's all really consistently copy and pasted voodoo. The other
> architecture implementations are not much better in that regard.  The
> main difference is their cutoff value for __const_udelay() and the
> multiplication factors.
>
> The below uncompiled and untested pile is an attempt to consolidate this
> mess as far as it goes. There is probably more to mop up, but for a
> start this makes already sense.

Thanks for the first step of dissection of the mess! I'll take a closer
look at it soon.

But as it's in tree since some more days than just one, can we please
make this cleanup on top of the original queue and get the fsleep() and
outdated documentation thing fixed soon? You made a proposal in the
previous answer to convert it into something comprehensible. If there
are no concerns, I would integrate it and prepare a v2 for the queue.

Thanks,

	Anna-Maria


