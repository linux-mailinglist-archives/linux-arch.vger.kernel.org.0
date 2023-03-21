Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30056C26FE
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCUBJj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCUBJA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:09:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795B336440;
        Mon, 20 Mar 2023 18:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FFB46190D;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDE6C433AA;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=V/B5mtkec3M+Mmw5Uf3vQ3zJrWeH4vUVItie4imYL48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZaAzJ682yLnZQ4lXP6rVaoJZkMfNbEtXcfUhYzmXeUQVIh9Svi6gfGqTq5/ncKJs
         QycfKauDQQURkM8ZeGX7tE6/sDD66sOfEiLa++eMnKflU0I6jdiXEaaCUkNTik4Z4A
         v7mevMo7cdb8bn8OLMil1HPiWTWvvR8sA6iJwxvQr2BmusbRbnVuTU2nfdsASt7NYw
         rnFSXlalvyLDc89k0bQyQLNPdIRfGOlMQ/2QL7Bs9ejRnlRkONEGXvJkv5lprQWVAp
         Ym3C5Zi9oZ7mkEqhHpGKWCQvHyn8YwpLRGI17+1N4e15+TBqIgm9k+3yPMe6cMMADK
         62C6IadadKQZw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8A14715403AD; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 11/31] tools/memory-model: Hardware checking for check{,all}litmus.sh
Date:   Mon, 20 Mar 2023 18:05:29 -0700
Message-Id: <20230321010549.51296-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit makes checklitmus.sh and checkalllitmus.sh check to see
if a hardware verification was specified (via the --hw command-line
argument, which sets the LKMM_HW_MAP_FILE environment variable).
If so, the C-language litmus test is converted to the specified type
of assembly-language litmus test and herd is run on it.  Hardware is
permitted to be stronger than LKMM requires, so "Always" and "Never"
verifications of "Sometimes" C-language litmus tests are forgiven.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/checkalllitmus.sh | 23 +++++------
 tools/memory-model/scripts/checklitmus.sh    | 42 ++++++++++++++++++--
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
index 54d8da8c338e..2d3ee850a839 100755
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
index 638b8c610894..42ff11869cd6 100755
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
2.40.0.rc2

