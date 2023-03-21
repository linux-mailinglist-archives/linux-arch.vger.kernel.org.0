Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30E6C26B6
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCUBDb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCUBD2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:03:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85A1303D4;
        Mon, 20 Mar 2023 18:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B1B11CE173F;
        Tue, 21 Mar 2023 01:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FEAC433A1;
        Tue, 21 Mar 2023 01:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360568;
        bh=ogHftEPqZVMExF9RqMnqFfkQ5fyo9sZst3jS5BWNIUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMaXhJS0JFHF6wWKE2hp7Jr8p6UBYPwpyxj7DYLWsP8Pr5H8ZWt9ptVZXtxDBO0up
         7z0J+t0Px6k/B0I2wTsZpddu/FM+KMJi7YP8kSp2+24uHncdEzhj0DGO+VtixEJkeW
         VQqHgSIXrasD1prXXHcICpipfPcChsHcAvO+GJORWmfd2JKzSnY9KLqci8soYJahYe
         WRXjXmBXPMdkz05MTsFr9lJzU7b7MeAVpl60PAHvoxtMW2XHj99HPKyUudkGpZrEl8
         zQQwi0xw5tVj2LNkjw7ZAjQ0HBG1rvYhwV1OXJ3dScGW7Z8JCdHFh1XDR9Y5u++ZQ/
         ggw5x8LRRnWRw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 80EC615403A3; Mon, 20 Mar 2023 18:02:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 6/8] tools/memory-model: Make ppo a subrelation of po
Date:   Mon, 20 Mar 2023 18:02:44 -0700
Message-Id: <20230321010246.50960-6-paulmck@kernel.org>
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

As stated in the documentation and implied by its name, the ppo
(preserved program order) relation is intended to link po-earlier
to po-later instructions under certain conditions.  However, a
corner case currently allows instructions to be linked by ppo that
are not executed by the same thread, i.e., instructions are being
linked that have no po relation.

This happens due to the mb/strong-fence/fence relations, which (as
one case) provide order when locks are passed between threads
followed by an smp_mb__after_unlock_lock() fence.  This is
illustrated in the following litmus test (as can be seen when using
herd7 with `doshow ppo`):

P0(spinlock_t *x, spinlock_t *y)
{
    spin_lock(x);
    spin_unlock(x);
}

P1(spinlock_t *x, spinlock_t *y)
{
    spin_lock(x);
    smp_mb__after_unlock_lock();
    *y = 1;
}

The ppo relation will link P0's spin_lock(x) and P1's *y=1, because
P0 passes a lock to P1 which then uses this fence.

The patch makes ppo a subrelation of po by letting fence contribute
to ppo only in case the fence links events of the same thread.

Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/linux-kernel.cat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index cfc1b8fd46da..adf3c4f41229 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -82,7 +82,7 @@ let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
 let to-r = (addr ; [R]) | (dep ; [Marked] ; rfi)
-let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
+let ppo = to-r | to-w | (fence & int) | (po-unlock-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = (rfe ; [Marked])? ; r
-- 
2.40.0.rc2

