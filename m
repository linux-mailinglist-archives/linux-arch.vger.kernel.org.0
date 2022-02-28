Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3844C6E88
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 14:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiB1NuB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 08:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiB1NuA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 08:50:00 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEC84A3E7;
        Mon, 28 Feb 2022 05:49:20 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id u10so12962347vsu.13;
        Mon, 28 Feb 2022 05:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ZlhBssXvwBUH+DmkM+uVIB26RD/VtgYSa5UcFW0OSE=;
        b=ME1GTl9CGgA+A8M1UU52UG/Gtlss9C0iIg4sxO0WmL4Cd8Ic6L3kRYcInardep7fO7
         qCrM852oJ1TUbDt5C5/9eOi4SuXkd/rwskANIZGpJDToD8R9dARY5tBW0fT61hKnyvS8
         V6ernEVfyJKnqMblapwQU3+kAx85skIcTcyM40Clr6SHq6FWsr+/lVGspn1VThtwt2IM
         KNN0SXnrDy7atslQ8/Wufx+7gG6GzbfEVKhzJX9a5xneNo0k3odS+C7zKTflZMcmkY2d
         A7qASNElSJOigQl2zBS47az4uhgWQZqoeH6E/pnc9WStivpg3+AxFFsysiEgHqZu+8WT
         wIlQ==
X-Gm-Message-State: AOAM5314yER7xvTQWX8RbYr0BQ7tT9BHwmA/PGgumRZYcGuzBDeBHZfj
        ASk+J2wwVgLMec50WYnFg0DlluAiuMbjyQ==
X-Google-Smtp-Source: ABdhPJweMf/Et4YuLWxLus2oWw/go9t2rgdokcne6lJ/T6d4SmO528QF5G51ga8DIXgqHdlR6bqNMw==
X-Received: by 2002:a67:d804:0:b0:31b:a7fd:2d9 with SMTP id e4-20020a67d804000000b0031ba7fd02d9mr7354987vsj.3.1646056159463;
        Mon, 28 Feb 2022 05:49:19 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id q131-20020a1f2a89000000b003209a39cc60sm1668859vkq.5.2022.02.28.05.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 05:49:18 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id j3so12992566vsi.7;
        Mon, 28 Feb 2022 05:49:18 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr7516436vsl.68.1646056157983; Mon, 28 Feb
 2022 05:49:17 -0800 (PST)
MIME-Version: 1.0
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
 <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com> <Yhyqjo/4bozJB6j5@shell.armlinux.org.uk>
In-Reply-To: <Yhyqjo/4bozJB6j5@shell.armlinux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 14:49:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWve8XkqtMJCTB_BH9JRZ8C4f7ynF60D1fvx3hxaK4YzA@mail.gmail.com>
Message-ID: <CAMuHMdWve8XkqtMJCTB_BH9JRZ8C4f7ynF60D1fvx3hxaK4YzA@mail.gmail.com>
Subject: Re: [PATCH V3 09/30] arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Russell,

On Mon, Feb 28, 2022 at 11:57 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Mon, Feb 28, 2022 at 04:17:32PM +0530, Anshuman Khandual wrote:
> > This defines and exports a platform specific custom vm_get_page_prot() via
> > subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> > macros can be dropped which are no longer needed.
>
> What I would really like to know is why having to run _code_ to work out
> what the page protections need to be is better than looking it up in a
> table.
>
> Not only is this more expensive in terms of CPU cycles, it also brings
> additional code size with it.
>
> I'm struggling to see what the benefit is.

I was wondering about that as well. But at least for code size on
m68k, this didn't have much impact.  Looking at the generated code,
the increase due to using code for the (few different) cases is offset
by a 16-bit jump table (which is to be credited to the compiler).

In terms of CPU cycles, it's indeed worse than before.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
