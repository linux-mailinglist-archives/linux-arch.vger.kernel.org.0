Return-Path: <linux-arch+bounces-7962-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C23998625
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 14:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30221281102
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB64E1C1ACF;
	Thu, 10 Oct 2024 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQj4vusl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B51BD00B;
	Thu, 10 Oct 2024 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563768; cv=none; b=QyK02dfPoVn35DTWvIXjUwrAQO1ZJ0JfYUcs/QaPEokUU9p6OMJNINsh2n3nEvnzCCkox1VNWdFg7I6Gf44E/PCo6uoINMm3oNgmQG5vZh1kTLBOKxrvTSZmCmApIrVgMNFeodeZSPP519YYxSC0864WVeTodQb8V73ePd+aeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563768; c=relaxed/simple;
	bh=Mrfex9PaX8qsirzDCOIMidvr+l1VhKsLmb0RG30fKrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVfGm4IGOWLCb9YAApE5FICzZzon8F26XM/mi4YXFKfRARv+twWV0xUXHDzB0iQTWDABMmdjjiH763MRIwHSPnTpcbB3aqzHGhvMB4TOZV4u594X+W/xd4Yxh33FtIBVOXy/3UESw81ingKA7Z0nnNNvYQIuVnkHmvoFjTa2ga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQj4vusl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F8CC4CECE;
	Thu, 10 Oct 2024 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728563768;
	bh=Mrfex9PaX8qsirzDCOIMidvr+l1VhKsLmb0RG30fKrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQj4vusl2xZyU2s6eZMzP0ufrrKpBG9qlyuhuQvJ9sjoTaOMo1QIul8EGCr2tkuE4
	 xSeSNrVwS6M44XVcCdw8+Y353IY4YTBCQl0ln9Eef9gYiXUyzZnjln4i3ZOSMNVC2u
	 r0SyEDUGUCCRqQU84Yq7imAHb4+QYJPyqriUcNZVWnammTp2GztTTqqN/CgxHfSaqG
	 2YeO0tHDt33FN9ORsPKpdqwe/V+C2dWp41X/bdpWSEUfWMf4jyrfONbX2T2SaRsrin
	 00Nye82TLAU5B4EBsJEhUg/7z9M7qOwh2vQtPWESHijBvm8Nm12HzcsvyqBAa9MTUq
	 aXToxtxSMxk7A==
Date: Thu, 10 Oct 2024 14:36:04 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 05/15] timers: Update function descriptions of
 sleep/delay related functions
Message-ID: <ZwfKNNpjYnn2OGWG@localhost.localdomain>
References: <ZwMF_y62yJ-bmNL9@pavilion.home>
 <87wmig9wj4.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmig9wj4.fsf@somnus>

Le Thu, Oct 10, 2024 at 10:45:03AM +0200, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> > I can't say I'm less confused about these values but at least it
> > brings a bit of light in the horizon...
> 
> :) This will be cleaned up in a second step all over the place as
> suggested by Thomas already in v1. But for now, the aim is only to fix
> fsleep and especially the outdated documentation of delay and sleep
> related functions.

Sure.

