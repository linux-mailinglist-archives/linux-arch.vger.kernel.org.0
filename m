Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5E15A3917
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 19:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiH0REO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 13:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiH0REO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 13:04:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F922255AC;
        Sat, 27 Aug 2022 10:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFC46B80966;
        Sat, 27 Aug 2022 17:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84600C433D6;
        Sat, 27 Aug 2022 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661619850;
        bh=ifCIA4dNWh8Q4AzrrjoDnXchHg7H4+UCS/oi7vz+Mj8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=A2AkI5um4s1GeoW+FJ+BIA4yYhOsndtFBlJhOGQNNzpVkOMtgpDh5yUQjPdd3zo2K
         dZ6reXlnM3iAa4sxqAUHqnz6K3ftoK/+Tm4v9N5OhaZXizDglY87hU2sEKnOkmctWm
         ROMs8pQ+Thxh/wXScne9SATahFytWcRdlYMWqsVdGsyNzg78m6jMYJPfk6Nzbm34LV
         YQnaDZUb7NrZzyPensUefrxvrCkuRJK9zDB2GOrMqmkF/z/mtwaeFhSpAO0Vnyomcy
         AtEpp3QDKRcHBNIqm98pI06jkMC6JRsgI0ccOCGxPgUkdkO8AcuO1ToV+rO0ESGazZ
         qa2NCXKzq3R0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2A9635C03F3; Sat, 27 Aug 2022 10:04:10 -0700 (PDT)
Date:   Sat, 27 Aug 2022 10:04:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <20220827170410.GG6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <20220826204219.GX6159@paulmck-ThinkPad-P17-Gen-1>
 <Ywo/j7V2GbMKMmp3@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywo/j7V2GbMKMmp3@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 27, 2022 at 12:00:15PM -0400, Alan Stern wrote:
> On Fri, Aug 26, 2022 at 01:42:19PM -0700, Paul E. McKenney wrote:
> > On Fri, Aug 26, 2022 at 01:10:39PM -0400, Alan Stern wrote:
> > > On Fri, Aug 26, 2022 at 06:23:24PM +0200, Peter Zijlstra wrote:
> > > > I think we should address that first one in LKMM, it seems very weird to
> > > > me a RmW would break the chain like that.
> > > 
> > > An explicitly relaxed RMW (atomic_cmpxchg_relaxed(), to be precise).
> > > 
> > > If the authors wanted to keep the release-acquire chain intact, why not 
> > > use a cmpxchg version that has release semantics instead of going out of 
> > > their way to use a relaxed version?
> > > 
> > > To put it another way, RMW accesses and release-acquire accesses are 
> > > unrelated concepts.  You can have one without the other (in principle, 
> > > anyway).  So a relaxed RMW is just as capable of breaking a 
> > > release-acquire chain as any other relaxed operation is.
> > > 
> > > >  Is there actual hardware that
> > > > doesn't behave?
> > > 
> > > Not as far as I know, although that isn't very far.  Certainly an 
> > > other-multicopy-atomic architecture would make the litmus test succeed.  
> > > But the LKMM does not require other-multicopy-atomicity.
> > 
> > My first attempt with ppcmem suggests that powerpc does -not- behave
> > this way.  But that surprises me, just on general principles.  Most likely
> > I blew the litmus test shown below.
> > 
> > Thoughts?
> 
> The litmus test looks okay.
> 
> As for your surprise, remember that PPC is B-cumulative, another 
> property which the LKMM does not require.  B-cumulativity will also 
> force the original litmus test to succeed.  (The situation is like ISA2 
> in the infamous test6.pdf, except that y and z are separate variables in 
> ISA2 but are the same here.  The RMW nature of lwarx/stwcx provides 
> the necessary R-W ordering in P1.)

Got it, thank you!

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > PPC MP+lwsyncs+atomic
> > "LwSyncdWW Rfe LwSyncdRR Fre"
> > Cycle=Rfe LwSyncdRR Fre LwSyncdWW
> > {
> > 0:r2=x; 0:r4=y;
> > 1:r2=y; 1:r5=2;
> > 2:r2=y; 2:r4=x;
> > }
> >  P0           | P1              | P2           ;
> >  li r1,1      | lwarx r1,r0,r2  | lwz r1,0(r2) ;
> >  stw r1,0(r2) | stwcx. r5,r0,r2 | lwsync       ;
> >  lwsync       |                 | lwz r3,0(r4) ;
> >  li r3,1      |                 |              ;
> >  stw r3,0(r4) |                 |              ;
> > exists (1:r1=1 /\ 2:r1=2 /\ 2:r3=0)
> > 
> > ------------------------------------------------------------------------
> > 
> > $ ./ppcmem -model lwsync_read_block -model coherence_points MP+lwsyncs+atomic.litmus
> > ...
> > Test MP+lwsyncs+atomic Allowed
> > States 9
> > 1:r1=0; 2:r1=0; 2:r3=0;
> > 1:r1=0; 2:r1=0; 2:r3=1;
> > 1:r1=0; 2:r1=1; 2:r3=1;
> > 1:r1=0; 2:r1=2; 2:r3=0;
> > 1:r1=0; 2:r1=2; 2:r3=1;
> > 1:r1=1; 2:r1=0; 2:r3=0;
> > 1:r1=1; 2:r1=0; 2:r3=1;
> > 1:r1=1; 2:r1=1; 2:r3=1;
> > 1:r1=1; 2:r1=2; 2:r3=1;
> > No (allowed not found)
> > Condition exists (1:r1=1 /\ 2:r1=2 /\ 2:r3=0)
> > Hash=b7cec0e2ecbd1cb68fe500d6fe362f9c
> > Observation MP+lwsyncs+atomic Never 0 9
