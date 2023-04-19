Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7196E82B8
	for <lists+linux-arch@lfdr.de>; Wed, 19 Apr 2023 22:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjDSUaK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Apr 2023 16:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDSUaJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Apr 2023 16:30:09 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9BA8A45;
        Wed, 19 Apr 2023 13:29:29 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fb615ac3dso17398657b3.2;
        Wed, 19 Apr 2023 13:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681936166; x=1684528166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri4M7wwnqfUyWg7ITQYtSCFlkjwgDD80RYs577YrqxA=;
        b=WIB0Mw6mTuaRsirvoZFjheEp9yY5Y/q9onOHwXnfWFMdFmYyli6xaVNh9nuRkFM8Bu
         OnXLT3OfefylOw1YM4VwkunQfq+Wm/ji1lKG5q5iuDSnqXz+pveEOmagYUHY70pV+qoa
         KvVDM5rfvXh7k0t2ztxy0CpMZU4jrTcGpdw3ugWQ7PYvTc5DIMuci51oMb3/89hTRu18
         ASTMyUIpSKSpdVyzVJqnIsAfKfcTX+AN3kdlEImle/BVRj8WezpdfvQGOxxtdhWDpR5M
         v2CCX9NS0Q1nwilMdzeBzucKwgU44O+OvH3u0Wiv6qbWAvaUduq3fyhR1v2QD/zzuIcP
         d4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681936166; x=1684528166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri4M7wwnqfUyWg7ITQYtSCFlkjwgDD80RYs577YrqxA=;
        b=fA7oFQsGvJQ3i43IS74zb1MqMjTV0S1kZdt1hO4vfzpeVjFxxpX451Zvqx5htZ+wIN
         s+E+2j4fL31lgSXUvDx8uX2rZ27EtOFe8/uJf2wbKzs6xeFpiHxcjOz3ENgPeQ9mvYwc
         T+nn5liT0JubB3kNFfRVJqjn98Dk10oIdA46WWdihsonPquEYmQd6QRjwdN5xA5+v4N1
         pupMN5BtfCAARSzzvRoeN5gAk9rF4yQJ8iPB65SQD0dOoKde99sdq0QXGWsROtxUKlRg
         Zjg3mmViA4bdX1lcZ2IYjhBGLTQASbjCjFbz4oVgm1d6Dzfozk7dvJ1QwYe9LZxDY/aw
         KmRg==
X-Gm-Message-State: AAQBX9dkC3nKzMHk0XftNaIR8EqYFRKlJV/K8dzqTa2ojj33aE8GqedT
        tql5UMZPs0+4p32GbnyNMtI0gMm/UKizSpJSqzcoV7zJYb/jtw==
X-Google-Smtp-Source: AKy350aNDMALBM0VAdPN5cwgCAJgGmI7MyMPzfpEMhO/TACZWqeGBJUZoGoWlGr6ZHAaYh0Tzxhzwi/dxg7Fov1Ofog=
X-Received: by 2002:a81:53c2:0:b0:54e:84f6:6669 with SMTP id
 h185-20020a8153c2000000b0054e84f66669mr4502802ywb.49.1681936166163; Wed, 19
 Apr 2023 13:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230417205048.15870-1-vishal.moola@gmail.com>
 <20230417205048.15870-5-vishal.moola@gmail.com> <ZD/syK8RYO9FZ6ks@vernon-pc>
In-Reply-To: <ZD/syK8RYO9FZ6ks@vernon-pc>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Wed, 19 Apr 2023 13:29:14 -0700
Message-ID: <CAOzc2pyt8MBv7N0qizdxr0__RKXK7hMLX-Jqvsd6RPh3nyTFVw@mail.gmail.com>
Subject: Re: [PATCH 4/33] mm: add utility functions for ptdesc
To:     Vernon Yang <vernon2gm@gmail.com>
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

On Wed, Apr 19, 2023 at 6:34=E2=80=AFAM Vernon Yang <vernon2gm@gmail.com> w=
rote:
>
> On Mon, Apr 17, 2023 at 01:50:19PM -0700, Vishal Moola wrote:
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
> >  include/linux/pgtable.h   | 13 ++++++++++++
> >  3 files changed, 68 insertions(+)
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
> > index b18848ae7e22..ec3cbe2fa665 100644
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
> > +}
> > +
> > +static inline void *ptdesc_to_virt(struct ptdesc *pt)
> > +{
> > +     return page_to_virt(ptdesc_page(pt));
> > +}
> > +
> > +static inline void *ptdesc_address(struct ptdesc *pt)
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
> > index 7cc6ea057ee9..7cd803aa38eb 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -97,6 +97,19 @@ TABLE_MATCH(ptl, ptl);
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
> > +static inline struct ptdesc *page_ptdesc(struct page *page)
> > +{
> > +     return (struct ptdesc *)page;
> > +}
>
> Hi Vishal,
>
> I'm a little curious, why is the page_ptdesc() using inline functions ins=
tead of macro?
> If this is any magic, please tell me, thank you very much.

No magic here, I was mainly basing it off Matthew's netmem
series. I'm not too clear on when to use macros vs inlines
myself :/.

If there's a benefit to having it be a macro let me
know and I can make that change in v2.
