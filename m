Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214AC11437F
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2019 16:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfLEP1K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Dec 2019 10:27:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44650 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEP1K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Dec 2019 10:27:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id x3so2876123oto.11;
        Thu, 05 Dec 2019 07:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BzeWlAHVU2HltvIFrP0fsFnUxdM4qbyfP8pavgfcc7w=;
        b=rAQvSKU3K8tKj0s5kNllYLui0AYu7uw0hsEXoaczmhFqiGIWmAwrq1CPWY4nYlUHra
         3gmOZ4vvkuEOfPmIY0h9LWmUiVnmOvC1/o8vdpiCWOlN9HoRZCkyUht17tPyv7WQKmsZ
         4W61py++43aGKPrNxL3Mv0W4qsE27R3VFDFrgwqTZPK2d3WShpp9u5JL0XcIdyIkDGWn
         j2TVOkDY8mBD8zBxhG72oJnYTjVvcZBhcv80Zp8jwLJ1hLV9j1Rp0Mh3owvQw68X4alZ
         Hlr+IxG9cKUB8AP3kcQAyOryl3kTTDlBGUjHeXi7vGZQk0cCOZmW2CZrdyUhLJBnUXhU
         T89w==
X-Gm-Message-State: APjAAAWNm7s1GI1ZMFwRM6mrbg/kofCIE078fRAi2e49zX4GBsDHVZ1j
        yoEu4TU34WCe25mR3tTwBGjFQh4IF/L4J1ypapQ=
X-Google-Smtp-Source: APXvYqwHCmPlfMrZYZj+ql/m9hWI+YZzgBndE9T9km42bN1m86N9jZu3XfoBgpqFZvcdKfpjvilVI7g5aPfn4CHsDqQ=
X-Received: by 2002:a05:6830:91:: with SMTP id a17mr6542243oto.107.1575559629333;
 Thu, 05 Dec 2019 07:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20190219103148.192029670@infradead.org> <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net> <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
 <20191204133454.GW2844@hirez.programming.kicks-ass.net> <CAMuHMdVnhNFBqPQXKYCQbCnoQjZPSXRkuxbsbaguZ7_TcXXmVg@mail.gmail.com>
 <20191204164143.GB2810@hirez.programming.kicks-ass.net>
In-Reply-To: <20191204164143.GB2810@hirez.programming.kicks-ass.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 5 Dec 2019 16:26:57 +0100
Message-ID: <CAMuHMdVQO6vMDuns7rwk8sD+cPhEVQjEU_DiKiTQn0NY2ppzag@mail.gmail.com>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hoi Peter,

On Wed, Dec 4, 2019 at 5:42 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Dec 04, 2019 at 04:07:53PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Dec 4, 2019 at 2:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > Does this fare better?
> >
> > Yes. Migo-R is happy again.
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > --- a/arch/sh/include/asm/pgalloc.h
> > > +++ b/arch/sh/include/asm/pgalloc.h
> > > @@ -36,9 +36,7 @@ do {                                                  \
> > >  #if CONFIG_PGTABLE_LEVELS > 2
> > >  #define __pmd_free_tlb(tlb, pmdp, addr)                        \
> > >  do {                                                   \
> > > -       struct page *page = virt_to_page(pmdp);         \
> > > -       pgtable_pmd_page_dtor(page);                    \
> > > -       tlb_remove_page((tlb), page);                   \
> > > +       pmd_free((tlb)->mm, (pmdp));                    \
> > >  } while (0);
> > >  #endif
>
> OK, so I was going to write a Changelog to go with that, but then I
> realized that while this works and is similar to before the patch, I'm
> not sure this is in fact correct.
>
> With this on (and also before) we're freeing the PMD before we've done
> the TLB invalidate, that seems wrong!
>
> Looking at the size of that pmd_cache, that looks to be 30-(12+12-3)+3
> == 12, which is exactly 1 page, for PAGE_SIZE_4K, less for the larger
> pages.
>
> I'm thinking perhaps we should do something like the below instead?

Your advice is better when in close vicinity of an SH cross compiler,
though ;-)

> --- a/arch/sh/mm/pgtable.c
> +++ b/arch/sh/mm/pgtable.c
> @@ -5,9 +5,6 @@
>  #define PGALLOC_GFP GFP_KERNEL | __GFP_ZERO
>
>  static struct kmem_cache *pgd_cachep;
> -#if PAGETABLE_LEVELS > 2
> -static struct kmem_cache *pmd_cachep;
> -#endif
>
>  void pgd_ctor(void *x)
>  {
> @@ -23,11 +20,6 @@ void pgtable_cache_init(void)
>         pgd_cachep = kmem_cache_create("pgd_cache",
>                                        PTRS_PER_PGD * (1<<PTE_MAGNITUDE),
>                                        PAGE_SIZE, SLAB_PANIC, pgd_ctor);
> -#if PAGETABLE_LEVELS > 2
> -       pmd_cachep = kmem_cache_create("pmd_cache",
> -                                      PTRS_PER_PMD * (1<<PTE_MAGNITUDE),
> -                                      PAGE_SIZE, SLAB_PANIC, NULL);
> -#endif
>  }
>
>  pgd_t *pgd_alloc(struct mm_struct *mm)
> @@ -48,11 +40,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
>
>  pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
> -       return kmem_cache_alloc(pmd_cachep, PGALLOC_GFP);
> -}
> -
> -void pmd_free(struct mm_struct *mm, pmd_t *pmd)

mm/memory.o: In function `__pmd_alloc':
memory.c:(.text+0x1d74): undefined reference to `pmd_free'

> -{
> -       kmem_cache_free(pmd_cachep, pmd);
> +       BUILD_BUG_ON(PTRS_PER_PMD * (1<<PTE_MAGNITUDE) <= PAGE_SIZE);

... > PAGE_SIZE ?

Else it triggers all the time.

> +       return (pmd_t *)__get_free_page(PGALLOC_GFP);
>  }
>  #endif /* PAGETABLE_LEVELS > 2 */

BTW, I'm still running Willy's fix that never made it upstream
to kill an ugly boot warning, which also touches this code:
https://patchwork.kernel.org/patch/10549883/#22166333

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
