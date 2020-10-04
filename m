Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032962827DB
	for <lists+linux-arch@lfdr.de>; Sun,  4 Oct 2020 03:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgJDBkX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 21:40:23 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41833 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726114AbgJDBkX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 21:40:23 -0400
Received: (qmail 332975 invoked by uid 1000); 3 Oct 2020 21:40:22 -0400
Date:   Sat, 3 Oct 2020 21:40:22 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH] tools: memory-model: Document that the LKMM can easily miss
 control dependencies
Message-ID: <20201004014022.GA332600@rowland.harvard.edu>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003171338.GA323226@rowland.harvard.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a small section to the litmus-tests.txt documentation file for
the Linux Kernel Memory Model explaining that the memory model often
fails to recognize certain control dependencies.

Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

 tools/memory-model/Documentation/litmus-tests.txt |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: usb-devel/tools/memory-model/Documentation/litmus-tests.txt
===================================================================
--- usb-devel.orig/tools/memory-model/Documentation/litmus-tests.txt
+++ usb-devel/tools/memory-model/Documentation/litmus-tests.txt
@@ -946,6 +946,23 @@ Limitations of the Linux-kernel memory m
 	carrying a dependency, then the compiler can break that dependency
 	by substituting a constant of that value.
 
+	Conversely, LKMM sometimes doesn't recognize that a particular
+	optimization is not allowed, and as a result, thinks that a
+	dependency is not present (because the optimization would break it).
+	The memory model misses some pretty obvious control dependencies
+	because of this limitation.  A simple example is:
+
+		r1 = READ_ONCE(x);
+		if (r1 == 0)
+			smp_mb();
+		WRITE_ONCE(y, 1);
+
+	There is a control dependency from the READ_ONCE to the WRITE_ONCE,
+	even when r1 is nonzero, but LKMM doesn't realize this and thinks
+	that the write may execute before the read if r1 != 0.  (Yes, that
+	doesn't make sense if you think about it, but the memory model's
+	intelligence is limited.)
+
 2.	Multiple access sizes for a single variable are not supported,
 	and neither are misaligned or partially overlapping accesses.
 
