Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA691571C24
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiGLORw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jul 2022 10:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiGLORj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2022 10:17:39 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7585CB3D58
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 07:17:37 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2ef5380669cso82274987b3.9
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fEuio4lP8DLja3+6yBSWoacIG45qoddRrq8lnL8+qJY=;
        b=A0yawrSyuBD1BrwqS6XcHwx7HkNd0M32tyf3plN3UdAYm30JPg6qQngknmH04thTbJ
         01pYsA15md6pUA3C11uIz2irvTBZSdPs7zdizz+Aum6XH6V5I5bu+UiwYKvovCdHMDhY
         cCTn72UsXaPzlUEh+LalWHMPc1hi/zDNwfeGbIoJFuD5rYP10OnBSTa8QkIWy/kcIxOP
         jX+u42g5fYdEGJExuQBn2AMnycuF9sCpZ3v3/kakGZuz6NiSs0qxmuVIanloI5ObVSFR
         cBsdFV9KC60+VkN+0U2LN1JxoveviS8QUXyZW8fQdZv5Ga1AI9NHYySSL5skT1gUxkTG
         hf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEuio4lP8DLja3+6yBSWoacIG45qoddRrq8lnL8+qJY=;
        b=25GTRfkOfvCYNSET1fl4vkgQg+Mq1QxOgv/u3N/PvGedXD7ANhAaS1Uz+qgYggFjRS
         pkoVid1QdX1ma4l/DdEgpddIx7hYCwuUYpDLxm485SktGqA1MWCQbaMF1r3CL6F5DkO1
         ftnpJZUhkiVtow5a/LYPvb2/xi99a5dGGmZoqvCmp6croY1TH7Kh9bddh9aev5wT6GMT
         U0NrMXimgQtqIDwJKBNRS3/doYlNy+d7ypFURWJvF4yFR6s7bMQBaOVf/fffIjhtPjpY
         CffQWyKWt3vQ0kSbN1xWHYUxj8pujShgzrwxFXMMno4+EQnLi7wH4kuRG6uRN3h3YvkC
         IjpA==
X-Gm-Message-State: AJIora8UfY69faD2vGVdBM+rGoAZoV/YlbmtJvEKQVo0+lUXJX96Ydn0
        irOOWsuf/ajKH7fCH9t9jqVFUfFWYYvC0So+R5IWFw==
X-Google-Smtp-Source: AGRyM1uQtghvNUKgdsR3kXQMmbgVawdVDZj57u52IyZ42Le1Qp7LffGVDk5K2rPGxqdKdxST/O5XSgOcyPO8vCvxbr8=
X-Received: by 2002:a0d:cf07:0:b0:31d:17cb:ec11 with SMTP id
 r7-20020a0dcf07000000b0031d17cbec11mr26264367ywd.264.1657635456390; Tue, 12
 Jul 2022 07:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-3-glider@google.com>
In-Reply-To: <20220701142310.2188015-3-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 16:17:00 +0200
Message-ID: <CANpmjNNuys+-OZj5f_5qc9dH3=+gYADJT4uxzsAPQjhPd-QCSQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/45] stackdepot: reserve 5 extra bits in depot_stack_handle_t
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

