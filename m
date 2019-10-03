Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE4C95C0
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfJCA2J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729653AbfJCA06 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 615B822467;
        Thu,  3 Oct 2019 00:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062417;
        bh=lji1O79dCLeV+Le2dri/vm/KuvNJvYDQFHC560GTvig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYUsEUr9HrLmhk7KOf72LGirG9s/P9QkMsSOxG1auiY7jex+xqNMZF4TU0e/ChOMD
         KxA+0PBeXvoe3AcpnEEfiBSjvOSPqLT9DWbukpDVKST/eO0+4Zy/RKzDTyei2A3UQU
         WjE3KEq2YET9qxyKR8q0qNpi/Np5/rMJzCgXe5WQ=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 18/32] tools/memory-model: Move from .AArch64.litmus.out to .litmus.AArch.out
Date:   Wed,  2 Oct 2019 17:26:36 -0700
Message-Id: <20191003002650.11249-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

When the github scripts see ".litmus.out", they assume that there must be
a corresponding C-language ".litmus" file.  Won't they be disappointed
when they instead see nothing, or, worse yet, the corresponding
assembly-language litmus test?  This commit therefore swaps the hardware
tag with the "litmus" to avoid this sort of disappointment.

This commit also adjusts the .gitignore file so as to avoid adding these
new ".out" files to git.

[ paulmck: Apply Akira Yokosawa feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/litmus-tests/.gitignore | 2 +-
 tools/memory-model/scripts/judgelitmus.sh  | 4 ++--
 tools/memory-model/scripts/runlitmus.sh    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/memory-model/litmus-tests/.gitignore b/tools/memory-model/litmus-tests/.gitignore
index 6e2ddc54..f47cb20 100644
--- a/tools/memory-model/litmus-tests/.gitignore
+++ b/tools/memory-model/litmus-tests/.gitignore
@@ -1 +1 @@
-*.litmus.out
+*.out
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index fe9131f..9abda72 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -6,7 +6,7 @@
 # test ran correctly.  If the --hw argument is omitted, check against the
 # LKMM output, which is assumed to be in file.litmus.out.  If this argument
 # is provided, this is assumed to be a hardware test, and the output is
-# assumed to be in file.HW.litmus.out, where "HW" is the --hw argument.
+# assumed to be in file.litmus.HW.out, where "HW" is the --hw argument.
 # In addition, non-Sometimes verification results will be noted, but
 # forgiven.  Furthermore, if there is no "Result:" comment but there is
 # an LKMM .litmus.out file, the observation in that file will be used
@@ -37,7 +37,7 @@ then
 	lkmmout=
 else
 	litmusout="`echo $litmus |
-		sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`.out"
+		sed -e 's/\.litmus$/.litmus.'${LKMM_HW_MAP_FILE}'/'`.out"
 	lkmmout=$litmus.out
 fi
 if test -f "$LKMM_DESTDIR/$litmusout" -a -r "$LKMM_DESTDIR/$litmusout"
diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index 2865a96..c84124b 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -57,7 +57,7 @@ catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
 mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
 themefile="$T/${LKMM_HW_MAP_FILE}.theme"
 herdoptions="-model $LKMM_HW_CAT_FILE"
-hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
+hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.litmus.'${LKMM_HW_MAP_FILE}'/'`
 hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
 
 # Don't run on litmus tests with complex synchronization
-- 
2.9.5

