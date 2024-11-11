Return-Path: <linux-arch+bounces-8972-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777519C4306
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 17:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA121F2557C
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247341A262A;
	Mon, 11 Nov 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8GlLOdT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D40197A7F;
	Mon, 11 Nov 2024 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344062; cv=none; b=EmWcYWx1AjiN7zYP8z8RLNLHmd4r5Wu+93B6WjMe4Rjk6yaLe8cv/Oyfi1Mcs+aHbz9jPf217jbE4PNl2LS9pCUo2BC9mEmWBQhFzQt8KwZmwvuVCdHYNcfor9z7A8UsYILsapbS/9STwnpSpeVm1sDKwB6QY6HFMJlKBsi/KPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344062; c=relaxed/simple;
	bh=mspEjnUL8FzcXKfpr+cohV5+ZL+sx/0/VOUfpAs6itc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9ZmKIJWSY6Z0IIM7P1MtF1iHO4TOFMvHNyvRMvfee+q3p7inL2tZRkS9IoHKCNIbogkRcmrqHB7s9r7cTDhMyD19hVgMojZxhiF9jD19fhkr57nKKFHNAgHu71Nn8PFa3J9FuccFBL65IZAuyyO+MvEQY2ZQJHw84emTcOCSj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8GlLOdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E08BC4CECF;
	Mon, 11 Nov 2024 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731344061;
	bh=mspEjnUL8FzcXKfpr+cohV5+ZL+sx/0/VOUfpAs6itc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=e8GlLOdTkBO988H1TU2ouEM5Kj/kaP26JWy4J+dCc1GEttNT7pfUzFIiQwq8osNuE
	 bxgrEOn8OsFdXHWByAZQ7bEKatQUU+nNg9wHVze/IN0keTwYKNid4jYez5bii0Ez1x
	 bU+Y1JwM3uJaiInGAX8xyhuKtqwbajdxOZXfQmjfeZxv5+hntEqlIqtRAMMgpYG+Y6
	 Dupmr9supKCYeGqSVOlGK11n4ft4LBUPagCK1Ng8nRVuxJ6gea2kMfqWDRaARamWvg
	 zjwxRHS6D50FX8c+5P4yf514hCUxQMqHM3W2RQX7w8Wl4Ci0EqeXZ/b782sFDnBCaj
	 mopINpldTRSTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0B33ECE09DE; Mon, 11 Nov 2024 08:54:21 -0800 (PST)
Date: Mon, 11 Nov 2024 08:54:21 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: egyszeregy@freemail.hu
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
Message-ID: <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111164248.1060-1-egyszeregy@freemail.hu>

On Mon, Nov 11, 2024 at 05:42:47PM +0100, egyszeregy@freemail.hu wrote:
> From: Benjamin Szőke <egyszeregy@freemail.hu>
> 
> The goal is to fix Linux repository for case-insensitive filesystem,
> to able to clone it and editable on any operating systems.
> 
> Rename "Z6.0+pooncelock+poonceLock+pombonce.litmus" to
> "Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus".
> 
> Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>

Ummm...  Really?

Just out of curiosity, which operating-system/filesystem combination are
you working with?  And why not instead fix that combination to handle
mixed case?

							Thanx, Paul

> ---
>  tools/memory-model/Documentation/locking.txt                    | 2 +-
>  tools/memory-model/Documentation/recipes.txt                    | 2 +-
>  tools/memory-model/litmus-tests/README                          | 2 +-
>  ...> Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} | 0
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename tools/memory-model/litmus-tests/{Z6.0+pooncelock+poonceLock+pombonce.litmus => Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} (100%)
> 
> diff --git a/tools/memory-model/Documentation/locking.txt b/tools/memory-model/Documentation/locking.txt
> index 65c898c64a93..42bc3efe2015 100644
> --- a/tools/memory-model/Documentation/locking.txt
> +++ b/tools/memory-model/Documentation/locking.txt
> @@ -184,7 +184,7 @@ ordering properties.
>  Ordering can be extended to CPUs not holding the lock by careful use
>  of smp_mb__after_spinlock():
>  
> -	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
> +	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
>  	void CPU0(void)
>  	{
>  		spin_lock(&mylock);
> diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
> index 03f58b11c252..35996eb1b690 100644
> --- a/tools/memory-model/Documentation/recipes.txt
> +++ b/tools/memory-model/Documentation/recipes.txt
> @@ -159,7 +159,7 @@ lock's ordering properties.
>  Ordering can be extended to CPUs not holding the lock by careful use
>  of smp_mb__after_spinlock():
>  
> -	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
> +	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
>  	void CPU0(void)
>  	{
>  		spin_lock(&mylock);
> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> index d311a0ff1ae6..e3d451346400 100644
> --- a/tools/memory-model/litmus-tests/README
> +++ b/tools/memory-model/litmus-tests/README
> @@ -149,7 +149,7 @@ Z6.0+pooncelock+pooncelock+pombonce.litmus
>  	spin_lock() sufficient to make ordering apparent to accesses
>  	by a process not holding the lock?
>  
> -Z6.0+pooncelock+poonceLock+pombonce.litmus
> +Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
>  	As above, but with smp_mb__after_spinlock() immediately
>  	following the spin_lock().
>  
> diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
> similarity index 100%
> rename from tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
> rename to tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
> -- 
> 2.47.0.windows.2
> 

