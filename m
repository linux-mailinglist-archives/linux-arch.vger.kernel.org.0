Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D42698E2B
	for <lists+linux-arch@lfdr.de>; Thu, 16 Feb 2023 08:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBPH5F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Feb 2023 02:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjBPH45 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Feb 2023 02:56:57 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DA146D63
        for <linux-arch@vger.kernel.org>; Wed, 15 Feb 2023 23:56:20 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id y2so789781qvo.4
        for <linux-arch@vger.kernel.org>; Wed, 15 Feb 2023 23:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhDO2MK0kPOmCAUzaTEIi3IbK3jHyOtFPMZslsdD/VM=;
        b=JPLI3QJYLSsZN0UUgt9N4ebviVbB9hOnDvncDfIt1HFiU57OPogXYjNSWlE4NBMCAr
         Et61g5XEBb1Tt4OtGaqrP/WOabyqmBbca3hZDajwI9V3pfNHx+Hkn+UzrJ11/7nY2X/u
         TqfENjpzwTZfoZDRtGzZKK/dOyjiZmQOU2nXt+l8KmFeZrzCU005uWQiMNR2Ba8Nlcjn
         4avB0FK4mb97Jkfyjs3dMK5NgE8zl0qMb+1yPdePDk52wR05cMuZWVjVb+NDZ+qdKm4e
         a8i3ypbZeg6OcbqsdvLzeakmL1yguhEIbiRzbBM7pZ89BP6j+UaZfWWNHNLc0dau6x8a
         TE1g==
X-Gm-Message-State: AO0yUKUmxNqwhiNCcdMvxiziXEl8vG+yGE0ql6IIZezXXmyoOkJBLybW
        euzRgliVqWb3DNT4SiTMLsxK0Y2bHR7G9g==
X-Google-Smtp-Source: AK7set8QPad1eHJwyVoVFl2Y7JaZmW3PZ/QFDGS9D9MI0ObLeirBGAmRnVlMBs03pnl5umW6f63LQQ==
X-Received: by 2002:a05:6214:2504:b0:56e:fe99:b296 with SMTP id gf4-20020a056214250400b0056efe99b296mr897899qvb.42.1676534139682;
        Wed, 15 Feb 2023 23:55:39 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id b1-20020a378001000000b0073b597ce5f8sm676311qkd.120.2023.02.15.23.55.39
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 23:55:39 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5338dd2813dso4622137b3.5
        for <linux-arch@vger.kernel.org>; Wed, 15 Feb 2023 23:55:39 -0800 (PST)
X-Received: by 2002:a81:73c4:0:b0:52e:ec16:6f19 with SMTP id
 o187-20020a8173c4000000b0052eec166f19mr791610ywc.33.1676534138884; Wed, 15
 Feb 2023 23:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20230215000446.1655635-1-willy@infradead.org> <20230215200920.1849567-1-willy@infradead.org>
 <20230215200920.1849567-2-willy@infradead.org> <84c923f7-c60b-068d-bb06-48aea1412f53@gmail.com>
 <Y+2wdSxVgS6HmFRy@casper.infradead.org>
In-Reply-To: <Y+2wdSxVgS6HmFRy@casper.infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Feb 2023 08:55:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUtjetsA8_cZAmyTR07CD5SbyV8aSymjd4wL5+TgW2Jgg@mail.gmail.com>
Message-ID: <CAMuHMdUtjetsA8_cZAmyTR07CD5SbyV8aSymjd4wL5+TgW2Jgg@mail.gmail.com>
Subject: Re: [PATCH 15/17] m68k: Implement the new page table range API
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>, linux-mm@kvack.org,
        linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org
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

Hi Matthew,

On Thu, Feb 16, 2023 at 5:26 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Feb 16, 2023 at 01:59:44PM +1300, Michael Schmitz wrote:
> > On 16/02/23 09:09, Matthew Wilcox (Oracle) wrote:
> > > Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
> > > flush_dcache_folio().  I'm not entirely certain that the 040/060 case
> > > in __flush_pages_to_ram() is correct.
> >
> > I'm pretty sure you need to iterate to hit each of the pages - the code as
> > is will only push cache entries for the first page.
> >
> > Quoting the 040 UM:
> >
> > "Both instructions [cinv, cpush] allow operation on a single cache line, all
> > cache lines in a specific page, or an entire cache, and can select one or
> > both caches for the operation. For line and page operations, a physical
> > address in an address register specifies the memory address."
>
> I actually found that!  What I didn't find was how to tell if this
> cpush insn is the one which is operating on a single cache line,
> a single page, or the entire cache.

cpushl (line), cpushp (page), cpusha (all).
Same for cinv.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
