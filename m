Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0262B7236
	for <lists+linux-arch@lfdr.de>; Wed, 18 Nov 2020 00:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgKQXVI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Nov 2020 18:21:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44856 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgKQXVH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Nov 2020 18:21:07 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHNDeGn099806;
        Tue, 17 Nov 2020 23:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=zBL5BAUEhYhdIPvRI+2kng+aaDFLCZfcYOytq8dMIi0=;
 b=dZc2BtLfS49rPyD8h0J/MnTUnYj2Rs9tHIshUyT5AsLqeEM8gNi6g7VAsNXsFWut17Ca
 GWKYOKfCCLbpEVr6dpPh0FOGoOPNCk90Kf4WqnefBz0UYUQAknJgU+IVCG2tOSIDJ6ct
 qUXxJ/TsvVrOsxeMqkDl3rF8wMk43mgfSRGYIiBovEnV/u7AOIlnDWVmmS0lrLWbT09O
 dXn4A7Ux1Ws6vQukv8BPFeQ7n7Xsj2pOUkn9wiWn3GMYQ/AvObnjNyHjgCQV+DV3HiyI
 d4UiVcCQvSccGgUYZGopO96PCMVUEyDCL69wiOjf/vgZGDyLM3EqTjCcseQT1zYsbvwP 8A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34t7vn59ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 23:13:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHN5bYa161369;
        Tue, 17 Nov 2020 23:13:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34uspu1abx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 23:13:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AHNDbDG032331;
        Tue, 17 Nov 2020 23:13:37 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 15:13:36 -0800
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v12 5/5] locking/qspinlock: Avoid moving certain threads between waiting queues in CNA
Date:   Tue, 17 Nov 2020 18:13:23 -0500
Message-Id: <20201117231323.797104-6-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117231323.797104-1-alex.kogan@oracle.com>
References: <20201117231323.797104-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170173
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Prohibit moving certain threads (e.g., in irq and nmi contexts)
to the secondary queue. Those prioritized threads will always stay
in the primary queue, and so will have a shorter wait time for the lock.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock_cna.h | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index d3e2754..ac3109a 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,7 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/sched/rt.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -35,7 +36,8 @@
  * running on the same NUMA node. If it is not, that waiter is detached from the
  * main queue and moved into the tail of the secondary queue. This way, we
  * gradually filter the primary queue, leaving only waiters running on the same
- * preferred NUMA node.
+ * preferred NUMA node. Note that certain priortized waiters (e.g., in
+ * irq and nmi contexts) are excluded from being moved to the secondary queue.
  *
  * We change the NUMA node preference after a waiter at the head of the
  * secondary queue spins for a certain amount of time (10ms, by default).
@@ -49,6 +51,8 @@
  *          Dave Dice <dave.dice@oracle.com>
  */
 
+#define CNA_PRIORITY_NODE      0xffff
+
 struct cna_node {
 	struct mcs_spinlock	mcs;
 	u16			numa_node;
@@ -121,9 +125,10 @@ static int __init cna_init_nodes(void)
 
 static __always_inline void cna_init_node(struct mcs_spinlock *node)
 {
+	bool priority = !in_task() || irqs_disabled() || rt_task(current);
 	struct cna_node *cn = (struct cna_node *)node;
 
-	cn->numa_node = cn->real_numa_node;
+	cn->numa_node = priority ? CNA_PRIORITY_NODE : cn->real_numa_node;
 	cn->start_time = 0;
 }
 
@@ -262,11 +267,13 @@ static u32 cna_order_queue(struct mcs_spinlock *node)
 	next_numa_node = ((struct cna_node *)next)->numa_node;
 
 	if (next_numa_node != numa_node) {
-		struct mcs_spinlock *nnext = READ_ONCE(next->next);
+		if (next_numa_node != CNA_PRIORITY_NODE) {
+			struct mcs_spinlock *nnext = READ_ONCE(next->next);
 
-		if (nnext) {
-			cna_splice_next(node, next, nnext);
-			next = nnext;
+			if (nnext) {
+				cna_splice_next(node, next, nnext);
+				next = nnext;
+			}
 		}
 		/*
 		 * Inherit NUMA node id of primary queue, to maintain the
@@ -285,6 +292,13 @@ static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
 
 	if (!cn->start_time || !intra_node_threshold_reached(cn)) {
 		/*
+		 * We are at the head of the wait queue, no need to use
+		 * the fake NUMA node ID.
+		 */
+		if (cn->numa_node == CNA_PRIORITY_NODE)
+			cn->numa_node = cn->real_numa_node;
+
+		/*
 		 * Try and put the time otherwise spent spin waiting on
 		 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
 		 */
-- 
2.7.4

