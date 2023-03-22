Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6BD6C533D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 19:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCVSGL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 14:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCVSGK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 14:06:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF51A3C7AE;
        Wed, 22 Mar 2023 11:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 666DBB81D84;
        Wed, 22 Mar 2023 18:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC65C433D2;
        Wed, 22 Mar 2023 18:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679508365;
        bh=NqIy8TPXH9n8Xdk5/LzybvZZAuSf+YD8WPfMsoOoEMw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eLYggIRADBn1RXYNnqJkmcJDffKSvjwZz51H9im/gHzfxqS8wH4p11/LXu/wX7TRG
         HX0G0AO7C0Hp2t5VGqbVyKFzGDK1ueAMh5MW990k6EhKI3O68LUI57Ysx9YCEIgpLF
         uSZFz0+oEO0QHLg1Ww03GZ+EvlSUfh7dMci9txHlWWVP5rYyNy/JdOphfpwH7MHm1f
         RauH12LtASBKOVUg8FcVTJuakKUubTlOW/9kerUpDJMnlHVhweIR/JhPF3gzX5JWWk
         XjSZr8m12bzZjCmo7asXHme7YFvTOi7EAtb7+IfAGUKPyuDICEUgaV7CR4Jl3Kb3AK
         Jv5II6dHf7UYQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8801A154033A; Wed, 22 Mar 2023 11:06:04 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:06:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: Re: [PATCH memory-model 2/8] tools/memory-model: Unify UNLOCK+LOCK
 pairings to po-unlock-lock-po
Message-ID: <09ea96a9-89c2-4c91-8656-63665e38b879@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
 <20230321010246.50960-2-paulmck@kernel.org>
 <ZBpS1H2rufhVoCid@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBpS1H2rufhVoCid@andrea>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 22, 2023 at 01:59:00AM +0100, Andrea Parri wrote:
> On Mon, Mar 20, 2023 at 06:02:40PM -0700, Paul E. McKenney wrote:
> > From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > 
> > LKMM uses two relations for talking about UNLOCK+LOCK pairings:
> > 
> > 	1) po-unlock-lock-po, which handles UNLOCK+LOCK pairings
> > 	   on the same CPU or immediate lock handovers on the same
> > 	   lock variable
> > 
> > 	2) po;[UL];(co|po);[LKW];po, which handles UNLOCK+LOCK pairs
> > 	   literally as described in rcupdate.h#L1002, i.e., even
> > 	   after a sequence of handovers on the same lock variable.
> > 
> > The latter relation is used only once, to provide the guarantee
> > defined in rcupdate.h#L1002 by smp_mb__after_unlock_lock(), which
> > makes any UNLOCK+LOCK pair followed by the fence behave like a full
> > barrier.
> > 
> > This patch drops this use in favor of using po-unlock-lock-po
> > everywhere, which unifies the way the model talks about UNLOCK+LOCK
> > pairings.  At first glance this seems to weaken the guarantee given
> > by LKMM: When considering a long sequence of lock handovers
> > such as below, where P0 hands the lock to P1, which hands it to P2,
> > which finally executes such an after_unlock_lock fence, the mb
> > relation currently links any stores in the critical section of P0
> > to instructions P2 executes after its fence, but not so after the
> > patch.
> > 
> > P0(int *x, int *y, spinlock_t *mylock)
> > {
> >         spin_lock(mylock);
> >         WRITE_ONCE(*x, 2);
> >         spin_unlock(mylock);
> >         WRITE_ONCE(*y, 1);
> > }
> > 
> > P1(int *y, int *z, spinlock_t *mylock)
> > {
> >         int r0 = READ_ONCE(*y); // reads 1
> >         spin_lock(mylock);
> >         spin_unlock(mylock);
> >         WRITE_ONCE(*z,1);
> > }
> > 
> > P2(int *z, int *d, spinlock_t *mylock)
> > {
> >         int r1 = READ_ONCE(*z); // reads 1
> >         spin_lock(mylock);
> >         spin_unlock(mylock);
> >         smp_mb__after_unlock_lock();
> >         WRITE_ONCE(*d,1);
> > }
> > 
> > P3(int *x, int *d)
> > {
> >         WRITE_ONCE(*d,2);
> >         smp_mb();
> >         WRITE_ONCE(*x,1);
> > }
> > 
> > exists (1:r0=1 /\ 2:r1=1 /\ x=2 /\ d=2)
> > 
> > Nevertheless, the ordering guarantee given in rcupdate.h is actually
> > not weakened.  This is because the unlock operations along the
> > sequence of handovers are A-cumulative fences.  They ensure that any
> > stores that propagate to the CPU performing the first unlock
> > operation in the sequence must also propagate to every CPU that
> > performs a subsequent lock operation in the sequence.  Therefore any
> > such stores will also be ordered correctly by the fence even if only
> > the final handover is considered a full barrier.
> > 
> > Indeed this patch does not affect the behaviors allowed by LKMM at
> > all.  The mb relation is used to define ordering through:
> > 1) mb/.../ppo/hb, where the ordering is subsumed by hb+ where the
> >    lock-release, rfe, and unlock-acquire orderings each provide hb
> > 2) mb/strong-fence/cumul-fence/prop, where the rfe and A-cumulative
> >    lock-release orderings simply add more fine-grained cumul-fence
> >    edges to substitute a single strong-fence edge provided by a long
> >    lock handover sequence
> > 3) mb/strong-fence/pb and various similar uses in the definition of
> >    data races, where as discussed above any long handover sequence
> >    can be turned into a sequence of cumul-fence edges that provide
> >    the same ordering.
> > 
> > Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Looks like after-unlock-lock has just won the single fattest inline comment
> in linux-kernel.cat.  :-)
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thank you!  I will apply these tags (1, 2, and 4) on my next rebase.

							Thanx, Paul

>   Andrea
> 
> 
> > ---
> >  tools/memory-model/linux-kernel.cat | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > index 07f884f9b2bf..6e531457bb73 100644
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -37,8 +37,19 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
> >  	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> >  	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> >  	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> > -	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> > -		fencerel(After-unlock-lock) ; [M])
> > +(*
> > + * Note: The po-unlock-lock-po relation only passes the lock to the direct
> > + * successor, perhaps giving the impression that the ordering of the
> > + * smp_mb__after_unlock_lock() fence only affects a single lock handover.
> > + * However, in a longer sequence of lock handovers, the implicit
> > + * A-cumulative release fences of lock-release ensure that any stores that
> > + * propagate to one of the involved CPUs before it hands over the lock to
> > + * the next CPU will also propagate to the final CPU handing over the lock
> > + * to the CPU that executes the fence.  Therefore, all those stores are
> > + * also affected by the fence.
> > + *)
> > +	([M] ; po-unlock-lock-po ;
> > +		[After-unlock-lock] ; po ; [M])
> >  let gp = po ; [Sync-rcu | Sync-srcu] ; po?
> >  let strong-fence = mb | gp
> >  
> > -- 
> > 2.40.0.rc2
> > 
