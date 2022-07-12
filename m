Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C651C571BEC
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 16:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiGLOFx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jul 2022 10:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGLOFv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2022 10:05:51 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4D526540
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 07:05:49 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r3so14098984ybr.6
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vd6O28VewSFhRewX03WzTG5J3zTXvR/VFa5UjMf0N0Y=;
        b=DMb/e8q7BilTtBK6TcH0Icoa+OQ9V23OddPj/UTUljSXrHATwM5NnL+b48BuN9sTuJ
         Kdp+sb6v+Ii23lFFq3IyCJDJPUiHADCxxhyS9B1+IlrWiuOXh56fp9J4+lytmKMa2bD9
         aeAlh0GXmi+VkbgRPW85vOh5sAlzG5Bi1a2pTpl1BwSEwvgu9tUaAvVH63YW6SMrC1HC
         WD/ZP+Qdj/VL0iN/yQNa/HJJIYwGRzmRosgPFeITfudEwKDtklhZIg+19s2PPCQj1nWp
         Qp+chRUBI+ndDYu9wdo5ajOQuo9+3m6yUc7WRIPAA522/z0e3wn8IDnvpb249D3X8ZV0
         HTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vd6O28VewSFhRewX03WzTG5J3zTXvR/VFa5UjMf0N0Y=;
        b=Nsl5HV12Ti3pWy+ZUaJaMsOJz66RShCjTLdBfIDhMydAc3PLbyxX6xzaTNAXtJaY4D
         ExwFymY5/OYU2KvinOpCC9wwlqCMUMEu8cCJEYqX+P3U3L+JmJpAZyBiNRGPteMyvbzG
         qIAbpLKD2vZh8jdTgZYmnOP/4dW+qiOO8S/PEwg0yh6TYO/I4p4E+L+VxU+N72q2NBsP
         +0kqwtpbr1rVHdJY98rMrcMCRzpcL+UQ74JQt5p1p+sh7MUU9iVkmklvifFqi7WjAx5y
         HmAiJfot72xFtVG91wmelz6EX5+MxKAn2sAKLN9FCYxoMj5vnNrp3wFYt1Fd0Jreu6VO
         guNQ==
X-Gm-Message-State: AJIora+3WSbLeKy1cqfgwgE1ciCwZww1tViKCXYx+Jf1kF8VG+aFtOm3
        wVzPa6FpHXFdZjCy7gXlZCvrKkGtLgEkqt9cATlwOQ==
X-Google-Smtp-Source: AGRyM1sIdaaewDnYDsIY69yIIAARIn16hCjK2BDekzfJa1VZ/Yqru1jWpYd6rRMAV+WPY3g3N3sAGB/at3CBMYCLLQI=
X-Received: by 2002:a25:94a:0:b0:668:df94:fdf4 with SMTP id
 u10-20020a25094a000000b00668df94fdf4mr21754860ybm.425.1657634748762; Tue, 12
 Jul 2022 07:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-18-glider@google.com>
