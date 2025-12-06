Return-Path: <linux-arch+bounces-15294-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D126CA98FA
	for <lists+linux-arch@lfdr.de>; Sat, 06 Dec 2025 00:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E82C31855BA
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 22:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471A2F6188;
	Fri,  5 Dec 2025 22:58:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487142D3EF2;
	Fri,  5 Dec 2025 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975504; cv=none; b=fRhbhh4ZOxGD4lXKHq9xvVB1UV07g8eVkQ6Dywv8oyAFVZycKyjrypZWuGwMlf+oNbKh4V4ef8FCN7PyOApo79XCJx71U41uvK2IE3OfDu/4uS9pd89eD2e2x7G5MY9P/FJfniYhb/iwTfi/XzAqpaFXzeYEOh3ZnHrBPjpJxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975504; c=relaxed/simple;
	bh=inld7ikSOOWiAqvELWhNnLoB3o0CGbwM0nmm0OTUsMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaIUFS4gRo3nk8RLftnTCSD0W98yaLc2c5COM5UYWLQlL7P+wp4XPa5k2LHNB+hAYfAe9huG8IbbOzt6oBO9JipWpXVChtFJrJmDm9wq/H/sc0sIuVgzWw6jaoTc6aLaExM0GlHKZUJFBEBPTwML78Zflj9Pro6IophOun4kjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dNRBd4FRYzHnGdM;
	Sat,  6 Dec 2025 06:39:21 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id EAD514056B;
	Sat,  6 Dec 2025 06:39:23 +0800 (CST)
Received: from localhost.localdomain (10.123.70.40) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 6 Dec 2025 01:39:23 +0300
From: Anatoly Stepanov <stepanov.anatoly@huawei.com>
To: <peterz@infradead.org>, <boqun.feng@gmail.com>, <longman@redhat.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <arnd@arndb.de>, <dvhart@infradead.org>,
	<dave@stgolabs.net>, <andrealmeid@igalia.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<guohanjun@huawei.com>, <wangkefeng.wang@huawei.com>,
	<weiyongjun1@huawei.com>, <yusongping@huawei.com>, <leijitang@huawei.com>,
	<artem.kuzin@huawei.com>, <fedorov.nikita@h-partners.com>,
	<kang.sun@huawei.com>, Anatoly Stepanov <stepanov.anatoly@huawei.com>
Subject: [RFC PATCH v2 1/5] kernel: introduce Hierarchical Queued spinlock
Date: Sat, 6 Dec 2025 14:21:02 +0800
Message-ID: <20251206062106.2109014-2-stepanov.anatoly@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251206062106.2109014-1-stepanov.anatoly@huawei.com>
References: <aad84044-a9d3-4806-a966-4770a3634b03@redhat.com>
 <20251206062106.2109014-1-stepanov.anatoly@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

We introduce Hierarchical Queued Spinlock (HQ spinlock), aiming to
reduce cross-NUMA cache line traffic and thus improving lock/unlock throughput
for high-contention cases.

This idea might be considered as a combination of cohort-locking
by Dave Dice and Linux kernel queued spinlock.

[Design and workflow]

The contenders are organized into 2-level scheme where each NUMA-node
has it's own FIFO contender queue.

NUMA-queues are linked into single-linked list alike structure, while
maintaining FIFO order between them.
When there're no contenders left in a NUMA-queue, the queue is removed from
the list.

Contenders try to enqueue to local NUMA-queue first and if there's
no such queue - link it to the list.
As for "qspinlock" only the first contender is spinning globally,
all others - MCS-spinning.

"Handoff" operation becomes two-staged:
- local handoff: between contenders in a single NUMA-queue
- remote handoff: between different NUMA-queues.

If "remote handoff" reaches the end of the NUMA-queue linked list it goes to
the list head.

To avoid potential starvation issues, we use handoff thresholds.

Key challenge here was keeping the same "qspinlock" structure size
and "bind" a given lock to related NUMA-queues.

We came up with dynamic lock metadata concept, where we can
dynamically "bind" a given lock to it's NUMA-related metadata, and
then "unbind" when the lock is released.

This approach allows to avoid metadata reservation for every lock in advance,
thus giving the upperbound of metadata instance number to ~ (NR_CPUS x nr_contexts / 2).
Which corresponds to maximum amount of different locks falling into the slowpath.

[Dynamic mode switching]

HQ-lock supports switching between "default qspinlock" mode to "NUMA-aware lock" mode and backwards.
Here we introduce simple scheme: when the contention is high enough a lock switches to NUMA-aware mode
until it is completely released.

If for some reason "NUMA-aware" mode cannot be enabled we fallback to default qspinlock mode.

[Usage]

If someone wants to try the HQ-lock in some subsystem, just
change lock initialization code from "spin_lock_init()" to "spin_lock_init_hq()".
The dedicated bit in the lock structure is used to distiguish between the two lock types.

[Performance measurements]

Performance measurements were done on x86 (AMD EPYC) and arm64 (Kunpeng 920)
platforms with the following scenarious:
- Locktorture benchmark
- Memcached + memtier benchmark
- Ngnix + Wrk benchmark

[Locktorture]

NPS stands for "Nodes per socket"
+------------------------------+-----------------------+-------+-------+--------+
| AMD EPYC 9654									|
+------------------------------+-----------------------+-------+-------+--------+
| 192 cores (x2 hyper-threads) |                       |       |       |        |
| 2 sockets                    |                       |       |       |        |
| Locktorture 60 sec.          | NUMA nodes per-socket |       |       |        |
| Average gain (single lock)   | 1 NPS                 | 2 NPS | 4 NPS | 12 NPS |
| Total contender threads      |                       |       |       |        |
| 8                            | 19%                   | 21%   | 12%   | 12%    |
| 16                           | 13%                   | 18%   | 34%   | 75%    |
| 32                           | 8%                    | 14%   | 25%   | 112%   |
| 64                           | 11%                   | 12%   | 30%   | 152%   |
| 128                          | 9%                    | 17%   | 37%   | 163%   |
| 256                          | 2%                    | 16%   | 40%   | 168%   |
| 384                          | -1%                   | 14%   | 44%   | 186%   |
+------------------------------+-----------------------+-------+-------+--------+

+-----------------+-------+-------+-------+--------+
| Fairness factor | 1 NPS | 2 NPS | 4 NPS | 12 NPS |
+-----------------+-------+-------+-------+--------+
| 8               | 0.54  | 0.57  | 0.57  | 0.55   |
| 16              | 0.52  | 0.53  | 0.60  | 0.58   |
| 32              | 0.53  | 0.53  | 0.53  | 0.61   |
| 64              | 0.52  | 0.56  | 0.54  | 0.56   |
| 128             | 0.51  | 0.54  | 0.54  | 0.53   |
| 256             | 0.52  | 0.52  | 0.52  | 0.52   |
| 384             | 0.51  | 0.51  | 0.51  | 0.51   |
+-----------------+-------+-------+-------+--------+

+-------------------------+--------------+
| Kunpeng 920 (arm64)     |              |
+-------------------------+--------------+
| 96 cores (no MT)        |              |
| 2 sockets, 4 NUMA nodes |              |
| Locktorture 60 sec.     |              |
|                         |              |
| Total contender threads | Average gain |
| 8                       | 93%          |
| 16                      | 142%         |
| 32                      | 129%         |
| 64                      | 152%         |
| 96                      | 158%         |
+-------------------------+--------------+

[Memcached]

+---------------------------------+-----------------+-------------------+
| AMD EPYC 9654                   |                 |                   |
+---------------------------------+-----------------+-------------------+
| 192 cores (x2 hyper-threads)    |                 |                   |
| 2 sockets, NPS=4                |                 |                   |
|                                 |                 |                   |
| Memtier+memcached 1:1 R/W ratio |                 |                   |
| Workers                         | Throughput gain | Latency reduction |
| 32                              | 1%              | -1%               |
| 64                              | 1%              | -1%               |
| 128                             | 3%              | -4%               |
| 256                             | 7%              | -6%               |
| 384                             | 10%             | -8%               |
+---------------------------------+-----------------+-------------------+

