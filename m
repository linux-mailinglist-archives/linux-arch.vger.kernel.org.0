Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27DFC19E01F
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 23:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgDCVIx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 17:08:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39896 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgDCVIx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2020 17:08:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033KhISr091448;
        Fri, 3 Apr 2020 21:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=iHsv12YyYCzbA4JkNFdM7JEEYF4PjRvPBPMt3XEabm8=;
 b=TdkfjkXX+mSX4MrxMIqOVp7I0Y8RompmAlt9xpknL1KQtnBcUzjS2SWZd9r+JQHLZCy8
 Gi5IiWO7UM5xan5G6dcDF45dl7Q/LaQ9qWbo0hCL2tMoRtrRKSJ5ZVPs9iYN6o3u2/hI
 Ln3/ZREisC9wjAZ1tWioLNUM0Qjcw5UA/ZqI8MJYg4i9hgvlmQncwlUCCmBqRpuIwfad
 jynUzZSXAOpdidlojZWHdP2ABGAlUvo8pl7duzLSFGj3jOE+XYx9b3harlemyzh024Zl
 Z4EdEa/+Wzp6NhrLWgSHhtpc1Ru6/P07xtkeQI49pkHW8HrdyKfWU2bBIntbyV6wOKag BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 303aqj3px5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 21:05:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033Kh3RA187970;
        Fri, 3 Apr 2020 21:05:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 302g2nxnhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 21:05:50 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033L5d2Q013177;
        Fri, 3 Apr 2020 21:05:39 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 14:05:39 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v10 3/5] locking/qspinlock: Introduce CNA into the slow path of qspinlock
Date:   Fri,  3 Apr 2020 16:59:28 -0400
Message-Id: <20200403205930.1707-4-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200403205930.1707-1-alex.kogan@oracle.com>
References: <20200403205930.1707-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In CNA, spinning threads are organized in two queues, a primary queue for
threads running on the same node as the current lock holder, and a
secondary queue for threads running on other nodes. After acquiring the
MCS lock and before acquiring the spinlock, the lock holder scans the
primary queue looking for a thread running on the same node (pre-scan). If
found (call it thread T), all threads in the primary queue between the
current lock holder and T are moved to the end of the secondary queue.
If such T is not found, we make another scan of the primary queue when
unlocking the MCS lock (post-scan), starting at the position where
pre-scan stopped. If both scans fail to find such T, the MCS lock is
passed to the first thread in the secondary queue. If the secondary queue
is empty, the lock is passed to the next thread in the primary queue.
For more details, see https://arxiv.org/abs/1810.05600.

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
Reviewed-by: Waiman Long <longman@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |  10 +
 arch/x86/Kconfig                              |  20 +
 arch/x86/include/asm/qspinlock.h              |   6 +
 arch/x86/kernel/alternative.c                 |   2 +
 kernel/locking/mcs_spinlock.h                 |   2 +-
 kernel/locking/qspinlock.c                    |  39 +-
 kernel/locking/qspinlock_cna.h                | 344 ++++++++++++++++++
 7 files changed, 418 insertions(+), 5 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..cf3ede858e01 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3239,6 +3239,16 @@
 
 	nox2apic	[X86-64,APIC] Do not enable x2APIC mode.
 
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
 	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
 			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
 			Some features depend on CPU0. Known dependencies are:
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea77046f9b..196fde22159b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1566,6 +1566,26 @@ config NUMA
 
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
index 444d6fd9a6d8..5a3027d8ea27 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -27,6 +27,12 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
 	return val;
 }
 
+#ifdef CONFIG_NUMA_AWARE_SPINLOCKS
+extern void cna_configure_spin_lock_slowpath(void);
+#else
+static inline void cna_configure_spin_lock_slowpath(void) { }
+#endif
+
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_init_lock_hash(void);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 15ac0d5f4b40..50f79a8aa2a9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -739,6 +739,8 @@ void __init alternative_instructions(void)
 	}
 #endif
 
