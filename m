Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836986A51C1
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 04:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjB1DRZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 22:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1DRZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 22:17:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB63323132;
        Mon, 27 Feb 2023 19:17:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 719BD60FD4;
        Tue, 28 Feb 2023 03:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29CBC4339B;
        Tue, 28 Feb 2023 03:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677554242;
        bh=NElAjJZryg7JqzKiDR8hC0eEVOkhIJa3SMKpSyMnJPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CrxWV0qs/bnkl58pZool2aJVFtKcw/Q0uWRr07irmOendQ/16LRWgXEpQ273LM1XI
         Yc/MFZGMTq3FqTcvny5OSqZ+uQOgcIgBYSPc6u6+dB/zVuU7lYdLthMuD2+B6fjaKI
         fZaxsBKEh1GiyyBhexpbZ/YU60Ag+S+r0RxliIk0Us4/6pVHlVlPV50nZPsIYMc0Mf
         HafcTHfpR1Y1h8GT3dlVZ8UgHuOZJ3Axa1A6G+19K0kAJ+rXN1vjLNNB5ZLrA8BBNh
         ulEo5kCsRYZv389cHyzPLKBumdjeovZlvDMvAORBYbyh9eiFMPcpRlITKr5bj2FvYF
         yA8VxA7wXfXpg==
Received: by mail-ed1-f43.google.com with SMTP id eg37so34172947edb.12;
        Mon, 27 Feb 2023 19:17:22 -0800 (PST)
X-Gm-Message-State: AO0yUKWZXA20Tp/fBx7b/eR7aaiROhHxQJBvc8/ozsNXen3PCHqHhh0U
        noPgeYNE004Zq1FRVEdU4jg2MIeXLxTpJH06m0c=
X-Google-Smtp-Source: AK7set+bzZT0otZA1dOZY7LboCwv3Txnx/Swz/QBYMaC3LUaGbGKhbHB4c/PEyIMCRek7vw859XlE0k3OlADVcOemPk=
X-Received: by 2002:a17:906:aac1:b0:87b:fa21:7953 with SMTP id
 kt1-20020a170906aac100b0087bfa217953mr431807ejb.8.1677554241057; Mon, 27 Feb
 2023 19:17:21 -0800 (PST)
MIME-Version: 1.0
References: <20230227175741.71216-1-willy@infradead.org> <20230227175741.71216-9-willy@infradead.org>
In-Reply-To: <20230227175741.71216-9-willy@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 28 Feb 2023 11:17:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRXsnZdJBKJGAwvsNstUGRgwi=uW2Zz13PgHUg5g5hNSA@mail.gmail.com>
Message-ID: <CAJF2gTRXsnZdJBKJGAwvsNstUGRgwi=uW2Zz13PgHUg5g5hNSA@mail.gmail.com>
Subject: Re: [PATCH v2 08/30] csky: Implement the new page table range API
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For csky part

Acked-by: Guo Ren <guoren@kernel.org>

