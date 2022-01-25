Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0863149BA76
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jan 2022 18:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbiAYRgN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jan 2022 12:36:13 -0500
Received: from mail-out1.in.tum.de ([131.159.0.8]:55806 "EHLO
        mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378673AbiAYRfS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jan 2022 12:35:18 -0500
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 12:35:17 EST
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mail-out1.informatik.tu-muenchen.de (Postfix) with ESMTP id 52A5B2400D3;
        Tue, 25 Jan 2022 18:29:30 +0100 (CET)
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 4EFA85A1; Tue, 25 Jan 2022 18:29:30 +0100 (CET)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 2CF6F591;
        Tue, 25 Jan 2022 18:29:30 +0100 (CET)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 2905A585;
        Tue, 25 Jan 2022 18:29:30 +0100 (CET)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 2598D4A03D1; Tue, 25 Jan 2022 18:29:30 +0100 (CET)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id BFD324A00C7;
        Tue, 25 Jan 2022 18:29:29 +0100 (CET)
        (Extended-Queue-bit xtech_ed@fff.in.tum.de)
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
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Subject: [PATCH] tools/memory-model: Clarify syntactic and semantic dependencies
Date:   Tue, 25 Jan 2022 17:28:19 +0000
Message-Id: <20220125172819.3087760-1-paul.heidekrueger@in.tum.de>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dependencies which are purely syntactic, i.e. not semantic, might imply
ordering at first glance. However, since they do not affect defined
behavior, compilers are within their rights to remove such dependencies
when optimizing code.

Since syntactic dependencies are not related to any kind of dependency
in particular, explicitly distinguish syntactic and semantic
dependencies as part of the 'A WARNING' section in explanation.txt,
which gives examples of how compilers might affect the LKMM's dependency
orderings in general.

Link: https://lore.kernel.org/all/20211102190138.GA1497378@rowland.harvard.edu/
Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
Cc: Marco Elver <elver@google.com>
Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
---
 .../Documentation/explanation.txt             | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 5d72f3112e56..6d679e5ebdf9 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -411,6 +411,31 @@ Given this version of the code, the LKMM would predict that the load
 from x could be executed after the store to y.  Thus, the memory
 model's original prediction could be invalidated by the compiler.
 
+Caution is also advised when dependencies are purely syntactic, i.e.
+not semantic.  A dependency between two marked accesses is purely
+syntactic iff the defined behavior of the second access is unaffected
+by its dependency.
+
+Compilers are aware of syntactic dependencies and are within their
+rights to remove them as part of optimizations, thereby breaking any
+guarantees of ordering.
+
+Notable cases are dependencies eliminated through constant propagation
+or those where only one value leads to defined behavior as in the
+following example:
+
+	int a[1];
+	int i;
+
+	r1 = READ_ONCE(i);
+	r2 = READ_ONCE(a[r1]);
+
+The formal LKMM is unaware of syntactic dependencies and therefore
+predicts ordering.  However, since any other value than 0 for r1 would
+result in an out-of-bounds access, which is undefined behavior, r2 is
+not affected by its dependency to r1, making the above a purely
+syntactic dependency.
+
 Another issue arises from the fact that in C, arguments to many
 operators and function calls can be evaluated in any order.  For
 example:
-- 
2.33.1

