Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781B0C95C4
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfJCA2U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729638AbfJCA05 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3869A222D1;
        Thu,  3 Oct 2019 00:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062416;
        bh=tY6P3wznUQC0vautg0ZoN2NAjmQ+5qv+4Wdjn4HApaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mh/Ud0bnWNW26T5epWgZuqdM5GV0r9QzPzH2AozNelcOXMeYMuzQmCZtM1f9QgYsk
         GRLT8Vwpsg8pegEL0GqGaywO4Tpz/7i/xXMWvqhOykSev+2/LAEwFWOV8lbzgf4J7N
         +AAPjsHpyLX2ADfLC/OAfjdR50a1Y2W7TlrccTAM=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 14/32] tools/memory-model: Hardware checking for check{,all}litmus.sh
Date:   Wed,  2 Oct 2019 17:26:32 -0700
Message-Id: <20191003002650.11249-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

This commit makes checklitmus.sh and checkalllitmus.sh check to see
if a hardware verification was specified (via the --hw command-line
argument, which sets the LKMM_HW_MAP_FILE environment variable).
If so, the C-language litmus test is converted to the specified type
of assembly-language litmus test and herd is run on it.  Hardware is
permitted to be stronger than LKMM requires, so "Always" and "Never"
verifications of "Sometimes" C-language litmus tests are forgiven.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checkalllitmus.sh | 23 ++++++++-------
 tools/memory-model/scripts/checklitmus.sh    | 42 +++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
index 54d8da8..2d3ee85 100755
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # Run herd7 tests on all .litmus files in the litmus-tests directory
@@ -8,6 +8,11 @@
 # "^^^".  It also outputs verification results to a file whose name is
 # that of the specified litmus test, but with ".out" appended.
 #
+# If the --hw argument is specified, this script translates the .litmus
+# C-language file to the specified type of assembly and verifies that.
+# But in this case, litmus tests using complex synchronization (such as
+# locking, RCU, and SRCU) are cheerfully ignored.
+#
 # Usage:
 #	checkalllitmus.sh
 #
@@ -38,21 +43,15 @@ then
 	( cd "$LKMM_DESTDIR"; sed -e 's/^/mkdir -p /' | sh )
 fi
 
-# Find the checklitmus script.  If it is not where we expect it, then
-# assume that the caller has the PATH environment variable set
-# appropriately.
-if test -x scripts/checklitmus.sh
-then
-	clscript=scripts/checklitmus.sh
-else
-	clscript=checklitmus.sh
-fi
-
 # Run the script on all the litmus tests in the specified directory
 ret=0
 for i in $litmusdir/*.litmus
 do
-	if ! $clscript $i
+	if test -n "$LKMM_HW_MAP_FILE" && ! scripts/simpletest.sh $i
+	then
+		continue
+	fi
+	if ! scripts/checklitmus.sh $i
 	then
 		ret=1
 	fi
diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
index 638b8c6..42ff118 100755
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -6,6 +6,11 @@
 # results to a file whose name is that of the specified litmus test, but
 # with ".out" appended.
 #
+# If the --hw argument is specified, this script translates the .litmus
+# C-language file to the specified type of assembly and verifies that.
+# But in this case, litmus tests using complex synchronization (such as
+# locking, RCU, and SRCU) are cheerfully ignored.
+#
 # Usage:
 #	checklitmus.sh file.litmus
 #
@@ -18,8 +23,6 @@
 # Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 litmus=$1
-herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
-
 if test -f "$litmus" -a -r "$litmus"
 then
 	:
@@ -28,7 +31,38 @@ else
 	exit 255
 fi
 
-echo Herd options: $herdoptions > $LKMM_DESTDIR/$litmus.out
-/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
+if test -z "$LKMM_HW_MAP_FILE"
+then
+	# LKMM run
+	herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
+	echo Herd options: $herdoptions > $LKMM_DESTDIR/$litmus.out
+	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
+else
+	# Hardware run
+
+	T=/tmp/checklitmushw.sh.$$
+	trap 'rm -rf $T' 0 2
+	mkdir $T
+
+	# Generate filenames
+	catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
+	mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
+	themefile="$T/${LKMM_HW_MAP_FILE}.theme"
+	herdoptions="-model $LKMM_HW_CAT_FILE"
+	hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
+	hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
+
+	# Don't run on litmus tests with complex synchronization
+	if ! scripts/simpletest.sh $litmus
+	then
+		echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
+		exit 254
+	fi
+
+	# Generate the assembly code and run herd7 on it.
+	gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
+	jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
+	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+fi
 
 scripts/judgelitmus.sh $litmus
-- 
2.9.5

