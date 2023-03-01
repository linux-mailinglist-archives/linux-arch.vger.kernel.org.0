Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571E06A688E
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 09:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCAIGi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 03:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCAIGh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 03:06:37 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D29937545;
        Wed,  1 Mar 2023 00:06:36 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id w23so13380137qtn.6;
        Wed, 01 Mar 2023 00:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxktB80SVUUGX5HN3L3vi17Q72ZYHj/nfVmA7YVgBaA=;
        b=wdSGo+pdXlu84nww6+YIrwwId9/9f8cBR8qDxCYPd3No4OoqNMrxTjE5TMK8t0JDVt
         ktYYTzCNIPcVr4q94cdRARxGLi2i3+ZJlue8Jyjihib5QDxpj5tfQAw3xwrXslGSnJCI
         bkTQDidm3G1UNSqC6lsKGOl4LRQe395rR5okFH5pE3bkc2uS+G5nHHI9dmHjngW4omac
         vnIDBALcG3K7dEkl9RSJNvEbEXvtSv29NuPfAkPYjY7DujuzVzcze3Rc9WCQGzvU5FKc
         WPUEIxarWe9RFCAOVp6TqiLeUrjuQn4maCpDncVLiX2YSuf4Mv5P2BJN7DoiIQ0slpjq
         vR6Q==
X-Gm-Message-State: AO0yUKWDHWpSfxPZBTbyVB+Qq0GItkfFsULXP6obhQ14XhqmV9NzO+O1
        YQifRG1thbbWIWJt+M265jceiebVhmG6dg==
X-Google-Smtp-Source: AK7set/auLsMLIlNhlXEG7ezcbAVvMv6WpFBcVJldKF6TnUx+tdBEq6g7gL2y4ZbvM6vu/qPOYnrrg==
X-Received: by 2002:a05:622a:101:b0:3b6:2b5c:97e5 with SMTP id u1-20020a05622a010100b003b62b5c97e5mr9880556qtw.17.1677657995153;
        Wed, 01 Mar 2023 00:06:35 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id p12-20020a37420c000000b007426ec97253sm5944573qka.111.2023.03.01.00.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 00:06:34 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-53916ab0c6bso344568887b3.7;
        Wed, 01 Mar 2023 00:06:34 -0800 (PST)
X-Received: by 2002:a81:ad45:0:b0:52e:cacb:d7c4 with SMTP id
 l5-20020a81ad45000000b0052ecacbd7c4mr3373237ywk.5.1677657994373; Wed, 01 Mar
 2023 00:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20230228213738.272178-1-willy@infradead.org> <20230228213738.272178-23-willy@infradead.org>
In-Reply-To: <20230228213738.272178-23-willy@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Mar 2023 09:06:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVY9VSZ57g-RXpDVBigfKJZLyF5wuyRsbmOm6d+m08OEA@mail.gmail.com>
Message-ID: <CAMuHMdVY9VSZ57g-RXpDVBigfKJZLyF5wuyRsbmOm6d+m08OEA@mail.gmail.com>
Subject: Re: [PATCH v3 22/34] superh: Implement the new page table range API
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Feb 28, 2023 at 10:39 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio() and
> flush_icache_pages().  Change the PG_dcache_clean flag from being
> per-page to per-folio.  Flush the entire folio containing the pages in
> flush_icache_pages() for ease of implementation.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks for your patch!

> --- a/arch/sh/mm/cache.c
> +++ b/arch/sh/mm/cache.c

>  void __flush_anon_page(struct page *page, unsigned long vmaddr)
>  {
> +       struct folio *folio = page_folio(page);
>         unsigned long addr = (unsigned long) page_address(page);
>
>         if (pages_do_alias(addr, vmaddr)) {
> -               if (boot_cpu_data.dcache.n_aliases && page_mapcount(page) &&
> -                   test_bit(PG_dcache_clean, &page->flags)) {
> +               if (boot_cpu_data.dcache.n_aliases && folio_mapped(folio) &&
> +                   test_bit(PG_dcache_clean, &folio->flags)) {
>                         void *kaddr;
>
>                         kaddr = kmap_coherent(page, vmaddr);
>                         /* XXX.. For now kunmap_coherent() does a purge */
>                         /* __flush_purge_region((void *)kaddr, PAGE_SIZE); */
>                         kunmap_coherent(kaddr);
> -               } else
> -                       __flush_purge_region((void *)addr, PAGE_SIZE);
> +               } else

Trailing whitespace. Please run scripts/checkpath.pl (on the full series).

> +                       __flush_purge_region(folio_address(folio),
> +                                               folio_size(folio));
>         }
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
