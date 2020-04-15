Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5E31AB0FD
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 21:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411771AbgDOTIM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 15:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416859AbgDOSts (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 14:49:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79726208E4;
        Wed, 15 Apr 2020 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586976587;
        bh=uX+VB0420gMf/ohkw7XASVivlF4bxxbUvzMx8QiMIUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7/ydYqmtdfmNr2OCd/urTfAO/yqTT1YNf2L0mdtXhWZGqKaprWVAm0IVl/k/EQXG
         qoQ0dqIug+srZthzrbQpP8YMb9jnFGZXJacSjSghjmplBMmAmmuXK9Yle/Ky1Hm1na
         uouBQTRgIr/guXESYGIypPmXdfxDwPoQ/dHNMIXc=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH lkmm tip/core/rcu 03/10] Documentation: LKMM: Move MP+onceassign+derefonce to new litmus-tests/rcu/
Date:   Wed, 15 Apr 2020 11:49:38 -0700
Message-Id: <20200415184945.16487-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Move MP+onceassign+derefonce to the new Documentation/litmus-tests/rcu/
directory.

More RCU-related litmus tests would be added here.

Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/litmus-tests/README                                | 9 +++++++++
 .../litmus-tests/rcu}/MP+onceassign+derefonce.litmus             | 0
 tools/memory-model/litmus-tests/README                           | 3 ---
 3 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/litmus-tests/README
 rename {tools/memory-model/litmus-tests => Documentation/litmus-tests/rcu}/MP+onceassign+derefonce.litmus (100%)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
new file mode 100644
index 0000000..84208bc
--- /dev/null
+++ b/Documentation/litmus-tests/README
@@ -0,0 +1,9 @@
+============
+LITMUS TESTS
+============
+
+RCU (/rcu directory)
+--------------------
+MP+onceassign+derefonce.litmus
+    Demonstrates that rcu_assign_pointer() and rcu_dereference() to
+    ensure that an RCU reader will not see pre-initialization garbage.
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/Documentation/litmus-tests/rcu/MP+onceassign+derefonce.litmus
similarity index 100%
rename from tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
rename to Documentation/litmus-tests/rcu/MP+onceassign+derefonce.litmus
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 681f906..79e1b1e 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -63,9 +63,6 @@ LB+poonceonces.litmus
 	As above, but with store-release replaced with WRITE_ONCE()
 	and load-acquire replaced with READ_ONCE().
 
-MP+onceassign+derefonce.litmus
-	As below, but with rcu_assign_pointer() and an rcu_dereference().
-
 MP+polockmbonce+poacquiresilsil.litmus
 	Protect the access with a lock and an smp_mb__after_spinlock()
 	in one process, and use an acquire load followed by a pair of
-- 
2.9.5

