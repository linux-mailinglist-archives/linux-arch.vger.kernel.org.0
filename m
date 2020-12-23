Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB172E189E
	for <lists+linux-arch@lfdr.de>; Wed, 23 Dec 2020 06:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgLWFrU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Dec 2020 00:47:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57690 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgLWFrU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Dec 2020 00:47:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BN5jL2m096277;
        Wed, 23 Dec 2020 05:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=c55FMrD622fziJASdJXh553yrWWsLbTh4wFdGnTLzaQ=;
 b=iOGIfpCZ3SoyPjaMLp0mqMH8jm7cezN/O1HQ0TMzH8Lgd+tIOCskaYLF6Q/Zp5+YZtfv
 gfmjpISeAE7EiWMT5SK4rhvU3YLzEIJO4H+k00NcVWqNGbhg3LpnsS6aJUX04gbywUuC
 0NfCpftpiEhLAYS1R14DDgFzaOS5jLCZMRcSUKTfjJn4Hsw+2bN5BLPcpufw/q1QkRJX
 BV4E4HahEMHWLy1vkKVO0mRDyFs6N1aqZTYa8KHPqEBH1vxqYB7MJDlAUGErwBHKYS2q
 +eLA5Xvcd17KpZpBC7Ik38iT1+GO0GxH2LcIpI6R3mwUGBmlPQKm/sHzo+RKFXhSklhT 6g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 35ku8drj2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Dec 2020 05:45:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BN5ec07062461;
        Wed, 23 Dec 2020 05:45:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 35k0eu0ufk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 05:45:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BN5jAxa014483;
        Wed, 23 Dec 2020 05:45:10 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Dec 2020 21:45:09 -0800
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v13 3/6] locking/qspinlock: Introduce CNA into the slow path of qspinlock
Date:   Wed, 23 Dec 2020 00:44:52 -0500
Message-Id: <20201223054455.1990884-4-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223054455.1990884-1-alex.kogan@oracle.com>
References: <20201223054455.1990884-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9843 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012230042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9843 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012230042
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
 kernel/locking/qspinlock_cna.h                | 336 ++++++++++++++++++
 7 files changed, 413 insertions(+), 5 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 44fde25bb221..a6ae826c6076 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3430,6 +3430,16 @@
 	numa_balancing=	[KNL,X86] Enable or disable automatic NUMA balancing.
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
index fbf26e0f7a6a..8c5ecbe5bcd6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1565,6 +1565,26 @@ config NUMA
 
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
index 2400ad62f330..e04f48c2191d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -741,6 +741,10 @@ void __init alternative_instructions(void)
 	}
 #endif
 
+#if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
+	cna_configure_spin_lock_slowpath();
+#endif
+
 	apply_paravirt(__parainstructions, __parainstructions_end);
 
 	restart_nmi();
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 904ba5d0f3f4..5e47ffb3f08b 100644
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
index 000000000000..590402ad69ef
--- /dev/null
+++ b/kernel/locking/qspinlock_cna.h
@@ -0,0 +1,336 @@
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
+	u32			partial_order;	/* enum val */
+};
+
+enum {
+	LOCAL_WAITER_FOUND,
+	LOCAL_WAITER_NOT_FOUND,
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
+ * cna_splice_tail -- splice the next node from the primary queue onto
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
+ */
+static u32 cna_order_queue(struct mcs_spinlock *node)
+{
+	struct mcs_spinlock *next = READ_ONCE(node->next);
+	int numa_node, next_numa_node;
+
+	if (!next)
+		return LOCAL_WAITER_NOT_FOUND;
+
+	numa_node = ((struct cna_node *)node)->numa_node;
+	next_numa_node = ((struct cna_node *)next)->numa_node;
+
+	if (next_numa_node != numa_node) {
+		struct mcs_spinlock *nnext = READ_ONCE(next->next);
+
+		if (nnext) {
+			cna_splice_next(node, next, nnext);
+			next = nnext;
+		}
+		/*
+		 * Inherit NUMA node id of primary queue, to maintain the
+		 * preference even if the next waiter is on a different node.
+		 */
+		((struct cna_node *)next)->numa_node = numa_node;
+	}
+	return LOCAL_WAITER_FOUND;
+}
+
+/* Abuse the pv_wait_head_or_lock() hook to get some work done */
+static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
+						 struct mcs_spinlock *node)
+{
+	struct cna_node *cn = (struct cna_node *)node;
+
+	/*
+	 * Try and put the time otherwise spent spin waiting on
+	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
+	 */
+	cn->partial_order = cna_order_queue(node);
+
+	return 0; /* we lied; we didn't wait, go do so now */
+}
+
+static inline void cna_lock_handoff(struct mcs_spinlock *node,
+				 struct mcs_spinlock *next)
+{
+	struct cna_node *cn = (struct cna_node *)node;
+	u32 val = 1;
+
+	u32 partial_order = cn->partial_order;
+
+	if (partial_order == LOCAL_WAITER_NOT_FOUND)
+		partial_order = cna_order_queue(node);
+
+	/*
+	 * At this point, we must have a successor in the main queue, so if we call
+	 * cna_order_queue() above, we will find a local waiter, either real or
+	 * fake one.
+	 */
+	WARN_ON(partial_order == LOCAL_WAITER_NOT_FOUND);
+
+	/*
+	 * We found a local waiter; reload @next in case it was changed by
+	 * cna_order_queue().
+	 */
+	next = node->next;
+	if (node->locked > 1)
+		val = node->locked;	/* preseve secondary queue */
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

