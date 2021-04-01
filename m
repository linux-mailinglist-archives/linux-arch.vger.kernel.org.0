Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A97351DF3
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 20:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhDASdZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 14:33:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52500 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbhDAS1y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 14:27:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131FPOoF176752;
        Thu, 1 Apr 2021 15:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=T0MWikKGNzZ7RZia50CndXflubXFeWns/L+OAB/N2sY=;
 b=pDVgX2iRNMVNHWDK01nC0Qr+248CKENMbAJN3AFlQshXPlLgUBWnOnlEMxsS/MvffDvt
 cO/VJW2dCujOLRfcIKE0dEAvsX0WmXUxmiMGBbU4UB7DhcuTSAsD7hNuLOXyYP5H1Rew
 pDaklv2JSUYKaIKh87IpfBSGamtEsVf263MrUqHlqtsIMY+jaK+K3zvsmajlQI9g6/aU
 8gcNC0H/J7nfOayylhmUYZrDWLWwnmJW8q4Y0KpyQ2G+1XA1xXbkoOriYK1eFwaJiIpR
 Xc2SbRLxsZKUWXJa5RlgV/VIaBqZ9kz7tlEKLryw+pHSi/XIIkRzZeaLOcy7+6mVrXk6 CQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37n30sa773-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 15:32:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131FLw3A024247;
        Thu, 1 Apr 2021 15:32:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 37n2asea1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 15:32:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 131FWHp4016838;
        Thu, 1 Apr 2021 15:32:17 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Apr 2021 08:32:17 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v14 6/6] locking/qspinlock: Introduce the shuffle reduction optimization into CNA
Date:   Thu,  1 Apr 2021 11:31:56 -0400
Message-Id: <20210401153156.1165900-7-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401153156.1165900-1-alex.kogan@oracle.com>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010104
X-Proofpoint-GUID: Suax28I4h68d2rkveiReGBIh8bcE8Is2
X-Proofpoint-ORIG-GUID: Suax28I4h68d2rkveiReGBIh8bcE8Is2
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010104
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
index 29c3abbd3d94..983c6a47a221 100644
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
@@ -293,6 +322,16 @@ static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
 {
 	struct cna_node *cn = (struct cna_node *)node;
 
+	if (node->locked <= 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) {
+		/*
+		 * When the secondary queue is empty, skip the call to
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

