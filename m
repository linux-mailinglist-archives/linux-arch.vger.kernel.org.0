Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C612E1898
	for <lists+linux-arch@lfdr.de>; Wed, 23 Dec 2020 06:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgLWFrA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Dec 2020 00:47:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40276 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbgLWFrA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Dec 2020 00:47:00 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BN5i4qb180579;
        Wed, 23 Dec 2020 05:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=62CUDxAtV3yxCJlqzCuxvemaJpVkPEKiTQZXt7HaeVs=;
 b=rh1kZldHXL9dx3w4RdMeIwicW81bDkSrJTPjfFtDjfFjui4kn+Vo0Y4n56ivObb3z88G
 H/2F1+J9sYamdJz+LjZiFraVubJi45mygy0ld9kM++H4eWw81RJ59N1lhVR3cTVKqqgq
 Cv8MWz5hznP6YPXfhE+b2veDWJ0GiYJqWE+YyAN+QhqBkRvoaFLcmMTui7T0rfbZQBv3
 IHYBotyI9k4YdxYHwsLW9D6jToY+VaJS1KU0YGjLv7Vy8do8gzz1g8wfhLfKp1oWJIV7
 div2uTI0nOsUCLQ4xDBhIih9SF3QFh6eB1g/EV4cWXALWKy9OaPkXe5IFS3AuUKY/twY EQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 35k0d16bv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Dec 2020 05:45:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BN5ecfC062429;
        Wed, 23 Dec 2020 05:45:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 35k0eu0ufd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 05:45:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BN5j7ER014439;
        Wed, 23 Dec 2020 05:45:07 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Dec 2020 21:45:06 -0800
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v13 1/6] locking/qspinlock: Rename mcs lock/unlock macros and make them more generic
Date:   Wed, 23 Dec 2020 00:44:50 -0500
Message-Id: <20201223054455.1990884-2-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223054455.1990884-1-alex.kogan@oracle.com>
References: <20201223054455.1990884-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9843 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=950 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012230042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9843 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 phishscore=0 mlxlogscore=966 spamscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012230042
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The mcs unlock macro (arch_mcs_lock_handoff) should accept the value to be
stored into the lock argument as another argument. This allows using the
same macro in cases where the value to be stored when passing the lock is
different from 1.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 arch/arm/include/asm/mcs_spinlock.h |  6 +++---
 include/asm-generic/mcs_spinlock.h  |  4 ++--
 kernel/locking/mcs_spinlock.h       | 18 +++++++++---------
 kernel/locking/qspinlock.c          |  4 ++--
 kernel/locking/qspinlock_paravirt.h |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
index 529d2cf4d06f..1eb4d733459c 100644
--- a/arch/arm/include/asm/mcs_spinlock.h
+++ b/arch/arm/include/asm/mcs_spinlock.h
@@ -6,7 +6,7 @@
 #include <asm/spinlock.h>
 
 /* MCS spin-locking. */
-#define arch_mcs_spin_lock_contended(lock)				\
+#define arch_mcs_spin_wait(lock)					\
 do {									\
 	/* Ensure prior stores are observed before we enter wfe. */	\
 	smp_mb();							\
@@ -14,9 +14,9 @@ do {									\
 		wfe();							\
 } while (0)								\
 
-#define arch_mcs_spin_unlock_contended(lock)				\
+#define arch_mcs_lock_handoff(lock, val)				\
 do {									\
-	smp_store_release(lock, 1);					\
+	smp_store_release((lock), (val));				\
 	dsb_sev();							\
 } while (0)
 
diff --git a/include/asm-generic/mcs_spinlock.h b/include/asm-generic/mcs_spinlock.h
index 10cd4ffc6ba2..f933d99c63e0 100644
--- a/include/asm-generic/mcs_spinlock.h
+++ b/include/asm-generic/mcs_spinlock.h
@@ -4,8 +4,8 @@
 /*
  * Architectures can define their own:
  *
- *   arch_mcs_spin_lock_contended(l)
- *   arch_mcs_spin_unlock_contended(l)
+ *   arch_mcs_spin_wait(l)
+ *   arch_mcs_lock_handoff(l, val)
  *
  * See kernel/locking/mcs_spinlock.c.
  */
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 5e10153b4d3c..904ba5d0f3f4 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -21,7 +21,7 @@ struct mcs_spinlock {
 	int count;  /* nesting count, see qspinlock.c */
 };
 
-#ifndef arch_mcs_spin_lock_contended
+#ifndef arch_mcs_spin_wait
 /*
  * Using smp_cond_load_acquire() provides the acquire semantics
  * required so that subsequent operations happen after the
@@ -29,20 +29,20 @@ struct mcs_spinlock {
  * ARM64 would like to do spin-waiting instead of purely
  * spinning, and smp_cond_load_acquire() provides that behavior.
  */
-#define arch_mcs_spin_lock_contended(l)					\
-do {									\
-	smp_cond_load_acquire(l, VAL);					\
+#define arch_mcs_spin_wait(l)					\
+do {								\
+	smp_cond_load_acquire(l, VAL);				\
 } while (0)
 #endif
 
-#ifndef arch_mcs_spin_unlock_contended
+#ifndef arch_mcs_lock_handoff
 /*
  * smp_store_release() provides a memory barrier to ensure all
  * operations in the critical section has been completed before
  * unlocking.
  */
-#define arch_mcs_spin_unlock_contended(l)				\
-	smp_store_release((l), 1)
+#define arch_mcs_lock_handoff(l, val)				\
+	smp_store_release((l), (val))
 #endif
 
 /*
@@ -91,7 +91,7 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 	WRITE_ONCE(prev->next, node);
 
 	/* Wait until the lock holder passes the lock down. */
-	arch_mcs_spin_lock_contended(&node->locked);
+	arch_mcs_spin_wait(&node->locked);
 }
 
 /*
@@ -115,7 +115,7 @@ void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 	}
 
 	/* Pass lock to next waiter. */
-	arch_mcs_spin_unlock_contended(&next->locked);
+	arch_mcs_lock_handoff(&next->locked, 1);
 }
 
 #endif /* __LINUX_MCS_SPINLOCK_H */
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index cbff6ba53d56..435d696f9250 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -471,7 +471,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		WRITE_ONCE(prev->next, node);
 
 		pv_wait_node(node, prev);
-		arch_mcs_spin_lock_contended(&node->locked);
+		arch_mcs_spin_wait(&node->locked);
 
 		/*
 		 * While waiting for the MCS lock, the next pointer may have
@@ -550,7 +550,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	arch_mcs_spin_unlock_contended(&next->locked);
+	arch_mcs_lock_handoff(&next->locked, 1);
 	pv_kick_node(lock, next);
 
 release:
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index e84d21aa0722..619d80fd5ea8 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -368,7 +368,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 	 *
 	 * Matches with smp_store_mb() and cmpxchg() in pv_wait_node()
 	 *
-	 * The write to next->locked in arch_mcs_spin_unlock_contended()
+	 * The write to next->locked in arch_mcs_lock_handoff()
 	 * must be ordered before the read of pn->state in the cmpxchg()
 	 * below for the code to work correctly. To guarantee full ordering
 	 * irrespective of the success or failure of the cmpxchg(),
-- 
2.24.3 (Apple Git-128)