In-Reply-To: <20220701142310.2188015-18-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 16:05:12 +0200
Message-ID: <CANpmjNNh0SP53s0kg_Lj2HUVnY_9k_grm==q4w6Bbq4hLmKtHA@mail.gmail.com>
Subject: Re: [PATCH v4 17/45] init: kmsan: call KMSAN initialization routines
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 1 Jul 2022 at 16:24, Alexander Potapenko <glider@google.com> wrote:
>
> kmsan_init_shadow() scans the mappings created at boot time and creates
> metadata pages for those mappings.
>
> When the memblock allocator returns pages to pagealloc, we reserve 2/3
> of those pages and use them as metadata for the remaining 1/3. Once KMSAN
> starts, every page allocated by pagealloc has its associated shadow and
> origin pages.
>
> kmsan_initialize() initializes the bookkeeping for init_task and enables
> KMSAN.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> v2:
>  -- move mm/kmsan/init.c and kmsan_memblock_free_pages() to this patch
>  -- print a warning that KMSAN is a debugging tool (per Greg K-H's
>     request)
>
> v4:
>  -- change sizeof(type) to sizeof(*ptr)
>  -- replace occurrences of |var| with @var
>  -- swap init: and kmsan: in the subject
>  -- do not export __init functions
>
> Link: https://linux-review.googlesource.com/id/I7bc53706141275914326df2345881ffe0cdd16bd
> ---
>  include/linux/kmsan.h |  48 +++++++++
>  init/main.c           |   3 +
>  mm/kmsan/Makefile     |   3 +-
>  mm/kmsan/init.c       | 238 ++++++++++++++++++++++++++++++++++++++++++
>  mm/kmsan/kmsan.h      |   3 +
>  mm/kmsan/shadow.c     |  36 +++++++
>  mm/page_alloc.c       |   3 +
>  7 files changed, 333 insertions(+), 1 deletion(-)
>  create mode 100644 mm/kmsan/init.c
>
> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> index b71e2032222e9..82fd564cc72e7 100644
> --- a/include/linux/kmsan.h
> +++ b/include/linux/kmsan.h
> @@ -51,6 +51,40 @@ void kmsan_task_create(struct task_struct *task);
>   */
>  void kmsan_task_exit(struct task_struct *task);
>
> +/**
> + * kmsan_init_shadow() - Initialize KMSAN shadow at boot time.
> + *
> + * Allocate and initialize KMSAN metadata for early allocations.
> + */
> +void __init kmsan_init_shadow(void);
> +
> +/**
> + * kmsan_init_runtime() - Initialize KMSAN state and enable KMSAN.
> + */
> +void __init kmsan_init_runtime(void);
> +
> +/**
> + * kmsan_memblock_free_pages() - handle freeing of memblock pages.
> + * @page:      struct page to free.
> + * @order:     order of @page.
> + *
> + * Freed pages are either returned to buddy allocator or held back to be used
> + * as metadata pages.
> + */
> +bool __init kmsan_memblock_free_pages(struct page *page, unsigned int order);
> +
> +/**
> + * kmsan_task_create() - Initialize KMSAN state for the task.
> + * @task: task to initialize.
> + */
> +void kmsan_task_create(struct task_struct *task);
> +
> +/**
> + * kmsan_task_exit() - Notify KMSAN that a task has exited.
> + * @task: task about to finish.
> + */
> +void kmsan_task_exit(struct task_struct *task);

Something went wrong with patch shuffling here I think,
kmsan_task_create + kmsan_task_exit decls are duplicated by this
patch.