+---------------------------------+-----------------+-------------------+
| Kunpeng 920 (arm64)             |                 |                   |
+---------------------------------+-----------------+-------------------+
| 96 cores (no MT)                |                 |                   |
| 2 sockets, 4 NUMA nodes         |                 |                   |
|                                 |                 |                   |
| Memtier+memcached 1:1 R/W ratio |                 |                   |
| Workers                         | Throughput gain | Latency reduction |
| 32                              | 4%              | -3%               |
| 64                              | 6%              | -6%               |
| 80                              | 8%              | -7%               |
| 96                              | 8%              | -8%               |
+---------------------------------+-----------------+-------------------+

[Nginx]

+-----------------------------------------------------------------------+-----------------+
| Kunpeng 920 (arm64)                                                   |                 |
+-----------------------------------------------------------------------+-----------------+
| 96 cores (no MT)                                                      |                 |
| 2 sockets, 4 NUMA nodes                                               |                 |
|                                                                       |                 |
| Nginx + WRK benchmark, single file (lockref spinlock contention case) |                 |
| Workers                                                               | Throughput gain |
| 32                                                                    | 1%              |
| 64                                                                    | 68%             |
| 80                                                                    | 72%             |
| 96                                                                    | 78%             |
+-----------------------------------------------------------------------+-----------------+
Despite, the test is a single-file test, it can be related to real-life cases, when some
html-pages are accessed much more frequently than others (index.html, etc.)

[Low contention remarks]

With the simple contention detection scheme presented in the patch we observe
some degradation, compared to "qspinlock" in low-contention scenraios (< 8 contenders).

We're working on more sophisticated and effective contention-detection method, that
addresses the issue.

Signed-off-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>

Co-authored-by: Stepanov Anatoly <stepanov.anatoly@huawei.com>
Co-authored-by: Fedorov Nikita <fedorov.nikita@h-partners.com>
---
 kernel/locking/hqlock_core.h  | 812 ++++++++++++++++++++++++++++++++++
 kernel/locking/hqlock_meta.h  | 477 ++++++++++++++++++++
 kernel/locking/hqlock_types.h | 118 +++++
 3 files changed, 1407 insertions(+)
 create mode 100644 kernel/locking/hqlock_core.h
 create mode 100644 kernel/locking/hqlock_meta.h
 create mode 100644 kernel/locking/hqlock_types.h

