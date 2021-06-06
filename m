Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5321539D027
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 19:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhFFRQz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 13:16:55 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46043 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFFRQy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 13:16:54 -0400
Received: by mail-wr1-f54.google.com with SMTP id z8so14668910wrp.12;
        Sun, 06 Jun 2021 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0ngfq8v4GDUgFESlrE0JELVOjRgUmmBaP6fcNBr54I=;
        b=uWrJ+arILlxT7ZwHMghPIzGKOCH6iid96CZIwxC/S5EClYcLbU8ECWa+j/LqE5fiXs
         Z56awwob2HCfTl6fzAYc37lQfBRjiSDTxEduhD15o5JOPzNeXQg/3f4/yhAAtTEYOGl9
         7zUDUp3uZTwJ6UNpK6qwbWIC9jRmOLyF45Ry/6DEtr26llfqZc0eA89WJzixTeuXNfHk
         QBzS8cHFX9MOmpp/AUktuc0hqI45DQRORCJIOV0jI7q4mGS69g+fVsSAcwraP/kXf2M1
         ulcvHVSlAdgw88aoSZTdGCniDRfpzW1MrNRGwlDIOyUMGEQDsdUEWZSVKKTgvz1Nxq9A
         H4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0ngfq8v4GDUgFESlrE0JELVOjRgUmmBaP6fcNBr54I=;
        b=PWn9aeF0XTEEvd9bLN2mYTO82A3UfTUvWGGJHhH2xCxsZH+YHe2BWWyCdxKOpdtRN2
         /VR3YNaBQRnXNhgnE1o1jJjl+2SonWSCXDgtqxSoJSUoS8soaqQjJzLpz9UDgnjIMIXu
         Gbic/4OaQVRED4Clhj6d+F6NmiazMOo9uphR7VfL23/Qvrzv+7u7EkA7wNuqEQPNby7P
         aRYYIDRWPnojo85PNYvg0oUET8f+71xnE23ONBzOiiTN95ppDEDUw0pKbTOJUXYKbAJb
         koMlNMIyI/C3TWSjpwSc1elhqIFb1TqgTe/xoqLPzeIwjGHX//HpZBWtmJuSSA/qLWtW
         WK+Q==
X-Gm-Message-State: AOAM533+bnrV48XPM16Ewco25xLePrH2DB9vrhT3Vzw/O0Rlfa7PbemW
        EvVZe/HFuIonc0FaPFuSPPo=
X-Google-Smtp-Source: ABdhPJz8CAyOeyOFrSeMZEwE9Secrxj8SxDI4wHQJzhlpIGI+BLpzrACIWxuIhOY9CX+GwwQ8KbewQ==
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr13309222wrn.117.1622999644208;
        Sun, 06 Jun 2021 10:14:04 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id k11sm14529330wmj.1.2021.06.06.10.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 10:14:03 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, wens@csie.org,
        maxime@cerno.tech, Drew Fustini <drew@beagleboard.org>,
        liush@allwinnertech.com,
        Wei Wu =?utf-8?B?KOWQtOS8nyk=?= <lazyparser@gmail.com>,
        wefu@redhat.com, linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH v2 00/11] riscv: Add DMA_COHERENT support for Allwinner D1
Date:   Sun, 06 Jun 2021 19:14:02 +0200
Message-ID: <1664140.l4xsYfQU8q@jernej-laptop>
In-Reply-To: <CAJF2gTQ1yvSNthJ2yJkqaYGaJ6OYmf0vbG=hm4ocgnw4DiZbOw@mail.gmail.com>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org> <3110420.cQCZQDpDj9@jernej-laptop> <CAJF2gTQ1yvSNthJ2yJkqaYGaJ6OYmf0vbG=hm4ocgnw4DiZbOw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dne nedelja, 06. junij 2021 ob 18:54:05 CEST je Guo Ren napisal(a):
> V5 is not related to the patch series.

Don't top post.

If that's the case, then your e-mail client messed things up. I got V5 patc=
hes=20
in the same thread as board enablement patches and so did mailing list [1].

