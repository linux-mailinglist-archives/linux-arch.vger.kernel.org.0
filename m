Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3742FE30
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfE3OnT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:43:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbfE3OnS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:43:18 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEdMpU144572;
        Thu, 30 May 2019 10:42:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgu3s3wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 10:42:29 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x4UEditR001342;
        Thu, 30 May 2019 10:42:28 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgu3s3uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 10:42:28 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4UCenTf031704;
        Thu, 30 May 2019 12:46:00 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 2spwb96mj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 12:46:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEgPs227918572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:42:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E16AB205F;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FF91B2066;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9F10116C5D97; Thu, 30 May 2019 07:42:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: [PATCH RFC memory-model 07/33] tools/memory-model: Do not use "herd" to refer to "herd7"
Date:   Thu, 30 May 2019 07:41:59 -0700
Message-Id: <20190530144225.27624-7-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
X-TM-AS-GCONF: 00
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

From: Andrea Parri <andrea.parri@amarulasolutions.com>

Use "herd7" in each such reference.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/litmus-tests/README       | 2 +-
 tools/memory-model/lock.cat                  | 2 +-
 tools/memory-model/scripts/README            | 4 ++--
 tools/memory-model/scripts/checkalllitmus.sh | 2 +-
 tools/memory-model/scripts/checklitmus.sh    | 2 +-
 tools/memory-model/scripts/parseargs.sh      | 2 +-
 tools/memory-model/scripts/runlitmushist.sh  | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 5ee08f129094..681f9067fa9e 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -244,7 +244,7 @@ produce the name:
 Adding the ".litmus" suffix: SB+rfionceonce-poonceonces.litmus
 
 The descriptors that describe connections between consecutive accesses
-within the cycle through a given litmus test can be provided by the herd
+within the cycle through a given litmus test can be provided by the herd7
 tool (Rfi, Po, Fre, and so on) or by the linux-kernel.bell file (Once,
 Release, Acquire, and so on).
 
diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index a059d1a6d8a2..6b52f365d73a 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -11,7 +11,7 @@
 include "cross.cat"
 
 (*
- * The lock-related events generated by herd are as follows:
+ * The lock-related events generated by herd7 are as follows:
  *
  * LKR		Lock-Read: the read part of a spin_lock() or successful
  *			spin_trylock() read-modify-write event pair
diff --git a/tools/memory-model/scripts/README b/tools/memory-model/scripts/README
index 29375a1fbbfa..095c7eb36f9f 100644
--- a/tools/memory-model/scripts/README
+++ b/tools/memory-model/scripts/README
@@ -22,7 +22,7 @@ checklitmushist.sh
 
 	Run all litmus tests having .litmus.out files from previous
 	initlitmushist.sh or newlitmushist.sh runs, comparing the
-	herd output to that of the original runs.
+	herd7 output to that of the original runs.
 
 checklitmus.sh
 
@@ -43,7 +43,7 @@ initlitmushist.sh
 
 judgelitmus.sh
 
-	Given a .litmus file and its .litmus.out herd output, check the
+	Given a .litmus file and its .litmus.out herd7 output, check the
 	.litmus.out file against the .litmus file's "Result:" comment to
 	judge whether the test ran correctly.  Not normally run manually,
 	provided instead for use by other scripts.
diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
index b35fcd61ecf6..3c0c7fbbd223 100755
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Run herd tests on all .litmus files in the litmus-tests directory
+# Run herd7 tests on all .litmus files in the litmus-tests directory
 # and check each file's result against a "Result:" comment within that
 # litmus test.  If the verification result does not match that specified
 # in the litmus test, this script prints an error message prefixed with
diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
index dd08801a30b0..11461ed40b5e 100755
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Run a herd test and invokes judgelitmus.sh to check the result against
+# Run a herd7 test and invokes judgelitmus.sh to check the result against
 # a "Result:" comment within the litmus test.  It also outputs verification
 # results to a file whose name is that of the specified litmus test, but
 # with ".out" appended.
diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 859e1d581e05..40f52080fdbd 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -91,7 +91,7 @@ do
 		shift
 		;;
 	--herdopts|--herdopt)
-		checkarg --destdir "(herd options)" "$#" "$2" '.*' '^--'
+		checkarg --destdir "(herd7 options)" "$#" "$2" '.*' '^--'
 		LKMM_HERD_OPTIONS="$2"
 		shift
 		;;
diff --git a/tools/memory-model/scripts/runlitmushist.sh b/tools/memory-model/scripts/runlitmushist.sh
index e507f5f933d5..6ed376f495bb 100755
--- a/tools/memory-model/scripts/runlitmushist.sh
+++ b/tools/memory-model/scripts/runlitmushist.sh
@@ -79,7 +79,7 @@ then
 	echo ' ---' Summary: 1>&2
 	grep '!!!' $T/*.sh.out 1>&2
 	nfail="`grep '!!!' $T/*.sh.out | wc -l`"
-	echo 'Number of failed herd runs (e.g., timeout): ' $nfail 1>&2
+	echo 'Number of failed herd7 runs (e.g., timeout): ' $nfail 1>&2
 	exit 1
 else
 	echo All runs completed successfully. 1>&2
-- 
2.17.1

