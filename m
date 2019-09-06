Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59507ABB03
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2019 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfIFOeh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Sep 2019 10:34:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34214 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405489AbfIFOeh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Sep 2019 10:34:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86ESqdg027710;
        Fri, 6 Sep 2019 14:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=UFnzdmg66OgjYn3sKmcbxApmV/mJ75tUNAwnULzGJwg=;
 b=VmSZ9X2fdSF+icfCB6ruLU2aRrEb1Tr04gmGkyKl1coz4dXXxY7Mhtmy3kzcUDrZ4IcV
 RVkJBzDkq4IeaD9ZQI6h8zxBEr7hv77xhcDeOvdNI6o46h+FtnR6++53FNY+YeEF2POn
 P1ZuMtOMPoliuHNUVVhEnaG97ERfVByFThJacsoRB7VF1b1FX3sZXZa5PDr8WTz3huN9
 xq7RNKWYZVRLAw0hz9khqVwMI6wxZCiuHJ300fsigAnFVDg0A5ABDknU7/mMgXJ+DSsW
 P2/4nIO21SNmcEAa4dJyRHZN+AMrFjMl9GLN2iXmx5ivGTpONyr96dh3bScc1WM6mrlG rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2uus4kg2wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 14:33:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86EX7rH045417;
        Fri, 6 Sep 2019 14:33:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2uu1b9t3jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 14:33:06 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x86EWuXN007516;
        Fri, 6 Sep 2019 14:32:56 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Sep 2019 07:32:56 -0700
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
Subject: [PATCH v4 3/5] locking/qspinlock: Introduce CNA into the slow path of qspinlock
Date:   Fri,  6 Sep 2019 10:25:39 -0400
Message-Id: <20190906142541.34061-4-alex.kogan@oracle.com>
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
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060153
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In CNA, spinning threads are organized in two queues, a main queue for
threads running on the same node as the current lock holder, and a
secondary queue for threads running on other nodes. At the unlock time,
the lock holder scans the main queue looking for a thread running on
the same node. If found (call it thread T), all threads in the main queue
between the current lock holder and T are moved to the end of the
secondary queue, and the lock is passed to T. If such T is not found, the
lock is passed to the first node in the secondary queue. Finally, if the
secondary queue is empty, the lock is passed to the next thread in the
main queue. For more details, see https://arxiv.org/abs/1810.05600.

Note that this variant of CNA may introduce starvation by continuously
passing the lock to threads running on the same node. This issue
will be addressed later in the series.

Enabling CNA is controlled via a new configuration option
(NUMA_AWARE_SPINLOCKS). By default, the CNA variant is patched in at the
boot time only if we run on a multi-node machine in native environment and
the new config is enabled. (For the time being, the patching requires
CONFIG_PARAVIRT_SPINLOCKS to be enabled as well. However, this should be
resolved once static_call() is available.) This default behavior can be
overridden with the new kernel boot command-line option
"numa_spinlock=on/off" (default is "auto").

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 arch/x86/Kconfig                 |  19 ++++
 arch/x86/include/asm/qspinlock.h |   4 +
 arch/x86/kernel/alternative.c    |  41 +++++++
 kernel/locking/mcs_spinlock.h    |   2 +-
 kernel/locking/qspinlock.c       |  31 +++++-
 kernel/locking/qspinlock_cna.h   | 225 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 317 insertions(+), 5 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 222855cc0158..9d0d87edff62 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1567,6 +1567,25 @@ config NUMA
 
 	  Otherwise, you should say N.
 
+config NUMA_AWARE_SPINLOCKS
+	bool "Numa-aware spinlocks"
+	depends on NUMA
+	depends on QUEUED_SPINLOCKS
+	# For now, we depend on PARAVIRT_SPINLOCKS to make the patching work.
+	# This is awkward, but hopefully would be resolved once static_call()
+	# is available.
+	depends on PARAVIRT_SPINLOCKS
+	default y
+	help
+	  Introduce NUMA (Non Uniform Memory Access) awareness into
+	  the slow path of spinlocks.
+
+	  In this variant of qspinlock, the kernel will try to keep the lock
+	  on the same node, thus reducing the number of remote cache misses,
+	  while trading some of the short term fairness for better performance.
+
+	  Say N if you want absolute first come first serve fairness.
+
 config AMD_NUMA
 	def_bool y
 	prompt "Old style AMD Opteron NUMA detection"
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index bd5ac6cc37db..d9b6c34d5eb4 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -27,6 +27,10 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
 	return val;
 }
 
