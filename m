Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595B24759C5
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 14:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbhLONgZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 08:36:25 -0500
Received: from foss.arm.com ([217.140.110.172]:52202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234413AbhLONgX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Dec 2021 08:36:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5212811D4;
        Wed, 15 Dec 2021 05:36:22 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A6A13F774;
        Wed, 15 Dec 2021 05:36:17 -0800 (PST)
Date:   Wed, 15 Dec 2021 13:36:14 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: Re: [PATCH 10/43] kmsan: pgtable: reduce vmalloc space
Message-ID: <YbnvTso+V6eZYGt+@FVFF77S0Q05N>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-11-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214162050.660953-11-glider@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 05:20:17PM +0100, Alexander Potapenko wrote:
> KMSAN is going to use 3/4 of existing vmalloc space to hold the
> metadata, therefore we lower VMALLOC_END to make sure vmalloc() doesn't
> allocate past the first 1/4.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>

It might be worth adding an 'x86: ' prefix to the commit title, since this
specifically affects x86 headers.

Mark.

> ---
> Link: https://linux-review.googlesource.com/id/I9d8b7f0a88a639f1263bc693cbd5c136626f7efd
> ---
>  arch/x86/include/asm/pgtable_64_types.h | 41 ++++++++++++++++++++++++-
>  arch/x86/mm/init_64.c                   |  2 +-
>  2 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index 91ac106545703..7f15d43754a34 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -139,7 +139,46 @@ extern unsigned int ptrs_per_p4d;
>  # define VMEMMAP_START		__VMEMMAP_BASE_L4
>  #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
>  
> -#define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
> +#define VMEMORY_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
> +
> +#ifndef CONFIG_KMSAN
> +#define VMALLOC_END		VMEMORY_END
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
> +#define VMALLOC_QUARTER_SIZE	((VMALLOC_SIZE_TB << 40) >> 2)
> +#define VMALLOC_END		(VMALLOC_START + VMALLOC_QUARTER_SIZE - 1)
> +
> +/*
> + * vmalloc metadata addresses are calculated by adding shadow/origin offsets
> + * to vmalloc address.
> + */
> +#define KMSAN_VMALLOC_SHADOW_OFFSET	VMALLOC_QUARTER_SIZE
> +#define KMSAN_VMALLOC_ORIGIN_OFFSET	(VMALLOC_QUARTER_SIZE << 1)
> +
> +#define KMSAN_VMALLOC_SHADOW_START	(VMALLOC_START + KMSAN_VMALLOC_SHADOW_OFFSET)
> +#define KMSAN_VMALLOC_ORIGIN_START	(VMALLOC_START + KMSAN_VMALLOC_ORIGIN_OFFSET)
> +
> +/*
> + * The shadow/origin for modules are placed one by one in the last 1/4 of
> + * vmalloc space.
> + */
> +#define KMSAN_MODULES_SHADOW_START	(VMALLOC_END + KMSAN_VMALLOC_ORIGIN_OFFSET + 1)
> +#define KMSAN_MODULES_ORIGIN_START	(KMSAN_MODULES_SHADOW_START + MODULES_LEN)
> +#endif /* CONFIG_KMSAN */
>  
>  #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
>  /* The module sections ends with the start of the fixmap */
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 36098226a9573..8e884e44a8d1e 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1287,7 +1287,7 @@ static void __init preallocate_vmalloc_pages(void)
>  	unsigned long addr;
>  	const char *lvl;
>  
> -	for (addr = VMALLOC_START; addr <= VMALLOC_END; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
> +	for (addr = VMALLOC_START; addr <= VMEMORY_END; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
>  		pgd_t *pgd = pgd_offset_k(addr);
>  		p4d_t *p4d;
>  		pud_t *pud;
> -- 
> 2.34.1.173.g76aa8bc2d0-goog
> 
