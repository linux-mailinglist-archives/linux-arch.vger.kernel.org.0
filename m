Return-Path: <linux-arch+bounces-8073-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8099C7EF
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 13:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11E0285CBE
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C417158DD0;
	Mon, 14 Oct 2024 11:00:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ED81A7275;
	Mon, 14 Oct 2024 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903604; cv=none; b=s16ad1Qvvx8CsevmVgqL6MkP1nu73ONfIP9TVnwBCWgRBIcMp9EeAf153gzPbiXxyk68tZgWLFSzf4QeZ3gvBvloQDKWt5tWz3F39nSJtu2lrLbX/vk0YSqH6lPiSHYLPYmZfFxl1oL1dqt13lLHp2HknzR8J0Oc+wLqxZEdcPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903604; c=relaxed/simple;
	bh=13J+whb0NBLwZYomxo/ndswlS3IHulBHddSnzPqbaOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIXYTGiLZnG50OszUaj0WmwsvoNfLLIK5DCWmOxxSpW9bezUzuhEfcRpLltSXLk5gdDH5Fg8AX3TzxhWABooOT5YaTvG4JHSdi3V28YQtrOZuFGovDr7DN7bB3pNSdVsapSK8Lp7zud2oowN+Mp0vs35d1rh65QUjT5WdQWRDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3B391424;
	Mon, 14 Oct 2024 04:00:31 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E14783F51B;
	Mon, 14 Oct 2024 03:59:58 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ingo Molnar <mingo@redhat.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	kasan-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 11/57] fork: Permit boot-time THREAD_SIZE determination
Date: Mon, 14 Oct 2024 11:58:18 +0100
Message-ID: <20241014105912.3207374-11-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

THREAD_SIZE defines the size of a kernel thread stack. To date, it has
been set at compile-time. However, when using vmap stacks, the size must
be a multiple of PAGE_SIZE, and given we are in the process of
supporting boot-time page size, we must also do the same for
THREAD_SIZE.

The alternative would be to define THREAD_SIZE for the largest supported
page size, but this would waste memory when using a smaller page size.
For example, arm64 requires THREAD_SIZE to be 16K, but when using 64K
pages and a vmap stack, we must increase the size to 64K. If we required
64K when 4K or 16K page size was in use, we would waste 48K per kernel
thread.

So let's refactor to allow THREAD_SIZE to not be a compile-time
constant. THREAD_SIZE_MAX (and THREAD_ALIGN_MAX) are introduced to
manage the limits, as is done for PAGE_SIZE.

When THREAD_SIZE is a compile-time constant, behaviour and code size
should be equivalent.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 include/asm-generic/vmlinux.lds.h |  6 ++-
 include/linux/sched.h             |  4 +-
 include/linux/thread_info.h       | 10 ++++-
 init/main.c                       |  2 +-
 kernel/fork.c                     | 67 +++++++++++--------------------
 mm/kasan/report.c                 |  3 +-
 6 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5727f883001bb..f19bab7a2e8f9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -56,6 +56,10 @@
 #define LOAD_OFFSET 0
 #endif
 
+#ifndef THREAD_SIZE_MAX
+#define THREAD_SIZE_MAX		THREAD_SIZE
+#endif
+
 /*
  * Only some architectures want to have the .notes segment visible in
  * a separate PT_NOTE ELF Program Header. When this happens, it needs
@@ -398,7 +402,7 @@
 	init_stack = .;							\
 	KEEP(*(.data..init_task))					\
 	KEEP(*(.data..init_thread_info))				\
-	. = __start_init_stack + THREAD_SIZE;				\
+	. = __start_init_stack + THREAD_SIZE_MAX;			\
 	__end_init_stack = .;
 
 #define JUMP_TABLE_DATA							\
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d150343d42d..3de4f655ee492 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1863,14 +1863,14 @@ union thread_union {
 #ifndef CONFIG_THREAD_INFO_IN_TASK
 	struct thread_info thread_info;
 #endif
-	unsigned long stack[THREAD_SIZE/sizeof(long)];
+	unsigned long stack[THREAD_SIZE_MAX/sizeof(long)];
 };
 
 #ifndef CONFIG_THREAD_INFO_IN_TASK
 extern struct thread_info init_thread_info;
 #endif
 
-extern unsigned long init_stack[THREAD_SIZE / sizeof(unsigned long)];
+extern unsigned long init_stack[THREAD_SIZE_MAX / sizeof(unsigned long)];
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 # define task_thread_info(task)	(&(task)->thread_info)
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 9ea0b28068f49..a7ccc448cd298 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -74,7 +74,15 @@ static inline long set_restart_fn(struct restart_block *restart,
 }
 
 #ifndef THREAD_ALIGN
-#define THREAD_ALIGN	THREAD_SIZE
+#define THREAD_ALIGN		THREAD_SIZE
+#endif
+
+#ifndef THREAD_SIZE_MAX
+#define THREAD_SIZE_MAX		THREAD_SIZE
+#endif
+
+#ifndef THREAD_ALIGN_MAX
+#define THREAD_ALIGN_MAX	max(THREAD_ALIGN, THREAD_SIZE_MAX)
 #endif
 
 #define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_ZERO)
diff --git a/init/main.c b/init/main.c
index ba1515eb20b9d..4dc28115fdf57 100644
--- a/init/main.c
+++ b/init/main.c
@@ -797,7 +797,7 @@ void __init __weak smp_prepare_boot_cpu(void)
 {
 }
 
-# if THREAD_SIZE >= PAGE_SIZE
+#ifdef CONFIG_VMAP_STACK
 void __init __weak thread_stack_cache_init(void)
 {
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index ea472566d4fcc..cbc3e73f9b501 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -184,13 +184,7 @@ static inline void free_task_struct(struct task_struct *tsk)
 	kmem_cache_free(task_struct_cachep, tsk);
 }
 
-/*
- * Allocate pages if THREAD_SIZE is >= PAGE_SIZE, otherwise use a
- * kmemcache based allocator.
- */
-# if THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK)
-
-#  ifdef CONFIG_VMAP_STACK
+#ifdef CONFIG_VMAP_STACK
 /*
  * vmalloc() is a bit slow, and calling vfree() enough times will force a TLB
  * flush.  Try to minimize the number of calls by caching stacks.
@@ -343,46 +337,21 @@ static void free_thread_stack(struct task_struct *tsk)
 	tsk->stack_vm_area = NULL;
 }
 
-#  else /* !CONFIG_VMAP_STACK */
+#else /* !CONFIG_VMAP_STACK */
 
