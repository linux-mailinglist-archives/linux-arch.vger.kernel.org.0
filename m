Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA2C39BAC0
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 16:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFDOO7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 10:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhFDOO7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 10:14:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAEC560FE7;
        Fri,  4 Jun 2021 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622815993;
        bh=xRpwrH0HJ2KIddrVIvTkRxRVVT2tlbNc3AZvwAnuhSA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ouzYknCwxkrIynnHdWsKXnNEAHUxGgmagRE1vEAl1nDnjmdWUeEsSrp6zL5iCYij+
         qb/D9heJKhZnerD0KcMZXxBDz5SVKb1SilNVtD/yILmpXkIUkYNslbSf1FkeTYXBUg
         icblfFBsoXDygLSnO+EuO7WeCtFBfYvgQ+kagG+1MXEn9B0e9nZH9y10TsTJNE0t0P
         2/vBsPehS6LIicO7T/udDbwgJki+5JeClTfzufCR9qFmKqDR14SoRNdLIfVvC2Eq0S
         1PxBnLMFWLp1Nl+ETBChuo0WQzCzqbaBjrjhHz6TtQR4sVjSIL87krcoMjxwdnwprM
         TNvpKp9TVlSjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9F5BF5C0154; Fri,  4 Jun 2021 07:13:12 -0700 (PDT)
Date:   Fri, 4 Jun 2021 07:13:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604141312.GV4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <YLoSJaOVbzKXU4/7@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLoSJaOVbzKXU4/7@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 01:44:37PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 12:12:07PM +0200, Peter Zijlstra wrote:
> > +/**
> > + * volatile_if() - Provide a control-dependency
> > + *
> > + * volatile_if(READ_ONCE(A))
> > + *	WRITE_ONCE(B, 1);
> > + *
> > + * will ensure that the STORE to B happens after the LOAD of A. Normally a
> > + * control dependency relies on a conditional branch having a data dependency
> > + * on the LOAD and an architecture's inability to speculate STOREs. IOW, this
> > + * provides a LOAD->STORE order.
> > + *
> > + * Due to optimizing compilers extra care is needed; as per the example above
> > + * the LOAD must be 'volatile' qualified in order to ensure the compiler
> > + * actually emits the load, such that the data-dependency to the conditional
> > + * branch can be formed.
> > + *
> > + * Secondly, the compiler must be prohibited from lifting anything out of the
> > + * selection statement, as this would obviously also break the ordering.
> > + *
> > + * Thirdly, and this is the tricky bit, architectures that allow the
> > + * LOAD->STORE reorder must ensure the compiler actually emits the conditional
> > + * branch instruction, this isn't possible in generic.
> > + *
> > + * See the volatile_cond() wrapper.
> > + */
> > +#define volatile_if(cond) if (volatile_cond(cond))
> 
> On naming (sorry Paul for forgetting that in the initial mail); while I
> think using the volatile qualifier for the language feature (can we haz
> plz, kthxbai) makes perfect sense, Paul felt that we might use a
> 'better' name for the kernel use, ctrl_dep_if() was proposed.
> 
> Let us pain bike sheds :-)

I have felt that pain many times...  ;-)

Here is what I see thus far from these two threads:

1.	volatile_if() as above.  Nice ease of use, but might be suboptimal
	on architectures where a branch is slower than an acquire load.

2.	#1, but with my preferred name of ctrl_dep_if() instead of
	volatile_if().

3.	READ_ONCE_CTRL() like back in the old days.  This has the
	advantage of giving the compiler more information, but has
	problems with relaxed atomic RMW operations.

4.	A full (fool?) solution based on #3 would also include _ctrl
	suffixed atomic RMW operations.

5.	Your bikeshed color here!

							Thanx, Paul
