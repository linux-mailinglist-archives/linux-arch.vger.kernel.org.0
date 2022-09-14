Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED75B8AD7
	for <lists+linux-arch@lfdr.de>; Wed, 14 Sep 2022 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiINOlg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Sep 2022 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiINOld (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Sep 2022 10:41:33 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 668315D0FC
        for <linux-arch@vger.kernel.org>; Wed, 14 Sep 2022 07:41:32 -0700 (PDT)
Received: (qmail 640842 invoked by uid 1000); 14 Sep 2022 10:41:31 -0400
Date:   Wed, 14 Sep 2022 10:41:31 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hernan Luis Ponce de Leon <hernanl.leon@huawei.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <YyHoG8jS/6shACws@rowland.harvard.edu>
References: <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
 <YwpAzTwSRCK5kdLN@rowland.harvard.edu>
 <YwpJ4ZPVbuCnnFKS@boqun-archlinux>
 <674d0fda790d4650899e2fcf43894053@huawei.com>
 <b7e32a603fdc4883b87c733f5681c6d9@huawei.com>
 <YxynQmEL6e194Wuw@rowland.harvard.edu>
 <e8b6b7222a894984b4d66cdcc6435efe@huawei.com>
 <CAEXW_YQPSi7RyA=Cz5S753uw4SqBp2v+7CqqE3LN9VQ48q40Zg@mail.gmail.com>
 <34735a476c3b4913985de3403a6216bd@huawei.com>
 <7ad2354bf993435b917f278d4199a6ff@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad2354bf993435b917f278d4199a6ff@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 12, 2022 at 11:10:17AM +0000, Hernan Luis Ponce de Leon wrote:
> I think it is somehow possible to show the liveness violation using herd7 and the following variant of the code
> 
> ------------------------------------------------------------------------
> C Liveness
> {
>   atomic_t x = ATOMIC_INIT(0);
>   atomic_t y = ATOMIC_INIT(0);
> }
> 
> 
> P0(atomic_t *x) {
>   // clear_pending_set_locked
>   int r0 = atomic_fetch_add(2,x) ;
> }
> 
> P1(atomic_t *x, int *z, int *y) {
>   // this store breaks liveness
>   WRITE_ONCE(*y, 1);
>   // queued_spin_trylock
>   int r0 = atomic_read(x);
>   // barrier after the initialisation of nodes
>   smp_wmb();
>   // xchg_tail
>   int r1 = atomic_cmpxchg_relaxed(x,r0,42);
>   // link node into the waitqueue
>   WRITE_ONCE(*z, 1);
> }
> 
> P2(atomic_t *x,int *z, int *y) {
>   // node initialisation
>   WRITE_ONCE(*z, 2);
>   // queued_spin_trylock
>   int r0 = atomic_read(x);
>   // barrier after the initialisation of nodes
>   smp_wmb();
>   // if we read z==2 we expect to read this store
>   WRITE_ONCE(*y, 0);
>   // xchg_tail
>   int r1 = atomic_cmpxchg_relaxed(x,r0,24);
>   // spinloop
>   int r2 = READ_ONCE(*y);  
>   int r3 = READ_ONCE(*z);  
> }
> 
> exists (z=2 /\ y=1 /\ 2:r2=1 /\ 2:r3=2)
> ------------------------------------------------------------------------
> 
> Condition "2:r3=2" forces the spinloop to read from the first write in P2 and "z=2" forces this write 
> to be last in the coherence order. Conditions "2:r2=1" and "y=1" force the same for the other read.
> herd7 says this behavior is allowed by LKMM, showing that liveness can be violated.
> 
> In all the examples above, if we use mb() instead of wmb(), LKMM does not accept
> the behavior and thus liveness is guaranteed.

That's right.

The issue may be somewhat confused by the fact that there have been 
_two_ separate problems covered in this discussion.  One has to do with 
the use of relaxed vs. non-relaxed atomic accesses, and the other -- 
this one -- has to do with liveness (eventual termination of a spin 
loop).

You can see the distinction quite clearly by noticing in the litmus test 
above, the variable x plays absolutely no role.  There are no 
dependencies from it, it isn't accessed by any instructions that include 
an acquire or release memory barrier, and it isn't used in the "exists" 
clause.  If we remove x from the test (and remove P0, which is now 
vacuous), and we also remove the unneeded reads at the end of P2 
(unneeded because they observe the co-final values stored in y and z), 
what remains is:

P1(int *z, int *y) {
	WRITE_ONCE(*y, 1);
	smp_wmb();
	WRITE_ONCE(*z, 1);
}

P2(int *z, int *y) {
	WRITE_ONCE(*z, 2);
	smp_wmb();
	WRITE_ONCE(*y, 0);
}

exists (z=2 /\ y=1)

which is exactly the 2+2W pattern.  As others have pointed out, this 
pattern is permitted by LKML because we never found a good reason to 
forbid it, even though it cannot occur on any real hardware that 
supports Linux.

On the other hand, the simplicity of this "liveness" test leads me to 
wonder if it isn't missing some crucial feature of the actual qspinlock 
implementation.

Alan