Best regards,
Jernej

[1] https://lore.kernel.org/linux-sunxi/
CAJF2gTQ1yvSNthJ2yJkqaYGaJ6OYmf0vbG=3Dhm4ocgnw4DiZbOw@mail.gmail.com/T/#t

>=20
> On Mon, Jun 7, 2021 at 12:29 AM Jernej =C5=A0krabec <jernej.skrabec@gmail=
=2Ecom>=20
wrote:
> > Hi!
> >=20
> > Dne nedelja, 06. junij 2021 ob 11:03:55 CEST je guoren@kernel.org=20
napisal(a):
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >=20
> > > The RISC-V ISA doesn't yet specify how to query or modify PMAs, so let
> > > vendors define the custom properties of memory regions in PTE.
> > >=20
> > > This patchset helps SOC vendors to support their own custom interconn=
ect
> > > coherent solution with PTE attributes.
> > >=20
> > > For example, allwinner D1[1] uses T-HEAD C906 as main processor, C906
> > > has
> > >=20
> > > two modes in MMU:
> > >  - Compatible mode, the same as the definitions in spec.
> > >  - Enhanced mode, add custom DMA_COHERENT attribute bits in PTE which
> > > =20
> > >    not mentioned in spec.
> > >=20
> > > Allwinner D1 needs the enhanced mode to support the DMA type device w=
ith
> > > non-coherent interconnect in its SOC. C906 uses BITS(63 - 59) as cust=
om
> > > attribute bits in PTE.
> > >=20
> > > The patchset contain 4 parts (asid, pgtable, cmo, soc) which have been
> > >=20
> > > tested on D1:
> > >  - asid: T-HEAD C906 of D1 contains full asid hw facilities which has=
 no
