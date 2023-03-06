Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A9E6AB6E2
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 08:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCFHWE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 6 Mar 2023 02:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCFHWC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 02:22:02 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578B41CADE;
        Sun,  5 Mar 2023 23:21:58 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id l18so9608986qtp.1;
        Sun, 05 Mar 2023 23:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678087317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KF4/rhYJLCb1V3udoZ6HDdLYb1astmKZTSpEt1KMS3k=;
        b=IrdpkYGwq1W+2wjvLYeQ73U1cZQwq5rbK5NKpPeFJyxZU7ZaFhJ5VtlCl40yrYFl7o
         1UDTqnmK3QK9G3V4A59ylfSJoEgCBDQOKEq/vzaoINnP8kQw2IUsZcO66MzSkQ9ATw3U
         KbLplf0lbFp5ArwRr5eta7/9Qy48kwgNc602sCtXlD1JUy+/Ag+XU+N/1jtu6EYj6Sts
         4Cac/Fn50iwifk60KrTlX9gb0PFk2EAAT+lY8SGVfW5yvwj5wcyL6x6Mz0SyYlktZt7B
         z7hfE/11eLZsVvBs/I8JBVpEatMt3OoydT6+KRG793COJ1qRfWCgF4YnooyEC8IXLTvX
         tWug==
X-Gm-Message-State: AO0yUKVQJCkKbruLUo7S7X6DC0EB8MY1dXwafPmfXW4o2NS2ftYvlcy/
        ma7gnD+3nezKfsUkMoG+RElF8tpVtXr3Eg==
X-Google-Smtp-Source: AK7set8mcAJ423JXJsA21vVn1OfcQyoRUUIgXpQ4jjvx3hT20oWRcD4ruVWtCq0vLmU3joUh6fjxAQ==
X-Received: by 2002:ac8:5b95:0:b0:3bf:b6cf:25c5 with SMTP id a21-20020ac85b95000000b003bfb6cf25c5mr17906454qta.14.1678087317247;
        Sun, 05 Mar 2023 23:21:57 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b007426b917031sm6972702qko.121.2023.03.05.23.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 23:21:56 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id t39so7154190ybi.3;
        Sun, 05 Mar 2023 23:21:56 -0800 (PST)
X-Received: by 2002:a5b:308:0:b0:90d:af77:9ca6 with SMTP id
 j8-20020a5b0308000000b0090daf779ca6mr5841580ybp.7.1678087316135; Sun, 05 Mar
 2023 23:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20230228213738.272178-1-willy@infradead.org> <20230228213738.272178-14-willy@infradead.org>
 <CAMuHMdW5TtUeZDmtHvxw+DxqUADC-OCW=tHE2Gptcoie62T+4w@mail.gmail.com>
 <ZAS1Lq6//oO/0PXe@casper.infradead.org> <0b00a30e-cb7f-d42b-7d16-0ae8d50ed916@gmail.com>
In-Reply-To: <0b00a30e-cb7f-d42b-7d16-0ae8d50ed916@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Mar 2023 08:21:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUDrOD3DezbvxaJH6CXxDFRNC7G-8uU7mqVHxZcG6GNBA@mail.gmail.com>
Message-ID: <CAMuHMdUDrOD3DezbvxaJH6CXxDFRNC7G-8uU7mqVHxZcG6GNBA@mail.gmail.com>
Subject: Re: [PATCH v3 13/34] m68k: Implement the new page table range API
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
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

Hi Michael,

On Sun, Mar 5, 2023 at 9:44 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 6/03/23 04:28, Matthew Wilcox wrote:
> > On Sun, Mar 05, 2023 at 11:16:13AM +0100, Geert Uytterhoeven wrote:
> >>> +               while (nr--) {
> >>> +                       __asm__ __volatile__("nop\n\t"
> >>> +                                            ".chip 68040\n\t"
> >>> +                                            "cpushp %%bc,(%0)\n\t"
> >>> +                                            ".chip 68k"
> >>> +                                            : : "a" (paddr + nr * PAGE_SIZE));
> >> As gcc (9.5.0) keeps on calculating "paddr + nr * PAGE_SIZE"
> >> inside the loop (albeit using a shift instead of a multiplication),
> >> please use "paddr" here, followed by "paddr += PAGE_SIZE;".
>
> Are we certain that contiguous vaddr always maps to contiguous paddr?

For a general __flush_pages_to_ram() function, that would not be
guaranteed. But as this is meant for folios, it must be true:
https://elixir.bootlin.com/linux/latest/source/include/linux/mm_types.h#L320

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