-static void thread_stack_free_rcu(struct rcu_head *rh)
-{
-	__free_pages(virt_to_page(rh), THREAD_SIZE_ORDER);
-}
-
-static void thread_stack_delayed_free(struct task_struct *tsk)
-{
-	struct rcu_head *rh = tsk->stack;
-
-	call_rcu(rh, thread_stack_free_rcu);
-}
-
-static int alloc_thread_stack_node(struct task_struct *tsk, int node)
-{
-	struct page *page = alloc_pages_node(node, THREADINFO_GFP,
-					     THREAD_SIZE_ORDER);
-
-	if (likely(page)) {
-		tsk->stack = kasan_reset_tag(page_address(page));
-		return 0;
-	}
-	return -ENOMEM;
-}
-
-static void free_thread_stack(struct task_struct *tsk)
-{
-	thread_stack_delayed_free(tsk);
-	tsk->stack = NULL;
-}
-
-#  endif /* CONFIG_VMAP_STACK */
-# else /* !(THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK)) */
+/*
+ * Allocate pages if THREAD_SIZE is >= PAGE_SIZE, otherwise use a
+ * kmemcache based allocator.
+ */
 
 static struct kmem_cache *thread_stack_cache;
 
 static void thread_stack_free_rcu(struct rcu_head *rh)
 {
-	kmem_cache_free(thread_stack_cache, rh);
+	if (THREAD_SIZE >= PAGE_SIZE)
+		__free_pages(virt_to_page(rh), THREAD_SIZE_ORDER);
+	else
+		kmem_cache_free(thread_stack_cache, rh);
 }
 
 static void thread_stack_delayed_free(struct task_struct *tsk)
@@ -395,7 +364,16 @@ static void thread_stack_delayed_free(struct task_struct *tsk)
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	unsigned long *stack;
-	stack = kmem_cache_alloc_node(thread_stack_cache, THREADINFO_GFP, node);
+	struct page *page;
+
+	if (THREAD_SIZE >= PAGE_SIZE) {
+		page = alloc_pages_node(node, THREADINFO_GFP, THREAD_SIZE_ORDER);
+		stack = likely(page) ? page_address(page) : NULL;
+	} else {
+		stack = kmem_cache_alloc_node(thread_stack_cache,
+					      THREADINFO_GFP, node);
+	}
+
 	stack = kasan_reset_tag(stack);
 	tsk->stack = stack;
 	return stack ? 0 : -ENOMEM;
@@ -409,13 +387,16 @@ static void free_thread_stack(struct task_struct *tsk)
 
 void thread_stack_cache_init(void)
 {
+	if (THREAD_SIZE >= PAGE_SIZE)
+		return;
+
 	thread_stack_cache = kmem_cache_create_usercopy("thread_stack",
 					THREAD_SIZE, THREAD_SIZE, 0, 0,
 					THREAD_SIZE, NULL);
 	BUG_ON(thread_stack_cache == NULL);
 }
 
-# endif /* THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
+#endif /* CONFIG_VMAP_STACK */
 
 /* SLAB cache for signal_struct structures (tsk->signal) */
 static struct kmem_cache *signal_cachep;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index b48c768acc84d..57c877852dbc6 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -365,8 +365,7 @@ static inline bool kernel_or_module_addr(const void *addr)
 static inline bool init_task_stack_addr(const void *addr)
 {
 	return addr >= (void *)&init_thread_union.stack &&
-		(addr <= (void *)&init_thread_union.stack +
-			sizeof(init_thread_union.stack));
+		(addr <= (void *)&init_thread_union.stack + THREAD_SIZE);
 }
 
 static void print_address_description(void *addr, u8 tag,
-- 
2.43.0


