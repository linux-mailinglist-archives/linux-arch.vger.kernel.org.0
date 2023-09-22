Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4DF7ABABF
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 22:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjIVU7x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIVU7w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 16:59:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4A31A4;
        Fri, 22 Sep 2023 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:References:In-Reply-To:Cc:To:
        From:Date:Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=reMqHnLawtQWzzJGyWchM0kycFgNaHwuVHMPL5F7/LQ=; b=fwFeoZP8X3SOPmGO0C+SKoLaLG
        UAKf05bsOetdUDWVacCvVL3SjXif6z0O3NNcDeX2/R9AoKIxklW0DVkMVGiUH76DI2+9q/U/93kHO
        bNuJPeHtMFR0JJKT4MjBEckZyH2RdH3VzULD/Pw+zP2inGLQvGtVqVNd3wnqS01TNY77T0U9q+wVk
        rl3NW0T1VqrbVmYNUn4m+pstkERd4VyJW+r7qM5NQJQeiKA/maXRRwLEEz82fnvXMnoZHAm/exTmY
        F7jM4yvKtti+5FjtFSQbidMffXd456V/d5TWPSxjJzB6J5g9wzFI2cQmKMWVYI8rHZlOJDkk8SNnR
        K0IQUNYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjnEs-00GXz9-2k;
        Fri, 22 Sep 2023 20:59:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id E269230042E; Fri, 22 Sep 2023 22:59:03 +0200 (CEST)
Message-Id: <20230922200120.011184118@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 22 Sep 2023 22:01:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, steve.shaw@intel.com,
        marko.makela@mariadb.com, andrei.artemev@intel.com
In-Reply-To: <20230921104505.717750284@noisy.programming.kicks-ass.net>
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
 <20230921104505.717750284@noisy.programming.kicks-ass.net>
Subject: futex2 numa stuff
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

Updated version of patch 15/15 and a few extra patches for testing the
FUTEX2_NUMA bits. The last patch (17/15) should never be applied for anything
you care about and exists purely because I'm too lazy to generate actual
hash-bucket contention.

On my 2 node IVB-EP:

 $ echo FUTEX_SQUASH > /debug/sched/features

Effectively reducing each node to 1 bucket.

 $ numactl -m0 -N0 ./futex_numa -c10 -t2 -n0 -N0 &
   numactl -m1 -N1 ./futex_numa -c10 -t2 -n0 -N0

 ...
 contenders: 16154935
 contenders: 16202472

 $ numactl -m0 -N0 ./futex_numa -c10 -t2 -n0 -N0 &
   numactl -m1 -N1 ./futex_numa -c10 -t2 -n0 -N1

 contenders: 48584991
 contenders: 48680560

(loop counts, higher is better)

Clearly showing how separating the hashes works. 

The first one runs 10 contenders on each node but forces the (numa) futex to
hash to node 0 for both. This ensures all 20 contenders hash to the same
bucket and *ouch*.

The second one does the same, except now fully separates the nodes. Performance
is much improved.

Proving the per-node hashing actually works as advertised.

Further:

 $ ./futex_numa -t2 -n50000 -s1 -N
 ...
 node: -1
 node: -1
 node: 0
 node: 0
 node: -1
 node: -1
 node: 1
 node: 1
 ...
 total: 8980

Shows how a FUTEX2_NUMA lock can bounce around the nodes. The test has some
trivial asserts trying to show critical section integrity, but otherwise does
lock+unlock cycles with a nanosleep.

This both illustrates how to build a (trivial) lock using FUTEX2_NUMA and
proves the functionality works.



