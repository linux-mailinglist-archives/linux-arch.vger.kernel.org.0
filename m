Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C7C2B723B
	for <lists+linux-arch@lfdr.de>; Wed, 18 Nov 2020 00:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgKQXVO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Nov 2020 18:21:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44918 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgKQXVN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Nov 2020 18:21:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHNDc65099794;
        Tue, 17 Nov 2020 23:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=we47x/zXOJPVtNw5uym1kfGuctWw0Fy3iZ7QHb+/J1c=;
 b=mPfDnJxXgDZo+hX5lQzxOsle4wCCh/ahgx3oUCzNaRUYlTkPNxK6wr1I6Ffq+2R67xNY
 wD60/Ot4aoqf3QeVZAAPVlMzqdRMYYOkzXvI39m9520WFfKWP8xdFia2NUYMZ3VOBAUC
 fOCtXGeOAegJbzIWImEz/DwLZ+ulrTm9bwPE0KxnV8xREBp6fULcqzDoi6tgrOzfZ6E1
 Nos57Ct+8HK+CO26Xm7YXoQFwUCsi4xHcXJiVU2wgaRHZ8SuSGUktgAA8rORLsxvMkNZ
 7YG0JLEurL9iw7FqCnReSErVPoETyugcVhIvCXLZOzBfgnl1jI5smsEb0SmN0BA8Nt71 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34t7vn59rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 23:13:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHN5bNo161431;
        Tue, 17 Nov 2020 23:13:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34uspu1a99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 23:13:34 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AHNDXQr028988;
        Tue, 17 Nov 2020 23:13:33 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 15:13:32 -0800
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v12 2/5] locking/qspinlock: Refactor the qspinlock slow path
Date:   Tue, 17 Nov 2020 18:13:20 -0500
Message-Id: <20201117231323.797104-3-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117231323.797104-1-alex.kogan@oracle.com>
References: <20201117231323.797104-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170173
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
index 435d696..e351870 100644
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
2.7.4

