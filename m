Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF52FE4F
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfE3Oo1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:44:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727272AbfE3Ome (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEdPbh023949
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:33 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stepvgeb8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:33 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:31 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:42:27 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEgQKS40632562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:42:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FDEFB2070;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C070B2065;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1C9A816C8E79; Thu, 30 May 2019 07:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 26/33] tools/memory-model: Implement --hw support for checkghlitmus.sh
Date:   Thu, 30 May 2019 07:42:18 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0060-0000-0000-00000349F4ED
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210779; UDB=6.00636154; IPR=6.00991814;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:42:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0061-0000-0000-0000498DEF55
Message-Id: <20190530144225.27624-26-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300105
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

