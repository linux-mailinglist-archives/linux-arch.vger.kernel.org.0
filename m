Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834E0570815
	for <lists+linux-arch@lfdr.de>; Mon, 11 Jul 2022 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiGKQNq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jul 2022 12:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiGKQNj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jul 2022 12:13:39 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6A610B8
        for <linux-arch@vger.kernel.org>; Mon, 11 Jul 2022 09:13:36 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31cac89d8d6so54355527b3.2
        for <linux-arch@vger.kernel.org>; Mon, 11 Jul 2022 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOu1n0uYdCsudxoJVtyz5/UL8tUbc5xPCGC+9KrKzU4=;
        b=jfZhtAzNU5rTNiQTs4mptKw1m2kTa9R6IQTrIM+PBmuO9yyCHXVyohDAlN7KTzn6Ah
         we0Ko3BSxqQWXKVCJWUqcjMFYTQ78+eNUIvCbS8SdyauGnfHltCkJdcl53p9aqKvWY3m
         IRJ3N9l8PXZ6ZZNwNwgBnoO6YhW3Kajtwmk3Yppwor2+/X/PfamcxKpfKaKnsiD5jMwe
         C7PQoBo9a8L6Gtf9tzt2aclez/bEA+frq7ccjV5CWtuVTh7ZAko/VlLMTBm4+dOZMCSz
         yHdAEc6RTrY4quwMSVG8R6BnUsgBhGlxx3SUpp5nDkGFTpMdMtR9QNkzjQOQ51Hqem1r
         ROgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOu1n0uYdCsudxoJVtyz5/UL8tUbc5xPCGC+9KrKzU4=;
        b=44eX3csTOtHb8Yvv0mTIF/Bx5vgjl9wiAGXN4m4nMmd7Njj1E12l4cINFDgigIenuU
         sL28+RkcvwQawjp2Sxq6Eu/nrfDrNdTH7R/+TUq4xMdPklm5HVSbebY9osn9KNfZulQp
         /qDNaVduNUpLX1a0QrhT25tpFQlKmk+grTcIwIGRd1NWNmoRnuSs1Sb/7P6bHmkIDShy
         Z/Q5u781vGduZZPHarc8MGwtmaq0NM2CuQpD1Osb3S2Ng/Q/iFE9EjDp0lnEKc6lhZjf
         9VyksThRnx5g42ZTqgZbvG1VFAf6/BOjpMM0KoF3txWpMeS3JdAUHexPXZHWmMMn9nFh
         32jw==
X-Gm-Message-State: AJIora/gmQFhllBeOZ4fBve6SyRXlFOeY7uIYEH/KaNv7lRrTL8ol81Z
        5iTBFFdqjlz9dwrYOnzkgLtvtKZJlW+Awl6tXfMnpQ==
X-Google-Smtp-Source: AGRyM1u7w4vwWQLqCchegA4jWk07R+nBUJyoXBnwnNANR5KSe1C5dJ2LQvRXdoOq/VOfMNDgU8kdjtBCXiK48O1MRt0=
X-Received: by 2002:a81:98d:0:b0:31c:921c:9783 with SMTP id
 135-20020a81098d000000b0031c921c9783mr19996386ywj.316.1657556015569; Mon, 11
 Jul 2022 09:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-10-glider@google.com>
In-Reply-To: <20220701142310.2188015-10-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Jul 2022 18:12:59 +0200
Message-ID: <CANpmjNN8xD2WK_Au86ww1eqGaUbWr+B=m0GuzrDrbhKA=hJYwQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/45] x86: kmsan: pgtable: reduce vmalloc space
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

