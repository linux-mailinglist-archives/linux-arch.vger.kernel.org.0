Return-Path: <linux-arch+bounces-9038-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE20C9C5D9B
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 17:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24FB281038
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F6620696F;
	Tue, 12 Nov 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP29/S0y"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14820696E;
	Tue, 12 Nov 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429812; cv=none; b=Ax6Acw6pCaRJy2Jap/pb609mh+yynvKsgkpdjJ4mDx+Ww9TcnqI0XjDHiUh8E4HxQAZTg7NgekdxkkV1BsdXcR9JkdO8ZJ+51QAV7Ckm9FNPxtZqxRP9kD5F8G+LY/7Vn8wdyYg54/Je4KtbcRx9uvBDW7pqPxXnI4ax9jIw2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429812; c=relaxed/simple;
	bh=f2lV8RaB8QNGA+MUFRtb1rcgq7DVyhNRRqvdbb6H5Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crB5q0R3GU38pWo8bcEnaIprm8XZQplSvoPu/PqRj8llKQh0Bp+enKKPjQ0Uk8Hi69jNc30n+JtfWV/Eg4dZdqbeVS4CVu5aJzaTDKqJ4cV5uRTMmryqlYWSa+tkfIRagFr4p+8wy8y/wKcr0SPWFSiEPxqRowisVcS/ask6nVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP29/S0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103DFC4CECD;
	Tue, 12 Nov 2024 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731429812;
	bh=f2lV8RaB8QNGA+MUFRtb1rcgq7DVyhNRRqvdbb6H5Us=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IP29/S0yVWTNoBbHO2CsgnI5LmqOQByjJJK8kAHvjAHtwjuh6HE0OBzqAXjHKCBkr
	 XeGjvPoAHP5h+GnkL34l3s691MAG9CLp8fLxWzX54hXwP3WLYunZ/8lrmwUUKdfNEH
	 Jc/D7+8JYBBnuUn682LAvOwojUlNrXT9TNLc25fmS5dZtYttDtqpAFjrlhoTwv4VJE
	 RV2WVfsEOp6zMZ1xqrxPZ6DaJkJ2a52LhPtT7gr8024IQcVZPdeb3ChSuR5EiUr5Ft
	 sZq0oVna+NH5wupskS0h4z7azE/rgFklXdduF9ykbFjnUQcalL8o4bTOGm5L1o/xMy
	 4tcam+K05etfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AD441CE0C4A; Tue, 12 Nov 2024 08:43:31 -0800 (PST)
Date: Tue, 12 Nov 2024 08:43:31 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: =?utf-8?B?U3rFkWtl?= Benjamin <egyszeregy@freemail.hu>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
Message-ID: <a9f0858b-6c05-4c7b-8677-8f635a025a05@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
 <CAHk-=wiEuh613GjBefTRe-_Eha1X1GoU=1nLt65uccSBC8Ne=A@mail.gmail.com>
 <705daf58-dd30-4935-9864-6489b9b90a35@freemail.hu>
 <ZzKpK_9nxh4Qg6mW@tardis.local>
 <9ecdbe98-666b-4467-85f5-7f9bc01788c2@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ecdbe98-666b-4467-85f5-7f9bc01788c2@freemail.hu>

On Tue, Nov 12, 2024 at 11:06:05AM +0100, Szőke Benjamin wrote:
> 2024. 11. 12. 2:02 keltezéssel, Boqun Feng írta:
> > On Tue, Nov 12, 2024 at 12:21:51AM +0100, Sz"oke Benjamin wrote:
> > > 2024. 11. 11. 23:00 keltezéssel, Linus Torvalds írta:
> > > > On Mon, 11 Nov 2024 at 13:15, Sz"oke Benjamin <egyszeregy@freemail.hu> wrote:
> > > > > 
> > > > > There is a technical issue in the Linux kernel source tree's file naming/styles
> > > > > in git clone command on case-insensitive filesystem.
> > > > 
> > > > No.
> > > > 
> > > > This is entirely your problem.
> > > > 
> > > > The kernel build does not work, and is not intended to work on broken setups.
> > > > 
> > > > If you have a case-insensitive filesystem, you get to keep both broken parts.
> > > > 
> > > > I actively hate case-insensitive filesystems. It's a broken model in
> > > > so many ways. I will not lift a finger to try to help that
> > > > braindamaged setup.
> > > > 
> > > > "Here's a nickel, Kid. Go buy yourself a real computer"
> > > > 
> > > >                Linus
> > > 
> > > 
> > > In this patch my goal is to improve Linux kernel codebase to able to
> > > edit/coding in any platform, in an IDE which has a modern GUI.
> > > 
> > > Chillout, i am not so stupid to compile kernel on this "braindamaged setup",
> > > I just like to edit the code and manage it by git commands.
> > > 
> > 
> > Then you just need to create a case-sensitive partition, no? What's the
> > *technical* issue of doing that? And that cannot be more challenging
> > than testing your kernel changes, right? So it won't raise the bar of a
> > potential serious kernel contributer.
> 
> It is easy to say just need a case-sensitive partition, and sure it can be
> configurable but for example on Windows, admin rights needed for it, which
> is not available in 90% for a workstation machine in an universitiy or a
> general company.

Or, as Boqun suggested, one of these websites:

https://elixir.bootlin.com/linux/v6.11/source
https://github.com/torvalds/linux/tree/master
https://lxr.linux.no/

And quite a few more.  They have at least some of the IDE-provided
cross-referencing capabilities, though I must confess that I still use
cscope and vi.  ;-)

							Thanx, Paul

