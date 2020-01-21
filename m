Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B861445F2
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 21:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAUU35 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 15:29:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgAUU35 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 15:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZjK+gSSRTzwsBR8YaNezn6RgxhBq9jolN22z/Ym95ko=; b=qMv+95IQMl3PDcbTKubFJrjwB
        O4rCNe0bfe8bMNzU/Q4HXUX5OuVnDWlWn8V0M4unbf+FpF9lxZVKL9ULUPRxD3B/mlxFuEnQeWdZl
        kYW1jepX3EPUn1qklRk5+VCsYsbSQ3TKxdmfJL2OeYzqwHgvfE1G/j8dzSzlyMtrkIo/d8u7G4bim
        6Yv88Ktz8lmmvj+kITbsYcBnljMPZD72vmuLiSZSXQSmPvCyIpfH9r6NmiO6nV1sXXHIujuk5hM1B
        eq8p/p3Zn5MxDPF9xFmaSHaU9cs21P1D3lVKZi0XjUPQHWgPbuoYia3H9zwvnrypY5TvaS0wy4A9G
        lEeelpj5A==;
Received: from [31.161.184.35] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iu09W-0006q1-59; Tue, 21 Jan 2020 20:29:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25FB9980E43; Tue, 21 Jan 2020 21:29:19 +0100 (CET)
Date:   Tue, 21 Jan 2020 21:29:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200121202919.GM11457@worktop.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125210709.10293-4-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


various notes and changes in the below.

---

Index: linux-2.6/kernel/locking/qspinlock.c
===================================================================
--- linux-2.6.orig/kernel/locking/qspinlock.c
+++ linux-2.6/kernel/locking/qspinlock.c
@@ -598,10 +598,10 @@ EXPORT_SYMBOL(queued_spin_lock_slowpath)
 #define _GEN_CNA_LOCK_SLOWPATH
 
 #undef pv_wait_head_or_lock
-#define pv_wait_head_or_lock		cna_pre_scan
+#define pv_wait_head_or_lock		cna_wait_head_or_lock
 
 #undef try_clear_tail
-#define try_clear_tail			cna_try_change_tail
+#define try_clear_tail			cna_try_clear_tail
 
 #undef mcs_pass_lock
 #define mcs_pass_lock			cna_pass_lock
Index: linux-2.6/kernel/locking/qspinlock_cna.h
===================================================================
--- linux-2.6.orig/kernel/locking/qspinlock_cna.h
+++ linux-2.6/kernel/locking/qspinlock_cna.h
@@ -8,37 +8,37 @@
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
  *
- * In CNA, spinning threads are organized in two queues, a main queue for
+ * In CNA, spinning threads are organized in two queues, a primary queue for
  * threads running on the same NUMA node as the current lock holder, and a
- * secondary queue for threads running on other nodes. Schematically, it
- * looks like this:
+ * secondary queue for threads running on other nodes. Schematically, it looks
+ * like this:
  *
  *    cna_node
- *   +----------+    +--------+        +--------+
- *   |mcs:next  | -> |mcs:next| -> ... |mcs:next| -> NULL      [Main queue]
- *   |mcs:locked| -+ +--------+        +--------+
+ *   +----------+     +--------+         +--------+
+ *   |mcs:next  | --> |mcs:next| --> ... |mcs:next| --> NULL  [Primary queue]
+ *   |mcs:locked| -.  +--------+         +--------+
  *   +----------+  |
- *                 +----------------------+
- *                                        \/
+ *                 `----------------------.
+ *                                        v
  *                 +--------+         +--------+
- *                 |mcs:next| -> ...  |mcs:next|          [Secondary queue]
+ *                 |mcs:next| --> ... |mcs:next|            [Secondary queue]
  *                 +--------+         +--------+
  *                     ^                    |
- *                     +--------------------+
+ *                     `--------------------'
  *
- * N.B. locked = 1 if secondary queue is absent. Othewrise, it contains the
+ * N.B. locked := 1 if secondary queue is absent. Othewrise, it contains the
  * encoded pointer to the tail of the secondary queue, which is organized as a
  * circular list.
  *
  * After acquiring the MCS lock and before acquiring the spinlock, the lock
- * holder scans the main queue looking for a thread running on the same node
- * (pre-scan). If found (call it thread T), all threads in the main queue
+ * holder scans the primary queue looking for a thread running on the same node
+ * (pre-scan). If found (call it thread T), all threads in the primary queue
  * between the current lock holder and T are moved to the end of the secondary
- * queue.  If such T is not found, we make another scan of the main queue when
- * unlocking the MCS lock (post-scan), starting at the node where pre-scan
+ * queue.  If such T is not found, we make another scan of the primary queue
+ * when unlocking the MCS lock (post-scan), starting at the node where pre-scan
  * stopped. If both scans fail to find such T, the MCS lock is passed to the
  * first thread in the secondary queue. If the secondary queue is empty, the
