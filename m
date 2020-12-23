Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B053D2E1899
	for <lists+linux-arch@lfdr.de>; Wed, 23 Dec 2020 06:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgLWFrA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Dec 2020 00:47:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40274 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgLWFrA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Dec 2020 00:47:00 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BN5ie47180845;
        Wed, 23 Dec 2020 05:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=dTZeucsYuMh2VDwfr0gyaa57dunOWTPFnSobSHvKYbc=;
 b=GPVdKO4wlRmgHUakS4aMYAGHwgfcmmG0birKRojh+QC2Yh2oDjv1fcuwN1y3kdiMJWan
 RbBMRPMDqElxG+ir0g4Kn3oe+bzxMC51CvTincelj9dsZ5mw186M4mQwL2rSza4hxc3a
 lP+hDVpHhtwz3ALcsAoOhMIxegGlntER0ZgPjWjNzgts6mcCz/I2KDvm/B5GyXTzpAP4
 X2hEGqPGEUMwVrXTkPQv7RjhFXvSQmF6mGHjRrCNQkLzLtEQlKvbgSELXPFnEj26OB8x
 R9W9KIoyKaCqB5mdLRcQO8RVyeNEwvqSggAjlkwXrXKVraK/9W6DVkvRvj6a/KkZzwEv 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35k0d16bv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Dec 2020 05:45:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BN5e1Tg000820;
        Wed, 23 Dec 2020 05:45:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 35k0eag1dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 05:45:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BN5jBsK014493;
        Wed, 23 Dec 2020 05:45:11 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Dec 2020 21:45:10 -0800
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v13 4/6] locking/qspinlock: Introduce starvation avoidance into CNA
Date:   Wed, 23 Dec 2020 00:44:53 -0500
Message-Id: <20201223054455.1990884-5-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223054455.1990884-1-alex.kogan@oracle.com>
References: <20201223054455.1990884-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9843 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012230042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9843 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012230042
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Keep track of the time the thread at the head of the secondary queue
has been waiting, and force inter-node handoff once this time passes
a preset threshold. The default value for the threshold (10ms) can be
overridden with the new kernel boot command-line option
"numa_spinlock_threshold". The ms value is translated internally to the
nearest rounded-up jiffies.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++
 kernel/locking/qspinlock_cna.h                | 95 ++++++++++++++++---
 2 files changed, 92 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a6ae826c6076..fffd31089db0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3440,6 +3440,15 @@
 			Not specifying this option is equivalent to
 			numa_spinlock=auto.
 
+	numa_spinlock_threshold=	[NUMA, PV_OPS]
+			Set the time threshold in milliseconds for the
+			number of intra-node lock hand-offs before the
+			NUMA-aware spinlock is forced to be passed to
+			a thread on another NUMA node.	Valid values
+			are in the [1..100] range. Smaller values result
+			in a more fair, but less performant spinlock,
+			and vice versa. The default value is 10.
+
 	numa_zonelist_order= [KNL, BOOT] Select zonelist order for NUMA.
 			'node', 'default' can be specified
 			This can be set from sysctl after boot.
diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 590402ad69ef..d3e27549c769 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -37,6 +37,12 @@
  * gradually filter the primary queue, leaving only waiters running on the same
  * preferred NUMA node.
  *
+ * We change the NUMA node preference after a waiter at the head of the
+ * secondary queue spins for a certain amount of time (10ms, by default).
+ * We do that by flushing the secondary queue into the head of the primary queue,
+ * effectively changing the preference to the NUMA node of the waiter at the head
+ * of the secondary queue at the time of the flush.
+ *
  * For more details, see https://arxiv.org/abs/1810.05600.
  *
  * Authors: Alex Kogan <alex.kogan@oracle.com>
@@ -49,13 +55,33 @@ struct cna_node {
 	u16			real_numa_node;
 	u32			encoded_tail;	/* self */
 	u32			partial_order;	/* enum val */
+	s32			start_time;
 };
 
 enum {
 	LOCAL_WAITER_FOUND,
 	LOCAL_WAITER_NOT_FOUND,
+	FLUSH_SECONDARY_QUEUE
 };
 