diff --git a/kernel/locking/hqlock_core.h b/kernel/locking/hqlock_core.h
new file mode 100644
index 000000000..c69d6c4f4
--- /dev/null
+++ b/kernel/locking/hqlock_core.h
@@ -0,0 +1,812 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _GEN_HQ_SPINLOCK_SLOWPATH
+#error "Do not include this file!"
+#endif
+
+#include <linux/nodemask.h>
+#include <linux/topology.h>
+#include <linux/sched/clock.h>
+#include <linux/moduleparam.h>
+#include <linux/sched/rt.h>
+#include <linux/random.h>
+#include <linux/mm.h>
+#include <linux/memblock.h>
+#include <linux/sysctl.h>
+#include <linux/types.h>
+#include <linux/percpu.h>
+#include <linux/slab.h>
+#include <linux/panic.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/sprintf.h>
+#include <linux/proc_fs.h>
+#include <linux/uaccess.h>
+#include <linux/swab.h>
+#include <linux/hash.h>
+
+/* Contains queues for all possible lock id */
+static struct numa_queue *queue_table[MAX_NUMNODES];
+
+#include "hqlock_types.h"
+#include "hqlock_proc.h"
+
+/* Gets node_id (1..N) */
+static inline struct numa_queue *
+get_queue(u16 lock_id, u16 node_id)
+{
+	return &queue_table[node_id - 1][lock_id];
+}
+
+static inline struct numa_queue *
+get_local_queue(struct numa_qnode *qnode)
+{
+	return get_queue(qnode->lock_id, qnode->numa_node);
+}
+
+static inline void init_queue_link(struct numa_queue *queue)
+{
+	queue->prev_node = 0;
+	queue->next_node = 0;
+}
+
+static inline void init_queue(struct numa_qnode *qnode)
+{
+	struct numa_queue *queue = get_local_queue(qnode);
+
+	queue->head = qnode;
+	queue->handoffs_not_head = 0;
+	init_queue_link(queue);
+}
+
+static void set_next_queue(u16 lock_id, u16 prev_node_id, u16 node_id)
+{
+	struct numa_queue *local_queue = get_queue(lock_id, node_id);
+	struct numa_queue *prev_queue =
+		get_queue(lock_id, prev_node_id);
+
+	WRITE_ONCE(local_queue->prev_node, prev_node_id);
+	/*
+	 * Needs to be guaranteed the following:
+	 * when appending "local_queue", if "prev_queue->next_node" link
+	 * is observed then "local_queue->prev_node" is also observed.
+	 *
+	 * We need this to guarantee correctness of concurrent
+	 * "unlink_node_queue" for the "prev_queue", if "prev_queue" is the first in the list.
+	 * [prev_queue] <-> [local_queue]
+	 *
+	 * In this case "unlink_node_queue" would be setting "local_queue->prev_node = 0", thus
+	 * w/o the smp-barrier, it might race with "set_next_queue", if
+	 * "local_queue->prev_node = prev_node_id" happens afterwards, leading to corrupted list.
+	 */
+	smp_wmb();
+	WRITE_ONCE(prev_queue->next_node, node_id);
+}
+
+static inline struct lock_metadata *get_meta(u16 lock_id);
+
+/**
+ * Put new node's queue into global NUMA-level queue
+ */
+static inline u16 append_node_queue(u16 lock_id, u16 node_id)
+{
+	struct lock_metadata *lock_meta = get_meta(lock_id);
+	u16 prev_node_id = xchg(&lock_meta->tail_node, node_id);
+
+	if (prev_node_id)
+		set_next_queue(lock_id, prev_node_id, node_id);
+	else
+		WRITE_ONCE(lock_meta->head_node, node_id);
+	return prev_node_id;
+}
+
+#include "hqlock_meta.h"
+
+/**
+ * Update tail
+ *
+ * Call proper function depending on lock's mode
+ * until successful queuing
+ */
+static inline u32 hqlock_xchg_tail(struct qspinlock *lock, u32 tail,
+				 struct mcs_spinlock *node, bool *numa_awareness_on)
+{
+	struct numa_qnode *qnode = (struct numa_qnode *)node;
+
+	u16 lock_id;
+	u32 old_tail;
+	u32 next_tail = tail;
+
+	/*
+	 * Key lock's mode switches questions:
+	 * - After init lock is in LOCK_MODE_QSPINLOCK
+	 * - If many contenders have come while lock was in LOCK_MODE_QSPINLOCK,
+	 *   we want this lock to use NUMA awareness next time,
+	 *   so we clean LOCK_MODE_QSPINLOCK, see 'low_contention_try_clear_tail'
+	 * - During next lock's usages we try to go through NUMA-aware path.
+	 *   We can fail here, because we use shared metadata
+	 *   and can have a conflict with another lock, see 'hqlock_meta.h' for details.
+	 *   In this case we fallback to generic qspinlock approach.
+	 *
+	 * In other words, lock can be in 3 mode states:
+	 *
+	 * 1. LOCK_MODE_QSPINLOCK - there was low contention or not at all earlier,
+	 *    or (unlikely) a conflict in metadata
+	 * 2. LOCK_NO_MODE - there was a contention on a lock earlier,
+	 *    now there are no contenders in the queue (we are likely the first)
+	 *    and we need to try using NUMA awareness
+	 * 3. LOCK_MODE_HQLOCK - lock is currently under contention
+	 *    and using NUMA awareness.
+	 */
+
+	/*
+	 * numa_awareness_on == false means we saw LOCK_MODE_QSPINLOCK (1st state)
+	 * before starting slowpath, see 'queued_spin_lock_slowpath'
+	 */
+	if (*numa_awareness_on == false &&
+		try_update_tail_qspinlock_mode(lock, tail, &old_tail, &next_tail))
+		return old_tail;
+
+	/* Calculate the lock_id hash here once */
+	qnode->lock_id = lock_id = hash_ptr(lock, LOCK_ID_BITS);
+
+try_again:
+	/*
+	 * Lock is in state 2 or 3 - go through NUMA-aware path
+	 */
+	if (try_update_tail_hqlock_mode(lock, lock_id, qnode, tail, &next_tail, &old_tail)) {
+		*numa_awareness_on = true;
+		return old_tail;
+	}
+
+	/*
+	 * We have failed (conflict in metadata), now lock is in LOCK_MODE_QSPINLOCK again
+	 */
+	if (try_update_tail_qspinlock_mode(lock, tail, &old_tail, &next_tail)) {
+		*numa_awareness_on = false;
+		return old_tail;
+	}
+
+	/*
+	 * We were slow and clear_tail after high contention has already happened
+	 * (very unlikely situation)
+	 */
+	goto try_again;
+}
+
+static inline void hqlock_clear_pending(struct qspinlock *lock, u32 old_val)
+{
+	WRITE_ONCE(lock->pending, (old_val & _Q_LOCK_TYPE_MODE_MASK) >> _Q_PENDING_OFFSET);
+}
+
+static inline void hqlock_clear_pending_set_locked(struct qspinlock *lock, u32 old_val)
+{
+	WRITE_ONCE(lock->locked_pending,
+			_Q_LOCKED_VAL | (old_val & _Q_LOCK_TYPE_MODE_MASK));
+}
+
+static inline void unlink_node_queue(u16 lock_id,
+					u16 prev_node_id,
+					u16 next_node_id)
+{
+	struct numa_queue *prev_queue =
+		prev_node_id ? get_queue(lock_id, prev_node_id) : NULL;
+	struct numa_queue *next_queue = get_queue(lock_id, next_node_id);
+
+	if (prev_queue)
+		WRITE_ONCE(prev_queue->next_node, next_node_id);
+	/*
+	 * This is guaranteed to be ordered "after" next_node_id observation
+	 * by implicit full-barrier in the caller-code.
+	 */
+	WRITE_ONCE(next_queue->prev_node, prev_node_id);
+}
+
+static inline bool try_clear_queue_tail(struct numa_queue *queue, u32 tail)
+{
+	/*
+	 * We need full ordering here to:
+	 * - ensure all prior operations with global tail and prev_queue
+	 *   are observed before clearing local tail
+	 * - guarantee all subsequent operations
+	 *   with metadata release, unlink etc will be observed after clearing local tail
+	 */
+	return cmpxchg(&queue->tail, tail, 0) == tail;
+}
+
+/*
+ * Determine if we have another local and global contenders.
+ * Try clear local and global tail, understand handoff type we need to perform.
+ * In case we are the last, free lock's metadata
+ */
+static inline bool hqlock_try_clear_tail(struct qspinlock *lock, u32 val,
+				       u32 tail, struct mcs_spinlock *node,
+				       int *p_next_node)
+{
+	bool ret = false;
+	struct numa_qnode *qnode = (void *)node;
+
+	u16 lock_id = qnode->lock_id;
+	u16 local_node = qnode->numa_node;
+	struct numa_queue *queue = get_queue(lock_id, qnode->numa_node);
+
+	struct lock_metadata *lock_meta = get_meta(lock_id);
+
+	u16 prev_node = 0, next_node = 0;
+	u16 node_tail;
+
+	u32 old_val;
+
+	bool lock_tail_updated = false;
+	bool lock_tail_cleared = false;
+
+	/* Do we have *next node* arrived */
+	bool pending_next_node = false;
+
+	tail >>= _Q_TAIL_OFFSET;
+
+	/* Do we have other CPUs in the node queue ? */
+	if (READ_ONCE(queue->tail) != tail) {
+		*p_next_node = HQLOCK_HANDOFF_LOCAL;
+		goto out;
+	}
+
+	/*
+	 * Key observations and actions:
+	 * 1) next queue isn't observed:
+	 *    a) if prev queue is observed, try to unpublish local queue
+	 *    b) if prev queue is not observed, try to clean global tail
+	 *    Anyway, perform these operations before clearing local tail.
+	 *
+	 *    Such trick is essential to safely unlink the local queue,
+	 *    otherwise we could race with upcomming local contenders,
+	 *    which will perform 'append_node_queue' while our unlink is not properly done.
+	 *
+	 * 2) next queue is observed:
+	 *    safely perform 'try_clear_queue_tail' and unlink local node if succeeded.
+	 */
+
+	prev_node = READ_ONCE(queue->prev_node);
+	pending_next_node = READ_ONCE(lock_meta->tail_node) != local_node;
+
+	/*
+	 * Tail case:
+	 * [prev_node] -> [local_node], lock->tail_node == local_node
+	 *
+	 * There're no nodes after us at the moment, try updating the "lock->tail_node"
+	 */
+	if (!pending_next_node && prev_node) {
+		struct numa_queue *prev_queue =
+			get_queue(lock_id, prev_node);
+
+		/* Reset next_node, in case no one will come after */
+		WRITE_ONCE(prev_queue->next_node, 0);
+
+		/*
+		 * release to publish prev_queue->next_node = 0
+		 * and to ensure ordering with 'READ_ONCE(queue->tail) != tail'
+		 */
+		if (cmpxchg_release(&lock_meta->tail_node, local_node, prev_node) == local_node) {
+			lock_tail_updated = true;
+
+			queue->next_node = 0;
+			queue->prev_node = 0;
+			next_node = 0;
+		} else {
+			/* If some node came after the local meanwhile, reset next_node back */
+			WRITE_ONCE(prev_queue->next_node, local_node);
+
+			/* We either observing updated "queue->next" or it equals zero */
+			next_node = READ_ONCE(queue->next_node);
+		}
+	}
+
+	node_tail = READ_ONCE(lock_meta->tail_node);
+
+	/* If nobody else is waiting, try clean global tail */
+	if (node_tail == local_node && !prev_node) {
+		old_val = (((u32)local_node) | (((u32)local_node) << 16));
+		/* release to ensure ordering with 'READ_ONCE(queue->tail) != tail' */
+		lock_tail_cleared = try_cmpxchg_release(&lock_meta->nodes_tail, &old_val, 0);
+	}
+
+	/*
+	 * lock->tail_node was not updated and cleared,
+	 * so we have at least single non-empty node after us
+	 */
+	if (!lock_tail_updated && !lock_tail_cleared) {
+		/*
+		 * If there's a node came before clearing node queue - wait for it to link properly.
+		 * We need this for correct upcoming *unlink*, otherwise the *unlink* might race with parallel set_next_node()
+		 */
+		if (!next_node) {
+			next_node =
+				smp_cond_load_relaxed(&queue->next_node, (VAL));
+		}
+	}
+
+	/* if we're the last one in the queue - clear the queue tail */
+	if (try_clear_queue_tail(queue, tail)) {
+		/*
+		 * "lock_tail_cleared == true"
+		 * It means: we cleared "lock->tail_node" and "lock->head_node".
+		 *
+		 * First new contender will do "global spin" anyway, so no handoff needed
+		 * "ret == true"
+		 */
+		if (lock_tail_cleared) {
+			ret = true;
+
+			/*
+			 * If someone has arrived in the meanwhile,
+			 * don't try to free the metadata.
+			 */
+			old_val = READ_ONCE(lock_meta->nodes_tail);
+			if (!old_val) {
+				/*
+				 * We are probably the last contender,
+				 * so, need to free lock's metadata.
+				 */
+				release_lock_meta(lock, lock_meta, qnode);
+			}
+			goto out;
+		}
+
+		/*
+		 * "lock_tail_updated == true" (implies "lock_tail_cleared == false")
+		 * It means we have at least "prev_node" and unlinked "local node"
+		 *
+		 * As we unlinked "local node", we only need to guarantee correct
+		 * remote handoff, thus we have:
+		 * "ret == false"
+		 * "next_node == HQLOCK_HANDOFF_REMOTE_HEAD"
+		 */
+		if (lock_tail_updated) {
+			*p_next_node = HQLOCK_HANDOFF_REMOTE_HEAD;
+			goto out;
+		}
+
+		/*
+		 * "!lock_tail_cleared && !lock_tail_updated"
+		 * It means we have at least single node after us.
+		 *
+		 * remote handoff and corect "local node" unlink are needed.
+		 *
+		 * "next_node" visibility guarantees that we observe
+		 * correctly additon of "next_node", so the following unlink
+		 * is safe and correct.
+		 *
+		 * "next_node > 0"
+		 * "ret == false"
+		 */
+		unlink_node_queue(lock_id, prev_node, next_node);
+
+		/*
+		 * If at the head - update one.
+		 *
+		 * Another place, where "lock->head_node" is updated is "append_node_queue"
+		 * But we're safe, as that happens only with the first node on empty "node list".
+		 */
+		if (!prev_node)
+			WRITE_ONCE(lock_meta->head_node, next_node);
+
+		*p_next_node = next_node;
+	} else {
+		/*
+		 * local queue has other contenders.
+		 *
+		 * 1) "lock_tail_updated == true":
+		 * It means we have at least "prev_node" and unlinked "local node"
+		 * Also, some new nodes can arrive and link after "prev_node".
+		 * We should just re-add "local node": (prev_node) => ... => (local_node)
+		 * and perform local handoff, as other CPUs from the local node do "mcs spin"
+		 *
+		 * 2) "lock_tail_cleared == true"
+		 * It means we cleared "lock->tail_node" and "lock->head_node".
+		 * We need to re-add "local node" and move "local_queue->head" to the next "mcs-node",
+		 * which is in the progress of linking after the current "mcs-node"
+		 * (that's why we couldn't clear the "local_queue->tail").
+		 *
+		 * Meanwhile other nodes can arrive: (new_node) => (...)
+		 * That "new_node" will spin in "global spin" mode.
+		 * In this case no handoff needed.
+		 *
+		 * 3) "!lock_tail_cleared && !lock_tail_updated"
+		 * It means we had at least one node after us before 'try_clear_queue_tail'
+		 * and only need to perform local handoff
+		 */
+
+		/* Cases 1) and 2) */
+		if (lock_tail_updated || lock_tail_cleared) {
+			u16 prev_node_id;
+
+			init_queue_link(queue);
+			prev_node_id =
+				append_node_queue(lock_id, local_node);
+
+			if (prev_node_id && lock_tail_cleared) {
+				/* Case 2) */
+				ret = true;
+				WRITE_ONCE(queue->head,
+					   (void *) smp_cond_load_relaxed(&node->next, (VAL)));
+				goto out;
+			}
+		}
+
+		/* Cases 1) and 3) */
+		*p_next_node = HQLOCK_HANDOFF_LOCAL;
+		ret = false;
+	}
+out:
+	/*
+	 * Either handoff for current node,
+	 * or remote handoff if the quota is expired
+	 */
+	return ret;
+}
+
+static inline void hqlock_handoff(struct qspinlock *lock,
+					 struct mcs_spinlock *node,
+					 struct mcs_spinlock *next, u32 tail,
+					 int handoff_info);
+
+
+/*
+ * Chech if contention has risen and if we need to set NUMA-aware mode
+ */
+static __always_inline bool determine_contention_qspinlock_mode(struct mcs_spinlock *node)
+{
+	struct numa_qnode *qnode = (void *)node;
+
+	if (qnode->general_handoffs > READ_ONCE(hqlock_general_handoffs_turn_numa))
+		return true;
+	return false;
+}
+
+static __always_inline bool low_contention_try_clear_tail(struct qspinlock *lock,
+					     u32 val,
+					     struct mcs_spinlock *node)
+{
+	u32 update_val = _Q_LOCKED_VAL | _Q_LOCKTYPE_HQ;
+
+	bool high_contention = determine_contention_qspinlock_mode(node);
+
+	/*
+	 * If we have high contention, we set _Q_LOCK_INVALID_TAIL
+	 * to notify upcomming contenders, which have seen QSPINLOCK mode,
+	 * that performing generic 'xchg_tail' is wrong.
+	 *
+	 * We cannot also set HQLOCK mode here,
+	 * because first contender in updated mode
+	 * should check if lock's metadata is free
+	 */
+	if (!high_contention)
+		update_val |= _Q_LOCK_MODE_QSPINLOCK_VAL;
+	else
+		update_val |= _Q_LOCK_INVALID_TAIL;
+
+	return atomic_try_cmpxchg_relaxed(&lock->val, &val, update_val);
+}
+
+static __always_inline void low_contention_mcs_lock_handoff(struct mcs_spinlock *node,
+					       struct mcs_spinlock *next, struct mcs_spinlock *prev)
+{
+	struct numa_qnode *qnode = (void *)node;
+	struct numa_qnode *qnext = (void *)next;
+
+	static u16 max_u16 = (u16)(-1);
+
+	u16 general_handoffs = qnode->general_handoffs;
+
+	if (next != prev && likely(general_handoffs + 1 != max_u16))
+		general_handoffs++;
+
+#ifdef CONFIG_HQSPINLOCKS_DEBUG
+	if (READ_ONCE(max_general_handoffs) < general_handoffs)
+		WRITE_ONCE(max_general_handoffs, general_handoffs);
+#endif
+	qnext->general_handoffs = general_handoffs;
+	arch_mcs_spin_unlock_contended(&next->locked);
+}
+
+static inline void hqlock_clear_tail_handoff(struct qspinlock *lock, u32 val,
+				    u32 tail,
+				    struct mcs_spinlock *node,
+				    struct mcs_spinlock *next,
+					struct mcs_spinlock *prev,
+					bool is_numa_lock)
+{
+	int handoff_info;
+	struct numa_qnode *qnode = (void *)node;
+
+	/*
+	 * qnode->wrong_fallback_tail means we have queued globally
+	 * in 'try_update_tail_qspinlock_mode' after another contender,
+	 * but lock's mode was not QSPINLOCK in that moment.
+	 *
+	 * First confused contender has restored _Q_LOCK_INVALID_TAIL in global tail
+	 * and set us in his local queue.
+	 */
+	if (is_numa_lock || qnode->wrong_fallback_tail) {
+		/*
+		 * Because of splitting generic tail and NUMA tail we must set locked before clearing tail,
+		 * otherwise double lock is possible
+		 */
+		set_locked(lock);
+
+		if (hqlock_try_clear_tail(lock, val, tail, node, &handoff_info))
+			return;
+
+		hqlock_handoff(lock, node, next, tail, handoff_info);
+	} else {
+		if ((val & _Q_TAIL_MASK) == tail) {
+			if (low_contention_try_clear_tail(lock, val, node))
+				return;
+		}
+
+		set_locked(lock);
+
+		if (!next)
+			next = smp_cond_load_relaxed(&node->next, (VAL));
+
+		low_contention_mcs_lock_handoff(node, next, prev);
+	}
+}
+
+static inline void hqlock_init_node(struct mcs_spinlock *node)
+{
+	struct numa_qnode *qnode = (void *)node;
+
+	qnode->general_handoffs = 0;
+	qnode->numa_node = numa_node_id() + 1;
+	qnode->lock_id = 0;
+	qnode->wrong_fallback_tail = 0;
+}
+
+static inline void reset_handoff_counter(struct numa_qnode *qnode)
+{
+	qnode->general_handoffs = 0;
+}
+
+static inline void handoff_local(struct mcs_spinlock *node,
+					       struct mcs_spinlock *next,
+					       u32 tail)
+{
+	static u16 max_u16 = (u16)(-1);
+
+	struct numa_qnode *qnode = (struct numa_qnode *)node;
+	struct numa_qnode *qnext = (struct numa_qnode *)next;
+
+	u16 general_handoffs = qnode->general_handoffs;
+
+	if (likely(general_handoffs + 1 != max_u16))
+		general_handoffs++;
+
+	qnext->general_handoffs = general_handoffs;
+
+	u16 wrong_fallback_tail = qnode->wrong_fallback_tail;
+
+	if (wrong_fallback_tail != 0 && wrong_fallback_tail != (tail >> _Q_TAIL_OFFSET)) {
+		qnext->numa_node = qnode->numa_node;
+		qnext->wrong_fallback_tail = wrong_fallback_tail;
+		qnext->lock_id = qnode->lock_id;
+	}
+
+	arch_mcs_spin_unlock_contended(&next->locked);
+}
+
+static inline void handoff_remote(struct qspinlock *lock,
+						struct numa_qnode *qnode,
+						u32 tail, int handoff_info)
+{
+	struct numa_queue *next_queue = NULL;
+	struct mcs_spinlock *mcs_head = NULL;
+	struct numa_qnode *qhead = NULL;
+	u16 lock_id = qnode->lock_id;
+
+	struct lock_metadata *lock_meta = get_meta(lock_id);
+	struct numa_queue *queue = get_local_queue(qnode);
+
+	u16 next_node_id;
+	u16 node_head, node_tail;
+
+	node_tail = READ_ONCE(lock_meta->tail_node);
+	node_head = READ_ONCE(lock_meta->head_node);
+
+	/*
+	 * 'handoffs_not_head > 0' means at the head of NUMA-level queue we have a node
+	 * which is heavily loaded and has performed a remote handoff upon reaching the threshold.
+	 *
+	 * Perform handoff to the head instead of next node in the NUMA-level queue,
+	 * if handoffs_not_head >= nr_online_nodes
+	 * (It means other contended nodes have been taking the lock at least once after the head one)
+	 */
+	u16 handoffs_not_head = READ_ONCE(queue->handoffs_not_head);
+
+	if (handoff_info > 0 && (handoffs_not_head < nr_online_nodes)) {
+		next_node_id = handoff_info;
+		if (node_head != qnode->numa_node)
+			handoffs_not_head++;
+	} else {
+		if (!node_head) {
+			/* If we're here - we have defintely other node-contenders, let's wait */
+			next_node_id = smp_cond_load_relaxed(&lock_meta->head_node, (VAL));
+		} else {
+			next_node_id = node_head;
+		}
+
+		handoffs_not_head = 0;
+	}
+
+	next_queue = get_queue(lock_id, next_node_id);
+	WRITE_ONCE(next_queue->handoffs_not_head, handoffs_not_head);
+
+	qhead = READ_ONCE(next_queue->head);
+
+	mcs_head = (void *) qhead;
+
+	/* arch_mcs_spin_unlock_contended implies smp-barrier */
+	arch_mcs_spin_unlock_contended(&mcs_head->locked);
+}
+
+static inline bool has_other_nodes(struct qspinlock *lock,
+				   struct numa_qnode *qnode)
+{
+	struct lock_metadata *lock_meta = get_meta(qnode->lock_id);
+
+	return lock_meta->tail_node != qnode->numa_node;
+}
+
+static inline bool is_node_threshold_reached(struct numa_qnode *qnode)
+{
+	return qnode->general_handoffs > hqlock_fairness_threshold;
+}
+
+static inline void hqlock_handoff(struct qspinlock *lock,
+					 struct mcs_spinlock *node,
+					 struct mcs_spinlock *next, u32 tail,
+					 int handoff_info)
+{
+	struct numa_qnode *qnode = (void *)node;
+	u16 lock_id = qnode->lock_id;
+	struct lock_metadata *lock_meta = get_meta(lock_id);
+	struct numa_queue *queue = get_local_queue(qnode);
+
+	if (handoff_info == HQLOCK_HANDOFF_LOCAL) {
+		if (!next)
+			next = smp_cond_load_relaxed(&node->next, (VAL));
+		WRITE_ONCE(queue->head, (void *) next);
+
+		bool threshold_expired = is_node_threshold_reached(qnode);
+
+		if (!threshold_expired || qnode->wrong_fallback_tail) {
+			handoff_local(node, next, tail);
+			return;
+		}
+
+		u16 queue_next = READ_ONCE(queue->next_node);
+		bool has_others = has_other_nodes(lock, qnode);
+
+		/*
+		 * This check is racy, but it's ok,
+		 * because we fallback to local node in the worst case
+		 * and do not call reset_handoff_counter.
+		 * Next local contender will perform remote handoff
+		 * after next queue is properly linked
+		 */
+		if (has_others) {
+			handoff_info =
+				queue_next > 0 ? queue_next : HQLOCK_HANDOFF_LOCAL;
+		} else {
+			handoff_info = HQLOCK_HANDOFF_REMOTE_HEAD;
+		}
+
+		if (handoff_info == HQLOCK_HANDOFF_LOCAL ||
+			(handoff_info == HQLOCK_HANDOFF_REMOTE_HEAD &&
+				READ_ONCE(lock_meta->head_node) == qnode->numa_node)) {
+			/*
+			 * No other nodes have come yet, so we can clean fairness counter
+			 */
+			if (handoff_info == HQLOCK_HANDOFF_REMOTE_HEAD)
+				reset_handoff_counter(qnode);
+			handoff_local(node, next, tail);
+			return;
+		}
+	}
+
+	handoff_remote(lock, qnode, tail, handoff_info);
+	reset_handoff_counter(qnode);
+}
+
+static void __init hqlock_alloc_global_queues(void)
+{
+	int nid;
+	phys_addr_t phys_addr;
+
+	// meta_pool
+	unsigned long meta_pool_size =
+		sizeof(struct lock_metadata) * LOCK_ID_MAX;
+
+	pr_info("Init HQspinlock lock_metadata info: size = %lu B\n",
+		meta_pool_size);
+
+	phys_addr = memblock_alloc_range_nid(
+				meta_pool_size, L1_CACHE_BYTES, 0,
+				MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE, false);
+
+	if (!phys_addr)
+		panic("HQspinlock lock_metadata metadata info: allocation failure.\n");
+
+	meta_pool = phys_to_virt(phys_addr);
+	memset(meta_pool, 0, meta_pool_size);
+
+	for (int i = 0; i < LOCK_ID_MAX; i++)
+		atomic_set(&meta_pool[i].seq_counter, 0);
+
+	/* Total queues size for all buckets */
+	unsigned long queues_size =
+		LOCK_ID_MAX *
+		ALIGN(sizeof(struct numa_queue), L1_CACHE_BYTES);
+
+	pr_info("Init HQspinlock per-NUMA metadata (per-node size = %lu B)\n",
+		queues_size);
+
+
+	for_each_node(nid) {
+		phys_addr = memblock_alloc_range_nid(
+			queues_size, L1_CACHE_BYTES, 0, MEMBLOCK_ALLOC_ACCESSIBLE,
+			nid, false);
+
+		if (!phys_addr)
+			panic("HQspinlock per-NUMA metadata: allocation failure for node %d.\n", nid);
+
+		queue_table[nid] = phys_to_virt(phys_addr);
+		memset(queue_table[nid], 0, queues_size);
+	}
+}
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#define hq_queued_spin_lock_slowpath	pv_ops.lock.queued_spin_lock_slowpath
+#else
+void (*hq_queued_spin_lock_slowpath)(struct qspinlock *lock, u32 val) =
+		native_queued_spin_lock_slowpath;
+EXPORT_SYMBOL(hq_queued_spin_lock_slowpath);
+#endif
+
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
+void __hq_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+
+void __init hq_configure_spin_lock_slowpath(void)
+{
+	if (numa_spinlock_flag < 0)
+		return;
+
+	if (numa_spinlock_flag == 0 && (nr_node_ids < 2 ||
+		    hq_queued_spin_lock_slowpath !=
+			native_queued_spin_lock_slowpath)) {
+		return;
+	}
+
+	numa_spinlock_flag = 1;
+	hq_queued_spin_lock_slowpath = __hq_queued_spin_lock_slowpath;
+	pr_info("Enabling HQspinlock\n");
+	hqlock_alloc_global_queues();
+}
diff --git a/kernel/locking/hqlock_meta.h b/kernel/locking/hqlock_meta.h
new file mode 100644
index 000000000..d9fb70af3
--- /dev/null
+++ b/kernel/locking/hqlock_meta.h
@@ -0,0 +1,477 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _GEN_HQ_SPINLOCK_SLOWPATH
+#error "Do not include this file!"
+#endif
+
+/* Lock metadata pool */
+static struct lock_metadata *meta_pool;
+
+static inline struct lock_metadata *get_meta(u16 lock_id)
+{
+	return &meta_pool[lock_id];
+}
+
+static inline hqlock_mode_t set_lock_mode(struct qspinlock *lock, int __val, u16 lock_id)
+{
+	u32 val = (u32)__val;
+	u32 new_val = 0;
+	u32 lock_mode = encode_lock_mode(lock_id);
+
+	while (!(val & _Q_LOCK_MODE_MASK)) {
+		/*
+		 * We need wait until pending is gone.
+		 * Otherwise, clearing pending can erase a NUMA mode we will set here
+		 */
+		if (val & _Q_PENDING_VAL) {
+			val = atomic_cond_read_relaxed(&lock->val, !(VAL & _Q_PENDING_VAL));
+
+			if (val & _Q_LOCK_MODE_MASK)
+				return LOCK_NO_MODE;
+		}
+
+		/*
+		 * If we are enabling NUMA-awareness, we should keep previous value in lock->tail
+		 * in case of having contenders seen LOCK_MODE_QSPINLOCK and set their tails via xchg_tail
+		 * (They will restore it to _Q_LOCK_INVALID_TAIL later).
+		 * If we are setting LOCK_MODE_QSPINLOCK, remove _Q_LOCK_INVALID_TAIL
+		 */
+		if (lock_id != LOCK_ID_NONE)
+			new_val = val | lock_mode;
+		else
+			new_val = (val & ~_Q_LOCK_INVALID_TAIL) | lock_mode;
+
+		/*
+		 * If we're setting LOCK_MODE_HQLOCK, make sure all "seq_counter"
+		 * updates (per-queue, lock_meta) are observed before lock mode update.
+		 * Paired with smp_rmb() in setup_lock_mode().
+		 */
+		if (lock_id != LOCK_ID_NONE)
+			smp_wmb();
+
+		bool updated = atomic_try_cmpxchg_relaxed(&lock->val, &val, new_val);
+
+		if (updated) {
+			return (lock_id == LOCK_ID_NONE) ?
+				LOCK_MODE_QSPINLOCK : LOCK_MODE_HQLOCK;
+		}
+	}
+
+	return LOCK_NO_MODE;
+}
+
+static inline hqlock_mode_t set_mode_hqlock(struct qspinlock *lock, int val, u16 lock_id)
+{
+	return set_lock_mode(lock, val, lock_id);
+}
+
+static inline hqlock_mode_t set_mode_qspinlock(struct qspinlock *lock, int val)
+{
+	return set_lock_mode(lock, val, LOCK_ID_NONE);
+}
+
+/* Dynamic lock-mode conditions */
+static inline bool is_mode_hqlock(int val)
+{
+	return decode_lock_mode(val) == LOCK_MODE_HQLOCK;
+}
+
+static inline bool is_mode_qspinlock(int val)
+{
+	return decode_lock_mode(val) == LOCK_MODE_QSPINLOCK;
+}
+
+enum meta_status {
+	META_CONFLICT = 0,
+	META_GRABBED,
+	META_SHARED,
+};
+
+static inline enum meta_status grab_lock_meta(struct qspinlock *lock, u32 lock_id, u32 *seq)
+{
+	int nid, seq_counter;
+	struct qspinlock *old = READ_ONCE(meta_pool[lock_id].lock_ptr);
+
+	if (old && old != lock)
+		return META_CONFLICT;
+
+	if (old && old == lock)
+		return META_SHARED;
+
+	old = cmpxchg_acquire(&meta_pool[lock_id].lock_ptr, NULL, lock);
+	if (!old)
+		goto init_meta;
+
+	/* Hash-conflict */
+	if (old != lock)
+		return META_CONFLICT;
+
+	return META_SHARED;
+init_meta:
+	/*
+	 * Update allocations counter and set it to per-NUMA queues
+	 * to prevent upcomming contenders from parking on deallocated queues
+	 */
+	seq_counter = atomic_inc_return_relaxed(&meta_pool[lock_id].seq_counter);
+
+	/* Very unlikely we can overflow */
+	if (unlikely(seq_counter == 0))
+		seq_counter = atomic_inc_return_relaxed(&meta_pool[lock_id].seq_counter);
+
+	for_each_online_node(nid) {
+		struct numa_queue *queue = &queue_table[nid][lock_id];
+		WRITE_ONCE(queue->seq_counter, (u32)seq_counter);
+	}
+
+	*seq = seq_counter;
+#ifdef CONFIG_HQSPINLOCKS_DEBUG
+	int current_used = atomic_inc_return_relaxed(&cur_buckets_in_use);
+
+	if (READ_ONCE(max_buckets_in_use) < current_used)
+		WRITE_ONCE(max_buckets_in_use, current_used);
+#endif
+	return META_GRABBED;
+}
+
+/*
+ * Try to setup current lock mode:
+ *
+ * LOCK_MODE_HQLOCK or fallback to default LOCK_MODE_QSPINLOCK
+ * if there's hash conflict with another lock in the system.
+ *
+ * In general the setup consists of grabbing lock-related metadata and
+ * publishing the mode in the global lock variable.
+ *
+ * For quick meta-lookup the pointer hashing is used.
+ *
+ * To identify "occupied/free" metadata record, we use "meta->lock_ptr"
+ * which is set to corresponding spinlock lock pointer or "NULL".
+ *
+ * The action sequence from initial state is the following:
+ *
+ * "Find lock-meta by hash" => "Occupy lock-meta" => publish "LOCK_MODE_HQLOCK" in
+ * global lock variable.
+ *
+ */
+static inline
+hqlock_mode_t setup_lock_mode(struct qspinlock *lock, u16 lock_id, u32 *meta_seq_counter)
+{
+	hqlock_mode_t mode;
+
+	do {
+		enum meta_status status;
+		int val = atomic_read(&lock->val);
+
+		if (is_mode_hqlock(val)) {
+			struct lock_metadata *lock_meta = get_meta(lock_id);
+			/*
+			 * The lock is currently in LOCK_MODE_HQLOCK, we need to make sure the
+			 * associated metadata isn't used by another lock.
+			 *
+			 * In the meanwhile several situations can occur:
+			 *
+			 * [Case 1] Another lock using the meta (hash-conflict)
+			 *
+			 * If "release + reallocate" of the meta happenned in the meanwhile,
+			 * we're guaranteed to observe lock-mode change in the "lock->val",
+			 * due to the following event ordering:
+			 *
+			 * [release_lock_meta]
+			 *	Clear lock mode in "lock->val", so we wouldn't
+			 *	observe LOCK_MODE_HQLOCK mode.
+			 *	=>
+			 *        [setup_lock_mode]
+			 *	    Update lock->seq_counter
+			 *
+			 * [Case 2] For exact same lock, some contender did "release + reallocate" of the meta
+			 *
+			 * Either We'll get newly set "seq_counter", or in the worst case, we'll get
+			 * outdated "seq_counter" fail in the CAS(queue) in the caller function.
+			 *
+			 * [Case 3] Meta is free, nobody using it
+			 * [Case 4] The lock mode is changed to LOCK_MODE_QSPINLOCK.
+			 */
+			int seq_counter = atomic_read(&lock_meta->seq_counter);
+
+			/*
+			 * "seq_counter" and "lock->val" should be read in program order.
+			 * Otherwise we might observe "seq_counter" updated on-behalf another lock.
+			 * Paired with smp_wmb() in set_lock_mode().
+			 */
+			smp_rmb();
+			val = atomic_read(&lock->val);
+
+			if (is_mode_hqlock(val)) {
+				*meta_seq_counter = (u32)seq_counter;
+				return LOCK_MODE_HQLOCK;
+			}
+			/*
+			 * [else] Here it can be 2 options:
+			 *
+			 * 1. Lock-meta is free, and nobody using it.
+			 *    In this case, we need to try occupying the meta and
+			 *    publish lock-mode LOCK_MODE_HQLOCK again.
+			 *
+			 * 2. Lock mode transitioned to LOCK_MODE_QSPINLOCK mode.
+			 */
+			continue;
+		} else if (is_mode_qspinlock(val)) {
+			return LOCK_MODE_QSPINLOCK;
+		}
+
+		/*
+		 * Trying to get temporary metadata "weak" ownership,
+		 * Three situations might happen:
+		 *
+		 * 1. Metadata isn't used by anyone
+		 *    Just take the ownership.
+		 *
+		 * 2. Metadata is already grabbed by one of the lock contenders.
+		 *
+		 * 3. Hash conflict: metadata is owned by another lock
+		 *    Give up, fallback to LOCK_MODE_QSPINLOCK.
+		 */
+		status = grab_lock_meta(lock, lock_id, meta_seq_counter);
+		if (status == META_SHARED) {
+			/*
+			 * Someone started publishing lock_id for us:
+			 * 1. We can catch the "LOCK_MODE_HQLOCK" mode quickly
+			 * 2. We can loop several times before we'll see "LOCK_MODE_HQLOCK" mode set.
+			 * (lightweight check)
+			 * 3. Another contender might be able to relase lock meta meanwhile.
+			 * Either we catch it in above "seq_counter" check, or we'll grab
+			 * lock meta first and try publishing lock_id.
+			 */
+			continue;
+		}
+
+		/* Setup the lock-mode */
+		if (status == META_GRABBED)
+			mode = set_mode_hqlock(lock, val, lock_id);
+		else if (status == META_CONFLICT)
+			mode = set_mode_qspinlock(lock, val);
+		else
+			BUG_ON(1);
+		/*
+		 * If we grabbed the meta but were unable to publish LOCK_MODE_HQLOCK
+		 * release it, just by resetting the pointer.
+		 */
+		if (status == META_GRABBED && mode != LOCK_MODE_HQLOCK) {
+			smp_store_release(&meta_pool[lock_id].lock_ptr, NULL);
+#ifdef CONFIG_HQSPINLOCKS_DEBUG
+			atomic_dec(&cur_buckets_in_use);
+#endif
+		}
+	} while (mode == LOCK_NO_MODE);
+
+	return mode;
+}
+
+static inline void release_lock_meta(struct qspinlock *lock,
+					struct lock_metadata *meta,
+				     struct numa_qnode *qnode)
+{
+	int nid;
+	bool cleared = false;
+	u32 upd_val = _Q_LOCKTYPE_HQ | _Q_LOCKED_VAL;
+	u16 lock_id = qnode->lock_id;
+	int seq_counter = atomic_read(&meta->seq_counter);
+
+	/*
+	 * Firstly, go across per-NUMA queues and set seq counter to 0,
+	 * it will prevent possible contenders, which haven't even queued locally,
+	 * from using already deoccupied metadata.
+	 *
+	 * We need to perform counter reset with CAS,
+	 * because local contenders (we didn't see them while try_clear_lock_tail and try_clear_queue_tail)
+	 * may have appeared while we were coming that point.
+	 *
+	 * If any CAS is not successful, it means someone has already queued locally,
+	 * in that case we should restore usability of all local queues
+	 * and return seq counter to every per-NUMA queue.
+	 *
+	 * If all CASes are successful, nobody will queue on this metadata's queues,
+	 * and we can free it and allow other locks to use it.
+	 */
+
+	/*
+	 * Before metadata release read every queue tail,
+	 * if we have at least one contender, don't do CASes and leave
+	 * (Reads are much faster and also prefetch local queue's cachelines)
+	 */
+	for_each_online_node(nid) {
+		struct numa_queue *queue = get_queue(lock_id, nid + 1);
+
+		if (READ_ONCE(queue->tail) != 0)
+			return;
+	}
+
+	for_each_online_node(nid) {
+		struct numa_queue *queue = get_queue(lock_id, nid + 1);
+
+		if (cmpxchg_relaxed(&queue->seq_counter_tail, encode_tc(0, seq_counter), 0)
+			!= encode_tc(0, seq_counter))
+			/* Some contender arrived - rollback */
+			goto do_rollback;
+	}
+
+#ifdef CONFIG_HQSPINLOCKS_DEBUG
+	atomic_dec(&cur_buckets_in_use);
+#endif
+	/*
+	 * We need wait until pending is gone.
+	 * Otherwise, clearing pending can erase a mode we will set here
+	 */
+	while (!cleared) {
+		u32 old_lock_val = atomic_cond_read_relaxed(&lock->val, !(VAL & _Q_PENDING_VAL));
+
+		cleared = atomic_try_cmpxchg_relaxed(&lock->val,
+				&old_lock_val, upd_val | (old_lock_val & _Q_TAIL_MASK));
+	}
+
+	/*
+	 * guarantee current seq counter is erased from every local queue
+	 * and lock mode has been updated before another lock can use metadata
+	 */
+	smp_store_release(&meta_pool[qnode->lock_id].lock_ptr, NULL);
+	return;
+
+do_rollback:
+	for_each_online_node(nid) {
+		struct numa_queue *queue = get_queue(lock_id, nid + 1);
+		WRITE_ONCE(queue->seq_counter, seq_counter);
+	}
+}
+
+/*
+ * Call it if we observe LOCK_MODE_QSPINLOCK.
+ *
+ * We can do generic xchg_tail in this case,
+ * if lock's mode has already been changed, we will get _Q_LOCK_INVALID_TAIL.
+ *
+ * If we have such a situation, we perform CAS cycle
+ * to restore _Q_LOCK_INVALID_TAIL or wait until lock's mode is LOCK_MODE_QSPINLOCK.
+ *
+ * All upcomming confused contenders will see valid tail.
+ * We will remember the last one before successful CAS and put its tail in local queue.
+ * During handoff we will notify them about mode change via qnext->wrong_fallback_tail
+ */
+static inline bool try_update_tail_qspinlock_mode(struct qspinlock *lock, u32 tail, u32 *old_tail, u32 *next_tail)
+{
+	/*
+	 * next_tail may be tail or last cpu from previous unsuccessful call
+	 * (highly unlikely, but still)
+	 */
+	u32 xchged_tail = xchg_tail(lock, *next_tail);
+
+	if (likely(xchged_tail != _Q_LOCK_INVALID_TAIL)) {
+		*old_tail = xchged_tail;
+		return true;
+	}
+
+	/*
+	 * If we got _Q_LOCK_INVALID_TAIL, it means lock was not in LOCK_MODE_QSPINLOCK.
+	 * In this case we should restore _Q_LOCK_INVALID_TAIL
+	 * and remember next contenders that got confused.
+	 * Later we will update lock's or local queue's tail to the last contender seen here.
+	 */
+	u32 val = atomic_read(&lock->val);
+
+	bool fixed = false;
+
+	while (!fixed) {
+		if (decode_lock_mode(val) == LOCK_MODE_QSPINLOCK) {
+			*old_tail = 0;
+			return true;
+		}
+
+		/*
+		 * CAS is needed here to catch possible lock mode change
+		 * from LOCK_MODE_HQLOCK to LOCK_MODE_QSPINLOCK in the meanwhile.
+		 * Thus preventing from publishing _Q_LOCK_INVALID_TAIL
+		 * when LOCK_MODE_QSPINLOCK is enabled.
+		 */
+		fixed = atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCK_INVALID_TAIL |
+				(val & (_Q_LOCKED_PENDING_MASK | _Q_LOCK_TYPE_MODE_MASK)));
+	}
+
+	if ((val & _Q_TAIL_MASK) != tail)
+		*next_tail = val & _Q_TAIL_MASK;
+
+	return false;
+}
+
+/*
+ * Call it if we observe LOCK_MODE_HQLOCK or LOCK_NO_MODE in the lock.
+ *
+ * Actions performed:
+ * - Call setup_lock_mode to set or read lock's mode,
+ *   read metadata's sequential counter for valid local queueing
+ * - CAS on union of local tail and meta_seq_counter
+ *   to guarantee metadata usage correctness.
+ *   Repeat from the beginning if fail.
+ * - If we are the first local contender,
+ *   update global tail with our NUMA node
+ */
+static inline bool try_update_tail_hqlock_mode(struct qspinlock *lock, u16 lock_id,
+				struct numa_qnode *qnode, u32 tail, u32 *next_tail, u32 *old_tail)
+{
+	u32 meta_seq_counter;
+	hqlock_mode_t mode;
+
+	struct numa_queue *queue;
+	u64 old_counter_tail;
+	bool updated_queue_tail = false;
+
+re_setup:
+	mode = setup_lock_mode(lock, lock_id, &meta_seq_counter);
+
+	if (mode == LOCK_MODE_QSPINLOCK)
+		return false;
+
+	queue = get_local_queue(qnode);
+
+	/*
+	 * While queueing locally, perform CAS cycle
+	 * on union of tail and meta_seq_counter.
+	 *
+	 * meta_seq_counter is taken from the lock metadata while allocation,
+	 * it's updated every time it's used by a next lock.
+	 * It shows that queue is used correctly
+	 * and metadata hasn't been deoccupied before we queued locally.
+	 */
+	old_counter_tail = READ_ONCE(queue->seq_counter_tail);
+
+	while (!updated_queue_tail &&
+		   decode_tc_counter(old_counter_tail) == meta_seq_counter) {
+		updated_queue_tail =
+			try_cmpxchg_relaxed(&queue->seq_counter_tail, &old_counter_tail,
+				encode_tc((*next_tail) >> _Q_TAIL_OFFSET, meta_seq_counter));
+	}
+
+	/* queue->seq_counter changed */
+	if (!updated_queue_tail)
+		goto re_setup;
+
+	/*
+	 * The condition means we tried to perform generic tail update in try_update_tail_qspinlock_mode,
+	 * but before we did it, lock type was changed.
+	 * Moreover, some contenders have come after us in LOCK_MODE_QSPINLOCK,
+	 * during handoff we must notify them that they are set in LOCK_MODE_HQLOCK in our node's local queue
+	 */
+	if (unlikely(*next_tail != tail))
+		qnode->wrong_fallback_tail = *next_tail >> _Q_TAIL_OFFSET;
+
+	*old_tail = decode_tc_tail(old_counter_tail);
+
+	if (!(*old_tail)) {
+		u16 prev_node_id;
+
+		init_queue(qnode);
+		prev_node_id = append_node_queue(lock_id, qnode->numa_node);
+		*old_tail = prev_node_id ? Q_NEW_NODE_QUEUE : 0;
+	} else {
+		*old_tail <<= _Q_TAIL_OFFSET;
+	}
+
+	return true;
+}
diff --git a/kernel/locking/hqlock_types.h b/kernel/locking/hqlock_types.h
new file mode 100644
index 000000000..2a30c87ee
--- /dev/null
+++ b/kernel/locking/hqlock_types.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _GEN_HQ_SPINLOCK_SLOWPATH
+#error "Do not include this file!"
+#endif
+
+#define IRQ_NODE (MAX_NUMNODES + 1)
+#define Q_NEW_NODE_QUEUE 1
+#define LOCK_ID_BITS		(12)
+
+#define LOCK_ID_MAX			(1 << LOCK_ID_BITS)
+#define LOCK_ID_NONE		(LOCK_ID_MAX + 1)
+
+#define _QUEUE_TAIL_MASK (((1ULL << 32) - 1) << 0)
+#define _QUEUE_SEQ_COUNTER_MASK (((1ULL << 32) - 1) << 32)
+
+/*
+ * Output code for handoff-logic:
+ *
+ * ==  0 (HQLOCK_HANDOFF_LOCAL) - has local nodes to handoff
+ *  >  0 - has remote node to handoff, id is visible
+ * == -1 (HQLOCK_HANDOFF_REMOTE_HEAD) - has remote node to handoff,
+ *         id isn't visible yet, will be in the *lock->head_node*
+ */
+enum {
+	HQLOCK_HANDOFF_LOCAL = 0,
+	HQLOCK_HANDOFF_REMOTE_HEAD = -1
+};
+
+typedef enum {
+	LOCK_NO_MODE = 0,
+	LOCK_MODE_QSPINLOCK = 1,
+	LOCK_MODE_HQLOCK = 2,
+} hqlock_mode_t;
+
+struct numa_qnode {
+	struct mcs_spinlock mcs;
+
+	u16 lock_id;
+	u16 wrong_fallback_tail;
+	u16 general_handoffs;
+
+	u16 numa_node;
+};
+
+struct numa_queue {
+	struct numa_qnode *head;
+	union {
+		u64 seq_counter_tail;
+		struct {
+			u32 tail;
+			u32 seq_counter;
+		};
+	};
+
+	u16 next_node;
+	u16 prev_node;
+
+	u16 handoffs_not_head;
+} ____cacheline_aligned;
+
+/**
+ * Lock metadata
+ * "allocated"/"freed" on demand.
+ *
+ * Used to dynamically bind numa_queue to a lock,
+ * maintain FIFO-order for the NUMA-queues.
+ *
+ * seq_counter is needed to distinguish metadata usage
+ * by different locks, preventing local contenders
+ * from queueing in the wrong per-NUMA queue
+ *
+ * @see set_bucket
+ * @see numa_xchg_tail
+ */
+struct lock_metadata {
+	atomic_t seq_counter;
+	struct qspinlock *lock_ptr;
+
+	/* NUMA-queues of contenders ae kept in FIFO order */
+	union {
+		u32 nodes_tail;
+		struct {
+			u16 tail_node;
+			u16 head_node;
+		};
+	};
+};
+
+static inline int decode_lock_mode(u32 lock_val)
+{
+	return (lock_val & _Q_LOCK_MODE_MASK) >> _Q_LOCK_MODE_OFFSET;
+}
+
+static inline u32 encode_lock_mode(u16 lock_id)
+{
+	if (lock_id == LOCK_ID_NONE)
+		return LOCK_MODE_QSPINLOCK << _Q_LOCK_MODE_OFFSET;
+
+	return LOCK_MODE_HQLOCK << _Q_LOCK_MODE_OFFSET;
+}
+
+static inline u64 encode_tc(u32 tail, u32 counter)
+{
+	u64 __tail = (u64)tail;
+	u64 __counter = (u64)counter;
+
+	return __tail | (__counter << 32);
+}
+
+static inline u32 decode_tc_tail(u64 tail_counter)
+{
+	return (u32)(tail_counter & _QUEUE_TAIL_MASK);
+}
+
+static inline u32 decode_tc_counter(u64 tail_counter)
+{
+	return (u32)((tail_counter & _QUEUE_SEQ_COUNTER_MASK) >> 32);
+}
-- 
2.34.1


