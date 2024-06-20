Return-Path: <linux-arch+bounces-4990-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A88910E23
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2024 19:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D165D1F2242C
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2024 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C3D1B3737;
	Thu, 20 Jun 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXj4h4it"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF817545;
	Thu, 20 Jun 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903566; cv=none; b=vD/IaMWLMBuTD98oFvjFi1lEeWmrknrs3BSX7AW92Nhqi6n03GUELusGvvBMKC6PmH6b08/ISp2Odx6eRiVkaBPtMMtM9qp72hPWYus2UYo8sbzfX800CiT+x6wXV29Ynq51Tmuef5A9otn20IlTcR3QKVVisuLrztucV8aMHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903566; c=relaxed/simple;
	bh=qk4456sBCjxKLWnBWCOTbUHhiEe7iSUI6k3KR/4USmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sow4yarm8Xt4dz6Tj4gQX8A3jkFXTzLpIXx6uKSYvT2C7ytgjhIor9yYAQFWaa0BIo8/4Zlnl+etNrbqSW9sqWFeZXyo4KxmDnTE6MhnGNwG85gmrVuMfoIihdLBSlJAAvZQp2XTHJEADSFF5FeQsDrDf/OsGLxaR1WdJlJ8nTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXj4h4it; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E00EC2BD10;
	Thu, 20 Jun 2024 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718903565;
	bh=qk4456sBCjxKLWnBWCOTbUHhiEe7iSUI6k3KR/4USmc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mXj4h4itjF5zRyeLlSxB5R/uZ5WDMKXaDIc2JuJTWyKvvoUm5XHvUICICtsbnD1wU
	 e61eJec9iEKPe4C+EzpRBB6uM256/7hz4LvGF18eUpoyc3Bq28wnLV/qS0Ki0BZfbL
	 PhZ4UVw51tkH9ajQJVDhcq5fffh6rig+GMwHOfrAN2OWosrnS6YWCqdwkwBFqmKUH+
	 Nz1fualtbf+zxFdR4XHYPMvT18dhhA4AFQW2pwkBiBnzRY951pGevSAf8BdEyjFJ/F
	 kBn0Sxq5WZNtH3TkcilfJlpfVB3Pi3MXqQXJrMXlopEdfZucm4JPS+YduV3qehUpDt
	 zdUwwzjYAmhyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 27D7ECE0B67; Thu, 20 Jun 2024 10:12:45 -0700 (PDT)
Date: Thu, 20 Jun 2024 10:12:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH v4] tools/memory-model: Document herd7 (abstract)
 representation
Message-ID: <b0691ab4-a61d-45ab-ad35-a6bbab987bfe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240619010604.1789103-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619010604.1789103-1-parri.andrea@gmail.com>

On Wed, Jun 19, 2024 at 03:06:04AM +0200, Andrea Parri wrote:
> The Linux-kernel memory model (LKMM) source code and the herd7 tool are
> closely linked in that the latter is responsible for (pre)processing
> each C-like macro of a litmus test, and for providing the LKMM with a
> set of events, or "representation", corresponding to the given macro.
> This commit therefore provides herd-representation.txt to document
> the representations of the concurrency macros, following their
> "classification" in Documentation/atomic_t.txt.
> 
> Suggested-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>

I have reverted the previous version and queued this one, thank you!!!

							Thanx, Paul

