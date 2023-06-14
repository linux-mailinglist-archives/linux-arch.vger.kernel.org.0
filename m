Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41BA72F93A
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 11:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbjFNJap convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 14 Jun 2023 05:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbjFNJaU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 05:30:20 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219711FF0;
        Wed, 14 Jun 2023 02:30:19 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-57001c0baddso5177207b3.2;
        Wed, 14 Jun 2023 02:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686735018; x=1689327018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUg4qrNPX3u1L7teHyX+L+B+2nv6pGpY1jj7jQmio6E=;
        b=HLaZwbSHm2RAUuRjN/mLmJpriec5nmc+q8fBgtHGJ40vcMlDF8+MTWfoIhQhqjnHMO
         Ckm91+jl1x7OHreSE7ETBeAqZagNZDTg1b3Zgch2N3y2FJcoyKkv0MvJAb+yFsaXw/hB
         2Fu0w7Vd3uH68ichY92zSNgoi6iS3FHrQOBy6qpDOEtmjvm2DWy2lyAcgS+JPlBcHgvO
         HUXi8XRtvUfIMDqOYW4gEppz5mrakbAFk6DSk+DDHZbceCO3+hc2gXVwa+SwuS/0AS8z
         SgfHEIZ6qQOIe4OmKsY5GYMW9YUI59Nwpod/hqOA2JDX0rvWkWqekueBYcLkkKOaNlRl
         iyww==
X-Gm-Message-State: AC+VfDwK0yjybGgEgvktGtZXCQlnhPB1kaBKPT9Sx30og7gV/63Lf1jo
        WmgxqFUZEHBbtVhHpbCpzeelL6Qwv1k42w==
X-Google-Smtp-Source: ACHHUZ5BS+Ccv/S1DfqmwwsAY9Irz8IspsCd9IYZqxmz3HQslBY2kdJscpPFhVoRxVIQmCSGDkWvCA==
X-Received: by 2002:a25:9248:0:b0:bb1:5628:59ee with SMTP id e8-20020a259248000000b00bb1562859eemr1357582ybo.28.1686735018147;
        Wed, 14 Jun 2023 02:30:18 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u18-20020a5b04d2000000b00bab9a67a4cesm3405967ybp.29.2023.06.14.02.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 02:30:17 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bc4ed01b5d4so407378276.1;
        Wed, 14 Jun 2023 02:30:17 -0700 (PDT)
X-Received: by 2002:a25:6b47:0:b0:ba8:2009:ccbb with SMTP id
 o7-20020a256b47000000b00ba82009ccbbmr1338474ybm.46.1686735017346; Wed, 14 Jun
 2023 02:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-28-vishal.moola@gmail.com> <e52c7a74-da68-08d2-54e2-f95a8c5b52e7@kernel.org>
In-Reply-To: <e52c7a74-da68-08d2-54e2-f95a8c5b52e7@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Jun 2023 11:30:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXPASfLM8St_JZOW3Wke+ickJoo1oDr+orRbTERy=Zgwg@mail.gmail.com>
Message-ID: <CAMuHMdXPASfLM8St_JZOW3Wke+ickJoo1oDr+orRbTERy=Zgwg@mail.gmail.com>
Subject: Re: [PATCH v4 27/34] nios2: Convert __pte_free_tlb() to use ptdescs
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dinh,

On Wed, Jun 14, 2023 at 12:17 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
> On 6/12/23 16:04, Vishal Moola (Oracle) wrote:
> > Part of the conversions to replace pgtable constructor/destructors with
> > ptdesc equivalents.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >   arch/nios2/include/asm/pgalloc.h | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
> > index ecd1657bb2ce..ce6bb8e74271 100644
> > --- a/arch/nios2/include/asm/pgalloc.h
> > +++ b/arch/nios2/include/asm/pgalloc.h
> > @@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
> >
> >   extern pgd_t *pgd_alloc(struct mm_struct *mm);
> >
> > -#define __pte_free_tlb(tlb, pte, addr)                               \
> > -     do {                                                    \
> > -             pgtable_pte_page_dtor(pte);                     \
> > -             tlb_remove_page((tlb), (pte));                  \
> > +#define __pte_free_tlb(tlb, pte, addr)                                       \
> > +     do {                                                            \
> > +             pagetable_pte_dtor(page_ptdesc(pte));                   \
> > +             tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
> >       } while (0)
> >
> >   #endif /* _ASM_NIOS2_PGALLOC_H */
>
> Applied!

I don't think you can just apply this patch, as the new functions
were only introduced in [PATCH v4 05/34] of this series.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
