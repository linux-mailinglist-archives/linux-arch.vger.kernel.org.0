Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D9538116A
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 22:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhENUKU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 16:10:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50472 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhENUKT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2021 16:10:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EK40C3009406;
        Fri, 14 May 2021 20:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=XHTJx+Gw+efrfyD467AyIdG7MgU2iHdmVP8/T5c98js=;
 b=y5pWO9/7W1W8BSSFDQePLGlB1oTkrk6WZHIJG/J9ea9Kem98f19guDroqt1zUzp5aKS+
 nlWH9gyunbABvved5yJQckHTxeoeqtq36v0HhM0Q/rkqGpVrRO4FgbcOv8Y2oGxBBto1
 UCPGRtEGHTR0SwwyXnTDarjzvkJARNqp46kR2yMtIspPMTkSGhupfhGCVOxd8QMtiIi6
 EMtZEWTlbXL70+EGHA+WXD+30Pj+uXtvFPcsMha7JW7hr3CQRzb3N/faAlTjNTgNTJRd
 8N6087DD/lLBREaNtW1VDaQje6ZiF+2qjqXAiQrCueJfoqI1ffRYAPbul77dnyGxqzt+ iA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 38gpnen8sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EK60la158899;
        Fri, 14 May 2021 20:08:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38gppqd6qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:08 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14EK87f2161889;
        Fri, 14 May 2021 20:08:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 38gppqd6qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14EK80cq011969;
        Fri, 14 May 2021 20:08:00 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 May 2021 13:08:00 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v15 6/6] locking/qspinlock: Introduce the shuffle reduction optimization into CNA
Date:   Fri, 14 May 2021 16:07:43 -0400
Message-Id: <20210514200743.3026725-7-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514200743.3026725-1-alex.kogan@oracle.com>
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fREsjUSXJkDnALJ_uXvk4qOk1SCZ_ztQ
X-Proofpoint-ORIG-GUID: fREsjUSXJkDnALJ_uXvk4qOk1SCZ_ztQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140159
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
 kernel/locking/qspinlock_cna.h | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index ffc5c3301f0f..17d56c739e57 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -7,6 +7,7 @@
 #include <linux/sched/clock.h>
 #include <linux/moduleparam.h>
 #include <linux/sched/rt.h>
+#include <linux/random.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -76,6 +77,34 @@ static inline bool intra_node_threshold_reached(struct cna_node *cn)
 	return current_time > threshold;
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
@@ -276,6 +305,16 @@ static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
 {
 	struct cna_node *cn = (struct cna_node *)node;
 
+	if (node->locked <= 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) {
+		/*
+		 * When the secondary queue is empty, skip the calls to
+		 * cna_order_queue() below with high probability. This optimization
+		 * reduces the overhead of unnecessary shuffling of threads
+		 * between waiting queues when the lock is only lightly contended.
+		 */
+		return 0;
+	}
+
 	if (!cn->start_time || !intra_node_threshold_reached(cn)) {
 		/*
 		 * We are at the head of the wait queue, no need to use
-- 
2.24.3 (Apple Git-128)

