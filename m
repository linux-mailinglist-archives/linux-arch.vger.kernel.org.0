Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880882A8963
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 23:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbgKEWAY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 17:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732465AbgKEWAW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Nov 2020 17:00:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EA6F2151B;
        Thu,  5 Nov 2020 22:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604613620;
        bh=Up52Q1K7/+brv94YlcU1TNDnPoGhSsz9VZcOjgOZ938=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/sHE6BBhsFBmc/O/MDUOuA6bfYME/vE5MFbshxDakCMS/qtT3N188WPjQ5XiIJFp
         BU1cOdsEkBSgJ79p88jABHTp7uewP/IgDYAgYwxjO0MiCyc72x0qRZWj04fyXanY9U
         KGpxnt0PaQNB29h4E82GVWb1Kc8MjT9XWztkj1NA=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 2/8] tools/memory-model: Move Documentation description to Documentation/README
Date:   Thu,  5 Nov 2020 14:00:11 -0800
Message-Id: <20201105220017.15410-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105215953.GA15309@paulmck-ThinkPad-P72>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
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
 tools/memory-model/Documentation/README | 59 +++++++++++++++++++++++++++++++++
 tools/memory-model/README               | 22 ++----------
 2 files changed, 61 insertions(+), 20 deletions(-)
 create mode 100644 tools/memory-model/Documentation/README

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
new file mode 100644
index 0000000..2d9539f
--- /dev/null
+++ b/tools/memory-model/Documentation/README
@@ -0,0 +1,59 @@
+It has been said that successful communication requires first identifying
+what your audience knows and then building a bridge from their current
+knowledge to what they need to know.  Unfortunately, the expected
+Linux-kernel memory model (LKMM) audience might be anywhere from novice
+to expert both in kernel hacking and in understanding LKMM.
+
+This document therefore points out a number of places to start reading,
+depending on what you know and what you would like to learn.  Please note
+that the documents later in this list assume that the reader understands
+the material provided by documents earlier in this list.
+
+o	You are new to Linux-kernel concurrency: simple.txt
+
+o	You are familiar with the Linux-kernel concurrency primitives
+	that you need, and just want to get started with LKMM litmus
+	tests:  litmus-tests.txt
+
+o	You are familiar with Linux-kernel concurrency, and would
+	like a detailed intuitive understanding of LKMM, including
+	situations involving more than two threads:  recipes.txt
+
+o	You are familiar with Linux-kernel concurrency and the use of
+	LKMM, and would like a quick reference:  cheatsheet.txt
+
+o	You are familiar with Linux-kernel concurrency and the use
+	of LKMM, and would like to learn about LKMM's requirements,
+	rationale, and implementation:	explanation.txt
+
+o	You are interested in the publications related to LKMM, including
+	hardware manuals, academic literature, standards-committee
+	working papers, and LWN articles:  references.txt
+
+
+====================
+DESCRIPTION OF FILES
+====================
+
+README
+	This file.
+
+cheatsheet.txt
+	Quick-reference guide to the Linux-kernel memory model.
+
+explanation.txt
+	Detailed description of the memory model.
+
+litmus-tests.txt
+	The format, features, capabilities, and limitations of the litmus
+	tests that LKMM can evaluate.
+
+recipes.txt
+	Common memory-ordering patterns.
+
+references.txt
+	Background information.
+
+simple.txt
+	Starting point for someone new to Linux-kernel concurrency.
+	And also a reminder of the simpler approaches to concurrency!
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

