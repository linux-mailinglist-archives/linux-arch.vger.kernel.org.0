Return-Path: <linux-arch+bounces-8982-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0D39C46CF
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 21:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601FF1F2792B
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011FD1A9B3E;
	Mon, 11 Nov 2024 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjrplZC4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B461A256C;
	Mon, 11 Nov 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356981; cv=none; b=p41TsjYbiharGpfx5XkuYydKRbPsTqBtDQF6+xynbwX3c/x4ehQFeFanEs9TzmOfjFNkw8H2WsPVXendwGk8WrqS9yEsCxoiFrFsfxxyeLIZVdCQTzgNmjXQKyi3nMKuanyVrJ0Bi9WW1iRemWNdNNH2dDoRqWZfjMvoH7DJ8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356981; c=relaxed/simple;
	bh=TGhfK/Yuf5VBRqTPtH4ckQmyZw+vRvADRvDG/zLBITA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeIi1N1KbqD4fftfgCgYBg6S41oqsjRfvwlE7DJA3VgqN4ZDnTXnPcr0BMQ4vJNDhgEMtxfdzFMU5c8GawamivJ87WPWW9l3TiXY7MPp02ElClxNP3Tyh3j9IO921N+j4KRQUHcyT0/CcSqTW3t4ma2xTo5x+6iQ63ed3VpH764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjrplZC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A765C4CECF;
	Mon, 11 Nov 2024 20:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731356981;
	bh=TGhfK/Yuf5VBRqTPtH4ckQmyZw+vRvADRvDG/zLBITA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RjrplZC4qkDm9l5CgivNExKmnfXLB7Sdpe92qq0UPDZZ125isrYuzAqdn0spRVaP6
	 FzgfCrljMNcQkaXGGqGeNUHgQ41gqElh1eCz8ZtVIgK/0LNAEP/Lqbz0iHQPCtsfu5
	 qp1tG1uCwnhbLBSYMgqQIE2yk2vff1aDqrBeXxT+W19+3Ec4PsAxObvbIEKlDmgGYJ
	 Ez0BKs6B39JDlMbz6R+X82C/1Ok37c2TLaov9OV15UDeRKODQ+GpVGcvdsCRR2gT/x
	 c7QiDyf/NSXXw7oHyaSnVB9ze8kYEw5ZrEtxNWYJFrN9V8v8XfBGhF/YgEJi0bNF1i
	 FDC0sZ5nNsyxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 03FD0CE0BA3; Mon, 11 Nov 2024 12:29:41 -0800 (PST)
Date: Mon, 11 Nov 2024 12:29:41 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: =?utf-8?B?U3rFkWtl?= Benjamin <egyszeregy@freemail.hu>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
Message-ID: <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>

On Mon, Nov 11, 2024 at 08:56:34PM +0100, Szőke Benjamin wrote:
> 2024. 11. 11. 20:22 keltezéssel, Paul E. McKenney írta:
> > On Mon, Nov 11, 2024 at 07:52:50PM +0100, Szőke Benjamin wrote:
> > > 2024. 11. 11. 17:54 keltezéssel, Paul E. McKenney írta:
> > > > On Mon, Nov 11, 2024 at 05:42:47PM +0100, egyszeregy@freemail.hu wrote:
> > > > > From: Benjamin Szőke <egyszeregy@freemail.hu>
> > > > > 
> > > > > The goal is to fix Linux repository for case-insensitive filesystem,
> > > > > to able to clone it and editable on any operating systems.
> > > > > 
> > > > > Rename "Z6.0+pooncelock+poonceLock+pombonce.litmus" to
> > > > > "Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus".
> > > > > 
> > > > > Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
> > > > 
> > > > Ummm...  Really?
> > > > 
> > > > Just out of curiosity, which operating-system/filesystem combination are
> > > > you working with?  And why not instead fix that combination to handle
> > > > mixed case?
> > > > 
> > > > 							Thanx, Paul
> > > 
> > > Windows and also MacOS is not case sensitive by default. My goal is to
> > > improve Linux kernel source-tree, to able to develop it in any operating
> > > systems for example via Visual Studio Code extensions/IntelliSense feature
> > > or any similar IDE which is usable in any OS.
> > 
> > Why not simply enable case sensitivity on the file tree in which you
> > are processing Linux-kernel source code?
> > 
> > For MacOS:  https://discussions.apple.com/thread/251191099?sortBy=rank
> > For Windows:  https://learn.microsoft.com/en-us/windows/wsl/case-sensitivity
> > 
> > In some cases it might work better to simply run a Linux VM on top of
> > Windows or MacOS.
> > 
> > They tell me that webservers already do this, so why not also for
> > Linux-kernel source code?
> 
> Why we not solve it as simple as it can in the source code of the Linux
> kernel with renaming? It would be more robust and more durable to fix this
> issue/inconviniant in the source as an overal complete solution. Nobody like
> to figth with configuraition hell of Windows and MacOS, or build up a
> diskspace consumer Virtual Linux with crappy GUI capapilities for coding big
> things.
> 
> Young developers will never be willing to join and contributing in Linux
> kernel in the future if Linux kernel code is not editable in a high-quality,
> easy-to-use IDE for, which is usable in any OS.

