Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C8F6AAEF7
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 11:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCEKQe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 5 Mar 2023 05:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCEKQ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 05:16:28 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFA714EAE;
        Sun,  5 Mar 2023 02:16:26 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id jo29so4790022qvb.0;
        Sun, 05 Mar 2023 02:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678011385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5qRGfTs5+kV00emn3Oo5iN+DSAN1HACfQYEpZctxMY=;
        b=4K6y9814ZyQ0hwtUKKBmR3oS8/2R5G5CKDMOqOqnlpftu6GPIK+P5as99uyggPWWwY
         D0m12G7PRVLpWeD38MMEci9pM69YzMX78rTM+NxAcRuWQZ+5NCMyRubDYMhu0tJgjXKp
         Oe0Kf8ov5rN3yWf37kxb7SW7k/3qdu9w77XzDNp9n/Zcmq0poAvyKQUo6PStw4IFRvD7
         acqpmUPqawqULtfm1pdFEWbxAusZ46tLiotivi0gSFyk7T6/w4DaWol9B3CsaZq9GID9
         Wno4TVNlOM2efxN8nXl1NSKI/DzVokhWN6ksafMSX/6jFPgNAWCWGeLJBRMv1joMYSMM
         VtDQ==
X-Gm-Message-State: AO0yUKU2hot4uLRnEZnP2+ecTwD0hPpbRw+rpw4DfAkdzFf49mwtQKbX
        GHNMMCbL/gtD5jt+ph9PpXJKUY5f9Jg6pw==
X-Google-Smtp-Source: AK7set+WkshgVzUUvxr+RB0KBsVwUS07ynJt+HPDLkRG47WFTc4UcMK4NbAlcssGYMvgyxxgmnN/Xw==
X-Received: by 2002:a05:6214:20a4:b0:583:a07b:5566 with SMTP id 4-20020a05621420a400b00583a07b5566mr5888801qvd.41.1678011385557;
        Sun, 05 Mar 2023 02:16:25 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id t190-20020a3746c7000000b0074235745fdasm5273276qka.58.2023.03.05.02.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 02:16:25 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-536af432ee5so130761407b3.0;
        Sun, 05 Mar 2023 02:16:24 -0800 (PST)
X-Received: by 2002:a81:b61d:0:b0:52e:f66d:b70f with SMTP id
 u29-20020a81b61d000000b0052ef66db70fmr4376324ywh.5.1678011384672; Sun, 05 Mar
 2023 02:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20230228213738.272178-1-willy@infradead.org> <20230228213738.272178-14-willy@infradead.org>
In-Reply-To: <20230228213738.272178-14-willy@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 5 Mar 2023 11:16:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW5TtUeZDmtHvxw+DxqUADC-OCW=tHE2Gptcoie62T+4w@mail.gmail.com>
Message-ID: <CAMuHMdW5TtUeZDmtHvxw+DxqUADC-OCW=tHE2Gptcoie62T+4w@mail.gmail.com>
Subject: Re: [PATCH v3 13/34] m68k: Implement the new page table range API
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Willy,

On Tue, Feb 28, 2023 at 10:37 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
> flush_dcache_folio().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks for your patch!

> --- a/arch/m68k/include/asm/cacheflush_mm.h
> +++ b/arch/m68k/include/asm/cacheflush_mm.h
> @@ -220,24 +220,28 @@ static inline void flush_cache_page(struct vm_area_struct *vma, unsigned long vm
>
>  /* Push the page at kernel virtual address and clear the icache */
>  /* RZ: use cpush %bc instead of cpush %dc, cinv %ic */
> -static inline void __flush_page_to_ram(void *vaddr)
> +static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
>  {
>         if (CPU_IS_COLDFIRE) {
>                 unsigned long addr, start, end;
>                 addr = ((unsigned long) vaddr) & ~(PAGE_SIZE - 1);
>                 start = addr & ICACHE_SET_MASK;
> -               end = (addr + PAGE_SIZE - 1) & ICACHE_SET_MASK;
> +               end = (addr + nr * PAGE_SIZE - 1) & ICACHE_SET_MASK;
>                 if (start > end) {
>                         flush_cf_bcache(0, end);
>                         end = ICACHE_MAX_ADDR;
>                 }
>                 flush_cf_bcache(start, end);
>         } else if (CPU_IS_040_OR_060) {
> -               __asm__ __volatile__("nop\n\t"
> -                                    ".chip 68040\n\t"
> -                                    "cpushp %%bc,(%0)\n\t"
> -                                    ".chip 68k"
> -                                    : : "a" (__pa(vaddr)));
> +               unsigned long paddr = __pa(vaddr);
> +
> +               while (nr--) {
> +                       __asm__ __volatile__("nop\n\t"
> +                                            ".chip 68040\n\t"
> +                                            "cpushp %%bc,(%0)\n\t"
> +                                            ".chip 68k"
> +                                            : : "a" (paddr + nr * PAGE_SIZE));

As gcc (9.5.0) keeps on calculating "paddr + nr * PAGE_SIZE"
inside the loop (albeit using a shift instead of a multiplication),
please use "paddr" here, followed by "paddr += PAGE_SIZE;".

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
