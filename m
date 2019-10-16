Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE976D8783
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 06:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390406AbfJPEcp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 00:32:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35328 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389479AbfJPEcp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 00:32:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9G4T1IT159468;
        Wed, 16 Oct 2019 04:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=8yKZaI5pFkA1Ua6h01kApDPq1HQAXCZX8ebNy5o4QVo=;
 b=bO8lJkO8TiMwxwU6LRuTCQ0p5XDAfLUpA/CImRov22v6YFe0a+8EAt3TgtxMTSnrsxOO
 Ob9xAvsCG4CQ9M5Hd+tVn+EV/Mx4qoxhLZwlrH7qkyPkUuEiyte08hyeCc9JrQxt4NB+
 g1kawlfkipk44dKRpMy6jobAEieqHzZ4TFLlW9QVTXaQCxo8iSFPjKcbZC8jtKkssNxL
 ExKRn1fhfwnvTDRtoj8Uq9WpYw+gUgKlD9sMHMnQmGE1VXGGSEuoNHTfcmiRQjb/szn3
 f7R1DKQA1sTyXYmGi5cDWvBoZsLaCvVEuzbGQHnXP/FGpM8ELTbwU12Fv+e8xb3Ru4qR yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vk6sqm3q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 04:31:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9G4Rfnx122552;
        Wed, 16 Oct 2019 04:31:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vn719wws8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 04:31:19 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9G4VCWW005818;
        Wed, 16 Oct 2019 04:31:12 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 21:31:12 -0700
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
Subject: [PATCH v5 5/5] locking/qspinlock: Introduce the shuffle reduction optimization into CNA
Date:   Wed, 16 Oct 2019 00:29:03 -0400
Message-Id: <20191016042903.61081-6-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191016042903.61081-1-alex.kogan@oracle.com>
References: <20191016042903.61081-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910160040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910160040
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
 kernel/locking/qspinlock_cna.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index b92a6f9a19db..6a66850be1e6 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,7 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/random.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -63,6 +64,34 @@ struct cna_node {
  */
 #define INTRA_NODE_HANDOFF_THRESHOLD (1 << 16)
 
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
@@ -235,6 +264,7 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock,
 	 * should be made in cna_pass_lock()
 	 */
 	cn->pre_scan_result =
+		(node->locked <= 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) ||
 		cn->intra_count == INTRA_NODE_HANDOFF_THRESHOLD ?
 			1 : cna_scan_main_queue(node, node);
 
-- 
2.11.0 (Apple Git-81)

