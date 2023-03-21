Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424956C26B0
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCUBDQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCUBDN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:03:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECDD32CD2;
        Mon, 20 Mar 2023 18:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2439AB810A0;
        Tue, 21 Mar 2023 01:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77ECC4339B;
        Tue, 21 Mar 2023 01:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360567;
        bh=v+o7k88i3gFGVlJhUGgecvLTnT0QcUZwggZOJd/nU3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HaPWWk3nvRhqjrKOptAHVkoP8Wrq9SI/mzmx1D5ifqmDkbfu3cBJpnH9aZUrleQvW
         MFsjnXzoFLsVEBONSk2z+kXCvr3RtoBtj5rDI5DQ2oTaj/zvZ6pJLnBse+pAxzOeCi
         aLOl9bYqMx/yhFtzqTYDPKPzZlmmTrSP9VwD/pKqQntBI9NI4Jc4rUF/v5RRI26KEM
         LLYCXPoRb3nOk/2p5MtHQByoDpjhAUKsjWHxROgEt+/uz6ZuD2drpd3m+Qz3okskHT
         QRFRHUiqoKl+bQsQ0Xdy6r6fkenr+E/Y2a5otbLbrzE8oPDJerNQZ1KyKcso8LNu3O
         ynThYWkWn8f9Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 73E3B154039D; Mon, 20 Mar 2023 18:02:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 3/8] tools/memory-model: Add smp_mb__after_srcu_read_unlock()
Date:   Mon, 20 Mar 2023 18:02:41 -0700
Message-Id: <20230321010246.50960-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit adds support for smp_mb__after_srcu_read_unlock(), which,
when combined with a prior srcu_read_unlock(), implies a full memory
barrier.  No ordering is guaranteed to accesses between the two, and
placing accesses between is bad practice in any case.

Tests may be found at https://github.com/paulmckrcu/litmus in files
matching manual/kernel/C-srcu-mb-*.litmus.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/linux-kernel.bell | 3 ++-
 tools/memory-model/linux-kernel.cat  | 3 ++-
 tools/memory-model/linux-kernel.def  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index dc464854d28a..b92fdf7f6eeb 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -31,7 +31,8 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 		'before-atomic (*smp_mb__before_atomic*) ||
 		'after-atomic (*smp_mb__after_atomic*) ||
 		'after-spinlock (*smp_mb__after_spinlock*) ||
-		'after-unlock-lock (*smp_mb__after_unlock_lock*)
+		'after-unlock-lock (*smp_mb__after_unlock_lock*) ||
+		'after-srcu-read-unlock (*smp_mb__after_srcu_read_unlock*)
 instructions F[Barriers]
 
 (* SRCU *)
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 6e531457bb73..3a4d3b49e85c 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -49,7 +49,8 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
  * also affected by the fence.
  *)
 	([M] ; po-unlock-lock-po ;
-		[After-unlock-lock] ; po ; [M])
+		[After-unlock-lock] ; po ; [M]) |
+	([M] ; po? ; [Srcu-unlock] ; fencerel(After-srcu-read-unlock) ; [M])
 let gp = po ; [Sync-rcu | Sync-srcu] ; po?
 let strong-fence = mb | gp
 
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index ef0f3c1850de..a6b6fbc9d0b2 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -24,6 +24,7 @@ smp_mb__before_atomic() { __fence{before-atomic}; }
 smp_mb__after_atomic() { __fence{after-atomic}; }
 smp_mb__after_spinlock() { __fence{after-spinlock}; }
 smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }
+smp_mb__after_srcu_read_unlock() { __fence{after-srcu-read-unlock}; }
 barrier() { __fence{barrier}; }
 
 // Exchange
-- 
2.40.0.rc2