> > > =20
> > >    conflict with RISC-V spec, and hope these patches soon could be
> > >    approved.
> > > =20
> > >  - pgtable: Using a image-hdr to pass vendor specific information and
> > > =20
> > >    setup custom PTE attributes in a global struct variable during boot
> > >    stage. Also it needs define custom protection_map in linux/mm.
> > > =20
> > >  - cmo: We need deal with dma_sync & icache_sync & __vdso_icache_sync.
> > > =20
> > >    In this patchset, I just show you how T-HEAD C9xx work, and seems
> > >    Atish
> > >    is working for the DMA infrustructure, please let me know the idea.
> > > =20
> > >  - soc: Add allwinner gmac driver & dts & Kconfig for sunxi test.
> > >=20
> > > The patchset could work with linux-5.13-rc4, here is the steps for D1:
> > >  - Download linux-5.13-rc4 and apply the patchset
> > >  - make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux- defconfig
> > >  - make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux- Image modules dtbs
> > >  - mkimage -A riscv -O linux -T kernel -C none -a 0x00200000 -e
> > >  0x00200000
> > >=20
> > > -n Linux -d arch/riscv/boot/Image uImage - Download newest opensbi [2=
],
> > > build with [3], and get fw_dynamic.bin - Copy uImage, fw_dynamic.bin,
> > > allwinner-d1-nezha-kit.dtb into boot partition of TF card.
> > >=20
> > >  - Plugin the TF card and power on D1.
> > >=20
> > > Link: https://linux-sunxi.org/D1 [1]
> > > Link: https://github.com/riscv/opensbi branch:master [2]
> > > Link:
> > > https://github.com/riscv/opensbi/blob/master/docs/platform/thead-c9xx=
=2Emd
> > > [3]
> >=20
> > Some patches are marked with v2 and some V5. It's very confusing. Mark
> > them
> > with same version in next revision.
> >=20
> > Best regards,
> > Jernej
> >=20
> > > Changes since v1:
> > >  - Rebase on linux-5.13-rc4
> > >  - Support defconfig for different PTE attributes
> > >  - Support C906 icache_sync
> > >  - Add Allwinner D1 dts & Kconfig & gmac for testing
> > >  - Add asid optimization for D1 usage
> > >=20
> > > Guo Ren (10):
> > >   riscv: asid: Use global mappings for kernel pages
> > >   riscv: asid: Add ASID-based tlbflushing methods
> > >   riscv: asid: Optimize tlbflush coding convention
> > >   riscv: pgtable: Fixup _PAGE_CHG_MASK usage
> > >   riscv: pgtable: Add custom protection_map init
> > >   riscv: pgtable: Add DMA_COHERENT with custom PTE attributes
> > >   riscv: cmo: Add dma-noncoherency support
> > >   riscv: cmo: Add vendor custom icache sync
> > >   riscv: soc: Initial DTS for Allwinner D1 NeZha board
> > >   riscv: soc: Add Allwinner SoC kconfig option
> > >=20
> > > liush (1):
> > >   riscv: soc: Allwinner D1 GMAC driver only for temp use
> > > =20
> > >  arch/riscv/Kconfig                                 |    9 +
> > >  arch/riscv/Kconfig.socs                            |   12 +
> > >  arch/riscv/boot/dts/Makefile                       |    1 +
> > >  arch/riscv/boot/dts/allwinner/Makefile             |    2 +
> > >  .../boot/dts/allwinner/allwinner-d1-nezha-kit.dts  |   29 +
> > >  arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi    |  100 +
> > >  arch/riscv/configs/defconfig                       |    1 +
> > >  arch/riscv/include/asm/cacheflush.h                |   48 +-
> > >  arch/riscv/include/asm/mmu_context.h               |    2 +
> > >  arch/riscv/include/asm/pgtable-64.h                |    8 +-
> > >  arch/riscv/include/asm/pgtable-bits.h              |   20 +-
> > >  arch/riscv/include/asm/pgtable.h                   |   44 +-
> > >  arch/riscv/include/asm/sbi.h                       |   15 +
> > >  arch/riscv/include/asm/soc.h                       |    1 +
> > >  arch/riscv/include/asm/tlbflush.h                  |   22 +
> > >  arch/riscv/include/asm/vendorid_list.h             |    1 +
> > >  arch/riscv/kernel/sbi.c                            |   19 +
> > >  arch/riscv/kernel/soc.c                            |   22 +
> > >  arch/riscv/kernel/vdso/flush_icache.S              |   33 +-
> > >  arch/riscv/mm/Makefile                             |    1 +
> > >  arch/riscv/mm/cacheflush.c                         |    3 +-
> > >  arch/riscv/mm/context.c                            |    2 +-
> > >  arch/riscv/mm/dma-mapping.c                        |   53 +
> > >  arch/riscv/mm/init.c                               |   26 +
> > >  arch/riscv/mm/tlbflush.c                           |   57 +-
> > >  drivers/net/ethernet/Kconfig                       |    1 +
> > >  drivers/net/ethernet/Makefile                      |    1 +
> > >  drivers/net/ethernet/allwinnertmp/Kconfig          |   17 +
> > >  drivers/net/ethernet/allwinnertmp/Makefile         |    7 +
> > >  drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c |  690 ++++++
> > >  drivers/net/ethernet/allwinnertmp/sunxi-gmac.c     | 2240
> > >=20
> > > ++++++++++++++++++++ drivers/net/ethernet/allwinnertmp/sunxi-gmac.h  =
 =20
> > > |
> > > 258 +++
> > >=20
> > >  drivers/net/phy/realtek.c                          |    2 +-
> > >  mm/mmap.c                                          |    4 +
> > >  34 files changed, 3714 insertions(+), 37 deletions(-)
> > >  create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
> > >  create mode 100644
> > >  arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > >=20
> > > create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > > create
> > > mode 100644 arch/riscv/mm/dma-mapping.c
> > >=20
> > >  create mode 100644 drivers/net/ethernet/allwinnertmp/Kconfig
> > >  create mode 100644 drivers/net/ethernet/allwinnertmp/Makefile
> > >  create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c
> > >  create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac.c
> > >  create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac.h