+#ifdef CONFIG_NUMA_AWARE_SPINLOCKS
+extern void __cna_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+#endif
+
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_init_lock_hash(void);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ccd32013c47a..d5194e342db9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -698,6 +698,33 @@ static void __init int3_selftest(void)
 	unregister_die_notifier(&int3_exception_nb);
 }
 
+#if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
+/*
+ * Constant (boot-param configurable) flag selecting the NUMA-aware variant
+ * of spinlock.  Possible values: -1 (off) / 0 (auto, default) / 1 (on).
+ */
+static int numa_spinlock_flag;
+
+static int __init numa_spinlock_setup(char *str)
+{
+	if (!strcmp(str, "auto")) {
+		numa_spinlock_flag = 0;
+		return 1;
+	} else if (!strcmp(str, "on")) {
+		numa_spinlock_flag = 1;
+		return 1;
+	} else if (!strcmp(str, "off")) {
+		numa_spinlock_flag = -1;
+		return 1;
+	}
+
+	return 0;
+}
+
+__setup("numa_spinlock=", numa_spinlock_setup);
+
+#endif
+
 void __init alternative_instructions(void)
 {
 	int3_selftest();
@@ -738,6 +765,20 @@ void __init alternative_instructions(void)
 	}
 #endif
 
+#if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
+	/*
+	 * By default, switch to the NUMA-friendly slow path for
+	 * spinlocks when we have multiple NUMA nodes in native environment.
+	 */
+	if ((numa_spinlock_flag == 1) ||
+	    (numa_spinlock_flag == 0 && nr_node_ids > 1 &&
+		    pv_ops.lock.queued_spin_lock_slowpath ==
+			native_queued_spin_lock_slowpath)) {
+		pv_ops.lock.queued_spin_lock_slowpath =
+		    __cna_queued_spin_lock_slowpath;
+	}
+#endif
+
 	apply_paravirt(__parainstructions, __parainstructions_end);
 
 	restart_nmi();
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 84327ca21650..bd127b21b70c 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -17,7 +17,7 @@
 
 struct mcs_spinlock {
 	struct mcs_spinlock *next;
-	int locked; /* 1 if lock acquired */
+	unsigned int locked; /* 1 if lock acquired */
 	int count;  /* nesting count, see qspinlock.c */
 };
 
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 070015156a10..e4e482685fc1 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -11,7 +11,7 @@
  *          Peter Zijlstra <peterz@infradead.org>
  */
 
-#ifndef _GEN_PV_LOCK_SLOWPATH
+#if !defined(_GEN_PV_LOCK_SLOWPATH) && !defined(_GEN_CNA_LOCK_SLOWPATH)
 
 #include <linux/smp.h>
 #include <linux/bug.h>
@@ -70,7 +70,8 @@
 /*
  * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
  * size and four of them will fit nicely in one 64-byte cacheline. For
- * pvqspinlock, however, we need more space for extra data. To accommodate
+ * pvqspinlock, however, we need more space for extra data. The same also
+ * applies for the NUMA-aware variant of spinlocks (CNA). To accommodate
  * that, we insert two more long words to pad it up to 32 bytes. IOW, only
  * two of them can fit in a cacheline in this case. That is OK as it is rare
  * to have more than 2 levels of slowpath nesting in actual use. We don't
@@ -79,7 +80,7 @@
  */
 struct qnode {
 	struct mcs_spinlock mcs;
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) || defined(CONFIG_NUMA_AWARE_SPINLOCKS)
 	long reserved[2];
 #endif
 };
