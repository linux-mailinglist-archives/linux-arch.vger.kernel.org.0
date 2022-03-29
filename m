Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34414EAD60
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbiC2MoE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiC2MnX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:43:23 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D69227C51
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:25 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id ml20-20020a170906cc1400b006df8c9357efso8110903ejb.21
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=77upEedV9MVWrhKieM+rh+8U4NcJYbcZy6sBqJQFlQA=;
        b=bnq8hQDOyCgftdNzwXDG/d91U07TnwCybE7fbjRK9l+Km9ccpsbPgpL6A5FRXtFi3h
         DAZlXoCRZE9ATLpK4lsLef8LJ+7L0QtfFMGiySRhOosaJSPL9aQlMN6TUArQSAlU/IZH
         X/GEA37JcLkYxodxNzOfq2hhriU8zPP4mQLJIr9rJz3Pgs6TJEbUfKgLtf+9xHvxkToL
         YGGTqE1B6aNUn6uXtMv9XW7u/kkVLc3AN5E3T7s3MDGrzrHTRuEyq/SdICW+CHxNTwyW
         QeTG6sbkosyQSzTdvIsKd+EadhvOS0HmjhvbsNcCDuon5xitTIyvmh3aXJ6iYAEciXLJ
         PgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=77upEedV9MVWrhKieM+rh+8U4NcJYbcZy6sBqJQFlQA=;
        b=7T3VLgiKQ6HdDNmUF0MJoZQUpJgbV+CLVlr7JOO7+Z0+UQsrBfBqPS9nJc10c35HE5
         dak4x6CgQZaq+xSYCdtKeLAbc7i68qgM7GGqkwy5QYMMTbH4BXYdgyJpLEDJNMHAx+pp
         WsPaE4UWudQdd/c/WaSvHioVfJFvpnh5y8rHCEWYyXm5kOpSCbw7j7Vbt5B0OhgHY1qD
         W4v5VtRaKyjtoMJlYlixxfbZZbKHGfbsjLftBrO+fzk43gFNVVBnnDPvOLujDt+IOrSh
         MOGLQQQyw/Ek1TonYU2GzI6iyrwL3LiScmScz+rVc8xhbFOC2LDIvPNKsiDHKtlkGmra
         051g==
X-Gm-Message-State: AOAM532WxbAb+ASBn1/dgGHJfDQUfQomoTpUuPK3aluGqh4oZBs7XTCy
        U9hFUKs+Ofj/UhTx9CbBgFf80wzf2dI=
X-Google-Smtp-Source: ABdhPJxfRHTi2f4Xo91+bXHbsM1wH3q6jI2ZFHeAyuCAPY6LAlGBC/wE0GczFznCZuQjg0wOJP1fGQHeEA8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:907:16ac:b0:6e0:1646:9121 with SMTP id
 hc44-20020a17090716ac00b006e016469121mr35199102ejc.194.1648557683611; Tue, 29
 Mar 2022 05:41:23 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:49 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-21-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 20/48] kmsan: init: call KMSAN initialization routines
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

kmsan_init_shadow() scans the mappings created at boot time and creates
metadata pages for those mappings.

When the memblock allocator returns pages to pagealloc, we reserve 2/3
of those pages and use them as metadata for the remaining 1/3. Once KMSAN
starts, every page allocated by pagealloc has its associated shadow and
origin pages.

kmsan_initialize() initializes the bookkeeping for init_task and enables
KMSAN.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- move mm/kmsan/init.c and kmsan_memblock_free_pages() to this patch
 -- print a warning that KMSAN is a debugging tool (per Greg K-H's
    request)

