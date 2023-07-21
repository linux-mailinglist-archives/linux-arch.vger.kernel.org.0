Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C17D75C52F
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 13:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGULAC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 07:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGUK7d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 06:59:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2A4272C;
        Fri, 21 Jul 2023 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=InZAoNtajhobmNQr05yuJ5qrK1sLTRyFZ+Ldl4K0hzA=; b=o8AkDmj7r0mUmpFMO60PLZYV4r
        HtXarlzhK6C/dHCGMo9Qnq0pyb5vTNo2RlTgbPe4tloAZCGKM8R5aWOn+SNQTr5QnN8gv9DIygdzO
        mUY8lNkYNqRL7oUB02O8lReJ/iHKTsXqQ/mAGmOvp0pOzXV9fEefXjRCf6mB55ajfZfEAondNBqah
        ZbYzhHP+aCWnujIf+yKZBaoysIhQ4fZPnrhYcwxHOfHq3b87eSLeKKlW3hfY7OKW4eI+dDht8eHsv
        OCtV6uKqQhL3LqTorpnelT+Yr6XwyANEmxA+MRSN0p2qnbKJ7Z5PYyPCllJLGrjdhGMkrimVodxle
        T+kkUv1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMnqK-0012Og-OI; Fri, 21 Jul 2023 10:58:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3679F301C41;
        Fri, 21 Jul 2023 12:58:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 210923157E625; Fri, 21 Jul 2023 12:58:38 +0200 (CEST)
Message-ID: <20230721105744.434742902@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Jul 2023 12:22:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v1 11/14] futex: Implement FUTEX2_NUMA
References: <20230721102237.268073801@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/futex/core.c     |  128 +++++++++++++++++++++++++++++++++++++++---------
 kernel/futex/futex.h    |   26 +++++++--
 kernel/futex/syscalls.c |    2 
 4 files changed, 127 insertions(+), 32 deletions(-)

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
 
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
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
 
-	return &futex_queues[hash & (futex_hashsize - 1)];
+	if (node == -1) {
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
 
 
@@ -217,32 +259,55 @@ static u64 get_inode_sequence_number(str
  *
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
-int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
+int get_futex_key(void __user *uaddr, unsigned int flags, union futex_key *key,
 		  enum futex_access rw)
 {
 	unsigned long address = (unsigned long)uaddr;
 	struct mm_struct *mm = current->mm;
 	struct page *page, *tail;
 	struct address_space *mapping;
-	int err, ro = 0;
+	int node, err, size, ro = 0;
 	bool fshared;
 
 	fshared = flags & FLAGS_SHARED;
+	size = futex_size(flags);
 
 	/*
 	 * The futex address must be "naturally" aligned.
 	 */
 	key->both.offset = address % PAGE_SIZE;
-	if (unlikely((address % sizeof(u32)) != 0))
+	if (unlikely((address % size) != 0))
 		return -EINVAL;
 	address -= key->both.offset;
 
-	if (unlikely(!access_ok(uaddr, sizeof(u32))))
+	if (flags & FLAGS_NUMA)
+		size *= 2;
+
+	if (unlikely(!access_ok(uaddr, size)))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(fshared)))
 		return -EFAULT;
 
+	key->both.node = -1;
+	if (flags & FLAGS_NUMA) {
+		void __user *naddr = uaddr + size/2;
+
+		if (futex_get_value(&node, naddr, flags))
+			return -EFAULT;
+
+		if (node == -1) {
+			node = numa_node_id();
+			if (futex_put_value(node, naddr, flags))
+				return -EFAULT;
+		}
+
+		if (node >= MAX_NUMNODES || !node_possible(node))
+			return -EINVAL;
+
+		key->both.node = node;
+	}
+
 	/*
 	 * PROCESS_PRIVATE futexes are fast.
 	 * As the mm cannot disappear under us and the 'key' only needs
@@ -1125,27 +1190,42 @@ void futex_exit_release(struct task_stru
 
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
-					       futex_hashsize, 0,
-					       futex_hashsize < 256 ? HASH_SMALL : 0,
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
@@ -65,6 +65,12 @@ static inline unsigned int futex2_to_fla
 	return flags;
 }
 
+static inline unsigned int futex_size(unsigned int flags)
+{
+	unsigned int size = flags & FLAGS_SIZE_MASK;
+	return 1 << size; /* {0,1,2,3} -> {1,2,4,8} */
+}
+
 static inline bool futex_flags_valid(unsigned int flags)
 {
 	/* Only 64bit futexes for 64bit code */
@@ -77,13 +83,19 @@ static inline bool futex_flags_valid(uns
 	if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
 		return false;
 
-	return true;
-}
+	/*
+	 * Must be able to represent both NUMA_NO_NODE and every valid nodeid
+	 * in a futex word.
+	 */
+	if (flags & FLAGS_NUMA) {
+		int bits = 8 * futex_size(flags);
+		u64 max = ~0ULL;
+		max >>= 64 - bits;
+		if (nr_node_ids >= max)
+			return false;
+	}
 
-static inline unsigned int futex_size(unsigned int flags)
-{
-	unsigned int size = flags & FLAGS_SIZE_MASK;
-	return 1 << size; /* {0,1,2,3} -> {1,2,4,8} */
+	return true;
 }
 
 static inline bool futex_validate_input(unsigned int flags, u64 val)
@@ -182,7 +194,7 @@ enum futex_access {
 	FUTEX_WRITE
 };
 
-extern int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
+extern int get_futex_key(void __user *uaddr, unsigned int flags, union futex_key *key,
 			 enum futex_access rw);
 
 extern struct hrtimer_sleeper *
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -179,7 +179,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
-#define FUTEX2_MASK (FUTEX2_64 | FUTEX2_PRIVATE)
+#define FUTEX2_MASK (FUTEX2_64 | FUTEX2_NUMA | FUTEX2_PRIVATE)
 
 /**
  * futex_parse_waitv - Parse a waitv array from userspace


