Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4970726AB91
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 20:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgIOSLV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 14:11:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42810 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbgIOSJQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 14:09:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FHwnx2078388;
        Tue, 15 Sep 2020 18:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=xSmDvkQkMYEWD7WRdYuNVEN2qfEEyomzGbWMzSTkEsw=;
 b=ZSb2CmhktBSZTNFLJKcKY+Jk3juA6JFLokE5btJ3XUl/B87Ye0+XBmb+PcqAeYO/85pZ
 aTr8cugz8k+vCewg0w8iQXSxwVkzQPCoQImlwZH913Ubcrksq/GZIsJL0/CPJKXKBvTA
 n5w7rWqgUGjJ2ihB27+mt4Iy5FXY9OtZJ12jIgW0szAUC8vGNd6rl24N7wE61vlprjLa
 bz+AuQm4Jwsaup+y5DXYJUNfyXNlh4/6A4xeuVwRfK9Y8PAPIOot8uAJW0yMmDfsAsPg
 a+0ixEPl6okQr0yUnInx1JjzhjaZutstrbj2Ah8+WfKQMRDTf4Oq0xGbKpFaS98Jqi47 Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33gp9m6r06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 18:07:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FI5p1C062230;
        Tue, 15 Sep 2020 18:05:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33hm310msy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 18:05:54 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08FI5oYW000920;
        Tue, 15 Sep 2020 18:05:50 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 18:05:50 +0000
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v11 4/5] locking/qspinlock: Introduce starvation avoidance into CNA
Date:   Tue, 15 Sep 2020 14:05:34 -0400
Message-Id: <20200915180535.2975060-5-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200915180535.2975060-1-alex.kogan@oracle.com>
References: <20200915180535.2975060-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150145
Sender: linux-arch-owner@vger.kernel.org
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
index 51ce050f8701..73ab23a47b97 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3363,6 +3363,15 @@
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
 	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
 			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
 			Some features depend on CPU0. Known dependencies are:
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
2.21.1 (Apple Git-122.3)

