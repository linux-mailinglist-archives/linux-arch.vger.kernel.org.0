Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAA719E021
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 23:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgDCVIx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 17:08:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39910 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCVIx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2020 17:08:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033KhhTt091836;
        Fri, 3 Apr 2020 21:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=TtLHzm/fAavdPCwUfplzv3vaOlv84S3xZrjh4mR8mjc=;
 b=jIIolrsDC46mFqnqJVL9yEGmUNpcxm91Qixwo8+RJME7MI9r6AwGwNblvDFefTkh9Gh6
 RGAJYJh9Imt6l62gYtYJvAx4sG8hLzH0231QsQScA/hXPn0wHSFr8QJCSfoNXji1qps8
 PpozIsaeuvaOSoan5NFi26neI2LooglDKXdYqTGT7lIgiP5AyngG9Rck2dYIgeXrGjQj
 kykm/eklnaBxAXCo+PYGG8apFmaU5tErcz8VZLJGHfcGFKK1YKqdkoPV4YC1MCqOlCiA
 dOWngs594LmEs7LXysU5L0aWCHm1Hg11DqfxJpwn4bjn2Hjn6MbWopFA96C+zL4dRSoQ vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 303aqj3px2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 21:05:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033Kh2k9187961;
        Fri, 3 Apr 2020 21:05:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 302g2nxnht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 21:05:50 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033L5hdS031747;
        Fri, 3 Apr 2020 21:05:43 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 14:05:43 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v10 5/5] locking/qspinlock: Avoid moving certain threads between waiting queues in CNA
Date:   Fri,  3 Apr 2020 16:59:30 -0400
Message-Id: <20200403205930.1707-6-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200403205930.1707-1-alex.kogan@oracle.com>
References: <20200403205930.1707-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
Sender: linux-arch-owner@vger.kernel.org
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
 kernel/locking/qspinlock_cna.h | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index e3180f6f5cdc..b004ce6882b6 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,7 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/sched/rt.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -41,6 +42,9 @@
  * lock is passed to the next thread in the primary queue. To avoid starvation
  * of threads in the secondary queue, those threads are moved back to the head
  * of the primary queue after a certain number of intra-node lock hand-offs.
+ * Lastly, certain threads (e.g., in irq and nmi contexts) are given
+ * preferential treatment -- the scan stops when such a thread is found,
+ * effectively never moving those threads into the secondary queue.
  *
  * For more details, see https://arxiv.org/abs/1810.05600.
  *
@@ -50,7 +54,7 @@
 
 struct cna_node {
 	struct mcs_spinlock	mcs;
-	int			numa_node;
+	int			numa_node;	/* use LSB for priority */
 	u32			encoded_tail;	/* self */
 	u32			partial_order;	/* encoded tail or enum val */
 	u32			intra_count;
@@ -79,7 +83,7 @@ static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 	for (i = 0; i < MAX_NODES; i++) {
 		struct cna_node *cn = (struct cna_node *)grab_mcs_node(base, i);
 
-		cn->numa_node = numa_node;
+		cn->numa_node = numa_node << 1;
 		cn->encoded_tail = encode_tail(cpu, i);
 		/*
 		 * make sure @encoded_tail is not confused with other valid
@@ -110,6 +114,14 @@ static int __init cna_init_nodes(void)
 
 static __always_inline void cna_init_node(struct mcs_spinlock *node)
 {
+	/*
+	 * Set the priority bit in @numa_node for threads that should not
+	 * be moved to the secondary queue.
+	 */
+	bool priority = !in_task() || irqs_disabled() || rt_task(current);
+	((struct cna_node *)node)->numa_node =
+		(((struct cna_node *)node)->numa_node & ~1) | priority;
+
 	((struct cna_node *)node)->intra_count = 0;
 }
 
@@ -243,12 +255,16 @@ static u32 cna_order_queue(struct mcs_spinlock *node,
 {
 	struct cna_node *cni = (struct cna_node *)READ_ONCE(iter->next);
 	struct cna_node *cn = (struct cna_node *)node;
-	int nid = cn->numa_node;
+	int nid = cn->numa_node >> 1;
 	struct cna_node *last;
 
 	/* find any next waiter on 'our' NUMA node */
 	for (last = cn;
-	     cni && cni->numa_node != nid;
+		 /*
+		  * iterate as long as the current node is not priorizied and
+		  * does not run on 'our' NUMA node
+		  */
+	     cni && !(cni->numa_node & 0x1) && (cni->numa_node >> 1) != nid;
 	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
 		;
 
@@ -258,6 +274,12 @@ static u32 cna_order_queue(struct mcs_spinlock *node,
 	if (last != cn)	/* did we skip any waiters? */
 		cna_splice_tail(node, node->next, (struct mcs_spinlock *)last);
 
+	/*
+	 * We return LOCAL_WAITER_FOUND here even if we stopped the scan because
+	 * of a prioritized waiter. That waiter will get the lock next even if
+	 * it runs on a different NUMA node, but this is what we wanted when we
+	 * prioritized it.
+	 */
 	return LOCAL_WAITER_FOUND;
 }
 
-- 
2.21.1 (Apple Git-122.3)

