Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B9E69B57
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2019 21:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfGOT1Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jul 2019 15:27:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38650 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730584AbfGOT1Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 15:27:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FJOAcp018340;
        Mon, 15 Jul 2019 19:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=3eVuBt9o65dPhmPiMWn6lk9FzUIcXbbNKM5BCFCplCY=;
 b=iK3uUaP12YpqPpt8uouhFcoO5w01/8gINdUTpWhwVQ2rcwq9VZOxHEIs3tJ0MpZ5klNk
 mAhk8dwEbBmomAdnucYeGDZtxJ/m8YJIeUPv01VRXqhziWap/+pYRKomIq1THSz9eKmE
 ZoBnET3deAPH0Yczr++qyGAIpNECIh+GjbhORYQesj/A6EjUcm99cMqNbxtAVVukSRQD
 r31TyY/ipeYboGLuSwoHF+6aFskBrtirnDgogD3MbF5V3lY+tflz0eO0dxDPiHpSerQS
 GVqvnqs9lnEgmbx9J6MnWwf8bI9k07i1Xnzdaa5x1CVym0akLx5Ppjt9cBUQSQI3RxPA Zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtghyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 19:26:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FJMkk5185803;
        Mon, 15 Jul 2019 19:26:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tq4dtg9hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 19:26:01 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6FJPvpB031345;
        Mon, 15 Jul 2019 19:25:57 GMT
Received: from ol-bur-x5-4.us.oracle.com (/10.152.128.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 12:25:56 -0700
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
Subject: [PATCH v3 4/5] locking/qspinlock: Introduce starvation avoidance into CNA
Date:   Mon, 15 Jul 2019 15:25:35 -0400
Message-Id: <20190715192536.104548-5-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715192536.104548-1-alex.kogan@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150221
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150222
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Choose the next lock holder among spinning threads running on the same
node with high probability rather than always. With small probability,
hand the lock to the first thread in the secondary queue or, if that
queue is empty, to the immediate successor of the current lock holder
in the main queue.  Thus, assuming no failures while threads hold the
lock, every thread would be able to acquire the lock after a bounded
number of lock transitions, with high probability.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock_cna.h | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index efb9b12b2f9b..3de5be813a46 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,7 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/random.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -36,6 +37,33 @@ struct cna_node {
 
 #define CNA_NODE(ptr) ((struct cna_node *)(ptr))
 
+/* Per-CPU pseudo-random number seed */
+static DEFINE_PER_CPU(u32, seed);
+
+/*
+ * Controls the probability for intra-node lock hand-off. It can be
+ * tuned and depend, e.g., on the number of CPUs per node. For now,
+ * choose a value that provides reasonable long-term fairness without
+ * sacrificing performance compared to a version that does not have any
+ * fairness guarantees.
+ */
+#define INTRA_NODE_HANDOFF_PROB_ARG 0x10000
+
+/*
+ * Return false with probability 1 / @range.
+ * @range must be a power of 2.
+ */
+static bool probably(unsigned int range)
+{
+	u32 s;
+
+	s = this_cpu_read(seed);
+	s = next_pseudo_random32(s);
+	this_cpu_write(seed, s);
+
+	return s & (range - 1);
+}
+
 static void cna_init_node(struct mcs_spinlock *node)
 {
 	struct cna_node *cn = CNA_NODE(node);
@@ -140,7 +168,13 @@ static inline void cna_pass_mcs_lock(struct mcs_spinlock *node,
 	u64 *var = &next->locked;
 	u64 val = 1;
 
-	succ = find_successor(node);
+	/*
+	 * Try to pass the lock to a thread running on the same node.
+	 * For long-term fairness, search for such a thread with high
+	 * probability rather than always.
+	 */
+	if (probably(INTRA_NODE_HANDOFF_PROB_ARG))
+		succ = find_successor(node);
 
 	if (succ) {
 		var = &succ->mcs.locked;
-- 
2.11.0 (Apple Git-81)

