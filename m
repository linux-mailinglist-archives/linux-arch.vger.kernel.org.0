Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCF339B749
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 12:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFDKpw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 06:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhFDKpw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 06:45:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8F546141B;
        Fri,  4 Jun 2021 10:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622803446;
        bh=kmLcjElNf8/glHDMFalVj0RYS3e6e9GqQWiMhVHRSCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYsfXNCv/6U3yuS4wbHctDnUkMoq8ufOr8zFX1ltCshzq/Ww9eRSbxM0K98wG4PGB
         VtpZrq7lKfu2t0+pPx2fAuerh5DD7VRuKrmkep/Z7pavXhf1ytV/o9JjaSjxRLbysq
         bL3FOPJlbm64ofLBboosy/yFaTRI7UIVh18glxBwcjG6kyC3JreAKhQMd/YDgUyOYM
         z2Vwbp3N9KJqS350XHdX2PeczC3QAZMQqP64ORb6OOj9+YWhPpHrh5bY1gmgbShCS5
         hzY7hoA1QJ7rs1sbOGZM9zY5GJI/k3Jqw6RCW/fAVMdmJa195i+EpP5r2PSIjexmb/
         dxDXB6LqHIUFQ==
Date:   Fri, 4 Jun 2021 11:44:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604104359.GE2318@willie-the-truck>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 12:12:07PM +0200, Peter Zijlstra wrote:
> With optimizing compilers becoming more and more agressive and C so far
> refusing to acknowledge the concept of control-dependencies even while
> we keep growing the amount of reliance on them, things will eventually
> come apart.
> 
> There have been talks with toolchain people on how to resolve this; one
> suggestion was allowing the volatile qualifier on branch statements like
> 'if', but so far no actual compiler has made any progress on this.
> 
> Rather than waiting any longer, provide our own construct based on that
> suggestion. The idea is by Alan Stern and refined by Paul and myself.
> 
> Code generation is sub-optimal (for the weak architectures) since we're
> forced to convert the condition into another and use a fixed conditional
> branch instruction, but shouldn't be too bad.
> 
> Usage of volatile_if requires the @cond to be headed by a volatile load
> (READ_ONCE() / atomic_read() etc..) such that the compiler is forced to
> emit the load and the branch emitted will have the required
> data-dependency. Furthermore, volatile_if() is a compiler barrier, which
> should prohibit the compiler from lifting anything out of the selection
> statement.

When building with LTO on arm64, we already upgrade READ_ONCE() to an RCpc
acquire. In this case, it would be really good to avoid having the dummy
conditional branch somehow, but I can't see a good way to achieve that.

> This construct should place control dependencies on a stronger footing
> until such time that the compiler folks get around to accepting them :-)
> 
> I've converted most architectures we care about, and the rest will get
> an extra smp_mb() by means of the 'generic' fallback implementation (for
> now).
> 
> I've converted the control dependencies I remembered and those found
> with a search for smp_acquire__after_ctrl_dep(), there might be more.
> 
> Compile tested only (alpha, arm, arm64, x86_64, powerpc, powerpc64, s390
> and sparc64).
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm/include/asm/barrier.h      | 11 +++++++++++
>  arch/arm64/include/asm/barrier.h    | 11 +++++++++++
>  arch/powerpc/include/asm/barrier.h  | 13 +++++++++++++
>  arch/s390/include/asm/barrier.h     |  3 +++
>  arch/sparc/include/asm/barrier_64.h |  3 +++
>  arch/x86/include/asm/barrier.h      | 16 ++++++++++++++++
>  include/asm-generic/barrier.h       | 38 ++++++++++++++++++++++++++++++++++++-
>  include/linux/refcount.h            |  2 +-
>  ipc/mqueue.c                        |  2 +-
>  ipc/msg.c                           |  2 +-
>  kernel/events/ring_buffer.c         |  8 ++++----
>  kernel/locking/rwsem.c              |  4 ++--
>  kernel/sched/core.c                 |  2 +-
>  kernel/smp.c                        |  2 +-
>  14 files changed, 105 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
> index 83ae97c049d9..de8a61479268 100644
> --- a/arch/arm/include/asm/barrier.h
> +++ b/arch/arm/include/asm/barrier.h
> @@ -97,6 +97,17 @@ static inline unsigned long array_index_mask_nospec(unsigned long idx,
>  #define array_index_mask_nospec array_index_mask_nospec
>  #endif
>  
> +/* Guarantee a conditional branch that depends on @cond. */
> +static __always_inline _Bool volatile_cond(_Bool cond)
> +{
> +	asm_volatile_goto("teq %0, #0; bne %l[l_yes]"
> +			  : : "r" (cond) : "cc", "memory" : l_yes);
> +	return 0;
> +l_yes:
> +	return 1;
> +}
> +#define volatile_cond volatile_cond
> +
>  #include <asm-generic/barrier.h>
>  
>  #endif /* !__ASSEMBLY__ */
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 451e11e5fd23..2782a7013615 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -156,6 +156,17 @@ do {									\
>  	(typeof(*p))__u.__val;						\
>  })
>  
> +/* Guarantee a conditional branch that depends on @cond. */
> +static __always_inline _Bool volatile_cond(_Bool cond)

Is _Bool to fix some awful header mess?

> +{
> +	asm_volatile_goto("cbnz %0, %l[l_yes]"
> +			  : : "r" (cond) : "cc", "memory" : l_yes);
> +	return 0;
> +l_yes:
> +	return 1;
> +}

nit: you don't need the "cc" clobber here.

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 640f09479bdf..a84833f1397b 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -187,6 +187,42 @@ do {									\
>  #define virt_store_release(p, v) __smp_store_release(p, v)
>  #define virt_load_acquire(p) __smp_load_acquire(p)
>  
> +/*
> + * 'Generic' wrapper to make volatile_if() below 'work'. Architectures are
> + * encouraged to provide their own implementation. See x86 for TSO and arm64
> + * for a weak example.
> + */
> +#ifndef volatile_cond
> +#define volatile_cond(cond)	({ bool __t = (cond); smp_mb(); __t; })
> +#endif
> +
> +/**
> + * volatile_if() - Provide a control-dependency
> + *
> + * volatile_if(READ_ONCE(A))
> + *	WRITE_ONCE(B, 1);
> + *
> + * will ensure that the STORE to B happens after the LOAD of A. Normally a
> + * control dependency relies on a conditional branch having a data dependency
> + * on the LOAD and an architecture's inability to speculate STOREs. IOW, this
> + * provides a LOAD->STORE order.
> + *
> + * Due to optimizing compilers extra care is needed; as per the example above
> + * the LOAD must be 'volatile' qualified in order to ensure the compiler
> + * actually emits the load, such that the data-dependency to the conditional
> + * branch can be formed.
> + *
> + * Secondly, the compiler must be prohibited from lifting anything out of the
> + * selection statement, as this would obviously also break the ordering.
> + *
> + * Thirdly, and this is the tricky bit, architectures that allow the
> + * LOAD->STORE reorder must ensure the compiler actually emits the conditional
> + * branch instruction, this isn't possible in generic.
> + *
> + * See the volatile_cond() wrapper.
> + */
> +#define volatile_if(cond) if (volatile_cond(cond))

The thing I really dislike about this is that, if the compiler _does_
emit a conditional branch for the C 'if', then we get a pair of branch
instructions in close proximity to each other which the predictor is likely
to hate. I wouldn't be surprised if an RCpc acquire heading the dependency
actually performs better on modern arm64 cores in the general case.

So I think that's an argument for doing this in the compiler...

Will
