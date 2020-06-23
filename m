Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F8D204641
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 02:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbgFWAwz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 20:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732388AbgFWAwf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 20:52:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B86C2083E;
        Tue, 23 Jun 2020 00:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873555;
        bh=UwqLbPyoEJG5AkPmX45IhP98B37FqbQTLZHyPLb3D7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hBZxIRIN3ZcvB+LFdMmwG/gJ3HWD19an84P0ak15Prt99qqX4ho/dfpKdbLKmyAR8
         4GP9/1qQTA+z8A0RuQ/gkm8Yrlk53wMvJzKaS9jvoVkh1BKjXNTsfmqJpVdPH34yVr
         NEefUYo3lVbPI04uZ4xvlstoyCGts/ZmhLvaeD18=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/14] Documentation/litmus-tests: Merge atomic's README into top-level one
Date:   Mon, 22 Jun 2020 17:52:28 -0700
Message-Id: <20200623005231.27712-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623005152.GA27459@paulmck-ThinkPad-P72>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Akira Yokosawa <akiyks@gmail.com>

Where Documentation/litmus-tests/README lists RCU litmus tests,
Documentation/litmus-tests/atomic/README lists atomic litmus tests.
For symmetry, merge the latter into former, with some context
adjustment in the introduction.

Acked-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/litmus-tests/README        | 19 +++++++++++++++++++
 Documentation/litmus-tests/atomic/README | 16 ----------------
 2 files changed, 19 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/litmus-tests/atomic/README

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index c4307ea..ac0b270 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -2,6 +2,25 @@
 LITMUS TESTS
 ============
 
+Each subdirectory contains litmus tests that are typical to describe the
+semantics of respective kernel APIs.
+For more information about how to "run" a litmus test or how to generate
+a kernel test module based on a litmus test, please see
+tools/memory-model/README.
+
+
+atomic (/atomic derectory)
+--------------------------
+
+Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
+    Test that an atomic RMW followed by a smp_mb__after_atomic() is
+    stronger than a normal acquire: both the read and write parts of
+    the RMW are ordered before the subsequential memory accesses.
+
+Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
+    Test that atomic_set() cannot break the atomicity of atomic RMWs.
+
+
 RCU (/rcu directory)
 --------------------
 
diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
deleted file mode 100644
index 714cf93..0000000
--- a/Documentation/litmus-tests/atomic/README
+++ /dev/null
@@ -1,16 +0,0 @@
-This directory contains litmus tests that are typical to describe the semantics
-of our atomic APIs. For more information about how to "run" a litmus test or
-how to generate a kernel test module based on a litmus test, please see
-tools/memory-model/README.
-
-============
-LITMUS TESTS
-============
-
-Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
-	Test that an atomic RMW followed by a smp_mb__after_atomic() is
-	stronger than a normal acquire: both the read and write parts of
-	the RMW are ordered before the subsequential memory accesses.
-
-Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
-	Test that atomic_set() cannot break the atomicity of atomic RMWs.
-- 
2.9.5

