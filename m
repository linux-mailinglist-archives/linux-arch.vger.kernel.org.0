Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC0839EF24
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 08:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFHHBD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 03:01:03 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:34685 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFHHBD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jun 2021 03:01:03 -0400
Received: by mail-vs1-f44.google.com with SMTP id q2so2934789vsr.1;
        Mon, 07 Jun 2021 23:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+FZhDB5g+zrC7pU7NdoL3gO/mOIESA4Y/Utk2Yrzo0M=;
        b=NvfXJUbbLSGU718P0YPLgPztu2uiWzB/vehF0IeReh1ZwCPgvc/09vYgqrrtvW18Gx
         DJeGkwgkzi3X+4QikyL9tmp8YtI+X0CBa3sWX4IgUWPAQ2PKg2pRqCt8Hiwd3zEeUQJy
         F2QxxtDFJ01qGT8arvLcaWFHWMXqCIavTOL2ZUURILQLUanlg6/eO3v9oohZIPJWbMp1
         7SLpbO9dbHleDkstQImlfu7Zwq9/GeL85aXLjP1zc9GzMlVpqWqm1+kegYIg8sdfQ8EE
         vgOw+Us+W8YjgY2n+aAKQDJo0rAPEovRNV53tDc99Nwx9xaqzqhxsB0+on8apOighcN7
         NF2w==
X-Gm-Message-State: AOAM5308i+KxuYn6Fwmy8aw+JVEnOdIbWcKPxT3/qv2jiMkmSYS2G8hJ
        npaCk5I5U///use82aDjQBX4Kqu5OhykA4VnwgY=
X-Google-Smtp-Source: ABdhPJz+kLqwZnPCS0BrIEbrML2xAox56vYXpHSSbBiyrAEZD83tbPAAws3L+b0gWUN+eb7OrpWA3ibw2diJNui3SYU=
X-Received: by 2002:a05:6102:c4c:: with SMTP id y12mr7383918vss.18.1623135534863;
 Mon, 07 Jun 2021 23:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <1623130327-13325-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1623130327-13325-1-git-send-email-anshuman.khandual@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Jun 2021 08:58:43 +0200
Message-ID: <CAMuHMdWVrUgfXAud_3fpjfO-1yqXzf75Jtk6SNqqcR39-ZzQJA@mail.gmail.com>
Subject: Re: [PATCH] mm/thp: Define default pmd_pgtable()
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Hu <nickhu@andestech.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Zankel <chris@zankel.net>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anshuman,

On Tue, Jun 8, 2021 at 7:31 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> Currently most platforms define pmd_pgtable() as pmd_page() duplicating the
> same code all over. Instead just define a default value i.e pmd_page() for
> pmd_pgtable() and let platforms override when required via <asm/pgtable.h>.
> All the existing platform that override pmd_pgtable() have been moved into
> their respective <asm/pgtable.h> header in order to precede before the new
> generic definition. This makes it much cleaner with reduced code.

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks for your patch!

> This patch has been built tested across multiple platforms. But the m68k
> changes in particular might not be optimal, followed the existing switch
> from (arch/m68k/include/asm/pgalloc.h).

Indeed.  Why not move them to the existing
arch/m68k/asm/{sun3,mcf,motorola}_pgtable.h>, instead of introducing
yet another #if/#elif/#else/#endif block?

> --- a/arch/m68k/include/asm/mcf_pgalloc.h
> +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> @@ -32,8 +32,6 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
>
>  #define pmd_populate_kernel pmd_populate
>
> -#define pmd_pgtable(pmd) pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT)
> -
>  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
>                                   unsigned long address)
>  {
> diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
> index b4fc3b4f6bb3..74a817d9387f 100644
> --- a/arch/m68k/include/asm/motorola_pgalloc.h
> +++ b/arch/m68k/include/asm/motorola_pgalloc.h
> @@ -88,7 +88,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page
>  {
>         pmd_set(pmd, page);
>  }
> -#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
>
>  static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
>  {
> diff --git a/arch/m68k/include/asm/pgtable.h b/arch/m68k/include/asm/pgtable.h
> index ad15d655a9bf..7be5e5e712b2 100644
> --- a/arch/m68k/include/asm/pgtable.h
> +++ b/arch/m68k/include/asm/pgtable.h
> @@ -4,3 +4,12 @@
>  #else
>  #include <asm/pgtable_mm.h>
>  #endif
> +
> +
> +#if defined(CONFIG_COLDFIRE)
> +#define pmd_pgtable(pmd) pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT)
> +#elif defined(CONFIG_SUN3)
> +#define pmd_pgtable(pmd) pmd_page(pmd)
> +#else
> +#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
> +#endif
> diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
> index 000f64869b91..198036aff519 100644
> --- a/arch/m68k/include/asm/sun3_pgalloc.h
> +++ b/arch/m68k/include/asm/sun3_pgalloc.h
> @@ -32,7 +32,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page
>  {
>         pmd_val(*pmd) = __pa((unsigned long)page_address(page));
>  }
> -#define pmd_pgtable(pmd) pmd_page(pmd)
>
>  /*
>   * allocating and freeing a pmd is trivial: the 1-entry pmd is

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
