Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30B57AA2CD
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 23:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjIUVea (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 17:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjIUVeC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 17:34:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB14585E7;
        Thu, 21 Sep 2023 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Q23LA4fNtxuPKBmxlCap1S+ePSWCcBWqnwP5S12UL2A=; b=fC10oRh8rfYFZppt9c16iBpKl6
        tkQE8L0dalhfkmy47nxsgnYzuJc2FTXNyLp6Rd0ZVmI/KuXMWQpYLjRD+U+fbnmEeJ9gaFyMm1bnb
        aT0bT1FWUhEoTBablLBTbDrqaF7h+KpyUsKbRO9bRqOlj/qsOceCkEiLP7zh0EbXUzHT4FQy45hya
        fmEHq61ylgZ0WVZqE3slZONq67sTfxiJPZsPO+eqcx/GQXgQn37LOKWcwtWwjtqB7ENRwaZMaLKGM
        IYs4YpR7md3q/nWDWIwlAUgK/TXufUhO82cfMxRUll9dQ0evfrrvgxDvbYnkIPPZ657PVpOhfuk4O
        Soz1laqg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjHQN-00FJvx-1Y;
        Thu, 21 Sep 2023 11:00:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 1BDC230067B; Thu, 21 Sep 2023 13:00:43 +0200 (CEST)
Message-Id: <20230921105248.852663217@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Thu, 21 Sep 2023 12:45:17 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v3 12/15] futex: Implement FUTEX2_NUMA
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-futex2-numa.patch
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Extend the futex2 interface to be numa aware.

When FUTEX2_NUMA is specified for a futex, the user value is extended
to two words (of the same size). The first is the user value we all
know, the second one will be the node to place this futex on.

  struct futex_numa_32 {
	u32 val;
	u32 node;
  };

When node is set to ~0, WAIT will set it to the current node_id such
that WAKE knows where to find it. If userspace corrupts the node value
between WAIT and WAKE, the futex will not be found and no wakeup will
happen.

When FUTEX2_NUMA is not set, the node is simply an extention of the
hash, such that traditional futexes are still interleaved over the
nodes.

This is done to avoid having to have a separate !numa hash-table.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/futex.h   |    3 +
 kernel/futex/core.c     |  129 +++++++++++++++++++++++++++++++++++++++---------
 kernel/futex/futex.h    |   25 +++++++--
 kernel/futex/syscalls.c |    2 
 4 files changed, 128 insertions(+), 31 deletions(-)

Index: linux-2.6/include/linux/futex.h
===================================================================
--- linux-2.6.orig/include/linux/futex.h
+++ linux-2.6/include/linux/futex.h
@@ -34,6 +34,7 @@ union futex_key {
 		u64 i_seq;
 		unsigned long pgoff;
 		unsigned int offset;
+		/* unsigned int node; */
 	} shared;
 	struct {
 		union {
@@ -42,11 +43,13 @@ union futex_key {
 		};
 		unsigned long address;
 		unsigned int offset;
+		/* unsigned int node; */
 	} private;
 	struct {
 		u64 ptr;
 		unsigned long word;
 		unsigned int offset;
+		unsigned int node;	/* NOT hashed! */
 	} both;
 };
 
Index: linux-2.6/kernel/futex/core.c
===================================================================
--- linux-2.6.orig/kernel/futex/core.c
+++ linux-2.6/kernel/futex/core.c
@@ -34,7 +34,8 @@
 #include <linux/compat.h>
 #include <linux/jhash.h>
 #include <linux/pagemap.h>
-#include <linux/memblock.h>
+#include <linux/gfp.h>
+#include <linux/vmalloc.h>
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
 
@@ -47,12 +48,14 @@
  * reside in the same cacheline.
  */
 static struct {
-	struct futex_hash_bucket *queues;
 	unsigned long            hashsize;
+	unsigned int		 hashshift;
+	struct futex_hash_bucket *queues[MAX_NUMNODES];
 } __futex_data __read_mostly __aligned(2*sizeof(long));
-#define futex_queues   (__futex_data.queues)
-#define futex_hashsize (__futex_data.hashsize)
 
