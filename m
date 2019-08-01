Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC1017E56D
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2019 00:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbfHAWVQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Aug 2019 18:21:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389534AbfHAWVQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:16 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MGwPi041391;
        Thu, 1 Aug 2019 18:21:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u47v11w41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:21:00 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MH0om041500;
        Thu, 1 Aug 2019 18:20:59 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u47v11w31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:20:59 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MJkIf004787;
        Thu, 1 Aug 2019 22:20:58 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 2u0e8792cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:20:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MKvpu19005930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:20:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D038AB206A;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3225B206B;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AB5F216C9A52; Thu,  1 Aug 2019 15:20:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 08/31] tools/memory-model: Make judgelitmus.sh handle hardware verifications
Date:   Thu,  1 Aug 2019 15:20:33 -0700
Message-Id: <20190801222056.12144-8-paulmck@linux.ibm.com>
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

This commit makes the judgelitmus.sh script check the --hw argument
(AKA the LKMM_HW_MAP_FILE environment variable) and to adjust its
judgment for a run where a C-language litmus test has been translated to
assembly and the assembly version verified.  In this case, the assembly
verification output is checked against the C-language script's "Result:"
comment.  However, because hardware can be stronger than LKMM requires,
the judgelitmus.sh script forgives verification mismatches featuring
a "Sometimes" in the C-language script and an "Always" or "Never"
assembly-language verification.

Note that deadlock is not forgiven, however, this should not normally be
an issue given that C-language tests containing locking, RCU, or SRCU
cannot be translated to assembly.  However, this issue can crop up in
litmus tests that mimic deadlock by using the "filter" clause to ignore
all executions.  It can also crop up when certain herd arguments are
used to autofilter everything that does not match the "exists" clause
in cases where the "exists" clause cannot be satisfied.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/README         |  8 +--
 tools/memory-model/scripts/judgelitmus.sh | 75 ++++++++++++++---------
 2 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/tools/memory-model/scripts/README b/tools/memory-model/scripts/README
index 095c7eb36f9f..0e29a52044c1 100644
--- a/tools/memory-model/scripts/README
+++ b/tools/memory-model/scripts/README
@@ -43,10 +43,10 @@ initlitmushist.sh
 
 judgelitmus.sh
 
-	Given a .litmus file and its .litmus.out herd7 output, check the
-	.litmus.out file against the .litmus file's "Result:" comment to
-	judge whether the test ran correctly.  Not normally run manually,
-	provided instead for use by other scripts.
+	Given a .litmus file and its herd7 output, check the output file
+	against the .litmus file's "Result:" comment to judge whether
+	the test ran correctly.  Not normally run manually, provided
+	instead for use by other scripts.
 
 newlitmushist.sh
 
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index d82133e75580..6f3c60065c8b 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -1,9 +1,14 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Given a .litmus test and the corresponding .litmus.out file, check
-# the .litmus.out file against the "Result:" comment to judge whether
-# the test ran correctly.
+# Given a .litmus test and the corresponding litmus output file, check
+# the .litmus.out file against the "Result:" comment to judge whether the
+# test ran correctly.  If the --hw argument is omitted, check against the
+# LKMM output, which is assumed to be in file.litmus.out.  If this argument
+# is provided, this is assumed to be a hardware test, and the output is
+# assumed to be in file.HW.litmus.out, where "HW" is the --hw argument.
+# In addition, non-Sometimes verification results will be noted, but
+# forgiven.
 #
 # Usage:
 #	judgelitmus.sh file.litmus
@@ -24,11 +29,18 @@ else
 	echo ' --- ' error: \"$litmus\" is not a readable file
 	exit 255
 fi
