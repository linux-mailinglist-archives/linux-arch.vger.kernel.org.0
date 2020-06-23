Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF63420464F
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 02:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbgFWAx0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 20:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732379AbgFWAwe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 20:52:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B157207DD;
        Tue, 23 Jun 2020 00:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873554;
        bh=jjp1onkfxL2eENBHHoIekG6O8re7lZ1C80KqLCuGG6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTpiI/J5f/v8WCOCinoF1VasCdlItA88LdHOr2tTh4w+T6wHzVXVVKoAfw+fgYTPD
         jIxOdcsR+zIw0QPz971Sm7PLNpw+dbrQGJzOmhXHkcGzedKqZ5aauf6cF0P+4ihsFH
         1TfBoJ3dgyIL3o0BKv2oxsfV0SKwt68DrsWfVN4o=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/14] tools/memory-model: Add an exception for limitations on _unless() family
Date:   Mon, 22 Jun 2020 17:52:23 -0700
Message-Id: <20200623005231.27712-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623005152.GA27459@paulmck-ThinkPad-P72>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

According to Luc, atomic_add_unless() is directly provided by herd7,
therefore it can be used in litmus tests. So change the limitation
section in README to unlimit the use of atomic_add_unless().

Cc: Luc Maranget <luc.maranget@inria.fr>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/README | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index fc07b52..b9c562e 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -207,11 +207,15 @@ The Linux-kernel memory model (LKMM) has the following limitations:
 		case as a store release.
 
 	b.	The "unless" RMW operations are not currently modeled:
-		atomic_long_add_unless(), atomic_add_unless(),
-		atomic_inc_unless_negative(), and
-		atomic_dec_unless_positive().  These can be emulated
+		atomic_long_add_unless(), atomic_inc_unless_negative(),
+		and atomic_dec_unless_positive().  These can be emulated
 		in litmus tests, for example, by using atomic_cmpxchg().
 
+		One exception of this limitation is atomic_add_unless(),
+		which is provided directly by herd7 (so no corresponding
+		definition in linux-kernel.def).  atomic_add_unless() is
+		modeled by herd7 therefore it can be used in litmus tests.
+
 	c.	The call_rcu() function is not modeled.  It can be
 		emulated in litmus tests by adding another process that
 		invokes synchronize_rcu() and the body of the callback
-- 
2.9.5

