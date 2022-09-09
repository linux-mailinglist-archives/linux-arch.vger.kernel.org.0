Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBA95B36A9
	for <lists+linux-arch@lfdr.de>; Fri,  9 Sep 2022 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIILp6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 9 Sep 2022 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiIILp5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2022 07:45:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2456F131ED4;
        Fri,  9 Sep 2022 04:45:54 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MPDgL0vt4z67YVQ;
        Fri,  9 Sep 2022 19:44:46 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Fri, 9 Sep 2022 13:45:52 +0200
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 12:45:52 +0100
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2375.031;
 Fri, 9 Sep 2022 12:45:52 +0100
From:   Jonas Oberhauser <jonas.oberhauser@huawei.com>
To:     Boqun Feng <boqun.feng@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Peter Zijlstra <peterz@infradead.org>,
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
Thread-Index: AQFTHlbyPG8prHkfhsVi+5kWxbhPeQF4BTgfASiPsr8Ag2bPhQCWSQQGAdXuv7eutboz0A==
Date:   Fri, 9 Sep 2022 11:45:52 +0000
Message-ID: <674d0fda790d4650899e2fcf43894053@huawei.com>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
 <YwpAzTwSRCK5kdLN@rowland.harvard.edu> <YwpJ4ZPVbuCnnFKS@boqun-archlinux>
In-Reply-To: <YwpJ4ZPVbuCnnFKS@boqun-archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.222.176]
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

Hi Boqun, hi everyone,

> > > >  - some babbling about a missing propagation -- ISTR Linux if stuffed
> > > >    full of them, specifically we require stores to auto propagate
> > > >    without help from barriers
> > > 
> > > Not a missing propagation; a late one.
> > > 
> > > Don't understand what you mean by "auto propagate without help 
> > > from barriers".

after a quick look at the claim in question, it seems to be about a different kind of issue. The problem alluded to seems not to be that the store doesn't propagate in finite time to the other core. The tools used by the authors of that work already assume every (marked) access propagates given enough time.

What they mean seems to be that a prop relation followed only by wmb (not mb) doesn't enforce the order of some writes to the same location, leading to the claimed hang in qspinlock (at least as far as LKMM is concerned). Without having looked at the code or trying to understand the bug in more detail, this may be similar to the bug fixed by Ingo in qspinlock in 2018 where the initialization of the locked bit in the node could overwrite the setting of the locked bit in the other thread, unless a release barrier/wmb is added at some point.

That being said:

> Should we add something somewhere in our model, maybe in the explanation.txt?
> Plus, I think we cannot express this in Herd because Herd uses graph-based model (axiomatic model) instead of an operational model to describe the model: axiomatic model cannot describe "something will eventually happen". There was also some discussion in the zulip steam of Rust unsafe-code-guidelines.

It is possible to express this kind of progress property in a graph based model. Some work on this was done in the RISC-V manual, as well as for some stronger graph based models ("making weak memory models fair", https://dl.acm.org/doi/10.1145/3485475 ) and in a more practical way for verification of liveness ( https://dl.acm.org/doi/abs/10.1145/3445814.3446748 ).

From a theoretical perspective, the suggestion made in "making weak memory models fair" would be to define prefix-finiteness of all the explicitly acyclic relations of LKMM, which includes the sc-per-loc relation and thus in particular fr. If fr is prefix-finite, meaning each store has only finitely many reads observing an older value, the infinite behaviour in the small example posted elsewhere in this thread becomes forbidden.

From an engineering perspective, I think the only issue is that cat *currently* does not have any syntax for this, nor does herd currently implement the await model checking techniques proposed in those works (c.f. Theorem 5.3. in the "making weak memory models fair" paper, which says that for this kind of loop, iff the mo-maximal reads in some graph are read in a loop iteration that does not exit the loop, the loop can run forever). However GenMC and I believe also Dat3M and recently also Nidhugg support such techniques. It may not even be too much effort to implement something like this in herd if desired.
	
Best regards,
jonas
