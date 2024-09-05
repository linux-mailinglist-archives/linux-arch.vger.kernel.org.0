Return-Path: <linux-arch+bounces-7059-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB04196CFDF
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 08:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5961C22540
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 06:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9551925A5;
	Thu,  5 Sep 2024 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e8Pxw70g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f0P/QSyM"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B262C192584;
	Thu,  5 Sep 2024 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519565; cv=none; b=jEUG8saZFuskWzxlhgHFmXo1PFHkZM6wPXN/gRWBV5x/0wvbLdSNIJNXqRiRUHavcgfs6iqmoi+M8GMPhyA9KtPR3BziyXRH/iGTDM2yMKEyTtG9rYhYjiVo6krgqylh5zrUwJMWrmsdM50gFzo21oV/eCYwWieXjHT5NwMGb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519565; c=relaxed/simple;
	bh=hP+71/L27TQjuMtWgb0td8xqGjaD2bL+FYvIFuB2UrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PNw579ro/j2oFFev5bnsqzTmFRXzMVnaluF6zSRlA1VcWaI0hnQ4HgBTOTTZnPoKLLF5m2h/r/N7oNEZNlYv9nBl1oNV2IgjpsVFMioCUsLtDozl8ydqgXQRwTc/oCe03JiHr6F57QRFlfIjhcpsF5FH5W3ch3E62lglFOlUdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e8Pxw70g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f0P/QSyM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725519561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oLnB5T73bYfoj4CCqjw/lu+6Mx99aJX5lgFJ/9PdkIo=;
	b=e8Pxw70gT1kJUEVjYse8VkE++rxiDuxzxStX9HcVf8y9kdtirafmQ9VyiRT1kByH7biKqF
	DumE8bORAZ7pkDk4059TolvE5rg2NJ96Qmug/d1Q9Mqp3Xzl82EhHCZbUrAO41cdAtNCht
	jfRB5wAlKLGjPLEu2ALbjawkyBACjaJy7gQHFW0V7GteQf6gA0I5FH/QM1rF/Y1BgO4+J1
	llAKgieu/pkFCJQc3Dot5a+8TM6yKpXotioWrzwlGo0qNo7Zr1Vgm8FKO7Bj7OMQT8e+2L
	BI3OwoSQbDcxAoP5sEZo68a7FvU1uF9uxe7KM2fE/3zNDiZCzaY6bGMWBs7VkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725519561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oLnB5T73bYfoj4CCqjw/lu+6Mx99aJX5lgFJ/9PdkIo=;
	b=f0P/QSyMaBk5B9FNdgpZp7byPXEP6dM1TOOUVv4G5K8tOPrQjavbbXDQnOchryz1Z1Taq3
	y5hgAhg4ysRFlhDQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Andrew Morton <akpm@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>
Subject: Re: [PATCH 06/15] timers: Update function descriptions of
 sleep/delay related functions
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-6-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-6-e98760256370@linutronix.de>
Date: Thu, 05 Sep 2024 08:59:20 +0200
Message-ID: <87frqe60xj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 04 2024 at 15:04, Anna-Maria Behnsen wrote:
> +/**
> + * udelay - Inserting a delay based on microseconds with busy waiting
> + * @n:	requested delay in microseconds

....

> + * Impelementation details for udelay() only:

Implementation

> + * * The weird n/20000 thing suppresses a "comparison is always false due to
> + *   limited range of data type" warning with non-const 8-bit arguments.
> + * * 0x10c7 is 2**32 / 1000000 (rounded up)
>   */

That spello aside, I don't see how this information is interesting for
the user of udelay(). It's really a implementation detail and the user
does not care about this piece of art at all.

Though that made me look at this voodoo and the magic constants in
detail.  The division was added in a87e553fabe8 ("asm-generic: delay.h
fix udelay and ndelay for 8 bit args") to work around a compiler which
is upset about the comparision even when __builtin_constant_p(arg) is
false:

   warning: comparison is always false due to limited range of data type

The changelog is silent about the compiler version. I assume it's clang
because clang still complains on a plain (n) > 20000 when udelay() is
invoked with a u8 variable as argument:

   warning: result of comparison of constant 20000 with
            expression of type 'unsigned char' is always false
            [-Wtautological-constant-out-of-range-compare]

while gcc does not care.

The change log explains further that type casting 'n' in the comparison
does not cure it. Contemporary clang seems to be less stupid and

	if ((unsigned long)(n) >= 20000)			\

compiles just fine. Though assumed that some older clang version failed
and is still allowed to be used for compiling the kernel we have to work
around it.

However, instead of proliferating this voodoo can we please convert it
into something comprehensible?

/*
 * The microseconds delay multiplicator is used to convert a constant
 * microseconds value to a <INSERT COHERENT EXPLANATION>.
 */
#define UDELAY_CONST_MULT  ((unsigned long)DIV_ROUND_UP(1ULL << 32, USEC_PER_SEC))

/*
 * The maximum constant udelay value picked out of thin air
 * to avoid <INSERT COHERENT EXPLANATION>.
 */
#define UDELAY_CONST_MAX   20000

/**
 * udelay - .....
 */
static __always_inline void udelay(unsigned long usec)
{
        /*
	 * <INSERT COHERENT EXPLANATION> for this construct
         */
	if (__builtin_constant_p(usec)) {
		if (usec >= UDELAY_CONST_MAX)
			__bad_udelay();
		else
			__const_udelay(usec * UDELAY_CONST_MULT);
	} else {
		__udelay(usec);
	}
}

Both gcc and clang optimize this correctly with -O2. If there are
ancient compilers which fail to do so: *shrug*. 

> + * See udelay() for basic information about ndelay() and it's variants.
> + *
> + * Impelmentation details for ndelay():

vs.

> + * Impelementation details for udelay() only:

above. Can you please make your mind up which mis-spelled variant to
pick? :)

>  /**
>   * msleep_interruptible - sleep waiting for signals
> - * @msecs: Time in milliseconds to sleep for
> + * @msecs:	Requested sleep duration in milliseconds
> + *
> + * See msleep() for some basic information.
> + *
> + * The difference between msleep() and msleep_interruptible() is that the sleep
> + * could be interrupted by a signal delivery and then returns early.
> + *
> + * Returns the remaining time of the sleep duration transformed to msecs (see
> + * schedule_timeout() for details).

  Returns: The remaining ...

Thanks,

        tglx

