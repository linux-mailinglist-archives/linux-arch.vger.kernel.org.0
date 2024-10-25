Return-Path: <linux-arch+bounces-8535-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19329AFE75
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 11:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B194F2839F6
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4751D5159;
	Fri, 25 Oct 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y2cyR1HP"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC9175A6;
	Fri, 25 Oct 2024 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849273; cv=none; b=CWAVcvW2SJ85Ej4m+86GgWn+Ro9uZlQctcp/2/pwXYe19qNBeK94rAINw3NVUZzJ75WFQ+3lZ04DTbPKNd+o3YS41Yw24CN1eiq7elM/EtJcf51TI/2UhI8ME07rnZxJd2IdPZZXN/wBxBs9GB+kZnUGrJgsZH9ezJut3xk/xco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849273; c=relaxed/simple;
	bh=KDCxAA2t4R126zWcHSt54xfK4tfXCDSdh3BN1NDkNf0=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZwpKNAknv3mNsMMGZLIv8ngzUwUyXX5hUcg9qrQmOEK85/t4DrLAeQrn0A1l0+0dExBq3ftLzzizYiQ+2O+PlukoTM22ZTyTqbKkolJTyF6P8cZO5UmGBjpcyF4kXPKOhwbonHpsgEnJ9yhiNeBMnjIpImVYhL5LJUz7N68iX/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y2cyR1HP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=RZyeqL/sDawSYArfjik+bzTHUaH0yRhT/D7WDZYPYBA=; b=Y2cyR1HPqEIEF7pPOyzphBJXKY
	5m6VIXPj2PJRcDkKRF8+NVUBugBJk6WNVYlLYSmQQ8F33FYEpW4Sqh1ioL5UUNbrSkDCQCbIt/mbU
	C/qEC6Q4O77K8rlLfhA2cwul6CNsYEDCKf+19iOiRxXrJKjsKXtCfJQ0V6j0mI8qWRPvGZrutb1gE
	zagsCUxVojU8zDApLn4H/SbdldGgPTcoKed5Jc0C4QZBFaI3hUx6A7I7jJKSX4MyKbb19A9SlktQ6
	RSeJ9D7aHgah0fGVuSgl3kyVxp1uzgnGQjtHjauc7Fqsg12U6Wwvi0k8UOmvnJUXnhpMSDBg3E45S
	vRnXCBzQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GoU-000000054PO-00xQ;
	Fri, 25 Oct 2024 09:40:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D1B7C300B40; Fri, 25 Oct 2024 11:40:57 +0200 (CEST)
Message-Id: <20241025093944.485691531@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 25 Oct 2024 11:03:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 dvhart@infradead.org,
 dave@stgolabs.net,
 andrealmeid@igalia.com,
 Andrew Morton <akpm@linux-foundation.org>,
 urezki@gmail.com,
 hch@infradead.org,
 lstoakes@gmail.com,
 Arnd Bergmann <arnd@arndb.de>,
 linux-api@vger.kernel.org,
 linux-mm@kvack.org,
 linux-arch@vger.kernel.org,
 malteskarupke@web.de,
 cl@linux.com,
 llong@redhat.com
Subject: [PATCH 2/6] futex: Implement FUTEX2_NUMA
References: <20241025090347.244183920@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
 include/linux/futex.h      |    3 +
 include/uapi/linux/futex.h |    8 ++
 kernel/futex/core.c        |  128 ++++++++++++++++++++++++++++++++++++---------
 kernel/futex/futex.h       |   17 +++++
 4 files changed, 131 insertions(+), 25 deletions(-)

--- a/include/linux/futex.h
+++ b/include/linux/futex.h
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
 
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
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
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -36,7 +36,8 @@
 #include <linux/pagemap.h>
 #include <linux/debugfs.h>
 #include <linux/plist.h>
-#include <linux/memblock.h>
+#include <linux/gfp.h>
+#include <linux/vmalloc.h>
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
 
@@ -49,12 +50,14 @@
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
@@ -107,6 +110,26 @@ late_initcall(fail_futex_debugfs);
 
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
@@ -116,10 +139,29 @@ late_initcall(fail_futex_debugfs);
  */
 struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
-	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
+	u32 hash = jhash2((u32 *)key,
+			  offsetof(typeof(*key), both.offset) / sizeof(u32),
 			  key->both.offset);
+	int node = key->both.node;
 
-	return &futex_queues[hash & (futex_hashsize - 1)];
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
+
+	return &futex_queues[node][hash & (futex_hashsize - 1)];
 }
 
 
@@ -219,7 +261,7 @@ static u64 get_inode_sequence_number(str
  *
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
-int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
+int get_futex_key(void __user *uaddr, unsigned int flags, union futex_key *key,
 		  enum futex_access rw)
 {
 	unsigned long address = (unsigned long)uaddr;
@@ -227,25 +269,49 @@ int get_futex_key(u32 __user *uaddr, uns
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
@@ -1148,26 +1214,42 @@ void futex_exit_release(struct task_stru
 
 static int __init futex_init(void)
 {
-	unsigned int futex_shift;
-	unsigned long i;
+	unsigned int order, n;
+	unsigned long size, i;
 
 #ifdef CONFIG_BASE_SMALL
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
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -52,7 +52,7 @@ static inline unsigned int futex_to_flag
 	return flags;
 }
 
-#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE)
+#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_NUMA | FUTEX2_PRIVATE)
 
 /* FUTEX2_ to FLAGS_ */
 static inline unsigned int futex2_to_flags(unsigned int flags2)
@@ -85,6 +85,19 @@ static inline bool futex_flags_valid(uns
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
 
@@ -193,7 +206,7 @@ enum futex_access {
 	FUTEX_WRITE
 };
 
-extern int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
+extern int get_futex_key(void __user *uaddr, unsigned int flags, union futex_key *key,
 			 enum futex_access rw);
 
 extern struct hrtimer_sleeper *



