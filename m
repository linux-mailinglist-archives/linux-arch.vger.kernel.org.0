Return-Path: <linux-arch+bounces-6809-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E329646E3
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 15:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8011B2847EF
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDC4197A69;
	Thu, 29 Aug 2024 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llgUmdBC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FC19408D;
	Thu, 29 Aug 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938671; cv=none; b=neUSkoz7F9IDMhpPuh32eqIu+WiiOV9U1kjep2cui/XOlTLsgeoKOOpoIuWJ88zdz+rGk7+3v+lrCFgsrOWCCDrQVOtwfoP2zSNeuTjg8frZKPMqX5xMWNhcvsQZdBLRyXyU8dqI0mp3uzbh7MwzOXQHaTdOnqh8qFCrtKKo5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938671; c=relaxed/simple;
	bh=Ca+p3EBy6mFIJiseSrgzhJ3uhFfJHvkFK+bEdDKuuBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7gCfvsYMvI92iO+f7kYKfFTM+R9C3JTV13FB5evJA4RsExQ7JYxcnz6eLzfJAoxYlavfyZ9DMnEi0oiZC7kP+Xb4Jk3L3WG5yi8uU/O534IBBtTKBHC00kleoJa9cXBaG9Bam3VX2ampVOG9NiEV7qgSaSCli+foWktBGlLQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llgUmdBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA5CC4CEC1;
	Thu, 29 Aug 2024 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938670;
	bh=Ca+p3EBy6mFIJiseSrgzhJ3uhFfJHvkFK+bEdDKuuBE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=llgUmdBCThp6X16iae1KFMQ0xTfN49f3PUWONK5Zj8t8fZMrLztX3otPGqDW7Cqpx
	 vpFCeqZaoZGqcGQHm6nafaMiCUI3LgEKVElU7w8Kw9ilGP3KciDaQTRatnZ4Sdi76L
	 5Y106K47AAGjgYG6eaqP3+3/qwtyWAs4kKYAAf1coL0jm+oS9AJ5NBZ3hUxUpkexB/
	 xaGTHHp3d4xTh8qdUfza0hNskAYa98B4Eqiju3RZ9yPue+sTZrCZNrKYYMXzRKLMFL
	 NDx5DVq4YLrHupcgKLTvNsDYwkQb/i+IhGWBam9YFjUhpRg4Ou0fNa5ck2Lbqf0UfV
	 uA+1OtxyXppUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4D86ECE0D9C; Thu, 29 Aug 2024 06:37:50 -0700 (PDT)
Date: Thu, 29 Aug 2024 06:37:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: 16-bit store instructions &c?
Message-ID: <1bb58d8d-4a2a-4728-a8f3-9295145dbbb0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3ca4590a-8256-42d1-89ca-f337ae6f755c@paulmck-laptop>
 <b3512703-bab3-4999-ac20-b1b874fcfcc3@app.fastmail.com>
 <289c7e10-06df-435b-a30d-c2a5bc4eea29@paulmck-laptop>
 <9242c5c2-2011-45bf-8679-3f918323788e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9242c5c2-2011-45bf-8679-3f918323788e@app.fastmail.com>

On Wed, Aug 28, 2024 at 10:01:06PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 28, 2024, at 14:22, Paul E. McKenney wrote:
> > On Wed, Aug 28, 2024 at 01:48:41PM +0000, Arnd Bergmann wrote:
> >
> >> There is a related problem with ARM RiscPC, which
> >> uses a kernel built with -march=armv3, and that
> >> disallows 16-bit load/store instructions entirely,
> >> similar to how alpha ev5 and earlier lacked both
> >> byte and word access.
> >
> > And one left to go.  Progress, anyway.  ;-)
> 
> What I meant to say about this one is also that we can probably
> ignore it as well, since it's on the way out already, at the latest
> when gcc-9 becomes the minimum compiler, as gcc-8 was the last
> to support -march=armv3. We can also ask Russell if he's ok with
> dropping it earlier, as he is almost certainly the only user.

Even better, thank you!

My plan is to submit a pull request for the remaining three 8-bit
cmpxchg() emulation commits into the upcoming merge window.  In the
meantime, I will create similar patches for 16-bit cmpxchg() and perhaps
also both 8-bit and 16-bit xchg().  I will obviously CC both you and
Russell on the full set.  And if there are hardware-incompatibility
complaints, we can deal with them, whether by dropping the offending
pieces of my patches or by whatever other adjustments make sense.

Does that seem like a reasonable approach, or is there a better way?

> >> Everything else that I see has native load/store
> >> on 16-bit words and either has 16-bit atomics or
> >> can emulate them using the 32-bit ones.
> >> 
> >> However, the one thing that people usually
> >> want 16-bit xchg() for is qspinlock, and that
> >> one not only depends on it being atomic but also
> >> on strict forward-progress guarantees, which
> >> I think the emulated version can't provide
> >> in general.
> >> 
> >> This does not prevent architectures from doing
> >> it anyway.
> >
> > Given that the simpler spinlock does not provide forward-progress
> > guarantees, I don't see any reason that these guarantees cannot be voided
> > for architectures without native 16-bit stores and atomics.
> >
> > After all, even without those guarantees, qspinlock provides very real
> > benefits over simple spinlocks.
> 
> My understanding of this problem is that with a trivial bit spinlock,
> the worst case is that one task never gets the lock while others
> also want it, but a qspinlock based on a flawed xchg() implementation
> may end with none of the CPUs ever getting the lock. It may not
> matter in practice, but it does feel worse.

I could argue that there is no law saying that a flawed atomic operation
cannot cause a trivial bit spinlock to never be actually handed to any
CPU, but point taken.  Given that the emulated xchg() would be implemented
in terms of cmpxchg(), there is clearly less opportunity for the hardware
to "do the right thing" in terms of fairness and starvation.  After all,
the hardware very likekly has less visibility into a cmpxchg()-emulated
xchg() operation than into a hardware xchg() instruction.

Perhaps the best approach is a comment on the xchg() emulation stating
that it might offer weaker forward-progress guarantees.

An alternative approach is to emulate 16-bit cmpxchg(), and defer
emulation of 8-bit and 16-bit xchg().

Thoughts?

							Thanx, Paul

