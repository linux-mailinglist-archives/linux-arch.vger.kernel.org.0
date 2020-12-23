Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D7F2E189B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Dec 2020 06:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgLWFrQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Dec 2020 00:47:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50364 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgLWFq6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Dec 2020 00:46:58 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BN5iGjp036950;
        Wed, 23 Dec 2020 05:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=l4K3+soBf81ftAgup0L66Xd+MstErj6d8Xna4kpbme8=;
 b=kC1wD5kJJWL7wfZmYsp+BFPltxMtYoC8Jp8oexH6OwS4tt7u49aINd+cVGmMgstHSl+r
 U+j26TATYZcgwLr93xsR7VFFR+ORXUoTArDtEKMe+qhRXYMJiGvhkrXaBtzaV5bZmF3s
 ss0YqspX8WFDLAbcmrSSBG8E1RoqOvppoYl2eO7mpHtC9CRP3kzEqlrrIksgQwGqqIqb
 7HidMBD+lDnGyinR8YBgXec3YsNhUA0Rs0rNqj5v1szwDxl7Xi3jd+X2xT8ihlQfVrMt
 15JEwRDy/QbNjUGmTZ+MzssEqSly5Uw4X5VcYi+JmiRo1ZCFpFktJdlol/XNtKdFGkm3 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35k0cw6baa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Dec 2020 05:45:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BN5fc48022684;
        Wed, 23 Dec 2020 05:45:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 35k0e2hnu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 05:45:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BN5jDpC019014;
        Wed, 23 Dec 2020 05:45:13 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Dec 2020 21:45:13 -0800
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v13 6/6] locking/qspinlock: Introduce the shuffle reduction optimization into CNA
Date:   Wed, 23 Dec 2020 00:44:55 -0500
Message-Id: <20201223054455.1990884-7-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223054455.1990884-1-alex.kogan@oracle.com>
References: <20201223054455.1990884-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9843 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012230042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9843 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012230042
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This performance optimization chooses probabilistically to avoid moving
threads from the main queue into the secondary one when the secondary queue
is empty.

It is helpful when the lock is only lightly contended. In particular, it
makes CNA less eager to create a secondary queue, but does not introduce
any extra delays for threads waiting in that queue once it is created.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock_cna.h | 39 +++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index ac3109ab0a84..621399242735 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -5,6 +5,7 @@
 
 #include <linux/topology.h>
 #include <linux/sched/rt.h>
+#include <linux/random.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -86,6 +87,34 @@ static inline bool intra_node_threshold_reached(struct cna_node *cn)
 	return current_time - threshold > 0;
 }
 
+/*
+ * Controls the probability for enabling the ordering of the main queue
+ * when the secondary queue is empty. The chosen value reduces the amount
+ * of unnecessary shuffling of threads between the two waiting queues
+ * when the contention is low, while responding fast enough and enabling
+ * the shuffling when the contention is high.
+ */
+#define SHUFFLE_REDUCTION_PROB_ARG  (7)
+
+/* Per-CPU pseudo-random number seed */
+static DEFINE_PER_CPU(u32, seed);
+
+/*
+ * Return false with probability 1 / 2^@num_bits.
+ * Intuitively, the larger @num_bits the less likely false is to be returned.
+ * @num_bits must be a number between 0 and 31.
+ */
+static bool probably(unsigned int num_bits)
+{
+	u32 s;
+
+	s = this_cpu_read(seed);
+	s = next_pseudo_random32(s);
+	this_cpu_write(seed, s);
+
+	return s & ((1 << num_bits) - 1);
+}
+
 static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 {
 	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
@@ -290,7 +319,15 @@ static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
 {
 	struct cna_node *cn = (struct cna_node *)node;
 
-	if (!cn->start_time || !intra_node_threshold_reached(cn)) {
+	if (node->locked <= 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) {
+		/*
+		 * When the secondary queue is empty, skip the call to
+		 * cna_order_queue() with high probability. This optimization
+		 * reduces the overhead of unnecessary shuffling of threads
+		 * between waiting queues when the lock is only lightly contended.
+		 */
+		cn->partial_order = LOCAL_WAITER_FOUND;
+	} else if (!cn->start_time || !intra_node_threshold_reached(cn)) {
 		/*
 		 * We are at the head of the wait queue, no need to use
 		 * the fake NUMA node ID.
-- 
2.24.3 (Apple Git-128)

