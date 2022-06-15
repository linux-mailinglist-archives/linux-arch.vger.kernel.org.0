Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9FF54CB04
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 16:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbiFOOQX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 10:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiFOOQU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 10:16:20 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7DFDD37AAF
        for <linux-arch@vger.kernel.org>; Wed, 15 Jun 2022 07:16:19 -0700 (PDT)
Received: (qmail 674306 invoked by uid 1000); 15 Jun 2022 10:16:18 -0400
Date:   Wed, 15 Jun 2022 10:16:18 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
Cc:     llvm@lists.linux.dev, linux-toolchains@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH RFC] tools/memory-model: Adjust ctrl dependency definition
Message-ID: <YqnpshlsAHg7Uf9G@rowland.harvard.edu>
References: <20220615114330.2573952-1-paul.heidekrueger@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615114330.2573952-1-paul.heidekrueger@in.tum.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 15, 2022 at 11:43:29AM +0000, Paul Heidekrüger wrote:
> Hi all,
> 
> I have been confused by explanation.txt's definition of control
> dependencies:
> 
> > Finally, a read event and another memory access event are linked by a
> > control dependency if the value obtained by the read affects whether
> > the second event is executed at all.
> 
> I'll go into the following:
> 
> ====
> 1. "At all", to me, is misleading
>   1.1 The code which confused me
>   1.2 The traditional definition via post-dominance doesn't work either
> 2. Solution
> ====
> 
> 1. "At all", to me, is misleading:
> 
> "At all" to me suggests a question for which we require a definitive
> "yes" or "no" answer: given a programme and an input, can a certain
> piece of code be executed? Can we always answer this this question?
> Doesn't this sound similar to the halting problem?

No.  You're not thinking about this the right way.

The point of view we take in this document and in the LKMM is not like 
the view in a static analysis of a program.  It is a dynamic analysis of 
one particular execution of a program.  The halting problem does not 
apply.  Note for instance that explanation.txt talks about "events" 
rather than instructions or pieces of code.

(The single-execution-at-a-time point of view has its own limitations, 
which do have some adverse affects on the LKMM.  But we don't want to 
exceed the capabilities of the herd7 tool.)

> 1.1 The Example which confused me:
> 
> For the dependency checker project [1], I've been thinking about
> tracking dependency chains in code, and I stumbled upon the following
> edge case, which made me question the "at all" part of the current
> definition. The below C-code is derived from some optimised kernel code
> in LLVM intermediate representation (IR) I encountered:
> 
> > int *x, *y;
> >
> > int foo()
> > {
> > /* More code */
> >
> > 	 loop:
> > 		/* More code */
> >
> > 	 	if(READ_ONCE(x)) {
> > 	 		WRITE_ONCE(y, 42);
> > 	 		return 0;
> > 	 	}
> >
> > 		/* More code */
> >
> > 	 	goto loop;
> >
> >       /* More code */
> > }
> 
> Assuming that foo() will return, the READ_ONCE() does not determine
> whether the WRITE_ONCE() will be executed __at all__, as it will be
> executed exactly when the function returns, instead, it determines
> __when__ the WRITE_ONCE() will be executed.

But what if your assumption is wrong?

In any case, your question displays an incorrect viewpoint.  For 
instance, the READ_ONCE() does not count as a single event.  Rather, 
each iteration through the loop executes a separate instance of the 
READ_ONCE(), and each instance counts as its own event.  Think of events 
not as static entities in the program source but instead as the items in 
the queue that gets fed into the CPU's execution unit at run time.

Strictly speaking, one could say there is a control dependency from each 
of these READ_ONCE() events to the final WRITE_ONCE().  However the LKMM 
takes a more limited viewpoint, saying that a dependency from a load to 
the controlling expression of an "if" statement only affects the 
execution of the events corresponding to statements lying statically in 
the two arms of the "if".  In your example the "if" has a single arm, 
and so only the access in that arm is considered to have a control 
dependency from the preceding instance of the READ_ONCE().  And it 
doesn't have a control dependency from any of the earlier iterations of 
the READ_ONCE(), because it doesn't lie in any of the arms of the 
earlier iterations of the "if".

> 1.2. The definition via post-dominance doesn't work either:
> 
> I have seen control dependencies being defined in terms of the first
> basic block that post-dominates the basic block of the if-condition,
> that is the first basic block control flow must take to reach the
> function return regardless of what the if condition returned.
> 
> E.g. [2] defines control dependencies as follows:
> 
> > A statement y is said to be control dependent on another statement x
> > if (1) there exists a nontrivial path from x to y such that every
> > statement z != x in the path is post-dominated by y, and (2) x is not
> > post-dominated by y.
> 
> Again, this definition doesn't work for the example above. As the basic
> block of the if branch trivially post-dominates any other basic block,
> because it contains the function return.

Again, not applicable as basic blocks, multiple paths, and so on belong 
to static analysis.

> 2. Solution:
> 
> The definition I came up with instead is the following:
> 
> > A basic block B is control-dependent on a basic block A if
> > B is reachable from A, but control flow can take a path through A
> > which avoids B. The scope of a control dependency ends at the first
> > basic block where all control flow paths running through A meet.
> 
> Note that this allows control dependencies to remain "unresolved".
> 
> I'm happy to submit a patch which covers more of what I mentioned above
> as part of explanation.txt, but figured that in the spirit of keeping
> things simple, leaving out "at all" might be enough?
> 
> What do you think?

Not so good.  A better description would be that there is a control 
dependency from a read event X to a memory access event Y if there is a 
dependency (data or address) from X to the conditional branch event of 
an "if" statement which contains Y in one of its arms.  And similarly 
for "switch" statements.

Alan

> Many thanks,
> Paul
> 
> [1]: https://lore.kernel.org/all/Yk7%2FT8BJITwz+Og1@Pauls-MacBook-Pro.local/T/#u
> [2]: Optimizing Compilers for Modern Architectures: A Dependence-Based
> Approach, Randy Allen, Ken Kennedy, 2002, p. 350
> 
> Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> Cc: Marco Elver <elver@google.com>
> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
> Cc: Martin Fink <martin.fink@in.tum.de>
> ---
>  tools/memory-model/Documentation/explanation.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index ee819a402b69..42af7ed91313 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -466,7 +466,7 @@ pointer.
>  
>  Finally, a read event and another memory access event are linked by a
>  control dependency if the value obtained by the read affects whether
> -the second event is executed at all.  Simple example:
> +the second event is executed.  Simple example:
>  
>  	int x, y;
>  
> -- 
> 2.35.1
> 
