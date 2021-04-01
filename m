Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E96351EC0
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 20:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhDASqH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 14:46:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48458 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbhDASnK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 14:43:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131FPHS4044621;
        Thu, 1 Apr 2021 15:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=cBF5424e9faYN0tz+G+01mYGrv5O38dwoL4gRmjzSZk=;
 b=b1C3fGuwWE4JuzgkbAxmVK2Uy9frRuGPFC2lVCIS5lkJtWBCoXUwreO36gXISm25pJU0
 jIoaWQKvRWUEapjTfZ1ciYw8/3SMYo2qRG5ryED++EI/zpv4+a9M2Zznnmf8RNV6lyb/
 rCVIf+GGbbPlj6NK68013zX2GunX3FajOYKkuB2d6GWqJi2e4JZBhZEjUZnC3Ty7lEuD
 27iA3T5q0lo+2LVNIfLwvzrE4NfgDUvwFkXCjqkNfPMX5WkHk1w1+9WbzZOLLerb8uVP
 lj9ngFSYESMs5daC43f5yhUNT9eDV0BhAiX8WaKp36ebVTwBkNTzR9EgCks+6AOIxIcJ wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37n33dt768-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 15:32:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131FLCdF101173;
        Thu, 1 Apr 2021 15:32:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 37n2abdcx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 15:32:28 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 131FWG8s031929;
        Thu, 1 Apr 2021 15:32:16 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Apr 2021 08:32:16 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v14 5/6] locking/qspinlock: Avoid moving certain threads between waiting queues in CNA
Date:   Thu,  1 Apr 2021 11:31:55 -0400
Message-Id: <20210401153156.1165900-6-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401153156.1165900-1-alex.kogan@oracle.com>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010104
X-Proofpoint-GUID: 6PIYxVHc8lKQRI3kumX_InE-9CMdkwzp
X-Proofpoint-ORIG-GUID: 6PIYxVHc8lKQRI3kumX_InE-9CMdkwzp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010104
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
 kernel/locking/qspinlock_cna.h | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 0513360c11fe..29c3abbd3d94 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,7 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/sched/rt.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -35,7 +36,8 @@
  * running on the same NUMA node. If it is not, that waiter is detached from the
  * main queue and moved into the tail of the secondary queue. This way, we
  * gradually filter the primary queue, leaving only waiters running on the same
- * preferred NUMA node.
+ * preferred NUMA node. Note that certain priortized waiters (e.g., in
+ * irq and nmi contexts) are excluded from being moved to the secondary queue.
  *
  * We change the NUMA node preference after a waiter at the head of the
  * secondary queue spins for a certain amount of time (10ms, by default).
@@ -49,6 +51,8 @@
  *          Dave Dice <dave.dice@oracle.com>
  */
 
+#define CNA_PRIORITY_NODE      0xffff
+
 struct cna_node {
 	struct mcs_spinlock	mcs;
 	u16			numa_node;
@@ -121,9 +125,10 @@ static int __init cna_init_nodes(void)
 
 static __always_inline void cna_init_node(struct mcs_spinlock *node)
 {
+	bool priority = !in_task() || irqs_disabled() || rt_task(current);
 	struct cna_node *cn = (struct cna_node *)node;
 
-	cn->numa_node = cn->real_numa_node;
+	cn->numa_node = priority ? CNA_PRIORITY_NODE : cn->real_numa_node;
 	cn->partial_order = LOCAL_WAITER_FOUND;
 	cn->start_time = 0;
 }
@@ -266,11 +271,13 @@ static void cna_order_queue(struct mcs_spinlock *node)
 	next_numa_node = ((struct cna_node *)next)->numa_node;
 
 	if (next_numa_node != numa_node) {
-		struct mcs_spinlock *nnext = READ_ONCE(next->next);
+		if (next_numa_node != CNA_PRIORITY_NODE) {
+			struct mcs_spinlock *nnext = READ_ONCE(next->next);
 
-		if (nnext) {
-			cna_splice_next(node, next, nnext);
-			next = nnext;
+			if (nnext) {
+				cna_splice_next(node, next, nnext);
+				next = nnext;
+			}
 		}
 		/*
 		 * Inherit NUMA node id of primary queue, to maintain the
@@ -287,6 +294,13 @@ static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
 	struct cna_node *cn = (struct cna_node *)node;
 
 	if (!cn->start_time || !intra_node_threshold_reached(cn)) {
+		/*
+		 * We are at the head of the wait queue, no need to use
+		 * the fake NUMA node ID.
+		 */
+		if (cn->numa_node == CNA_PRIORITY_NODE)
+			cn->numa_node = cn->real_numa_node;
+
 		/*
 		 * Try and put the time otherwise spent spin waiting on
 		 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
-- 
2.24.3 (Apple Git-128)