There are a great number of software projects out there that use mixed
case.  Therefore, can an IDE that does not gracefully handle mixed case
really be said to be either high quality or easy to use?

In other words, you have the option of making the IDE handle this.

> Need to improve this kind of things and simplify/modernize developing or
> never will be solved the following issues:
> https://www.youtube.com/watch?v=lJLw94pAcBY

Sorry, but that video does not support your point.  In fact, the presenter
clearly states that this sort of tooling issue is not a real problem
for the Linux kernel near the middle of that video.

							Thanx, Paul

> > > There were some accepted patches which aim this same goal.
> > > https://gitlab.freedesktop.org/drm/kernel/-/commit/231bb9b4c42398db3114c087ba39ba00c4b7ac2c
> > > https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/commit/?h=for-curr&id=8bf275d61925cff45568438c73f114e46237ad7e
> > 
> > Fair enough, as it is the maintainer's choice.  Which means that
> > their accepting these case-sensitivity changes does not require other
> > maintainers to do so.
> > 
> > 							Thanx, Paul
> > 
> > > > > ---
> > > > >    tools/memory-model/Documentation/locking.txt                    | 2 +-
> > > > >    tools/memory-model/Documentation/recipes.txt                    | 2 +-
> > > > >    tools/memory-model/litmus-tests/README                          | 2 +-
> > > > >    ...> Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} | 0
> > > > >    4 files changed, 3 insertions(+), 3 deletions(-)
> > > > >    rename tools/memory-model/litmus-tests/{Z6.0+pooncelock+poonceLock+pombonce.litmus => Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} (100%)
> > > > > 
> > > > > diff --git a/tools/memory-model/Documentation/locking.txt b/tools/memory-model/Documentation/locking.txt
> > > > > index 65c898c64a93..42bc3efe2015 100644
> > > > > --- a/tools/memory-model/Documentation/locking.txt
> > > > > +++ b/tools/memory-model/Documentation/locking.txt
> > > > > @@ -184,7 +184,7 @@ ordering properties.
> > > > >    Ordering can be extended to CPUs not holding the lock by careful use
> > > > >    of smp_mb__after_spinlock():
> > > > > -	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
> > > > > +	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
> > > > >    	void CPU0(void)
> > > > >    	{
> > > > >    		spin_lock(&mylock);
> > > > > diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
> > > > > index 03f58b11c252..35996eb1b690 100644
> > > > > --- a/tools/memory-model/Documentation/recipes.txt
> > > > > +++ b/tools/memory-model/Documentation/recipes.txt
> > > > > @@ -159,7 +159,7 @@ lock's ordering properties.
> > > > >    Ordering can be extended to CPUs not holding the lock by careful use
> > > > >    of smp_mb__after_spinlock():
> > > > > -	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
> > > > > +	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
> > > > >    	void CPU0(void)
> > > > >    	{
> > > > >    		spin_lock(&mylock);
> > > > > diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> > > > > index d311a0ff1ae6..e3d451346400 100644
> > > > > --- a/tools/memory-model/litmus-tests/README
> > > > > +++ b/tools/memory-model/litmus-tests/README
> > > > > @@ -149,7 +149,7 @@ Z6.0+pooncelock+pooncelock+pombonce.litmus
> > > > >    	spin_lock() sufficient to make ordering apparent to accesses
> > > > >    	by a process not holding the lock?
> > > > > -Z6.0+pooncelock+poonceLock+pombonce.litmus
> > > > > +Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
> > > > >    	As above, but with smp_mb__after_spinlock() immediately
> > > > >    	following the spin_lock().
> > > > > diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
> > > > > similarity index 100%
> > > > > rename from tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
> > > > > rename to tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
> > > > > -- 
> > > > > 2.47.0.windows.2
> > > > > 
> > > 
> 

