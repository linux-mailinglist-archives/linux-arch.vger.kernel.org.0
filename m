Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41582580EA
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgHaSVT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbgHaSUl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 14:20:41 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1241A2166E;
        Mon, 31 Aug 2020 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598898041;
        bh=3H82tCuC3/dhfdvmXOWKUg8hke0w7lO5dGDHziBbYz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGoAgiHSiXfdIxg/FYgM9otQ3RcvlN5dcqpoJugQTeIT4VG/GiDkoi15lgYfts9sd
         OUVs7hyhgey78qCXAVK19j4yUD2RsbNEvy066OO4cfXh6UbGA7ZqiFGY93PpHdLFdU
         rDAo567QdKn0noIUdHXFL1Xro2wKVmH32U+DiVOA=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 7/9] tools/memory-model: Move Documentation description to Documentation/README
Date:   Mon, 31 Aug 2020 11:20:35 -0700
Message-Id: <20200831182037.2034-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831182012.GA1965@paulmck-ThinkPad-P72>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit moves the descriptions of the files residing in
tools/memory-model/Documentation to a README file in that directory,
leaving behind the description of tools/memory-model/Documentation/README
itself.  After this change, tools/memory-model/Documentation/README
provides a guide to the files in the tools/memory-model/Documentation
directory, guiding people with different skills and needs to the most
appropriate starting point.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/README | 62 +++++++++++++++++++++++++++++++++
 tools/memory-model/README               | 22 ++----------
 2 files changed, 64 insertions(+), 20 deletions(-)
 create mode 100644 tools/memory-model/Documentation/README

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
new file mode 100644
index 0000000..4326603
--- /dev/null
+++ b/tools/memory-model/Documentation/README
@@ -0,0 +1,62 @@
+This file serves as the guide for the other files residing in the
+tools/memory-model/Documentation directory.  It has been said that at
+its best, communication involves identifying where the target audience
+is and then building a bridge from where they are to where they need
+to go.  Unfortunately, this time-honored approach falls short in this
+case because readers of the documents in this directory might be in any
+number of places.
+
+This document therefore describes a number of places to start reading
+the documentation in this directory, depending on what you know and what
+you would like to learn:
+
+o	You are new to Linux-kernel concurrency: simple.txt
+
+o	You are familiar with the concurrency facilities that you
+	need, and just want to get started with LKMM litmus tests:
+	litmus-tests.txt
+
+o	You are familiar with Linux-kernel concurrency, and would
+	like a detailed intuitive understanding of LKMM, including
+	situations involving more than two threads: recipes.txt
+
+o	You are familiar with Linux-kernel concurrency and the
+	use of LKMM, and would like a cheat sheet to remind you
+	of LKMM's guarantees: cheatsheet.txt
+
+o	You are familiar with Linux-kernel concurrency and the
+	use of LKMM, and would like to learn about LKMM's requirements,
+	rationale, and implementation: explanation.txt
+
+o	You are interested in the publications related to LKMM, including
+	hardware manuals, academic literature, standards-committee working
+	papers, and LWN articles: references.txt
+
+
+====================
+DESCRIPTION OF FILES
+====================
+
+Documentation/README
+	This file.
+
+Documentation/cheatsheet.txt
+	Quick-reference guide to the Linux-kernel memory model.
+
+Documentation/explanation.txt
+	Describes the memory model in detail.
+
+Documentation/litmus-tests.txt
+	Describes the format, features, capabilities, and limitations
+	of the litmus tests that LKMM can evaluate.
+
+Documentation/recipes.txt
+	Lists common memory-ordering patterns.
+
+Documentation/references.txt
+	Provides background reading.
+
+Documentation/simple.txt
+	Starting point for someone new to Linux-kernel concurrency.
+	And also for those needing a reminder of the simpler approaches
+	to concurrency!
diff --git a/tools/memory-model/README b/tools/memory-model/README
index c8144d4..39d08d1 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -161,26 +161,8 @@ running LKMM litmus tests.
 DESCRIPTION OF FILES
 ====================
 
-Documentation/cheatsheet.txt
-	Quick-reference guide to the Linux-kernel memory model.
-
-Documentation/explanation.txt
-	Describes the memory model in detail.
-
-Documentation/litmus-tests.txt
-	Describes the format, features, capabilities, and limitations
-	of the litmus tests that LKMM can evaluate.
-
-Documentation/recipes.txt
-	Lists common memory-ordering patterns.
-
-Documentation/references.txt
-	Provides background reading.
-
-Documentation/simple.txt
-	Starting point for someone new to Linux-kernel concurrency.
-	And also for those needing a reminder of the simpler approaches
-	to concurrency!
+Documentation/README
+	Guide to the other documents in the Documentation/ directory.
 
 linux-kernel.bell
 	Categorizes the relevant instructions, including memory
-- 
2.9.5

