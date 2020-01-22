Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED8145A8E
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2020 18:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAVRFh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jan 2020 12:05:37 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55568 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVRFh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 12:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J42OoTtifdDN3LunEbWluQEhFHDFChSHhb/WUPgfuFk=; b=quPVgMD05WJDnI+3YTuuVz0gD
        KOzL84mUhUQy3t/LlZ65VgJmnJ6SBQU7sOiYr5ed3KcV222CedU174mXPKUYsm9imq9Pc28DL73It
        tim5beEZ6bAqLgwxZnAYheff01oKeFixcXjZG3p5/B4IRRWlyIJV22sJm+h7IKucpJVjL1w32HQaH
        n3tDx7fvsdsjiI36j05ageUbuKr9uQKermVKw2PxcaCCwc7hGDe6niLH8b04RumTaKgGybKCYyxb2
        g+BYIrcusn0vXJ461XwlgsiBv5NsqaEGIEB790Jx4PKjja9PTwkBrmmmuN+Bg0pb5vCXRBrA6LVZZ
        R0QR/dAKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuJR4-0008LB-UM; Wed, 22 Jan 2020 17:04:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C758A305FEA;
        Wed, 22 Jan 2020 18:03:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E69E2B6F5E7C; Wed, 22 Jan 2020 18:04:56 +0100 (CET)
Date:   Wed, 22 Jan 2020 18:04:56 +0100
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
Message-ID: <20200122170456.GY14879@hirez.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <20200121202919.GM11457@worktop.programming.kicks-ass.net>
 <20200122095127.GC14946@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122095127.GC14946@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 22, 2020 at 10:51:27AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2020 at 09:29:19PM +0100, Peter Zijlstra wrote:
> > 
> > various notes and changes in the below.
> 
> Also, sorry for replying to v7 and v8, I forgot to refresh email on the
> laptop and had spotty cell service last night and only found v7 in that
> mailbox.
> 
> Afaict none of the things I commented on were fundamentally changed
> though.

But since I was editing, here is the latest version..

---

Index: linux-2.6/kernel/locking/qspinlock_cna.h
===================================================================
--- /dev/null
+++ linux-2.6/kernel/locking/qspinlock_cna.h
@@ -0,0 +1,261 @@
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
+ * secondary queue for threads running on other nodes. Schematically, it looks
+ * like this:
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
+	u32			encoded_tail;    /* self */
+	u32			partial_order;
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
+		 * it with other valid values for @locked or @partial_order
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
+early_initcall(cna_init_nodes);
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
+ * Returns 0 if a matching node is found; otherwise return the encoded pointer
+ * to the last element inspected (such that a subsequent scan can continue there).
+ *
+ * The worst case complexity of the scan is O(n), where n is the number
+ * of current waiters. However, the amortized complexity is close to O(1),
+ * as the immediate successor is likely to be running on the same node once
+ * threads from other nodes are moved to the secondary queue.
+ *
+ * XXX does not compute; given equal contention it should average to O(nr_nodes).
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
+	if (!cna)
+		return last->encoded_tail; /* continue from here */
+
+	if (last != cn)	/* did we skip any waiters? */
+		cna_splice_tail(node, node->next, (struct mcs_spinlock *)last);
+
+	return 0;
+}
+
+/*
+ * cna_splice_head -- splice the entire secondary queue onto the head of the
+ * primary queue.
+ */
+static cna_splice_head(struct qspinlock *lock, u32 val,
+		       struct mcs_spinlock *node, struct mcs_spinlock *next)
+{
+	struct mcs_spinlock *head_2nd, *tail_2nd;
+
+	tail_2nd = decode_tail(node->locked);
+	head_2nd = tail_2nd->next;
+
+	if (lock) {
+		u32 new = ((struct cna_node *)tail_2nd)->encoded_tail | _Q_LOCKED_VAL;
+		if (!atomic_try_cmpxchg_relaxed(&lock->val, &val, new))
+			return NULL;
+
+		/*
+		 * The moment we've linked the primary tail we can race with
+		 * the WRITE_ONCE(prev->next, node) store from new waiters.
+		 * That store must win.
+		 */
+		cmpxchg_relaxed(&tail_2nd->next, head_2nd, next);
+	} else {
+		tail_2nd->next = next;
+	}
+
+	return head_2nd;
+}
+
+/* Abuse the pv_wait_head_or_lock() hook to get some work done */
+static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
+						 struct mcs_spinlock *node)
+{
+	struct cna_node *cn = (struct cna_node *)node;
+
+	/*
+	 * Try and put the time otherwise spend spin waiting on
+	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
+	 */
+	cn->partial_order = cna_order_queue(node, node);
+
+	return 0; /* we lied; we didn't wait, go do so now */
+}
+
+static inline bool cna_try_clear_tail(struct qspinlock *lock, u32 val,
+				      struct mcs_spinlock *node)
+{
+	struct mcs_spinlock *next;
+
+	/*
+	 * We're here because the primary queue is empty; check the secondary
+	 * queue for remote waiters.
+	 */
+	if (node->locked > 1) {
+		/*
+		 * When there are waiters on the secondary queue move them back
+		 * onto the primary queue and let them rip.
+		 */
+		next = cna_splice_head(lock, val, node, NULL);
+		if (next) {
+			arch_mcs_pass_lock(&head_2nd->locked, 1);
+			return true;
+		}
+
+		return false;
+	}
+
+	/* Both queues empty. */
+	return __try_clear_tail(lock, val, node);
+}
+
+static inline void cna_pass_lock(struct mcs_spinlock *node,
+				 struct mcs_spinlock *next)
+{
+	struct cna_node *cn = (struct cna_node *)node;
+	u32 partial_order = cn->partial_order;
+	u32 val = _Q_LOCKED_VAL;
+
+	/* cna_wait_head_or_lock() left work for us. */
+	if (partial_order) {
+		partial_order = cna_order_queue(node, decode_tail(partial_order));
+
+	if (!partial_order) {
+		/*
+		 * We found a local waiter; reload @next in case we called
+		 * cna_order_queue() above.
+		 */
+		next = node->next;
+		val |= node->locked;	/* preseve secondary queue */
+
+	} else if (node->locked > 1) {
+		/*
+		 * When there are no local waiters on the primary queue, splice
+		 * the secondary queue onto the primary queue and pass the lock
+		 * to the longest waiting remote waiter.
+		 */
+		next = cna_splice_head(NULL, 0, node, next);
+	}
+
+	arch_mcs_pass_lock(&next->locked, val);
+}
