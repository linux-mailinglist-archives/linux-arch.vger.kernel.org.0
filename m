Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BF339C2A2
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 23:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhFDVmC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 17:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhFDVl5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 17:41:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E20496138C;
        Fri,  4 Jun 2021 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622842810;
        bh=Ko37cBvfHIxoEbRgsUYYOd/Sa/dGad/pOy7jAZuLOkI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LNT+UDFcrcsyocROBLUl4fi/GeIpJpw3QrtiF6WhseAuieUGHUI4ixigD9YoiTDvD
         dn3CIvxeWAR/sVeTCYIADQ6Le4UubSSO3uJqPeUY4y0g6IH3ZHr6GwG+SUvuDv0GQs
         yFy5zbBdVxZSLjzmibi+uc8tCuTxpMLyUVv8N2whixEoojjf+b6z+RtYsUlyBYPBDR
         7v7jhN1Auz3V3mPuuu1srkozxiMXs+0jMS0fbSJR5/EYqirKkpJy0z0vPIHrbvcttx
         2oLoTUP4TsXK9g95C3htAkt5wb8IFjSOMDZXhsluzrM5uqNmznIHXhNf7zGFXqMJw/
         KNYHPh6gRJnWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B363A5C02AB; Fri,  4 Jun 2021 14:40:10 -0700 (PDT)
Date:   Fri, 4 Jun 2021 14:40:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210604151356.GC2793@willie-the-truck>
 <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
 <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net>
 <20210604155154.GG1676809@rowland.harvard.edu>
 <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net>
 <20210604182708.GB1688170@rowland.harvard.edu>
 <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 02:27:49PM -0700, Linus Torvalds wrote:
> On Fri, Jun 4, 2021 at 1:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > The usual way to prevent it is to use WRITE_ONCE().
> 
> The very *documentation example* for "volatile_if()" uses that WRITE_ONCE().

Whew!  ;-)

> IOW, the patch that started this discussion has this comment in it:
> 
> +/**
> + * volatile_if() - Provide a control-dependency
> + *
> + * volatile_if(READ_ONCE(A))
> + *     WRITE_ONCE(B, 1);
> + *
> + * will ensure that the STORE to B happens after the LOAD of A.
> 
> and my point is that I don't see *ANY THEORETICALLY POSSIBLE* way that
> that "volatile_if()" could not be just a perfectly regular "if ()".
> 
> Can you?

I cannot, maybe due to failure of imagination.  But please see below.

> Because we *literally* depend on the fundamental concept of causality
> to make the hardware not re-order those operations.
> 
> That is the WHOLE AND ONLY point of this whole construct: we're
> avoiding a possibly expensive hardware barrier operation, because we
> know we have a more fundamental barrier that is INHERENT TO THE
> OPERATION.
> 
> And I cannot for the life of me see how a compiler can break that
> fundamental concept of causality either.
> 
> Seriously. Tell me how a compiler could _possibly_ turn that into
> something that breaks the fundamental causal relationship. The same
> fundamental causal relationship that is the whole and only reason we
> don't need a memory barrier for the hardware.
> 
> And no, there is not a way in hell that the above can be written with
> some kind of semantically visible speculative store without the
> compiler being a total pile of garbage that wouldn't be usable for
> compiling a kernel with.
> 
> If your argument is that the compiler can magically insert speculative
> stores that can then be overwritten later, then MY argument is that
> such a compiler could do that for *ANYTHING*. "volatile_if()" wouldn't
> save us.
> 
> If that's valid compiler behavior in your opinion, then we have
> exactly two options:
> 
>  (a) give up
> 
>  (b) not use that broken garbage of a compiler.
> 
> So I can certainly accept the patch with the simpler implementation of
> "volatile_if()", but dammit, I want to see an actual real example
> arguing for why it would be relevant and why the compiler would need
> our help.
> 
> Because the EXACT VERY EXAMPLE that was in the patch as-is sure as
> hell is no such thing.
> 
> If the intent is to *document* that "this conditional is part of a
> load-conditional-store memory ordering pattern, then that is one
> thing. But if that's the intent, then we might as well just write it
> as
> 
>     #define volatile_if(x) if (x)
> 
> and add a *comment* about why this kind of sequence doesn't need a
> memory barrier.
> 
> I'd much rather have that kind of documentation, than have barriers
> that are magical for theoretical compiler issues that aren't real, and
> don't have any grounding in reality.
> 
> Without a real and valid example of how this could matter, this is
> just voodoo programming.
> 
> We don't actually need to walk three times widdershins around the
> computer before compiling the kernel.That's not how kernel development
> works.
> 
> And we don't need to add a "volatile_if()" with magical barriers that
> have no possibility of having real semantic meaning.
> 
> So I want to know what the semantic meaning of volatile_if() would be,
> and why it fixes anything that a plain "if()" wouldn't. I want to see
> the sequence where that "volatile_if()" actually *fixes* something.

Here is one use case:

	volatile_if(READ_ONCE(A)) {
		WRITE_ONCE(B, 1);
		do_something();
	} else {
		WRITE_ONCE(B, 1);
		do_something_else();
	}

With plain "if", the compiler is within its rights to do this:

	tmp = READ_ONCE(A);
	WRITE_ONCE(B, 1);
	if (tmp)
		do_something();
	else
		do_something_else();

On x86, still no problem.  But weaker hardware could now reorder the
store to B before the load from A.  With volatile_if(), this reordering
would be prevented.

							Thanx, Paul
