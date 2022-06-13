Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FA5549C1E
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 20:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiFMStB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 14:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345595AbiFMSsc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 14:48:32 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A87926B64F
        for <linux-arch@vger.kernel.org>; Mon, 13 Jun 2022 08:46:37 -0700 (PDT)
Received: (qmail 603976 invoked by uid 1000); 13 Jun 2022 11:46:36 -0400
Date:   Mon, 13 Jun 2022 11:46:36 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH] tools/memory-model: Clarify LKMM's limitations in
 litmus-tests.txt
Message-ID: <Yqdb3CZ8bKtbWZ+z@rowland.harvard.edu>
References: <20220613122744.373516-1-paul.heidekrueger@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613122744.373516-1-paul.heidekrueger@in.tum.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 13, 2022 at 12:27:44PM +0000, Paul Heidekrüger wrote:
> As discussed, clarify LKMM not recognizing certain kinds of orderings.
> In particular, highlight the fact that LKMM might deliberately make
> weaker guarantees than compilers and architectures.
> 
> Link: https://lore.kernel.org/all/YpoW1deb%2FQeeszO1@ethstick13.dse.in.tum.de/T/#u
> Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> Cc: Marco Elver <elver@google.com>
> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
> Cc: Martin Fink <martin.fink@in.tum.de>
> ---
>  .../Documentation/litmus-tests.txt            | 29 ++++++++++++-------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
> index 8a9d5d2787f9..623059eff84e 100644
> --- a/tools/memory-model/Documentation/litmus-tests.txt
> +++ b/tools/memory-model/Documentation/litmus-tests.txt
> @@ -946,22 +946,31 @@ Limitations of the Linux-kernel memory model (LKMM) include:
>  	carrying a dependency, then the compiler can break that dependency
>  	by substituting a constant of that value.
>  
> -	Conversely, LKMM sometimes doesn't recognize that a particular
> -	optimization is not allowed, and as a result, thinks that a
> -	dependency is not present (because the optimization would break it).
> -	The memory model misses some pretty obvious control dependencies
> -	because of this limitation.  A simple example is:
> +	Conversely, LKMM will sometimes overstate the amount of reordering
> +	done by architectures and compilers, leading it to missing some
> +	pretty obvious orderings.  A simple example is:

I don't like the word "overstate" here.  How about instead:

	LKMM will sometimes overestimate the amount of reordering
	CPUs and compilers can carry out, leading it to miss some
	pretty obvious cases of ordering.

>  
>  		r1 = READ_ONCE(x);
>  		if (r1 == 0)
>  			smp_mb();
>  		WRITE_ONCE(y, 1);
>  
> -	There is a control dependency from the READ_ONCE to the WRITE_ONCE,
> -	even when r1 is nonzero, but LKMM doesn't realize this and thinks
> -	that the write may execute before the read if r1 != 0.  (Yes, that
> -	doesn't make sense if you think about it, but the memory model's
> -	intelligence is limited.)
> +	There is no dependency from the WRITE_ONCE() to the READ_ONCE(),

You mean "from the READ_ONCE() to the WRITE_ONCE()".

> +	and as a result, LKMM does not assume ordering.  However, the

... does not claim that the load is ordered before the store.

> +	smp_mb() in the if branch will prevent architectures from
> +	reordering the WRITE_ONCE() ahead of the READ_ONCE() but only if r1

Architectures don't do reordering; CPUs do.  In any case this sentence 
is wrong; the presence of the "if" statement is what prevents the 
reordering.  CPUs will never reorder a store before a conditional 
branch, even if the store gets executed on both branches of the 
conditional.

By contrast, the smp_mb() in one of the branches prevents _compilers_ 
from moving the store before the conditional.

> +	is 0.  This, by definition, is not a control dependency, yet
> +	ordering is guaranteed in some cases, depending on the READ_ONCE(),
> +	which LKMM doesn't recognize.

Say instead:

	However, even though no dependency is present, the WRITE_ONCE() 
	will not be executed before the READ_ONCE().  There are two
	reasons for this:

		The presence of the smp_mb() in one of the branches
		prevents the compiler from moving the WRITE_ONCE()
		up before the "if" statement, since the compiler has
		to assume that r1 will sometimes be 0 (but see the
		comment below);

		CPUs do not execute stores before po-earlier conditional
		branches, even in cases where the store occurs after the
		two arms of the branch have recombined.

> +
> +	It is clear that it is not dangerous in the slightest for LKMM to
> +	make weaker guarantees than architectures.  In fact, it is
> +	desirable, as it gives compilers room for making optimizations.
> +	For instance, because a value of 0 triggers undefined behavior

"because a value of 0 triggers undefined behavior" implies that 
undefined behavior will always occur.  Instead say:

	For instance, suppose that a 0 value in r1 would trigger
	undefined behavior later on.  Then a clever compiler...

> +	elsewhere, a clever compiler might deduce that r1 can never be 0 in
> +	the if condition.  As a result, said clever compiler might deem it
> +	safe to optimize away the smp_mb(), eliminating the branch and
> +	any ordering an architecture would guarantee otherwise.

Alan

>  
>  2.	Multiple access sizes for a single variable are not supported,
>  	and neither are misaligned or partially overlapping accesses.
> -- 
> 2.35.1
> 
