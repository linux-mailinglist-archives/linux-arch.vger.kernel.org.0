Return-Path: <linux-arch+bounces-4352-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8B8C3AA1
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 06:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C9C2813B5
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 04:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CDE145B30;
	Mon, 13 May 2024 04:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ij1PmLMp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B922F08;
	Mon, 13 May 2024 04:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715572999; cv=none; b=ZsUdD75xfSAjqF+qpE+9FPy3BLkCLOkwVVSJlzb2ms1gM2a6UFBUcBtFdIE85mfvPBnfQCIKgWu6+Pmy5KHjmbQ4pkmLhPthEPc45hHlleSorTUnEbfGz3W/GO/PaGFLBBPvbOez2/yQ+iM0mt7OROEey13IqVRvXA/TOkp5vpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715572999; c=relaxed/simple;
	bh=+neRAQuDz/eL/RUGK6nZmBt9+IAnz1VY6pYxUd64wV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQyBWg7oxmyy1pufW7nNHfdIhzX7algMc6zy40DoFlmj30Bsckqv0JQl8wx20N7oOL/Nq70swsf6AF8Dwq/CQ4vlcvuTbQ24wLp+NTXbF1oCtqYD/xBlh3rHAbq2WM0HR1x/DQNLTKzn2twoYaFP8zqhDyu2gn04PfVZBqOiLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ij1PmLMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C8EC113CC;
	Mon, 13 May 2024 04:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715572999;
	bh=+neRAQuDz/eL/RUGK6nZmBt9+IAnz1VY6pYxUd64wV0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ij1PmLMpNeMzp+4gxi5K12CkyvJwOF3lv0WSRd+v4X3QKuEUFUgMZVvlr9gvq21Iv
	 bbn6zfWrES3GnraurpiTgBsnfPBmErBV+ayZMNA9BiZ3KZj9LCL4lHkEetaEGu1Uwv
	 Tz3Lb1jNUc/5vzw+VCiSwwlXvN+/S1M3cSyqg8gYCjeYO14i7Pd/6SMRuFdk2xLtJR
	 97IXv2F2sUVayDIAPRXxC7Oi+z+dcLGbh6rVaPRJYK6vGapuqXj8b7ZSGQdYyeBvIz
	 iAGiWkpd1npCwxaNnndtVCoIL2u3DPGpMkvIqfm7IARgcHPpSD38EUiUi4d9NLZ9Yb
	 W0OktVoErA/rw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 69AA2CE08A1; Sun, 12 May 2024 21:03:18 -0700 (PDT)
Date: Sun, 12 May 2024 21:03:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: arnd@arndb.de, glaubitz@physik.fu-berlin.de, ink@jurassic.park.msu.ru,
	linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, mattst88@gmail.com,
	richard.henderson@linaro.org, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	Ulrich Teichert <krypton@ulrich-teichert.org>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
Message-ID: <ec4e905b-030c-43bb-818a-f4a0299597f7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a8241a71-2b7d-4be0-8772-5c3b40fb5302@paulmck-laptop>
 <99765904-3f35-4c78-998e-b444a6ab90e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99765904-3f35-4c78-998e-b444a6ab90e4@gmail.com>

On Mon, May 13, 2024 at 12:50:07PM +0900, Akira Yokosawa wrote:
> On Sun, 12 May 2024 07:44:25 -0700, Paul E. McKenney wrote:
> > On Sun, May 12, 2024 at 08:02:59AM +0200, John Paul Adrian Glaubitz wrote:
> >> On Sat, 2024-05-11 at 18:26 -0700, Paul E. McKenney wrote:
> >> > And that breaks things because it can clobber concurrent stores to
> >> > other bytes in that enclosing machine word.
> >> 
> >> But pre-EV56 Alpha has always been like this. What makes it broken
> >> all of a sudden?
> > 
> > I doubt if it was sudden.   Putting concurrently (but rarely) accessed
> > small-value quantities into single bytes is a very natural thing to do,
> > and I bet that there are quite a few places in the kernel where exactly
> > this happens.  I happen to know of a specific instance that went into
> > mainline about two years ago.
> > 
> > So why didn't the people running current mainline on pre-EV56 Alpha
> > systems notice?  One possibility is that they are upgrading their
> > kernels only occasionally.  Another possibility is that they are seeing
> > the failures, but are not tracing the obtuse failure modes back to the
> > change(s) in question.  Yet another possibility is that the resulting
> > failures are very low probability, with mean times to failure that are
> > so long that you won't notice anything on a single system.
> 
> Another possibility is that the Jensen system was booted into uni processer
> mode.  Looking at the early boot log [1] provided by Ulrich (+CCed) back in
> Sept. 2021, I see the following by running "grep -i cpu":
> 
> >> > [1] https://marc.info/?l=linux-alpha&m=163265555616841&w=2
> 
> [    0.000000] Memory: 90256K/131072K available (8897K kernel code, 9499K rwdata, \
> 2704K rodata, 312K init, 437K bss, 40816K reserved, 0K cma-reserved) [    0.000000] \
> random: get_random_u64 called from __kmem_cache_create+0x54/0x600 with crng_init=0 [  \
> 0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1 [    0.000000]
>                                                      ^^^^^^
> 
> Without any concurrent atomic updates, the "broken" atomic accesses won't
> matter, I guess.

True enough!

							Thanx, Paul

