Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D62171137A
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 20:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbjEYSR2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjEYSR1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 14:17:27 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13330D9;
        Thu, 25 May 2023 11:17:26 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9daef8681fso766668276.1;
        Thu, 25 May 2023 11:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685038645; x=1687630645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEt/V8+3jpKdaWf/91twz9m1AxbB8mw1sieW7q1FOX4=;
        b=qpx33W23LxzGgtt7x0f+jHNiqnq/vW7f+lo4R60odkrqHHbvAvDFwCToA7ZeGOtlZu
         1pix82nq+XRaSlrOoV5XSSn7dUtYbrVRPJSVcc+Y0QUEIud/VeliblGAWTefKuC3uiLW
         Y767SW9acPu7TamxQ3rDZ7ad1waallUvH2KGWMSoPdMgQ6uqByETyo++E8JgCnYWaIR7
         T+3+xQi6fbJlgvqxHEFBxTPhg1oh030qaBtpvB360U8uoO6SqTXFxFoolc38s3Jd+HWF
         qSuZfJvCEliq2Q2QxhelaN+CYntsdlTkVUzhuGY+pHQjjIlm9D34YIwBuMF1/x8S1rOB
         qR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038645; x=1687630645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEt/V8+3jpKdaWf/91twz9m1AxbB8mw1sieW7q1FOX4=;
        b=GYx8Vc6Qyadtv52ZSRC1OpNQJOXQJ3a9QlpsNbv0Wl5bOH3MasYZx+fdpWz6yovU28
         cK+lZ6pmJj8CR2CsFNMhwvFZvnnsOPUUE8RU3viIfOUieadTSqgkhShmmtQ05hGF9u7m
         Hycf/ryemTt+RR0i1XrAIsI5x9ZT20r0z94IZaeM6A+saY6xHcepLVZGO4aOKItNWovJ
         ir982uyT4S7KaKDZYYZsMvzu44Mme52jKcEAsqHKAYyrWM2XVpGGjLBzAxaRlKcZF3l8
         i3ZEdC1KTlwBKMqnvWxvuTkb6zQzVZKlYs5XOq9NzhwvqtHf6fQKw7l1adPXcw+lbjSk
         O0oQ==
X-Gm-Message-State: AC+VfDzS8nTuROnl9ViiaFP8mNzAbhqJO6XLAcEJSgmaE6emoLIjFG0h
        m+8Lkay510cSCS0esr3uXlkmcXSxvCQirsrSN3k=
X-Google-Smtp-Source: ACHHUZ4CxdCafEVA2N8+YE3r54vbJuyNv4iSvWQn7ibpFdu7Q8YcRob13nPjv7XKdbKB6AoaGk0hrDu/6J2TDu7u8Qo=
X-Received: by 2002:a25:ac6:0:b0:ba7:bb4c:7960 with SMTP id
 189-20020a250ac6000000b00ba7bb4c7960mr4320550ybk.26.1685038645132; Thu, 25
 May 2023 11:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-14-vishal.moola@gmail.com> <20230525091900.GY4967@kernel.org>
In-Reply-To: <20230525091900.GY4967@kernel.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 25 May 2023 11:17:14 -0700
Message-ID: <CAOzc2pxNRbohxxNnaKtBNOBgOschHMj278-6hWZK9A1oJOgujA@mail.gmail.com>
Subject: Re: [PATCH v2 13/34] mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25, 2023 at 2:19=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, May 01, 2023 at 12:28:08PM -0700, Vishal Moola (Oracle) wrote:
> > Creates ptdesc_pte_ctor(), ptdesc_pmd_ctor(), ptdesc_pte_dtor(), and
> > ptdesc_pmd_dtor() and make the original pgtable constructor/destructors
> > wrappers.
>
> I think pgtable_pXY_ctor/dtor names would be better.

I have it as ptdesc to keep it consistent with the rest of the functions. I
also think it makes more sense as it's initializing stuff tracked by a ptde=
sc.

> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  include/linux/mm.h | 56 ++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 42 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 58c911341a33..dc61aeca9077 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2847,20 +2847,34 @@ static inline bool ptlock_init(struct ptdesc *p=
tdesc) { return true; }
> >  static inline void ptlock_free(struct ptdesc *ptdesc) {}
> >  #endif /* USE_SPLIT_PTE_PTLOCKS */
> >
> > -static inline bool pgtable_pte_page_ctor(struct page *page)
> > +static inline bool ptdesc_pte_ctor(struct ptdesc *ptdesc)
> >  {
> > -     if (!ptlock_init(page_ptdesc(page)))
> > +     struct folio *folio =3D ptdesc_folio(ptdesc);
> > +
> > +     if (!ptlock_init(ptdesc))
> >               return false;
> > -     __SetPageTable(page);
> > -     inc_lruvec_page_state(page, NR_PAGETABLE);
> > +     __folio_set_table(folio);
> > +     lruvec_stat_add_folio(folio, NR_PAGETABLE);
> >       return true;
> >  }
> >
> > +static inline bool pgtable_pte_page_ctor(struct page *page)
> > +{
> > +     return ptdesc_pte_ctor(page_ptdesc(page));
> > +}
> > +
> > +static inline void ptdesc_pte_dtor(struct ptdesc *ptdesc)
> > +{
> > +     struct folio *folio =3D ptdesc_folio(ptdesc);
> > +
> > +     ptlock_free(ptdesc);
> > +     __folio_clear_table(folio);
> > +     lruvec_stat_sub_folio(folio, NR_PAGETABLE);
> > +}
> > +
> >  static inline void pgtable_pte_page_dtor(struct page *page)
> >  {
> > -     ptlock_free(page_ptdesc(page));
> > -     __ClearPageTable(page);
> > -     dec_lruvec_page_state(page, NR_PAGETABLE);
> > +     ptdesc_pte_dtor(page_ptdesc(page));
> >  }
> >
> >  #define pte_offset_map_lock(mm, pmd, address, ptlp)  \
> > @@ -2942,20 +2956,34 @@ static inline spinlock_t *pmd_lock(struct mm_st=
ruct *mm, pmd_t *pmd)
> >       return ptl;
> >  }
> >
> > -static inline bool pgtable_pmd_page_ctor(struct page *page)
> > +static inline bool ptdesc_pmd_ctor(struct ptdesc *ptdesc)
> >  {
> > -     if (!pmd_ptlock_init(page_ptdesc(page)))
> > +     struct folio *folio =3D ptdesc_folio(ptdesc);
> > +
> > +     if (!pmd_ptlock_init(ptdesc))
> >               return false;
> > -     __SetPageTable(page);
> > -     inc_lruvec_page_state(page, NR_PAGETABLE);
> > +     __folio_set_table(folio);
> > +     lruvec_stat_add_folio(folio, NR_PAGETABLE);
> >       return true;
> >  }
> >
> > +static inline bool pgtable_pmd_page_ctor(struct page *page)
> > +{
> > +     return ptdesc_pmd_ctor(page_ptdesc(page));
> > +}
> > +
> > +static inline void ptdesc_pmd_dtor(struct ptdesc *ptdesc)
> > +{
> > +     struct folio *folio =3D ptdesc_folio(ptdesc);
> > +
> > +     pmd_ptlock_free(ptdesc);
> > +     __folio_clear_table(folio);
> > +     lruvec_stat_sub_folio(folio, NR_PAGETABLE);
> > +}
> > +
> >  static inline void pgtable_pmd_page_dtor(struct page *page)
> >  {
> > -     pmd_ptlock_free(page_ptdesc(page));
> > -     __ClearPageTable(page);
> > -     dec_lruvec_page_state(page, NR_PAGETABLE);
> > +     ptdesc_pmd_dtor(page_ptdesc(page));
> >  }
> >
> >  /*
> > --
> > 2.39.2
> >
> >
>
> --
> Sincerely yours,
> Mike.
