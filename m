Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBEE39DCAF
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 14:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFGMlu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 08:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230444AbhFGMls (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 08:41:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFEB561284;
        Mon,  7 Jun 2021 12:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623069597;
        bh=LUAY4oJCPkrVMDMv4EYSat/1R4o3Msb/H6pgTpNF6Dc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KWV+7c3IjzT7FtlrB8gnUBQW/jSf/nTwRv+WGXgX1oQerF7TNwnjINy9dIy0WM9XG
         H1eMFTEQYp0FdRfJtMNFI3oqNy4X3oGD4+HIUq9/iTB8P8wYTaDPwD/HPWcoaF6BQu
         2n1h5PrujEwNugnUORQbo1zKFUmY+3LjPLub+kbavMAFzreI59ISbTUM60VJX+WXfS
         VVW0lJbixOMhfywWAgsIKDbu3fxk7qCyg6Lu06aqudSTABe3Cdyq/Ubusv+JNhg2vT
         o9fCVpoKq+s/nQ/NzUEDefCCqiMPGg3z4whipIhJYw+B4JzYo/IFTU7/Td6hKQDVxB
         uMx+BBnyHbJZA==
Received: by mail-lf1-f54.google.com with SMTP id v22so24672282lfa.3;
        Mon, 07 Jun 2021 05:39:57 -0700 (PDT)
X-Gm-Message-State: AOAM531zyvifZThPAG2gNZn9Zbyg1Wu761NFxXU4YKd6tOsI0tHJWL/L
        rWZl13HO6S9XI+h9Yf+IlR/pS8GVKmFI5Hj9Jig=
X-Google-Smtp-Source: ABdhPJz48qsWSQ02EwreDy3/VnjhXRWA7jvdPh9Ppq+bQ7kJFHb73CXOyYtlYg++k2AP3yDR3+5XzBToRYQX0vNFFNo=
X-Received: by 2002:a05:6512:3f02:: with SMTP id y2mr12282446lfa.355.1623069595963;
 Mon, 07 Jun 2021 05:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-14-git-send-email-guoren@kernel.org> <20210607071916.kwdbtafbqp3icgia@gilmour>
 <CAJF2gTT=aLNpwuQmOPw=L8eoezwX8DmGOunmPx0H_WzbaOpO+g@mail.gmail.com> <20210607121216.ypoehirsdypul3br@gilmour>
In-Reply-To: <20210607121216.ypoehirsdypul3br@gilmour>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Jun 2021 20:39:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR1z3ZMOwyMBztNUnQJse2zPJV6CenXRnqu1LbUG6XW7A@mail.gmail.com>
Message-ID: <CAJF2gTR1z3ZMOwyMBztNUnQJse2zPJV6CenXRnqu1LbUG6XW7A@mail.gmail.com>
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

On Mon, Jun 7, 2021 at 8:12 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Jun 07, 2021 at 03:43:03PM +0800, Guo Ren wrote:
> > On Mon, Jun 7, 2021 at 3:19 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > Hi,
> > >
> > > On Sun, Jun 06, 2021 at 09:04:08AM +0000, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Add Allwinner kconfig option which selects SoC specific and common
> > > > drivers that is required for this SoC.
> > > >
> > > > Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
> > > > interconnect issues for dma synchronization, so we set the default
> > > > value when SOC_SUNXI selected.
> > > >
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Co-Developed-by: Liu Shaohua <liush@allwinnertech.com>
> > > > Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> > > > Cc: Anup Patel <anup.patel@wdc.com>
> > > > Cc: Atish Patra <atish.patra@wdc.com>
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: Chen-Yu Tsai <wens@csie.org>
> > > > Cc: Drew Fustini <drew@beagleboard.org>
> > > > Cc: Maxime Ripard <maxime@cerno.tech>
> > > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > > > Cc: Wei Fu <wefu@redhat.com>
> > > > Cc: Wei Wu <lazyparser@gmail.com>
> > > > ---
> > > >  arch/riscv/Kconfig.socs      | 12 ++++++++++++
> > > >  arch/riscv/configs/defconfig |  1 +
> > > >  2 files changed, 13 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > > index ed96376..055fb3e 100644
> > > > --- a/arch/riscv/Kconfig.socs
> > > > +++ b/arch/riscv/Kconfig.socs
> > > > @@ -69,4 +69,16 @@ config SOC_CANAAN_K210_DTB_SOURCE
> > > >
> > > >  endif
> > > >
> > > > +config SOC_SUNXI
> > > > +     bool "Allwinner SoCs"
> > > > +     depends on MMU
> > > > +     select DWMAC_GENERIC
> > > > +     select SERIAL_8250
> > > > +     select SERIAL_8250_CONSOLE
> > > > +     select SERIAL_8250_DW
> > > > +     select SIFIVE_PLIC
> > > > +     select STMMAC_ETH
> > > > +     help
> > > > +       This enables support for Allwinner SoC platforms like the D1.
> > > > +
> > >
> > > We probably don't want to select DWMAC, STMMAC_ETH and the 8250 options,
> > > looks good otherwise.
> > >
> > > Maxime
> > Remove DWMAC, STMMAC_ETH is okay.
> >
> > But I think we still need:
> > select SERIAL_8250_DW if SERIAL_8250
>
> Well, even the UART is optional. Just enable them in the defconfig
Okay


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