+#define futex_hashsize	(__futex_data.hashsize)
+#define futex_hashshift	(__futex_data.hashshift)
+#define futex_queues	(__futex_data.queues)
 
 /*
  * Fault injections for futexes.
@@ -105,6 +108,26 @@ late_initcall(fail_futex_debugfs);
 
 #endif /* CONFIG_FAIL_FUTEX */
 
+static int futex_get_value(u32 *val, u32 __user *from, unsigned int flags)
+{
+	switch (futex_size(flags)) {
+	case 1: return __get_user(*val, (u8 __user *)from);
+	case 2: return __get_user(*val, (u16 __user *)from);
+	case 4: return __get_user(*val, (u32 __user *)from);
+	default: BUG();
+	}
+}
+
+static int futex_put_value(u32 val, u32 __user *to, unsigned int flags)
+{
+	switch (futex_size(flags)) {
+	case 1: return __put_user(val, (u8 __user *)to);
+	case 2: return __put_user(val, (u16 __user *)to);
+	case 4: return __put_user(val, (u32 __user *)to);
+	default: BUG();
+	}
+}
+
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -114,10 +137,29 @@ late_initcall(fail_futex_debugfs);
  */
 struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
-	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
+	u32 hash = jhash2((u32 *)key,
+			  offsetof(typeof(*key), both.offset) / sizeof(u32),
 			  key->both.offset);
+	int node = key->both.node;
+
+	if (node == FUTEX_NO_NODE) {
+		/*
+		 * In case of !FLAGS_NUMA, use some unused hash bits to pick a
+		 * node -- this ensures regular futexes are interleaved across
+		 * the nodes and avoids having to allocate multiple
+		 * hash-tables.
+		 *
+		 * NOTE: this isn't perfectly uniform, but it is fast and
+		 * handles sparse node masks.
+		 */
+		node = (hash >> futex_hashshift) % nr_node_ids;
+		if (!node_possible(node)) {
+			node = find_next_bit_wrap(node_possible_map.bits,
+						  nr_node_ids, node);
+		}
+	}
 
-	return &futex_queues[hash & (futex_hashsize - 1)];
+	return &futex_queues[node][hash & (futex_hashsize - 1)];
 }
 
 