+/*
+ * Controls the threshold time in ms (default = 10) for intra-node lock
+ * hand-offs before the NUMA-aware variant of spinlock is forced to be
+ * passed to a thread on another NUMA node. The default setting can be
+ * changed with the "numa_spinlock_threshold" boot option.
+ */
+#define MSECS_TO_JIFFIES(m)	\
+	(((m) + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ))
+static int intra_node_handoff_threshold __ro_after_init = MSECS_TO_JIFFIES(10);
+
+static inline bool intra_node_threshold_reached(struct cna_node *cn)
+{
+	s32 current_time = (s32)jiffies;
+	s32 threshold = cn->start_time + intra_node_handoff_threshold;
+
+	return current_time - threshold > 0;
+}
+
 static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 {
 	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
@@ -98,6 +124,7 @@ static __always_inline void cna_init_node(struct mcs_spinlock *node)
 	struct cna_node *cn = (struct cna_node *)node;
 
 	cn->numa_node = cn->real_numa_node;
+	cn->start_time = 0;
 }
 
 /*
@@ -197,8 +224,15 @@ static void cna_splice_next(struct mcs_spinlock *node,
 
 	/* stick `next` on the secondary queue tail */
 	if (node->locked <= 1) { /* if secondary queue is empty */
+		struct cna_node *cn = (struct cna_node *)node;
+
 		/* create secondary queue */
 		next->next = next;
+
+		cn->start_time = (s32)jiffies;
+		/* make sure start_time != 0 iff secondary queue is not empty */
+		if (!cn->start_time)
+			cn->start_time = 1;
 	} else {
 		/* add to the tail of the secondary queue */
 		struct mcs_spinlock *tail_2nd = decode_tail(node->locked);
@@ -249,11 +283,15 @@ static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
 {
 	struct cna_node *cn = (struct cna_node *)node;
 
-	/*
-	 * Try and put the time otherwise spent spin waiting on
-	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
-	 */
-	cn->partial_order = cna_order_queue(node);
+	if (!cn->start_time || !intra_node_threshold_reached(cn)) {
+		/*
+		 * Try and put the time otherwise spent spin waiting on
+		 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
+		 */
+		cn->partial_order = cna_order_queue(node);
+	} else {
+		cn->partial_order = FLUSH_SECONDARY_QUEUE;
+	}
 
 	return 0; /* we lied; we didn't wait, go do so now */
 }
@@ -276,13 +314,29 @@ static inline void cna_lock_handoff(struct mcs_spinlock *node,
 	 */
 	WARN_ON(partial_order == LOCAL_WAITER_NOT_FOUND);
 
-	/*
-	 * We found a local waiter; reload @next in case it was changed by
-	 * cna_order_queue().
-	 */
-	next = node->next;
-	if (node->locked > 1)
-		val = node->locked;	/* preseve secondary queue */
+	if (partial_order == LOCAL_WAITER_FOUND) {
+		/*
+		 * We found a local waiter; reload @next in case it
+		 * was changed by cna_order_queue().
+		 */
+		next = node->next;
+		if (node->locked > 1) {
+			val = node->locked;     /* preseve secondary queue */
+			((struct cna_node *)next)->start_time = cn->start_time;
+		}
+	} else {
+		WARN_ON(partial_order != FLUSH_SECONDARY_QUEUE);
+		/*
+		 * We decided to flush the secondary queue;
+		 * this can only happen if that queue is not empty.
+		 */
+		WARN_ON(node->locked <= 1);
+		/*
+		 * Splice the secondary queue onto the primary queue and pass the lock
+		 * to the longest waiting remote waiter.
+		 */
+		next = cna_splice_head(NULL, 0, node, next);
+	}
 
 	arch_mcs_lock_handoff(&next->locked, val);
 }
@@ -334,3 +388,20 @@ void __init cna_configure_spin_lock_slowpath(void)
 
 	pr_info("Enabling CNA spinlock\n");
 }
+
+static int __init numa_spinlock_threshold_setup(char *str)
+{
+	int param;
+
+	if (get_option(&str, &param)) {
+		/* valid value is between 1 and 100 */
+		if (param <= 0 || param > 100)
+			return 0;
+
+		intra_node_handoff_threshold = msecs_to_jiffies(param);
+		return 1;
+	}
+
+	return 0;
+}
+__setup("numa_spinlock_threshold=", numa_spinlock_threshold_setup);
-- 
2.24.3 (Apple Git-128)

