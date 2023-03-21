Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2316C26F6
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjCUBJG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCUBI1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF41C20D00;
        Mon, 20 Mar 2023 18:07:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2D6E6192D;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F09C4339E;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=s9ojW5D99E0N5jDbUUGtarJUEkQdysRNlfbhK1sMvIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmzqCH9DFOdLYr84piHc5undrc8To0vxkGUcQUi3FxbfVKjypWpqH7ez4DhPZ+Q5w
         TUfV2RrWjmcOmYYN+2Gi0DhyIyfppVkQ2RDAyOzR/0w6+SPr8Jszv8J4FywDNV7BFu
         UR3ua8BPXeOCtzRBiXYv/njeGSnjl/MgQcv916JU9ciimUomPCeUPk87b6kPFR0LMg
         8jhnAmU0Aai1AavbOZyWT8v67kiEmVmLR49NzUztjaZRQb3TjM0v7yDgDLNByYH58N
         /623/ylwXhIJMz7x09KMlIUuWsBeAYmGwixgmmhjbvMWsp+N2nsliyjSmp1Ju0WSfb
         TZMGC7m4rJizw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B0E9B15403BF; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 20/31] tools/memory-model: Implement --hw support for checkghlitmus.sh
Date:   Mon, 20 Mar 2023 18:05:38 -0700
Message-Id: <20230321010549.51296-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commits enables the "--hw" argument for the checkghlitmus.sh script,
causing it to convert any applicable C-language litmus tests to the
specified flavor of assembly language, to verify these assembly-language
litmus tests, and checking compatibility of the outcomes.

Note that the conversion does not yet handle locking, RCU, SRCU, plain
C-language memory accesses, or casts.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/checkghlitmus.sh |  9 ++++---
 tools/memory-model/scripts/hwfnseg.sh       | 20 +++++++++++++++
 tools/memory-model/scripts/runlitmushist.sh | 27 +++++++++++++--------
 3 files changed, 42 insertions(+), 14 deletions(-)
 create mode 100755 tools/memory-model/scripts/hwfnseg.sh

diff --git a/tools/memory-model/scripts/checkghlitmus.sh b/tools/memory-model/scripts/checkghlitmus.sh
index 6589fbb6f653..2ea220d2564b 100755
--- a/tools/memory-model/scripts/checkghlitmus.sh
+++ b/tools/memory-model/scripts/checkghlitmus.sh
@@ -10,6 +10,7 @@
 # parseargs.sh scripts for arguments.
 
 . scripts/parseargs.sh
+. scripts/hwfnseg.sh
 
 T=/tmp/checkghlitmus.sh.$$
 trap 'rm -rf $T' 0
@@ -32,9 +33,9 @@ then
 	( cd "$LKMM_DESTDIR"; sed -e 's/^/mkdir -p /' | sh )
 fi
 
-# Create a list of the C-language litmus tests previously run.
-( cd $LKMM_DESTDIR; find litmus -name '*.litmus.out' -print ) |
-	sed -e 's/\.out$//' |
+# Create a list of the specified litmus tests previously run.
+( cd $LKMM_DESTDIR; find litmus -name "*.litmus${hwfnseg}.out" -print ) |
+	sed -e "s/${hwfnseg}"'\.out$//' |
 	xargs -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' |
 	xargs -r grep -L "^P${LKMM_PROCS}"> $T/list-C-already
 
@@ -44,7 +45,7 @@ find litmus -name '*.litmus' -exec grep -l -m 1 "^C " {} \; > $T/list-C
 xargs < $T/list-C -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' > $T/list-C-result
 xargs < $T/list-C-result -r grep -L "^P${LKMM_PROCS}" > $T/list-C-result-short
 
-# Form list of tests without corresponding .litmus.out files
+# Form list of tests without corresponding .out files
 sort $T/list-C-already $T/list-C-result-short | uniq -u > $T/list-C-needed
 
 # Run any needed tests.
diff --git a/tools/memory-model/scripts/hwfnseg.sh b/tools/memory-model/scripts/hwfnseg.sh
new file mode 100755
index 000000000000..580c3281181c
--- /dev/null
+++ b/tools/memory-model/scripts/hwfnseg.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Generate the hardware extension to the litmus-test filename, or the
+# empty string if this is an LKMM run.  The extension is placed in
+# the shell variable hwfnseg.
+#
+# Usage:
+#	. hwfnseg.sh
+#
+# Copyright IBM Corporation, 2019
+#
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
+
+if test -z "$LKMM_HW_MAP_FILE"
+then
+	hwfnseg=
+else
+	hwfnseg=".$LKMM_HW_MAP_FILE"
+fi
diff --git a/tools/memory-model/scripts/runlitmushist.sh b/tools/memory-model/scripts/runlitmushist.sh
index 852786fef179..c6c2bdc67a50 100755
--- a/tools/memory-model/scripts/runlitmushist.sh
+++ b/tools/memory-model/scripts/runlitmushist.sh
@@ -15,6 +15,8 @@
 #
 # Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
+. scripts/hwfnseg.sh
+
 T=/tmp/runlitmushist.sh.$$
 trap 'rm -rf $T' 0
 mkdir $T
@@ -30,15 +32,12 @@ fi
 # Prefixes for per-CPU scripts
 for ((i=0;i<$LKMM_JOBS;i++))
 do
-	echo dir="$LKMM_DESTDIR" > $T/$i.sh
 	echo T=$T >> $T/$i.sh
-	echo herdoptions=\"$LKMM_HERD_OPTIONS\" >> $T/$i.sh
 	cat << '___EOF___' >> $T/$i.sh
 	runtest () {
-		echo ' ... ' /usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $1 '>' $dir/$1.out '2>&1'
-		if /usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $1 > $dir/$1.out 2>&1
+		if scripts/runlitmus.sh $1
 		then
-			if ! grep -q '^Observation ' $dir/$1.out
+			if ! grep -q '^Observation ' $LKMM_DESTDIR/$1$2.out
 			then
 				echo ' !!! Herd failed, no Observation:' $1
 			fi
@@ -47,10 +46,16 @@ do
 			if test "$exitcode" -eq 124
 			then
 				exitmsg="timed out"
+			elif test "$exitcode" -eq 253
+			then
+				exitmsg=
 			else
 				exitmsg="failed, exit code $exitcode"
 			fi
-			echo ' !!! Herd' ${exitmsg}: $1
+			if test -n "$exitmsg"
+			then
+				echo ' !!! Herd' ${exitmsg}: $1
+			fi
 		fi
 	}
 ___EOF___
@@ -59,11 +64,13 @@ done
 awk -v q="'" -v b='\\' '
 {
 	print "echo `grep " q "^P[0-9]" b "+(" q " " $0 " | tail -1 | sed -e " q "s/^P" b "([0-9]" b "+" b ")(.*$/" b "1/" q "` " $0
-}' | bash |
-sort -k1n |
-awk -v ncpu=$LKMM_JOBS -v t=$T '
+}' | sh | sort -k1n |
+awk -v dq='"' -v hwfnseg="$hwfnseg" -v ncpu="$LKMM_JOBS" -v t="$T" '
 {
-	print "runtest " $2 >> t "/" NR % ncpu ".sh";
+	print "if test -z " dq hwfnseg dq " || scripts/simpletest.sh " dq $2 dq
+	print "then"
+	print "\techo runtest " dq $2 dq " " hwfnseg " >> " t "/" NR % ncpu ".sh";
+	print "fi"
 }
 
 END {
-- 
2.40.0.rc2