On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
>
> KMSAN is going to use 3/4 of existing vmalloc space to hold the
> metadata, therefore we lower VMALLOC_END to make sure vmalloc() doesn't
> allocate past the first 1/4.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> v2:
>  -- added x86: to the title
>
> Link: https://linux-review.googlesource.com/id/I9d8b7f0a88a639f1263bc693cbd5c136626f7efd
> ---
>  arch/x86/include/asm/pgtable_64_types.h | 41 ++++++++++++++++++++++++-
>  arch/x86/mm/init_64.c                   |  2 +-
>  2 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index 70e360a2e5fb7..ad6ded5b1dedf 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -139,7 +139,46 @@ extern unsigned int ptrs_per_p4d;
>  # define VMEMMAP_START         __VMEMMAP_BASE_L4
>  #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
>
> -#define VMALLOC_END            (VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
> +#define VMEMORY_END            (VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)

Comment what VMEMORY_END is? (Seems obvious, but less guessing is better here.)

> +#ifndef CONFIG_KMSAN
> +#define VMALLOC_END            VMEMORY_END
> +#else
> +/*
> + * In KMSAN builds vmalloc area is four times smaller, and the remaining 3/4
> + * are used to keep the metadata for virtual pages. The memory formerly
> + * belonging to vmalloc area is now laid out as follows:
> + *
> + * 1st quarter: VMALLOC_START to VMALLOC_END - new vmalloc area
> + * 2nd quarter: KMSAN_VMALLOC_SHADOW_START to
> + *              VMALLOC_END+KMSAN_VMALLOC_SHADOW_OFFSET - vmalloc area shadow
> + * 3rd quarter: KMSAN_VMALLOC_ORIGIN_START to
> + *              VMALLOC_END+KMSAN_VMALLOC_ORIGIN_OFFSET - vmalloc area origins
> + * 4th quarter: KMSAN_MODULES_SHADOW_START to KMSAN_MODULES_ORIGIN_START
> + *              - shadow for modules,
> + *              KMSAN_MODULES_ORIGIN_START to
> + *              KMSAN_MODULES_ORIGIN_START + MODULES_LEN - origins for modules.
> + */
> +#define VMALLOC_QUARTER_SIZE   ((VMALLOC_SIZE_TB << 40) >> 2)
> +#define VMALLOC_END            (VMALLOC_START + VMALLOC_QUARTER_SIZE - 1)
> +
> +/*
> + * vmalloc metadata addresses are calculated by adding shadow/origin offsets
> + * to vmalloc address.
> + */
> +#define KMSAN_VMALLOC_SHADOW_OFFSET    VMALLOC_QUARTER_SIZE
> +#define KMSAN_VMALLOC_ORIGIN_OFFSET    (VMALLOC_QUARTER_SIZE << 1)
> +
> +#define KMSAN_VMALLOC_SHADOW_START     (VMALLOC_START + KMSAN_VMALLOC_SHADOW_OFFSET)
> +#define KMSAN_VMALLOC_ORIGIN_START     (VMALLOC_START + KMSAN_VMALLOC_ORIGIN_OFFSET)
> +
> +/*
> + * The shadow/origin for modules are placed one by one in the last 1/4 of
> + * vmalloc space.
> + */
> +#define KMSAN_MODULES_SHADOW_START     (VMALLOC_END + KMSAN_VMALLOC_ORIGIN_OFFSET + 1)
> +#define KMSAN_MODULES_ORIGIN_START     (KMSAN_MODULES_SHADOW_START + MODULES_LEN)
> +#endif /* CONFIG_KMSAN */
>
>  #define MODULES_VADDR          (__START_KERNEL_map + KERNEL_IMAGE_SIZE)
>  /* The module sections ends with the start of the fixmap */
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 39c5246964a91..5806331172361 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1287,7 +1287,7 @@ static void __init preallocate_vmalloc_pages(void)
>         unsigned long addr;
>         const char *lvl;
>
> -       for (addr = VMALLOC_START; addr <= VMALLOC_END; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
> +       for (addr = VMALLOC_START; addr <= VMEMORY_END; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
>                 pgd_t *pgd = pgd_offset_k(addr);
>                 p4d_t *p4d;
>                 pud_t *pud;
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
