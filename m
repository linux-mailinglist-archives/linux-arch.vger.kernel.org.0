Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F92B719491
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 09:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjFAHoj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 1 Jun 2023 03:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjFAHmh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 03:42:37 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0737110CC;
        Thu,  1 Jun 2023 00:40:24 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-568928af8f5so9443097b3.1;
        Thu, 01 Jun 2023 00:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685605223; x=1688197223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Vy5gwXbACIYw+FA/+yi3OHDGD1kIURAtfeea/c7peI=;
        b=MXtZUSLN8cbjATgjlAJ9vAmeIzlXVy7iupF0PTCKFrw8acmi3JcT1VtVE/8vGrh2OK
         SdOWHyAZvXiBlW5dI6btWOSTWZSz7PFyBc3DAEqCWchERfKAfxIPhZ1ofT0cbYAcDShu
         mOZpc451rTZUyCtB4J25znh7d8y1NlWjwHRnnLbPcO9KunpAgoSexYvkcTL+BxMAgtob
         GLldu+1+FYebvrXDD4RDJCzLaIoweT7EOsywplDOz44/VajnIfod9vbSShNiTWoxhdyU
         SSFeyXBQgkf8x+a2vtVtsNXzhOU5mNXfsRDLqs3UgO+ZB9W7qol2g7T31sPnz71AP6I5
         Xzdw==
X-Gm-Message-State: AC+VfDw4+0QhiSWiV66tPV9Aj8YNsBHnfWh1HZeQpD/PF9B8Apkd/aX+
        Q7my6i5wpRMDihqvn0XkkhZcxF05md8rQg==
X-Google-Smtp-Source: ACHHUZ49BXjkr/FRB9hIFKfzLi0jJtK8aNJjrwykqWch00dqJsfmzTBaySBSGZ/S/6+clJol7GGTtw==
X-Received: by 2002:a81:92d6:0:b0:564:fb0a:abe9 with SMTP id j205-20020a8192d6000000b00564fb0aabe9mr1087191ywg.22.1685605222838;
        Thu, 01 Jun 2023 00:40:22 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id m129-20020a0de387000000b00561e83db519sm6085211ywe.3.2023.06.01.00.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 00:40:21 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so2796881276.0;
        Thu, 01 Jun 2023 00:40:21 -0700 (PDT)
X-Received: by 2002:a81:a041:0:b0:565:9f61:c771 with SMTP id
 x62-20020a81a041000000b005659f61c771mr1176431ywg.9.1685605221248; Thu, 01 Jun
 2023 00:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230531213032.25338-1-vishal.moola@gmail.com> <20230531213032.25338-26-vishal.moola@gmail.com>
In-Reply-To: <20230531213032.25338-26-vishal.moola@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Jun 2023 09:40:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCe=VsTJYNA_-k=JipeAGKzgBFjZ8i+XRK7U1DBei=7A@mail.gmail.com>
Message-ID: <CAMuHMdWCe=VsTJYNA_-k=JipeAGKzgBFjZ8i+XRK7U1DBei=7A@mail.gmail.com>
Subject: Re: [PATCH v3 25/34] m68k: Convert various functions to use ptdescs
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vishal,

On Wed, May 31, 2023 at 11:32 PM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
>
> Some of the functions use the *get*page*() helper functions. Convert
> these to use pagetable_alloc() and ptdesc_address() instead to help
> standardize page tables further.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Thanks for your patch!

> --- a/arch/m68k/include/asm/mcf_pgalloc.h
> +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> @@ -7,20 +7,19 @@
>
>  extern inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>  {
> -       free_page((unsigned long) pte);
> +       pagetable_free(virt_to_ptdesc(pte));
>  }
>
>  extern const char bad_pmd_string[];
>
>  extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  {
> -       unsigned long page = __get_free_page(GFP_DMA);
> +       struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA | __GFP_ZERO, 0);
>
> -       if (!page)
> +       if (!ptdesc)
>                 return NULL;
>
> -       memset((void *)page, 0, PAGE_SIZE);
> -       return (pte_t *) (page);
> +       return (pte_t *) (ptdesc_address(ptdesc));

No need to cast "void *" when returning a different pointer type.

>  }
>
>  extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
> @@ -35,36 +34,36 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
>  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
>                                   unsigned long address)
>  {
> -       struct page *page = virt_to_page(pgtable);
> +       struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
>
> -       pgtable_pte_page_dtor(page);
> -       __free_page(page);
> +       pagetable_pte_dtor(ptdesc);
> +       pagetable_free(ptdesc);
>  }
>
>  static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>  {
> -       struct page *page = alloc_pages(GFP_DMA, 0);
> +       struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA, 0);
>         pte_t *pte;
>
> -       if (!page)
> +       if (!ptdesc)
>                 return NULL;
> -       if (!pgtable_pte_page_ctor(page)) {
> -               __free_page(page);
> +       if (!pagetable_pte_ctor(ptdesc)) {
> +               pagetable_free(ptdesc);
>                 return NULL;
>         }
>
> -       pte = page_address(page);
> -       clear_page(pte);
> +       pte = ptdesc_address(ptdesc);
> +       pagetable_clear(pte);
>
>         return pte;
>  }
>
>  static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
>  {
> -       struct page *page = virt_to_page(pgtable);
> +       struct ptdesc *ptdesc = virt_to_ptdesc(ptdesc);

virt_to_ptdesc(pgtable)

(You can build this using m5475evb_defconfig)

>
> -       pgtable_pte_page_dtor(page);
> -       __free_page(page);
> +       pagetable_pte_dtor(ptdesc);
> +       pagetable_free(ptdesc);
>  }
>
>  /*
> @@ -75,16 +74,18 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
>
>  static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>  {
> -       free_page((unsigned long) pgd);
> +       pagetable_free(virt_to_ptdesc(pgd));
>  }
>
>  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
>         pgd_t *new_pgd;
> +       struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA | GFP_NOWARN, 0);
>
> -       new_pgd = (pgd_t *)__get_free_page(GFP_DMA | __GFP_NOWARN);
> -       if (!new_pgd)
> +       if (!ptdesc)
>                 return NULL;
> +       new_pgd = (pgd_t *) ptdesc_address(ptdesc);

No need to cast "void *" when assigning to a different pointer type.

> +
>         memcpy(new_pgd, swapper_pg_dir, PTRS_PER_PGD * sizeof(pgd_t));
>         memset(new_pgd, 0, PAGE_OFFSET >> PGDIR_SHIFT);
>         return new_pgd;

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