On Tue, Feb 28, 2023 at 1:57=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
> Change the PG_dcache_clean flag from being per-page to per-folio.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> ---
>  arch/csky/abiv1/cacheflush.c         | 32 +++++++++++++++++-----------
>  arch/csky/abiv1/inc/abi/cacheflush.h |  2 ++
>  arch/csky/abiv2/cacheflush.c         | 30 +++++++++++++-------------
>  arch/csky/abiv2/inc/abi/cacheflush.h | 10 +++++++--
>  arch/csky/include/asm/pgtable.h      | 21 +++++++++++++++---
>  5 files changed, 62 insertions(+), 33 deletions(-)
>
> diff --git a/arch/csky/abiv1/cacheflush.c b/arch/csky/abiv1/cacheflush.c
> index fb91b069dc69..ba43f6c26b4f 100644
> --- a/arch/csky/abiv1/cacheflush.c
> +++ b/arch/csky/abiv1/cacheflush.c
> @@ -14,43 +14,49 @@
>
>  #define PG_dcache_clean                PG_arch_1
>
> -void flush_dcache_page(struct page *page)
> +void flush_dcache_folio(struct folio *folio)
>  {
>         struct address_space *mapping;
>
> -       if (page =3D=3D ZERO_PAGE(0))
> +       if (is_zero_pfn(folio_pfn(folio)))
>                 return;
>
> -       mapping =3D page_mapping_file(page);
> +       mapping =3D folio_flush_mapping(folio);
>
> -       if (mapping && !page_mapcount(page))
> -               clear_bit(PG_dcache_clean, &page->flags);
> +       if (mapping && !folio_mapped(folio))
> +               clear_bit(PG_dcache_clean, &folio->flags);
>         else {
>                 dcache_wbinv_all();
>                 if (mapping)
>                         icache_inv_all();
> -               set_bit(PG_dcache_clean, &page->flags);
> +               set_bit(PG_dcache_clean, &folio->flags);
>         }
>  }
> +EXPORT_SYMBOL(flush_dcache_folio);
> +
> +void flush_dcache_page(struct page *page)
> +{
> +       flush_dcache_folio(page_folio(page));
> +}
>  EXPORT_SYMBOL(flush_dcache_page);
>
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
> -       pte_t *ptep)
> +void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long ad=
dr,
> +               pte_t *ptep, unsigned int nr)
>  {
>         unsigned long pfn =3D pte_pfn(*ptep);
> -       struct page *page;
> +       struct folio *folio;
>
>         if (!pfn_valid(pfn))
>                 return;
>
> -       page =3D pfn_to_page(pfn);
> -       if (page =3D=3D ZERO_PAGE(0))
> +       if (is_zero_pfn(pfn))
>                 return;
>
> -       if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> +       folio =3D page_folio(pfn_to_page(pfn));
> +       if (!test_and_set_bit(PG_dcache_clean, &folio->flags))
>                 dcache_wbinv_all();
>
> -       if (page_mapping_file(page)) {
> +       if (folio_flush_mapping(folio)) {
>                 if (vma->vm_flags & VM_EXEC)
>                         icache_inv_all();
>         }
> diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/a=
bi/cacheflush.h
> index ed62e2066ba7..0d6cb65624c4 100644
> --- a/arch/csky/abiv1/inc/abi/cacheflush.h
> +++ b/arch/csky/abiv1/inc/abi/cacheflush.h
> @@ -9,6 +9,8 @@
>
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>  extern void flush_dcache_page(struct page *);
> +void flush_dcache_folio(struct folio *);
> +#define flush_dcache_folio flush_dcache_folio
>
>  #define flush_cache_mm(mm)                     dcache_wbinv_all()
>  #define flush_cache_page(vma, page, pfn)       cache_wbinv_all()
> diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
> index 39c51399dd81..c1cf0d55a2a1 100644
> --- a/arch/csky/abiv2/cacheflush.c
> +++ b/arch/csky/abiv2/cacheflush.c
> @@ -6,30 +6,30 @@
>  #include <linux/mm.h>
>  #include <asm/cache.h>
>
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
> -                     pte_t *pte)
> +void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long ad=
dress,
> +               pte_t *pte, unsigned int nr)
>  {
> -       unsigned long addr;
> +       unsigned long pfn =3D pte_pfn(*pte);
>         struct page *page;
> +       unsigned int i;
>
> -       if (!pfn_valid(pte_pfn(*pte)))
> +       if (!pfn_valid(pfn) || is_zero_pfn(pfn))
>                 return;
>
> -       page =3D pfn_to_page(pte_pfn(*pte));
> -       if (page =3D=3D ZERO_PAGE(0))
> -               return;
> +       folio =3D page_folio(pfn_to_page(pfn));
>
> -       if (test_and_set_bit(PG_dcache_clean, &page->flags))
> +       if (test_and_set_bit(PG_dcache_clean, &folio->flags))
>                 return;
>
> -       addr =3D (unsigned long) kmap_atomic(page);
> -
> -       dcache_wb_range(addr, addr + PAGE_SIZE);
> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> +               unsigned long addr =3D (unsigned long) kmap_local_folio(f=
olio,
> +                                                               i * PAGE_=
SIZE);
>
> -       if (vma->vm_flags & VM_EXEC)
> -               icache_inv_range(addr, addr + PAGE_SIZE);
> -
> -       kunmap_atomic((void *) addr);
> +               dcache_wb_range(addr, addr + PAGE_SIZE);
> +               if (vma->vm_flags & VM_EXEC)
> +                       icache_inv_range(addr, addr + PAGE_SIZE);
> +               kunmap_local((void *) addr);
> +       }
>  }
>
>  void flush_icache_deferred(struct mm_struct *mm)
> diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/a=
bi/cacheflush.h
> index a565e00c3f70..9c728933a776 100644
> --- a/arch/csky/abiv2/inc/abi/cacheflush.h
> +++ b/arch/csky/abiv2/inc/abi/cacheflush.h
> @@ -18,11 +18,17 @@
>
>  #define PG_dcache_clean                PG_arch_1
>
> +static inline void flush_dcache_folio(struct folio *folio)
> +{
> +       if (test_bit(PG_dcache_clean, &folio->flags))
> +               clear_bit(PG_dcache_clean, &folio->flags);
> +}
> +#define flush_dcache_folio flush_dcache_folio
> +
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>  static inline void flush_dcache_page(struct page *page)
>  {
> -       if (test_bit(PG_dcache_clean, &page->flags))
> -               clear_bit(PG_dcache_clean, &page->flags);
> +       flush_dcache_folio(page_folio(page));
>  }
>
>  #define flush_dcache_mmap_lock(mapping)                do { } while (0)
> diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgta=
ble.h
> index d4042495febc..a30ae048233e 100644
> --- a/arch/csky/include/asm/pgtable.h
> +++ b/arch/csky/include/asm/pgtable.h
> @@ -90,7 +90,20 @@ static inline void set_pte(pte_t *p, pte_t pte)
>         /* prevent out of order excution */
>         smp_mb();
>  }
> -#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
> +
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +               pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +       for (;;) {
> +               set_pte(ptep, pte);
> +               if (--nr =3D=3D 0)
> +                       break;
> +               ptep++;
> +               pte_val(pte) +=3D PAGE_SIZE;
> +       }
> +}
> +
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
>
>  static inline pte_t *pmd_page_vaddr(pmd_t pmd)
>  {
> @@ -263,8 +276,10 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t n=
ewprot)
>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>  extern void paging_init(void);
>
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
> -                     pte_t *pte);
> +void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long ad=
dress,
> +               pte_t *pte, unsigned int nr);
> +#define update_mmu_cache(vma, addr, ptep) \
> +       update_mmu_cache_range(vma, addr, ptep, 1)
>
>  #define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
>         remap_pfn_range(vma, vaddr, pfn, size, prot)
> --
> 2.39.1
>


--=20
Best Regards
 Guo Ren
