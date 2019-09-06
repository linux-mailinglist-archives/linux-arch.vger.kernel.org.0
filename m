Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B09ABB00
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2019 16:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404184AbfIFOeY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Sep 2019 10:34:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404187AbfIFOeY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Sep 2019 10:34:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86ETPB5057991;
        Fri, 6 Sep 2019 14:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=iUYFxUsqHgAm76CUFaGiB1Q4NJwTjXdVV+fFE9B3uOo=;
 b=iZcNxkhtBcoPpNAZsabiJ6qx3XRaQeZrUTqowkCWgn2cGaKNLA2wytbaCnM6M5VLl/oj
 Fad3xeTZAbewEHYxaiKINQklQTmelxS7LIsQbJEhps1fWtqn591VRVfKCCYbDKdvKx96
 +L2VfR/wBY5ZlZYO7rYYTVfrWsMDOl9OH0JrLfYXNjkb/p1euy84tsYOsc4Yq4UH78my
 BnCj2kloThIBOr3TgkNdfN608lhg07dKvpLpILgecKUYTwCdGV2vGTWB+GywNAfZ9yKw
 8zJRUULDfG91GpdKri8S9eL3Gt2DN5eG+0W3QEXe/QxxPg7HquBoZ8sYw2pgsKEEWzni qA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2uus6qg1k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 14:33:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86EXSL6079760;
        Fri, 6 Sep 2019 14:33:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2uud7pk6h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 14:33:30 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x86EWvHV026013;
        Fri, 6 Sep 2019 14:32:57 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Sep 2019 07:32:57 -0700
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
Subject: [PATCH v4 4/5] locking/qspinlock: Introduce starvation avoidance into CNA
Date:   Fri,  6 Sep 2019 10:25:40 -0400
Message-Id: <20190906142541.34061-5-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190906142541.34061-1-alex.kogan@oracle.com>
References: <20190906142541.34061-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909060153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060153
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
 kernel/locking/qspinlock_cna.h | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index f983debf20bb..e86182e6163b 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,7 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/random.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -50,6 +51,34 @@ struct cna_node {
 	struct	cna_node *tail;    /* points to the secondary queue tail */
 };
 
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
+#define INTRA_NODE_HANDOFF_PROB_ARG (16)
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
@@ -202,9 +231,11 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 
 	/*
 	 * Try to find a successor running on the same NUMA node
-	 * as the current lock holder.
+	 * as the current lock holder. For long-term fairness,
+	 * search for such a thread with high probability rather than always.
 	 */
-	new_next = cna_try_find_next(node, next);
+	if (probably(INTRA_NODE_HANDOFF_PROB_ARG))
+		new_next = cna_try_find_next(node, next);
 
 	if (new_next) {		          /* if such successor is found */
 		next_holder = new_next;
-- 
2.11.0 (Apple Git-81)

