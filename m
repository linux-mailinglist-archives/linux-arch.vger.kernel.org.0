Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E237E583
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2019 00:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389472AbfHAWVH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Aug 2019 18:21:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389466AbfHAWVG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MGwk5140413
        for <linux-arch@vger.kernel.org>; Thu, 1 Aug 2019 18:21:05 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u455v7u34-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 01 Aug 2019 18:21:05 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:21:04 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 23:20:59 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MKwD253674382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:20:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3855DB2066;
        Thu,  1 Aug 2019 22:20:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23F81B205F;
        Thu,  1 Aug 2019 22:20:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:20:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2013316C9A63; Thu,  1 Aug 2019 15:20:59 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 30/31] tools/memory-model: Use cumul-fence instead of fence in ->prop example
Date:   Thu,  1 Aug 2019 15:20:55 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080122-0060-0000-0000-000003677020
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240728; UDB=6.00654291; IPR=6.01022153;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 22:21:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080122-0061-0000-0000-00004A626D0F
Message-Id: <20190801222056.12144-30-paulmck@linux.ibm.com>
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

To reduce ambiguity in the more exotic ->prop ordering example, this
commit uses the term cumul-fence instead of the term fence for the two
fences, so that the implict ->rfe on loads/stores to Y are covered by
the description.

Link: https://lore.kernel.org/lkml/20190729121745.GA140682@google.com

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/Documentation/explanation.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 68caa9a976d0..634dc6db26c4 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1302,7 +1302,7 @@ followed by an arbitrary number of cumul-fence links, ending with an
 rfe link.  You can concoct more exotic examples, containing more than
 one fence, although this quickly leads to diminishing returns in terms
 of complexity.  For instance, here's an example containing a coe link
-followed by two fences and an rfe link, utilizing the fact that
+followed by two cumul-fences and an rfe link, utilizing the fact that
 release fences are A-cumulative:
 
 	int x, y, z;
@@ -1334,10 +1334,10 @@ If x = 2, r0 = 1, and r2 = 1 after this code runs then there is a prop
 link from P0's store to its load.  This is because P0's store gets
 overwritten by P1's store since x = 2 at the end (a coe link), the
 smp_wmb() ensures that P1's store to x propagates to P2 before the
-store to y does (the first fence), the store to y propagates to P2
+store to y does (the first cumul-fence), the store to y propagates to P2
 before P2's load and store execute, P2's smp_store_release()
 guarantees that the stores to x and y both propagate to P0 before the
-store to z does (the second fence), and P0's load executes after the
+store to z does (the second cumul-fence), and P0's load executes after the
 store to z has propagated to P0 (an rfe link).
 
 In summary, the fact that the hb relation links memory access events
-- 
2.17.1

