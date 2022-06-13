Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5BB5498F6
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 18:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386859AbiFMPPP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387207AbiFMPNv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 11:13:51 -0400
Received: from mailout1.rbg.tum.de (mailout1.rbg.tum.de [131.159.0.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AABB6E;
        Mon, 13 Jun 2022 05:28:25 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mailout1.rbg.tum.de (Postfix) with ESMTPS id 895E54D;
        Mon, 13 Jun 2022 14:28:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1655123300;
        bh=Fy/GQ0kuNY2dgt6/NaElsORQBYUxRHvsByxnFzQadfw=;
        h=From:To:Cc:Subject:Date:From;
        b=qm01H+Guv33t7GmzpIwNun8w0ScI8wczrt31RkjIBbbD+NR+ViDZnnRkHphKSyqle
         iaq+2v8W6y8gapcRjwZj64HYNe4C4KuM3GzAjoK/gcfK9uKFzTuZBg9bQruSiNohPD
         KyVLlSyAc/JcNv7aU3W8s5EQyyXXYXU2m9M2HMc85r6xQ1c4wmnsRCx4VX0N2nbovj
         Izs50u97ViKHQaGWmaLtlKzc3uak2ptoyMQvw6Ctf4f37VwzOrlT3CmdjTSSRGxTH9
         /fpTuYaskC2WD6Li/64gqcWpwlYoE8nUMF6yzyrOhSSjrk2ZRnIYK/n6NwKGhpWde8
         yO6Q0osrw6cFQ==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 846E428B; Mon, 13 Jun 2022 14:28:20 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 527C428A;
        Mon, 13 Jun 2022 14:28:20 +0200 (CEST)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 47EB4286;
        Mon, 13 Jun 2022 14:28:20 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 411744A03AB; Mon, 13 Jun 2022 14:28:20 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id CE83B4A02E6;
        Mon, 13 Jun 2022 14:28:19 +0200 (CEST)
        (Extended-Queue-bit xtech_cr@fff.in.tum.de)
From:   =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: [PATCH] tools/memory-model: Clarify LKMM's limitations in litmus-tests.txt
Date:   Mon, 13 Jun 2022 12:27:44 +0000
Message-Id: <20220613122744.373516-1-paul.heidekrueger@in.tum.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As discussed, clarify LKMM not recognizing certain kinds of orderings.
In particular, highlight the fact that LKMM might deliberately make
weaker guarantees than compilers and architectures.

Link: https://lore.kernel.org/all/YpoW1deb%2FQeeszO1@ethstick13.dse.in.tum.de/T/#u
Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
Cc: Marco Elver <elver@google.com>
Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
Cc: Martin Fink <martin.fink@in.tum.de>
---
 .../Documentation/litmus-tests.txt            | 29 ++++++++++++-------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
index 8a9d5d2787f9..623059eff84e 100644
--- a/tools/memory-model/Documentation/litmus-tests.txt
+++ b/tools/memory-model/Documentation/litmus-tests.txt
@@ -946,22 +946,31 @@ Limitations of the Linux-kernel memory model (LKMM) include:
 	carrying a dependency, then the compiler can break that dependency
 	by substituting a constant of that value.
 
-	Conversely, LKMM sometimes doesn't recognize that a particular
-	optimization is not allowed, and as a result, thinks that a
-	dependency is not present (because the optimization would break it).
-	The memory model misses some pretty obvious control dependencies
-	because of this limitation.  A simple example is:
+	Conversely, LKMM will sometimes overstate the amount of reordering
+	done by architectures and compilers, leading it to missing some
+	pretty obvious orderings.  A simple example is:
 
 		r1 = READ_ONCE(x);
 		if (r1 == 0)
 			smp_mb();
 		WRITE_ONCE(y, 1);
 
-	There is a control dependency from the READ_ONCE to the WRITE_ONCE,
-	even when r1 is nonzero, but LKMM doesn't realize this and thinks
-	that the write may execute before the read if r1 != 0.  (Yes, that
-	doesn't make sense if you think about it, but the memory model's
-	intelligence is limited.)
+	There is no dependency from the WRITE_ONCE() to the READ_ONCE(),
+	and as a result, LKMM does not assume ordering.  However, the
+	smp_mb() in the if branch will prevent architectures from
+	reordering the WRITE_ONCE() ahead of the READ_ONCE() but only if r1
+	is 0.  This, by definition, is not a control dependency, yet
+	ordering is guaranteed in some cases, depending on the READ_ONCE(),
+	which LKMM doesn't recognize.
+
+	It is clear that it is not dangerous in the slightest for LKMM to
+	make weaker guarantees than architectures.  In fact, it is
+	desirable, as it gives compilers room for making optimizations.
+	For instance, because a value of 0 triggers undefined behavior
+	elsewhere, a clever compiler might deduce that r1 can never be 0 in
+	the if condition.  As a result, said clever compiler might deem it
+	safe to optimize away the smp_mb(), eliminating the branch and
+	any ordering an architecture would guarantee otherwise.
 
 2.	Multiple access sizes for a single variable are not supported,
 	and neither are misaligned or partially overlapping accesses.
-- 
2.35.1

