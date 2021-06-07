Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E171839D63A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 09:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFGHpI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 03:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhFGHpH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 03:45:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF4386127C;
        Mon,  7 Jun 2021 07:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623051796;
        bh=hTteHEOJ6fuVn0bUEkVjfhKcTXY/fr6KaN9hPRGCRE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XcJ16yKwRTtjOEHZTmO5sqG2EgpLlLKApCRuWSa2uNKExqjlmP6pIcZB+LR9vHoUJ
         DlEePW9oLiXKXzeH9L9F0Wk5IlIzHnk8S8cF7e+14d2grrjRGj2z3RllwrC9qvMzWa
         Scz54HCXmSpiKFvI9ZwujG1MOGPfRBgKd+8j2eRJwMFJcoO716/e4aO83B1Ftd1YQe
         V/pq06VNseHS37q5seU5IeYEitCUWKFx5Ql+VG32hohITtzAdxsSYTxN01aKBmqN5n
         3CGVqHhcrZFZq8mZbNc4pEcTK5PgFy6OsZjWB1rcYhYD4mddESSUsRyaHx2+w/2mo5
         1OJ4M8CSeddjQ==
Received: by mail-lj1-f178.google.com with SMTP id r16so1721296ljk.9;
        Mon, 07 Jun 2021 00:43:16 -0700 (PDT)
X-Gm-Message-State: AOAM531nAlEjuWKHo6t899Z8POJV3N5FjCK5VRPEGJRPJkq+0ABAiEw7
        NquFAOaQJDhWCaX34H0zttZju6HdmcEILOPrPPc=
X-Google-Smtp-Source: ABdhPJyKxzhukXaYzHu0eSbGrCR3t7tIBy0TIpuvAKNAzu0/rYsPgtX7UElk34zL12D4zBA67MfFr81fmeJmAptKvvA=
X-Received: by 2002:a05:651c:502:: with SMTP id o2mr13824567ljp.105.1623051795168;
 Mon, 07 Jun 2021 00:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-14-git-send-email-guoren@kernel.org> <20210607071916.kwdbtafbqp3icgia@gilmour>
In-Reply-To: <20210607071916.kwdbtafbqp3icgia@gilmour>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Jun 2021 15:43:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT=aLNpwuQmOPw=L8eoezwX8DmGOunmPx0H_WzbaOpO+g@mail.gmail.com>
Message-ID: <CAJF2gTT=aLNpwuQmOPw=L8eoezwX8DmGOunmPx0H_WzbaOpO+g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/11] riscv: soc: Add Allwinner SoC kconfig option
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Drew Fustini <drew@beagleboard.org>, liush@allwinnertech.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        wefu@redhat.com, linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 7, 2021 at 3:19 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Sun, Jun 06, 2021 at 09:04:08AM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add Allwinner kconfig option which selects SoC specific and common
> > drivers that is required for this SoC.
> >
> > Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
> > interconnect issues for dma synchronization, so we set the default
> > value when SOC_SUNXI selected.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Co-Developed-by: Liu Shaohua <liush@allwinnertech.com>
> > Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> > Cc: Anup Patel <anup.patel@wdc.com>
> > Cc: Atish Patra <atish.patra@wdc.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: Drew Fustini <drew@beagleboard.org>
> > Cc: Maxime Ripard <maxime@cerno.tech>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Wei Fu <wefu@redhat.com>
> > Cc: Wei Wu <lazyparser@gmail.com>
> > ---
> >  arch/riscv/Kconfig.socs      | 12 ++++++++++++
> >  arch/riscv/configs/defconfig |  1 +
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index ed96376..055fb3e 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -69,4 +69,16 @@ config SOC_CANAAN_K210_DTB_SOURCE
> >
> >  endif
> >
> > +config SOC_SUNXI
> > +     bool "Allwinner SoCs"
> > +     depends on MMU
> > +     select DWMAC_GENERIC
> > +     select SERIAL_8250
> > +     select SERIAL_8250_CONSOLE
> > +     select SERIAL_8250_DW
> > +     select SIFIVE_PLIC
> > +     select STMMAC_ETH
> > +     help
> > +       This enables support for Allwinner SoC platforms like the D1.
> > +
>
> We probably don't want to select DWMAC, STMMAC_ETH and the 8250 options,
> looks good otherwise.
>
> Maxime
Remove DWMAC, STMMAC_ETH is okay.

But I think we still need:
select SERIAL_8250_DW if SERIAL_8250
-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