- * lock is passed to the next thread in the main queue.
+ * lock is passed to the next thread in the primary queue.
  *
  * For more details, see https://arxiv.org/abs/1810.05600.
  *
@@ -49,8 +49,8 @@
 struct cna_node {
 	struct mcs_spinlock	mcs;
 	int			numa_node;
-	u32			encoded_tail;
-	u32			pre_scan_result; /* 0 or encoded tail */
+	u32			encoded_tail;    /* self */
+	u32			partial_order;
 };
 
 static void __init cna_init_nodes_per_cpu(unsigned int cpu)
@@ -66,7 +66,7 @@ static void __init cna_init_nodes_per_cp
 		cn->encoded_tail = encode_tail(cpu, i);
 		/*
 		 * @encoded_tail has to be larger than 1, so we do not confuse
-		 * it with other valid values for @locked or @pre_scan_result
+		 * it with other valid values for @locked or @partial_order
 		 * (0 or 1)
 		 */
 		WARN_ON(cn->encoded_tail <= 1);
@@ -92,8 +92,8 @@ static int __init cna_init_nodes(void)
 }
 early_initcall(cna_init_nodes);
 
-static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
-				       struct mcs_spinlock *node)
+static inline bool cna_try_clear_tail(struct qspinlock *lock, u32 val,
+				      struct mcs_spinlock *node)
 {
 	struct mcs_spinlock *head_2nd, *tail_2nd;
 	u32 new;
@@ -106,7 +106,9 @@ static inline bool cna_try_change_tail(s
 	 * Try to update the tail value to the last node in the secondary queue.
 	 * If successful, pass the lock to the first thread in the secondary
 	 * queue. Doing those two actions effectively moves all nodes from the
-	 * secondary queue into the main one.
+	 * secondary queue into the primary one.
+	 *
+	 * XXX: reformulate, that's just confusing.
 	 */
 	tail_2nd = decode_tail(node->locked);
 	head_2nd = tail_2nd->next;
@@ -116,6 +118,9 @@ static inline bool cna_try_change_tail(s
 		/*
 		 * Try to reset @next in tail_2nd to NULL, but no need to check
 		 * the result - if failed, a new successor has updated it.
+		 *
+		 * XXX: figure out what how where..
+		 * XXX: cns_pass_lock() does something relared
 		 */
 		cmpxchg_relaxed(&tail_2nd->next, head_2nd, NULL);
 		arch_mcs_pass_lock(&head_2nd->locked, 1);
@@ -126,7 +131,7 @@ static inline bool cna_try_change_tail(s
 }
 
 /*
- * cna_splice_tail -- splice nodes in the main queue between [first, last]
+ * cna_splice_tail -- splice nodes in the primary queue between [first, last]
  * onto the secondary queue.
  */
 static void cna_splice_tail(struct mcs_spinlock *node,
@@ -153,77 +158,56 @@ static void cna_splice_tail(struct mcs_s
 }
 
 /*
- * cna_scan_main_queue - scan the main waiting queue looking for the first
- * thread running on the same NUMA node as the lock holder. If found (call it
- * thread T), move all threads in the main queue between the lock holder and
- * T to the end of the secondary queue and return 0; otherwise, return the
- * encoded pointer of the last scanned node in the primary queue (so a
- * subsequent scan can be resumed from that node)
+ * cna_order_queue - scan the primary queue looking for the first lock node on
+ * the same NUMA node as the lock holder and move any skipped nodes onto the
+ * secondary queue.
  *
- * Schematically, this may look like the following (nn stands for numa_node and
- * et stands for encoded_tail).
- *
- *   when cna_scan_main_queue() is called (the secondary queue is empty):
- *
- *  A+------------+   B+--------+   C+--------+   T+--------+
- *   |mcs:next    | -> |mcs:next| -> |mcs:next| -> |mcs:next| -> NULL
- *   |mcs:locked=1|    |cna:nn=0|    |cna:nn=2|    |cna:nn=1|
- *   |cna:nn=1    |    +--------+    +--------+    +--------+
- *   +----------- +
- *
- *   when cna_scan_main_queue() returns (the secondary queue contains B and C):
- *
- *  A+----------------+    T+--------+
- *   |mcs:next        | ->  |mcs:next| -> NULL
- *   |mcs:locked=C.et | -+  |cna:nn=1|
- *   |cna:nn=1        |  |  +--------+
- *   +--------------- +  +-----+
- *                             \/
- *          B+--------+   C+--------+
- *           |mcs:next| -> |mcs:next| -+
- *           |cna:nn=0|    |cna:nn=2|  |
- *           +--------+    +--------+  |
- *               ^                     |
- *               +---------------------+
+ * Returns 0 if a matching node is found; otherwise return the encoded pointer
+ * to the last element inspected (such that a subsequent scan can continue there).
  *
  * The worst case complexity of the scan is O(n), where n is the number
  * of current waiters. However, the amortized complexity is close to O(1),
  * as the immediate successor is likely to be running on the same node once
  * threads from other nodes are moved to the secondary queue.
+ *
+ * XXX does not compute; given equal contention it should average to O(nr_nodes).
  */
-static u32 cna_scan_main_queue(struct mcs_spinlock *node,
-			       struct mcs_spinlock *pred_start)
+static u32 cna_order_queue(struct mcs_spinlock *node,
+			   struct mcs_spinlock *iter)
 {
+	struct cna_node *cni = (struct cna_node *)READ_ONCE(iter->next);
 	struct cna_node *cn = (struct cna_node *)node;
-	struct cna_node *cni = (struct cna_node *)READ_ONCE(pred_start->next);
+	int nid = cn->numa_node;
 	struct cna_node *last;
-	int my_numa_node = cn->numa_node;
 
 	/* find any next waiter on 'our' NUMA node */
 	for (last = cn;
-	     cni && cni->numa_node != my_numa_node;
+	     cni && cni->numa_node != nid;
 	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
 		;
 
-	/* if found, splice any skipped waiters onto the secondary queue */
-	if (cni) {
-		if (last != cn)	/* did we skip any waiters? */
-			cna_splice_tail(node, node->next,
-					(struct mcs_spinlock *)last);
-		return 0;
-	}
+	if (!cna)
+		return last->encoded_tail; /* continue from here */
+
+	if (last != cn)	/* did we skip any waiters? */
+		cna_splice_tail(node, node->next, (struct mcs_spinlock *)last);
 
-	return last->encoded_tail;
+	return 0;
 }
 
-__always_inline u32 cna_pre_scan(struct qspinlock *lock,
-				  struct mcs_spinlock *node)
+/* abuse the pv_wait_head_or_lock() hook to get some work done */
+static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
+						 struct mcs_spinlock *node)
 {
 	struct cna_node *cn = (struct cna_node *)node;
 
-	cn->pre_scan_result = cna_scan_main_queue(node, node);
+	/*
+	 * Try and put the time otherwise spend spin waiting on
+	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
+	 */
+	cn->partial_order = cna_order_queue(node, node);
 
-	return 0;
+	return 0; /* we lied; we didn't wait, go do so now */
 }
 
 static inline void cna_pass_lock(struct mcs_spinlock *node,
@@ -231,33 +215,27 @@ static inline void cna_pass_lock(struct
 {
 	struct cna_node *cn = (struct cna_node *)node;
 	struct mcs_spinlock *next_holder = next, *tail_2nd;
-	u32 val = 1;
+	u32 partial_order = cn->partial_order;
+	u32 val = _Q_LOCKED_VAL;
 
-	u32 scan = cn->pre_scan_result;
+	/* cna_wait_head_or_lock() left work for us. */
+	if (partial_order) {
+		partial_order = cna_order_queue(node, decode_tail(partial_order));
 
-	/*
-	 * check if a successor from the same numa node has not been found in
-	 * pre-scan, and if so, try to find it in post-scan starting from the
-	 * node where pre-scan stopped (stored in @pre_scan_result)
-	 */
-	if (scan > 0)
-		scan = cna_scan_main_queue(node, decode_tail(scan));
-
-	if (!scan) { /* if found a successor from the same numa node */
+	if (!partial_order) {		/* ordered; use primary queue */
 		next_holder = node->next;
-		/*
-		 * we unlock successor by passing a non-zero value,
-		 * so set @val to 1 iff @locked is 0, which will happen
-		 * if we acquired the MCS lock when its queue was empty
-		 */
-		val = node->locked ? node->locked : 1;
-	} else if (node->locked > 1) {	  /* if secondary queue is not empty */
+		val |= node->locked;	/* preseve secondary queue */
+
+	} else if (node->locked > 1) {	/* try secondary queue */
+
 		/* next holder will be the first node in the secondary queue */
 		tail_2nd = decode_tail(node->locked);
 		/* @tail_2nd->next points to the head of the secondary queue */
 		next_holder = tail_2nd->next;
-		/* splice the secondary queue onto the head of the main queue */
+		/* splice the secondary queue onto the head of the primary queue */
 		tail_2nd->next = next;
+
+		// XXX cna_try_clear_tail also does something like this
 	}
 
 	arch_mcs_pass_lock(&next_holder->locked, val);

