Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6890680094
	for <lists+linux-arch@lfdr.de>; Sun, 29 Jan 2023 18:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjA2RvX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 29 Jan 2023 12:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjA2RvX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 29 Jan 2023 12:51:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3493819F00;
        Sun, 29 Jan 2023 09:51:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4E1160CEF;
        Sun, 29 Jan 2023 17:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E301C433EF;
        Sun, 29 Jan 2023 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675014681;
        bh=l4hEyZpO2oJZa+cpND05u71/0f47fJcK1SCdHu0VA6A=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=jaY2H0zphpAB/4y7WSq+gtS9dUOd9004iuBraqeUUdS7K39qXPEO7c0ogJ0V5MNaz
         q6TOEZ4J7JIwSpICLrpyWLQakrxLISOtFvkvrSL0i46UCmDxIMqWX7G+irkc38fj/W
         TjVaTeG/FGk97WdWzeG7c78znCRAsCmd3LlKmf/mEp412371U20ZVmESE68osZSq8u
         T3ngCFrBa/cZmAj85wzAZbw6IPEB8yfktgg16gPec+//ftW13cgoZdXCojbmdHB/8m
         UactsGRGBq0eDHA+nHXgX9ySz09KoX2I+4jPlZ39jBZjJk8/9D+x4hwTzw049oFxt8
         Z6bPGXkw0O0aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AB7E75C08B3; Sun, 29 Jan 2023 09:51:20 -0800 (PST)
Date:   Sun, 29 Jan 2023 09:51:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model] Add smp_mb__after_srcu_read_unlock()
Message-ID: <20230129175120.GA1109244@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

If we really do figure a way to weaken srcu_read_unlock() to release
semantics, this functionality might play a greater role.

It can be argued that smp_mb__after_srcu_read_unlock() should instead
be smp_mb__before_srcu_read_unlock() to make it more clear that the full
memory barrier precedes the end of any ongoing grace period.  There are
not that many uses of smp_mb__after_srcu_read_unlock(), so...

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index dc464854d28a4..b92fdf7f6eeb1 100644
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
index 6e531457bb738..3a4d3b49e85cb 100644
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
index ef0f3c1850dee..a6b6fbc9d0b24 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -24,6 +24,7 @@ smp_mb__before_atomic() { __fence{before-atomic}; }
 smp_mb__after_atomic() { __fence{after-atomic}; }
 smp_mb__after_spinlock() { __fence{after-spinlock}; }
 smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }
+smp_mb__after_srcu_read_unlock() { __fence{after-srcu-read-unlock}; }
 barrier() { __fence{barrier}; }
 
 // Exchange
