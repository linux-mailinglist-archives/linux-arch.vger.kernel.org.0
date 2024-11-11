Return-Path: <linux-arch+bounces-8978-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5519C45D1
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 20:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B30B23CCA
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 19:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222511A707D;
	Mon, 11 Nov 2024 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6lI8h5u"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644A1AA7BA;
	Mon, 11 Nov 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352929; cv=none; b=TXsruPx/9/tKJoAgtUZUFw21CO3LzHepuYVoIslDFO97uLrEQuVI4N7mX4dXX8w9R1AN9h9w1CcY+e9xYkhMO+Zbd4ASWTVZ5bnQ9QTp2KivFpXqYhXMnEzFWXQciN69Chd8PGEYRTrLxZnpcAeoObLJeqCJaqmdSykEzps562I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352929; c=relaxed/simple;
	bh=c02hTB78MoPcZ0Dt5j9XxHug0jIQ86D9X3K/ewWt1u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGqvSgnDwAJG9KYpn7MhDjkCIwqWt14Ulaiw7imOT9D0YXkguW/KWKePZhJdXhYwzd6wnusYRWK/K3fjaC+8C5iYFz1yuWfbLIosxFaOyXP2oYpYfiz87AW8K3efkOgr0bhU2ShXNawjrnW3uS/xOM+oVNHcq3DxYPvRsdaV/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6lI8h5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69464C4CECF;
	Mon, 11 Nov 2024 19:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731352928;
	bh=c02hTB78MoPcZ0Dt5j9XxHug0jIQ86D9X3K/ewWt1u8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=S6lI8h5ukNNudMSoQPI8TQUJ1r0QO6459lwmnJHoFzf3/OtKRhFMkLf+qbPVPqkqr
	 BcDkV2J5Cprd7Yh2oR0VV1Bc8VoJAb/9RrBPrWEbfb2zIDhD9DY15g0MH4+pU3SaPQ
	 ibUxidFVQ4T+6/eswo8zuoVEKnyY0rg+ZeF8Wm+NnzQBZIKc/wIdG0z5vj2qzaU/4R
	 8YV/kgf3984f+lU4JI/1BP6vuyGkd9FouVsmWV8E149XMRwNAzBdAVtFwKdPr0dnca
	 6hXPNrwl4mhPKMiSt29oITHt+M4lkckRozsm7/r/JBDPYLuw6wqAWWiWO6xSmQT0so
	 5tKh0GphHlcwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 08A5DCE0BA3; Mon, 11 Nov 2024 11:22:08 -0800 (PST)
Date: Mon, 11 Nov 2024 11:22:07 -0800
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
Message-ID: <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>

On Mon, Nov 11, 2024 at 07:52:50PM +0100, Szőke Benjamin wrote:
> 2024. 11. 11. 17:54 keltezéssel, Paul E. McKenney írta:
> > On Mon, Nov 11, 2024 at 05:42:47PM +0100, egyszeregy@freemail.hu wrote:
> > > From: Benjamin Szőke <egyszeregy@freemail.hu>
> > > 
> > > The goal is to fix Linux repository for case-insensitive filesystem,
> > > to able to clone it and editable on any operating systems.
> > > 
> > > Rename "Z6.0+pooncelock+poonceLock+pombonce.litmus" to
> > > "Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus".
> > > 
> > > Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
> > 
> > Ummm...  Really?
> > 
> > Just out of curiosity, which operating-system/filesystem combination are
> > you working with?  And why not instead fix that combination to handle
> > mixed case?
> > 
> > 							Thanx, Paul
> 
> Windows and also MacOS is not case sensitive by default. My goal is to
> improve Linux kernel source-tree, to able to develop it in any operating
> systems for example via Visual Studio Code extensions/IntelliSense feature
> or any similar IDE which is usable in any OS.

Why not simply enable case sensitivity on the file tree in which you
are processing Linux-kernel source code?

For MacOS:  https://discussions.apple.com/thread/251191099?sortBy=rank
For Windows:  https://learn.microsoft.com/en-us/windows/wsl/case-sensitivity

In some cases it might work better to simply run a Linux VM on top of
Windows or MacOS.

They tell me that webservers already do this, so why not also for
Linux-kernel source code?

> There were some accepted patches which aim this same goal.
> https://gitlab.freedesktop.org/drm/kernel/-/commit/231bb9b4c42398db3114c087ba39ba00c4b7ac2c
> https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/commit/?h=for-curr&id=8bf275d61925cff45568438c73f114e46237ad7e

Fair enough, as it is the maintainer's choice.  Which means that
their accepting these case-sensitivity changes does not require other
maintainers to do so.

							Thanx, Paul

> > > ---
> > >   tools/memory-model/Documentation/locking.txt                    | 2 +-
> > >   tools/memory-model/Documentation/recipes.txt                    | 2 +-
> > >   tools/memory-model/litmus-tests/README                          | 2 +-
> > >   ...> Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} | 0
> > >   4 files changed, 3 insertions(+), 3 deletions(-)
> > >   rename tools/memory-model/litmus-tests/{Z6.0+pooncelock+poonceLock+pombonce.litmus => Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} (100%)
> > > 
> > > diff --git a/tools/memory-model/Documentation/locking.txt b/tools/memory-model/Documentation/locking.txt
> > > index 65c898c64a93..42bc3efe2015 100644
> > > --- a/tools/memory-model/Documentation/locking.txt
> > > +++ b/tools/memory-model/Documentation/locking.txt
> > > @@ -184,7 +184,7 @@ ordering properties.
> > >   Ordering can be extended to CPUs not holding the lock by careful use
> > >   of smp_mb__after_spinlock():
> > > -	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
> > > +	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
> > >   	void CPU0(void)
> > >   	{
> > >   		spin_lock(&mylock);
> > > diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
> > > index 03f58b11c252..35996eb1b690 100644
> > > --- a/tools/memory-model/Documentation/recipes.txt
> > > +++ b/tools/memory-model/Documentation/recipes.txt
> > > @@ -159,7 +159,7 @@ lock's ordering properties.
> > >   Ordering can be extended to CPUs not holding the lock by careful use
> > >   of smp_mb__after_spinlock():
> > > -	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
> > > +	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
> > >   	void CPU0(void)
> > >   	{
> > >   		spin_lock(&mylock);
> > > diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> > > index d311a0ff1ae6..e3d451346400 100644
> > > --- a/tools/memory-model/litmus-tests/README
> > > +++ b/tools/memory-model/litmus-tests/README
> > > @@ -149,7 +149,7 @@ Z6.0+pooncelock+pooncelock+pombonce.litmus
> > >   	spin_lock() sufficient to make ordering apparent to accesses
> > >   	by a process not holding the lock?
> > > -Z6.0+pooncelock+poonceLock+pombonce.litmus
> > > +Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
> > >   	As above, but with smp_mb__after_spinlock() immediately
> > >   	following the spin_lock().
> > > diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
> > > similarity index 100%
> > > rename from tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
> > > rename to tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
> > > -- 
> > > 2.47.0.windows.2
> > > 
> 

