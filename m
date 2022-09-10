Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0BD5B472E
	for <lists+linux-arch@lfdr.de>; Sat, 10 Sep 2022 17:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiIJPDe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Sep 2022 11:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiIJPDc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2022 11:03:32 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7EFCC46617
        for <linux-arch@vger.kernel.org>; Sat, 10 Sep 2022 08:03:31 -0700 (PDT)
Received: (qmail 520554 invoked by uid 1000); 10 Sep 2022 11:03:30 -0400
Date:   Sat, 10 Sep 2022 11:03:30 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hernan Luis Ponce de Leon <hernanl.leon@huawei.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <YxynQmEL6e194Wuw@rowland.harvard.edu>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
 <YwpAzTwSRCK5kdLN@rowland.harvard.edu>
 <YwpJ4ZPVbuCnnFKS@boqun-archlinux>
 <674d0fda790d4650899e2fcf43894053@huawei.com>
 <b7e32a603fdc4883b87c733f5681c6d9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e32a603fdc4883b87c733f5681c6d9@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 10, 2022 at 12:11:36PM +0000, Hernan Luis Ponce de Leon wrote:
> 
> What they mean seems to be that a prop relation followed only by wmb 
> (not mb) doesn't enforce the order of some writes to the same 
> location, leading to the claimed hang in qspinlock (at least as far as 
> LKMM is concerned).

You were quoting Jonas here, right?  The email doesn't make this obvious 
because it doesn't have two levels of "> > " markings.

> What we mean is that wmb does not give the same propagation properties as mb.

In general, _no_ two distinct relations in the LKMM have the same 
propagation properties.  If wmb always behaved the same way as mb, we 
wouldn't use two separate words for them.

> The claim is based on these relations from the memory model
> 
> let strong-fence = mb | gp
> ...
> let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
> 	po-unlock-lock-po) ; [Marked]
> let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
> 	[Marked] ; rfe? ; [Marked]

Please be more specific.  What difference between mb and wmb are you 
concerned about?  Can you give a small litmus test that illustrates this 
difference?  Can you explain in more detail how this difference affects 
the qspinlock implementation?

> From an engineering perspective, I think the only issue is that cat 
> *currently* does not have any syntax for this,

Syntax for what?  The difference between wmb and mb?

>  nor does herd currently 
> implement the await model checking techniques proposed in those works 
> (c.f. Theorem 5.3. in the "making weak memory models fair" paper, 
> which says that for this kind of loop, iff the mo-maximal reads in 
> some graph are read in a loop iteration that does not exit the loop, 
> the loop can run forever). However GenMC and I believe also Dat3M and 
> recently also Nidhugg support such techniques. It may not even be too 
> much effort to implement something like this in herd if desired.

I believe that herd has no way to express the idea of a program running 
forever.  On the other hand, it's certainly true (in all of these 
models) than for any finite number N, there is a feasible execution in 
which a loop runs for more than N iterations before the termination 
condition eventually becomes true.

Alan

> The Dartagnan model checker uses the Theorem 5.3 from above to detect 
> liveness violations.
> 
> We did not try to come up with a litmus test about the behavior 
> because herd7 cannot reason about liveness.
> However, if anybody is interested, the violating execution is shown here
> 	https://github.com/huawei-drc/cna-verification/blob/master/verification-output/BUG1.png
> 
> Hernan
