Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B985231356
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 22:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgG1UA0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 16:00:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28865 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728452AbgG1UAY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jul 2020 16:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595966421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NbuVlb20X7aLNVDgvjCFcT8rKevY9uha8UkibvC8p04=;
        b=UX9/wDazZ10qcfjyHSx/CFClJhh3yNTV9iqi9hxiReknBdvYkjZXfwGLXuWRHtrD1IupDb
        DMmGDrrFp6z546Yhvz4psZckkckHc5BvNNyG4taZf4WMHPXFUZ5FQXi4Av0QtkSFhdGeCm
        fa867uNJOMqBydBAyqEyjxTFyK7YiSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-BiJ90p7YN-madmATHVf6Tw-1; Tue, 28 Jul 2020 16:00:16 -0400
X-MC-Unique: BiJ90p7YN-madmATHVf6Tw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 536558014D7;
        Tue, 28 Jul 2020 20:00:14 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-38.rdu2.redhat.com [10.10.119.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C4381002388;
        Tue, 28 Jul 2020 20:00:12 +0000 (UTC)
Subject: Re: [PATCH v10 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20200403205930.1707-1-alex.kogan@oracle.com>
 <20200403205930.1707-4-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a4bf9541-1996-3ba2-dfe5-e734c652ac86@redhat.com>
Date:   Tue, 28 Jul 2020 16:00:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403205930.1707-4-alex.kogan@oracle.com>
Content-Type: multipart/mixed;
 boundary="------------370526D467942428E1F63AAA"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a multi-part message in MIME format.
--------------370526D467942428E1F63AAA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/20 4:59 PM, Alex Kogan wrote:
> In CNA, spinning threads are organized in two queues, a primary queue for
> threads running on the same node as the current lock holder, and a
> secondary queue for threads running on other nodes. After acquiring the
> MCS lock and before acquiring the spinlock, the lock holder scans the
> primary queue looking for a thread running on the same node (pre-scan). If
> found (call it thread T), all threads in the primary queue between the
> current lock holder and T are moved to the end of the secondary queue.
> If such T is not found, we make another scan of the primary queue when
> unlocking the MCS lock (post-scan), starting at the position where
> pre-scan stopped. If both scans fail to find such T, the MCS lock is
> passed to the first thread in the secondary queue. If the secondary queue
> is empty, the lock is passed to the next thread in the primary queue.
> For more details, see https://arxiv.org/abs/1810.05600.
>
> Note that this variant of CNA may introduce starvation by continuously
> passing the lock to threads running on the same node. This issue
> will be addressed later in the series.
>
> Enabling CNA is controlled via a new configuration option
> (NUMA_AWARE_SPINLOCKS). By default, the CNA variant is patched in at the
> boot time only if we run on a multi-node machine in native environment and
> the new config is enabled. (For the time being, the patching requires
> CONFIG_PARAVIRT_SPINLOCKS to be enabled as well. However, this should be
> resolved once static_call() is available.) This default behavior can be
> overridden with the new kernel boot command-line option
> "numa_spinlock=on/off" (default is "auto").
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> ---

There is also a concern that the worst case latency for a lock transfer 
can be close to O(n) which can be quite large for large SMP systems. I 
have a patch on top that modifies the current behavior to limit the 
number of node scans after the lock is freed.

Cheers,
Longman



--------------370526D467942428E1F63AAA
Content-Type: text/x-patch; charset=UTF-8;
 name="0008-locking-qspinlock-Limit-CNA-node-scan-after-the-lock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0008-locking-qspinlock-Limit-CNA-node-scan-after-the-lock.pa";
 filename*1="tch"

From 1e0d1a7c1d04383367b3d7a086ef3becd2fd81d8 Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Tue, 28 Jul 2020 15:13:47 -0400
Subject: [PATCH 8/9] locking/qspinlock: Limit CNA node scan after the lock is
 freed

When there is a long list of lock waiters, the worst case scenario
for CNA is that none of them are from the same NUMA node. All the lock
waiters will have to be scanned to figure that out. If the lock becomes
free early in the scanning process, it means that there will be a long
delay between lock being freed and re-acquired after scanning the full
list. The worst case delay is O(n) where n is the number of lock waiters
which is limited by the number of cpus in the system.

One way to limit the delay is to limit the number of nodes to be scanned
after the lock is freed. Assuming random distribution of NUMA nodes in
the lock waiters, the chance of not finding a lock waiter in the same
NUMA node is ((n-1)/n)^m where n is the number of NUMA nodes and m is
the number of lock waiters scanned. If we limit the number of scans to
4n, for example, the chance of not finding same NUMA node lock waiter
will be 1.4% and 1.6% for 8 and 16-socket servers respectively.
Note that the limit applies only after the lock is freed, so the chance
of not finding the right lock waiter is even lower.

To make this possible, the lock waiter scanning and lock spinning have
to be done at the same time. Since the lock waiter scanning won't stop
until the lock is freed with additional look ahead, if necessary. The
extra scanning done in cna_lock_handoff() isn't needed anymore.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock_cna.h | 130 +++++++++++++++++++++------------
 1 file changed, 83 insertions(+), 47 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 03e8ba71a537..89a3905870ea 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -59,7 +59,7 @@ struct cna_node {
 	u16			numa_node;
 	u16			real_numa_node;
 	u32			encoded_tail;	/* self */
-	u32			partial_order;	/* encoded tail or enum val */
+	u32			order;		/* encoded tail or enum val */
 	s32			start_time;
 };
 
@@ -79,6 +79,12 @@ enum {
 	((m) + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ)
 static int intra_node_handoff_threshold __ro_after_init = MSECS_TO_JIFFIES(10);
 
+/*
+ * Controls how many lookaheads for matching numa node after the lock
+ * is freed.
+ */
+static int matching_node_lookahead __ro_after_init;
+
 static inline bool intra_node_threshold_reached(struct cna_node *cn)
 {
 	s32 current_time = (s32)jiffies;
@@ -105,6 +111,11 @@ static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 		 */
 		WARN_ON(cn->encoded_tail < MIN_ENCODED_TAIL);
 	}
+	/*
+	 * With 4x numa-node lookahead and assuming random node distribution,
+	 * the probability of not finding a matching node is less than 2%.
+	 */
+	matching_node_lookahead = 4*nr_node_ids;
 }
 
 static int __init cna_init_nodes(void)
@@ -262,33 +273,67 @@ static void cna_splice_tail(struct mcs_spinlock *node,
  * of current waiters. However, the amortized complexity is close to O(1),
  * as the immediate successor is likely to be running on the same node once
  * threads from other nodes are moved to the secondary queue.
+ *
+ * Given the fact that the lock state is being monitored at the same time
+ * and the number of additional scans after the lock is freed is limited.
+ * This will limit the additional lock acquisition latency.
  */
-static u32 cna_order_queue(struct mcs_spinlock *node,
-			   struct mcs_spinlock *iter)
+static u32 cna_order_queue(struct mcs_spinlock *node, struct qspinlock *lock)
 {
-	struct cna_node *cni = (struct cna_node *)READ_ONCE(iter->next);
 	struct cna_node *cn = (struct cna_node *)node;
-	int nid = cn->numa_node;
-	struct cna_node *last;
+	struct cna_node *cni = cn;
+	struct cna_node *found = NULL;
+	int lookahead = matching_node_lookahead;
+	bool locked = true;
 
-	/* find any next waiter on 'our' NUMA node */
-	for (last = cn;
-		 /*
-		  * iterate as long as the current node is not priorizied and
-		  * does not run on 'our' NUMA node
-		  */
-	     cni && cni->numa_node != CNA_PRIORITY_NODE && cni->numa_node != nid;
-	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
-		;
+	/*
+	 * Find any next waiter on 'our' NUMA node while spinning on the lock
+	 * simultaneously. Iterate as long as the current node is not
+	 * priorizied and does not run on 'our' NUMA node, or up to
+	 * "lockahead" nodes have been checked after the lock was freed.
+	 */
+	while (!found && lookahead) {
+		if (locked) {
+			u32 val = atomic_read(&lock->val);
+			if (!(val & _Q_LOCKED_PENDING_MASK)) {
+				locked = false;
+				continue;
+			}
+			/*
+			 * If we are hitting the end of the queue, use
+			 * atomic_cond_read_relaxed() to wait until the
+			 * lock value changes which means either the lock
+			 * is freed or a new waiter comes.
+			 */
+			if (cni->encoded_tail == (val & _Q_TAIL_MASK))
+				atomic_cond_read_relaxed(&lock->val, VAL != val);
+		}
+		if (!found) {
+			found = (struct cna_node *)READ_ONCE(cni->mcs.next);
+			if (!found && !locked)
+				break; /* Lock is free with no more nodes to parse */
+
+			if (found && found->numa_node != CNA_PRIORITY_NODE
+				  && found->numa_node != cn->numa_node) {
+				cni = found;
+				found = NULL;
+			}
+			if (!locked)
+				lookahead--;
+		}
+	}
+
+	if (!found)
+		return cni->encoded_tail; /* continue from here */
 
-	if (!cni)
-		return last->encoded_tail; /* continue from here */
+	if (found->numa_node == CNA_PRIORITY_NODE) {
+		int nid = cn->numa_node;
 
-	if (cni->numa_node == CNA_PRIORITY_NODE)
-		cni->numa_node = nid;	/* Inherit node id of primary queue */
+		found->numa_node = nid;	/* Inherit node id of primary queue */
+	}
 
-	if (last != cn)	/* did we skip any waiters? */
-		cna_splice_tail(node, node->next, (struct mcs_spinlock *)last);
+	if (cni != cn)	/* did we skip any waiters? */
+		cna_splice_tail(node, node->next, (struct mcs_spinlock *)cni);
 
 	/*
 	 * We return LOCAL_WAITER_FOUND here even if we stopped the scan because
@@ -312,23 +357,23 @@ static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
 	if (!cn->start_time)
 		cn->start_time = (s32)jiffies;
 
-	if (!intra_node_threshold_reached(cn)) {
-		/*
-		 * We are at the head of the wait queue, no need to use
-		 * the fake NUMA node ID.
-		 */
-		if (cn->numa_node == CNA_PRIORITY_NODE)
-			cn->numa_node = cn->real_numa_node;
-
-		/*
-		 * Try and put the time otherwise spent spin waiting on
-		 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
-		 */
-		cn->partial_order = cna_order_queue(node, node);
-	} else {
-		cn->partial_order = FLUSH_SECONDARY_QUEUE;
+	if (intra_node_threshold_reached(cn)) {
+		cn->order = FLUSH_SECONDARY_QUEUE;
+		goto out;
 	}
+	/*
+	 * We are at the head of the wait queue, no need to use
+	 * the fake NUMA node ID.
+	 */
+	if (cn->numa_node == CNA_PRIORITY_NODE)
+		cn->numa_node = cn->real_numa_node;
 
+	/*
+	 * Try and put the time otherwise spent spin waiting on
+	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
+	 */
+	cn->order = cna_order_queue(node, lock);
+out:
 	return 0; /* we lied; we didn't wait, go do so now */
 }
 
@@ -337,18 +382,9 @@ static inline void cna_lock_handoff(struct mcs_spinlock *node,
 {
 	struct cna_node *cn = (struct cna_node *)node;
 	u32 val = _Q_LOCKED_VAL;
-	u32 partial_order = cn->partial_order;
-
-	/*
-	 * check if a successor from the same numa node has not been found in
-	 * pre-scan, and if so, try to find it in post-scan starting from the
-	 * node where pre-scan stopped (stored in @pre_scan_result)
-	 */
-	if (partial_order >= MIN_ENCODED_TAIL)
-		partial_order =
-			cna_order_queue(node, decode_tail(partial_order));
+	u32 order = cn->order;
 
-	if (partial_order == LOCAL_WAITER_FOUND) {
+	if (order == LOCAL_WAITER_FOUND) {
 		/*
 		 * We found a local waiter; reload @next in case we called
 		 * cna_order_queue() above.
-- 
2.18.1


--------------370526D467942428E1F63AAA--