Link: https://linux-review.googlesource.com/id/I7bc53706141275914326df2345881ffe0cdd16bd
---
 include/linux/kmsan.h |  48 +++++++++
 init/main.c           |   3 +
 mm/kmsan/Makefile     |   3 +-
 mm/kmsan/init.c       | 240 ++++++++++++++++++++++++++++++++++++++++++
 mm/kmsan/kmsan.h      |   3 +
 mm/kmsan/shadow.c     |  36 +++++++
 mm/page_alloc.c       |   3 +
 7 files changed, 335 insertions(+), 1 deletion(-)
 create mode 100644 mm/kmsan/init.c

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index dca42e0e91991..a5767c728a46b 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -52,6 +52,40 @@ void kmsan_task_create(struct task_struct *task);
  */
 void kmsan_task_exit(struct task_struct *task);
 
+/**
+ * kmsan_init_shadow() - Initialize KMSAN shadow at boot time.
+ *
+ * Allocate and initialize KMSAN metadata for early allocations.
+ */
+void __init kmsan_init_shadow(void);
+
+/**
+ * kmsan_init_runtime() - Initialize KMSAN state and enable KMSAN.
+ */
+void __init kmsan_init_runtime(void);
+
+/**
+ * kmsan_memblock_free_pages() - handle freeing of memblock pages.
+ * @page:	struct page to free.
+ * @order:	order of @page.
+ *
+ * Freed pages are either returned to buddy allocator or held back to be used
+ * as metadata pages.
+ */
+bool __init kmsan_memblock_free_pages(struct page *page, unsigned int order);
+
+/**
+ * kmsan_task_create() - Initialize KMSAN state for the task.
+ * @task: task to initialize.
+ */
+void kmsan_task_create(struct task_struct *task);
+
+/**
+ * kmsan_task_exit() - Notify KMSAN that a task has exited.
+ * @task: task about to finish.
+ */
+void kmsan_task_exit(struct task_struct *task);
+
 /**
  * kmsan_alloc_page() - Notify KMSAN about an alloc_pages() call.
  * @page:  struct page pointer returned by alloc_pages().
@@ -173,6 +207,20 @@ void kmsan_iounmap_page_range(unsigned long start, unsigned long end);
 
 #else
 
+static inline void kmsan_init_shadow(void)
+{
+}
+
+static inline void kmsan_init_runtime(void)
+{
+}
+
+static inline bool kmsan_memblock_free_pages(struct page *page,
+					     unsigned int order)
+{
+	return true;
+}
+
 static inline void kmsan_task_create(struct task_struct *task)
 {
 }
diff --git a/init/main.c b/init/main.c
index 65fa2e41a9c09..88be337b54298 100644
--- a/init/main.c
+++ b/init/main.c
@@ -34,6 +34,7 @@
 #include <linux/percpu.h>
 #include <linux/kmod.h>
 #include <linux/kprobes.h>
+#include <linux/kmsan.h>
 #include <linux/vmalloc.h>
 #include <linux/kernel_stat.h>
 #include <linux/start_kernel.h>
@@ -834,6 +835,7 @@ static void __init mm_init(void)
 	init_mem_debugging_and_hardening();
 	kfence_alloc_pool();
 	report_meminit();
+	kmsan_init_shadow();
 	stack_depot_early_init();
 	mem_init();
 	mem_init_print_info();
@@ -851,6 +853,7 @@ static void __init mm_init(void)
 	init_espfix_bsp();
 	/* Should be run after espfix64 is set up. */
 	pti_init();
+	kmsan_init_runtime();
 }
 
 #ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
diff --git a/mm/kmsan/Makefile b/mm/kmsan/Makefile
index 73b705cbf75b9..f57a956cb1c8b 100644
--- a/mm/kmsan/Makefile
+++ b/mm/kmsan/Makefile
@@ -1,4 +1,4 @@
-obj-y := core.o instrumentation.o hooks.o report.o shadow.o annotations.o
+obj-y := core.o instrumentation.o init.o hooks.o report.o shadow.o annotations.o
 
 KMSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
