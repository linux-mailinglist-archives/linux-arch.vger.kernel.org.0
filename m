Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21099571AE6
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiGLNOe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jul 2022 09:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGLNOe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2022 09:14:34 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6E565F8
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 06:14:32 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p129so13856193yba.7
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BonEn6uOwekFl3zwAk2Kis9tLSCC45eUpmb7zWo4VJI=;
        b=Ei+65oY0/L+YeMQ1FjVks7XnHIa0H/pol34HBHs2FcL9Q7phxIqIPLH9RPDjkjPACp
         I+qWzwPIn0D24e++W3Y4eVpA7sk5tc2GxOj3Guu/jzK58jQSuc99e6CfhxQucydm6p2F
         PUU6gG0AwT5w8nYdpIhdSvN+t6gR1hJYmeaCWGCDhuifOxPqP8WGTFp9BPgG+FA9kovz
         SUqzBjp7nSm8W3HAeCK01MGJ6SyNABUd8BRocKOkPOzCaMvr64kAPXcLeF0lqvBtFumi
         2/VRcnqTQ1W+9XHhczLWY0VAK+4ura4IXhE0342iVV6consMox/cv14hJVnDR28p639j
         RbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BonEn6uOwekFl3zwAk2Kis9tLSCC45eUpmb7zWo4VJI=;
        b=birkN1cq89dQvxRtM5IACUPWzcLKaDsMHnv5uYI7I4qsF5tvKjJTF9Ehfvb1/YTxC5
         2V1vH/GrpLHZTs9dnWSfXAF+owolOhDOeQ0oybRZqcUvnLe+H75TQXaJ5T1HrGezVJHp
         WAmaLjiVWrZ1mezOO3OGjaCOL6lgkyim+IKvh2Tomo5ICpxykzow8MiILkJJ9zOortij
         QYpPa6STVkK3YxM9VrO1s8/BmQgcIv1eClNVe8ST3Ut0RlwOmWCX9RWBI83ZvFi4YD3D
         neh2gTaZSgcrTEIBvjZ4iypZhY+cybMvW6X/PMoka0dR2SiUngqUVDcHSPOMjRnQfGwI
         sHvA==
X-Gm-Message-State: AJIora+JgicuMpbvkzb9YfzbKo9drr94TRCm+lLXOCZq6D31XHa/FLTk
        0jKi0qTPzRVg9yYCRG88VHcIZeSz8EhNq7iEoCwdYQ==
X-Google-Smtp-Source: AGRyM1t3MUCp/CV5V+cpnchkexRCwEh09OyfLbEs5YJ1MMEogJ1Ly4GZ0Kh71upFxhlQLBhCzmmahxJwZPCVgMqv2po=
X-Received: by 2002:a25:2d59:0:b0:66e:32d3:7653 with SMTP id
 s25-20020a252d59000000b0066e32d37653mr22288782ybe.625.1657631671169; Tue, 12
 Jul 2022 06:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-16-glider@google.com>
In-Reply-To: <20220701142310.2188015-16-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 15:13:55 +0200
Message-ID: <CANpmjNOJ-2xim3KM=9O=sfSgQXZi81R6PQj=antfHnejaOOogg@mail.gmail.com>
Subject: Re: [PATCH v4 15/45] mm: kmsan: call KMSAN hooks from SLUB code
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 1 Jul 2022 at 16:23, 'Alexander Potapenko' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> In order to report uninitialized memory coming from heap allocations
> KMSAN has to poison them unless they're created with __GFP_ZERO.
>
> It's handy that we need KMSAN hooks in the places where
> init_on_alloc/init_on_free initialization is performed.
>
> In addition, we apply __no_kmsan_checks to get_freepointer_safe() to
> suppress reports when accessing freelist pointers that reside in freed
> objects.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

But see comment below.

