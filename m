Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907436AAEF5
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 11:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCEKQO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 5 Mar 2023 05:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCEKQN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 05:16:13 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7789FF777;
        Sun,  5 Mar 2023 02:16:12 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id nv15so4736467qvb.7;
        Sun, 05 Mar 2023 02:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678011371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lotoz11ggMGtNTl3aQvMMzWHUqGY2U+vaeJhB00aaRc=;
        b=3oR63exngN1IQTE99V1MRdnggDePgOUzrC/blSENxspFcoC/nh7hxE8gCJBArVLutM
         f595BzpAc56pFmvNR0yqinHwzyxLl7bfwODrANjzThBEANOUxcWMmMcfKKW0+ihjH64e
         F0Kvv8FJQB2mI9IbvZRMHi4JPxrPRUzKH2cKEgm6QIKtUIt+3EvzINvcXhmRwatkszwQ
         UpRJdnU+Q3P8+Z8xLiy/+6evlSI0bamljijHmet2GWWHkj7a45EdDazti2fl+9VWr033
         XpVEn4ULSd0eZJVfxndHrH2vfyB6Oj6gZdRX79CswT7awiwqfEnCi3IqnWl7HR8Sc9yd
         DflA==
X-Gm-Message-State: AO0yUKX1D9qgzH4V3hQMuCV/JmulsJQdAGsXwJxgTEoikDlGh7KaF5p+
        EKl5hlHbPdf624owm0RG/9bx+vYJWj1imQ==
X-Google-Smtp-Source: AK7set+z8ddUHNmML6QnccXLW4f8zqI2tL19/eB/h+fezKq/uz1hXgMd4CQ+UpkLwGtl1+uxne5eWg==
X-Received: by 2002:a05:6214:1250:b0:570:bf43:475 with SMTP id r16-20020a056214125000b00570bf430475mr11896594qvv.22.1678011371342;
        Sun, 05 Mar 2023 02:16:11 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id q79-20020a374352000000b0073b27323c6dsm5141934qka.136.2023.03.05.02.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 02:16:10 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-536be69eadfso130125547b3.1;
        Sun, 05 Mar 2023 02:16:10 -0800 (PST)
X-Received: by 2002:a81:b61d:0:b0:52e:f66d:b70f with SMTP id
 u29-20020a81b61d000000b0052ef66db70fmr4376133ywh.5.1678011370431; Sun, 05 Mar
 2023 02:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20230228213738.272178-1-willy@infradead.org>
In-Reply-To: <20230228213738.272178-1-willy@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 5 Mar 2023 11:15:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVD-de_jzfidbz7BQaH59=qsFVcV8wpWRfQAtdpakB0SA@mail.gmail.com>
Message-ID: <CAMuHMdVD-de_jzfidbz7BQaH59=qsFVcV8wpWRfQAtdpakB0SA@mail.gmail.com>
Subject: Re: [PATCH v3 00/34] New page table range API
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Feb 28, 2023 at 10:40 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> This patchset changes the API used by the MM to set up page table entries.
> The four APIs are:
>     set_ptes(mm, addr, ptep, pte, nr)
>     update_mmu_cache_range(vma, addr, ptep, nr)
>     flush_dcache_folio(folio)
>     flush_icache_pages(vma, page, nr)
>
> flush_dcache_folio() isn't technically new, but no architecture
> implemented it, so I've done that for you.  The old APIs remain around
> but are mostly implemented by calling the new interfaces.
>
> The new APIs are based around setting up N page table entries at once.
> The N entries belong to the same PMD, the same folio and the same VMA,
> so ptep++ is a legitimate operation, and locking is taken care of for
> you.  Some architectures can do a better job of it than just a loop,
> but I have hesitated to make too deep a change to architectures I don't
> understand well.
>
> One thing I have changed in every architecture is that PG_arch_1 is now a
> per-folio bit instead of a per-page bit.  This was something that would
> have to happen eventually, and it makes sense to do it now rather than
> iterate over every page involved in a cache flush and figure out if it
> needs to happen.
>
> The point of all this is better performance, and Fengwei Yin has
> measured improvement on x86.  I suspect you'll see improvement on
> your architecture too.  Try the new will-it-scale test mentioned here:
> https://lore.kernel.org/linux-mm/20230206140639.538867-5-fengwei.yin@intel.com/
> You'll need to run it on an XFS filesystem and have
> CONFIG_TRANSPARENT_HUGEPAGE set.

Thanks for your series!

> For testing, I've only run the code on x86.  If an x86->foo compiler
> exists in Debian, I've built defconfig.  I'm relying on the buildbots
> to tell me what I missed, and people who actually have the hardware to
> tell me if it actually works.

Seems to work fine on ARAnyM and qemu-system-m68k/virt, so
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
