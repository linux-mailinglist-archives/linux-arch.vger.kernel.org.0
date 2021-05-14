Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3061381168
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 22:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhENUKT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 16:10:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53682 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhENUKS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2021 16:10:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EK4wSe151546;
        Fri, 14 May 2021 20:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=zQ/1/2J6jL75I15gPTt4mjOOyd9HZEC6PKJACaHwExw=;
 b=BezBi4M2HtknJ58WpEZ94/xJBKPmImjUEy6t+w10zwB9g5CrVIV3US2bWFtGZPIUuN+q
 kz92pffc9i+4/Vs1JWkusHplZG4ymamUCHVJxOYIJYCQ5jPnwpqTrnniG/ZhxxO/RFGW
 2Jvdj0j7KWkJgwQs+1riqlVAl7TlzL4JmwnMOqXvUCOQIkMMamXKXsSDW6OGxQqXq9oi
 kQFsPmNaMd+gsbf/NiLBKLOKyBilrykdbhPbJkRbSyePRwNvtp/39xXe6zPD5lIPkSQd
 SVlxirdGxQZTYyyK4wlEMAfYL0w2hMb2Q78Ku+zGakY4/cbbWK1bGEmC35YRwONui3ST Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38gpnxw8j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EK6Cxc098986;
        Fri, 14 May 2021 20:08:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38gpphgtuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:07 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14EK7LaX100292;
        Fri, 14 May 2021 20:08:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 38gpphgtuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14EK7xRE011960;
        Fri, 14 May 2021 20:07:59 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 May 2021 13:07:59 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v15 5/6] locking/qspinlock: Avoid moving certain threads between waiting queues in CNA
Date:   Fri, 14 May 2021 16:07:42 -0400
Message-Id: <20210514200743.3026725-6-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514200743.3026725-1-alex.kogan@oracle.com>
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xuu9t5RUNNTjssDrPPvistR2qAfhAMQO
X-Proofpoint-ORIG-GUID: xuu9t5RUNNTjssDrPPvistR2qAfhAMQO
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140159
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
 kernel/locking/qspinlock_cna.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 0b991c340fb1..ffc5c3301f0f 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -6,6 +6,7 @@
 #include <linux/topology.h>
 #include <linux/sched/clock.h>
 #include <linux/moduleparam.h>
+#include <linux/sched/rt.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -37,7 +38,8 @@
  * running on the same NUMA node. If it is not, that waiter is detached from the
  * main queue and moved into the tail of the secondary queue. This way, we
  * gradually filter the primary queue, leaving only waiters running on the same
- * preferred NUMA node.
+ * preferred NUMA node. Note that certain priortized waiters (e.g., in
+ * irq and nmi contexts) are excluded from being moved to the secondary queue.
  *
  * We change the NUMA node preference after a waiter at the head of the
  * secondary queue spins for a certain amount of time (1ms, by default).
@@ -53,6 +55,8 @@
 
 #define FLUSH_SECONDARY_QUEUE	1
 
+#define CNA_PRIORITY_NODE      0xffff
+
 struct cna_node {
 	struct mcs_spinlock	mcs;
 	u16			numa_node;
@@ -111,9 +115,10 @@ static int __init cna_init_nodes(void)
 
 static __always_inline void cna_init_node(struct mcs_spinlock *node)
 {
+	bool priority = !in_task() || irqs_disabled() || rt_task(current);
 	struct cna_node *cn = (struct cna_node *)node;
 
-	cn->numa_node = cn->real_numa_node;
+	cn->numa_node = priority ? CNA_PRIORITY_NODE : cn->real_numa_node;
 	cn->start_time = 0;
 }
 
@@ -252,7 +257,7 @@ static int cna_order_queue(struct mcs_spinlock *node)
 	numa_node = cn->numa_node;
 	next_numa_node = ((struct cna_node *)next)->numa_node;
 
-	if (next_numa_node != numa_node) {
+	if (next_numa_node != numa_node && next_numa_node != CNA_PRIORITY_NODE) {
 		struct mcs_spinlock *nnext = READ_ONCE(next->next);
 
 		if (nnext)
@@ -272,6 +277,13 @@ static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
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

