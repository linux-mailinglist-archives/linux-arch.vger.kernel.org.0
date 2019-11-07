Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B24F3640
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2019 18:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389782AbfKGRwr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Nov 2019 12:52:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34064 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389492AbfKGRwq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Nov 2019 12:52:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7Hj2WL017805;
        Thu, 7 Nov 2019 17:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=Ond/Ou3AXBMDlvWamA95cT9mkghAyo4/RAbi5d7prGU=;
 b=UDNIrYl1QdUPg7dAuK1RyQh4gwk3R+xEisubbni+JodQ7eiVrYY425uqi1rpb92psTLZ
 fAuVmo3QToZOUiEgcEZ6J+0whM8hqe/zYVImnVEnz34b+jFvsr6Opa0j8OgyWxq2HHll
 /HCas7zm0JpjOpNg/IB84s79zEqs3X61bzWoC8lFE8vEcFeuEVi5BYxeLrEpTTfTY915
 t5PU4Dqmhryy5JRuJauJBka5IbJKYIMvrIYaqlkZjjxRSdlV1RdL+RbnGkhd5Enu+P4C
 RPNjYh+9Q7zNFgIR6d3ftXS4eGHN258JM0J2rLa5nY73HPPg4MqjO68puAVwjGdRfITe 9w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w41w0yxh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 17:51:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7HipIH011047;
        Thu, 7 Nov 2019 17:51:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2w41whrn18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 17:51:27 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA7HpLCh007840;
        Thu, 7 Nov 2019 17:51:21 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 09:51:21 -0800
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
Subject: [PATCH v6 3/5] locking/qspinlock: Introduce CNA into the slow path of qspinlock
Date:   Thu,  7 Nov 2019 12:46:20 -0500
Message-Id: <20191107174622.61718-4-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191107174622.61718-1-alex.kogan@oracle.com>
References: <20191107174622.61718-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070165
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In CNA, spinning threads are organized in two queues, a main queue for
threads running on the same node as the current lock holder, and a
secondary queue for threads running on other nodes. After acquiring the
MCS lock and before acquiring the spinlock, the lock holder scans the
main queue looking for a thread running on the same node (pre-scan). If
found (call it thread T), all threads in the main queue between the
current lock holder and T are moved to the end of the secondary queue.
If such T is not found, we make another scan of the main queue when
unlocking the MCS lock (post-scan), starting at the position where
pre-scan stopped. If both scans fail to find such T, the MCS lock is
passed to the first thread in the secondary queue. If the secondary queue
is empty, the lock is passed to the next thread in the main queue.
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
---
 Documentation/admin-guide/kernel-parameters.txt |  10 +
 arch/x86/Kconfig                                |  19 ++
 arch/x86/include/asm/qspinlock.h                |   4 +
 arch/x86/kernel/alternative.c                   |  43 ++++
 kernel/locking/mcs_spinlock.h                   |   2 +-
 kernel/locking/qspinlock.c                      |  34 +++-
 kernel/locking/qspinlock_cna.h                  | 260 ++++++++++++++++++++++++
 7 files changed, 367 insertions(+), 5 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a84a83f8881e..a2fd0c669dba 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3148,6 +3148,16 @@
 
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
index d6e1faa28c58..1d480f190def 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1573,6 +1573,25 @@ config NUMA
 
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
index 444d6fd9a6d8..6fa8fcc5c7af 100644
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
index 9d3a971ea364..6a4ccbf4e09c 100644
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
@@ -738,6 +765,22 @@ void __init alternative_instructions(void)
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
+
+		pr_info("Enabling CNA spinlock\n");
+	}
+#endif
+
 	apply_paravirt(__parainstructions, __parainstructions_end);
 
 	restart_nmi();
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 52d06ec6f525..e40b9538b79f 100644
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
index c06d1e8075d9..6d8c4a52e44e 100644
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
@@ -589,6 +592,29 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
 /*
+ * Generate the code for NUMA-aware spinlocks
+ */
+#if !defined(_GEN_CNA_LOCK_SLOWPATH) && defined(CONFIG_NUMA_AWARE_SPINLOCKS)
+#define _GEN_CNA_LOCK_SLOWPATH
+
+#undef pv_wait_head_or_lock
+#define pv_wait_head_or_lock		cna_pre_scan
+
+#undef try_clear_tail
+#define try_clear_tail			cna_try_change_tail
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
index 000000000000..0cf5a6a2709c
--- /dev/null
+++ b/kernel/locking/qspinlock_cna.h
@@ -0,0 +1,260 @@
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
+ *   |mcs:locked| -+ +--------+        +--------+
+ *   +----------+  |
+ *                 +----------------------+
+ *                                        \/
+ *                 +--------+         +--------+
+ *                 |mcs:next| -> ...  |mcs:next|          [Secondary queue]
+ *                 +--------+         +--------+
+ *                     ^                    |
+ *                     +--------------------+
+ *
+ * N.B. locked = 1 if secondary queue is absent. Othewrise, it contains the
+ * encoded pointer to the tail of the secondary queue, which is organized as a
+ * circular list.
+ *
+ * After acquiring the MCS lock and before acquiring the spinlock, the lock
+ * holder scans the main queue looking for a thread running on the same node
+ * (pre-scan). If found (call it thread T), all threads in the main queue
+ * between the current lock holder and T are moved to the end of the secondary
+ * queue.  If such T is not found, we make another scan of the main queue when
+ * unlocking the MCS lock (post-scan), starting at the node where pre-scan
+ * stopped. If both scans fail to find such T, the MCS lock is passed to the
+ * first thread in the secondary queue. If the secondary queue is empty, the
+ * lock is passed to the next thread in the main queue.
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
+	u32			encoded_tail;
+	u32			pre_scan_result; /* 0 or encoded tail */
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
+		 * it with other valid values for @locked or @pre_scan_result
+		 * (0 or 1)
+		 */
+		WARN_ON(cn->encoded_tail <= 1);
+	}
+}
+
+static int __init cna_init_nodes(void)
+{
+	unsigned int cpu;
+
+	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
+	/* we store an ecoded tail word in the node's @locked field */
+	BUILD_BUG_ON(sizeof(u32) > sizeof(unsigned int));
+
+	for_each_possible_cpu(cpu)
+		cna_init_nodes_per_cpu(cpu);
+
+	return 0;
+}
+early_initcall(cna_init_nodes);
+
+static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
+				       struct mcs_spinlock *node)
+{
+	struct mcs_spinlock *head_2nd, *tail_2nd;
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
+	tail_2nd = decode_tail(node->locked);
+	head_2nd = tail_2nd->next;
+	new = ((struct cna_node *)tail_2nd)->encoded_tail + _Q_LOCKED_VAL;
+
+	if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
+		/*
+		 * Try to reset @next in tail_2nd to NULL, but no need to check
+		 * the result - if failed, a new successor has updated it.
+		 */
+		cmpxchg_relaxed(&tail_2nd->next, head_2nd, NULL);
+		arch_mcs_pass_lock(&head_2nd->locked, 1);
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
+ * cna_scan_main_queue - scan the main waiting queue looking for the first
+ * thread running on the same NUMA node as the lock holder. If found (call it
+ * thread T), move all threads in the main queue between the lock holder and
+ * T to the end of the secondary queue and return 0; otherwise, return the
+ * encoded pointer of the last scanned node in the primary queue (so a
+ * subsequent scan can be resumed from that node)
+ *
+ * Schematically, this may look like the following (nn stands for numa_node and
+ * et stands for encoded_tail).
+ *
+ *   when cna_scan_main_queue() is called (the secondary queue is empty):
+ *
+ *  A+------------+   B+--------+   C+--------+   T+--------+
+ *   |mcs:next    | -> |mcs:next| -> |mcs:next| -> |mcs:next| -> NULL
+ *   |mcs:locked=1|    |cna:nn=0|    |cna:nn=2|    |cna:nn=1|
+ *   |cna:nn=1    |    +--------+    +--------+    +--------+
+ *   +----------- +
+ *
+ *   when cna_scan_main_queue() returns (the secondary queue contains B and C):
+ *
+ *  A+----------------+    T+--------+
+ *   |mcs:next        | ->  |mcs:next| -> NULL
+ *   |mcs:locked=C.et | -+  |cna:nn=1|
+ *   |cna:nn=1        |  |  +--------+
+ *   +--------------- +  +-----+
+ *                             \/
+ *          B+--------+   C+--------+
+ *           |mcs:next| -> |mcs:next| -+
+ *           |cna:nn=0|    |cna:nn=2|  |
+ *           +--------+    +--------+  |
+ *               ^                     |
+ *               +---------------------+
+ *
+ * The worst case complexity of the scan is O(n), where n is the number
+ * of current waiters. However, the amortized complexity is close to O(1),
+ * as the immediate successor is likely to be running on the same node once
+ * threads from other nodes are moved to the secondary queue.
+ */
+static u32 cna_scan_main_queue(struct mcs_spinlock *node,
+			       struct mcs_spinlock *pred_start)
+{
+	struct cna_node *cn = (struct cna_node *)node;
+	struct cna_node *cni = (struct cna_node *)READ_ONCE(pred_start->next);
+	struct cna_node *last;
+	int my_numa_node = cn->numa_node;
+
+	/* find any next waiter on 'our' NUMA node */
+	for (last = cn;
+	     cni && cni->numa_node != my_numa_node;
+	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
+		;
+
+	/* if found, splice any skipped waiters onto the secondary queue */
+	if (cni) {
+		if (last != cn)	/* did we skip any waiters? */
+			cna_splice_tail(node, node->next,
+					(struct mcs_spinlock *)last);
+		return 0;
+	}
+
+	return last->encoded_tail;
+}
+
+__always_inline u32 cna_pre_scan(struct qspinlock *lock,
+				  struct mcs_spinlock *node)
+{
+	struct cna_node *cn = (struct cna_node *)node;
+
+	cn->pre_scan_result = cna_scan_main_queue(node, node);
+
+	return 0;
+}
+
+static inline void cna_pass_lock(struct mcs_spinlock *node,
+				 struct mcs_spinlock *next)
+{
+	struct cna_node *cn = (struct cna_node *)node;
+	struct mcs_spinlock *next_holder = next, *tail_2nd;
+	u32 val = 1;
+
+	u32 scan = cn->pre_scan_result;
+
+	/*
+	 * check if a successor from the same numa node has not been found in
+	 * pre-scan, and if so, try to find it in post-scan starting from the
+	 * node where pre-scan stopped (stored in @pre_scan_result)
+	 */
+	if (scan > 0)
+		scan = cna_scan_main_queue(node, decode_tail(scan));
+
+	if (!scan) { /* if found a successor from the same numa node */
+		next_holder = node->next;
+		/*
+		 * we unlock successor by passing a non-zero value,
+		 * so set @val to 1 iff @locked is 0, which will happen
+		 * if we acquired the MCS lock when its queue was empty
+		 */
+		val = node->locked ? node->locked : 1;
+	} else if (node->locked > 1) {	  /* if secondary queue is not empty */
+		/* next holder will be the first node in the secondary queue */
+		tail_2nd = decode_tail(node->locked);
+		/* @tail_2nd->next points to the head of the secondary queue */
+		next_holder = tail_2nd->next;
+		/* splice the secondary queue onto the head of the main queue */
+		tail_2nd->next = next;
+	}
+
+	arch_mcs_pass_lock(&next_holder->locked, val);
+}
-- 
2.11.0 (Apple Git-81)

