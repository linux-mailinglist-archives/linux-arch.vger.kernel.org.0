Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103E6465B6A
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 01:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354643AbhLBAyl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Dec 2021 19:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbhLBAyj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Dec 2021 19:54:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62EFC061748;
        Wed,  1 Dec 2021 16:51:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 79B38CE2079;
        Thu,  2 Dec 2021 00:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4665C00446;
        Thu,  2 Dec 2021 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638406273;
        bh=a3TZYdz2Z8fwcDIg3kbsL1+jsy0L1ksMQY3QtehlESA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N53IlzFhkbJm0Ufhv915xQ5P3720+l8rJmfb1axCs8XZ2DaL7Mt4bsXhTqL3Uf00d
         qjVAoVSL7RRhSlJjgwnoz2jMRQk5pp8DV9HQHjDJFoTenOXzwGHeKJNX3NS7hCJNc2
         hh0+Pm4UnN2ZBzoyB66aVrCpie5/TH5Hz3ye+YHRkobfwFkU08PJhDHZRSWh4gb69Y
         VOFeGo6LK8slI8yZVfxFSsh67Vr59QKDnsAxmOW3NBn8WkMPxTMeBUXV4x1kJcb8BJ
         1XF6s84rKlj9yg8XTNi5xGlrRl/burREqLmNpnW/TtpDpsd86Md5/lLmBvBepVDDEa
         V5yZRXgJDCl9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6A6C35C0FCD; Wed,  1 Dec 2021 16:51:13 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 1/3] tools/memory-model: Provide extra ordering for unlock+lock pair on the same CPU
Date:   Wed,  1 Dec 2021 16:50:51 -0800
Message-Id: <20211202005053.3131071-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202005027.GA3130970@paulmck-ThinkPad-P17-Gen-1>
References: <20211202005027.GA3130970@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

A recent discussion[1] shows that we are in favor of strengthening the
ordering of unlock + lock on the same CPU: a unlock and a po-after lock
should provide the so-called RCtso ordering, that is a memory access S
po-before the unlock should be ordered against a memory access R
po-after the lock, unless S is a store and R is a load.

The strengthening meets programmers' expection that "sequence of two
locked regions to be ordered wrt each other" (from Linus), and can
reduce the mental burden when using locks. Therefore add it in LKMM.

[1]: https://lore.kernel.org/lkml/20210909185937.GA12379@rowland.harvard.edu/

Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com> (RISC-V)
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Documentation/explanation.txt             | 44 +++++++++++--------
 tools/memory-model/linux-kernel.cat           |  6 +--
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 5d72f3112e565..394ee57d58f2f 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1813,15 +1813,16 @@ spin_trylock() -- we can call these things lock-releases and
 lock-acquires -- have two properties beyond those of ordinary releases
 and acquires.
 
-First, when a lock-acquire reads from a lock-release, the LKMM
-requires that every instruction po-before the lock-release must
-execute before any instruction po-after the lock-acquire.  This would
-naturally hold if the release and acquire operations were on different
-CPUs, but the LKMM says it holds even when they are on the same CPU.
-For example:
+First, when a lock-acquire reads from or is po-after a lock-release,
+the LKMM requires that every instruction po-before the lock-release
+must execute before any instruction po-after the lock-acquire.  This
+would naturally hold if the release and acquire operations were on
+different CPUs and accessed the same lock variable, but the LKMM says
+it also holds when they are on the same CPU, even if they access
+different lock variables.  For example:
 
 	int x, y;
-	spinlock_t s;
+	spinlock_t s, t;
 
 	P0()
 	{
@@ -1830,9 +1831,9 @@ For example:
 		spin_lock(&s);
 		r1 = READ_ONCE(x);
 		spin_unlock(&s);
-		spin_lock(&s);
+		spin_lock(&t);
 		r2 = READ_ONCE(y);
-		spin_unlock(&s);
+		spin_unlock(&t);
 	}
 
 	P1()
@@ -1842,10 +1843,10 @@ For example:
 		WRITE_ONCE(x, 1);
 	}
 
-Here the second spin_lock() reads from the first spin_unlock(), and
-therefore the load of x must execute before the load of y.  Thus we
-cannot have r1 = 1 and r2 = 0 at the end (this is an instance of the
-MP pattern).
+Here the second spin_lock() is po-after the first spin_unlock(), and
+therefore the load of x must execute before the load of y, even though
+the two locking operations use different locks.  Thus we cannot have
+r1 = 1 and r2 = 0 at the end (this is an instance of the MP pattern).
 
 This requirement does not apply to ordinary release and acquire
 fences, only to lock-related operations.  For instance, suppose P0()
@@ -1872,13 +1873,13 @@ instructions in the following order:
 
 and thus it could load y before x, obtaining r2 = 0 and r1 = 1.
 
-Second, when a lock-acquire reads from a lock-release, and some other
-stores W and W' occur po-before the lock-release and po-after the
-lock-acquire respectively, the LKMM requires that W must propagate to
-each CPU before W' does.  For example, consider:
+Second, when a lock-acquire reads from or is po-after a lock-release,
+and some other stores W and W' occur po-before the lock-release and
+po-after the lock-acquire respectively, the LKMM requires that W must
+propagate to each CPU before W' does.  For example, consider:
 
 	int x, y;
-	spinlock_t x;
+	spinlock_t s;
 
 	P0()
 	{
@@ -1908,7 +1909,12 @@ each CPU before W' does.  For example, consider:
 
 If r1 = 1 at the end then the spin_lock() in P1 must have read from
 the spin_unlock() in P0.  Hence the store to x must propagate to P2
-before the store to y does, so we cannot have r2 = 1 and r3 = 0.
+before the store to y does, so we cannot have r2 = 1 and r3 = 0.  But
+if P1 had used a lock variable different from s, the writes could have
+propagated in either order.  (On the other hand, if the code in P0 and
+P1 had all executed on a single CPU, as in the example before this
+one, then the writes would have propagated in order even if the two
+critical sections used different lock variables.)
 
 These two special requirements for lock-release and lock-acquire do
 not arise from the operational model.  Nevertheless, kernel developers
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 2a9b4fe4a84eb..d70315fddef6e 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -27,7 +27,7 @@ include "lock.cat"
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
+let po-unlock-lock-po = po ; [UL] ; (po|rf) ; [LKR] ; po
 
 (* Fences *)
 let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
@@ -70,12 +70,12 @@ let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
 let to-r = addr | (dep ; [Marked] ; rfi)
-let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
+let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = (rfe ; [Marked])? ; r
 let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
-	po-unlock-rf-lock-po) ; [Marked]
+	po-unlock-lock-po) ; [Marked]
 let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
 	[Marked] ; rfe? ; [Marked]
 
-- 
2.31.1.189.g2e36527f23

