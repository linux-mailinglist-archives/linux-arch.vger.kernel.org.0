Return-Path: <linux-arch+bounces-4331-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB138C3392
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 21:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D38528231A
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF311D554;
	Sat, 11 May 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA6Tl/Nu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BAD28E8;
	Sat, 11 May 2024 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715456221; cv=none; b=dvbGWp0rJYMfI8iZKhGo3ebiIjr5ccKAibOc6BFznhR1ePUjuOxKXbyBvIs431kBAp2BzlbrFPeXHl92Q3XeNkJAhBRLNzOIx9Nabgp1vdtAn/7ISDNX2R8lOdWIjkhOJjUjVUh7e/eGwofKU0vnUXrRsxkfe9vuDelfRJJIaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715456221; c=relaxed/simple;
	bh=Q5o5JneIswt/b5UG0phWcTLBa6olOmJH1BlimYH1Ifk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbZupsX0fWPpLGcpAX7cGb2lHVVwU4y0tT2cGWjEC6m9ehjuAuI7eRAm9uvoHO9XO5iFpt4Yo8CipZA1gnwFz0Mo9Ag6JzEOo4E787tXW9bHPlVYhe6/OjA6iCvSLRf23IA4jNHkApnTU9vYAB21Ts1HyNcpTA6jNMp1XTzbomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA6Tl/Nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99552C2BBFC;
	Sat, 11 May 2024 19:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715456220;
	bh=Q5o5JneIswt/b5UG0phWcTLBa6olOmJH1BlimYH1Ifk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DA6Tl/NuOz2EnzJYJD3Ep5ZlKfD3Wv6fQ/B2Vh062w5//j2v2OtK0MTsTUkfBDd5J
	 VPMZxfDDZHlCVHVKFm8Ai5hiaIEy67iwINn4Olhs/22v8Xh9WVjfP4EDZqFfdUNu3v
	 TiGXdCTswfjaAzDUayna7uESDZ5pBf/k7wgjMuFpOfSlvp4R4Z345O74wAwcqn4ucQ
	 7Rrgu1o52AQ/pTE6jVBIdStN2v7ir9PVcXn5hHYhj5wkcxe+9TD0T1s2GsZ1iFbDd7
	 eB6ueqv6YiP0OkAUMsDgTgP8uDqmAoSKrJrYleUjd4J1yKOe8Ymaae6myJrTG/wx8F
	 0vVCks6xbsqNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0610BCE02E9; Sat, 11 May 2024 12:37:00 -0700 (PDT)
Date: Sat, 11 May 2024 12:37:00 -0700
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
Message-ID: <a1331c86-dc07-4635-b169-623fcdd11824@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
 <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
 <6e6dae45ffbf7a6ab54175695a3e21207c6f5126.camel@physik.fu-berlin.de>
 <46543a98-4767-471a-91be-20fb60ab138b@paulmck-laptop>
 <7432d241b538819b603194bfb3a306faf360d4b1.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7432d241b538819b603194bfb3a306faf360d4b1.camel@physik.fu-berlin.de>

On Sat, May 11, 2024 at 08:49:08PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Paul,
> 
> On Fri, 2024-05-10 at 15:28 -0700, Paul E. McKenney wrote:
> > > I'm still against dropping pre-EV56 so quickly without a proper phaseout period.
> > > Why not wait for the next LTS release? AFAIK pre-EV56 support is not broken, is
> > > it?
> > 
> > Sadly, yes, it is, and it has been broken in mainline for almost two
> > years.
> 
> Could you elaborate what exactly is broken? I'm just trying to understand the reasoning.

First, let's make sure that I completely and correctly understand the
situation.

The pre-EV56 Alphas have no byte store instruction, correct?

If that is in fact correct, what code is generated for a volatile store
to a single byte for those CPUs?  For example, for this example?

	char c;

	...

	WRITE_ONCE(c, 3);

The rumor I heard is that the compilers will generate a non-atomic
read-modify-write instruction sequence in this case, first reading the
32-bit word containing that byte into a register, then substituting the
value to be stored into corresponding byte of that register, and finally
doing a 32-bit store from that register.

Is that the case, or am I confused?

							Thanx, Paul

PS:  Or, if you prefer, this example is equivalent:

	volatile char c;

	...

	c = 3;