@@ -217,7 +259,7 @@ static u64 get_inode_sequence_number(str
  *
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
-int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
+int get_futex_key(void __user *uaddr, unsigned int flags, union futex_key *key,
 		  enum futex_access rw)
 {
 	unsigned long address = (unsigned long)uaddr;
@@ -225,25 +267,49 @@ int get_futex_key(u32 __user *uaddr, uns
 	struct page *page;
 	struct folio *folio;
 	struct address_space *mapping;
-	int err, ro = 0;
+	int node, err, size, ro = 0;
 	bool fshared;
 
 	fshared = flags & FLAGS_SHARED;
+	size = futex_size(flags);
+	if (flags & FLAGS_NUMA)
+		size *= 2;
 
 	/*
 	 * The futex address must be "naturally" aligned.
 	 */
 	key->both.offset = address % PAGE_SIZE;
-	if (unlikely((address % sizeof(u32)) != 0))
+	if (unlikely((address % size) != 0))
 		return -EINVAL;
 	address -= key->both.offset;
 
-	if (unlikely(!access_ok(uaddr, sizeof(u32))))
+	if (unlikely(!access_ok(uaddr, size)))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(fshared)))
 		return -EFAULT;
 
+	if (flags & FLAGS_NUMA) {
+		void __user *naddr = uaddr + size / 2;
+
+		if (futex_get_value(&node, naddr, flags))
+			return -EFAULT;
+
+		if (node == FUTEX_NO_NODE) {
+			node = numa_node_id();
+			if (futex_put_value(node, naddr, flags))
+				return -EFAULT;
+
+		} else if (node >= MAX_NUMNODES || !node_possible(node)) {
+			return -EINVAL;
+		}
+
+		key->both.node = node;
+
+	} else {
+		key->both.node = FUTEX_NO_NODE;
+	}
+
 	/*
 	 * PROCESS_PRIVATE futexes are fast.
 	 * As the mm cannot disappear under us and the 'key' only needs
@@ -1124,26 +1190,42 @@ void futex_exit_release(struct task_stru
 
 static int __init futex_init(void)
 {
-	unsigned int futex_shift;
-	unsigned long i;
+	unsigned int order, n;
+	unsigned long size, i;
 
 #if CONFIG_BASE_SMALL
 	futex_hashsize = 16;
 #else
-	futex_hashsize = roundup_pow_of_two(256 * num_possible_cpus());
+	futex_hashsize = 256 * num_possible_cpus();
+	futex_hashsize /= num_possible_nodes();
+	futex_hashsize = roundup_pow_of_two(futex_hashsize);
 #endif
+	futex_hashshift = ilog2(futex_hashsize);
+	size = sizeof(struct futex_hash_bucket) * futex_hashsize;
+	order = get_order(size);
+
+	for_each_node(n) {
+		struct futex_hash_bucket *table;
+
+		if (order > MAX_ORDER)
+			table = vmalloc_huge_node(size, GFP_KERNEL, n);
+		else
+			table = alloc_pages_exact_nid(n, size, GFP_KERNEL);
+
+		BUG_ON(!table);
+
+		for (i = 0; i < futex_hashsize; i++) {
+			atomic_set(&table[i].waiters, 0);
+			spin_lock_init(&table[i].lock);
+			plist_head_init(&table[i].chain);
+		}
 
-	futex_queues = alloc_large_system_hash("futex", sizeof(*futex_queues),
-					       futex_hashsize, 0, 0,
-					       &futex_shift, NULL,
-					       futex_hashsize, futex_hashsize);
-	futex_hashsize = 1UL << futex_shift;
-
-	for (i = 0; i < futex_hashsize; i++) {
-		atomic_set(&futex_queues[i].waiters, 0);
-		plist_head_init(&futex_queues[i].chain);
-		spin_lock_init(&futex_queues[i].lock);
+		futex_queues[n] = table;
 	}
+	pr_info("futex hash table, %d nodes, %ld entries (order: %d, %lu bytes)\n",
+		num_possible_nodes(),
+		futex_hashsize, order,
+		sizeof(struct futex_hash_bucket) * futex_hashsize);
 
 	return 0;
 }
Index: linux-2.6/kernel/futex/futex.h
===================================================================
--- linux-2.6.orig/kernel/futex/futex.h
+++ linux-2.6/kernel/futex/futex.h
@@ -83,6 +83,19 @@ static inline bool futex_flags_valid(uns
 	if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
 		return false;
 
+	/*
+	 * Must be able to represent both FUTEX_NO_NODE and every valid nodeid
+	 * in a futex word.
+	 */
+	if (flags & FLAGS_NUMA) {
+		int bits = 8 * futex_size(flags);
+		u64 max = ~0ULL;
+
+		max >>= 64 - bits;
+		if (nr_node_ids >= max)
+			return false;
+	}
+
 	return true;
 }
 
@@ -184,7 +197,7 @@ enum futex_access {
 	FUTEX_WRITE
 };
 
-extern int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
+extern int get_futex_key(void __user *uaddr, unsigned int flags, union futex_key *key,
 			 enum futex_access rw);
 
 extern struct hrtimer_sleeper *
Index: linux-2.6/kernel/futex/syscalls.c
===================================================================
--- linux-2.6.orig/kernel/futex/syscalls.c
+++ linux-2.6/kernel/futex/syscalls.c
@@ -179,7 +179,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
-#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE)
+#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_NUMA | FUTEX2_PRIVATE)
 
 /**
  * futex_parse_waitv - Parse a waitv array from userspace
Index: linux-2.6/include/uapi/linux/futex.h
===================================================================
--- linux-2.6.orig/include/uapi/linux/futex.h
+++ linux-2.6/include/uapi/linux/futex.h
@@ -74,6 +74,14 @@
 /* do not use */
 #define FUTEX_32		FUTEX2_SIZE_U32 /* historical accident :-( */
 
+
+/*
+ * When FUTEX2_NUMA doubles the futex word, the second word is a node value.
+ * The special value -1 indicates no-node. This is the same value as
+ * NUMA_NO_NODE, except that value is not ABI, this is.
+ */
+#define FUTEX_NO_NODE		(-1)
+
 /*
  * Max numbers of elements in a futex_waitv array
  */


