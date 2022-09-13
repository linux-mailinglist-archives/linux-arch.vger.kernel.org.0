Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA4E5B6C57
	for <lists+linux-arch@lfdr.de>; Tue, 13 Sep 2022 13:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiIMLYZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Sep 2022 07:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiIMLYY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Sep 2022 07:24:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A375E652;
        Tue, 13 Sep 2022 04:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A5F6142A;
        Tue, 13 Sep 2022 11:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F24C433C1;
        Tue, 13 Sep 2022 11:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663068262;
        bh=THuJP0WJEfHxE8DKbrRwfNvhpJj6jXfLpT5jJ4vmLXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAfyez+6X8YcxvwrfSr7TeaBvBPQXIQsSVWvgYpC2nVu90qjQm90yNtOcngPUA+P1
         ZyGNmyJZZxzqftl07y94cOTEhYnAf0MOus4DmdYkIbuBc1xT0ek8luO6uc5O4UDZ9o
         vfgqwGiCBcnzo3i0/pnpQtRDyy6skzEc0Z2oIBdt9ybQNBFkU/skluiHqkLc6vjpa1
         ZW1lxiFq2nMky8R9jGPd3r02A55AfjBzmoij8JRDrM/pT0t2BMF5ihi3cxO5awoz9E
         7zYW0TmJlaQr+M1ujPNo1ibqDxTLUGs/QVzVPyjvy39tgveEHgWsuxCA91pN6tEmJ0
         1tk4o7v6Hmv6Q==
Date:   Tue, 13 Sep 2022 12:24:16 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <20220913112416.GC3752@willie-the-truck>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <20220826204219.GX6159@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826204219.GX6159@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 01:42:19PM -0700, Paul E. McKenney wrote:
> On Fri, Aug 26, 2022 at 01:10:39PM -0400, Alan Stern wrote:
> > On Fri, Aug 26, 2022 at 06:23:24PM +0200, Peter Zijlstra wrote:
> > > On Fri, Aug 26, 2022 at 05:48:12AM -0700, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > I have not yet done more than glance at this one, but figured I should
> > > > send it along sooner rather than later.
> > > > 
> > > > "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
> > > > Memory Models", Antonio Paolillo, Hernán Ponce-de-León, Thomas
> > > > Haas, Diogo Behrens, Rafael Chehab, Ming Fu, and Roland Meyer.
> > > > https://arxiv.org/abs/2111.15240
> > > > 
> > > > The claim is that the queued spinlocks implementation with CNA violates
> > > > LKMM but actually works on all architectures having a formal hardware
> > > > memory model.
> > > > 
> > > > Thoughts?
> > > 
> > > So the paper mentions the following defects:
> > > 
> > >  - LKMM doesn't carry a release-acquire chain across a relaxed op
> > 
> > That's right, although I'm not so sure this should be considered a 
> > defect...
> > 
> > >  - some babbling about a missing propagation -- ISTR Linux if stuffed
> > >    full of them, specifically we require stores to auto propagate
> > >    without help from barriers
> > 
> > Not a missing propagation; a late one.
> > 
> > Don't understand what you mean by "auto propagate without help from 
> > barriers".
> > 
> > >  - some handoff that is CNA specific and I've not looked too hard at
> > >    presently.
> > > 
> > > 
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
> 
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

Just catching up on this, but one possible gotcha here is if you have an
architecture with native load-acquire on P2 and then you move P2 to the end
of P1. e.g. at a high-level:


  P0		P1
  Wx = 1	RmW(y) // xchg() 1 => 2
  WyRel = 1	RyAcq = 2
		Rx = 0

arm64 forbids this, but it's not "natural" to the hardware and I don't
know what e.g. risc-v would say about it.

Will
