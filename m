Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6626109504
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 22:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYVR4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 16:17:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55992 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfKYVRz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 16:17:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPL9Zeg165706;
        Mon, 25 Nov 2019 21:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=43cC3PbqxO7tdNuHSZvFFcEcDtgtIg8cKVnCoxINKAg=;
 b=ozWvzCfjHP3yjwQeQq8QRDwgHgt4YSKZFICw2hrxIUGdE63+inUk63huczA7ocJVc5zR
 QgOiTw5JV9koQhmy13nB+SA4bXaSq0DrTFmL50gxW7eB9063HkGduRUQHN//TOsYEPoW
 BRLzXykvjsvAx2apamEHWEwAxY72OA3+C5wx7E40xNfJLW4WMUah2cSrPlQj7snV/Yvz
 cqdfWOCR32yV8cweTyfVqWZQvTkU2UPtb5jj6eio8g6yjSsPvrvH/WF+xWoCp2n7FL6Z
 ZmB5d12ldwNjH3uOmBRbTbBD+hyS5yG9waE9YLr3THUgb+QlO9SDL+LSGi3mBTzY2tMg oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wewdr2915-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 21:17:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPL8Rtm041317;
        Mon, 25 Nov 2019 21:15:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2wfewb4m07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 21:15:21 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAPLFDah020513;
        Mon, 25 Nov 2019 21:15:13 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 13:15:12 -0800
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
Subject: [PATCH v7 1/5] locking/qspinlock: Rename mcs lock/unlock macros and make them more generic
Date:   Mon, 25 Nov 2019 16:07:05 -0500
Message-Id: <20191125210709.10293-2-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191125210709.10293-1-alex.kogan@oracle.com>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=670
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=736 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250171
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The mcs unlock macro (arch_mcs_pass_lock) should accept the value to be
stored into the lock argument as another argument. This allows using the
same macro in cases where the value to be stored when passing the lock is
different from 1.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 arch/arm/include/asm/mcs_spinlock.h |  6 +++---
 include/asm-generic/mcs_spinlock.h  |  4 ++--
 kernel/locking/mcs_spinlock.h       | 18 +++++++++---------
 kernel/locking/qspinlock.c          |  4 ++--
 kernel/locking/qspinlock_paravirt.h |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
index 529d2cf4d06f..693fe6ce3c43 100644
--- a/arch/arm/include/asm/mcs_spinlock.h
+++ b/arch/arm/include/asm/mcs_spinlock.h
@@ -6,7 +6,7 @@
 #include <asm/spinlock.h>
 
 /* MCS spin-locking. */
-#define arch_mcs_spin_lock_contended(lock)				\
+#define arch_mcs_spin_lock(lock)				\
 do {									\
 	/* Ensure prior stores are observed before we enter wfe. */	\
 	smp_mb();							\
@@ -14,9 +14,9 @@ do {									\
 		wfe();							\
 } while (0)								\
 
-#define arch_mcs_spin_unlock_contended(lock)				\
+#define arch_mcs_pass_lock(lock, val)					\
 do {									\
-	smp_store_release(lock, 1);					\
+	smp_store_release((lock), (val));				\
 	dsb_sev();							\
 } while (0)
 
diff --git a/include/asm-generic/mcs_spinlock.h b/include/asm-generic/mcs_spinlock.h
index 10cd4ffc6ba2..868da43dba7c 100644
--- a/include/asm-generic/mcs_spinlock.h
+++ b/include/asm-generic/mcs_spinlock.h
@@ -4,8 +4,8 @@
 /*
  * Architectures can define their own:
  *
- *   arch_mcs_spin_lock_contended(l)
- *   arch_mcs_spin_unlock_contended(l)
+ *   arch_mcs_spin_lock(l)
+ *   arch_mcs_pass_lock(l, val)
  *
  * See kernel/locking/mcs_spinlock.c.
  */
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 5e10153b4d3c..52d06ec6f525 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -21,7 +21,7 @@ struct mcs_spinlock {
 	int count;  /* nesting count, see qspinlock.c */
 };
 
-#ifndef arch_mcs_spin_lock_contended
+#ifndef arch_mcs_spin_lock
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
+#define arch_mcs_spin_lock(l)					\
+do {								\
+	smp_cond_load_acquire(l, VAL);				\
 } while (0)
 #endif
 
-#ifndef arch_mcs_spin_unlock_contended
+#ifndef arch_mcs_spin_unlock
 /*
  * smp_store_release() provides a memory barrier to ensure all
  * operations in the critical section has been completed before
  * unlocking.
  */
-#define arch_mcs_spin_unlock_contended(l)				\
-	smp_store_release((l), 1)
+#define arch_mcs_pass_lock(l, val)				\
+	smp_store_release((l), (val))
 #endif
 
 /*
@@ -91,7 +91,7 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 	WRITE_ONCE(prev->next, node);
 
 	/* Wait until the lock holder passes the lock down. */
-	arch_mcs_spin_lock_contended(&node->locked);
+	arch_mcs_spin_lock(&node->locked);
 }
 
 /*
@@ -115,7 +115,7 @@ void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 	}
 
 	/* Pass lock to next waiter. */
-	arch_mcs_spin_unlock_contended(&next->locked);
+	arch_mcs_pass_lock(&next->locked, 1);
 }
 
 #endif /* __LINUX_MCS_SPINLOCK_H */
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 2473f10c6956..804c0fbd6328 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -470,7 +470,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		WRITE_ONCE(prev->next, node);
 
 		pv_wait_node(node, prev);
-		arch_mcs_spin_lock_contended(&node->locked);
+		arch_mcs_spin_lock(&node->locked);
 
 		/*
 		 * While waiting for the MCS lock, the next pointer may have
@@ -549,7 +549,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	arch_mcs_spin_unlock_contended(&next->locked);
+	arch_mcs_pass_lock(&next->locked, 1);
 	pv_kick_node(lock, next);
 
 release:
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index e84d21aa0722..e98079414671 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -368,7 +368,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 	 *
 	 * Matches with smp_store_mb() and cmpxchg() in pv_wait_node()
 	 *
-	 * The write to next->locked in arch_mcs_spin_unlock_contended()
+	 * The write to next->locked in arch_mcs_pass_lock()
 	 * must be ordered before the read of pn->state in the cmpxchg()
 	 * below for the code to work correctly. To guarantee full ordering
 	 * irrespective of the success or failure of the cmpxchg(),
-- 
2.21.0 (Apple Git-122.2)

