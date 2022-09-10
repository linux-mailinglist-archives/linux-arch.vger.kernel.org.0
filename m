Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5E25B48D4
	for <lists+linux-arch@lfdr.de>; Sat, 10 Sep 2022 22:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiIJUlh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 10 Sep 2022 16:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiIJUlg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2022 16:41:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FFE12AD1;
        Sat, 10 Sep 2022 13:41:33 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MQ4Vr3M0Qz67KX0;
        Sun, 11 Sep 2022 04:40:20 +0800 (CST)
Received: from lhrpeml100004.china.huawei.com (7.191.162.219) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 10 Sep 2022 22:41:31 +0200
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 10 Sep 2022 21:41:30 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2375.031;
 Sat, 10 Sep 2022 21:41:30 +0100
From:   Hernan Luis Ponce de Leon <hernanl.leon@huawei.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
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
Subject: RE: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak Memory
 Models"
Thread-Topic: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Thread-Index: AQFTHlbyPG8prHkfhsVi+5kWxbhPeQF4BTgfASiPsr8Ag2bPhQCWSQQGAdXuv7eutboz0IABoUKwgAAidwCAAGhxQA==
Date:   Sat, 10 Sep 2022 20:41:30 +0000
Message-ID: <e8b6b7222a894984b4d66cdcc6435efe@huawei.com>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
 <YwpAzTwSRCK5kdLN@rowland.harvard.edu> <YwpJ4ZPVbuCnnFKS@boqun-archlinux>
 <674d0fda790d4650899e2fcf43894053@huawei.com>
 <b7e32a603fdc4883b87c733f5681c6d9@huawei.com>
 <YxynQmEL6e194Wuw@rowland.harvard.edu>
In-Reply-To: <YxynQmEL6e194Wuw@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.132.83]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> You were quoting Jonas here, right?  The email doesn't make this obvious
> because it doesn't have two levels of "> > " markings.

Yes, I was quoting Jonas. 
It seems my mail client did not format the email correctly and I did not notice.
Sorry for that.

> In general, _no_ two distinct relations in the LKMM have the same propagation
> properties.  If wmb always behaved the same way as mb, we wouldn't use two
> separate words for them.

I understand that relations with different names are intended to be different.
What I meant was 
	"wmb gives weaker propagation guarantees than mb and because of this, liveness of qspinlock is not guaranteed in LKMM" 

> 
> > The claim is based on these relations from the memory model
> >
> > let strong-fence = mb | gp
> > ...
> > let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
> > 	po-unlock-lock-po) ; [Marked]
> > let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
> > 	[Marked] ; rfe? ; [Marked]
> 
> Please be more specific.  What difference between mb and wmb are you
> concerned about?  

Since the code uses wmb, there are certain pairs of events that will not be in strong-fence.
Since strong-fence contributes to cumul-fence, cumul-fence to prop, and prop to hb, 
the pair of events related by hb is less that if the code would use mb instead.
Because of this, there are executions (in particular the one that violates liveness) that have 
an acyclic hb relation, but would create a cycle (and thus the memory model would not accept 
the behavior) if mb would have been used.

> Can you give a small litmus test that illustrates this
> difference?  Can you explain in more detail how this difference affects the
> qspinlock implementation?

Here is a litmus test showing the problem (I hope the comment are enough to relate it back to qspinlock)

C Liveness
{
  atomic_t x = ATOMIC_INIT(0);
  atomic_t y = ATOMIC_INIT(0);
}

P0(atomic_t *x) {
  // clear_pending_set_locked
  int r0 = atomic_fetch_add(2,x) ;
}

P1(atomic_t *x, int *z) {
  // queued_spin_trylock
  int r0 = atomic_read(x);
  // barrier after the initialization of nodes
  smp_wmb();
  // xchg_tail
  int r1 = atomic_cmpxchg_relaxed(x,r0,42);
  // link node into the waitqueue
  WRITE_ONCE(*z, 1);
}

P2(atomic_t *x,atomic_t *z) {
  // node initialization
  WRITE_ONCE(*z, 2);
  // queued_spin_trylock
  int r0 = atomic_read(x);
  // barrier after the initialization of nodes
  smp_wmb();
  // xchg_tail
  int r1 = atomic_cmpxchg_relaxed(x,r0,24);
}

exists (0:r0 = 24 /\ 1:r0 = 26 /\ z=2)

herd7 says that the behavior is observable. 
However if you change wmb by mb, it is not observable anymore.

> 
> > From an engineering perspective, I think the only issue is that cat
> > *currently* does not have any syntax for this,
> 
> Syntax for what?  The difference between wmb and mb?
> 
> >  nor does herd currently
> > implement the await model checking techniques proposed in those works
> > (c.f. Theorem 5.3. in the "making weak memory models fair" paper,
> > which says that for this kind of loop, iff the mo-maximal reads in
> > some graph are read in a loop iteration that does not exit the loop,
> > the loop can run forever). However GenMC and I believe also Dat3M and
> > recently also Nidhugg support such techniques. It may not even be too
> > much effort to implement something like this in herd if desired.
> 
> I believe that herd has no way to express the idea of a program running forever.
> On the other hand, it's certainly true (in all of these
> models) than for any finite number N, there is a feasible execution in which a
> loop runs for more than N iterations before the termination condition eventually
> becomes true.

Here I was again quoting Jonas.
I think his intention was to make a distinction between graph based semantics and tools.
While herd7 cannot reason about this kind of property, it is possible to define the property 
using graph based semantics and there are tools already using this.

Hernan

