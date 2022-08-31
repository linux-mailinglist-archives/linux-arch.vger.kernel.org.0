Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF785A8592
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 20:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiHaS2h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 14:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiHaS2O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 14:28:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1421E9279;
        Wed, 31 Aug 2022 11:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C65861CD5;
        Wed, 31 Aug 2022 18:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FF0C433D6;
        Wed, 31 Aug 2022 18:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970235;
        bh=RH117eB+xIPb+d+OTRKvRd6566cj7SbPEdnpE0kcJI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKzzifM2IzFzPoYqwuHyb7KUze9j1tsaAPHuoTM5xD6cjWD15Br+PtwVZfQc6ByxH
         4PtHUKu4Y3zj4gv587QhE1thcigp4sir8uM6jxn2Bwg2blw63ns2OIbwDoaqfY5Te7
         MdKx3BgKVNqihDrZeSwNjRbVJ/O/h7SqqjtJknUpVOyK+WEb5F2VE0A1g/cW09Nj0p
         sqrX5r1sbZ7GN/0HlqJe60P/lsCCCF7Ml+l2GmvHnmUiu+953wEApZN6r1EW0iD9rI
         VGlTWuQFtvHR4WFhNTre7ElWAJdTdT1em6coaOTilIn0BeMHfrMDEWegNT1JWlET2S
         m6vKv/RVFfnfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 822DC5C02A9; Wed, 31 Aug 2022 11:23:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>,
        Marco Elver <elver@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 3/3] tools/memory-model: Clarify LKMM's limitations in litmus-tests.txt
Date:   Wed, 31 Aug 2022 11:23:53 -0700
Message-Id: <20220831182353.2699262-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831182350.GA2698943@paulmck-ThinkPad-P17-Gen-1>
References: <20220831182350.GA2698943@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Paul Heidekrüger <paul.heidekrueger@in.tum.de>

As discussed, clarify LKMM not recognizing certain kinds of orderings.
In particular, highlight the fact that LKMM might deliberately make
weaker guarantees than compilers and architectures.

[ paulmck: Fix whitespace issue noted by checkpatch.pl. ]

Link: https://lore.kernel.org/all/YpoW1deb%2FQeeszO1@ethstick13.dse.in.tum.de/T/#u
Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
Cc: Martin Fink <martin.fink@in.tum.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Documentation/litmus-tests.txt            | 37 ++++++++++++++-----
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
index 8a9d5d2787f9e..26554b1c5575e 100644
--- a/tools/memory-model/Documentation/litmus-tests.txt
+++ b/tools/memory-model/Documentation/litmus-tests.txt
@@ -946,22 +946,39 @@ Limitations of the Linux-kernel memory model (LKMM) include:
 	carrying a dependency, then the compiler can break that dependency
 	by substituting a constant of that value.
 
-	Conversely, LKMM sometimes doesn't recognize that a particular
-	optimization is not allowed, and as a result, thinks that a
-	dependency is not present (because the optimization would break it).
-	The memory model misses some pretty obvious control dependencies
-	because of this limitation.  A simple example is:
+	Conversely, LKMM will sometimes overestimate the amount of
+	reordering compilers and CPUs can carry out, leading it to miss
+	some pretty obvious cases of ordering.  A simple example is:
 
 		r1 = READ_ONCE(x);
 		if (r1 == 0)
 			smp_mb();
 		WRITE_ONCE(y, 1);
 
-	There is a control dependency from the READ_ONCE to the WRITE_ONCE,
-	even when r1 is nonzero, but LKMM doesn't realize this and thinks
-	that the write may execute before the read if r1 != 0.  (Yes, that
-	doesn't make sense if you think about it, but the memory model's
-	intelligence is limited.)
+	The WRITE_ONCE() does not depend on the READ_ONCE(), and as a
+	result, LKMM does not claim ordering.  However, even though no
+	dependency is present, the WRITE_ONCE() will not be executed before
+	the READ_ONCE().  There are two reasons for this:
+
+                The presence of the smp_mb() in one of the branches
+                prevents the compiler from moving the WRITE_ONCE()
+                up before the "if" statement, since the compiler has
+                to assume that r1 will sometimes be 0 (but see the
+                comment below);
+
+                CPUs do not execute stores before po-earlier conditional
+                branches, even in cases where the store occurs after the
+                two arms of the branch have recombined.
+
+	It is clear that it is not dangerous in the slightest for LKMM to
+	make weaker guarantees than architectures.  In fact, it is
+	desirable, as it gives compilers room for making optimizations.
+	For instance, suppose that a 0 value in r1 would trigger undefined
+	behavior elsewhere.  Then a clever compiler might deduce that r1
+	can never be 0 in the if condition.  As a result, said clever
+	compiler might deem it safe to optimize away the smp_mb(),
+	eliminating the branch and any ordering an architecture would
+	guarantee otherwise.
 
 2.	Multiple access sizes for a single variable are not supported,
 	and neither are misaligned or partially overlapping accesses.
-- 
2.31.1.189.g2e36527f23