@@ -16,6 +16,7 @@ CFLAGS_REMOVE.o = $(CC_FLAGS_FTRACE)
 CFLAGS_annotations.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_core.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_hooks.o := $(CC_FLAGS_KMSAN_RUNTIME)
+CFLAGS_init.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_instrumentation.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_report.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_shadow.o := $(CC_FLAGS_KMSAN_RUNTIME)
diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
new file mode 100644
index 0000000000000..45757d1390402
--- /dev/null
+++ b/mm/kmsan/init.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KMSAN initialization routines.
+ *
+ * Copyright (C) 2017-2021 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#include "kmsan.h"
+
+#include <asm/sections.h>
+#include <linux/mm.h>
+#include <linux/memblock.h>
+
+#include "../internal.h"
+
+#define NUM_FUTURE_RANGES 128
+struct start_end_pair {
+	u64 start, end;
+};
+
+static struct start_end_pair start_end_pairs[NUM_FUTURE_RANGES] __initdata;
+static int future_index __initdata;
+
+/*
+ * Record a range of memory for which the metadata pages will be created once
+ * the page allocator becomes available.
+ */
+static void __init kmsan_record_future_shadow_range(void *start, void *end)
+{
+	u64 nstart = (u64)start, nend = (u64)end, cstart, cend;
+	bool merged = false;
+	int i;
+
+	KMSAN_WARN_ON(future_index == NUM_FUTURE_RANGES);
+	KMSAN_WARN_ON((nstart >= nend) || !nstart || !nend);
+	nstart = ALIGN_DOWN(nstart, PAGE_SIZE);
+	nend = ALIGN(nend, PAGE_SIZE);
+
+	/*
+	 * Scan the existing ranges to see if any of them overlaps with
+	 * [start, end). In that case, merge the two ranges instead of
+	 * creating a new one.
+	 * The number of ranges is less than 20, so there is no need to organize
+	 * them into a more intelligent data structure.
+	 */
+	for (i = 0; i < future_index; i++) {
+		cstart = start_end_pairs[i].start;
+		cend = start_end_pairs[i].end;
+		if ((cstart < nstart && cend < nstart) ||
+		    (cstart > nend && cend > nend))
+			/* ranges are disjoint - do not merge */
+			continue;
+		start_end_pairs[i].start = min(nstart, cstart);
+		start_end_pairs[i].end = max(nend, cend);
+		merged = true;
+		break;
+	}
+	if (merged)
+		return;
+	start_end_pairs[future_index].start = nstart;
+	start_end_pairs[future_index].end = nend;
+	future_index++;
+}
+
+/*
+ * Initialize the shadow for existing mappings during kernel initialization.
+ * These include kernel text/data sections, NODE_DATA and future ranges
+ * registered while creating other data (e.g. percpu).
+ *
+ * Allocations via memblock can be only done before slab is initialized.
+ */
+void __init kmsan_init_shadow(void)
+{
+	const size_t nd_size = roundup(sizeof(pg_data_t), PAGE_SIZE);
+	phys_addr_t p_start, p_end;
+	int nid;
+	u64 i;
+
+	for_each_reserved_mem_range(i, &p_start, &p_end)
+		kmsan_record_future_shadow_range(phys_to_virt(p_start),
+						 phys_to_virt(p_end));
+	/* Allocate shadow for .data */
+	kmsan_record_future_shadow_range(_sdata, _edata);
+
+	for_each_online_node(nid)
+		kmsan_record_future_shadow_range(
+			NODE_DATA(nid), (char *)NODE_DATA(nid) + nd_size);
+
+	for (i = 0; i < future_index; i++)
+		kmsan_init_alloc_meta_for_range(
+			(void *)start_end_pairs[i].start,
+			(void *)start_end_pairs[i].end);
+}
+EXPORT_SYMBOL(kmsan_init_shadow);
+
+struct page_pair {
+	struct page *shadow, *origin;
+};
+static struct page_pair held_back[MAX_ORDER] __initdata;
+
+/*
+ * Eager metadata allocation. When the memblock allocator is freeing pages to
+ * pagealloc, we use 2/3 of them as metadata for the remaining 1/3.
+ * We store the pointers to the returned blocks of pages in held_back[] grouped
+ * by their order: when kmsan_memblock_free_pages() is called for the first
+ * time with a certain order, it is reserved as a shadow block, for the second
+ * time - as an origin block. On the third time the incoming block receives its
+ * shadow and origin ranges from the previously saved shadow and origin blocks,
+ * after which held_back[order] can be used again.
+ *
+ * At the very end there may be leftover blocks in held_back[]. They are
+ * collected later by kmsan_memblock_discard().
+ */
+bool kmsan_memblock_free_pages(struct page *page, unsigned int order)
+{
+	struct page *shadow, *origin;
+
+	if (!held_back[order].shadow) {
+		held_back[order].shadow = page;
+		return false;
+	}
+	if (!held_back[order].origin) {
+		held_back[order].origin = page;
+		return false;
+	}
+	shadow = held_back[order].shadow;
+	origin = held_back[order].origin;
+	kmsan_setup_meta(page, shadow, origin, order);
+
+	held_back[order].shadow = NULL;
+	held_back[order].origin = NULL;
+	return true;
+}
+
+#define MAX_BLOCKS 8
+struct smallstack {
+	struct page *items[MAX_BLOCKS];
+	int index;
+	int order;
+};
+
+struct smallstack collect = {
+	.index = 0,
+	.order = MAX_ORDER,
+};
+
+static void smallstack_push(struct smallstack *stack, struct page *pages)
+{
+	KMSAN_WARN_ON(stack->index == MAX_BLOCKS);
+	stack->items[stack->index] = pages;
+	stack->index++;
+}
+#undef MAX_BLOCKS
+
+static struct page *smallstack_pop(struct smallstack *stack)
+{
+	struct page *ret;
+
+	KMSAN_WARN_ON(stack->index == 0);
+	stack->index--;
+	ret = stack->items[stack->index];
+	stack->items[stack->index] = NULL;
+	return ret;
+}
+
+static void do_collection(void)
+{
+	struct page *page, *shadow, *origin;
+
+	while (collect.index >= 3) {
+		page = smallstack_pop(&collect);
+		shadow = smallstack_pop(&collect);
+		origin = smallstack_pop(&collect);
+		kmsan_setup_meta(page, shadow, origin, collect.order);
+		__free_pages_core(page, collect.order);
+	}
+}
+
+static void collect_split(void)
+{
+	struct smallstack tmp = {
+		.order = collect.order - 1,
+		.index = 0,
+	};
+	struct page *page;
+
+	if (!collect.order)
+		return;
+	while (collect.index) {
+		page = smallstack_pop(&collect);
+		smallstack_push(&tmp, &page[0]);
+		smallstack_push(&tmp, &page[1 << tmp.order]);
+	}
+	__memcpy(&collect, &tmp, sizeof(struct smallstack));
+}
+
+/*
+ * Memblock is about to go away. Split the page blocks left over in held_back[]
+ * and return 1/3 of that memory to the system.
+ */
+static void kmsan_memblock_discard(void)
+{
+	int i;
+
+	/*
+	 * For each order=N:
+	 *  - push held_back[N].shadow and .origin to |collect|;
+	 *  - while there are >= 3 elements in |collect|, do garbage collection:
+	 *    - pop 3 ranges from |collect|;
+	 *    - use two of them as shadow and origin for the third one;
+	 *    - repeat;
+	 *  - split each remaining element from |collect| into 2 ranges of
+	 *    order=N-1,
+	 *  - repeat.
+	 */
+	collect.order = MAX_ORDER - 1;
+	for (i = MAX_ORDER - 1; i >= 0; i--) {
+		if (held_back[i].shadow)
+			smallstack_push(&collect, held_back[i].shadow);
+		if (held_back[i].origin)
+			smallstack_push(&collect, held_back[i].origin);
+		held_back[i].shadow = NULL;
+		held_back[i].origin = NULL;
+		do_collection();
+		collect_split();
+	}
+}
+
+void __init kmsan_init_runtime(void)
+{
+	/* Assuming current is init_task */
+	kmsan_internal_task_create(current);
+	kmsan_memblock_discard();
+	pr_info("Starting KernelMemorySanitizer\n");
+	pr_info("ATTENTION: KMSAN is a debugging tool! Do not use it on production machines!\n");
+	kmsan_enabled = true;
+}
+EXPORT_SYMBOL(kmsan_init_runtime);
diff --git a/mm/kmsan/kmsan.h b/mm/kmsan/kmsan.h
index a1b5900ffd97b..059f21c39ec1b 100644
--- a/mm/kmsan/kmsan.h
+++ b/mm/kmsan/kmsan.h
@@ -66,6 +66,7 @@ struct shadow_origin_ptr {
 struct shadow_origin_ptr kmsan_get_shadow_origin_ptr(void *addr, u64 size,
 						     bool store);
 void *kmsan_get_metadata(void *addr, bool is_origin);
+void __init kmsan_init_alloc_meta_for_range(void *start, void *end);
 
 enum kmsan_bug_reason {
 	REASON_ANY,
@@ -181,5 +182,7 @@ bool kmsan_internal_is_module_addr(void *vaddr);
 bool kmsan_internal_is_vmalloc_addr(void *addr);
 
 struct page *kmsan_vmalloc_to_page_or_null(void *vaddr);
+void kmsan_setup_meta(struct page *page, struct page *shadow,
+		      struct page *origin, int order);
 
 #endif /* __MM_KMSAN_KMSAN_H */
diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 8fe6a5ed05e67..99cb9436eddc6 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -298,3 +298,39 @@ void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 	kfree(s_pages);
 	kfree(o_pages);
 }
+
+/* Allocate metadata for pages allocated at boot time. */
+void __init kmsan_init_alloc_meta_for_range(void *start, void *end)
+{
+	struct page *shadow_p, *origin_p;
+	void *shadow, *origin;
+	struct page *page;
+	u64 addr, size;
+
+	start = (void *)ALIGN_DOWN((u64)start, PAGE_SIZE);
+	size = ALIGN((u64)end - (u64)start, PAGE_SIZE);
+	shadow = memblock_alloc(size, PAGE_SIZE);
+	origin = memblock_alloc(size, PAGE_SIZE);
+	for (addr = 0; addr < size; addr += PAGE_SIZE) {
+		page = virt_to_page_or_null((char *)start + addr);
+		shadow_p = virt_to_page_or_null((char *)shadow + addr);
+		set_no_shadow_origin_page(shadow_p);
+		shadow_page_for(page) = shadow_p;
+		origin_p = virt_to_page_or_null((char *)origin + addr);
+		set_no_shadow_origin_page(origin_p);
+		origin_page_for(page) = origin_p;
+	}
+}
+
+void kmsan_setup_meta(struct page *page, struct page *shadow,
+		      struct page *origin, int order)
+{
+	int i;
+
+	for (i = 0; i < (1 << order); i++) {
+		set_no_shadow_origin_page(&shadow[i]);
+		set_no_shadow_origin_page(&origin[i]);
+		shadow_page_for(&page[i]) = &shadow[i];
+		origin_page_for(&page[i]) = &origin[i];
+	}
+}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 98a066c0a9f63..4237b7290e619 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1751,6 +1751,9 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 {
 	if (early_page_uninitialised(pfn))
 		return;
+	if (!kmsan_memblock_free_pages(page, order))
+		/* KMSAN will take care of these pages. */
+		return;
 	__free_pages_core(page, order);
 }
 
-- 
2.35.1.1021.g381101b075-goog

