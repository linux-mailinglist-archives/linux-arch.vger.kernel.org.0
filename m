Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B8371132A
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbjEYSGR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbjEYSGD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 14:06:03 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F51723;
        Thu, 25 May 2023 11:05:18 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ba878d5e75fso1224376276.3;
        Thu, 25 May 2023 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685037879; x=1687629879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHz1MnM6TYYio2C+7LZLfrVXy67ugaabkk4Lxt+VEKA=;
        b=NoHSm+P+R3f9P1hTtI0Aa2538QwCPLtSoQPrBLURQdxmp107FQ1F0pBnbEQWwggzlT
         fiTACnc6uzA/OAWqwR1JVWYYICkwBDdnIXj4ERwntlgZc/Oij0dm8rv+0LrV+CltMo3B
         fKyXLHfkdRh4xQKVcMe8OCp5giU3Tnn12LZCznOtQl1pIuAziPLT4fePeWe5Cvh7ZNzP
         bRQ3kdfBju0tbpe4F8kOJL6Oz3PfBgKD+/0uu8kOUyKFxwwoV5gkGDAbnMcHEgSeCLSi
         HSGZ+QgYvXiydUgpNmaTWLnoPbGEK3dVe0T9hw+SN0OStPQTocdixTet+7JhvERZXcH+
         xYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685037879; x=1687629879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHz1MnM6TYYio2C+7LZLfrVXy67ugaabkk4Lxt+VEKA=;
        b=kUIH37ZAWo7fM0tUzfBZMlgH44Wsgrhc6w7VAtUWyNutx/AeQeNjByX2zcEMy3nrli
         mPkY74G9FtefHVHhKRE6XvMst+qXP+YsR6q5x0G1Jz90t2QRuN2J9ISmvGq3WOaICeto
         dEWQSfVQevXKS0Jv9dxwwDBxFHVAywPXpDiohN8EYvN1Bko8+0sxsY8S7Oi/xHgK9RjY
         852CwgToRHsWEDIxLGxk7B/3vCf4KUnO++s9ZquESY/dNnYAySXdYJiE8eFBVcp+l7C2
         N0jIIwnmjhA2fJNIsKqGWltZRaq5lU1HGhLB0kmoenfgJdh3/b9LvCP47eL4QPYosKF7
         9qyw==
X-Gm-Message-State: AC+VfDzNAwP8H4RdJLuLWEP1fEBW4VMdvr+66Fk57/kDE+16n/M6vepo
        Ni1QiIz4eSIlCaACRXwZU8UAecuPS2JgVDjeVwMF/VX+87c=
X-Google-Smtp-Source: ACHHUZ7leu3e42UYud7EgWJZoN6PW1XGYdS9PCBG/tq5rzS7YnuUSWzFoklHW8B2kAANtPb/IRvLBp1ufSDbPWAmKj4=
X-Received: by 2002:a25:7493:0:b0:ba8:15a3:f2e4 with SMTP id
 p141-20020a257493000000b00ba815a3f2e4mr4848492ybc.0.1685037879336; Thu, 25
 May 2023 11:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com> <20230525090956.GX4967@kernel.org>
