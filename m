Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E36F7E569
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2019 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfHAWVk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Aug 2019 18:21:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389565AbfHAWVT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MH0aw140595;
        Thu, 1 Aug 2019 18:21:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u455v7tyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:21:00 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MHgHQ147106;
        Thu, 1 Aug 2019 18:21:00 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u455v7txx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:20:59 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MJlVd026752;
        Thu, 1 Aug 2019 22:20:58 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 2u0e87h3qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:20:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MKve535586494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:20:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D136BB2070;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD508B2071;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C8DCD16C9A58; Thu,  1 Aug 2019 15:20:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 14/31] tools/memory-model: Make runlitmus.sh generate .litmus.out for --hw
Date:   Thu,  1 Aug 2019 15:20:39 -0700
Message-Id: <20190801222056.12144-14-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=959 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010234
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In the absence of "Result:" comments, the runlitmus.sh script relies on
litmus.out files from prior LKMM runs.  This can be a bit user-hostile,
so this commit makes runlitmus.sh generate any needed .litmus.out files
that don't already exist.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/runlitmus.sh | 54 ++++++++++++++-----------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index 91af859c0e90..2865a9661b07 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -28,42 +28,48 @@ if test -f "$litmus" -a -r "$litmus"
 then
 	:
 else
-	echo ' --- ' error: \"$litmus\" is not a readable file
+	echo ' !!! ' error: \"$litmus\" is not a readable file
 	exit 255
 fi
 
-if test -z "$LKMM_HW_MAP_FILE"
+if test -z "$LKMM_HW_MAP_FILE" -o ! -e $LKMM_DESTDIR/$litmus.out
 then
 	# LKMM run
 	herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
 	echo Herd options: $herdoptions > $LKMM_DESTDIR/$litmus.out
 	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
-else
-	# Hardware run
+	ret=$?
+	if test -z "$LKMM_HW_MAP_FILE"
+	then
+		exit $ret
+	fi
+	echo " --- " Automatically generated LKMM output for '"'--hw $LKMM_HW_MAP_FILE'"' run
+fi
 
-	T=/tmp/checklitmushw.sh.$$
-	trap 'rm -rf $T' 0 2
-	mkdir $T
+# Hardware run
 
-	# Generate filenames
-	catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
-	mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
-	themefile="$T/${LKMM_HW_MAP_FILE}.theme"
-	herdoptions="-model $LKMM_HW_CAT_FILE"
-	hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
-	hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
+T=/tmp/checklitmushw.sh.$$
+trap 'rm -rf $T' 0 2
+mkdir $T
 
-	# Don't run on litmus tests with complex synchronization
-	if ! scripts/simpletest.sh $litmus
-	then
-		echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
-		exit 254
-	fi
+# Generate filenames
+catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
+mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
+themefile="$T/${LKMM_HW_MAP_FILE}.theme"
+herdoptions="-model $LKMM_HW_CAT_FILE"
+hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
+hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
 
-	# Generate the assembly code and run herd on it.
-	gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
-	jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
-	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+# Don't run on litmus tests with complex synchronization
+if ! scripts/simpletest.sh $litmus
+then
+	echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
+	exit 254
 fi
 
+# Generate the assembly code and run herd7 on it.
+gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
+jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
+/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+
 exit $?
-- 
2.17.1