> 
> >>   */
> >>  
> >> -/* 0x10c7 is 2**32 / 1000000 (rounded up) */
> >> +/**
> >> + * udelay - Inserting a delay based on microseconds with busy waiting
> >> + * @usec:	requested delay in microseconds
> >> + *
> >> + * When delaying in an atomic context ndelay(), udelay() and mdelay() are the
> >> + * only valid variants of delaying/sleeping to go with.
> >> + *
> >> + * When inserting delays in non atomic context which are shorter than the time
> >> + * which is required to queue e.g. an hrtimer and to enter then the scheduler,
> >> + * it is also valuable to use udelay(). But is not simple to specify a generic
> >
> > But it is*
> >
> >> + * threshold for this which will fit for all systems, but an approximation would
> >
> > But but?
> 
> change those two sentences into: But it is not simple to specify a
> generic threshold for this which will fit for all systems. An
> approximation is a threshold for all delays up to 10 microseconds.

Very good!

> >> @@ -281,7 +281,34 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout);
> >>  
> >>  /**
> >>   * msleep - sleep safely even with waitqueue interruptions
> >> - * @msecs: Time in milliseconds to sleep for
> >> + * @msecs:	Requested sleep duration in milliseconds
> >> + *
> >> + * msleep() uses jiffy based timeouts for the sleep duration. The accuracy of
> >> + * the resulting sleep duration depends on:
> >> + *
> >> + * * HZ configuration
> >> + * * sleep duration (as granularity of a bucket which collects timers increases
> >> + *   with the timer wheel levels)
> >> + *
> >> + * When the timer is queued into the second level of the timer wheel the maximum
> >> + * additional delay will be 12.5%. For explanation please check the detailed
> >> + * description about the basics of the timer wheel. In case this is accurate
> >> + * enough check which sleep length is selected to make sure required accuracy is
> >> + * given. Please use therefore the following simple steps:
> >> + *
> >> + * #. Decide which slack is fine for the requested sleep duration - but do not
> >> + *    use values shorter than 1/8
> >
> > I'm confused, what means 1/x for a slack value? 1/8 means 125 msecs? I'm not
> > even I understand what you mean by slack. Is it the bucket_expiry - expiry?
> 
> I was confused as well and had to read it twice... I would propose to
> rephrase the whole function description:
> 
> 
> /**
>  * msleep - sleep safely even with waitqueue interruptions
>  * @msecs:	Requested sleep duration in milliseconds
>  *
>  * msleep() uses jiffy based timeouts for the sleep duration. Because of the
>  * design of the timer wheel, the maximum additional percentage delay (slack) is
>  * 12.5%. This is only valid for timers which will end up in the second or a
>  * higher level of the timer wheel. For explanation of those 12.5% please check
>  * the detailed description about the basics of the timer wheel.

I've never realized this constant worst percentage of slack. Would be nice to mention
that somewhere in kernel/time/timer.c

However this doesn't need a second to apply. It only takes crossing levels above
0. Or am I missing something?

>  *
>  * The slack of timers which will end up in the first level depends on:
>  *
>  * * sleep duration (msecs)
>  * * HZ configuration
>  *
>  * To make sure the sleep duration with the slack is accurate enough, a slack
>  * value is required (because of the design of the timer wheel it is not

But where is it required?

>  * possible to define a value smaller than 12.5%). The following check makes
>  * clear, whether the sleep duration with the defined slack and with the HZ
>  * configuration will meet the constraints:
>  *
>  *  ``msecs >= (MSECS_PER_TICK / slack)``
>  *
>  * Examples:
>  *
>  * * ``HZ=1000`` with ``slack=25%``: ``MSECS_PER_TICK / slack = 1 / (1/4) = 4``:
>  *   all sleep durations greater or equal 4ms will meet the constraints.
>  * * ``HZ=1000`` with ``slack=12.5%``: ``MSECS_PER_TICK / slack = 1 / (1/8) = 8``:
>  *   all sleep durations greater or equal 8ms will meet the constraints.
>  * * ``HZ=250`` with ``slack=25%``: ``MSECS_PER_TICK / slack = 4 / (1/4) = 16``:
>  *   all sleep durations greater or equal 16ms will meet the constraints.
>  * * ``HZ=250`` with ``slack=12.5%``: ``MSECS_PER_TICK / slack = 4 / (1/8) = 32``:
>  *   all sleep durations greater or equal 32ms will meet the constraints.

But who defines those slacks and where? I'm even more confused now...

>  *
>  * See also the signal aware variant msleep_interruptible().
>  */
> 
> >
> > But I'm still lost...
> >
> 
> Hopefully no longer :)

Well...

> Thanks,
> 
> 	Anna-Maria
> 
> 

