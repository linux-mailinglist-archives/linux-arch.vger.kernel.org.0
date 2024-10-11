Return-Path: <linux-arch+bounces-8035-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4859E99A3CB
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 14:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C291C2330F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 12:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A9217902;
	Fri, 11 Oct 2024 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Prq+SKho"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C310F7;
	Fri, 11 Oct 2024 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649357; cv=none; b=O2ojE1OY2Q/h9czWLmivolcLu9vHsM4X4Tq434z+wnFSWJZuOyWm5SMz97KMbyerQ3Pal9jCKU3jS6pCxAjLXPtwk4fZPjQjqTWgQQC9uoN9aX36JrVkgjEzpli0pGAqRjlQ+dS3T+S29Ags2PbgeVvIeQ01gd5ttTDqfziRAf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649357; c=relaxed/simple;
	bh=B5Iy/9ftq4KBwLaC3rfpxqAUMJU39oc6TaojDmgcRQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=om8akYxy35tCGtCdwH1PYowmozUmThY5knzRRetsZAmkolD55QOpXbZVKK4sjMMUM9FkBlLUG2FtM4AuirOq6N1bSErSx1A/Ehx5ZPQ+E3kMCJCyrPoytaNe9g0moksv6/yr9K0IKYG9JIb09YoszHxMtV0QAGOV24j6hr/SQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Prq+SKho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED53C4CECE;
	Fri, 11 Oct 2024 12:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649357;
	bh=B5Iy/9ftq4KBwLaC3rfpxqAUMJU39oc6TaojDmgcRQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Prq+SKho8+F4utfD51E8T3n9B7Fic/+nISuvn7hQDj+DUouTYpkuzbIFfOApxQ7/+
	 d2wlUjD4MI9gM2bnjn5F3zXAt2FGJwfXimP+knuggajM/JrdhTQwDXV1uFYVi7S71u
	 iWIyQZtNT47cKapxMK7y1mJ+WUDhJvOLdVWIV9D4mxupAC5YTZur5NkUdpN71+F3gL
	 qAsY1rHYAlfFdpCH7rVG+6Ww35ZzGiXlV7qaDG+kMVoIA6jG+AcMba3qvSG5Z871R5
	 QnLctJyndtm1MK4HHeOQqTEG31KgV9syCYoSTxrLh48ZTY7APNOS6tzCiK1IBHvyCV
	 kf5q358OD1pNA==
Date: Fri, 11 Oct 2024 14:22:34 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 05/15] timers: Update function descriptions of
 sleep/delay related functions
Message-ID: <ZwkYihUS2Cv1rkbY@pavilion.home>
References: <ZwMF_y62yJ-bmNL9@pavilion.home>
 <87wmig9wj4.fsf@somnus>
 <ZwfKNNpjYnn2OGWG@localhost.localdomain>
 <875xpzvt3v.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xpzvt3v.fsf@somnus>

Le Fri, Oct 11, 2024 at 12:20:20PM +0200, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> > However this doesn't need a second to apply. It only takes crossing levels above
> > 0. Or am I missing something?
> 
> s/the second/level 1/
> 
> more clear? Then it's the same number as used in the timer wheel
> documentation.

Oh right! I was confused with second (s) and 2nd. Yes much better.

> 
> >>  *
> >>  * The slack of timers which will end up in the first level depends on:
> >>  *
> 
> Same here: s/the first level/level 0/

Much better !

> 
> >>  * * sleep duration (msecs)
> >>  * * HZ configuration
> >>  *
> >>  * To make sure the sleep duration with the slack is accurate enough, a slack
> >>  * value is required (because of the design of the timer wheel it is not
> >
> > But where is it required?
> 
> The callsite has to decide which accuracy/slack is required for their
> use case (this was also part of the discussion which leads to this
> queue).
> 
> >>  * possible to define a value smaller than 12.5%). The following check makes
> >>  * clear, whether the sleep duration with the defined slack and with the HZ
> >>  * configuration will meet the constraints:
> >>  *
> >>  *  ``msecs >= (MSECS_PER_TICK / slack)``
> >>  *
> >>  * Examples:
> >>  *
> >>  * * ``HZ=1000`` with ``slack=25%``: ``MSECS_PER_TICK / slack = 1 / (1/4) = 4``:
> >>  *   all sleep durations greater or equal 4ms will meet the constraints.
> >>  * * ``HZ=1000`` with ``slack=12.5%``: ``MSECS_PER_TICK / slack = 1 / (1/8) = 8``:
> >>  *   all sleep durations greater or equal 8ms will meet the constraints.
> >>  * * ``HZ=250`` with ``slack=25%``: ``MSECS_PER_TICK / slack = 4 / (1/4) = 16``:
> >>  *   all sleep durations greater or equal 16ms will meet the constraints.
> >>  * * ``HZ=250`` with ``slack=12.5%``: ``MSECS_PER_TICK / slack = 4 / (1/8) = 32``:
> >>  *   all sleep durations greater or equal 32ms will meet the constraints.
> >
> > But who defines those slacks and where? I'm even more confused now...
> 
> I think I know where the confusion comes from. I rephrase it once more
> and turned around the calculation:
> 
> /**
>  * msleep - sleep safely even with waitqueue interruptions
>  * @msecs:	Requested sleep duration in milliseconds
>  *
>  * msleep() uses jiffy based timeouts for the sleep duration. Because of the
>  * design of the timer wheel, the maximum additional percentage delay (slack) is
>  * 12.5%. This is only valid for timers which will end up in level 1 or a
>  * higher level of the timer wheel. For explanation of those 12.5% please check
>  * the detailed description about the basics of the timer wheel.
>  *
>  * The slack of timers which will end up in level 0 depends on sleep
>  * duration (msecs) and HZ configuration and can be calculated in the
>  * following way (with the timer wheel design restriction that the slack
>  * is not less than 12.5%):
>  *
>  *   ``slack = MSECS_PER_TICK / msecs``
>  *
>  * When the allowed slack of the callsite is known, the calculation
>  * could be turned around to find the minimal allowed sleep duration to meet
>  * the constraints. For example:
>  *
>  * * ``HZ=1000`` with ``slack=25%``: ``MSECS_PER_TICK / slack = 1 / (1/4) = 4``:
>  *   all sleep durations greater or equal 4ms will meet the constraints.
>  * * ``HZ=1000`` with ``slack=12.5%``: ``MSECS_PER_TICK / slack = 1 / (1/8) = 8``:
>  *   all sleep durations greater or equal 8ms will meet the constraints.
>  * * ``HZ=250`` with ``slack=25%``: ``MSECS_PER_TICK / slack = 4 / (1/4) = 16``:
>  *   all sleep durations greater or equal 16ms will meet the constraints.
>  * * ``HZ=250`` with ``slack=12.5%``: ``MSECS_PER_TICK / slack = 4 / (1/8) = 32``:
>  *   all sleep durations greater or equal 32ms will meet the constraints.
>  *
>  * See also the signal aware variant msleep_interruptible().
>  */
> 
> Hopefully this attempt clarifies the confusion?
> 

Yes now it's perfectly clear!

Please add: Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.

