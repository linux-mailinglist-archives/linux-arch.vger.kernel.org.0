Return-Path: <linux-arch+bounces-7731-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9369921C2
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 23:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9141F214C2
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 21:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759FF18A934;
	Sun,  6 Oct 2024 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hzu0ANxj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF6D520;
	Sun,  6 Oct 2024 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728251395; cv=none; b=RNFRDLTDRI2vZBjsP6aY1fJ1yaD/VYysVNGXYJ2seJHkk6qIibXtEyHoBE57lp+aW6/iWjtsQTTK74aR4ka6gcp1PbZgVxLZDFK24Ph/y7zQkAcpzLVdLrFZvR4FP73d7yKGf0TUnbZY4SMK37hvwQf1uVl84AHnP5azUn9aoQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728251395; c=relaxed/simple;
	bh=8jp7Ne+0hZvfThEFXdytXZSN0GP34oer6XoG1C4BwuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAZCjLtCam6emy+3qlRwYKFcsI8eW5T7r7ubg0bVRGnRD8Vm1UOdMGMA+GKpnSGTD7xE+sn8nXSk4rTAP34f9uip8gZzJ7794wNS3bs1mNud7MWkO4vSi6q+QVzhxsdWwifz8tMjUs+yn2ckzLfX6Nw/yfHhyu4m3z2iYgXXkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hzu0ANxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A11C4CEC5;
	Sun,  6 Oct 2024 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728251394;
	bh=8jp7Ne+0hZvfThEFXdytXZSN0GP34oer6XoG1C4BwuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hzu0ANxjEcyo4R9USphwNx/THRK3QIqUIImkROQaYMX0LiliKzGZNNpaHjrGyBdFZ
	 kwc1ShZ6+m964XhB52ioTlIv0Err90gWst8Gg5U9HcA5dp10nqZA8rgMrYSisI4dNB
	 feCzw6x4avmCuvg+Y8yjQL9wEPiRvEKgAh7828N9yfJEtVYMU8bosC5tJ2cQIyWrpO
	 7cm83PYtPsDnWAfMUqRWPqizIBoJUcLdfKBuodjIk4jVm6raAOjusoLS6ZWrcv6EXO
	 n8TnQaI7Eq6gaaYZDZe9/UHXI6iHiHrlFnX/yrRAMMDfsYS3ruxlMjRevp5zlbnbI7
	 RpATL3oyYdzbw==
Date: Sun, 6 Oct 2024 23:49:51 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 05/15] timers: Update function descriptions of
 sleep/delay related functions
