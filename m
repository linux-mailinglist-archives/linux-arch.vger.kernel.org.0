Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB395A3895
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiH0QAW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiH0QAT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 12:00:19 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 550C4FD2B
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 09:00:16 -0700 (PDT)
Received: (qmail 70612 invoked by uid 1000); 27 Aug 2022 12:00:15 -0400
Date:   Sat, 27 Aug 2022 12:00:15 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <Ywo/j7V2GbMKMmp3@rowland.harvard.edu>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <20220826204219.GX6159@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826204219.GX6159@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 01:42:19PM -0700, Paul E. McKenney wrote:
> On Fri, Aug 26, 2022 at 01:10:39PM -0400, Alan Stern wrote:
> > On Fri, Aug 26, 2022 at 06:23:24PM +0200, Peter Zijlstra wrote:
> > > I think we should address that first one in LKMM, it seems very weird to
> > > me a RmW would break the chain like that.
> > 
> > An explicitly relaxed RMW (atomic_cmpxchg_relaxed(), to be precise).
> > 
> > If the authors wanted to keep the release-acquire chain intact, why not 
> > use a cmpxchg version that has release semantics instead of going out of 
> > their way to use a relaxed version?
> > 
> > To put it another way, RMW accesses and release-acquire accesses are 
> > unrelated concepts.  You can have one without the other (in principle, 
> > anyway).  So a relaxed RMW is just as capable of breaking a 
> > release-acquire chain as any other relaxed operation is.
> > 
> > >  Is there actual hardware that
> > > doesn't behave?
> > 
> > Not as far as I know, although that isn't very far.  Certainly an 
> > other-multicopy-atomic architecture would make the litmus test succeed.  
> > But the LKMM does not require other-multicopy-atomicity.
> 
> My first attempt with ppcmem suggests that powerpc does -not- behave
> this way.  But that surprises me, just on general principles.  Most likely
> I blew the litmus test shown below.
> 
> Thoughts?

The litmus test looks okay.

As for your surprise, remember that PPC is B-cumulative, another 
property which the LKMM does not require.  B-cumulativity will also 
force the original litmus test to succeed.  (The situation is like ISA2 
in the infamous test6.pdf, except that y and z are separate variables in 
ISA2 but are the same here.  The RMW nature of lwarx/stwcx provides 
the necessary R-W ordering in P1.)

Alan

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> PPC MP+lwsyncs+atomic
> "LwSyncdWW Rfe LwSyncdRR Fre"
> Cycle=Rfe LwSyncdRR Fre LwSyncdWW
> {
> 0:r2=x; 0:r4=y;
> 1:r2=y; 1:r5=2;
> 2:r2=y; 2:r4=x;
> }
>  P0           | P1              | P2           ;
>  li r1,1      | lwarx r1,r0,r2  | lwz r1,0(r2) ;
>  stw r1,0(r2) | stwcx. r5,r0,r2 | lwsync       ;
>  lwsync       |                 | lwz r3,0(r4) ;
>  li r3,1      |                 |              ;
>  stw r3,0(r4) |                 |              ;
> exists (1:r1=1 /\ 2:r1=2 /\ 2:r3=0)
> 
> ------------------------------------------------------------------------
> 
> $ ./ppcmem -model lwsync_read_block -model coherence_points MP+lwsyncs+atomic.litmus
> ...
> Test MP+lwsyncs+atomic Allowed
> States 9
> 1:r1=0; 2:r1=0; 2:r3=0;
> 1:r1=0; 2:r1=0; 2:r3=1;
> 1:r1=0; 2:r1=1; 2:r3=1;
> 1:r1=0; 2:r1=2; 2:r3=0;
> 1:r1=0; 2:r1=2; 2:r3=1;
> 1:r1=1; 2:r1=0; 2:r3=0;
> 1:r1=1; 2:r1=0; 2:r3=1;
> 1:r1=1; 2:r1=1; 2:r3=1;
> 1:r1=1; 2:r1=2; 2:r3=1;
> No (allowed not found)
> Condition exists (1:r1=1 /\ 2:r1=2 /\ 2:r3=0)
> Hash=b7cec0e2ecbd1cb68fe500d6fe362f9c
> Observation MP+lwsyncs+atomic Never 0 9