> ---
> Changes since v3 [1]:
>   - note that rmw is a subset of po
>   - include paulmck's wordsmithing
>   - add limitations, aka stress that certain ops have been intentionally omitted
>   - add collected Reviewed-by: tags
> 
> Changes since v2 [2]:
>   - drop lk-rmw links
> 
> Changes since v1 [3]:
>   - add legenda/notations
>   - add some SRCU, locking macros
>   - update formatting of failure cases
>   - update README file
> 
> [1] https://lore.kernel.org/lkml/20240617201759.1670994-1-parri.andrea@gmail.com/
> [2] https://lore.kernel.org/lkml/20240605134918.365579-1-parri.andrea@gmail.com/
> [3] https://lore.kernel.org/lkml/20240524151356.236071-1-parri.andrea@gmail.com/
> 
>  tools/memory-model/Documentation/README       |   7 +-
>  .../Documentation/herd-representation.txt     | 110 ++++++++++++++++++
>  2 files changed, 116 insertions(+), 1 deletion(-)
>  create mode 100644 tools/memory-model/Documentation/herd-representation.txt
> 
> diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
> index db90a26dbdf40..1f73014cc48a3 100644
> --- a/tools/memory-model/Documentation/README
> +++ b/tools/memory-model/Documentation/README
> @@ -33,7 +33,8 @@ o	You are familiar with Linux-kernel concurrency and the use of
>  
>  o	You are familiar with Linux-kernel concurrency and the use
>  	of LKMM, and would like to learn about LKMM's requirements,
> -	rationale, and implementation:	explanation.txt
> +	rationale, and implementation:	explanation.txt and
> +	herd-representation.txt
>  
>  o	You are interested in the publications related to LKMM, including
>  	hardware manuals, academic literature, standards-committee
> @@ -57,6 +58,10 @@ control-dependencies.txt
>  explanation.txt
>  	Detailed description of the memory model.
>  
> +herd-representation.txt
> +	The (abstract) representation of the Linux-kernel concurrency
> +	primitives in terms of events.
> +
>  litmus-tests.txt
>  	The format, features, capabilities, and limitations of the litmus
>  	tests that LKMM can evaluate.
> diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
> new file mode 100644
> index 0000000000000..ed988906f2b71
> --- /dev/null
> +++ b/tools/memory-model/Documentation/herd-representation.txt
> @@ -0,0 +1,110 @@
> +#
> +# Legend:
> +#	R,	a Load event
> +#	W,	a Store event
> +#	F,	a Fence event
> +#	LKR,	a Lock-Read event
> +#	LKW,	a Lock-Write event
> +#	UL,	an Unlock event
> +#	LF,	a Lock-Fail event
> +#	RL,	a Read-Locked event
> +#	RU,	a Read-Unlocked event
> +#	R*,	a Load event included in RMW
> +#	W*,	a Store event included in RMW
> +#	SRCU,	a Sleepable-Read-Copy-Update event
> +#
> +#	po,	a Program-Order link
> +#	rmw,	a Read-Modify-Write link - every rmw link is a po link
> +#
> +# By convention, a blank line in a cell means "same as the preceding line".
> +#
> +# Disclaimer.  The table includes representations of "add" and "and" operations;
> +# corresponding/identical representations of "sub", "inc", "dec" and "or", "xor",
> +# "andnot" operations are omitted.
> +#
> +    ------------------------------------------------------------------------------
> +    |                        C macro | Events                                    |
> +    ------------------------------------------------------------------------------
> +    |                    Non-RMW ops |                                           |
> +    ------------------------------------------------------------------------------
> +    |                      READ_ONCE | R[once]                                   |
> +    |                    atomic_read |                                           |
> +    |                     WRITE_ONCE | W[once]                                   |
> +    |                     atomic_set |                                           |
> +    |               smp_load_acquire | R[acquire]                                |
> +    |            atomic_read_acquire |                                           |
> +    |              smp_store_release | W[release]                                |
> +    |             atomic_set_release |                                           |
> +    |                   smp_store_mb | W[once] ->po F[mb]                        |
> +    |                         smp_mb | F[mb]                                     |
> +    |                        smp_rmb | F[rmb]                                    |
> +    |                        smp_wmb | F[wmb]                                    |
> +    |          smp_mb__before_atomic | F[before-atomic]                          |
> +    |           smp_mb__after_atomic | F[after-atomic]                           |
> +    |                    spin_unlock | UL                                        |
> +    |                 spin_is_locked | On success: RL                            |
> +    |                                | On failure: RU                            |
> +    |         smp_mb__after_spinlock | F[after-spinlock]                         |
> +    |      smp_mb__after_unlock_lock | F[after-unlock-lock]                      |
> +    |                  rcu_read_lock | F[rcu-lock]                               |
> +    |                rcu_read_unlock | F[rcu-unlock]                             |
> +    |                synchronize_rcu | F[sync-rcu]                               |
> +    |                rcu_dereference | R[once]                                   |
> +    |             rcu_assign_pointer | W[release]                                |
> +    |                 srcu_read_lock | R[srcu-lock]                              |
> +    |                 srcu_down_read |                                           |
> +    |               srcu_read_unlock | W[srcu-unlock]                            |
> +    |                   srcu_up_read |                                           |
> +    |               synchronize_srcu | SRCU[sync-srcu]                           |
> +    | smp_mb__after_srcu_read_unlock | F[after-srcu-read-unlock]                 |
> +    ------------------------------------------------------------------------------
> +    |       RMW ops w/o return value |                                           |
> +    ------------------------------------------------------------------------------
> +    |                     atomic_add | R*[noreturn] ->rmw W*[once]               |
> +    |                     atomic_and |                                           |
> +    |                      spin_lock | LKR ->po LKW                              |
> +    ------------------------------------------------------------------------------
> +    |        RMW ops w/ return value |                                           |
> +    ------------------------------------------------------------------------------
> +    |              atomic_add_return | F[mb] ->po R*[once]                       |
> +    |                                |     ->rmw W*[once] ->po F[mb]             |
> +    |               atomic_fetch_add |                                           |
> +    |               atomic_fetch_and |                                           |
> +    |                    atomic_xchg |                                           |
> +    |                           xchg |                                           |
> +    |            atomic_add_negative |                                           |
> +    |      atomic_add_return_relaxed | R*[once] ->rmw W*[once]                   |
> +    |       atomic_fetch_add_relaxed |                                           |
> +    |       atomic_fetch_and_relaxed |                                           |
> +    |            atomic_xchg_relaxed |                                           |
> +    |                   xchg_relaxed |                                           |
> +    |    atomic_add_negative_relaxed |                                           |
> +    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[once]                |
> +    |       atomic_fetch_add_acquire |                                           |
> +    |       atomic_fetch_and_acquire |                                           |
> +    |            atomic_xchg_acquire |                                           |
> +    |                   xchg_acquire |                                           |
> +    |    atomic_add_negative_acquire |                                           |
> +    |      atomic_add_return_release | R*[once] ->rmw W*[release]                |
> +    |       atomic_fetch_add_release |                                           |
> +    |       atomic_fetch_and_release |                                           |
> +    |            atomic_xchg_release |                                           |
> +    |                   xchg_release |                                           |
> +    |    atomic_add_negative_release |                                           |
> +    ------------------------------------------------------------------------------
> +    |            Conditional RMW ops |                                           |
> +    ------------------------------------------------------------------------------
> +    |                 atomic_cmpxchg | On success: F[mb] ->po R*[once]           |
> +    |                                |                 ->rmw W*[once] ->po F[mb] |
> +    |                                | On failure: R*[once]                      |
> +    |                        cmpxchg |                                           |
> +    |              atomic_add_unless |                                           |
> +    |         atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
> +    |                                | On failure: R*[once]                      |
> +    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[once]    |
> +    |                                | On failure: R*[once]                      |
> +    |         atomic_cmpxchg_release | On success: R*[once] ->rmw W*[release]    |
> +    |                                | On failure: R*[once]                      |
> +    |                   spin_trylock | On success: LKR ->po LKW                  |
> +    |                                | On failure: LF                            |
> +    ------------------------------------------------------------------------------
> -- 
> 2.34.1
> 

