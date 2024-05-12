Return-Path: <linux-arch+bounces-4338-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB018C36DA
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 16:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F4A1C20E29
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624F9286A6;
	Sun, 12 May 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfddMqHP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6001E488;
	Sun, 12 May 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715525067; cv=none; b=TevPGTdXF8ogsVR+zKeTdzKXcHFC4Ue1qOZRMc/yW3zCCXdM4xupgspeU/hJPjP759HQgfwviOlI25pcIUrRacHSVXJyO0U3dq+EIky7a0k2uKUKeweaUWe/WpO9ad5z/Dz2Gp7fraG5NxCoJHuwQDkYXlYhzu92nYBj4dhxYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715525067; c=relaxed/simple;
	bh=AwROLrxn0F0wXRVR180mb+2UZ4gIn9nj8gcQQDhqnQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK71SJ8/olT+3OIfVp6s1DOQVFfgTp40vu41eUL+S9cwvqEjirdJwzQmkxcEoV9rp9E9UzkYZrsOHoJGRsL5K0Geg0hkMSONxgSsL1eCcDt6+pfKl0Iw3+5NMQPd5sUCinspdjkBvze+tFRkIX6mrfcZUdMDOdbRDcCcdzy+i3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfddMqHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33CFC116B1;
	Sun, 12 May 2024 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715525066;
	bh=AwROLrxn0F0wXRVR180mb+2UZ4gIn9nj8gcQQDhqnQo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FfddMqHP66LJZ6mmAUxW5AywjFk8GWsCfeWpNLxdh70aZfm5Cdv53ZDXRzpxvUv0M
	 x/M7CxnPf3FFf+LslcQnMYtptVn4fpc4vEjikg7NWeZ8f4HwVjwotz9tVFZLdQKqLa
	 beW1PEHStVpIbnqrV5EoAocQXlUtys6lhBqhFp4bDl5lYQvYjR4WQNbinxu7Y01+FV
	 7CXjjUOBQwphlmHC6hy8P5mYZ9sqkHJU6wjmmmz7gSrTKy1obxAvmY1SpzwIjmVKzd
	 jQFf4QsteHIsot2ieSbDnsxbU/7VkIvjzhZ81PracAe58Wfv2B3I0g3wZTPKheOhAR
	 2w9EcD7dbZ14g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 873B0CE105C; Sun, 12 May 2024 07:44:25 -0700 (PDT)
Date: Sun, 12 May 2024 07:44:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-alpha@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
Message-ID: <a8241a71-2b7d-4be0-8772-5c3b40fb5302@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
 <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
 <6e6dae45ffbf7a6ab54175695a3e21207c6f5126.camel@physik.fu-berlin.de>
 <46543a98-4767-471a-91be-20fb60ab138b@paulmck-laptop>
 <7432d241b538819b603194bfb3a306faf360d4b1.camel@physik.fu-berlin.de>
 <a1331c86-dc07-4635-b169-623fcdd11824@paulmck-laptop>
 <8dd1c466-54e3-45c1-a19f-f81dd9dbf243@app.fastmail.com>
 <f01d9eb2-9ab8-4e82-99d2-467385ebce2b@paulmck-laptop>
 <975442500864e4f30a830afb4ffd09a9bedb65d6.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975442500864e4f30a830afb4ffd09a9bedb65d6.camel@physik.fu-berlin.de>

On Sun, May 12, 2024 at 08:02:59AM +0200, John Paul Adrian Glaubitz wrote:
> On Sat, 2024-05-11 at 18:26 -0700, Paul E. McKenney wrote:
> > And that breaks things because it can clobber concurrent stores to
> > other bytes in that enclosing machine word.
> 
> But pre-EV56 Alpha has always been like this. What makes it broken
> all of a sudden?

I doubt if it was sudden.   Putting concurrently (but rarely) accessed
small-value quantities into single bytes is a very natural thing to do,
and I bet that there are quite a few places in the kernel where exactly
this happens.  I happen to know of a specific instance that went into
mainline about two years ago.

So why didn't the people running current mainline on pre-EV56 Alpha
systems notice?  One possibility is that they are upgrading their
kernels only occasionally.  Another possibility is that they are seeing
the failures, but are not tracing the obtuse failure modes back to the
change(s) in question.  Yet another possibility is that the resulting
failures are very low probability, with mean times to failure that are
so long that you won't notice anything on a single system.

And the change of about two years ago would in fact have a very long
mean time to failure, as in in decades, if not centuries.

But it is still broken, and given a report of a bump-in-the-night failure
on such a system, my response has to be to assume that the inability of
that system to load and store individual bytes is a likely root cause.

> My question was whether it actually stopped working, i.e. it's no
> longer usable on these machines but that's not the case as far as
> I know as not too long ago someone was actually running Debian on
> a Jensen machine [1].

The thing is that I know of one issue.  There are very likely many
others, given that there apparently no checks for this sort of thing.
And as the kernel accumulates (say) seven-decade issues of this sort,
the reliability of your systems declines.

In contrast, if I make the mistake of using the C-language "/" operator
on 64-bit quantities, those affected do not suffer in silence.

> We could actually ask Ulrich Teichert what the current state is
> on his Jensen machine.

Please feel free to do so.

And if the ability to run current mainline reliably on these systems
is so very important to you, please also feel free to look into ways of
fixing this issue within the confines of the Alpha-specific code rather
than attempting to continue placing this outdated constraint on the rest
of the kernel.

Yes, it is no longer the year 1973, but it still is the case that using
four bytes (or, worse yet, per Arnd, eight bytes) where one byte will
do is wasting a huge amount of resources across the billions of systems
on which the Linux kernel runs.  So again, if running current mainline
on these decades-old systems is so very important to you, please figure
out a way to do so that isn't quite so wasteful of resources.

							Thanx, Paul

> Adrian
> 
> > [1] https://marc.info/?l=linux-alpha&m=163265555616841&w=2
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

