Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F9A6AAEE0
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 10:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCEJyK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 5 Mar 2023 04:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCEJyJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 04:54:09 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9715EAD13;
        Sun,  5 Mar 2023 01:54:08 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id w23so7582775qtn.6;
        Sun, 05 Mar 2023 01:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678010047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=likQ3YJWQU7uGYJUxbuxq2RkKCJsTtCE9M6mOr0D2q4=;
        b=BB2x3RdXMKSm3QvXXLnXvDpNQcBdG+JcRdeWHiAMmy+GSX4nNBottGNzP932WgHYqX
         v72eET6PH/b2E0NJRRQKTD9u2STguB5aqQNU0T7c6GDeFl1f1uleetQJXGf+Cp+ibIY8
         9B2yJIHkcgh4ZEhMS3YgrG0z2fRG442htz9Bej4nQnNVc02kQruCEI2xFxXEM+lM7qEN
         GcovIGZSE/iIcbsKchbEe1+zTmE7Ln0rwJ4OSwKkKDYnp8Q21aS4CdI7THwXYA1/RyzR
         BazVx61ijTwGoAapH8M+tudyiu5r3v9fE3umvGu8PyQgIRfrK34s6j1x1z34vQmhLbOw
         DAuA==
X-Gm-Message-State: AO0yUKVwQt+ID6+Mb0qTaxNZZ7WjrQN/mxup14PrNpdwMvlmZkz3rzGy
        xZBHOqFTmD6Gopk53Guf9z+Lo1y7RjQ2xQ==
X-Google-Smtp-Source: AK7set8Hq72orfXxmnGEfmPdfZAZmdG+iEkJyEEOV6NTOq/yO+45dtJew2oq0BG7yCmg874o51u66w==
X-Received: by 2002:ac8:7d88:0:b0:3bf:da79:6703 with SMTP id c8-20020ac87d88000000b003bfda796703mr13357062qtd.3.1678010047504;
        Sun, 05 Mar 2023 01:54:07 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id r13-20020a05622a034d00b0039cc0fbdb61sm5598782qtw.53.2023.03.05.01.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 01:54:07 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-536b7ffdd34so129098077b3.6;
        Sun, 05 Mar 2023 01:54:06 -0800 (PST)
X-Received: by 2002:a81:ac60:0:b0:52f:184a:da09 with SMTP id
 z32-20020a81ac60000000b0052f184ada09mr4696206ywj.2.1678010046579; Sun, 05 Mar
 2023 01:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20230228213738.272178-1-willy@infradead.org> <20230228213738.272178-30-willy@infradead.org>
In-Reply-To: <20230228213738.272178-30-willy@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 5 Mar 2023 10:53:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWMToCZn5Ehp7-Me49Fv1Smgfaz4Z2wvi1=2MLMtzyqow@mail.gmail.com>
Message-ID: <CAMuHMdWMToCZn5Ehp7-Me49Fv1Smgfaz4Z2wvi1=2MLMtzyqow@mail.gmail.com>
Subject: Re: [PATCH v3 29/34] mm: Rationalise flush_icache_pages() and flush_icache_page()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Feb 28, 2023 at 10:39 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Move the default (no-op) implementation of flush_icache_pages()
> to <linux/cacheflush.h> from <asm-generic/cacheflush.h>.
> Remove the flush_icache_page() wrapper from each architecture
> into <linux/cacheflush.h>.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

>  arch/m68k/include/asm/cacheflush_mm.h   |  1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
