Return-Path: <linux-arch+bounces-4717-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9548FD47F
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 19:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EEEB25E25
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2551D19539E;
	Wed,  5 Jun 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5oLqyFs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AD194AE7;
	Wed,  5 Jun 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610262; cv=none; b=LzvKBj2RTJZon7SOpJ5J2UGBJEua8EFRmXHPo4m3U64PbSIo6/3d6Lp3eH8q6/C1dardRC908jqm4aGpJ3/G7YfT85OAsA7MR3BkKvBpxbD6yQ0q1PBDphtCJir7NfizCjw2Q1jVdqT27hdyXs1Vt7RgNWhZWbAbKFvqXiHC8UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610262; c=relaxed/simple;
	bh=5qgE9HCIK6VgCwwxB3oLRE7JHeNCeqE3R3gGXoTgU70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgzNtFNlRWKyYJkIIQJNVsA9HdH+SGiU54XGZ3fSLGEPpyT7fzIyAuoaQCwNYzpVPRIf1rjgaxHGSMXdk3vEAw+jO0+17EO+F6DUR/7Zhots5GsS5wdzh9lPHSYIj//dUHa5aBpWpZ/yfje5Rbyj78ECVyi+LFhPfzoPMMHrJBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5oLqyFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CBAC3277B;
	Wed,  5 Jun 2024 17:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610261;
	bh=5qgE9HCIK6VgCwwxB3oLRE7JHeNCeqE3R3gGXoTgU70=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=X5oLqyFs/fUOIspiZa3AO98Uwy+/LGpCKo+rDKsLfLHNrxARh48ud5ztVtVxD0ym2
	 2LCsSXPumsnEB6KW2dKvdf4MmtBnuwrQkMavym3dbw/3paACPdyIyYIOifBj+M6VCl
	 Vl15J6irXr+pCIc4KqQ6+4E0ujTUghH96mPVe7QMqmrBYasli5yR+Wop6r9NKJoJeM
	 bgzLMne+IwX/BhmYxq+Y+585w2jiTCLZ5+O7wOYGo73DOvBgke/a/mo0eeGkb4TPHT
	 LImvMIp7R1Hxghw2kA1sJyQWUFGnUDJ9S04k1XXAHt6t6cpyT/rYUaPqlwPxZEhkiI
	 Fsl6WwRIU3j4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 794F0CE0A72; Wed,  5 Jun 2024 10:57:41 -0700 (PDT)
Date: Wed, 5 Jun 2024 10:57:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH memory-model 3/3] tools/memory-model: Add KCSAN LF
 mentorship session citation
Message-ID: <62cbaceb-1f65-4569-a54f-4c4bffed746f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
 <20240604221419.2370127-3-paulmck@kernel.org>
 <CANpmjNPPaqcHPowRSb=8u+rqykctRW_Mod5nO_0KTc68WdRLWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPPaqcHPowRSb=8u+rqykctRW_Mod5nO_0KTc68WdRLWw@mail.gmail.com>

On Wed, Jun 05, 2024 at 09:52:38AM +0200, Marco Elver wrote:
> On Wed, 5 Jun 2024 at 00:14, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Add a citation to Marco's LF mentorship session presentation entitled
> > "The Kernel Concurrency Sanitizer"
> >
> > [ paulmck: Apply Marco Elver feedback. ]
> >
> > Reported-by: Marco Elver <elver@google.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Acked-by: Marco Elver <elver@google.com>
> 
> Thanks for adding.

I will apply your ack on my next rebase, thank you!

							Thanx, Paul

> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Andrea Parri <parri.andrea@gmail.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > Cc: Luc Maranget <luc.maranget@inria.fr>
> > Cc: Akira Yokosawa <akiyks@gmail.com>
> > Cc: Daniel Lustig <dlustig@nvidia.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: <linux-arch@vger.kernel.org>
> > ---
> >  tools/memory-model/Documentation/access-marking.txt | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
> > index 65778222183e3..f531b0837356b 100644
> > --- a/tools/memory-model/Documentation/access-marking.txt
> > +++ b/tools/memory-model/Documentation/access-marking.txt
> > @@ -6,7 +6,8 @@ normal accesses to shared memory, that is "normal" as in accesses that do
> >  not use read-modify-write atomic operations.  It also describes how to
> >  document these accesses, both with comments and with special assertions
> >  processed by the Kernel Concurrency Sanitizer (KCSAN).  This discussion
> > -builds on an earlier LWN article [1].
> > +builds on an earlier LWN article [1] and Linux Foundation mentorship
> > +session [2].
> >
> >
> >  ACCESS-MARKING OPTIONS
> > @@ -31,7 +32,7 @@ example:
> >         WRITE_ONCE(a, b + data_race(c + d) + READ_ONCE(e));
> >
> >  Neither plain C-language accesses nor data_race() (#1 and #2 above) place
> > -any sort of constraint on the compiler's choice of optimizations [2].
> > +any sort of constraint on the compiler's choice of optimizations [3].
> >  In contrast, READ_ONCE() and WRITE_ONCE() (#3 and #4 above) restrict the
> >  compiler's use of code-motion and common-subexpression optimizations.
> >  Therefore, if a given access is involved in an intentional data race,
> > @@ -594,5 +595,8 @@ REFERENCES
> >  [1] "Concurrency bugs should fear the big bad data-race detector (part 2)"
> >      https://lwn.net/Articles/816854/
> >
> > -[2] "Who's afraid of a big bad optimizing compiler?"
> > +[2] "The Kernel Concurrency Sanitizer"
> > +    https://www.linuxfoundation.org/webinars/the-kernel-concurrency-sanitizer
> > +
> > +[3] "Who's afraid of a big bad optimizing compiler?"
> >      https://lwn.net/Articles/793253/
> > --
> > 2.40.1
> >

