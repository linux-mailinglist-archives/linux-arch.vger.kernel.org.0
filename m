Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6733B5B59D5
	for <lists+linux-arch@lfdr.de>; Mon, 12 Sep 2022 14:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiILMCG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Sep 2022 08:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiILMB1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2022 08:01:27 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D38A93CBCD
        for <linux-arch@vger.kernel.org>; Mon, 12 Sep 2022 05:01:05 -0700 (PDT)
Received: (qmail 565827 invoked by uid 1000); 12 Sep 2022 08:01:03 -0400
Date:   Mon, 12 Sep 2022 08:01:03 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hernan Luis Ponce de Leon <hernanl.leon@huawei.com>,
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
Message-ID: <Yx8ff+Q/mNu/3R92@rowland.harvard.edu>
References: <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
 <YwpAzTwSRCK5kdLN@rowland.harvard.edu>
 <YwpJ4ZPVbuCnnFKS@boqun-archlinux>
 <674d0fda790d4650899e2fcf43894053@huawei.com>
 <b7e32a603fdc4883b87c733f5681c6d9@huawei.com>
 <YxynQmEL6e194Wuw@rowland.harvard.edu>
 <e8b6b7222a894984b4d66cdcc6435efe@huawei.com>
 <CAEXW_YQPSi7RyA=Cz5S753uw4SqBp2v+7CqqE3LN9VQ48q40Zg@mail.gmail.com>
 <34735a476c3b4913985de3403a6216bd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34735a476c3b4913985de3403a6216bd@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 12, 2022 at 10:13:33AM +0000, Jonas Oberhauser wrote:
> As I tried to explain before, this problem has nothing to do with 
> stores propagating within a given time to another core. Rather it is 
> due to two stores to the same location happening in a surprising 
> order. I.e., both stores propagate quickly to other cores, but in a 
> surprising coherence order.And if a wmb in the code is replaced by an 
> mb, then this co will create a pb cycle and become forbidden.
> 
> Therefore this hang should be observable on a hypothetical LKMM 
> processor which makes use of all the relaxed liberty the LKMM allows. 
> However according to the authors of that paper (who are my colleagues 
> but I haven't been involved deeply in that work), not even Power+gcc 
> allow this reordering to happen, and if that's true it is probably 
> because the wmb is mapped to lwsync which is fully cumulative in Power 
> but not in LKMM.

Yes, that's right.  On ARM64 architectures the reordering is forbidden 
by other multi-copy atomicity, and on PPC is it forbidden by 
B-cumulativity (neither of which is part of the LKMM).

If I'm not mistaken, another way to forbid it is to replace one of the 
relaxed atomic accesses with an atomic access having release semantics.  
Perhaps this change will find its way into the kernel source, since it 
has less overhead than replacing wmb with bm.

Alan
