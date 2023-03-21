Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A46C26B1
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCUBDR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCUBDM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0831C3251A;
        Mon, 20 Mar 2023 18:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 826B5618F3;
        Tue, 21 Mar 2023 01:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30FAC4339E;
        Tue, 21 Mar 2023 01:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360567;
        bh=FT+Zpl2+JDglqimqaqOEQRRviu8fzMr0CfKlrl4m+TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTuYivu0kNSe9J7LE0cBTiQ01DXZeVMsPTKFG2LCALmDEeQg/wgzeuO4S6+PRkOYI
         eHRU0WZrBemHkq2jupfVz1VQu1lVfLZmotMC9y5IVLBT7AiOUjM8BqvHsQJeb19oSf
         rBCfFZaFJGSJqOZsulzeqPEeb6kjSN8XuYScXtkTgaeVj0hgWfznXElCIHqv8HI+o6
         V6wtjYvrDSUVF2UItwNa4g3nlrMTuddEWroM0KhNCxu4IIyv3rekmbS0IzJWdKcq75
         ft+ZHckgMCbSi476XTyxIXLnn8UeuEGaxxzlAUOfHHw3znzVLAtUPu3l3Jrx2YZFl+
         xBpsrZZobuozw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 78BF4154039F; Mon, 20 Mar 2023 18:02:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 4/8] tools/memory-model: Restrict to-r to read-read address dependency
Date:   Mon, 20 Mar 2023 18:02:42 -0700
Message-Id: <20230321010246.50960-4-paulmck@kernel.org>
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

During a code-reading exercise of linux-kernel.cat CAT file, I generated
a graph to show the to-r relations. While likely not problematic for the
model, I found it confusing that a read-write address dependency would
show as a to-r edge on the graph.

This patch therefore restricts the to-r links derived from addr to only
read-read address dependencies, so that read-write address dependencies don't
show as to-r in the graphs. This should also prevent future users of to-r from
deriving incorrect relations. Note that a read-write address dep, obviously,
still ends up in the ppo relation via the to-w relation.

I verified that a read-read address dependency still shows up as a to-r
link in the graph, as it did before.

For reference, the problematic graph was generated with the following
command:
herd7 -conf linux-kernel.cfg \
   -doshow dep -doshow to-r -doshow to-w ./foo.litmus -show all -o OUT/

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/linux-kernel.cat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 3a4d3b49e85c..cfc1b8fd46da 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -81,7 +81,7 @@ let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
-let to-r = addr | (dep ; [Marked] ; rfi)
+let to-r = (addr ; [R]) | (dep ; [Marked] ; rfi)
 let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
-- 
2.40.0.rc2

