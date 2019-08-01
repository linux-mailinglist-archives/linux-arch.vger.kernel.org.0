Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942A67E56B
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2019 00:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfHAWWD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Aug 2019 18:22:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389545AbfHAWVR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:17 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MGvQg081202;
        Thu, 1 Aug 2019 18:20:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u475rube1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:20:59 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MKxaf090739;
        Thu, 1 Aug 2019 18:20:59 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u475rubda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:20:59 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MJmwV006635;
        Thu, 1 Aug 2019 22:20:57 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 2u0e85w5pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:20:57 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MKvk025756128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:20:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 557B7B2068;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36B64B2067;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8D20D16C9A4D; Thu,  1 Aug 2019 15:20:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 03/31] tools/memory-model: Make cmplitmushist.sh note timeouts
Date:   Thu,  1 Aug 2019 15:20:28 -0700
Message-Id: <20190801222056.12144-3-paulmck@linux.ibm.com>
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

Currently, cmplitmushist.sh treats timeouts (as in the "--timeout"
argument) as "Missing Observation line".  This can be misleading because
it is quite possible that running the test longer would have produced
a verification.  This commit therefore changes cmplitmushist.sh to check
for timeouts and to report them with "Timed out".

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/cmplitmushist.sh | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/memory-model/scripts/cmplitmushist.sh b/tools/memory-model/scripts/cmplitmushist.sh
index 0f498aeeccf5..b9c174dd8004 100755
--- a/tools/memory-model/scripts/cmplitmushist.sh
+++ b/tools/memory-model/scripts/cmplitmushist.sh
@@ -12,12 +12,30 @@ trap 'rm -rf $T' 0
 mkdir $T
 
 # comparetest oldpath newpath
+timedout=0
 perfect=0
 obsline=0
 noobsline=0
 obsresult=0
 badcompare=0
 comparetest () {
+	if grep -q '^Command exited with non-zero status 124' $1 ||
+	   grep -q '^Command exited with non-zero status 124' $2
+	then
+		if grep -q '^Command exited with non-zero status 124' $1 &&
+		   grep -q '^Command exited with non-zero status 124' $2
+		then
+			echo Both runs timed out: $2
+		elif grep -q '^Command exited with non-zero status 124' $1
+		then
+			echo Old run timed out: $2
+		elif grep -q '^Command exited with non-zero status 124' $2
+		then
+			echo New run timed out: $2
+		fi
+		timedout=`expr "$timedout" + 1`
+		return 0
+	fi
 	grep -v 'maxresident)k\|minor)pagefaults\|^Time' $1 > $T/oldout
 	grep -v 'maxresident)k\|minor)pagefaults\|^Time' $2 > $T/newout
 	if cmp -s $T/oldout $T/newout && grep -q '^Observation' $1
@@ -78,6 +96,10 @@ if test "$obsresult" -ne 0
 then
 	echo Matching Observation Always/Sometimes/Never result: $obsresult 1>&2
 fi
+if test "$timedout" -ne 0
+then
+	echo "!!!" Timed out: $timedout 1>&2
+fi
 if test "$badcompare" -ne 0
 then
 	echo "!!!" Result changed: $badcompare 1>&2
-- 
2.17.1

