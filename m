Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF055346E
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351403AbiFUOYU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 10:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351375AbiFUOYT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 10:24:19 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D1E8D18E08
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2022 07:24:18 -0700 (PDT)
Received: (qmail 876587 invoked by uid 1000); 21 Jun 2022 10:24:17 -0400
Date:   Tue, 21 Jun 2022 10:24:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <Paul.Heidekrueger@in.tum.de>
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
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH RFC] tools/memory-model: Adjust ctrl dependency definition
Message-ID: <YrHUkfDWsexHRUKj@rowland.harvard.edu>
References: <20220615114330.2573952-1-paul.heidekrueger@in.tum.de>
 <YqnpshlsAHg7Uf9G@rowland.harvard.edu>
 <50B9D7C1-B11D-4583-9814-BFFF2C80D8CA@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50B9D7C1-B11D-4583-9814-BFFF2C80D8CA@in.tum.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 21, 2022 at 01:59:27PM +0200, Paul Heidekrüger wrote:
> OK. So, LKMM limits the scope of control dependencies to its arm(s), hence
> there is a control dependency from the last READ_ONCE() before the loop
> exists to the WRITE_ONCE().
> 
> But then what about the following:
> 
> > int *x, *y;
> > 
> > int foo()
> > {
> > 	/* More code */
> > 
> > 	if(READ_ONCE(x))
> > 		return 42;
> > 
> > 	/* More code */
> > 
> > 	WRITE_ONCE(y, 42);
> > 
> > 	/* More code */
> > 
> > 	return 0;
> > }
> 
> The READ_ONCE() determines whether the WRITE_ONCE() will be executed at all,
> but the WRITE_ONCE() doesn't lie in the if condition's arm.

So in this case the LKMM would not recognize that there's a control 
dependency, even though it clearly exists.

>   However, by
> "inverting" the if, we get the following equivalent code:
> 
> > if(!READ_ONCE(x)) {
> > 	/* More code */
> > 
> > 	WRITE_ONCE(y, 42);
> > 
> > 	/* More code */
> > 
> > 	return 0;
> > }
> > 
> > return 42;
> 
> Now, the WRITE_ONCE() is in the if's arm, and there is clearly a control
> dependency.

Correct.

> Similar cases:
> 
> > if(READ_ONCE())
> > 	foo(); /* WRITE_ONCE() in foo() */
> > return 42;
> 
> or
> 
> > if(READ_ONCE())
> >     goto foo; /* WRITE_ONCE() after foo */
> > return 42;
> 
> In both cases, the WRITE_ONCE() again isn't in the if's arm syntactically
> speaking, but again, with rewriting, you can end up with a control
> dependency; in the first case via inlining, in the second case by simply
> copying the code after the "foo" marker.

Again, correct.  The LKMM isn't always consistent, and it behaves this 
way to try to avoid presuming too much about the optimizations that 
compilers may apply.

Alan
