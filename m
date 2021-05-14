Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937A3381172
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhENUK0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 16:10:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54790 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhENUKX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2021 16:10:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EK4xiO144173;
        Fri, 14 May 2021 20:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=0l7Qx4lQyWqOqvgqs2v2Ly65peNTNdVGyEpzX0zdBVM=;
 b=sG2MPjIX3veBuWtdCnRjux2djEMtwPKKoyZYkd4kW4ZZOxKEcQM/K1MwSepAETxPHwTk
 bHxdHWbwBs//YeGhOArFPHU8mvGYQERNw8DyfhLJdskJKa+E/dmF6s4pQN/2g0OQiTD9
 NayqT7kmtrZJoREDJvBNUY3ruCiKfxNqjtGKtp3rRIWmU5aIMworHRep+WN1MaJ5mzvq
 pjYLIppzjsPx6AkLiIRyOs6FlIxTHY6rgHcXycj5KI88EFeHD5cCL0nrh8n3a4fIs5u6
 4TAd0fyWT5n04Y35PcXh167lsnM6EwgiyZFeffY4Ea+M4ZdO/5OauExeYQLVH9WpfChX 1g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38gpnun8et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EK6EW3099107;
        Fri, 14 May 2021 20:08:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38gpphgtvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:09 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14EK88AS102085;
        Fri, 14 May 2021 20:08:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 38gpphgtuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14EK7wHB011263;
        Fri, 14 May 2021 20:07:58 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 May 2021 13:07:57 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v15 4/6] locking/qspinlock: Introduce starvation avoidance into CNA
Date:   Fri, 14 May 2021 16:07:41 -0400
Message-Id: <20210514200743.3026725-5-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514200743.3026725-1-alex.kogan@oracle.com>
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0KcFYQ_2J-gxhelsZ5BqVzsOl0G1cHye
X-Proofpoint-GUID: 0KcFYQ_2J-gxhelsZ5BqVzsOl0G1cHye
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140159
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Keep track of the time the thread at the head of the secondary queue
has been waiting, and force inter-node handoff once this time passes
a preset threshold. The default value for the threshold (1ms) can be
overridden with the new kernel boot command-line option
"qspinlock.numa_spinlock_threshold_ns".

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++
 kernel/locking/qspinlock_cna.h                | 81 +++++++++++++++----
 2 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 94d35507560c..e2bcf6f4e048 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4183,6 +4183,14 @@
 			[KNL] Number of legacy pty's. Overwrites compiled-in
 			default number.
 
+	qspinlock.numa_spinlock_threshold_ns=	[NUMA, PV_OPS]
+			Set the time threshold in nanoseconds for the
+			number of intra-node lock hand-offs before the
+			NUMA-aware spinlock is forced to be passed to
+			a thread on another NUMA node. Smaller values
+			result in a more fair, but less performant spinlock,
+			and vice versa. The default value is 1000000 (=1ms).
+
 	quiet		[KNL] Disable most log messages
 
 	r128=		[HW,DRM]
diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index ca564e64e5de..0b991c340fb1 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,8 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/sched/clock.h>
+#include <linux/moduleparam.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -37,19 +39,39 @@
  * gradually filter the primary queue, leaving only waiters running on the same
  * preferred NUMA node.
  *
+ * We change the NUMA node preference after a waiter at the head of the
+ * secondary queue spins for a certain amount of time (1ms, by default).
+ * We do that by flushing the secondary queue into the head of the primary queue,
+ * effectively changing the preference to the NUMA node of the waiter at the head
+ * of the secondary queue at the time of the flush.
+ *
  * For more details, see https://arxiv.org/abs/1810.05600.
  *
  * Authors: Alex Kogan <alex.kogan@oracle.com>
  *          Dave Dice <dave.dice@oracle.com>
  */
 
+#define FLUSH_SECONDARY_QUEUE	1
+
 struct cna_node {
 	struct mcs_spinlock	mcs;
 	u16			numa_node;
 	u16			real_numa_node;
 	u32			encoded_tail;	/* self */
+	u64			start_time;
 };
 
