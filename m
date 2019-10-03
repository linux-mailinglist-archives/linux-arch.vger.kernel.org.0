Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3727BC95B6
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfJCA1y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbfJCA07 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:59 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D00FA22466;
        Thu,  3 Oct 2019 00:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062419;
        bh=iRcDEBfxkv8l6bTP78ExNhW+MMZBsa+eN+470HQBJsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWEDJNKCh5pXzzR3ICpOOO2zGkVVw7thLxif/IRqx65ZZpeK6RNaBnlHfOkPwUV3r
         H1vmW+RTh67kk8lq3nAZM0eI5bsXrKViBqpq8tSkthiZMVA0hQ+poBBU63LAlDOYr5
         ZOrc0B3lJEk76ux4k09pyGan1/xconWxKFsR2sBY=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 23/32] tools/memory-model: Implement --hw support for checkghlitmus.sh
Date:   Wed,  2 Oct 2019 17:26:41 -0700
Message-Id: <20191003002650.11249-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

This commits enables the "--hw" argument for the checkghlitmus.sh script,
causing it to convert any applicable C-language litmus tests to the
specified flavor of assembly language, to verify these assembly-language
litmus tests, and checking compatibility of the outcomes.

Note that the conversion does not yet handle locking, RCU, SRCU, plain
C-language memory accesses, or casts.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checkghlitmus.sh |  9 +++++----
 tools/memory-model/scripts/hwfnseg.sh       | 20 ++++++++++++++++++++
 tools/memory-model/scripts/runlitmushist.sh | 27 +++++++++++++++++----------
 3 files changed, 42 insertions(+), 14 deletions(-)
 create mode 100755 tools/memory-model/scripts/hwfnseg.sh

diff --git a/tools/memory-model/scripts/checkghlitmus.sh b/tools/memory-model/scripts/checkghlitmus.sh
index 6589fbb..2ea220d 100755
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
index 0000000..580c328
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
index 852786f..c6c2bdc 100755
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
2.9.5