In-Reply-To: <20230525090956.GX4967@kernel.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 25 May 2023 11:04:28 -0700
Message-ID: <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/34] mm: add utility functions for ptdesc
To:     Mike Rapoport <rppt@kernel.org>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25, 2023 at 2:10=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, May 01, 2023 at 12:28:00PM -0700, Vishal Moola (Oracle) wrote:
> > Introduce utility functions setting the foundation for ptdescs. These
> > will also assist in the splitting out of ptdesc from struct page.
> >
> > ptdesc_alloc() is defined to allocate new ptdesc pages as compound
> > pages. This is to standardize ptdescs by allowing for one allocation
> > and one free function, in contrast to 2 allocation and 2 free functions=
.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  include/asm-generic/tlb.h | 11 ++++++++++
> >  include/linux/mm.h        | 44 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/pgtable.h   | 12 +++++++++++
> >  3 files changed, 67 insertions(+)
> >
> > diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> > index b46617207c93..6bade9e0e799 100644
> > --- a/include/asm-generic/tlb.h
> > +++ b/include/asm-generic/tlb.h
> > @@ -481,6 +481,17 @@ static inline void tlb_remove_page(struct mmu_gath=
er *tlb, struct page *page)
> >       return tlb_remove_page_size(tlb, page, PAGE_SIZE);
> >  }
> >
> > +static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
> > +{
> > +     tlb_remove_table(tlb, pt);
> > +}
> > +
> > +/* Like tlb_remove_ptdesc, but for page-like page directories. */
> > +static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, stru=
ct ptdesc *pt)
> > +{
> > +     tlb_remove_page(tlb, ptdesc_page(pt));
> > +}
> > +
> >  static inline void tlb_change_page_size(struct mmu_gather *tlb,
> >                                                    unsigned int page_si=
ze)
> >  {
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index b18848ae7e22..258f3b730359 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2744,6 +2744,45 @@ static inline pmd_t *pmd_alloc(struct mm_struct =
*mm, pud_t *pud, unsigned long a
> >  }
> >  #endif /* CONFIG_MMU */
> >
> > +static inline struct ptdesc *virt_to_ptdesc(const void *x)
> > +{
> > +     return page_ptdesc(virt_to_head_page(x));
>
> Do we ever use compound pages for page tables?

Mips and s390 crst tables use multi-order (but not compound) pages.
The ptdesc api *should* change that, but until all the allocation/free path=
s
are changed it may cause problems.
Thanks for catching that, I'll change it in v3.

> > +}
> > +
> > +static inline void *ptdesc_to_virt(const struct ptdesc *pt)
> > +{
> > +     return page_to_virt(ptdesc_page(pt));
> > +}
> > +
> > +static inline void *ptdesc_address(const struct ptdesc *pt)
> > +{
> > +     return folio_address(ptdesc_folio(pt));
> > +}
> > +
> > +static inline bool ptdesc_is_reserved(struct ptdesc *pt)
> > +{
> > +     return folio_test_reserved(ptdesc_folio(pt));
> > +}
> > +
> > +static inline struct ptdesc *ptdesc_alloc(gfp_t gfp, unsigned int orde=
r)
> > +{
> > +     struct page *page =3D alloc_pages(gfp | __GFP_COMP, order);
> > +
> > +     return page_ptdesc(page);
> > +}
> > +
> > +static inline void ptdesc_free(struct ptdesc *pt)
> > +{
> > +     struct page *page =3D ptdesc_page(pt);
> > +
> > +     __free_pages(page, compound_order(page));
> > +}
>
> The ptdesc_{alloc,free} API does not sound right to me. The name
> ptdesc_alloc() implies the allocation of the ptdesc itself, rather than
> allocation of page table page. The same goes for free.

I'm not sure I see the difference. Could you elaborate?

> > +
> > +static inline void ptdesc_clear(void *x)
> > +{
> > +     clear_page(x);
> > +}
> > +
> >  #if USE_SPLIT_PTE_PTLOCKS
> >  #if ALLOC_SPLIT_PTLOCKS
> >  void __init ptlock_cache_init(void);
> > @@ -2970,6 +3009,11 @@ static inline void mark_page_reserved(struct pag=
e *page)
> >       adjust_managed_page_count(page, -1);
> >  }
> >
> > +static inline void free_reserved_ptdesc(struct ptdesc *pt)
> > +{
> > +     free_reserved_page(ptdesc_page(pt));
> > +}
> > +
> >  /*
> >   * Default method to free all the __init memory into the buddy system.
> >   * The freed pages will be poisoned with pattern "poison" if it's with=
in
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 5e0f51308724..b067ac10f3dd 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -1041,6 +1041,18 @@ TABLE_MATCH(ptl, ptl);
> >  #undef TABLE_MATCH
> >  static_assert(sizeof(struct ptdesc) <=3D sizeof(struct page));
> >
> > +#define ptdesc_page(pt)                      (_Generic((pt),          =
       \
> > +     const struct ptdesc *:          (const struct page *)(pt),      \
> > +     struct ptdesc *:                (struct page *)(pt)))
> > +
> > +#define ptdesc_folio(pt)             (_Generic((pt),                 \
> > +     const struct ptdesc *:          (const struct folio *)(pt),     \
> > +     struct ptdesc *:                (struct folio *)(pt)))
> > +
> > +#define page_ptdesc(p)                       (_Generic((p),           =
       \
> > +     const struct page *:            (const struct ptdesc *)(p),     \
> > +     struct page *:                  (struct ptdesc *)(p)))
> > +
> >  /*
> >   * No-op macros that just return the current protection value. Defined=
 here
> >   * because these macros can be used even if CONFIG_MMU is not defined.
> > --
> > 2.39.2
> >
> >
>
> --
> Sincerely yours,
> Mike.