+static ulong numa_spinlock_threshold_ns = 1000000;   /* 1ms, by default */
+module_param(numa_spinlock_threshold_ns, ulong, 0644);
+
+static inline bool intra_node_threshold_reached(struct cna_node *cn)
+{
+	u64 current_time = local_clock();
+	u64 threshold = cn->start_time + numa_spinlock_threshold_ns;
+
+	return current_time > threshold;
+}
+
 static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 {
 	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
@@ -92,6 +114,7 @@ static __always_inline void cna_init_node(struct mcs_spinlock *node)
 	struct cna_node *cn = (struct cna_node *)node;
 
 	cn->numa_node = cn->real_numa_node;
+	cn->start_time = 0;
 }
 
 /*
@@ -191,8 +214,14 @@ static void cna_splice_next(struct mcs_spinlock *node,
 
 	/* stick `next` on the secondary queue tail */
 	if (node->locked <= 1) { /* if secondary queue is empty */
+		struct cna_node *cn = (struct cna_node *)node;
+
 		/* create secondary queue */
 		next->next = next;
+
+		cn->start_time = local_clock();
+		/* secondary queue is not empty iff start_time != 0 */
+		WARN_ON(!cn->start_time);
 	} else {
 		/* add to the tail of the secondary queue */
 		struct mcs_spinlock *tail_2nd = decode_tail(node->locked);
@@ -240,12 +269,18 @@ static int cna_order_queue(struct mcs_spinlock *node)
 static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
 						 struct mcs_spinlock *node)
 {
-	/*
-	 * Try and put the time otherwise spent spin waiting on
-	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
-	 */
-	while (LOCK_IS_BUSY(lock) && !cna_order_queue(node))
-		cpu_relax();
+	struct cna_node *cn = (struct cna_node *)node;
+
+	if (!cn->start_time || !intra_node_threshold_reached(cn)) {
+		/*
+		 * Try and put the time otherwise spent spin waiting on
+		 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
+		 */
+		while (LOCK_IS_BUSY(lock) && !cna_order_queue(node))
+			cpu_relax();
+	} else {
+		cn->start_time = FLUSH_SECONDARY_QUEUE;
+	}
 
 	return 0; /* we lied; we didn't wait, go do so now */
 }
@@ -253,24 +288,38 @@ static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
 static inline void cna_lock_handoff(struct mcs_spinlock *node,
 				 struct mcs_spinlock *next)
 {
+	struct cna_node *cn = (struct cna_node *)node;
 	u32 val = 1;
 
-	if (node->locked > 1) {
-		struct cna_node *cn = (struct cna_node *)node;
+	if (cn->start_time != FLUSH_SECONDARY_QUEUE) {
+		if (node->locked > 1) {
+			val = node->locked;	/* preseve secondary queue */
+
+			/*
+			 * We have a local waiter, either real or fake one;
+			 * reload @next in case it was changed by cna_order_queue().
+			 */
+			next = node->next;
 
-		val = node->locked;	/* preseve secondary queue */
+			/*
+			 * Pass over NUMA node id of primary queue, to maintain the
+			 * preference even if the next waiter is on a different node.
+			 */
+			((struct cna_node *)next)->numa_node = cn->numa_node;
 
+			((struct cna_node *)next)->start_time = cn->start_time;
+		}
+	} else {
 		/*
-		 * We have a local waiter, either real or fake one;
-		 * reload @next in case it was changed by cna_order_queue().
+		 * We decided to flush the secondary queue;
+		 * this can only happen if that queue is not empty.
 		 */
-		next = node->next;
-
+		WARN_ON(node->locked <= 1);
 		/*
-		 * Pass over NUMA node id of primary queue, to maintain the
-		 * preference even if the next waiter is on a different node.
+		 * Splice the secondary queue onto the primary queue and pass the lock
+		 * to the longest waiting remote waiter.
 		 */
-		((struct cna_node *)next)->numa_node = cn->numa_node;
+		next = cna_splice_head(NULL, 0, node, next);
 	}
 
 	arch_mcs_lock_handoff(&next->locked, val);
-- 
2.24.3 (Apple Git-128)

