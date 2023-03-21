Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705976C26BA
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCUBD2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCUBDP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:03:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CEF32E46;
        Mon, 20 Mar 2023 18:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DEA5B80AB3;
        Tue, 21 Mar 2023 01:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB157C433EF;
        Tue, 21 Mar 2023 01:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360567;
        bh=2Y/XkB2XZZFnsP5FyaQPKn2f91HJuzwOuZ3zcl/2c04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9DDTiT46Oi1hcKTuoi/+ql7R4BJ7GnazB3Dgvm89Zx/f4kXniLalQP0HpJ5nvLD0
         fGUzRF++FpNxq3Knx4+BbIXUSVErCmq1VxsKb+ZrWrF8b+pz88tR39FgDJgs21YmW8
         Fa/dKAeeyhfILqkglV7/WpDMLU0CxQO/oAPNoY1dIX0f7D7N3uQkE79EZlMGsjuXCE
         3ln9txdApPjeLtX2YoCSYOkMPtBDdhhmnfXO0427L5T7dWpO5Ft3aUxl59229CQ2ZN
         LSb/ql8xu4h4BizA5kmkurGpbLDccyFhvOriZJWStVCphzrI30Kwp66cdi18bDM/ar
         4h0fEG3U5WE6A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6EAAC154039B; Mon, 20 Mar 2023 18:02:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 2/8] tools/memory-model: Unify UNLOCK+LOCK pairings to po-unlock-lock-po
Date:   Mon, 20 Mar 2023 18:02:40 -0700
Message-Id: <20230321010246.50960-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>

LKMM uses two relations for talking about UNLOCK+LOCK pairings:

	1) po-unlock-lock-po, which handles UNLOCK+LOCK pairings
	   on the same CPU or immediate lock handovers on the same
	   lock variable

	2) po;[UL];(co|po);[LKW];po, which handles UNLOCK+LOCK pairs
	   literally as described in rcupdate.h#L1002, i.e., even
	   after a sequence of handovers on the same lock variable.

The latter relation is used only once, to provide the guarantee
defined in rcupdate.h#L1002 by smp_mb__after_unlock_lock(), which
makes any UNLOCK+LOCK pair followed by the fence behave like a full
barrier.

This patch drops this use in favor of using po-unlock-lock-po
everywhere, which unifies the way the model talks about UNLOCK+LOCK
pairings.  At first glance this seems to weaken the guarantee given
by LKMM: When considering a long sequence of lock handovers
such as below, where P0 hands the lock to P1, which hands it to P2,
which finally executes such an after_unlock_lock fence, the mb
relation currently links any stores in the critical section of P0
to instructions P2 executes after its fence, but not so after the
patch.

P0(int *x, int *y, spinlock_t *mylock)
{
        spin_lock(mylock);
        WRITE_ONCE(*x, 2);
        spin_unlock(mylock);
        WRITE_ONCE(*y, 1);
}

P1(int *y, int *z, spinlock_t *mylock)
{
        int r0 = READ_ONCE(*y); // reads 1
        spin_lock(mylock);
        spin_unlock(mylock);
        WRITE_ONCE(*z,1);
}

P2(int *z, int *d, spinlock_t *mylock)
{
        int r1 = READ_ONCE(*z); // reads 1
        spin_lock(mylock);
        spin_unlock(mylock);
        smp_mb__after_unlock_lock();
        WRITE_ONCE(*d,1);
}

P3(int *x, int *d)
{
        WRITE_ONCE(*d,2);
        smp_mb();
        WRITE_ONCE(*x,1);
}

exists (1:r0=1 /\ 2:r1=1 /\ x=2 /\ d=2)

Nevertheless, the ordering guarantee given in rcupdate.h is actually
not weakened.  This is because the unlock operations along the
sequence of handovers are A-cumulative fences.  They ensure that any
stores that propagate to the CPU performing the first unlock
operation in the sequence must also propagate to every CPU that
performs a subsequent lock operation in the sequence.  Therefore any
such stores will also be ordered correctly by the fence even if only
the final handover is considered a full barrier.

Indeed this patch does not affect the behaviors allowed by LKMM at
all.  The mb relation is used to define ordering through:
1) mb/.../ppo/hb, where the ordering is subsumed by hb+ where the
   lock-release, rfe, and unlock-acquire orderings each provide hb
2) mb/strong-fence/cumul-fence/prop, where the rfe and A-cumulative
   lock-release orderings simply add more fine-grained cumul-fence
   edges to substitute a single strong-fence edge provided by a long
   lock handover sequence
3) mb/strong-fence/pb and various similar uses in the definition of
   data races, where as discussed above any long handover sequence
   can be turned into a sequence of cumul-fence edges that provide
   the same ordering.

Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/linux-kernel.cat | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 07f884f9b2bf..6e531457bb73 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -37,8 +37,19 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
-	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
-		fencerel(After-unlock-lock) ; [M])
+(*
+ * Note: The po-unlock-lock-po relation only passes the lock to the direct
+ * successor, perhaps giving the impression that the ordering of the
+ * smp_mb__after_unlock_lock() fence only affects a single lock handover.
+ * However, in a longer sequence of lock handovers, the implicit
+ * A-cumulative release fences of lock-release ensure that any stores that
+ * propagate to one of the involved CPUs before it hands over the lock to
+ * the next CPU will also propagate to the final CPU handing over the lock
+ * to the CPU that executes the fence.  Therefore, all those stores are
+ * also affected by the fence.
+ *)
+	([M] ; po-unlock-lock-po ;
+		[After-unlock-lock] ; po ; [M])
 let gp = po ; [Sync-rcu | Sync-srcu] ; po?
 let strong-fence = mb | gp
 
-- 
2.40.0.rc2