> ---
> v2:
>  -- move the implementation of SLUB hooks here
>
> v4:
>  -- change sizeof(type) to sizeof(*ptr)
>  -- swap mm: and kmsan: in the subject
>  -- get rid of kmsan_init(), replace it with __no_kmsan_checks
>
> Link: https://linux-review.googlesource.com/id/I6954b386c5c5d7f99f48bb6cbcc74b75136ce86e
> ---
>  include/linux/kmsan.h | 57 ++++++++++++++++++++++++++++++
>  mm/kmsan/hooks.c      | 80 +++++++++++++++++++++++++++++++++++++++++++
>  mm/slab.h             |  1 +
>  mm/slub.c             | 18 ++++++++++
>  4 files changed, 156 insertions(+)
>
> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> index 699fe4f5b3bee..fd76cea338878 100644
> --- a/include/linux/kmsan.h
> +++ b/include/linux/kmsan.h
> @@ -15,6 +15,7 @@
>  #include <linux/types.h>
>
>  struct page;
> +struct kmem_cache;
>
>  #ifdef CONFIG_KMSAN
>
> @@ -72,6 +73,44 @@ void kmsan_free_page(struct page *page, unsigned int order);
>   */
>  void kmsan_copy_page_meta(struct page *dst, struct page *src);
>
> +/**
> + * kmsan_slab_alloc() - Notify KMSAN about a slab allocation.
> + * @s:      slab cache the object belongs to.
> + * @object: object pointer.
> + * @flags:  GFP flags passed to the allocator.
> + *
> + * Depending on cache flags and GFP flags, KMSAN sets up the metadata of the
> + * newly created object, marking it as initialized or uninitialized.
> + */
> +void kmsan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags);
> +
> +/**
> + * kmsan_slab_free() - Notify KMSAN about a slab deallocation.
> + * @s:      slab cache the object belongs to.
> + * @object: object pointer.
> + *
> + * KMSAN marks the freed object as uninitialized.
> + */
> +void kmsan_slab_free(struct kmem_cache *s, void *object);
> +
> +/**
> + * kmsan_kmalloc_large() - Notify KMSAN about a large slab allocation.
> + * @ptr:   object pointer.
> + * @size:  object size.
> + * @flags: GFP flags passed to the allocator.
> + *
> + * Similar to kmsan_slab_alloc(), but for large allocations.
> + */
> +void kmsan_kmalloc_large(const void *ptr, size_t size, gfp_t flags);
> +
> +/**
> + * kmsan_kfree_large() - Notify KMSAN about a large slab deallocation.
> + * @ptr: object pointer.
> + *
> + * Similar to kmsan_slab_free(), but for large allocations.
> + */
> +void kmsan_kfree_large(const void *ptr);
> +
>  /**
>   * kmsan_map_kernel_range_noflush() - Notify KMSAN about a vmap.
>   * @start:     start of vmapped range.
> @@ -138,6 +177,24 @@ static inline void kmsan_copy_page_meta(struct page *dst, struct page *src)
>  {
>  }
>
> +static inline void kmsan_slab_alloc(struct kmem_cache *s, void *object,
> +                                   gfp_t flags)
> +{
> +}
> +
> +static inline void kmsan_slab_free(struct kmem_cache *s, void *object)
> +{
> +}
> +
> +static inline void kmsan_kmalloc_large(const void *ptr, size_t size,
> +                                      gfp_t flags)
> +{
> +}
> +
> +static inline void kmsan_kfree_large(const void *ptr)
> +{
> +}
> +
>  static inline void kmsan_vmap_pages_range_noflush(unsigned long start,
>                                                   unsigned long end,
>                                                   pgprot_t prot,
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index 070756be70e3a..052e17b7a717d 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -26,6 +26,86 @@
>   * skipping effects of functions like memset() inside instrumented code.
>   */
>
> +void kmsan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags)
> +{
> +       if (unlikely(object == NULL))
> +               return;
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +       /*
> +        * There's a ctor or this is an RCU cache - do nothing. The memory
> +        * status hasn't changed since last use.
> +        */
> +       if (s->ctor || (s->flags & SLAB_TYPESAFE_BY_RCU))
> +               return;
> +
> +       kmsan_enter_runtime();
> +       if (flags & __GFP_ZERO)
> +               kmsan_internal_unpoison_memory(object, s->object_size,
> +                                              KMSAN_POISON_CHECK);
> +       else
> +               kmsan_internal_poison_memory(object, s->object_size, flags,
> +                                            KMSAN_POISON_CHECK);
> +       kmsan_leave_runtime();
> +}
> +EXPORT_SYMBOL(kmsan_slab_alloc);
> +
> +void kmsan_slab_free(struct kmem_cache *s, void *object)
> +{
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +
> +       /* RCU slabs could be legally used after free within the RCU period */
> +       if (unlikely(s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)))
> +               return;
> +       /*
> +        * If there's a constructor, freed memory must remain in the same state
> +        * until the next allocation. We cannot save its state to detect
> +        * use-after-free bugs, instead we just keep it unpoisoned.
> +        */
> +       if (s->ctor)
> +               return;
> +       kmsan_enter_runtime();
> +       kmsan_internal_poison_memory(object, s->object_size, GFP_KERNEL,
> +                                    KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
> +       kmsan_leave_runtime();
> +}
> +EXPORT_SYMBOL(kmsan_slab_free);
> +
> +void kmsan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
> +{
> +       if (unlikely(ptr == NULL))
> +               return;
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +       kmsan_enter_runtime();
> +       if (flags & __GFP_ZERO)
> +               kmsan_internal_unpoison_memory((void *)ptr, size,
> +                                              /*checked*/ true);
> +       else
> +               kmsan_internal_poison_memory((void *)ptr, size, flags,
> +                                            KMSAN_POISON_CHECK);
> +       kmsan_leave_runtime();
> +}
> +EXPORT_SYMBOL(kmsan_kmalloc_large);
> +
> +void kmsan_kfree_large(const void *ptr)
> +{
> +       struct page *page;
> +
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +       kmsan_enter_runtime();
> +       page = virt_to_head_page((void *)ptr);
> +       KMSAN_WARN_ON(ptr != page_address(page));
> +       kmsan_internal_poison_memory((void *)ptr,
> +                                    PAGE_SIZE << compound_order(page),
> +                                    GFP_KERNEL,
> +                                    KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
> +       kmsan_leave_runtime();
> +}
> +EXPORT_SYMBOL(kmsan_kfree_large);
> +
>  static unsigned long vmalloc_shadow(unsigned long addr)
>  {
>         return (unsigned long)kmsan_get_metadata((void *)addr,
> diff --git a/mm/slab.h b/mm/slab.h
> index db9fb5c8dae73..d0de8195873d8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -752,6 +752,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>                         memset(p[i], 0, s->object_size);
>                 kmemleak_alloc_recursive(p[i], s->object_size, 1,
>                                          s->flags, flags);
> +               kmsan_slab_alloc(s, p[i], flags);
>         }
>
>         memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
> diff --git a/mm/slub.c b/mm/slub.c
> index b1281b8654bd3..b8b601f165087 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -22,6 +22,7 @@
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/kasan.h>
> +#include <linux/kmsan.h>
>  #include <linux/cpu.h>
>  #include <linux/cpuset.h>
>  #include <linux/mempolicy.h>
> @@ -359,6 +360,17 @@ static void prefetch_freepointer(const struct kmem_cache *s, void *object)
>         prefetchw(object + s->offset);
>  }
>
> +/*
> + * When running under KMSAN, get_freepointer_safe() may return an uninitialized
> + * pointer value in the case the current thread loses the race for the next
> + * memory chunk in the freelist. In that case this_cpu_cmpxchg_double() in
> + * slab_alloc_node() will fail, so the uninitialized value won't be used, but
> + * KMSAN will still check all arguments of cmpxchg because of imperfect
> + * handling of inline assembly.
> + * To work around this problem, we apply __no_kmsan_checks to ensure that
> + * get_freepointer_safe() returns initialized memory.
> + */
> +__no_kmsan_checks
>  static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
>  {
>         unsigned long freepointer_addr;
> @@ -1709,6 +1721,7 @@ static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
>         ptr = kasan_kmalloc_large(ptr, size, flags);
>         /* As ptr might get tagged, call kmemleak hook after KASAN. */
>         kmemleak_alloc(ptr, size, 1, flags);
> +       kmsan_kmalloc_large(ptr, size, flags);
>         return ptr;
>  }
>
> @@ -1716,12 +1729,14 @@ static __always_inline void kfree_hook(void *x)
>  {
>         kmemleak_free(x);
>         kasan_kfree_large(x);
> +       kmsan_kfree_large(x);
>  }
>
>  static __always_inline bool slab_free_hook(struct kmem_cache *s,
>                                                 void *x, bool init)
>  {
>         kmemleak_free_recursive(x, s->flags);
> +       kmsan_slab_free(s, x);
>
>         debug_check_no_locks_freed(x, s->object_size);
>
> @@ -3756,6 +3771,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>          */
>         slab_post_alloc_hook(s, objcg, flags, size, p,
>                                 slab_want_init_on_alloc(flags, s));
> +

Remove unnecessary whitespace change.
