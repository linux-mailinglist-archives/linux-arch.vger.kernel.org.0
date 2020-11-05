Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266AB2A8961
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 23:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbgKEWAV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 17:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbgKEWAU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Nov 2020 17:00:20 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D85192080D;
        Thu,  5 Nov 2020 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604613620;
        bh=lIFA0bAw3Q75uj8xTs8lt9NHPCzwjMUIirOE5Fl2nV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrBFLhdHXWaTenk3njYyeUbFUZBxPPwIJP8dQmue2GTGvwwDCXsgGvKpWIlK0CpuF
         /64n64tAYUMhVoyvI8NbvfHREgnsLtL4tdz5PdN72zrz5eXKerW3KnpbjJc3YYLK4e
         NkhCT0RKWz4RqA9JUAepy1gjpA7NoDRyM0sBFcJU=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 1/8] tools: memory-model: Document that the LKMM can easily miss control dependencies
Date:   Thu,  5 Nov 2020 14:00:10 -0800
Message-Id: <20201105220017.15410-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105215953.GA15309@paulmck-ThinkPad-P72>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

Add a small section to the litmus-tests.txt documentation file for
the Linux Kernel Memory Model explaining that the memory model often
fails to recognize certain control dependencies.

Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/litmus-tests.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
index 2f840dc..8a9d5d2 100644
--- a/tools/memory-model/Documentation/litmus-tests.txt
+++ b/tools/memory-model/Documentation/litmus-tests.txt
@@ -946,6 +946,23 @@ Limitations of the Linux-kernel memory model (LKMM) include:
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
 
-- 
2.9.5

