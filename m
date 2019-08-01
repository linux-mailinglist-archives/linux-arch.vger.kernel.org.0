Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55BA7E57C
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2019 00:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbfHAWWb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Aug 2019 18:22:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389501AbfHAWVN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:13 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MGvXC016136;
        Thu, 1 Aug 2019 18:21:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u488k91v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:21:00 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MIa9i020141;
        Thu, 1 Aug 2019 18:20:59 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u488k91u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:20:59 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MJsgf009511;
        Thu, 1 Aug 2019 22:20:58 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 2u0e85xffc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:20:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MKvWN21365070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:20:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3F32B2064;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF649B2073;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CF33816C9A59; Thu,  1 Aug 2019 15:20:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 15/31] tools/memory-model: Move from .AArch64.litmus.out to .litmus.AArch.out
Date:   Thu,  1 Aug 2019 15:20:40 -0700
Message-Id: <20190801222056.12144-15-paulmck@linux.ibm.com>
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

When the github scripts see ".litmus.out", they assume that there must be
a corresponding C-language ".litmus" file.  Won't they be disappointed
when they instead see nothing, or, worse yet, the corresponding
assembly-language litmus test?  This commit therefore swaps the hardware
tag with the "litmus" to avoid this sort of disappointment.

This commit also adjusts the .gitignore file so as to avoid adding these
new ".out" files to git.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/litmus-tests/.gitignore | 2 +-
 tools/memory-model/scripts/judgelitmus.sh  | 2 +-
 tools/memory-model/scripts/runlitmus.sh    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/litmus-tests/.gitignore b/tools/memory-model/litmus-tests/.gitignore
index 6e2ddc54152f..f47cb2045f13 100644
--- a/tools/memory-model/litmus-tests/.gitignore
+++ b/tools/memory-model/litmus-tests/.gitignore
@@ -1 +1 @@
-*.litmus.out
+*.out
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index fe9131f8eb96..ca9a19829d79 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -37,7 +37,7 @@ then
 	lkmmout=
 else
 	litmusout="`echo $litmus |
-		sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`.out"
+		sed -e 's/\.litmus$/.litmus.'${LKMM_HW_MAP_FILE}'/'`.out"
 	lkmmout=$litmus.out
 fi
 if test -f "$LKMM_DESTDIR/$litmusout" -a -r "$LKMM_DESTDIR/$litmusout"
diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index 2865a9661b07..c84124b32bee 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -57,7 +57,7 @@ catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
 mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
 themefile="$T/${LKMM_HW_MAP_FILE}.theme"
 herdoptions="-model $LKMM_HW_CAT_FILE"
-hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
+hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.litmus.'${LKMM_HW_MAP_FILE}'/'`
 hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
 
 # Don't run on litmus tests with complex synchronization
-- 
2.17.1