@@ -103,6 +104,8 @@ struct qnode {
  * Exactly fits one 64-byte cacheline on a 64-bit architecture.
  *
  * PV doubles the storage and uses the second cacheline for PV state.
+ * CNA also doubles the storage and uses the second cacheline for
+ * CNA-specific state.
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
 
@@ -316,7 +319,7 @@ static __always_inline void __mcs_pass_lock(struct mcs_spinlock *node,
 #define try_clear_tail	__try_clear_tail
 #define mcs_pass_lock		__mcs_pass_lock
 
-#endif /* _GEN_PV_LOCK_SLOWPATH */
+#endif /* _GEN_PV_LOCK_SLOWPATH && _GEN_CNA_LOCK_SLOWPATH */
 
 /**
  * queued_spin_lock_slowpath - acquire the queued spinlock
@@ -589,6 +592,26 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
 /*
+ * Generate the code for NUMA-aware spinlocks
+ */
+#if !defined(_GEN_CNA_LOCK_SLOWPATH) && defined(CONFIG_NUMA_AWARE_SPINLOCKS)
+#define _GEN_CNA_LOCK_SLOWPATH
+
+#undef try_clear_tail
+#define try_clear_tail		cna_try_change_tail
+
+#undef mcs_pass_lock
+#define mcs_pass_lock			cna_pass_lock
+
+#undef  queued_spin_lock_slowpath
+#define queued_spin_lock_slowpath	__cna_queued_spin_lock_slowpath
+
+#include "qspinlock_cna.h"
+#include "qspinlock.c"
+
+#endif
+
+/*
  * Generate the paravirt code for queued_spin_unlock_slowpath().
  */
 #if !defined(_GEN_PV_LOCK_SLOWPATH) && defined(CONFIG_PARAVIRT_SPINLOCKS)
diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
new file mode 100644
index 000000000000..f983debf20bb
--- /dev/null
+++ b/kernel/locking/qspinlock_cna.h
@@ -0,0 +1,225 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _GEN_CNA_LOCK_SLOWPATH
+#error "do not include this file"
+#endif
+
+#include <linux/topology.h>
+
+/*
+ * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
+ *
+ * In CNA, spinning threads are organized in two queues, a main queue for
+ * threads running on the same NUMA node as the current lock holder, and a
+ * secondary queue for threads running on other nodes. Schematically, it
+ * looks like this:
+ *
+ *    cna_node
+ *   +----------+    +--------+        +--------+
+ *   |mcs:next  | -> |mcs:next| -> ... |mcs:next| -> NULL      [Main queue]
+ *   |mcs:locked|    +--------+        +--------+
+ *   +----------+
+ *             |   +--------+         +--------+
+ *             +-> |mcs:next| -> ...  |mcs:next| -> NULL  [Secondary queue]
+ *                 |cna:tail| -+      +--------+
+ *                 +--------+  |        ^
+ *                              +-------+
+ *
+ * N.B. locked = 1 if secondary queue is absent.
+ *
+ * At the unlock time, the lock holder scans the main queue looking for a thread
+ * running on the same node. If found (call it thread T), all threads in the
+ * main queue between the current lock holder and T are moved to the end of the
+ * secondary queue, and the lock is passed to T. If such T is not found, the
+ * lock is passed to the first node in the secondary queue. Finally, if the
+ * secondary queue is empty, the lock is passed to the next thread in the
+ * main queue. To avoid starvation of threads in the secondary queue,
+ * those threads are moved back to the head of the main queue after a certain
+ * expected number of intra-node lock hand-offs.
+ *
+ *
+ * For more details, see https://arxiv.org/abs/1810.05600.
+ *
+ * Authors: Alex Kogan <alex.kogan@oracle.com>
+ *          Dave Dice <dave.dice@oracle.com>
+ */
+
+struct cna_node {
+	struct	mcs_spinlock mcs;
+	int	numa_node;
+	u32	encoded_tail;
+	struct	cna_node *tail;    /* points to the secondary queue tail */
+};
+
+static void __init cna_init_nodes_per_cpu(unsigned int cpu)
+{
+	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
+	int numa_node = cpu_to_node(cpu);
+	int i;
+
+	for (i = 0; i < MAX_NODES; i++) {
+		struct cna_node *cn = (struct cna_node *)grab_mcs_node(base, i);
+
+		cn->numa_node = numa_node;
+		cn->encoded_tail = encode_tail(cpu, i);
+		/*
+		 * @encoded_tail has to be larger than 1, so we do not confuse
+		 * it with other valid values for @locked (0 or 1)
+		 */
+		WARN_ON(cn->encoded_tail <= 1);
+	}
+}
+
+static void __init cna_init_nodes(void)
+{
+	unsigned int cpu;
+
+	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
+	/* we store an ecoded tail word in the node's @locked field */
+	BUILD_BUG_ON(sizeof(u32) > sizeof(unsigned int));
+
+	for_each_possible_cpu(cpu)
+		cna_init_nodes_per_cpu(cpu);
+}
+early_initcall(cna_init_nodes);
+
+static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
+				       struct mcs_spinlock *node)
+{
+	struct cna_node *succ;
+	u32 new;
+
+	/* If the secondary queue is empty, do what MCS does. */
+	if (node->locked <= 1)
+		return __try_clear_tail(lock, val, node);
+
+	/*
+	 * Try to update the tail value to the last node in the secondary queue.
+	 * If successful, pass the lock to the first thread in the secondary
+	 * queue. Doing those two actions effectively moves all nodes from the
+	 * secondary queue into the main one.
+	 */
+	succ = (struct cna_node *)decode_tail(node->locked);
+	new = succ->tail->encoded_tail + _Q_LOCKED_VAL;
+
+	if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
+		arch_mcs_pass_lock(&succ->mcs.locked, 1);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * cna_splice_tail -- splice nodes in the main queue between [first, last]
+ * onto the secondary queue.
+ */
+static void cna_splice_tail(struct cna_node *cn, struct cna_node *first,
+			    struct cna_node *last)
+{
+	/* remove [first,last] */
+	cn->mcs.next = last->mcs.next;
+	last->mcs.next = NULL;
+
+	/* stick [first,last] on the secondary queue tail */
+	if (cn->mcs.locked <= 1) {	/* if secondary queue is empty */
+		/* create secondary queue */
+		first->tail = last;
+		cn->mcs.locked = first->encoded_tail;
+	} else {
+		/* add to the tail of the secondary queue */
+		struct cna_node *head_2nd =
+			(struct cna_node *)decode_tail(cn->mcs.locked);
+		head_2nd->tail->mcs.next = &first->mcs;
+		head_2nd->tail = last;
+	}
+}
+
+/*
+ * cna_try_find_next - scan the main waiting queue looking for the first
+ * thread running on the same NUMA node as the lock holder. If found (call it
+ * thread T), move all threads in the main queue between the lock holder and
+ * T to the end of the secondary queue and return T; otherwise, return NULL.
+ *
+ * Schematically, this may look like the following (nn stands for numa_node and
+ * et stands for encoded_tail).
+ *
+ *     when cna_try_find_next() is called (the secondary queue is empty):
+ *
+ *  A+------------+   B+--------+   C+--------+   T+--------+
+ *   |mcs:next    | -> |mcs:next| -> |mcs:next| -> |mcs:next| -> NULL
+ *   |mcs:locked=1|    |cna:nn=0|    |cna:nn=2|    |cna:nn=1|
+ *   |cna:nn=1    |    +--------+    +--------+    +--------+
+ *   +----------- +
+ *
+ *     when cna_try_find_next() returns (the secondary queue contains B and C):
+ *
+ *  A+----------------+    T+--------+
+ *   |mcs:next        | ->  |mcs:next| -> NULL
+ *   |mcs:locked=B.et | -+  |cna:nn=1|
+ *   |cna:nn=1        |  |  +--------+
+ *   +--------------- +  |
+ *                       |
+ *                       +->  B+--------+   C+--------+
+ *                             |mcs:next| -> |mcs:next|
+ *                             |cna:nn=0|    |cna:nn=2|
+ *                             |cna:tail| -> +--------+
+ *                             +--------+
+ *
+ * The worst case complexity of the scan is O(n), where n is the number
+ * of current waiters. However, the fast path, which is expected to be the
+ * common case, is O(1).
+ */
+static struct mcs_spinlock *cna_try_find_next(struct mcs_spinlock *node,
+					      struct mcs_spinlock *next)
+{
+	struct cna_node *cn = (struct cna_node *)node;
+	struct cna_node *cni = (struct cna_node *)next;
+	struct cna_node *first, *last = NULL;
+	int my_numa_node = cn->numa_node;
+
+	/* fast path: immediate successor is on the same NUMA node */
+	if (cni->numa_node == my_numa_node)
+		return next;
+
+	/* find any next waiter on 'our' NUMA node */
+	for (first = cni;
+	     cni && cni->numa_node != my_numa_node;
+	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
+		;
+
+	/* if found, splice any skipped waiters onto the secondary queue */
+	if (cni && last)
+		cna_splice_tail(cn, first, last);
+
+	return (struct mcs_spinlock *)cni;
+}
+
+static inline void cna_pass_lock(struct mcs_spinlock *node,
+				 struct mcs_spinlock *next)
+{
+	struct mcs_spinlock *next_holder = next, *new_next = NULL;
+	u32 val = 1;
+
+	/*
+	 * Try to find a successor running on the same NUMA node
+	 * as the current lock holder.
+	 */
+	new_next = cna_try_find_next(node, next);
+
+	if (new_next) {		          /* if such successor is found */
+		next_holder = new_next;
+		/*
+		 * Note that @locked here can be 0, 1 or an encoded pointer to
+		 * the head of the secondary queue. We pass the lock by storing
+		 * a non-zero value, so make sure @val gets 1 iff @locked is 0.
+		 */
+		val = node->locked + (node->locked == 0);
+	} else if (node->locked > 1) {	  /* if secondary queue is not empty */
+		/* next holder will be the first node in the secondary queue */
+		next_holder = decode_tail(node->locked);
+		/* splice the secondary queue onto the head of the main queue */
+		((struct cna_node *)next_holder)->tail->mcs.next = next;
+	}
+
+	arch_mcs_pass_lock(&next_holder->locked, val);
+}
-- 
2.11.0 (Apple Git-81)

