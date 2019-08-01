Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0B7E566
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2019 00:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389620AbfHAWVk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Aug 2019 18:21:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389570AbfHAWVT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MH7O7098602;
        Thu, 1 Aug 2019 18:21:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u457uqc6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:21:00 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MHD3d099768;
        Thu, 1 Aug 2019 18:21:00 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u457uqc5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:21:00 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MJmko017599;
        Thu, 1 Aug 2019 22:20:58 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 2u0e85w6bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:20:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MKwCC20382078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:20:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 059DBB2068;
        Thu,  1 Aug 2019 22:20:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6FDDB2075;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E610C16C9A4A; Thu,  1 Aug 2019 15:20:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 20/31] tools/memory-model: Implement --hw support for checkghlitmus.sh
Date:   Thu,  1 Aug 2019 15:20:45 -0700
Message-Id: <20190801222056.12144-20-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010234
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commits enables the "--hw" argument for the checkghlitmus.sh script,
causing it to convert any applicable C-language litmus tests to the
specified flavor of assembly language, to verify these assembly-language
litmus tests, and checking compatibility of the outcomes.

Note that the conversion does not yet handle locking, RCU, SRCU, plain
C-language memory accesses, or casts.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
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
2.17.1

