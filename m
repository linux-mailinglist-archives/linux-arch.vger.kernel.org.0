Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B04A381171
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhENUKZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 16:10:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53722 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhENUKW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2021 16:10:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EK6N65152432;
        Fri, 14 May 2021 20:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=1WNpQxl9/JghzqKKePVmJ6DIZBhp6gRkWK5EFYl9e+E=;
 b=W5EAWm9Ln2760rr49+hAOYq0pEdDy7gQfSfruu3OUR3n6dEBqjSYzpELMJMGjpcF3AXt
 Wp9qn/7aOl1VFCWqH+WiH2sGqabtcefAybLaD/ec7rbxpCRUSvL+z6ZETxN27b3KdWde
 M43AIkgBDjmW8VNPVWcnCG7kR4PTehfSbl5qF4RQu/YiNnMQMzhOYk3uNIzmENldb0ac
 WXxE/hJAvKNv38xaE0oRff8dYlB4gtPSxzf8KCB1t92GtwiIAs7lgiQxnKH3etTCvGFM
 4q3HZzsMsrqv/eQTF3JmqTdo3xa1hKG6EiPeKQNWTixOJYbRhNAW0qj+Oo/SUt36xogh cA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38gpnxw8ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EK6BcW098914;
        Fri, 14 May 2021 20:08:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38gpphgtvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:08 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14EK6Y61099310;
        Fri, 14 May 2021 20:08:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 38gpphgtux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14EK7uqW011259;
        Fri, 14 May 2021 20:07:56 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 May 2021 13:07:56 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v15 3/6] locking/qspinlock: Introduce CNA into the slow path of qspinlock
Date:   Fri, 14 May 2021 16:07:40 -0400
Message-Id: <20210514200743.3026725-4-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514200743.3026725-1-alex.kogan@oracle.com>
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CTykUhOScB9vqchmPI9tS4Gv3T5ANvq5
X-Proofpoint-ORIG-GUID: CTykUhOScB9vqchmPI9tS4Gv3T5ANvq5
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140159
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In CNA, spinning threads are organized in two queues, a primary queue for
threads running on the same node as the current lock holder, and a
secondary queue for threads running on other nodes. After acquiring the
MCS lock and before acquiring the spinlock, the MCS lock
holder checks whether the next waiter in the primary queue (if exists) is
running on the same NUMA node. If it is not, that waiter is detached from
the main queue and moved into the tail of the secondary queue. This way,
we gradually filter the primary queue, leaving only waiters running on
the same preferred NUMA node. For more details, see
https://arxiv.org/abs/1810.05600.

Note that this variant of CNA may introduce starvation by continuously
passing the lock between waiters in the main queue. This issue will be
addressed later in the series.

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
Reviewed-by: Waiman Long <longman@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |  10 +
 arch/x86/Kconfig                              |  20 ++
 arch/x86/include/asm/qspinlock.h              |   4 +
 arch/x86/kernel/alternative.c                 |   4 +
 kernel/locking/mcs_spinlock.h                 |   2 +-
 kernel/locking/qspinlock.c                    |  42 ++-
 kernel/locking/qspinlock_cna.h                | 325 ++++++++++++++++++
 7 files changed, 402 insertions(+), 5 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a816935d23d4..94d35507560c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3515,6 +3515,16 @@
 			NUMA balancing.
 			Allowed values are enable and disable
 
+	numa_spinlock=	[NUMA, PV_OPS] Select the NUMA-aware variant
+			of spinlock. The options are:
+			auto - Enable this variant if running on a multi-node
+			machine in native environment.
+			on  - Unconditionally enable this variant.
+			off - Unconditionally disable this variant.
+
+			Not specifying this option is equivalent to
+			numa_spinlock=auto.
+
 	numa_zonelist_order= [KNL, BOOT] Select zonelist order for NUMA.
 			'node', 'default' can be specified
 			This can be set from sysctl after boot.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b44190..819c3dad8afc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1564,6 +1564,26 @@ config NUMA
 
 	  Otherwise, you should say N.
 
+config NUMA_AWARE_SPINLOCKS
+	bool "Numa-aware spinlocks"
+	depends on NUMA
+	depends on QUEUED_SPINLOCKS
+	depends on 64BIT
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
index d86ab942219c..21d09e8db979 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -27,6 +27,10 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
 	return val;
 }
 
+#ifdef CONFIG_NUMA_AWARE_SPINLOCKS
+extern void cna_configure_spin_lock_slowpath(void);
+#endif
+
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_init_lock_hash(void);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6974b5174495..6c73c2dc17fb 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -608,6 +608,10 @@ void __init alternative_instructions(void)
 	 */
 	paravirt_set_cap();
 