-if test -f "$LKMM_DESTDIR/$litmus".out -a -r "$LKMM_DESTDIR/$litmus".out
+if test -z "$LKMM_HW_MAP_FILE"
+then
+	litmusout=$litmus.out
+else
+	litmusout="`echo $litmus |
+		sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`.out"
+fi
+if test -f "$LKMM_DESTDIR/$litmusout" -a -r "$LKMM_DESTDIR/$litmusout"
 then
 	:
 else
-	echo ' --- ' error: \"$LKMM_DESTDIR/$litmus\".out is not a readable file
+	echo ' --- ' error: \"$LKMM_DESTDIR/$litmusout is not a readable file
 	exit 255
 fi
 if grep -q '^ \* Result: ' $litmus
@@ -38,69 +50,76 @@ else
 	outcome=specified
 fi
 
-grep '^Observation' $LKMM_DESTDIR/$litmus.out
-if grep -q '^Observation' $LKMM_DESTDIR/$litmus.out
+grep '^Observation' $LKMM_DESTDIR/$litmusout
+if grep -q '^Observation' $LKMM_DESTDIR/$litmusout
 then
 	:
-elif grep ': Unknown macro ' $LKMM_DESTDIR/$litmus.out
+elif grep ': Unknown macro ' $LKMM_DESTDIR/$litmusout
 then
-	badname=`grep ': Unknown macro ' $LKMM_DESTDIR/$litmus.out |
+	badname=`grep ': Unknown macro ' $LKMM_DESTDIR/$litmusout |
 		sed -e 's/^.*: Unknown macro //' |
 		sed -e 's/ (User error).*$//'`
 	badmsg=' !!! Current LKMM version does not know "'$badname'"'" $litmus"
 	echo $badmsg
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 	then
-		echo ' !!! '$badmsg >> $LKMM_DESTDIR/$litmus.out 2>&1
+		echo ' !!! '$badmsg >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
 	exit 254
-elif grep '^Command exited with non-zero status 124' $LKMM_DESTDIR/$litmus.out
+elif grep '^Command exited with non-zero status 124' $LKMM_DESTDIR/$litmusout
 then
 	echo ' !!! Timeout' $litmus
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 	then
-		echo ' !!! Timeout' >> $LKMM_DESTDIR/$litmus.out 2>&1
+		echo ' !!! Timeout' >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
 	exit 124
 else
 	echo ' !!! Verification error' $litmus
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 	then
-		echo ' !!! Verification error' >> $LKMM_DESTDIR/$litmus.out 2>&1
+		echo ' !!! Verification error' >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
 	exit 255
 fi
 if test "$outcome" = DEADLOCK
 then
-	if grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q 'Never 0 0$'
+	if grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q 'Never 0 0$'
 	then
 		ret=0
 	else
 		echo " !!! Unexpected non-$outcome verification" $litmus
-		if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+		if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 		then
-			echo " !!! Unexpected non-$outcome verification" >> $LKMM_DESTDIR/$litmus.out 2>&1
+			echo " !!! Unexpected non-$outcome verification" >> $LKMM_DESTDIR/$litmusout 2>&1
 		fi
 		ret=1
 	fi
-elif grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q 'Never 0 0$'
+elif grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q 'Never 0 0$'
 then
 	echo " !!! Unexpected non-$outcome deadlock" $litmus
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 	then
-		echo " !!! Unexpected non-$outcome deadlock" $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
+		echo " !!! Unexpected non-$outcome deadlock" $litmus >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
 	ret=1
-elif grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q $outcome || test "$outcome" = Maybe
+elif grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q $outcome || test "$outcome" = Maybe
 then
 	ret=0
 else
-	echo " !!! Unexpected non-$outcome verification" $litmus
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if test -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes
 	then
-		echo " !!! Unexpected non-$outcome verification" >> $LKMM_DESTDIR/$litmus.out 2>&1
+		flag="--- Forgiven"
+		ret=0
+	else
+		flag="!!! Unexpected"
+		ret=1
+	fi
+	echo " $flag non-$outcome verification" $litmus
+	if ! grep -qe "$flag" $LKMM_DESTDIR/$litmusout
+	then
+		echo " $flag non-$outcome verification" >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
-	ret=1
 fi
-tail -2 $LKMM_DESTDIR/$litmus.out | head -1
+tail -2 $LKMM_DESTDIR/$litmusout | head -1
 exit $ret
-- 
2.17.1

