Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5721C95CF
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfJCA0z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfJCA0x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6180222C4;
        Thu,  3 Oct 2019 00:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062412;
        bh=3Bwl5pMwocf2/uH9BRYHthWC5hMiOfpMI8VbhGrwn2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygb6MeVP21c5OFXp+lAhXEcMto81Ik0DTHHaCd6tXpGbnt44BL1tHp3QbEcXj3W5E
         gL0rK2PK2HK7VaqRaZnPkkI3XMyysWiJShoJlagGef5UehaRtqCDlAeUbWVTI4xq52
         zoKgM0M+tPE801lQ3jiH0IG1jz6ewvOoX7i8cjHE=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/32] tools/memory-model/Documentation: Fix typos in explanation.txt
Date:   Wed,  2 Oct 2019 17:26:20 -0700
Message-Id: <20191003002650.11249-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch fixes a few minor typos and improves word usage in a few
places in the Linux Kernel Memory Model's explanation.txt file.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/explanation.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 488f11f..1b52645 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -206,7 +206,7 @@ goes like this:
 	P0 stores 1 to buf before storing 1 to flag, since it executes
 	its instructions in order.
 
-	Since an instruction (in this case, P1's store to flag) cannot
+	Since an instruction (in this case, P0's store to flag) cannot
 	execute before itself, the specified outcome is impossible.
 
 However, real computer hardware almost never follows the Sequential
@@ -419,7 +419,7 @@ example:
 
 The object code might call f(5) either before or after g(6); the
 memory model cannot assume there is a fixed program order relation
-between them.  (In fact, if the functions are inlined then the
+between them.  (In fact, if the function calls are inlined then the
 compiler might even interleave their object code.)
 
 
@@ -499,7 +499,7 @@ different CPUs (external reads-from, or rfe).
 
 For our purposes, a memory location's initial value is treated as
 though it had been written there by an imaginary initial store that
-executes on a separate CPU before the program runs.
+executes on a separate CPU before the main program runs.
 
 Usage of the rf relation implicitly assumes that loads will always
 read from a single store.  It doesn't apply properly in the presence
@@ -955,7 +955,7 @@ atomic update.  This is what the LKMM's "atomic" axiom says.
 THE PRESERVED PROGRAM ORDER RELATION: ppo
 -----------------------------------------
 
-There are many situations where a CPU is obligated to execute two
+There are many situations where a CPU is obliged to execute two
 instructions in program order.  We amalgamate them into the ppo (for
 "preserved program order") relation, which links the po-earlier
 instruction to the po-later instruction and is thus a sub-relation of
@@ -1572,7 +1572,7 @@ and there are events X, Y and a read-side critical section C such that:
 
 	2. X comes "before" Y in some sense (including rfe, co and fr);
 
-	2. Y is po-before Z;
+	3. Y is po-before Z;
 
 	4. Z is the rcu_read_unlock() event marking the end of C;
 
-- 
2.9.5

