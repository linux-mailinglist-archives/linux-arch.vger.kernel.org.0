Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D79D6BA99C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 08:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCOHoW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 15 Mar 2023 03:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjCOHoV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 03:44:21 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7344B3B678;
        Wed, 15 Mar 2023 00:43:58 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id y3so15297098qvn.4;
        Wed, 15 Mar 2023 00:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irw1UVNowl4JF0FKbWda8y5x3cm6gsUP6fVPn73ScMA=;
        b=q4GvK29S6qWDh6WY8ujEn5dSQ2ltQs45+8zhGyX5qULm0LGndsE2xTFo5JhVumNVyQ
         jmMinDzzMhVJ2ve08rNkALpfBt/cpQ+GVi0GOn93+NPvTS/cUbamfiKwMNaXg6VHMq2X
         Q+3zskxoQKMSsTQVneYZhc02VxwXf7+USHghuCFKwZvKkijE+BpDyKRduYdprKkQKsey
         ADrLpZ7rlnfrgzF4aCEyY7MAxChKwavhrnq3iR7rT7GIHLPNaJYBOr0FCDhITZ1/7i0x
         kILZ64XkUH4SuJlr+8L+n+Zs6+O4wqv7fyjWaNlTY6CnVfq+c+gHIOukoejevfXjTnPf
         6hgA==
X-Gm-Message-State: AO0yUKUUUzg2SRKJTR3pydjQw2AQXulKh0Ki7YyhvQunccLWBkddauAO
        Pf8rBnG++V31cZ7rOhEkN/sETqhSuLm94JVT
X-Google-Smtp-Source: AK7set8udUSzoAOHD3joiBJcDRJyzWTYPiykA8vQz7ARwji56cDqg/Y6pQ4motNLvMyeaDu/937hLw==
X-Received: by 2002:a05:622a:120f:b0:3bf:cf9d:cc97 with SMTP id y15-20020a05622a120f00b003bfcf9dcc97mr29875399qtx.47.1678866237388;
        Wed, 15 Mar 2023 00:43:57 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id p11-20020ac8460b000000b003d4008dccb7sm1542603qtn.48.2023.03.15.00.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:43:57 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id t4so18214426ybg.11;
        Wed, 15 Mar 2023 00:43:56 -0700 (PDT)
X-Received: by 2002:a05:6902:188:b0:a99:de9d:d504 with SMTP id
 t8-20020a056902018800b00a99de9dd504mr25136921ybh.12.1678866236647; Wed, 15
 Mar 2023 00:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230315051444.3229621-1-willy@infradead.org> <20230315051444.3229621-15-willy@infradead.org>
In-Reply-To: <20230315051444.3229621-15-willy@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Mar 2023 08:43:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdULvhry_pGap0J0FLH8TMXG1smanQjUNzPoyKsWh1FZBQ@mail.gmail.com>
Message-ID: <CAMuHMdULvhry_pGap0J0FLH8TMXG1smanQjUNzPoyKsWh1FZBQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/36] m68k: Implement the new page table range API
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
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

On Wed, Mar 15, 2023 at 6:14 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Add PFN_PTE_SHIFT, update_mmu_cache_range(), flush_icache_pages() and
> flush_dcache_folio().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks for your patch!

> --- a/arch/m68k/include/asm/cacheflush_mm.h
> +++ b/arch/m68k/include/asm/cacheflush_mm.h
> @@ -220,24 +220,29 @@ static inline void flush_cache_page(struct vm_area_struct *vma, unsigned long vm
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
> +               do {
> +                       __asm__ __volatile__("nop\n\t"
> +                                            ".chip 68040\n\t"
> +                                            "cpushp %%bc,(%0)\n\t"
> +                                            ".chip 68k"
> +                                            : : "a" (paddr));
> +                       paddr += PAGE_SIZE;
> +               } while (--nr);

Please use "while (nr--) { ... }", to protect against anyone ever
calling this with nr == 0.

The rest LGTM, I'll give it a try shortly...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