Message-ID: <ZwMF_y62yJ-bmNL9@pavilion.home>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-5-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-5-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:31AM +0200, Anna-Maria Behnsen a écrit :
> A lot of commonly used functions for inserting a sleep or delay lack a
> proper function description. Add function descriptions to all of them to
> have important information in a central place close to the code.
> 
> No functional change.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> v2:
>  - Fix typos
>  - Fix proper usage of kernel-doc return formatting
> ---
>  include/asm-generic/delay.h | 41 +++++++++++++++++++++++++++++++----
>  include/linux/delay.h       | 48 ++++++++++++++++++++++++++++++----------
>  kernel/time/sleep_timeout.c | 53 ++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 120 insertions(+), 22 deletions(-)
> 
> diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
> index e448ac61430c..70a1b20f3e1a 100644
> --- a/include/asm-generic/delay.h
> +++ b/include/asm-generic/delay.h
> @@ -12,11 +12,39 @@ extern void __const_udelay(unsigned long xloops);
>  extern void __delay(unsigned long loops);
>  
>  /*
> - * The weird n/20000 thing suppresses a "comparison is always false due to
> - * limited range of data type" warning with non-const 8-bit arguments.
> + * Implementation details:
> + *
> + * * The weird n/20000 thing suppresses a "comparison is always false due to
> + *   limited range of data type" warning with non-const 8-bit arguments.
> + * * 0x10c7 is 2**32 / 1000000 (rounded up) -> udelay
> + * * 0x5 is 2**32 / 1000000000 (rounded up) -> ndelay

I can't say I'm less confused about these values but at least it
brings a bit of light in the horizon...

>   */
>  
> -/* 0x10c7 is 2**32 / 1000000 (rounded up) */
> +/**
> + * udelay - Inserting a delay based on microseconds with busy waiting
> + * @usec:	requested delay in microseconds
> + *
> + * When delaying in an atomic context ndelay(), udelay() and mdelay() are the
> + * only valid variants of delaying/sleeping to go with.
> + *
> + * When inserting delays in non atomic context which are shorter than the time
> + * which is required to queue e.g. an hrtimer and to enter then the scheduler,
> + * it is also valuable to use udelay(). But is not simple to specify a generic

But it is*

> + * threshold for this which will fit for all systems, but an approximation would

But but?

> + * be a threshold for all delays up to 10 microseconds.
> + *
> + * When having a delay which is larger than the architecture specific
> + * %MAX_UDELAY_MS value, please make sure mdelay() is used. Otherwise a overflow
> + * risk is given.
> + *
> + * Please note that ndelay(), udelay() and mdelay() may return early for several
> + * reasons (https://lists.openwall.net/linux-kernel/2011/01/09/56):
> + *
> + * #. computed loops_per_jiffy too low (due to the time taken to execute the
> + *    timer interrupt.)
> + * #. cache behaviour affecting the time it takes to execute the loop function.
> + * #. CPU clock rate changes.
> + */
>  #define udelay(n)							\
>  	({								\
>  		if (__builtin_constant_p(n)) {				\
> @@ -35,12 +25,21 @@ extern unsigned long loops_per_jiffy;
>   * The 2nd mdelay() definition ensures GCC will optimize away the 
>   * while loop for the common cases where n <= MAX_UDELAY_MS  --  Paul G.
>   */
> -
>  #ifndef MAX_UDELAY_MS
>  #define MAX_UDELAY_MS	5
>  #endif
>  
>  #ifndef mdelay
> +/**
> + * mdelay - Inserting a delay based on microseconds with busy waiting

Milliseconds?

> + * @n:	requested delay in microseconds

Ditto

> + *
> + * See udelay() for basic information about mdelay() and it's variants.
> + *
> + * Please double check, whether mdelay() is the right way to go or whether a
> + * refactoring of the code is the better variant to be able to use msleep()
> + * instead.
> + */
>  #define mdelay(n) (\
>  	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
>  	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
> @@ -63,16 +62,41 @@ unsigned long msleep_interruptible(unsigned int msecs);
>  void usleep_range_state(unsigned long min, unsigned long max,
>  			unsigned int state);
>  
> +/**
> + * usleep_range - Sleep for an approximate time
> + * @min:	Minimum time in microseconds to sleep
> + * @max:	Maximum time in microseconds to sleep
> + *
> + * For basic information please refere to usleep_range_state().
> + *
> + * The task will be in the state TASK_UNINTERRUPTIBLE during the sleep.
> + */
>  static inline void usleep_range(unsigned long min, unsigned long max)
>  {
>  	usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
>  }
>  
> +/**
> + * usleep_range_idle - Sleep for an approximate time with idle time accounting
> + * @min:	Minimum time in microseconds to sleep
> + * @max:	Maximum time in microseconds to sleep
> + *
> + * For basic information please refere to usleep_range_state().
> + *
> + * The sleeping task has the state TASK_IDLE during the sleep to prevent
> + * contribution to the load avarage.
> + */
>  static inline void usleep_range_idle(unsigned long min, unsigned long max)
>  {
>  	usleep_range_state(min, max, TASK_IDLE);
>  }
>  
> +/**
> + * ssleep - wrapper for seconds arount msleep

around

> + * @seconds:	Requested sleep duration in seconds
> + *
> + * Please refere to msleep() for detailed information.
> + */
>  static inline void ssleep(unsigned int seconds)
>  {
>  	msleep(seconds * 1000);
> diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
> index 560d17c30aa5..21f412350b15 100644
> --- a/kernel/time/sleep_timeout.c
> +++ b/kernel/time/sleep_timeout.c
> @@ -281,7 +281,34 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout);
>  
>  /**
>   * msleep - sleep safely even with waitqueue interruptions
> - * @msecs: Time in milliseconds to sleep for
> + * @msecs:	Requested sleep duration in milliseconds
> + *
> + * msleep() uses jiffy based timeouts for the sleep duration. The accuracy of
> + * the resulting sleep duration depends on:
> + *
> + * * HZ configuration
> + * * sleep duration (as granularity of a bucket which collects timers increases
> + *   with the timer wheel levels)
> + *
> + * When the timer is queued into the second level of the timer wheel the maximum
> + * additional delay will be 12.5%. For explanation please check the detailed
> + * description about the basics of the timer wheel. In case this is accurate
> + * enough check which sleep length is selected to make sure required accuracy is
> + * given. Please use therefore the following simple steps:
> + *
> + * #. Decide which slack is fine for the requested sleep duration - but do not
> + *    use values shorter than 1/8

I'm confused, what means 1/x for a slack value? 1/8 means 125 msecs? I'm not
even I understand what you mean by slack. Is it the bucket_expiry - expiry?

> + * #. Check whether your sleep duration is equal or greater than the following
> + *    result: ``TICK_NSEC / slack / NSEC_PER_MSEC``
> + *
> + * Examples:
> + *
> + * * ``HZ=1000`` with `slack=1/4``: all sleep durations greater or equal 4ms will meet
> + *   the constrains.
> + * * ``HZ=250`` with ``slack=1/4``: all sleep durations greater or equal 16ms will meet
> + *   the constrains.

constraints.

But I'm still lost...

Thanks.