>  /**
>   * kmsan_alloc_page() - Notify KMSAN about an alloc_pages() call.
>   * @page:  struct page pointer returned by alloc_pages().
> @@ -172,6 +206,20 @@ void kmsan_iounmap_page_range(unsigned long start, unsigned long end);
>
>  #else
>
> +static inline void kmsan_init_shadow(void)
> +{
> +}
> +
> +static inline void kmsan_init_runtime(void)
> +{
> +}
> +
> +static inline bool kmsan_memblock_free_pages(struct page *page,
> +                                            unsigned int order)
> +{
> +       return true;
> +}
> +
>  static inline void kmsan_task_create(struct task_struct *task)
>  {
>  }
> diff --git a/init/main.c b/init/main.c
> index 0ee39cdcfcac9..7ba48a9ff1d53 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -34,6 +34,7 @@
>  #include <linux/percpu.h>
>  #include <linux/kmod.h>
>  #include <linux/kprobes.h>
> +#include <linux/kmsan.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kernel_stat.h>
>  #include <linux/start_kernel.h>
> @@ -835,6 +836,7 @@ static void __init mm_init(void)
>         init_mem_debugging_and_hardening();
>         kfence_alloc_pool();
>         report_meminit();
> +       kmsan_init_shadow();
>         stack_depot_early_init();
>         mem_init();
>         mem_init_print_info();
> @@ -852,6 +854,7 @@ static void __init mm_init(void)
>         init_espfix_bsp();
>         /* Should be run after espfix64 is set up. */
>         pti_init();
> +       kmsan_init_runtime();
>  }
>
>  #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> diff --git a/mm/kmsan/Makefile b/mm/kmsan/Makefile
> index 550ad8625e4f9..401acb1a491ce 100644
> --- a/mm/kmsan/Makefile
> +++ b/mm/kmsan/Makefile
> @@ -3,7 +3,7 @@
>  # Makefile for KernelMemorySanitizer (KMSAN).
>  #
>  #
> -obj-y := core.o instrumentation.o hooks.o report.o shadow.o
> +obj-y := core.o instrumentation.o init.o hooks.o report.o shadow.o
>
>  KMSAN_SANITIZE := n
>  KCOV_INSTRUMENT := n
> @@ -18,6 +18,7 @@ CFLAGS_REMOVE.o = $(CC_FLAGS_FTRACE)
>
>  CFLAGS_core.o := $(CC_FLAGS_KMSAN_RUNTIME)
>  CFLAGS_hooks.o := $(CC_FLAGS_KMSAN_RUNTIME)
> +CFLAGS_init.o := $(CC_FLAGS_KMSAN_RUNTIME)
>  CFLAGS_instrumentation.o := $(CC_FLAGS_KMSAN_RUNTIME)
>  CFLAGS_report.o := $(CC_FLAGS_KMSAN_RUNTIME)
>  CFLAGS_shadow.o := $(CC_FLAGS_KMSAN_RUNTIME)
> diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
> new file mode 100644
> index 0000000000000..abbf595a1e359
> --- /dev/null
> +++ b/mm/kmsan/init.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KMSAN initialization routines.
> + *
> + * Copyright (C) 2017-2021 Google LLC
> + * Author: Alexander Potapenko <glider@google.com>
> + *
> + */
> +
> +#include "kmsan.h"
> +
> +#include <asm/sections.h>
> +#include <linux/mm.h>
> +#include <linux/memblock.h>
> +
> +#include "../internal.h"
> +
> +#define NUM_FUTURE_RANGES 128
> +struct start_end_pair {
> +       u64 start, end;
> +};
> +
> +static struct start_end_pair start_end_pairs[NUM_FUTURE_RANGES] __initdata;
> +static int future_index __initdata;
> +
> +/*
> + * Record a range of memory for which the metadata pages will be created once
> + * the page allocator becomes available.
> + */
> +static void __init kmsan_record_future_shadow_range(void *start, void *end)
> +{
> +       u64 nstart = (u64)start, nend = (u64)end, cstart, cend;
> +       bool merged = false;
> +       int i;
> +
> +       KMSAN_WARN_ON(future_index == NUM_FUTURE_RANGES);
> +       KMSAN_WARN_ON((nstart >= nend) || !nstart || !nend);
> +       nstart = ALIGN_DOWN(nstart, PAGE_SIZE);
> +       nend = ALIGN(nend, PAGE_SIZE);
> +
> +       /*
> +        * Scan the existing ranges to see if any of them overlaps with
> +        * [start, end). In that case, merge the two ranges instead of
> +        * creating a new one.
> +        * The number of ranges is less than 20, so there is no need to organize
> +        * them into a more intelligent data structure.
> +        */
> +       for (i = 0; i < future_index; i++) {
> +               cstart = start_end_pairs[i].start;
> +               cend = start_end_pairs[i].end;
> +               if ((cstart < nstart && cend < nstart) ||
> +                   (cstart > nend && cend > nend))
> +                       /* ranges are disjoint - do not merge */
> +                       continue;
> +               start_end_pairs[i].start = min(nstart, cstart);
> +               start_end_pairs[i].end = max(nend, cend);
> +               merged = true;
> +               break;
> +       }
> +       if (merged)
> +               return;
> +       start_end_pairs[future_index].start = nstart;
> +       start_end_pairs[future_index].end = nend;
> +       future_index++;
> +}
> +
> +/*
> + * Initialize the shadow for existing mappings during kernel initialization.
> + * These include kernel text/data sections, NODE_DATA and future ranges
> + * registered while creating other data (e.g. percpu).
> + *
> + * Allocations via memblock can be only done before slab is initialized.
> + */
> +void __init kmsan_init_shadow(void)
> +{
> +       const size_t nd_size = roundup(sizeof(pg_data_t), PAGE_SIZE);
> +       phys_addr_t p_start, p_end;
> +       int nid;
> +       u64 i;
> +
> +       for_each_reserved_mem_range(i, &p_start, &p_end)
> +               kmsan_record_future_shadow_range(phys_to_virt(p_start),
> +                                                phys_to_virt(p_end));
> +       /* Allocate shadow for .data */
> +       kmsan_record_future_shadow_range(_sdata, _edata);
> +
> +       for_each_online_node(nid)
> +               kmsan_record_future_shadow_range(
> +                       NODE_DATA(nid), (char *)NODE_DATA(nid) + nd_size);
> +
> +       for (i = 0; i < future_index; i++)
> +               kmsan_init_alloc_meta_for_range(
> +                       (void *)start_end_pairs[i].start,
> +                       (void *)start_end_pairs[i].end);
> +}
> +
> +struct page_pair {

'struct shadow_origin_pages' for a more descriptive name?

> +       struct page *shadow, *origin;
> +};
> +static struct page_pair held_back[MAX_ORDER] __initdata;
> +
> +/*
> + * Eager metadata allocation. When the memblock allocator is freeing pages to
> + * pagealloc, we use 2/3 of them as metadata for the remaining 1/3.
> + * We store the pointers to the returned blocks of pages in held_back[] grouped
> + * by their order: when kmsan_memblock_free_pages() is called for the first
> + * time with a certain order, it is reserved as a shadow block, for the second
> + * time - as an origin block. On the third time the incoming block receives its
> + * shadow and origin ranges from the previously saved shadow and origin blocks,
> + * after which held_back[order] can be used again.
> + *
> + * At the very end there may be leftover blocks in held_back[]. They are
> + * collected later by kmsan_memblock_discard().
> + */
> +bool kmsan_memblock_free_pages(struct page *page, unsigned int order)
> +{
> +       struct page *shadow, *origin;

Can this just be 'struct page_pair'?

> +       if (!held_back[order].shadow) {
> +               held_back[order].shadow = page;
> +               return false;
> +       }
> +       if (!held_back[order].origin) {
> +               held_back[order].origin = page;
> +               return false;
> +       }
> +       shadow = held_back[order].shadow;
> +       origin = held_back[order].origin;
> +       kmsan_setup_meta(page, shadow, origin, order);
> +
> +       held_back[order].shadow = NULL;
> +       held_back[order].origin = NULL;
> +       return true;
> +}
> +
> +#define MAX_BLOCKS 8
> +struct smallstack {
> +       struct page *items[MAX_BLOCKS];
> +       int index;
> +       int order;
> +};
> +
> +static struct smallstack collect = {
> +       .index = 0,
> +       .order = MAX_ORDER,
> +};
> +
> +static void smallstack_push(struct smallstack *stack, struct page *pages)
> +{
> +       KMSAN_WARN_ON(stack->index == MAX_BLOCKS);
> +       stack->items[stack->index] = pages;
> +       stack->index++;
> +}
> +#undef MAX_BLOCKS
> +
> +static struct page *smallstack_pop(struct smallstack *stack)
> +{
> +       struct page *ret;
> +
> +       KMSAN_WARN_ON(stack->index == 0);
> +       stack->index--;
> +       ret = stack->items[stack->index];
> +       stack->items[stack->index] = NULL;
> +       return ret;
> +}
> +
> +static void do_collection(void)
> +{
> +       struct page *page, *shadow, *origin;
> +
> +       while (collect.index >= 3) {
> +               page = smallstack_pop(&collect);
> +               shadow = smallstack_pop(&collect);
> +               origin = smallstack_pop(&collect);
> +               kmsan_setup_meta(page, shadow, origin, collect.order);
> +               __free_pages_core(page, collect.order);
> +       }
> +}
> +
> +static void collect_split(void)
> +{
> +       struct smallstack tmp = {
> +               .order = collect.order - 1,
> +               .index = 0,
> +       };
> +       struct page *page;
> +
> +       if (!collect.order)
> +               return;
> +       while (collect.index) {
> +               page = smallstack_pop(&collect);
> +               smallstack_push(&tmp, &page[0]);
> +               smallstack_push(&tmp, &page[1 << tmp.order]);
> +       }
> +       __memcpy(&collect, &tmp, sizeof(tmp));
> +}
> +
> +/*
> + * Memblock is about to go away. Split the page blocks left over in held_back[]
> + * and return 1/3 of that memory to the system.
> + */
> +static void kmsan_memblock_discard(void)
> +{
> +       int i;
> +
> +       /*
> +        * For each order=N:
> +        *  - push held_back[N].shadow and .origin to @collect;
> +        *  - while there are >= 3 elements in @collect, do garbage collection:
> +        *    - pop 3 ranges from @collect;
> +        *    - use two of them as shadow and origin for the third one;
> +        *    - repeat;
> +        *  - split each remaining element from @collect into 2 ranges of
> +        *    order=N-1,
> +        *  - repeat.
> +        */
> +       collect.order = MAX_ORDER - 1;
> +       for (i = MAX_ORDER - 1; i >= 0; i--) {
> +               if (held_back[i].shadow)
> +                       smallstack_push(&collect, held_back[i].shadow);
> +               if (held_back[i].origin)
> +                       smallstack_push(&collect, held_back[i].origin);
> +               held_back[i].shadow = NULL;
> +               held_back[i].origin = NULL;
> +               do_collection();
> +               collect_split();
> +       }
> +}
> +
> +void __init kmsan_init_runtime(void)
> +{
> +       /* Assuming current is init_task */
> +       kmsan_internal_task_create(current);
> +       kmsan_memblock_discard();
> +       pr_info("Starting KernelMemorySanitizer\n");
> +       pr_info("ATTENTION: KMSAN is a debugging tool! Do not use it on production machines!\n");
> +       kmsan_enabled = true;
> +}
> diff --git a/mm/kmsan/kmsan.h b/mm/kmsan/kmsan.h
> index c7fb8666607e2..2f17912ef863f 100644
> --- a/mm/kmsan/kmsan.h
> +++ b/mm/kmsan/kmsan.h
> @@ -66,6 +66,7 @@ struct shadow_origin_ptr {
>  struct shadow_origin_ptr kmsan_get_shadow_origin_ptr(void *addr, u64 size,
>                                                      bool store);
>  void *kmsan_get_metadata(void *addr, bool is_origin);
> +void __init kmsan_init_alloc_meta_for_range(void *start, void *end);
>
>  enum kmsan_bug_reason {
>         REASON_ANY,
> @@ -188,5 +189,7 @@ bool kmsan_internal_is_module_addr(void *vaddr);
>  bool kmsan_internal_is_vmalloc_addr(void *addr);
>
>  struct page *kmsan_vmalloc_to_page_or_null(void *vaddr);
> +void kmsan_setup_meta(struct page *page, struct page *shadow,
> +                     struct page *origin, int order);
>
>  #endif /* __MM_KMSAN_KMSAN_H */
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> index 416cb85487a1a..7b254c30d42cc 100644
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -259,3 +259,39 @@ void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>         kfree(s_pages);
>         kfree(o_pages);
>  }
> +
> +/* Allocate metadata for pages allocated at boot time. */
> +void __init kmsan_init_alloc_meta_for_range(void *start, void *end)
> +{
> +       struct page *shadow_p, *origin_p;
> +       void *shadow, *origin;
> +       struct page *page;
> +       u64 addr, size;
> +
> +       start = (void *)ALIGN_DOWN((u64)start, PAGE_SIZE);
> +       size = ALIGN((u64)end - (u64)start, PAGE_SIZE);
> +       shadow = memblock_alloc(size, PAGE_SIZE);
> +       origin = memblock_alloc(size, PAGE_SIZE);
> +       for (addr = 0; addr < size; addr += PAGE_SIZE) {
> +               page = virt_to_page_or_null((char *)start + addr);
> +               shadow_p = virt_to_page_or_null((char *)shadow + addr);
> +               set_no_shadow_origin_page(shadow_p);
> +               shadow_page_for(page) = shadow_p;
> +               origin_p = virt_to_page_or_null((char *)origin + addr);
> +               set_no_shadow_origin_page(origin_p);
> +               origin_page_for(page) = origin_p;
> +       }
> +}
> +
> +void kmsan_setup_meta(struct page *page, struct page *shadow,
> +                     struct page *origin, int order)
> +{
> +       int i;
> +
> +       for (i = 0; i < (1 << order); i++) {

Noticed this in many places, but we can just make these "for (int i =.." now.

> +               set_no_shadow_origin_page(&shadow[i]);
> +               set_no_shadow_origin_page(&origin[i]);
> +               shadow_page_for(&page[i]) = &shadow[i];
> +               origin_page_for(&page[i]) = &origin[i];
> +       }
> +}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 785459251145e..e8d5a0b2a3264 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1731,6 +1731,9 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
>  {
>         if (early_page_uninitialised(pfn))
>                 return;
> +       if (!kmsan_memblock_free_pages(page, order))
> +               /* KMSAN will take care of these pages. */
> +               return;

Add {} because the then-statement is not right below the if.
