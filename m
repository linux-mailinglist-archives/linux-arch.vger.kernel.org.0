Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BED9564AF5
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 02:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiGDAkh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Jul 2022 20:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiGDAkg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 20:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10075FEB;
        Sun,  3 Jul 2022 17:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89B2F612F0;
        Mon,  4 Jul 2022 00:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE52C341D6;
        Mon,  4 Jul 2022 00:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656895234;
        bh=zihGkex1hcNbg03vghsoOk/F/+VaugalDQxsnw4PkM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W9cj3t/dcSUFWJ25fS8zMjM60opfgitB8Gx5lj4fpM3pYRU6irplF0ZbkH4/IMqYI
         q4kEZhLARfG8ylM7kIyI8ru4oa0b2HbhPT0fiKgvdQrSHC3HSkpdinmlflPhIM6Wk+
         1BcGixfUoYmzdTSZNyljoqUg9vOQDWs3/OHMtuE2mjn3hV7pZWXv1krAQ0zj2ewJbx
         v1pQdzZS+KLDQtCDBCr+FNdQNhu7bK70myiSHVR8J6cbjb7x+z9gqIgfF21bP9KPkL
         Kr97MpR/v9kfBy8ZqFFKJErqV3HQrb61v6fthK15Az6MEi3eMNSklHVcrfic6PKLvW
         j3CzNGYDxIY7Q==
Received: by mail-ua1-f43.google.com with SMTP id s38so470737uac.6;
        Sun, 03 Jul 2022 17:40:34 -0700 (PDT)
X-Gm-Message-State: AJIora/zY34xnuO4vj8W9h6fBKu3xJETvyrslp6bOTixqbvWi5pcrQiR
        LC3D65jV8x0vLB3xAVctsOTDiBGofNP+25ABtEo=
X-Google-Smtp-Source: AGRyM1t9y2OyTdqTWfS0OUB9uEcr6esCzva/vtBPss0d4wMIRnd6LsJlOqm32WZUvlijKEhKgrlQzao0xN67K3uh9Pg=
X-Received: by 2002:a9f:37a7:0:b0:382:1e21:9e93 with SMTP id
 q36-20020a9f37a7000000b003821e219e93mr10429642uaq.22.1656895233630; Sun, 03
 Jul 2022 17:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220703141203.147893-1-rppt@kernel.org> <512b4acb-af9c-6582-dcfd-f4f12e2ff2a1@gmx.de>
In-Reply-To: <512b4acb-af9c-6582-dcfd-f4f12e2ff2a1@gmx.de>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 4 Jul 2022 08:40:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H76Z-6axxHejaSCjg43sfaVC=3h5ArxSe4TSHT=AMXa9Q@mail.gmail.com>
Message-ID: <CAAhV-H76Z-6axxHejaSCjg43sfaVC=3h5ArxSe4TSHT=AMXa9Q@mail.gmail.com>
Subject: Re: [PATCH 00/14] arch: make PxD_ORDER generically available
To:     Helge Deller <deller@gmx.de>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dinh Nguyen <dinguyen@kernel.org>, Guo Ren <guoren@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Acked-by: Huacai Chen <chenhuacai@kernel.org> # LoongArch

On Sun, Jul 3, 2022 at 10:28 PM Helge Deller <deller@gmx.de> wrote:
>
> On 7/3/22 16:11, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Hi,
> >
> > The question what does PxD_ORDER define raises from time to time and
> > there is still a conflict between MIPS and DAX definitions.
> >
> > Some time ago Matthew Wilcox suggested to use PMD_TABLE_ORDER to define
> > the order of page table allocation:
> >
> > [1] https://lore.kernel.org/linux-arch/YPCJftSTUBEnq2lI@casper.infradead.org/
> >
> > The parisc patch made it in, but mips didn't.
> > Now mips defines from asm/include/pgtable.h were copied to loongarch which
> > made it worse.
> >
> > Let's deal with it once and for all and rename PxD_ORDER defines to
> > PxD_TABLE_ORDER or just drop them when the only possible order of page
> > table is 0.
> >
> > I think the best way to merge this via mm tree with acks from arch
> > maintainers.
>
> That's fine for me.
>
> Acked-by: Helge Deller <deller@gmx.de> # parisc
>
> Thanks!
> Helge
>
>
>
> > Matthew Wilcox (Oracle) (1):
> >   mips: Rename PMD_ORDER to PMD_TABLE_ORDER
> >
> > Mike Rapoport (13):
> >   csky: drop definition of PTE_ORDER
> >   csky: drop definition of PGD_ORDER
> >   mips: Rename PUD_ORDER to PUD_TABLE_ORDER
> >   mips: drop definitions of PTE_ORDER
> >   mips: Rename PGD_ORDER to PGD_TABLE_ORDER
> >   nios2: drop definition of PTE_ORDER
> >   nios2: drop definition of PGD_ORDER
> >   loongarch: drop definition of PTE_ORDER
> >   loongarch: drop definition of PMD_ORDER
> >   loongarch: drop definition of PUD_ORDER
> >   loongarch: drop definition of PGD_ORDER
> >   parisc: Rename PGD_ORDER to PGD_TABLE_ORDER
> >   xtensa: drop definition of PGD_ORDER
> >
> >  arch/csky/include/asm/pgalloc.h      |  2 +-
> >  arch/csky/include/asm/pgtable.h      |  6 +--
> >  arch/loongarch/include/asm/pgalloc.h |  6 +--
> >  arch/loongarch/include/asm/pgtable.h | 27 +++++-------
> >  arch/loongarch/kernel/asm-offsets.c  |  5 ---
> >  arch/loongarch/mm/pgtable.c          |  2 +-
> >  arch/loongarch/mm/tlbex.S            |  6 +--
> >  arch/mips/include/asm/pgalloc.h      |  8 ++--
> >  arch/mips/include/asm/pgtable-32.h   | 19 ++++-----
> >  arch/mips/include/asm/pgtable-64.h   | 61 +++++++++++++---------------
> >  arch/mips/kernel/asm-offsets.c       |  5 ---
> >  arch/mips/kvm/mmu.c                  |  2 +-
> >  arch/mips/mm/pgtable.c               |  2 +-
> >  arch/mips/mm/tlbex.c                 | 14 +++----
> >  arch/nios2/include/asm/pgtable.h     |  7 +---
> >  arch/nios2/mm/init.c                 |  5 +--
> >  arch/nios2/mm/pgtable.c              |  2 +-
> >  arch/parisc/include/asm/pgalloc.h    |  6 +--
> >  arch/parisc/include/asm/pgtable.h    |  8 ++--
> >  arch/xtensa/include/asm/pgalloc.h    |  2 +-
> >  arch/xtensa/include/asm/pgtable.h    |  1 -
> >  21 files changed, 84 insertions(+), 112 deletions(-)
> >
> >
> > base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
>
