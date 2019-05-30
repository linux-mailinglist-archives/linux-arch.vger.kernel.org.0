Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B32FE48
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfE3Ome (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:42:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbfE3Omd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEdPWe023957
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:32 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stepvge9x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:32 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:30 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:42:26 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEgPK419464210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:42:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63024B2066;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BF5DB206E;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BA41316C5DA2; Thu, 30 May 2019 07:42:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 12/33] tools/memory-model: Fix paulmck email address on pre-existing scripts
Date:   Thu, 30 May 2019 07:42:04 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0064-0000-0000-000003E70C71
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210779; UDB=6.00636154; IPR=6.00991814;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:42:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0065-0000-0000-00003DAB92D3
Message-Id: <20190530144225.27624-12-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=698 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300105
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checkalllitmus.sh  | 2 +-
 tools/memory-model/scripts/checklitmus.sh     | 2 +-
 tools/memory-model/scripts/checklitmushist.sh | 2 +-
 tools/memory-model/scripts/judgelitmus.sh     | 2 +-
 tools/memory-model/scripts/newlitmushist.sh   | 2 +-
 tools/memory-model/scripts/parseargs.sh       | 2 +-
 tools/memory-model/scripts/runlitmushist.sh   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
index 3c0c7fbbd223..10e14d94acee 100755
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -17,7 +17,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 . scripts/parseargs.sh
 
diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
index 11461ed40b5e..638b8c610894 100755
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -15,7 +15,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 litmus=$1
 herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
diff --git a/tools/memory-model/scripts/checklitmushist.sh b/tools/memory-model/scripts/checklitmushist.sh
index 1d210ffb7c8a..406ecfc0aee4 100755
--- a/tools/memory-model/scripts/checklitmushist.sh
+++ b/tools/memory-model/scripts/checklitmushist.sh
@@ -12,7 +12,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 . scripts/parseargs.sh
 
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index 84c62eee321b..d82133e75580 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -13,7 +13,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 litmus=$1
 
diff --git a/tools/memory-model/scripts/newlitmushist.sh b/tools/memory-model/scripts/newlitmushist.sh
index 991f8f814881..3f4b06e29988 100755
--- a/tools/memory-model/scripts/newlitmushist.sh
+++ b/tools/memory-model/scripts/newlitmushist.sh
@@ -12,7 +12,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 . scripts/parseargs.sh
 
diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 40f52080fdbd..afe7bd23de6b 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -9,7 +9,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 T=/tmp/parseargs.sh.$$
 mkdir $T
diff --git a/tools/memory-model/scripts/runlitmushist.sh b/tools/memory-model/scripts/runlitmushist.sh
index 6ed376f495bb..852786fef179 100755
--- a/tools/memory-model/scripts/runlitmushist.sh
+++ b/tools/memory-model/scripts/runlitmushist.sh
@@ -13,7 +13,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 T=/tmp/runlitmushist.sh.$$
 trap 'rm -rf $T' 0
-- 
2.17.1

