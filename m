Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8175A39B7F3
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 13:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhFDLd6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 07:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhFDLd5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 07:33:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC256C06174A;
        Fri,  4 Jun 2021 04:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Baycmb9ZKY+3yewI7Jog0p/WlMuLj8QJRTUHCrsTHPY=; b=NIAhBeJy/S1ksSYgfwipNF/chq
        zoIncitK3RhT8dXdUFe1EE/nFbbm1Na+aO2ih6y92CKrUQw2J/mXNT0zaeTwpjQiHHjHhcUK8Varz
        mxOIwMoAAmdtpjfzrA3az6qnjYQ73aC+De1AW9B8osXxwwo15fVCHlC9fmLQccxj8wx4kwH0x5NIj
        EZ1qqWTj8jvBPXhGCbOLnmroOAIExG5E3yHionIoa8P2r7bh5QgpzwV4TsSK++5kLiZwOMdV++7Ue
        ZAzSSrshUTUyvTCnW49wS8xME+Gcdp4r+7rMI4641XouI1x/P2He6BUngnxbWY8kq87O4DpvDWSiI
        tnPocvRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lp83J-00D79q-KC; Fri, 04 Jun 2021 11:31:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D280F300091;
        Fri,  4 Jun 2021 13:31:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B766E2BF0D6A9; Fri,  4 Jun 2021 13:31:48 +0200 (CEST)
Date:   Fri, 4 Jun 2021 13:31:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604104359.GE2318@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604104359.GE2318@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 11:44:00AM +0100, Will Deacon wrote:
> On Fri, Jun 04, 2021 at 12:12:07PM +0200, Peter Zijlstra wrote:

> > Usage of volatile_if requires the @cond to be headed by a volatile load
> > (READ_ONCE() / atomic_read() etc..) such that the compiler is forced to
> > emit the load and the branch emitted will have the required
> > data-dependency. Furthermore, volatile_if() is a compiler barrier, which
> > should prohibit the compiler from lifting anything out of the selection
> > statement.
> 
> When building with LTO on arm64, we already upgrade READ_ONCE() to an RCpc
> acquire. In this case, it would be really good to avoid having the dummy
> conditional branch somehow, but I can't see a good way to achieve that.

#ifdef CONFIG_LTO
/* Because __READ_ONCE() is load-acquire */
#define volatile_cond(cond)	(cond)
#else
....
#endif

Doesn't work? Bit naf, but I'm thinking it ought to do.

> > This construct should place control dependencies on a stronger footing
> > until such time that the compiler folks get around to accepting them :-)
> > 
> > I've converted most architectures we care about, and the rest will get
> > an extra smp_mb() by means of the 'generic' fallback implementation (for
> > now).
> > 
> > I've converted the control dependencies I remembered and those found
> > with a search for smp_acquire__after_ctrl_dep(), there might be more.
> > 
> > Compile tested only (alpha, arm, arm64, x86_64, powerpc, powerpc64, s390
> > and sparc64).
> > 
> > Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> > diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> > index 451e11e5fd23..2782a7013615 100644
> > --- a/arch/arm64/include/asm/barrier.h
> > +++ b/arch/arm64/include/asm/barrier.h
> > @@ -156,6 +156,17 @@ do {									\
> >  	(typeof(*p))__u.__val;						\
> >  })
> >  
> > +/* Guarantee a conditional branch that depends on @cond. */
> > +static __always_inline _Bool volatile_cond(_Bool cond)
> 
> Is _Bool to fix some awful header mess?

Yes, header soup :/ Idem for the lack of true and false.

> > +{
> > +	asm_volatile_goto("cbnz %0, %l[l_yes]"
> > +			  : : "r" (cond) : "cc", "memory" : l_yes);
> > +	return 0;
> > +l_yes:
> > +	return 1;
> > +}
> 
> nit: you don't need the "cc" clobber here.

Yeah I know, "cc" is implied.

> > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> > index 640f09479bdf..a84833f1397b 100644
> > --- a/include/asm-generic/barrier.h
> > +++ b/include/asm-generic/barrier.h
> > @@ -187,6 +187,42 @@ do {									\
> >  #define virt_store_release(p, v) __smp_store_release(p, v)
> >  #define virt_load_acquire(p) __smp_load_acquire(p)
> >  
> > +/*
> > + * 'Generic' wrapper to make volatile_if() below 'work'. Architectures are
> > + * encouraged to provide their own implementation. See x86 for TSO and arm64
> > + * for a weak example.
> > + */
> > +#ifndef volatile_cond
> > +#define volatile_cond(cond)	({ bool __t = (cond); smp_mb(); __t; })
> > +#endif
> > +
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
> The thing I really dislike about this is that, if the compiler _does_
> emit a conditional branch for the C 'if', then we get a pair of branch
> instructions in close proximity to each other which the predictor is likely
> to hate. I wouldn't be surprised if an RCpc acquire heading the dependency
> actually performs better on modern arm64 cores in the general case.

jump_label / static_branch relies on asm goto inside if to get optimized
away, so I'm fairly confident this will not result in a double branch,
because yes, that would blow.

> So I think that's an argument for doing this in the compiler...

Don't get me wrong, I would _LOVE_ for the compilers to do this. This
really is just a stop-gap solution to ensure we don't get to debug 'FUN'
stuff.