+#if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
+	cna_configure_spin_lock_slowpath();
+#endif
+
 	/*
 	 * First patch paravirt functions, such that we overwrite the indirect
 	 * call with the direct call.
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index e794babc519a..3926aad129ed 100644
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
index e3518709ffdc..8c1a21b53913 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -11,7 +11,7 @@
  *          Peter Zijlstra <peterz@infradead.org>
  */
 
-#ifndef _GEN_PV_LOCK_SLOWPATH
+#if !defined(_GEN_PV_LOCK_SLOWPATH) && !defined(_GEN_CNA_LOCK_SLOWPATH)
 
 #include <linux/smp.h>
 #include <linux/bug.h>
@@ -71,7 +71,8 @@
 /*
  * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
  * size and four of them will fit nicely in one 64-byte cacheline. For
- * pvqspinlock, however, we need more space for extra data. To accommodate
+ * pvqspinlock, however, we need more space for extra data. The same also
+ * applies for the NUMA-aware variant of spinlocks (CNA). To accommodate
  * that, we insert two more long words to pad it up to 32 bytes. IOW, only
  * two of them can fit in a cacheline in this case. That is OK as it is rare
  * to have more than 2 levels of slowpath nesting in actual use. We don't
@@ -80,7 +81,7 @@
  */
 struct qnode {
 	struct mcs_spinlock mcs;
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) || defined(CONFIG_NUMA_AWARE_SPINLOCKS)
 	long reserved[2];
 #endif
 };
