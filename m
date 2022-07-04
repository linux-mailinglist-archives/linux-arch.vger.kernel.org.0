Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83694564B48
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 03:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiGDBqL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Jul 2022 21:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiGDBqJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 21:46:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D17265;
        Sun,  3 Jul 2022 18:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60E8D61376;
        Mon,  4 Jul 2022 01:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA507C341CF;
        Mon,  4 Jul 2022 01:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656899166;
        bh=nfBUY/fhIAmOhW9ph0bjLhgR/sBhReTkwz/+ZrPexow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tLcDIRIWz7Q2wpFvwgsaRmqwgu0pqulQ9KJ0iQcgo0yygnVXLMgrAK5WtsNIICFWO
         qNeG5oEbxVm6nltJ5EtiW6qcvQwmOXDUy3Ef2WfGtHfl6X+6rgEcCA7CxnK0rsFv+Q
         Dv/POw2M1nBsenMRCoMLbgafNefs3I+eXcmSCVupTuYrB9neiS1ZB7IaKU/V+yIV7o
         ND57rjQJrbwXhbT5nFC4O/UY3ySlqSzva+/cPhlNTT+JYoF40NVyP+0Uw3QLylEwIo
         Ag83z88Um11eGXbBulAzbLkl0Ke9nghWwaVnoy/WRU3jXV12mzPmP2xH0gDL3wK9bD
         x0TLu7o5fhI4Q==
Received: by mail-vs1-f52.google.com with SMTP id w187so7734020vsb.1;
        Sun, 03 Jul 2022 18:46:06 -0700 (PDT)
X-Gm-Message-State: AJIora+f+NgYLJicw/2HlnKNrBbpJIQX4Niob0Py01kXcMKqOj90SLWH
        a+QYeb1G+Ktol8nTxAaa43hRrrrOZtlEx9aWE3s=
X-Google-Smtp-Source: AGRyM1srykoKdGwELzwWlqStU79Op47MXKyXXMO2jo0udbI/Hzuo/Mtgcs0igUc4cRWAqyKAcU/W5qCjkxXXukFYC18=
X-Received: by 2002:a67:ae0e:0:b0:356:c48b:401d with SMTP id
 x14-20020a67ae0e000000b00356c48b401dmr1453276vse.51.1656899165592; Sun, 03
 Jul 2022 18:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220703141203.147893-1-rppt@kernel.org> <512b4acb-af9c-6582-dcfd-f4f12e2ff2a1@gmx.de>
 <CAAhV-H76Z-6axxHejaSCjg43sfaVC=3h5ArxSe4TSHT=AMXa9Q@mail.gmail.com>
In-Reply-To: <CAAhV-H76Z-6axxHejaSCjg43sfaVC=3h5ArxSe4TSHT=AMXa9Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 4 Jul 2022 09:45:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR6Urt=YfwTRerpiSP7d5XwJ9FdKf_pLp5u-Hn0NsCeCQ@mail.gmail.com>
Message-ID: <CAJF2gTR6Urt=YfwTRerpiSP7d5XwJ9FdKf_pLp5u-Hn0NsCeCQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] arch: make PxD_ORDER generically available
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Helge Deller <deller@gmx.de>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, loongarch@lists.linux.dev
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

For csky part.

Acked-by: Guo Ren <guoren@kernel.org>

On Mon, Jul 4, 2022 at 8:40 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Acked-by: Huacai Chen <chenhuacai@kernel.org> # LoongArch
>
> On Sun, Jul 3, 2022 at 10:28 PM Helge Deller <deller@gmx.de> wrote:
> >
> > On 7/3/22 16:11, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > Hi,
> > >
> > > The question what does PxD_ORDER define raises from time to time and
> > > there is still a conflict between MIPS and DAX definitions.
> > >
> > > Some time ago Matthew Wilcox suggested to use PMD_TABLE_ORDER to define
> > > the order of page table allocation:
> > >
> > > [1] https://lore.kernel.org/linux-arch/YPCJftSTUBEnq2lI@casper.infradead.org/
> > >
> > > The parisc patch made it in, but mips didn't.
> > > Now mips defines from asm/include/pgtable.h were copied to loongarch which
> > > made it worse.
> > >
> > > Let's deal with it once and for all and rename PxD_ORDER defines to
> > > PxD_TABLE_ORDER or just drop them when the only possible order of page
> > > table is 0.
> > >
> > > I think the best way to merge this via mm tree with acks from arch
> > > maintainers.
> >
> > That's fine for me.
> >
> > Acked-by: Helge Deller <deller@gmx.de> # parisc
> >
> > Thanks!
> > Helge
> >
> >
> >
> > > Matthew Wilcox (Oracle) (1):
> > >   mips: Rename PMD_ORDER to PMD_TABLE_ORDER
> > >
> > > Mike Rapoport (13):
> > >   csky: drop definition of PTE_ORDER
> > >   csky: drop definition of PGD_ORDER
> > >   mips: Rename PUD_ORDER to PUD_TABLE_ORDER
> > >   mips: drop definitions of PTE_ORDER
> > >   mips: Rename PGD_ORDER to PGD_TABLE_ORDER
> > >   nios2: drop definition of PTE_ORDER
> > >   nios2: drop definition of PGD_ORDER
> > >   loongarch: drop definition of PTE_ORDER
> > >   loongarch: drop definition of PMD_ORDER
> > >   loongarch: drop definition of PUD_ORDER
> > >   loongarch: drop definition of PGD_ORDER
> > >   parisc: Rename PGD_ORDER to PGD_TABLE_ORDER
> > >   xtensa: drop definition of PGD_ORDER
> > >
> > >  arch/csky/include/asm/pgalloc.h      |  2 +-
> > >  arch/csky/include/asm/pgtable.h      |  6 +--
> > >  arch/loongarch/include/asm/pgalloc.h |  6 +--
> > >  arch/loongarch/include/asm/pgtable.h | 27 +++++-------
> > >  arch/loongarch/kernel/asm-offsets.c  |  5 ---
> > >  arch/loongarch/mm/pgtable.c          |  2 +-
> > >  arch/loongarch/mm/tlbex.S            |  6 +--
> > >  arch/mips/include/asm/pgalloc.h      |  8 ++--
> > >  arch/mips/include/asm/pgtable-32.h   | 19 ++++-----
> > >  arch/mips/include/asm/pgtable-64.h   | 61 +++++++++++++---------------
> > >  arch/mips/kernel/asm-offsets.c       |  5 ---
> > >  arch/mips/kvm/mmu.c                  |  2 +-
> > >  arch/mips/mm/pgtable.c               |  2 +-
> > >  arch/mips/mm/tlbex.c                 | 14 +++----
> > >  arch/nios2/include/asm/pgtable.h     |  7 +---
> > >  arch/nios2/mm/init.c                 |  5 +--
> > >  arch/nios2/mm/pgtable.c              |  2 +-
> > >  arch/parisc/include/asm/pgalloc.h    |  6 +--
> > >  arch/parisc/include/asm/pgtable.h    |  8 ++--
> > >  arch/xtensa/include/asm/pgalloc.h    |  2 +-
> > >  arch/xtensa/include/asm/pgtable.h    |  1 -
> > >  21 files changed, 84 insertions(+), 112 deletions(-)
> > >
> > >
> > > base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