On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
>
> Some users (currently only KMSAN) may want to use spare bits in
> depot_stack_handle_t. Let them do so by adding @extra_bits to
> __stack_depot_save() to store arbitrary flags, and providing
> stack_depot_get_extra_bits() to retrieve those flags.
>
> Also adapt KASAN to the new prototype by passing extra_bits=0, as KASAN
> does not intend to store additional information in the stack handle.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
> v4:
>  -- per Marco Elver's request, fold "kasan: common: adapt to the new
>     prototype of __stack_depot_save()" into this patch to prevent
>     bisection breakages.
>
> Link: https://linux-review.googlesource.com/id/I0587f6c777667864768daf07821d594bce6d8ff9
> ---
>  include/linux/stackdepot.h |  8 ++++++++
>  lib/stackdepot.c           | 29 ++++++++++++++++++++++++-----
>  mm/kasan/common.c          |  2 +-
>  3 files changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index bc2797955de90..9ca7798d7a318 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -14,9 +14,15 @@
>  #include <linux/gfp.h>
>
>  typedef u32 depot_stack_handle_t;
> +/*
> + * Number of bits in the handle that stack depot doesn't use. Users may store
> + * information in them.
> + */
> +#define STACK_DEPOT_EXTRA_BITS 5
>
>  depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                                         unsigned int nr_entries,
> +                                       unsigned int extra_bits,
>                                         gfp_t gfp_flags, bool can_alloc);
>
>  /*
> @@ -59,6 +65,8 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>  unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>                                unsigned long **entries);
>
> +unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle);
> +
>  int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
>                        int spaces);
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 5ca0d086ef4a3..3d1dbdd5a87f6 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -42,7 +42,8 @@
>  #define STACK_ALLOC_OFFSET_BITS (STACK_ALLOC_ORDER + PAGE_SHIFT - \
>                                         STACK_ALLOC_ALIGN)
>  #define STACK_ALLOC_INDEX_BITS (DEPOT_STACK_BITS - \
> -               STACK_ALLOC_NULL_PROTECTION_BITS - STACK_ALLOC_OFFSET_BITS)
> +               STACK_ALLOC_NULL_PROTECTION_BITS - \
> +               STACK_ALLOC_OFFSET_BITS - STACK_DEPOT_EXTRA_BITS)
>  #define STACK_ALLOC_SLABS_CAP 8192
>  #define STACK_ALLOC_MAX_SLABS \
>         (((1LL << (STACK_ALLOC_INDEX_BITS)) < STACK_ALLOC_SLABS_CAP) ? \
> @@ -55,6 +56,7 @@ union handle_parts {
>                 u32 slabindex : STACK_ALLOC_INDEX_BITS;
>                 u32 offset : STACK_ALLOC_OFFSET_BITS;
>                 u32 valid : STACK_ALLOC_NULL_PROTECTION_BITS;
> +               u32 extra : STACK_DEPOT_EXTRA_BITS;
>         };
>  };
>
> @@ -76,6 +78,14 @@ static int next_slab_inited;
>  static size_t depot_offset;
>  static DEFINE_RAW_SPINLOCK(depot_lock);
>
> +unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
> +{
> +       union handle_parts parts = { .handle = handle };
> +
> +       return parts.extra;
> +}
> +EXPORT_SYMBOL(stack_depot_get_extra_bits);
> +
>  static bool init_stack_slab(void **prealloc)
>  {
>         if (!*prealloc)
> @@ -139,6 +149,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>         stack->handle.slabindex = depot_index;
>         stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
>         stack->handle.valid = 1;
> +       stack->handle.extra = 0;
>         memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
>         depot_offset += required_size;
>
> @@ -343,6 +354,7 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
>   *
>   * @entries:           Pointer to storage array
>   * @nr_entries:                Size of the storage array
> + * @extra_bits:                Flags to store in unused bits of depot_stack_handle_t
>   * @alloc_flags:       Allocation gfp flags
>   * @can_alloc:         Allocate stack slabs (increased chance of failure if false)
>   *
> @@ -354,6 +366,10 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
>   * If the stack trace in @entries is from an interrupt, only the portion up to
>   * interrupt entry is saved.
>   *
> + * Additional opaque flags can be passed in @extra_bits, stored in the unused
> + * bits of the stack handle, and retrieved using stack_depot_get_extra_bits()
> + * without calling stack_depot_fetch().
> + *
>   * Context: Any context, but setting @can_alloc to %false is required if
>   *          alloc_pages() cannot be used from the current context. Currently
>   *          this is the case from contexts where neither %GFP_ATOMIC nor
> @@ -363,10 +379,11 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
>   */
>  depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                                         unsigned int nr_entries,
> +                                       unsigned int extra_bits,
>                                         gfp_t alloc_flags, bool can_alloc)
>  {
>         struct stack_record *found = NULL, **bucket;
> -       depot_stack_handle_t retval = 0;
> +       union handle_parts retval = { .handle = 0 };
>         struct page *page = NULL;
>         void *prealloc = NULL;
>         unsigned long flags;
> @@ -450,9 +467,11 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                 free_pages((unsigned long)prealloc, STACK_ALLOC_ORDER);
>         }
>         if (found)
> -               retval = found->handle.handle;
> +               retval.handle = found->handle.handle;
>  fast_exit:
> -       return retval;
> +       retval.extra = extra_bits;
> +
> +       return retval.handle;
>  }
>  EXPORT_SYMBOL_GPL(__stack_depot_save);
>
> @@ -472,6 +491,6 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>                                       unsigned int nr_entries,
>                                       gfp_t alloc_flags)
>  {
> -       return __stack_depot_save(entries, nr_entries, alloc_flags, true);
> +       return __stack_depot_save(entries, nr_entries, 0, alloc_flags, true);
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_save);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index c40c0e7b3b5f1..ba4fceeec173c 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -36,7 +36,7 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
>         unsigned int nr_entries;
>
>         nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> -       return __stack_depot_save(entries, nr_entries, flags, can_alloc);
> +       return __stack_depot_save(entries, nr_entries, 0, flags, can_alloc);
>  }
>
>  void kasan_set_track(struct kasan_track *track, gfp_t flags)
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
