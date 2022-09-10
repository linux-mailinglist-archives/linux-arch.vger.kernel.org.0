Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2316F5B4629
	for <lists+linux-arch@lfdr.de>; Sat, 10 Sep 2022 14:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIJMLo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 10 Sep 2022 08:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJMLn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2022 08:11:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EEF1759F;
        Sat, 10 Sep 2022 05:11:39 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MPsBw6l7jz67gYW;
        Sat, 10 Sep 2022 20:10:48 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 10 Sep 2022 14:11:36 +0200
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 10 Sep 2022 13:11:36 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2375.031;
 Sat, 10 Sep 2022 13:11:36 +0100
From:   Hernan Luis Ponce de Leon <hernanl.leon@huawei.com>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
Thread-Index: AQFTHlbyPG8prHkfhsVi+5kWxbhPeQF4BTgfASiPsr8Ag2bPhQCWSQQGAdXuv7eutboz0IABoUKw
Date:   Sat, 10 Sep 2022 12:11:36 +0000
Message-ID: <b7e32a603fdc4883b87c733f5681c6d9@huawei.com>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
 <YwpAzTwSRCK5kdLN@rowland.harvard.edu> <YwpJ4ZPVbuCnnFKS@boqun-archlinux>
 <674d0fda790d4650899e2fcf43894053@huawei.com>
In-Reply-To: <674d0fda790d4650899e2fcf43894053@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.134.155]
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


What they mean seems to be that a prop relation followed only by wmb (not mb) doesn't enforce the order of some writes to the same location, leading to the claimed hang in qspinlock (at least as far as LKMM is concerned). 

What we mean is that wmb does not give the same propagation properties as mb.
The claim is based on these relations from the memory model

let strong-fence = mb | gp
...
let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
	po-unlock-lock-po) ; [Marked]
let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
	[Marked] ; rfe? ; [Marked]

From an engineering perspective, I think the only issue is that cat *currently* does not have any syntax for this, nor does herd currently implement the await model checking techniques proposed in those works (c.f. Theorem 5.3. in the "making weak memory models fair" paper, which says that for this kind of loop, iff the mo-maximal reads in some graph are read in a loop iteration that does not exit the loop, the loop can run forever). However GenMC and I believe also Dat3M and recently also Nidhugg support such techniques. It may not even be too much effort to implement something like this in herd if desired.

The Dartagnan model checker uses the Theorem 5.3 from above to detect liveness violations.

We did not try to come up with a litmus test about the behavior because herd7 cannot reason about liveness.
However, if anybody is interested, the violating execution is shown here
	https://github.com/huawei-drc/cna-verification/blob/master/verification-output/BUG1.png

Hernan
