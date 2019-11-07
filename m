Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A1CF363D
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2019 18:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfKGRwj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Nov 2019 12:52:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58318 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389492AbfKGRwi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Nov 2019 12:52:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7Hj16l001455;
        Thu, 7 Nov 2019 17:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=pVKPWMvFyUwJRTNG5MI/Esw+TNiMEp1xgevCif494n0=;
 b=eXgXIGaWhFLt4RWw6WoCMBO6/l3d1UOMLrMt0Gz+bhQFmL9ReiJeP5JefHRnvZomrrYC
 MjXnvmT950PbjpM0jjsVhjHxm9kOgRvTuhP2k6aOQcapIR+RRzQSoZZNgBaV246Qj+zC
 eVrwchJTGeeThTiE/eA0blHtng7yzy9XNzijkBV1f3RvqdyGTIwxI3YWrvl/kf7/arbe
 uvQZzM0bPoAewjmv77tcRdI6091CiUuVJqC7wtuRt54p1XyjkYTG8qUa7KkJLllyJ5/R
 fx3ukPpJgcYbalHsVSVzG0RXOSXDTWYL8UFktvhtHVO6vDei34cLAMUQSQ9zmy317gW4 zA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w41w0ywtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 17:51:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7Hj7Vk076960;
        Thu, 7 Nov 2019 17:51:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2w41wacfmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 17:51:27 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA7HpO3Y007851;
        Thu, 7 Nov 2019 17:51:24 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 09:51:24 -0800
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: [PATCH v6 5/5] locking/qspinlock: Introduce the shuffle reduction optimization into CNA
Date:   Thu,  7 Nov 2019 12:46:22 -0500
Message-Id: <20191107174622.61718-6-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191107174622.61718-1-alex.kogan@oracle.com>
References: <20191107174622.61718-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070165
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This optimization reduces the probability threads will be shuffled between
the main and secondary queues when the secondary queue is empty.
It is helpful when the lock is only lightly contended.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock_cna.h | 50 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 916c9083e8ec..0549ce40dc75 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,7 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/random.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -50,7 +51,7 @@ struct cna_node {
 	struct mcs_spinlock	mcs;
 	int			numa_node;
 	u32			encoded_tail;
-	u32			pre_scan_result; /* 0, 1 or encoded tail */
+	u32			pre_scan_result; /* 0, 1, 2 or encoded tail */
 	u32			intra_count;
 };
 
@@ -60,6 +61,34 @@ struct cna_node {
  */
 extern int intra_node_handoff_threshold;
 
+/*
+ * Controls the probability for enabling the scan of the main queue when
+ * the secondary queue is empty. The chosen value reduces the amount of
+ * unnecessary shuffling of threads between the two waiting queues when
+ * the contention is low, while responding fast enough and enabling
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
@@ -72,11 +101,11 @@ static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 		cn->numa_node = numa_node;
 		cn->encoded_tail = encode_tail(cpu, i);
 		/*
-		 * @encoded_tail has to be larger than 1, so we do not confuse
+		 * @encoded_tail has to be larger than 2, so we do not confuse
 		 * it with other valid values for @locked or @pre_scan_result
-		 * (0 or 1)
+		 * (0, 1 or 2)
 		 */
-		WARN_ON(cn->encoded_tail <= 1);
+		WARN_ON(cn->encoded_tail <= 2);
 	}
 }
 
@@ -230,12 +259,13 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock,
 	struct cna_node *cn = (struct cna_node *)node;
 
 	/*
-	 * setting @pre_scan_result to 1 indicates that no post-scan
+	 * setting @pre_scan_result to 1 or 2 indicates that no post-scan
 	 * should be made in cna_pass_lock()
 	 */
 	cn->pre_scan_result =
-		cn->intra_count == intra_node_handoff_threshold ?
-			1 : cna_scan_main_queue(node, node);
+		(node->locked <= 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
+			1 : cn->intra_count == intra_node_handoff_threshold ?
+			2 : cna_scan_main_queue(node, node);
 
 	return 0;
 }
@@ -249,12 +279,15 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 
 	u32 scan = cn->pre_scan_result;
 
+	if (scan == 1)
+		goto pass_lock;
+
 	/*
 	 * check if a successor from the same numa node has not been found in
 	 * pre-scan, and if so, try to find it in post-scan starting from the
 	 * node where pre-scan stopped (stored in @pre_scan_result)
 	 */
-	if (scan > 1)
+	if (scan > 2)
 		scan = cna_scan_main_queue(node, decode_tail(scan));
 
 	if (!scan) { /* if found a successor from the same numa node */
@@ -277,5 +310,6 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 		tail_2nd->next = next;
 	}
 
+pass_lock:
 	arch_mcs_pass_lock(&next_holder->locked, val);
 }
-- 
2.11.0 (Apple Git-81)

