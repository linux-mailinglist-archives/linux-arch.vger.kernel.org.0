Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4F5B58AA
	for <lists+linux-arch@lfdr.de>; Mon, 12 Sep 2022 12:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiILKqq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 12 Sep 2022 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiILKqq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2022 06:46:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E0B31EEB;
        Mon, 12 Sep 2022 03:46:41 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MR3Cw4VPcz67NNV;
        Mon, 12 Sep 2022 18:45:48 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (7.191.160.210) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 12:46:39 +0200
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 11:46:39 +0100
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2375.031;
 Mon, 12 Sep 2022 11:46:38 +0100
From:   Jonas Oberhauser <jonas.oberhauser@huawei.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Hernan Luis Ponce de Leon <hernanl.leon@huawei.com>
CC:     Boqun Feng <boqun.feng@gmail.com>,
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
Thread-Index: AQFTHlbyPG8prHkfhsVi+5kWxbhPeQF4BTgfASiPsr8Ag2bPhQCWSQQGAdXuv7eutboz0IABoUKwgAAidwCAAuR04A==
Date:   Mon, 12 Sep 2022 10:46:38 +0000
Message-ID: <1326fa48d44b4571b436c07ae9f32d83@huawei.com>
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
x-originating-ip: [10.45.157.136]
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

Hi Alan,

Sorry for the confusion.

>  [...] it's certainly true (in all of these
models) than for any finite number N, there is a feasible execution in which a loop runs for more than N iterations before the termination condition eventually becomes true.
	
Indeed; but more interestingly, as the Theorem 5.3 in "making weak memory models fair" states, under certain conditions it suffices to look at graphs where N=1 to decide whether a loop can run forever (despite all writes propagating to all cores eventually) or will always terminate.

And since herd can generate all such graphs, herd could be extended to make that decision and output it, just like many other tools already do.

To illuminate this on an example, consider the program sent by Peter earlier:
	WRITE_ONCE(foo, 1);		while (!READ_ONCE(foo));

Without the assumption that fr is prefix finite, the graph with infinitely many reads of thread 2 all reading the initial value (and hence being fr-before the store foo=1) would be allowed. However, the tools used to analyze the qspinlock all assume that fr is prefix finite, and hence that such a graph with infinitely many fr-before events does not exist. Because of that, all of the tools will say that this loop always terminates.

However, if you change the code into the following:

	WRITE_ONCE(foo, 1);		WRITE_ONCE(foo, 0); while (!READ_ONCE(foo));

then even under the assumption of fr-prefix-finiteness, the coherence order in which WRITE_ONCE(foo, 1); is overwritten by WRITE_ONCE(foo, 0); of thread 2 would lead to non-terminating behaviors, and these are detected by those tools. Furthermore, if we synchronize the two stores as follows:

	while (! READ_ONCE(bar)) {}; WRITE_ONCE(foo, 1);		WRITE_ONCE(foo, 0); smp_store_release(&bar,1); while (!READ_ONCE(foo));

then the graphs with that co become prohibited as they all have hb cycles, and the tools again will not detect any liveness violations. But if we go further and relax the release barrier as below


	while (! READ_ONCE(bar)) {}; WRITE_ONCE(foo, 1);		WRITE_ONCE(foo, 0); WRITE_ONCE(bar,1); while (!READ_ONCE(foo));

then the hb cycle disappears, and the coherence order in which foo=0 overwrites foo=1 becomes allowed. Again, the tools will detect this and state that thread 2 could be stuck in its while loop forever.

In each of these cases, the decision can be made by looking for a graph in which the loop is executed for one iteration which reads from foo=0, and checking whether that store is co-maximal. So in some sense this is all that is needed to express the idea that a program can run forever, even though only in some very limited (but common) circumstances, namely that the loop iteration that repeats forever does not create modifications to state that are observed outside the loop. Luckily this is a very common case, so these checks have proven quite useful in practice.

The same kind of check could be implemented in herd together with either the implicit assumption that fr is prefix finite (like in other tools) or with some special syntax like

prefix-finite fr | co as fairness

which hopefully clears up the question below:

> > From an engineering perspective, I think the only issue is that cat
> > *currently* does not have any syntax for this,

> Syntax for what?  The difference between wmb and mb?
> [...]


Thanks for your patience and hoping I explained it more clearly,

jonas
