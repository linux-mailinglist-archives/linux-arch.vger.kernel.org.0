Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A882F223294
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 06:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgGQEp4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 00:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQEp4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jul 2020 00:45:56 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E66952071A;
        Fri, 17 Jul 2020 04:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594961155;
        bh=2d9QmkmWrAR4QgerUk4A9L+J8tlPTeoVoUmhc6Of+hM=;
        h=From:To:Cc:Subject:Date:From;
        b=SERugfeU3gZ8i8FENUn2s6y6Zh3X0wlF6xeSmAdyIe0xy1genwn9EdD/xjO6LMogx
         9fHBbceh9pNb0bSIOqEXAfLoJet26PdioE7glSYpCRZ3igepH3zhPrqppLDktS+kN+
         K1DPdxXI/7kDPq6rl1R3Ee8BGRU4vOUrMYiJBXRU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] tools/memory-model: document the "one-time init" pattern
Date:   Thu, 16 Jul 2020 21:44:27 -0700
Message-Id: <20200717044427.68747-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The "one-time init" pattern is implemented incorrectly in various places
in the kernel.  And when people do try to implement it correctly, it is
unclear what to use.  Try to give some proper guidance.

This is motivated by the discussion at
https://lkml.kernel.org/linux-fsdevel/20200713033330.205104-1-ebiggers@kernel.org/T/#u
regarding fixing the initialization of super_block::s_dio_done_wq.

Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tools/memory-model/Documentation/recipes.txt | 151 +++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index 7fe8d7aa3029..04beb06dbfc7 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -519,6 +519,157 @@ CPU1 puts the waiting task to sleep and CPU0 fails to wake it up.
 
 Note that use of locking can greatly simplify this pattern.
 
+One-time init
+-------------
+
+The "one-time init" pattern is when multiple tasks can race to
+initialize the same data structure(s) on first use.
+
+In many cases, it's best to just avoid the need for this by simply
+initializing the data ahead of time.
+
+But in cases where the data would often go unused, one-time init can be
+appropriate to avoid wasting kernel resources.  It can also be
+appropriate if the initialization has other prerequisites which preclude
+it being done ahead of time.
+
+First, consider if your data has (a) global or static scope, (b) can be
+initialized from atomic context, and (c) cannot fail to be initialized.
+If all of those apply, just use DO_ONCE() from <linux/once.h>:
+
+	DO_ONCE(func);
+
+If that doesn't apply, you'll have to implement one-time init yourself.
+
+The simplest implementation just uses a mutex and an 'inited' flag.
+This implementation should be used where feasible:
+
+	static bool foo_inited;
+	static DEFINE_MUTEX(foo_init_mutex);
+
+	int init_foo_if_needed(void)
+	{
+		int err = 0;
+
+		mutex_lock(&foo_init_mutex);
+		if (!foo_inited) {
+			err = init_foo();
+			if (err == 0)
+				foo_inited = true;
+		}
+		mutex_unlock(&foo_init_mutex);
+		return err;
+	}
+
+The above example uses static variables, but this solution also works
+for initializing something that is part of another data structure.  The
+mutex may still be static.
+
+In where cases where taking the mutex in the "already initialized" case
+presents scalability concerns, the implementation can be optimized to
+check the 'inited' flag outside the mutex.  Unfortunately, this
+optimization is often implemented incorrectly by using a plain load.
+That violates the memory model and may result in unpredictable behavior.
+
+A correct implementation is:
+
+	static bool foo_inited;
+	static DEFINE_MUTEX(foo_init_mutex);
+
+	int init_foo_if_needed(void)
+	{
+		int err = 0;
+
+		/* pairs with smp_store_release() below */
+		if (smp_load_acquire(&foo_inited))
+			return 0;
+
+		mutex_lock(&foo_init_mutex);
+		if (!foo_inited) {
+			err = init_foo();
+			if (err == 0) /* pairs with smp_load_acquire() above */
+				smp_store_release(&foo_inited, true);
+		}
+		mutex_unlock(&foo_init_mutex);
+		return err;
+	}
+
+If only a single data structure is being initialized, then the pointer
+itself can take the place of the 'inited' flag:
+
+	static struct foo *foo;
+	static DEFINE_MUTEX(foo_init_mutex);
+
+	int init_foo_if_needed(void)
+	{
+		int err = 0;
+
+		/* pairs with smp_store_release() below */
+		if (smp_load_acquire(&foo))
+			return 0;
+
+		mutex_lock(&foo_init_mutex);
+		if (!foo) {
+			struct foo *p = alloc_foo();
+
+			if (p) /* pairs with smp_load_acquire() above */
+				smp_store_release(&foo, p);
+			else
+				err = -ENOMEM;
+		}
+		mutex_unlock(&foo_init_mutex);
+		return err;
+	}
+
+There are also cases in which the smp_load_acquire() can be replaced by
+the more lightweight READ_ONCE().  (smp_store_release() is still
+required.)  Specifically, if all initialized memory is transitively
+reachable from the pointer itself, then there is no control dependency
+so the data dependency barrier provided by READ_ONCE() is sufficient.
+
+However, using the READ_ONCE() optimization is discouraged for
+nontrivial data structures, as it can be difficult to determine if there
+is a control dependency.  For complex data structures it may depend on
+internal implementation details of other kernel subsystems.
+
+For the single-pointer case, a further optimized implementation
+eliminates the mutex and instead uses compare-and-exchange:
+
+	static struct foo *foo;
+
+	int init_foo_if_needed(void)
+	{
+		struct foo *p;
+
+		/* pairs with successful cmpxchg_release() below */
+		if (smp_load_acquire(&foo))
+			return 0;
+
+		p = alloc_foo();
+		if (!p)
+			return -ENOMEM;
+
+		/* on success, pairs with smp_load_acquire() above and below */
+		if (cmpxchg_release(&foo, NULL, p) != NULL) {
+			free_foo(p);
+			/* pairs with successful cmpxchg_release() above */
+			smp_load_acquire(&foo);
+		}
+		return 0;
+	}
+
+Note that when the cmpxchg_release() fails due to another task already
+having done it, a second smp_load_acquire() is required, since we still
+need to acquire the data that the other task released.  You may be
+tempted to upgrade cmpxchg_release() to cmpxchg() with the goal of it
+acting as both ACQUIRE and RELEASE, but that doesn't work here because
+cmpxchg() only guarantees memory ordering if it succeeds.
+
+Because of the above subtlety, the version with the mutex instead of
+cmpxchg_release() should be preferred, except potentially in cases where
+it is difficult to provide anything other than a global mutex and where
+the one-time data is part of a frequently allocated structure.  In that
+case, a global mutex might present scalability concerns.
 
 Rules of thumb
 ==============
-- 
2.27.0

