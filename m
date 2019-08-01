Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B10D7E561
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2019 00:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389623AbfHAWVl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Aug 2019 18:21:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389563AbfHAWVS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MGwmf068440;
        Thu, 1 Aug 2019 18:20:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u45607ndv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:20:59 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MKexx078053;
        Thu, 1 Aug 2019 18:20:59 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u45607nd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:20:59 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MJu47014819;
        Thu, 1 Aug 2019 22:20:57 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 2u0e85w67h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:20:57 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MKvqD25756130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:20:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B743B2065;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BD45B206B;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 929C616C9A4E; Thu,  1 Aug 2019 15:20:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 04/31] tools/memory-model: Make judgelitmus.sh identify bad macros
Date:   Thu,  1 Aug 2019 15:20:29 -0700
Message-Id: <20190801222056.12144-4-paulmck@linux.ibm.com>
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

