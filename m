Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A1D6DBCE5
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 22:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjDHUYs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Apr 2023 16:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDHUYr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2023 16:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3756590;
        Sat,  8 Apr 2023 13:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0683060AD9;
        Sat,  8 Apr 2023 20:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E056C433D2;
        Sat,  8 Apr 2023 20:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680985485;
        bh=X+Lf7s5dxpEFVCEJOEx1czjjlt29a/yatD+un/fJqAQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uhRYc+Y1+hCW9P1CDcRKRgNiYNMBPENHY190qpXn5hSNIV3avW33kY7A/JOVoDtjl
         jx+pPKFznD35W5rf5tAjUq9WfZAZxj4XKdv22EubKZGZsW7+WxEJpJCZBz476aL6G6
         bpUd9MxmSLu4Vc0F45dEy0lXcUd9x1Y5pQe55is1Baa2KvEf6tzPyUNPuGKOpaBKdp
         6B892Za8Dza9s9v+wcTn1WNVtK8OE/o+Cp2115Vb3CRbTs/gy8BRcGV6X8fDIXbW29
         tkY+DdPm2PSn50EDt7qGzD17IY936DCjSt08XivlQEK9DEefaYRiuaBi4KFtmbb9yg
         DmNIAsG5DW2jw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DF06615404B5; Sat,  8 Apr 2023 13:24:44 -0700 (PDT)
Date:   Sat, 8 Apr 2023 13:24:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
Subject: Re: Litmus test names
Message-ID: <f43f3309-2aff-41be-b3c6-05864e9767b1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ea9376b4-4b3d-48ee-9c27-ad8de8a7b5cb@paulmck-laptop>
 <3908932E-17D4-4B87-AB0C-D10564F10623@joelfernandes.org>
 <159545c3-0093-3cbd-e822-7298ae764966@huaweicloud.com>
 <d32901a8-3a07-440c-9089-36b37c3f04e5@paulmck-laptop>
 <20230408164956.GA680332@google.com>
 <e4a2059d-8199-b74e-d776-116c99c73fe6@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4a2059d-8199-b74e-d776-116c99c73fe6@huaweicloud.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 08, 2023 at 08:57:57PM +0200, Jonas Oberhauser wrote:
> 
> On 4/8/2023 6:49 PM, Joel Fernandes wrote:
> > On Fri, Apr 07, 2023 at 05:49:02PM -0700, Paul E. McKenney wrote:
> > > On Fri, Apr 07, 2023 at 03:05:01PM +0200, Jonas Oberhauser wrote:
> > > > 
> > > > On 4/7/2023 2:12 AM, Joel Fernandes wrote:
> > > > > 
> > > > > > On Apr 6, 2023, at 6:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > 
> > > > > > ﻿On Thu, Apr 06, 2023 at 05:36:13PM -0400, Alan Stern wrote:
> > > > > > > Paul:
> > > > > > > 
> > > > > > > I just saw that two of the files in
> > > > > > > tools/memory-model/litmus-tests have
> > > > > > > almost identical names:
> > > > > > > 
> > > > > > >   Z6.0+pooncelock+pooncelock+pombonce.litmus
> > > > > > >   Z6.0+pooncelock+poonceLock+pombonce.litmus
> > > > > > > 
> > > > > > > They differ only by a lower-case 'l' vs. a capital 'L'.  It's
> > > > > > > not at all
> > > > > > > easy to see, and won't play well in case-insensitive filesystems.
> > > > > > > 
> > > > > > > Should one of them be renamed?
> > > > > > 
> > FWIW, if I move that smp_mb_after..() a step lower, that also makes the test
> > work (see below).
> > 
> > If you may look over quickly my analysis of why this smp_mb_after..() is
> > needed, it is because what I marked as a and d below don't have an hb
> > relation right?
> 
> I think a and d have an hb relation due to the
> a ->po-rel X ->rfe Y ->acq-po d
> edges (where X and Y are the unlock/lock events I annotated in your example
> below).
> 
> Generally, an mb_unlock_lock isn't used to give you hb, but to turn some
> (coe/fre) ; hb* edges into pb edges
> 
> In this case, that would probably be
> f ->fre a ->hb* f   (where a ->hb* f comes from a ->hb* d ->hb e ->hb f)
> By adding the mb_unlock_lock_po in one of the right places, this becomes f
> ->pb f,
> thus forbidden.

Yes, it is forbidden, and even on purpose.  ;-)

But please don't do this in real life.  Having that READ_ONCE(*y) be
ordered differently on different architectures is not what those reading
your code will want to deal with.

							Thanx, Paul

> Have fun,
> jonas
> 
> 
> > 
> > (*
> >    b ->rf c
> > 
> >    d ->co e
> > 
> >    e ->hb f
> > 
> >    basically the issue is a ->po b ->rf c ->po d    does not imply a ->hb d
> > *)
> > 
> > P0(int *x, int *y, spinlock_t *mylock)
> > {
> > 	spin_lock(mylock);
> > 	WRITE_ONCE(*x, 1); // a
> > 	WRITE_ONCE(*y, 1); // b
> > 	spin_unlock(mylock); // X
> > }
> > 
> > P1(int *y, int *z, spinlock_t *mylock)
> > {
> > 	int r0;
> > 
> > 	spin_lock(mylock); // Y
> > 	r0 = READ_ONCE(*y); // c
> > 	smp_mb__after_spinlock(); // moving this a bit lower also works fwiw.
> > 	WRITE_ONCE(*z, 1);  // d
> > 	spin_unlock(mylock);
> > }
> > 
> > P2(int *x, int *z)
> > {
> > 	int r1;
> > 
> > 	WRITE_ONCE(*z, 2);  // e
> > 	smp_mb();
> > 	r1 = READ_ONCE(*x); // f
> > }
> > 
> > exists (1:r0=1 /\ z=2 /\ 2:r1=0)
> > 
> > 
> > > Would someone like to to a "git mv" send the resulting patch?
> > Yes I can do that in return as I am thankful in advance for the above
> > discussion. ;)
> > 
> > thanks,
> > 
> >   - Joel
> > 
> 
