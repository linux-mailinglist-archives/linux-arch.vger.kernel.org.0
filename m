Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA0E6C26AC
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCUBDN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCUBDL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06979311EC;
        Mon, 20 Mar 2023 18:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59A91618E6;
        Tue, 21 Mar 2023 01:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B458FC433D2;
        Tue, 21 Mar 2023 01:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360567;
        bh=EZtQGfiUVBCTzbeZZD6hd/oXm/Lh2CaRjKVyFOMGkQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdRWKpr1DrklM1VpNS4yHWebuftSVAkBgJXz3NTj3UBWwzIhPpJ2TikJMrTAl1xTj
         mbNfNAYAn7xiBfeJPHyv8zSSBnhoKcbEVygo5JiDQOgxM+UApz/lul8kR4M7AFYMjh
         wvRUHCrd8uLEC98JEW8+ckrrjc43vKPsdcumPWfQUmr3x3gf2m3ne3wcdhKuVkUmyQ
         raZbHBK/TewSzdu5ixSK/9RFrGiOCIePp/YODe2cmRsFTmSLsBFmDsItNqiFNbCEi8
         0ETFnGHjOJDcZ4sR5b3kRetQ6vF2mIsqCCUD05e8oyJOQUnzQTsYChAbrbIzUU7a4y
         y4vzuVzLEjlTg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 69FC61540395; Mon, 20 Mar 2023 18:02:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 1/8] tools/memory-model: Update some warning labels
Date:   Mon, 20 Mar 2023 18:02:39 -0700
Message-Id: <20230321010246.50960-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

Some of the warning labels used in the LKMM are unfortunately
ambiguous.  In particular, the same warning is used for both an
unmatched rcu_read_lock() call and for an unmatched rcu_read_unlock()
call.  Likewise for the srcu_* equivalents.  Also, the warning about
passing a wrong value to srcu_read_unlock() -- i.e., a value different
from the one returned by the matching srcu_read_lock() -- talks about
bad nesting rather than non-matching values.

Let's update the warning labels to make their meanings more clear.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/linux-kernel.bell | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 70a9073dec3e..dc464854d28a 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -53,8 +53,8 @@ let rcu-rscs = let rec
 	in matched
 
 (* Validate nesting *)
-flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
-flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
+flag ~empty Rcu-lock \ domain(rcu-rscs) as unmatched-rcu-lock
+flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
 
 (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
 let srcu-rscs = let rec
@@ -69,14 +69,14 @@ let srcu-rscs = let rec
 	in matched
 
 (* Validate nesting *)
-flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
-flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
+flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
+flag ~empty Srcu-unlock \ range(srcu-rscs) as unmatched-srcu-unlock
 
 (* Check for use of synchronize_srcu() inside an RCU critical section *)
 flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
 
 (* Validate SRCU dynamic match *)
-flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
+flag ~empty different-values(srcu-rscs) as srcu-bad-value-match
 
 (* Compute marked and plain memory accesses *)
 let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
-- 
2.40.0.rc2

