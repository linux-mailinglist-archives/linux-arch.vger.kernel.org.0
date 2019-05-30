Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7493F2FE5B
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfE3Oop (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:44:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726684AbfE3Omc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEg5wH032961
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:31 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stfmbd7ue-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:31 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:30 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:42:25 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEgO3P41484778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:42:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8358B206E;
        Thu, 30 May 2019 14:42:24 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B99ACB2065;
        Thu, 30 May 2019 14:42:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:42:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 80A5016C373B; Thu, 30 May 2019 07:42:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 02/33] tools/memory-model: Add definitions of plain and marked accesses
Date:   Thu, 30 May 2019 07:41:54 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0072-0000-0000-000004354C30
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210779; UDB=6.00636154; IPR=6.00991814;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:42:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0073-0000-0000-00004C6B56B2
Message-Id: <20190530144225.27624-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=726 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300105
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch adds definitions for marked and plain accesses to the
Linux-Kernel Memory Model.  It also modifies the definitions of the
existing parts of the model (including the cumul-fence, prop, hb, pb,
and rb relations) so as to make them apply only to marked accesses.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/linux-kernel.bell |  5 +++++
 tools/memory-model/linux-kernel.cat  | 16 +++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index def9131d3d8e..b60eb5a01053 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -76,3 +76,8 @@ flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
 
 (* Validate SRCU dynamic match *)
 flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
+
+(* Compute marked and plain memory accesses *)
+let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
+		LKR | LKW | UL | LF | RL | RU
+let Plain = M \ Marked
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 834107022c50..ff354e5ffd4b 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -65,19 +65,21 @@ let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
-let to-r = addr | (dep ; rfi)
+let to-r = addr | (dep ; [Marked] ; rfi)
 let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
-let A-cumul(r) = rfe? ; r
-let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | po-unlock-rf-lock-po
-let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
+let A-cumul(r) = (rfe ; [Marked])? ; r
+let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
+	po-unlock-rf-lock-po) ; [Marked]
+let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
+	[Marked] ; rfe? ; [Marked]
 
 (*
  * Happens Before: Ordering from the passage of time.
  * No fences needed here for prop because relation confined to one process.
  *)
-let hb = ppo | rfe | ((prop \ id) & int)
+let hb = [Marked] ; (ppo | rfe | ((prop \ id) & int)) ; [Marked]
 acyclic hb as happens-before
 
 (****************************************)
@@ -85,7 +87,7 @@ acyclic hb as happens-before
 (****************************************)
 
 (* Propagation: Each non-rf link needs a strong fence. *)
-let pb = prop ; strong-fence ; hb*
+let pb = prop ; strong-fence ; hb* ; [Marked]
 acyclic pb as propagation
 
 (*******)
@@ -133,7 +135,7 @@ let rec rcu-fence = rcu-gp | srcu-gp |
 	(rcu-fence ; rcu-link ; rcu-fence)
 
 (* rb orders instructions just as pb does *)
-let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb*
+let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb* ; [Marked]
 
 irreflexive rb as rcu
 
-- 
2.17.1

