Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007D857085B
	for <lists+linux-arch@lfdr.de>; Mon, 11 Jul 2022 18:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiGKQaS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jul 2022 12:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiGKQaQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jul 2022 12:30:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BC311C09;
        Mon, 11 Jul 2022 09:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35AAFB8105D;
        Mon, 11 Jul 2022 16:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B8DC34115;
        Mon, 11 Jul 2022 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657557011;
        bh=mvqPbuaTIeF07jDnNksf18FEDwVUT+8krl/Dwsc6qno=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sW4BxRBTLmwTu7pEMQct6C84C9TbhXs+7hJQQIh/SBV8ml9HL8ngYkDl842xy671o
         cNstVweeRHTuUPPJL/2PXsbAr8d3TXWeBJQmkGrP1vS+InJilS7jK9HCo0bSaEuQTD
         0HQHaa5RKQBq9BL6+yzMsFqvPEvMkj18aZf7tjq7OL+fzhF9qyVU7+ZOfdstXom6JM
         FPOSpk+KmezzAmH0MksG8opnbea9yOLH29jIVy/ygiWftyhP9fiwlqbsQ+KtiqU5z9
         e/zbzBSNaFMfjOu+94vfFrtZJfMOVuyKJp+FlQkeeMBui3jggDiGKF9kpXTTAOzY1B
         cfUpNlnkxl+wA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 78BFF5C03B9; Mon, 11 Jul 2022 09:30:11 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:30:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <Paul.Heidekrueger@in.tum.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH v2] tools/memory-model: Clarify LKMM's limitations in
 litmus-tests.txt
Message-ID: <20220711163011.GN1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yqdb3CZ8bKtbWZ+z@rowland.harvard.edu>
 <20220614154812.1870099-1-paul.heidekrueger@in.tum.de>
 <CANpmjNOkXz=+221i70CWJexQWwfA_By3+7Cnimwgjmwn7RQdBg@mail.gmail.com>
 <YshC8sJ4dZq3m2wy@rowland.harvard.edu>
 <20220708184749.GW1790663@paulmck-ThinkPad-P17-Gen-1>
 <EE1854E3-C33D-4A4E-AC31-4194A701052B@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EE1854E3-C33D-4A4E-AC31-4194A701052B@in.tum.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 11, 2022 at 05:14:55PM +0200, Paul Heidekrüger wrote:
> > On 8. Jul 2022, at 20:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > On Fri, Jul 08, 2022 at 10:45:06AM -0400, Alan Stern wrote:
> >> On Fri, Jul 08, 2022 at 01:44:06PM +0200, Marco Elver wrote:
> >>> On Tue, 14 Jun 2022 at 17:49, Paul Heidekrüger
> >>> <paul.heidekrueger@in.tum.de> wrote:
> >>>> As discussed, clarify LKMM not recognizing certain kinds of orderings.
> >>>> In particular, highlight the fact that LKMM might deliberately make
> >>>> weaker guarantees than compilers and architectures.
> >>>> 
> >>>> Link: https://lore.kernel.org/all/YpoW1deb%2FQeeszO1@ethstick13.dse.in.tum.de/T/#u
> >>>> Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> >>>> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> >>> 
> >>> Reviewed-by: Marco Elver <elver@google.com>
> >>> 
> >>> However with the Co-developed-by, this is missing Alan's SOB.
> >> 
> >> For the record:
> >> 
> >> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> >> 
> >> (Note that according to Documentation/process/submitting-patches.rst, 
> >> the submitting author's SOB is supposed to come last.)
> > 
> > And this is what I ended up with. Please provide additional feedback
> > as needed, and in the meantime, thank you all!
> > 
> > 							Thanx, Paul
> 
> Looks great - my first commit in the Linux kernel!

Congratulations!!!  ;-)

My commits for the upcoming merge window, which is probably 2-3 weeks
from now, are already set.  So this is targeted at the merge window
after that, which is likely to be in late September or early October.

So it is well on its way!

							Thanx, Paul

> Thanks everyone!
> 
> Paul
> 
> > ------------------------------------------------------------------------
> > 
> > commit 3c7753e959706f39e1ee183ef8dcde3b4cfbb4c7
> > Author: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> > Date: Tue Jun 14 15:48:11 2022 +0000
> > 
> > tools/memory-model: Clarify LKMM's limitations in litmus-tests.txt
> > 
> > As discussed, clarify LKMM not recognizing certain kinds of orderings.
> > In particular, highlight the fact that LKMM might deliberately make
> > weaker guarantees than compilers and architectures.
> > 
> > Link: https://lore.kernel.org/all/YpoW1deb%2FQeeszO1@ethstick13.dse.in.tum.de/T/#u
> > Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> > Reviewed-by: Marco Elver <elver@google.com>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
> > Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
> > Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
> > Cc: Martin Fink <martin.fink@in.tum.de>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
> > index 8a9d5d2787f9e..cc355999815cb 100644
> > --- a/tools/memory-model/Documentation/litmus-tests.txt
> > +++ b/tools/memory-model/Documentation/litmus-tests.txt
> > @@ -946,22 +946,39 @@ Limitations of the Linux-kernel memory model (LKMM) include:
> > 	carrying a dependency, then the compiler can break that dependency
> > 	by substituting a constant of that value.
> > 
> > -	Conversely, LKMM sometimes doesn't recognize that a particular
> > -	optimization is not allowed, and as a result, thinks that a
> > -	dependency is not present (because the optimization would break it).
> > -	The memory model misses some pretty obvious control dependencies
> > -	because of this limitation. A simple example is:
> > +	Conversely, LKMM will sometimes overestimate the amount of
> > +	reordering compilers and CPUs can carry out, leading it to miss
> > +	some pretty obvious cases of ordering. A simple example is:
> > 
> > 		r1 = READ_ONCE(x);
> > 		if (r1 == 0)
> > 			smp_mb();
> > 		WRITE_ONCE(y, 1);
> > 
> > -	There is a control dependency from the READ_ONCE to the WRITE_ONCE,
> > -	even when r1 is nonzero, but LKMM doesn't realize this and thinks
> > -	that the write may execute before the read if r1 != 0. (Yes, that
> > -	doesn't make sense if you think about it, but the memory model's
> > -	intelligence is limited.)
> > +	The WRITE_ONCE() does not depend on the READ_ONCE(), and as a
> > +	result, LKMM does not claim ordering. However, even though no
> > +	dependency is present, the WRITE_ONCE() will not be executed before
> > +	the READ_ONCE(). There are two reasons for this:
> > +
> > + The presence of the smp_mb() in one of the branches
> > + prevents the compiler from moving the WRITE_ONCE()
> > + up before the "if" statement, since the compiler has
> > + to assume that r1 will sometimes be 0 (but see the
> > + comment below);
> > +
> > + CPUs do not execute stores before po-earlier conditional
> > + branches, even in cases where the store occurs after the
> > + two arms of the branch have recombined.
> > +
> > +	It is clear that it is not dangerous in the slightest for LKMM to
> > +	make weaker guarantees than architectures. In fact, it is
> > +	desirable, as it gives compilers room for making optimizations. 
> > +	For instance, suppose that a 0 value in r1 would trigger undefined
> > +	behavior elsewhere. Then a clever compiler might deduce that r1
> > +	can never be 0 in the if condition. As a result, said clever
> > +	compiler might deem it safe to optimize away the smp_mb(),
> > +	eliminating the branch and any ordering an architecture would
> > +	guarantee otherwise.
> > 
> > 2.	Multiple access sizes for a single variable are not supported,
> > 	and neither are misaligned or partially overlapping accesses.
