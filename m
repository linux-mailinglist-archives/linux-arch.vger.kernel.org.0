Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C550A6BD5AA
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 17:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCPQcq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 16 Mar 2023 12:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCPQcn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 12:32:43 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25759E4851;
        Thu, 16 Mar 2023 09:32:34 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id ek9so2332462qtb.10;
        Thu, 16 Mar 2023 09:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678984353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgcdy0Q2UM92NkuqSo6yI/I4/kIvBnyOPq4TXfCrfno=;
        b=Qa3hJdzBoR4QYJJtno3arPI+S2Wxh7Rd3C9o56ANs28yusuvEn9MEmEZ4OSvf7DzWa
         neURxvse8Q39uYWulzDgoR516t4rUy8ftB6dv1+CyBhv4B5BAMAJcCASg1Pw6Btv6R3u
         gdUxLTiYYEuo38I5hfJ+T9mt4JF/hysmbyLDPsx97snV5sshkMf8eV7UbWNGO5C7IBPD
         +8EIEklTsIkjtaqZ+gAivxR1kswqjctunECJR8wuNTY7pJ0VgT6Moti7b/3C2+PTyQA2
         MCmkw4pxehMI/kOr1U+Ez5ezjAFqh7L6Ap1dPQzss+gqfr1hf4IBHPWgGoqgHtolqsj7
         earg==
X-Gm-Message-State: AO0yUKW7aF2lckk8JDldII+cM5isEnhwkoE7hROcSYhtrl1WPPUCyP6G
        Pf8eizgw2RWKEBKs99XLJ4Ue+fW3CfV1pQ==
X-Google-Smtp-Source: AK7set9Wv4ugIhggJpuKBizqjeJ5SkN0g1xYAveDgtt8SHTljENN7L1ucVv5pH/VzAMbRrlvsI7XYA==
X-Received: by 2002:a05:622a:188c:b0:3bf:e2ff:4c2f with SMTP id v12-20020a05622a188c00b003bfe2ff4c2fmr7452986qtc.51.1678984353008;
        Thu, 16 Mar 2023 09:32:33 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 15-20020a05620a040f00b00745eb9f6e47sm4336978qkp.56.2023.03.16.09.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 09:32:32 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-53d277c1834so42139007b3.10;
        Thu, 16 Mar 2023 09:32:32 -0700 (PDT)
X-Received: by 2002:a81:ae5e:0:b0:541:a17f:c779 with SMTP id
 g30-20020a81ae5e000000b00541a17fc779mr2625005ywk.4.1678984352328; Thu, 16 Mar
 2023 09:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230315051444.3229621-1-willy@infradead.org> <20230315051444.3229621-15-willy@infradead.org>
 <CAMuHMdULvhry_pGap0J0FLH8TMXG1smanQjUNzPoyKsWh1FZBQ@mail.gmail.com>
In-Reply-To: <CAMuHMdULvhry_pGap0J0FLH8TMXG1smanQjUNzPoyKsWh1FZBQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Mar 2023 17:32:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX__7r=ZcJtTAOZeYkzc7Ls+M+n3vuSY1=_HVCf5Y_twA@mail.gmail.com>
Message-ID: <CAMuHMdX__7r=ZcJtTAOZeYkzc7Ls+M+n3vuSY1=_HVCf5Y_twA@mail.gmail.com>
Subject: Re: [PATCH v4 14/36] m68k: Implement the new page table range API
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 8:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Mar 15, 2023 at 6:14 AM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> > Add PFN_PTE_SHIFT, update_mmu_cache_range(), flush_icache_pages() and
> > flush_dcache_folio().
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>
> Thanks for your patch!
>
> > --- a/arch/m68k/include/asm/cacheflush_mm.h
> > +++ b/arch/m68k/include/asm/cacheflush_mm.h
> > @@ -220,24 +220,29 @@ static inline void flush_cache_page(struct vm_area_struct *vma, unsigned long vm
> >
> >  /* Push the page at kernel virtual address and clear the icache */
> >  /* RZ: use cpush %bc instead of cpush %dc, cinv %ic */
> > -static inline void __flush_page_to_ram(void *vaddr)
> > +static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
> >  {
> >         if (CPU_IS_COLDFIRE) {
> >                 unsigned long addr, start, end;
> >                 addr = ((unsigned long) vaddr) & ~(PAGE_SIZE - 1);
> >                 start = addr & ICACHE_SET_MASK;
> > -               end = (addr + PAGE_SIZE - 1) & ICACHE_SET_MASK;
> > +               end = (addr + nr * PAGE_SIZE - 1) & ICACHE_SET_MASK;
> >                 if (start > end) {
> >                         flush_cf_bcache(0, end);
> >                         end = ICACHE_MAX_ADDR;
> >                 }
> >                 flush_cf_bcache(start, end);
> >         } else if (CPU_IS_040_OR_060) {
> > -               __asm__ __volatile__("nop\n\t"
> > -                                    ".chip 68040\n\t"
> > -                                    "cpushp %%bc,(%0)\n\t"
> > -                                    ".chip 68k"
> > -                                    : : "a" (__pa(vaddr)));
> > +               unsigned long paddr = __pa(vaddr);
> > +
> > +               do {
> > +                       __asm__ __volatile__("nop\n\t"
> > +                                            ".chip 68040\n\t"
> > +                                            "cpushp %%bc,(%0)\n\t"
> > +                                            ".chip 68k"
> > +                                            : : "a" (paddr));
> > +                       paddr += PAGE_SIZE;
> > +               } while (--nr);
>
> Please use "while (nr--) { ... }", to protect against anyone ever
> calling this with nr == 0.
>
> The rest LGTM, I'll give it a try shortly...

Still working fine on ARAnyM, so
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
