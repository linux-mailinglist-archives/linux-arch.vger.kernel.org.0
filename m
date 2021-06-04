Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD539BA1D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhFDNqO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 09:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhFDNqO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 09:46:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD209613FA;
        Fri,  4 Jun 2021 13:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622814268;
        bh=Gk6qNsvg6fwttfoHR12fN0bBTyiEuNabgU3OOgIVeUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jkGBGVr8y0oUbAJarTCBCAiqB+t2wubxe4yuw1MACCD2jkT+SKm0ZS1ZDxRElnNEY
         Mwxqn78c/9uMSzN6zRJzpQUAFDzAjB3WDIrNTRGcCl786bWhgzBk9sqLNZuGyvZefI
         1a1GrlEDj1mv0DhA2Lz3E3p2Hqs2kGuV4VpwkvC47E3IO7kKB6Mbj/koNpFCUgNG4l
         txXs2OpK2l7BjmqqXkoDV0vdbpCNg2bHVakj1b2EfOZvABAPJaQ/BC1ASVYXhjzZXs
         kuhKz204Ph5SdSMMfVVAi7snBA62V59lQP7H0PIGEuw41fK743z3qVSWEUx60u+LVP
         M4vB3yn7k2yHA==
Date:   Fri, 4 Jun 2021 14:44:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604134422.GA2793@willie-the-truck>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604104359.GE2318@willie-the-truck>
 <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 01:31:48PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 11:44:00AM +0100, Will Deacon wrote:
> > On Fri, Jun 04, 2021 at 12:12:07PM +0200, Peter Zijlstra wrote:
> 
> > > Usage of volatile_if requires the @cond to be headed by a volatile load
> > > (READ_ONCE() / atomic_read() etc..) such that the compiler is forced to
> > > emit the load and the branch emitted will have the required
> > > data-dependency. Furthermore, volatile_if() is a compiler barrier, which
> > > should prohibit the compiler from lifting anything out of the selection
> > > statement.
> > 
> > When building with LTO on arm64, we already upgrade READ_ONCE() to an RCpc
> > acquire. In this case, it would be really good to avoid having the dummy
> > conditional branch somehow, but I can't see a good way to achieve that.
> 
> #ifdef CONFIG_LTO
> /* Because __READ_ONCE() is load-acquire */
> #define volatile_cond(cond)	(cond)
> #else
> ....
> #endif
> 
> Doesn't work? Bit naf, but I'm thinking it ought to do.

The problem is with relaxed atomic RMWs; we don't upgrade those to acquire
atm as they're written in asm, but we'd need volatile_cond() to work with
them. It's a shame, because we only have RCsc RMWs on arm64, so it would
be a bit more expensive.

> > > +/**
> > > + * volatile_if() - Provide a control-dependency
> > > + *
> > > + * volatile_if(READ_ONCE(A))
> > > + *	WRITE_ONCE(B, 1);
> > > + *
> > > + * will ensure that the STORE to B happens after the LOAD of A. Normally a
> > > + * control dependency relies on a conditional branch having a data dependency
> > > + * on the LOAD and an architecture's inability to speculate STOREs. IOW, this
> > > + * provides a LOAD->STORE order.
> > > + *
> > > + * Due to optimizing compilers extra care is needed; as per the example above
> > > + * the LOAD must be 'volatile' qualified in order to ensure the compiler
> > > + * actually emits the load, such that the data-dependency to the conditional
> > > + * branch can be formed.
> > > + *
> > > + * Secondly, the compiler must be prohibited from lifting anything out of the
> > > + * selection statement, as this would obviously also break the ordering.
> > > + *
> > > + * Thirdly, and this is the tricky bit, architectures that allow the
> > > + * LOAD->STORE reorder must ensure the compiler actually emits the conditional
> > > + * branch instruction, this isn't possible in generic.
> > > + *
> > > + * See the volatile_cond() wrapper.
> > > + */
> > > +#define volatile_if(cond) if (volatile_cond(cond))
> > 
> > The thing I really dislike about this is that, if the compiler _does_
> > emit a conditional branch for the C 'if', then we get a pair of branch
> > instructions in close proximity to each other which the predictor is likely
> > to hate. I wouldn't be surprised if an RCpc acquire heading the dependency
> > actually performs better on modern arm64 cores in the general case.
> 
> jump_label / static_branch relies on asm goto inside if to get optimized
> away, so I'm fairly confident this will not result in a double branch,
> because yes, that would blow.

I gave it a spin and you're right. Neat!

Will
