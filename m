Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B97351E98
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbhDASn4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 14:43:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57304 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbhDASdN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 14:33:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131FPgBh176900;
        Thu, 1 Apr 2021 15:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=2yrNiAKJpcLiNmBIZlf2xOOwkkpvgKkFvYNZqq9aHsc=;
 b=FRhNku98QeU/zw24nKaHiERPul0xEeAfR4W4ptgxqbQBdX1+KMq7+GQsuWjcYuets5SG
 d+C4orF/H1DykIY/7DrVrdWiXKeUdQQcHNe569LwG+zdsL3JMmdvQ+XZROS72xlyBzg5
 lO65TvwHl9YI5sutYa9ypAZHtjo2rbYiFr+JmsnPB/RaDLxZqC8gDZBPGUYLJM9ZFQXo
 IdSeHV/sh5zQ8/Bev7TVk13fAB9rKkUBrA8FTB3FoW8Rv01cNF09Lc7Wq7Q3uIz9JuiI
 pMqCuMDT7RbEZl8fvwyQCaVYsdKAGaPC3wr7kw0T3A/r57VsQ8baCZ1+/wrzih/gBiep hQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37n30sa777-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 15:32:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131FLoPB063320;
        Thu, 1 Apr 2021 15:32:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 37n2asydrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 15:32:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 131FWCdB011637;
        Thu, 1 Apr 2021 15:32:12 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Apr 2021 08:32:12 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v14 2/6] locking/qspinlock: Refactor the qspinlock slow path
Date:   Thu,  1 Apr 2021 11:31:52 -0400
Message-Id: <20210401153156.1165900-3-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401153156.1165900-1-alex.kogan@oracle.com>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010104
X-Proofpoint-GUID: 8GHdQviB0b2n-cQ4RufgYROFx9wgbYTQ
X-Proofpoint-ORIG-GUID: 8GHdQviB0b2n-cQ4RufgYROFx9wgbYTQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010104
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move some of the code manipulating the spin lock into separate functions.
This would allow easier integration of alternative ways to manipulate
that lock.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 435d696f9250..e3518709ffdc 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -289,6 +289,34 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
 #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
 #endif
 
+/*
+ * __try_clear_tail - try to clear tail by setting the lock value to
+ * _Q_LOCKED_VAL.
+ * @lock: Pointer to the queued spinlock structure
+ * @val: Current value of the lock
+ * @node: Pointer to the MCS node of the lock holder
+ */
+static __always_inline bool __try_clear_tail(struct qspinlock *lock,
+					     u32 val,
+					     struct mcs_spinlock *node)
+{
+	return atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL);
+}
+
+/*
+ * __mcs_lock_handoff - pass the MCS lock to the next waiter
+ * @node: Pointer to the MCS node of the lock holder
+ * @next: Pointer to the MCS node of the first waiter in the MCS queue
+ */
+static __always_inline void __mcs_lock_handoff(struct mcs_spinlock *node,
+					       struct mcs_spinlock *next)
+{
+	arch_mcs_lock_handoff(&next->locked, 1);
+}
+
+#define try_clear_tail		__try_clear_tail
+#define mcs_lock_handoff	__mcs_lock_handoff
+
 #endif /* _GEN_PV_LOCK_SLOWPATH */
 
 /**
@@ -533,7 +561,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *       PENDING will make the uncontended transition fail.
 	 */
 	if ((val & _Q_TAIL_MASK) == tail) {
-		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+		if (try_clear_tail(lock, val, node))
 			goto release; /* No contention */
 	}
 
@@ -550,7 +578,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	arch_mcs_lock_handoff(&next->locked, 1);
+	mcs_lock_handoff(node, next);
 	pv_kick_node(lock, next);
 
 release:
@@ -575,6 +603,12 @@ EXPORT_SYMBOL(queued_spin_lock_slowpath);
 #undef pv_kick_node
 #undef pv_wait_head_or_lock
 
+#undef try_clear_tail
+#define try_clear_tail		__try_clear_tail
+
+#undef mcs_lock_handoff
+#define mcs_lock_handoff			__mcs_lock_handoff
+
 #undef  queued_spin_lock_slowpath
 #define queued_spin_lock_slowpath	__pv_queued_spin_lock_slowpath
 
-- 
2.24.3 (Apple Git-128)