@@ -104,6 +105,8 @@ struct qnode {
  * Exactly fits one 64-byte cacheline on a 64-bit architecture.
  *
  * PV doubles the storage and uses the second cacheline for PV state.
+ * CNA also doubles the storage and uses the second cacheline for
+ * CNA-specific state.
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
 
@@ -317,7 +320,7 @@ static __always_inline void __mcs_lock_handoff(struct mcs_spinlock *node,
 #define try_clear_tail		__try_clear_tail
 #define mcs_lock_handoff	__mcs_lock_handoff
 
-#endif /* _GEN_PV_LOCK_SLOWPATH */
+#endif /* _GEN_PV_LOCK_SLOWPATH && _GEN_CNA_LOCK_SLOWPATH */
 
 /**
  * queued_spin_lock_slowpath - acquire the queued spinlock
@@ -589,6 +592,37 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
+/*
+ * Generate the code for NUMA-aware spinlocks
+ */
+#if !defined(_GEN_CNA_LOCK_SLOWPATH) && defined(CONFIG_NUMA_AWARE_SPINLOCKS)
+#define _GEN_CNA_LOCK_SLOWPATH
+
+#undef pv_init_node
+#define pv_init_node			cna_init_node
+
+#undef pv_wait_head_or_lock
+#define pv_wait_head_or_lock		cna_wait_head_or_lock
+
+#undef try_clear_tail
+#define try_clear_tail			cna_try_clear_tail
+
+#undef mcs_lock_handoff
+#define mcs_lock_handoff			cna_lock_handoff
+
+#undef  queued_spin_lock_slowpath
+/*
+ * defer defining queued_spin_lock_slowpath until after the include to
+ * avoid a name clash with the identically named field in pv_ops.lock
+ * (see cna_configure_spin_lock_slowpath())
+ */
+#include "qspinlock_cna.h"
+#define queued_spin_lock_slowpath	__cna_queued_spin_lock_slowpath
+
+#include "qspinlock.c"
+
+#endif
+
 /*
  * Generate the paravirt code for queued_spin_unlock_slowpath().
  */
diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
new file mode 100644
index 000000000000..ca564e64e5de
--- /dev/null
+++ b/kernel/locking/qspinlock_cna.h
@@ -0,0 +1,325 @@
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
+ * In CNA, spinning threads are organized in two queues, a primary queue for
+ * threads running on the same NUMA node as the current lock holder, and a
+ * secondary queue for threads running on other nodes. Schematically, it
+ * looks like this:
+ *
+ *    cna_node
+ *   +----------+     +--------+         +--------+
+ *   |mcs:next  | --> |mcs:next| --> ... |mcs:next| --> NULL  [Primary queue]
+ *   |mcs:locked| -.  +--------+         +--------+
+ *   +----------+  |
+ *                 `----------------------.
+ *                                        v
+ *                 +--------+         +--------+
+ *                 |mcs:next| --> ... |mcs:next|            [Secondary queue]
+ *                 +--------+         +--------+
+ *                     ^                    |
+ *                     `--------------------'
+ *
+ * N.B. locked := 1 if secondary queue is absent. Otherwise, it contains the
+ * encoded pointer to the tail of the secondary queue, which is organized as a
+ * circular list.
+ *
+ * After acquiring the MCS lock and before acquiring the spinlock, the MCS lock
+ * holder checks whether the next waiter in the primary queue (if exists) is
+ * running on the same NUMA node. If it is not, that waiter is detached from the
+ * main queue and moved into the tail of the secondary queue. This way, we
+ * gradually filter the primary queue, leaving only waiters running on the same
+ * preferred NUMA node.
+ *
+ * For more details, see https://arxiv.org/abs/1810.05600.
+ *
+ * Authors: Alex Kogan <alex.kogan@oracle.com>
+ *          Dave Dice <dave.dice@oracle.com>
+ */
+
+struct cna_node {
+	struct mcs_spinlock	mcs;
+	u16			numa_node;
+	u16			real_numa_node;
+	u32			encoded_tail;	/* self */
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
+		cn->real_numa_node = numa_node;
+		cn->encoded_tail = encode_tail(cpu, i);
+		/*
+		 * make sure @encoded_tail is not confused with other valid
+		 * values for @locked (0 or 1)
+		 */
+		WARN_ON(cn->encoded_tail <= 1);
+	}
+}
+
+static int __init cna_init_nodes(void)
+{
+	unsigned int cpu;
+
+	/*
+	 * this will break on 32bit architectures, so we restrict
+	 * the use of CNA to 64bit only (see arch/x86/Kconfig)
+	 */
+	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
+	/* we store an ecoded tail word in the node's @locked field */
+	BUILD_BUG_ON(sizeof(u32) > sizeof(unsigned int));
+
+	for_each_possible_cpu(cpu)
+		cna_init_nodes_per_cpu(cpu);
+
+	return 0;
+}
+
+static __always_inline void cna_init_node(struct mcs_spinlock *node)
+{
+	struct cna_node *cn = (struct cna_node *)node;
+
+	cn->numa_node = cn->real_numa_node;
+}
+
+/*
+ * cna_splice_head -- splice the entire secondary queue onto the head of the
+ * primary queue.
+ *
+ * Returns the new primary head node or NULL on failure.
+ */
+static struct mcs_spinlock *
+cna_splice_head(struct qspinlock *lock, u32 val,
+		struct mcs_spinlock *node, struct mcs_spinlock *next)
+{
+	struct mcs_spinlock *head_2nd, *tail_2nd;
+	u32 new;
+
+	tail_2nd = decode_tail(node->locked);
+	head_2nd = tail_2nd->next;
+
+	if (next) {
+		/*
+		 * If the primary queue is not empty, the primary tail doesn't
+		 * need to change and we can simply link the secondary tail to
+		 * the old primary head.
+		 */
+		tail_2nd->next = next;
+	} else {
+		/*
+		 * When the primary queue is empty, the secondary tail becomes
+		 * the primary tail.
+		 */
+
+		/*
+		 * Speculatively break the secondary queue's circular link such
+		 * that when the secondary tail becomes the primary tail it all
+		 * works out.
+		 */
+		tail_2nd->next = NULL;
+
+		/*
+		 * tail_2nd->next = NULL;	old = xchg_tail(lock, tail);
+		 *				prev = decode_tail(old);
+		 * try_cmpxchg_release(...);	WRITE_ONCE(prev->next, node);
+		 *
+		 * If the following cmpxchg() succeeds, our stores will not
+		 * collide.
+		 */
+		new = ((struct cna_node *)tail_2nd)->encoded_tail |
+			_Q_LOCKED_VAL;
+		if (!atomic_try_cmpxchg_release(&lock->val, &val, new)) {
+			/* Restore the secondary queue's circular link. */
+			tail_2nd->next = head_2nd;
+			return NULL;
+		}
+	}
+
+	/* The primary queue head now is what was the secondary queue head. */
+	return head_2nd;
+}
+
+static inline bool cna_try_clear_tail(struct qspinlock *lock, u32 val,
+				      struct mcs_spinlock *node)
+{
+	/*
+	 * We're here because the primary queue is empty; check the secondary
+	 * queue for remote waiters.
+	 */
+	if (node->locked > 1) {
+		struct mcs_spinlock *next;
+
+		/*
+		 * When there are waiters on the secondary queue, try to move
+		 * them back onto the primary queue and let them rip.
+		 */
+		next = cna_splice_head(lock, val, node, NULL);
+		if (next) {
+			arch_mcs_lock_handoff(&next->locked, 1);
+			return true;
+		}
+
+		return false;
+	}
+
+	/* Both queues are empty. Do what MCS does. */
+	return __try_clear_tail(lock, val, node);
+}
+
+/*
+ * cna_splice_next -- splice the next node from the primary queue onto
+ * the secondary queue.
+ */
+static void cna_splice_next(struct mcs_spinlock *node,
+			    struct mcs_spinlock *next,
+			    struct mcs_spinlock *nnext)
+{
+	/* remove 'next' from the main queue */
+	node->next = nnext;
+
+	/* stick `next` on the secondary queue tail */
+	if (node->locked <= 1) { /* if secondary queue is empty */
+		/* create secondary queue */
+		next->next = next;
+	} else {
+		/* add to the tail of the secondary queue */
+		struct mcs_spinlock *tail_2nd = decode_tail(node->locked);
+		struct mcs_spinlock *head_2nd = tail_2nd->next;
+
+		tail_2nd->next = next;
+		next->next = head_2nd;
+	}
+
+	node->locked = ((struct cna_node *)next)->encoded_tail;
+}
+
+/*
+ * cna_order_queue - check whether the next waiter in the main queue is on
+ * the same NUMA node as the lock holder; if not, and it has a waiter behind
+ * it in the main queue, move the former onto the secondary queue.
+ * Returns 1 if the next waiter runs on the same NUMA node; 0 otherwise.
+ */
+static int cna_order_queue(struct mcs_spinlock *node)
+{
+	struct mcs_spinlock *next = READ_ONCE(node->next);
+	struct cna_node *cn = (struct cna_node *)node;
+	int numa_node, next_numa_node;
+
+	if (!next)
+		return 0;
+
+	numa_node = cn->numa_node;
+	next_numa_node = ((struct cna_node *)next)->numa_node;
+
+	if (next_numa_node != numa_node) {
+		struct mcs_spinlock *nnext = READ_ONCE(next->next);
+
+		if (nnext)
+			cna_splice_next(node, next, nnext);
+
+		return 0;
+	}
+	return 1;
+}
+
+#define LOCK_IS_BUSY(lock) (atomic_read(&(lock)->val) & _Q_LOCKED_PENDING_MASK)
+
+/* Abuse the pv_wait_head_or_lock() hook to get some work done */
+static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
+						 struct mcs_spinlock *node)
+{
+	/*
+	 * Try and put the time otherwise spent spin waiting on
+	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
+	 */
+	while (LOCK_IS_BUSY(lock) && !cna_order_queue(node))
+		cpu_relax();
+
+	return 0; /* we lied; we didn't wait, go do so now */
+}
+
+static inline void cna_lock_handoff(struct mcs_spinlock *node,
+				 struct mcs_spinlock *next)
+{
+	u32 val = 1;
+
+	if (node->locked > 1) {
+		struct cna_node *cn = (struct cna_node *)node;
+
+		val = node->locked;	/* preseve secondary queue */
+
+		/*
+		 * We have a local waiter, either real or fake one;
+		 * reload @next in case it was changed by cna_order_queue().
+		 */
+		next = node->next;
+
+		/*
+		 * Pass over NUMA node id of primary queue, to maintain the
+		 * preference even if the next waiter is on a different node.
+		 */
+		((struct cna_node *)next)->numa_node = cn->numa_node;
+	}
+
+	arch_mcs_lock_handoff(&next->locked, val);
+}
+
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
+__setup("numa_spinlock=", numa_spinlock_setup);
+
+void __cna_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+
+/*
+ * Switch to the NUMA-friendly slow path for spinlocks when we have
+ * multiple NUMA nodes in native environment, unless the user has
+ * overridden this default behavior by setting the numa_spinlock flag.
+ */
+void __init cna_configure_spin_lock_slowpath(void)
+{
+
+	if (numa_spinlock_flag < 0)
+		return;
+
+	if (numa_spinlock_flag == 0 && (nr_node_ids < 2 ||
+		    pv_ops.lock.queued_spin_lock_slowpath !=
+			native_queued_spin_lock_slowpath))
+		return;
+
+	cna_init_nodes();
+
+	pv_ops.lock.queued_spin_lock_slowpath = __cna_queued_spin_lock_slowpath;
+
+	pr_info("Enabling CNA spinlock\n");
+}
-- 
2.24.3 (Apple Git-128)

