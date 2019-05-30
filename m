Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775642FE39
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfE3Onr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:43:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727677AbfE3Onr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:43:47 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEf3tB067032
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:43:46 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stf2174ta-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:43:46 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:43:45 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:43:41 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEgPac39780370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:42:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 578D5B206B;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33B25B206C;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ADB5C16C5D9F; Thu, 30 May 2019 07:42:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 10/33] tools/memory-model: Make judgelitmus.sh identify bad macros
Date:   Thu, 30 May 2019 07:42:02 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0040-0000-0000-000004F680DA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210780; UDB=6.00636155; IPR=6.00991814;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:43:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0041-0000-0000-000009029B2A
Message-Id: <20190530144225.27624-10-paulmck@linux.ibm.com>
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

Currently, judgelitmus.sh treats use of unknown primitives (such as
srcu_read_lock() prior to SRCU support) as "!!! Verification error".
This can be misleading because it fails to call out typos and running
a version LKMM on a litmus test requiring a feature not provided by
that version.  This commit therefore changes judgelitmus.sh to check
for unknown primitives and to report them, for example, with:

	'!!! Current LKMM version does not know "rcu_write_lock"'.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/cmplitmushist.sh | 31 ++++++++++++++++++---
 tools/memory-model/scripts/judgelitmus.sh   | 12 ++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/tools/memory-model/scripts/cmplitmushist.sh b/tools/memory-model/scripts/cmplitmushist.sh
index b9c174dd8004..ca1ac8b64614 100755
--- a/tools/memory-model/scripts/cmplitmushist.sh
+++ b/tools/memory-model/scripts/cmplitmushist.sh
@@ -12,6 +12,7 @@ trap 'rm -rf $T' 0
 mkdir $T
 
 # comparetest oldpath newpath
+badmacnam=0
 timedout=0
 perfect=0
 obsline=0
@@ -19,8 +20,26 @@ noobsline=0
 obsresult=0
 badcompare=0
 comparetest () {
-	if grep -q '^Command exited with non-zero status 124' $1 ||
-	   grep -q '^Command exited with non-zero status 124' $2
+	if grep -q ': Unknown macro ' $1 || grep -q ': Unknown macro ' $2
+	then
+		if grep -q ': Unknown macro ' $1
+		then
+			badname=`grep ': Unknown macro ' $1 |
+				sed -e 's/^.*: Unknown macro //' |
+				sed -e 's/ (User error).*$//'`
+			echo 'Current LKMM version does not know "'$badname'"' $1
+		fi
+		if grep -q ': Unknown macro ' $2
+		then
+			badname=`grep ': Unknown macro ' $2 |
+				sed -e 's/^.*: Unknown macro //' |
+				sed -e 's/ (User error).*$//'`
+			echo 'Current LKMM version does not know "'$badname'"' $2
+		fi
+		badmacnam=`expr "$badmacnam" + 1`
+		return 0
+	elif grep -q '^Command exited with non-zero status 124' $1 ||
+	     grep -q '^Command exited with non-zero status 124' $2
 	then
 		if grep -q '^Command exited with non-zero status 124' $1 &&
 		   grep -q '^Command exited with non-zero status 124' $2
@@ -56,7 +75,7 @@ comparetest () {
 			return 0
 		fi
 	else
-		echo Missing Observation line "(e.g., herd7 timeout)": $2
+		echo Missing Observation line "(e.g., syntax error)": $2
 		noobsline=`expr "$noobsline" + 1`
 		return 0
 	fi
@@ -90,7 +109,7 @@ then
 fi
 if test "$noobsline" -ne 0
 then
-	echo Missing Observation line "(e.g., herd7 timeout)": $noobsline 1>&2
+	echo Missing Observation line "(e.g., syntax error)": $noobsline 1>&2
 fi
 if test "$obsresult" -ne 0
 then
@@ -100,6 +119,10 @@ if test "$timedout" -ne 0
 then
 	echo "!!!" Timed out: $timedout 1>&2
 fi
+if test "$badmacnam" -ne 0
+then
+	echo "!!!" Unknown primitive: $badmacnam 1>&2
+fi
 if test "$badcompare" -ne 0
 then
 	echo "!!!" Result changed: $badcompare 1>&2
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index d3c313b9a458..d40439c7b71e 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -42,6 +42,18 @@ grep '^Observation' $LKMM_DESTDIR/$litmus.out
 if grep -q '^Observation' $LKMM_DESTDIR/$litmus.out
 then
 	:
+elif grep ': Unknown macro ' $LKMM_DESTDIR/$litmus.out
+then
+	badname=`grep ': Unknown macro ' $LKMM_DESTDIR/$litmus.out |
+		sed -e 's/^.*: Unknown macro //' |
+		sed -e 's/ (User error).*$//'`
+	badmsg=' !!! Current LKMM version does not know "'$badname'"'" $litmus"
+	echo $badmsg
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	then
+		echo ' !!! '$badmsg >> $LKMM_DESTDIR/$litmus.out 2>&1
+	fi
+	exit 254
 elif grep '^Command exited with non-zero status 124' $LKMM_DESTDIR/$litmus.out
 then
 	echo ' !!! Timeout' $litmus
-- 
2.17.1