+	cna_configure_spin_lock_slowpath();
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
index 6e63c72e3fbd..5b01ab0cc944 100644
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
@@ -589,6 +592,34 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
+/*
+ * Generate the code for NUMA-aware spinlocks
+ */
+#if !defined(_GEN_CNA_LOCK_SLOWPATH) && defined(CONFIG_NUMA_AWARE_SPINLOCKS)
+#define _GEN_CNA_LOCK_SLOWPATH
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
index 000000000000..619883f3dfd3
--- /dev/null
+++ b/kernel/locking/qspinlock_cna.h
@@ -0,0 +1,344 @@
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
+ * After acquiring the MCS lock and before acquiring the spinlock, the lock
+ * holder scans the primary queue looking for a thread running on the same node
+ * (pre-scan). If found (call it thread T), all threads in the primary queue
+ * between the current lock holder and T are moved to the end of the secondary
+ * queue.  If such T is not found, we make another scan of the primary queue
+ * when unlocking the MCS lock (post-scan), starting at the node where pre-scan
+ * stopped. If both scans fail to find such T, the MCS lock is passed to the
+ * first thread in the secondary queue. If the secondary queue is empty, the
+ * lock is passed to the next thread in the primary queue.
+ *
+ * For more details, see https://arxiv.org/abs/1810.05600.
+ *
+ * Authors: Alex Kogan <alex.kogan@oracle.com>
+ *          Dave Dice <dave.dice@oracle.com>
+ */
+
+struct cna_node {
+	struct mcs_spinlock	mcs;
+	int			numa_node;
+	u32			encoded_tail;	/* self */
+	u32			partial_order;	/* encoded tail or enum val */
+};
+
+enum {
+	LOCAL_WAITER_FOUND = 2,	/* 0 and 1 are reserved for @locked */
+	MIN_ENCODED_TAIL
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
+		 * make sure @encoded_tail is not confused with other valid
+		 * values for @locked (0 or 1) or with designated values for
+		 * @pre_scan_result
+		 */
+		WARN_ON(cn->encoded_tail < MIN_ENCODED_TAIL);
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
+ * cna_splice_tail -- splice nodes in the primary queue between [first, last]
+ * onto the secondary queue.
+ */
+static void cna_splice_tail(struct mcs_spinlock *node,
+			    struct mcs_spinlock *first,
+			    struct mcs_spinlock *last)
+{
+	/* remove [first,last] */
+	node->next = last->next;
+
+	/* stick [first,last] on the secondary queue tail */
+	if (node->locked <= 1) { /* if secondary queue is empty */
+		/* create secondary queue */
+		last->next = first;
+	} else {
+		/* add to the tail of the secondary queue */
+		struct mcs_spinlock *tail_2nd = decode_tail(node->locked);
+		struct mcs_spinlock *head_2nd = tail_2nd->next;
+
+		tail_2nd->next = first;
+		last->next = head_2nd;
+	}
+
+	node->locked = ((struct cna_node *)last)->encoded_tail;
+}
+
+/*
+ * cna_order_queue - scan the primary queue looking for the first lock node on
+ * the same NUMA node as the lock holder and move any skipped nodes onto the
+ * secondary queue.
+ *
+ * Returns LOCAL_WAITER_FOUND if a matching node is found; otherwise return
+ * the encoded pointer to the last element inspected (such that a subsequent
+ * scan can continue there).
+ *
+ * The worst case complexity of the scan is O(n), where n is the number
+ * of current waiters. However, the amortized complexity is close to O(1),
+ * as the immediate successor is likely to be running on the same node once
+ * threads from other nodes are moved to the secondary queue.
+ */
+static u32 cna_order_queue(struct mcs_spinlock *node,
+			   struct mcs_spinlock *iter)
+{
+	struct cna_node *cni = (struct cna_node *)READ_ONCE(iter->next);
+	struct cna_node *cn = (struct cna_node *)node;
+	int nid = cn->numa_node;
+	struct cna_node *last;
+
+	/* find any next waiter on 'our' NUMA node */
+	for (last = cn;
+	     cni && cni->numa_node != nid;
+	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
+		;
+
+	if (!cni)
+		return last->encoded_tail; /* continue from here */
+
+	if (last != cn)	/* did we skip any waiters? */
+		cna_splice_tail(node, node->next, (struct mcs_spinlock *)last);
+
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
+	cn->partial_order = cna_order_queue(node, node);
+
+	return 0; /* we lied; we didn't wait, go do so now */
+}
+
+static inline void cna_lock_handoff(struct mcs_spinlock *node,
+				 struct mcs_spinlock *next)
+{
+	struct cna_node *cn = (struct cna_node *)node;
+	u32 val = _Q_LOCKED_VAL;
+	u32 partial_order = cn->partial_order;
+
+	/*
+	 * check if a successor from the same numa node has not been found in
+	 * pre-scan, and if so, try to find it in post-scan starting from the
+	 * node where pre-scan stopped (stored in @pre_scan_result)
+	 */
+	if (partial_order >= MIN_ENCODED_TAIL)
+		partial_order =
+			cna_order_queue(node, decode_tail(partial_order));
+
+	if (partial_order == LOCAL_WAITER_FOUND) {
+		/*
+		 * We found a local waiter; reload @next in case we called
+		 * cna_order_queue() above.
+		 */
+		next = node->next;
+		if (node->locked > 1)
+			val = node->locked;	/* preseve secondary queue */
+	} else if (node->locked > 1) {
+		/*
+		 * When there are no local waiters on the primary queue, splice
+		 * the secondary queue onto the primary queue and pass the lock
+		 * to the longest waiting remote waiter.
+		 */
+		next = cna_splice_head(NULL, 0, node, next);
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
2.21.1 (Apple Git-122.3)

