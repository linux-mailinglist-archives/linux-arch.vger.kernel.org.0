Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBDC5A2D1C
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 19:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiHZRKn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 13:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiHZRKm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 13:10:42 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C89AD8A7EF
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 10:10:40 -0700 (PDT)
Received: (qmail 44494 invoked by uid 1000); 26 Aug 2022 13:10:39 -0400
Date:   Fri, 26 Aug 2022 13:10:39 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 06:23:24PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 26, 2022 at 05:48:12AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > I have not yet done more than glance at this one, but figured I should
> > send it along sooner rather than later.
> > 
> > "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
> > Memory Models", Antonio Paolillo, Hernán Ponce-de-León, Thomas
> > Haas, Diogo Behrens, Rafael Chehab, Ming Fu, and Roland Meyer.
> > https://arxiv.org/abs/2111.15240
> > 
> > The claim is that the queued spinlocks implementation with CNA violates
> > LKMM but actually works on all architectures having a formal hardware
> > memory model.
> > 
> > Thoughts?
> 
> So the paper mentions the following defects:
> 
>  - LKMM doesn't carry a release-acquire chain across a relaxed op

That's right, although I'm not so sure this should be considered a 
defect...

>  - some babbling about a missing propagation -- ISTR Linux if stuffed
>    full of them, specifically we require stores to auto propagate
>    without help from barriers

Not a missing propagation; a late one.

Don't understand what you mean by "auto propagate without help from 
barriers".

>  - some handoff that is CNA specific and I've not looked too hard at
>    presently.
> 
> 
> I think we should address that first one in LKMM, it seems very weird to
> me a RmW would break the chain like that.

An explicitly relaxed RMW (atomic_cmpxchg_relaxed(), to be precise).

If the authors wanted to keep the release-acquire chain intact, why not 
use a cmpxchg version that has release semantics instead of going out of 
their way to use a relaxed version?

To put it another way, RMW accesses and release-acquire accesses are 
unrelated concepts.  You can have one without the other (in principle, 
anyway).  So a relaxed RMW is just as capable of breaking a 
release-acquire chain as any other relaxed operation is.

>  Is there actual hardware that
> doesn't behave?

Not as far as I know, although that isn't very far.  Certainly an 
other-multicopy-atomic architecture would make the litmus test succeed.  
But the LKMM does not require other-multicopy-atomicity.

Alan
