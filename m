Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B152FE58
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfE3Ood (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:44:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727094AbfE3Omd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEdNPt144641
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:32 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgu3s3yn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:32 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:31 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:42:26 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEgPBZ30736428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:42:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02F26B2065;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5231B2066;
        Thu, 30 May 2019 14:42:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:42:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 85D6B16C5D7E; Thu, 30 May 2019 07:42:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 03/33] tools/memory-model: Add data-race detection
Date:   Thu, 30 May 2019 07:41:55 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0052-0000-0000-000003C911B0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011184; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210780; UDB=6.00636154; IPR=6.00991814;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:42:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0053-0000-0000-0000611A0B5F
Message-Id: <20190530144225.27624-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=922 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300105
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch adds data-race detection to the Linux-Kernel Memory Model.
As part of this effort, support is added for:

	compiler barriers (the barrier() function), and

	a new Preserved Program Order term: (addr ; [Plain] ; wmb)

Data races are marked with a special Flag warning in herd.  It is
not guaranteed that the model will provide accurate predictions when a
data race is present.

The patch does not include documentation for the data-race detection
facility.  The basic design has been explained in various emails, and
a separate documentation patch will be submitted later.

This work is based on an earlier formulation of data races for the
LKMM by Andrea Parri.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/linux-kernel.bell |  1 +
 tools/memory-model/linux-kernel.cat  | 50 +++++++++++++++++++++++++++-
 tools/memory-model/linux-kernel.def  |  1 +
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index b60eb5a01053..5be86b1025e8 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -24,6 +24,7 @@ instructions RMW[{'once,'acquire,'release}]
 enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
 		'mb (*smp_mb*) ||
+		'barrier (*barrier*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
 		'sync-rcu (*synchronize_rcu*) ||
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index ff354e5ffd4b..36d367054811 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -44,6 +44,9 @@ let strong-fence = mb | gp
 
 let nonrw-fence = strong-fence | po-rel | acq-po
 let fence = nonrw-fence | wmb | rmb
+let barrier = fencerel(Barrier | Rmb | Wmb | Mb | Sync-rcu | Sync-srcu |
+		Before-atomic | After-atomic | Acquire | Release) |
+	(po ; [Release]) | ([Acquire] ; po)
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -64,7 +67,7 @@ empty rmw & (fre ; coe) as atomic
 let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
-let to-w = rwdep | (overwrite & int)
+let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
 let to-r = addr | (dep ; [Marked] ; rfi)
 let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
 
@@ -147,3 +150,48 @@ irreflexive rb as rcu
  * let xb = hb | pb | rb
  * acyclic xb as executes-before
  *)
+
+(*********************************)
+(* Plain accesses and data races *)
+(*********************************)
+
+(* Warn about plain writes and marked accesses in the same region *)
+let mixed-accesses = ([Plain & W] ; (po-loc \ barrier) ; [Marked]) |
+	([Marked] ; (po-loc \ barrier) ; [Plain & W])
+flag ~empty mixed-accesses as mixed-accesses
+
+(* Executes-before and visibility *)
+let xbstar = (hb | pb | rb)*
+let full-fence = strong-fence | (po ; rcu-fence ; po?)
+let vis = cumul-fence* ; rfe? ; [Marked] ;
+	((full-fence ; [Marked] ; xbstar) | (xbstar & int))
+
+(* Boundaries for lifetimes of plain accesses *)
+let w-pre-bounded = [Marked] ; (addr | fence)?
+let r-pre-bounded = [Marked] ; (addr | nonrw-fence |
+	([R4rmb] ; fencerel(Rmb) ; [~Noreturn]))?
+let w-post-bounded = fence? ; [Marked]
+let r-post-bounded = (nonrw-fence | ([~Noreturn] ; fencerel(Rmb) ; [R4rmb]))? ;
+	[Marked]
+
+(* Visibility and executes-before for plain accesses *)
+let ww-vis = w-post-bounded ; vis ; w-pre-bounded
+let wr-vis = w-post-bounded ; vis ; r-pre-bounded
+let rw-xbstar = r-post-bounded ; xbstar ; w-pre-bounded
+
+(* Potential races *)
+let pre-race = ext & ((Plain * M) | ((M \ IW) * Plain))
+
+(* Coherence requirements for plain accesses *)
+let wr-incoh = pre-race & rf & rw-xbstar^-1
+let rw-incoh = pre-race & fr & wr-vis^-1
+let ww-incoh = pre-race & co & ww-vis^-1
+empty (wr-incoh | rw-incoh | ww-incoh) as plain-coherence
+
+(* Actual races *)
+let ww-nonrace = ww-vis & ((Marked * W) | rw-xbstar) & ((W * Marked) | wr-vis)
+let ww-race = (pre-race & co) \ ww-nonrace
+let wr-race = (pre-race & (co? ; rf)) \ wr-vis
+let rw-race = (pre-race & fr) \ rw-xbstar
+
+flag ~empty (ww-race | wr-race | rw-race) as data-race
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 551eeaa389d4..ef0f3c1850de 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -24,6 +24,7 @@ smp_mb__before_atomic() { __fence{before-atomic}; }
 smp_mb__after_atomic() { __fence{after-atomic}; }
 smp_mb__after_spinlock() { __fence{after-spinlock}; }
 smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }
+barrier() { __fence{barrier}; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)
-- 
2.17.1

