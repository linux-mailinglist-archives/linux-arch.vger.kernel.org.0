Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E964A54B512
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343667AbiFNPtZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 11:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343759AbiFNPtX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 11:49:23 -0400
X-Greylist: delayed 98454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 08:49:18 PDT
Received: from mailout1.rbg.tum.de (mailout1.rbg.tum.de [IPv6:2a09:80c0::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9530F2EA14
        for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2022 08:49:17 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [IPv6:2a09:80c0:254::14])
        by mailout1.rbg.tum.de (Postfix) with ESMTPS id 501D6B1B;
        Tue, 14 Jun 2022 17:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1655221754;
        bh=1YhOTVDbcaz5aNnY1gjxQfdQ/am6Ukomt+EudTq2P2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MnPhEdQqyQ1dj/LdIOb1/ik+eBP2cXlELw5VAJ4ZScoIVFbkwpvTRn4lRYr9nd95z
         bpi6zH4cmJ97p4VIqa5mB0GIttqcjxsuTSiO+aIXn1VSnSIEXP7h3cyFw2XsZAcj+m
         lTguT6BeX1U1HrhmptlwHBWZFb294oWbroWDzjeHypXsZzZHDFzEZvJYXqWRF/Wktp
         Sls1uXGCT1+n6uKXHFwOYWNp41+59ziA9diqr+Xolumj0ybiuw47RUBp0qq9Tt7elg
         LoyBZwSwT5TZQi1GnEiKcTFWcgBrIJZ6i0c5w/Tuao76wl5F5LahW+IjfrJjw7MiQZ
         Hw02rTSxcCSDQ==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 4C06C28B; Tue, 14 Jun 2022 17:49:14 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 1D39E28A;
        Tue, 14 Jun 2022 17:49:14 +0200 (CEST)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 17A50286;
        Tue, 14 Jun 2022 17:49:14 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 13CFB4A01EC; Tue, 14 Jun 2022 17:49:14 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id B21584A013B;
        Tue, 14 Jun 2022 17:49:13 +0200 (CEST)
        (Extended-Queue-bit xtech_hi@fff.in.tum.de)
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
Subject: [PATCH v2] tools/memory-model: Clarify LKMM's limitations in litmus-tests.txt
Date:   Tue, 14 Jun 2022 15:48:11 +0000
Message-Id: <20220614154812.1870099-1-paul.heidekrueger@in.tum.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Yqdb3CZ8bKtbWZ+z@rowland.harvard.edu>
References: <Yqdb3CZ8bKtbWZ+z@rowland.harvard.edu>
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
Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Marco Elver <elver@google.com>
Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
Cc: Martin Fink <martin.fink@in.tum.de>
---

v2:
- Incorporate Alan Stern's feedback.
- Add suggested text by Alan Stern to clearly state how the branch and the
  smp_mb() affect ordering.
- Add "Co-developed-by: Alan Stern <stern@rowland.harvard.edu>" based on the
  above.

 .../Documentation/litmus-tests.txt            | 37 ++++++++++++++-----
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
index 8a9d5d2787f9..cc355999815c 100644
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
2.35.1

