Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D345F39D242
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 01:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhFFXoW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 19:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhFFXoW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 19:44:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A3D16142A;
        Sun,  6 Jun 2021 23:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623022952;
        bh=i1uufPaK1BX0kA3BJtIl9yPmxo9PBjDZ/jrFo/GJyw8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jsw4onpLJwXT0KXYZXGW3YB6Vg+YSGoAwX3d3Xu76JlRgZfEKVwoILi+DdrFtRYBb
         vIKbV/NdZNA6kKUMDuAzfn1MZHy7FmY2ot2jaPegpbhRUHQ7Q+IDG2V3ZPkxqOeVq9
         1L3UOEhgcmCrjRlowgv5cmReuegRhUCTUm9MDdCLtyQ3jOSL1XJZYnsSgM9tW8JHW0
         KvWTo9msYTczNFXE7VfTjH2sRlA0ACJK0yvjwx6etF4mZSlDAikgdajrUIBjkabbnB
         bORdrWh+x75U7XaetDbeqJAQGmwDo/lnXzfLVxlv0xVnLbs9tvCAqr498DOgujIRrh
         yMBAoTu3oGayA==
Received: by mail-lf1-f42.google.com with SMTP id f11so23056763lfq.4;
        Sun, 06 Jun 2021 16:42:32 -0700 (PDT)
X-Gm-Message-State: AOAM530JitmclC1GrMxKwQjZhlVGjmdQf72JO3T6KClHrKlkYTOQ07LL
        MGY8WazC1u05VlIyxim/nGD1yqX5Pm7jjNIcaxQ=
X-Google-Smtp-Source: ABdhPJxvaxaFPrOwibMix35n1vL49cBzDLaWpXGSU6SIqkBBYbk+4WNMVtzOwyH2GWUvesqmouHHyNYsGl2aXhqhLJ8=
X-Received: by 2002:a05:6512:987:: with SMTP id w7mr9954573lft.41.1623022950504;
 Sun, 06 Jun 2021 16:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <3110420.cQCZQDpDj9@jernej-laptop> <CAJF2gTQ1yvSNthJ2yJkqaYGaJ6OYmf0vbG=hm4ocgnw4DiZbOw@mail.gmail.com>
 <1664140.l4xsYfQU8q@jernej-laptop>
In-Reply-To: <1664140.l4xsYfQU8q@jernej-laptop>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Jun 2021 07:42:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR6zV8GuftZ1M69Ma2rxy31KvMBVjyB8G40JnyY4D+0Gw@mail.gmail.com>
Message-ID: <CAJF2gTR6zV8GuftZ1M69Ma2rxy31KvMBVjyB8G40JnyY4D+0Gw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] riscv: Add DMA_COHERENT support for
 Allwinner D1
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, wens@csie.org,
        maxime@cerno.tech, Drew Fustini <drew@beagleboard.org>,
        liush@allwinnertech.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        wefu@redhat.com, linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 7, 2021 at 1:14 AM Jernej =C5=A0krabec <jernej.skrabec@gmail.co=
m> wrote:
>
> Dne nedelja, 06. junij 2021 ob 18:54:05 CEST je Guo Ren napisal(a):
> > V5 is not related to the patch series.
>
> Don't top post.
>
> If that's the case, then your e-mail client messed things up. I got V5 pa=
tches
> in the same thread as board enablement patches and so did mailing list [1=
].
I made mistake that make two patchset mixed in my linux directory.

git format-patch -11
git send-email *.patch

But there are still some last posted patches in *.patch.

I'll prevent it in the next patchset version.

>
> Best regards,
> Jernej
>
> [1] https://lore.kernel.org/linux-sunxi/
> CAJF2gTQ1yvSNthJ2yJkqaYGaJ6OYmf0vbG=3Dhm4ocgnw4DiZbOw@mail.gmail.com/T/#t
>
> >
> > On Mon, Jun 7, 2021 at 12:29 AM Jernej =C5=A0krabec <jernej.skrabec@gma=
il.com>
> wrote:
> > > Hi!
> > >
> > > Dne nedelja, 06. junij 2021 ob 11:03:55 CEST je guoren@kernel.org
> napisal(a):
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > The RISC-V ISA doesn't yet specify how to query or modify PMAs, so =
let
> > > > vendors define the custom properties of memory regions in PTE.
> > > >
> > > > This patchset helps SOC vendors to support their own custom interco=
nnect
> > > > coherent solution with PTE attributes.
> > > >
> > > > For example, allwinner D1[1] uses T-HEAD C906 as main processor, C9=
06
> > > > has
> > > >
> > > > two modes in MMU:
> > > >  - Compatible mode, the same as the definitions in spec.
> > > >  - Enhanced mode, add custom DMA_COHERENT attribute bits in PTE whi=
ch
> > > >
> > > >    not mentioned in spec.
> > > >
> > > > Allwinner D1 needs the enhanced mode to support the DMA type device=
 with
> > > > non-coherent interconnect in its SOC. C906 uses BITS(63 - 59) as cu=
stom
> > > > attribute bits in PTE.
> > > >
> > > > The patchset contain 4 parts (asid, pgtable, cmo, soc) which have b=
een
> > > >
> > > > tested on D1:
> > > >  - asid: T-HEAD C906 of D1 contains full asid hw facilities which h=
as no
> > > >
> > > >    conflict with RISC-V spec, and hope these patches soon could be
> > > >    approved.
> > > >
> > > >  - pgtable: Using a image-hdr to pass vendor specific information a=
nd
> > > >
> > > >    setup custom PTE attributes in a global struct variable during b=
oot
> > > >    stage. Also it needs define custom protection_map in linux/mm.
> > > >
> > > >  - cmo: We need deal with dma_sync & icache_sync & __vdso_icache_sy=
nc.
> > > >
> > > >    In this patchset, I just show you how T-HEAD C9xx work, and seem=
s
> > > >    Atish
> > > >    is working for the DMA infrustructure, please let me know the id=
ea.
> > > >
> > > >  - soc: Add allwinner gmac driver & dts & Kconfig for sunxi test.
> > > >
> > > > The patchset could work with linux-5.13-rc4, here is the steps for =
D1:
> > > >  - Download linux-5.13-rc4 and apply the patchset
> > > >  - make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux- defconfig
> > > >  - make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux- Image modules d=
tbs
> > > >  - mkimage -A riscv -O linux -T kernel -C none -a 0x00200000 -e
> > > >  0x00200000
> > > >
> > > > -n Linux -d arch/riscv/boot/Image uImage - Download newest opensbi =
[2],
> > > > build with [3], and get fw_dynamic.bin - Copy uImage, fw_dynamic.bi=
n,
> > > > allwinner-d1-nezha-kit.dtb into boot partition of TF card.
> > > >
> > > >  - Plugin the TF card and power on D1.
> > > >
> > > > Link: https://linux-sunxi.org/D1 [1]
> > > > Link: https://github.com/riscv/opensbi branch:master [2]
> > > > Link:
> > > > https://github.com/riscv/opensbi/blob/master/docs/platform/thead-c9=
xx.md
> > > > [3]
> > >
> > > Some patches are marked with v2 and some V5. It's very confusing. Mar=
k
> > > them
> > > with same version in next revision.
> > >
> > > Best regards,
> > > Jernej
> > >
> > > > Changes since v1:
> > > >  - Rebase on linux-5.13-rc4
> > > >  - Support defconfig for different PTE attributes
> > > >  - Support C906 icache_sync
> > > >  - Add Allwinner D1 dts & Kconfig & gmac for testing
> > > >  - Add asid optimization for D1 usage
> > > >
> > > > Guo Ren (10):
> > > >   riscv: asid: Use global mappings for kernel pages
> > > >   riscv: asid: Add ASID-based tlbflushing methods
> > > >   riscv: asid: Optimize tlbflush coding convention
> > > >   riscv: pgtable: Fixup _PAGE_CHG_MASK usage
> > > >   riscv: pgtable: Add custom protection_map init
> > > >   riscv: pgtable: Add DMA_COHERENT with custom PTE attributes
> > > >   riscv: cmo: Add dma-noncoherency support
> > > >   riscv: cmo: Add vendor custom icache sync
> > > >   riscv: soc: Initial DTS for Allwinner D1 NeZha board
> > > >   riscv: soc: Add Allwinner SoC kconfig option
> > > >
> > > > liush (1):
> > > >   riscv: soc: Allwinner D1 GMAC driver only for temp use
> > > >
> > > >  arch/riscv/Kconfig                                 |    9 +
> > > >  arch/riscv/Kconfig.socs                            |   12 +
> > > >  arch/riscv/boot/dts/Makefile                       |    1 +
> > > >  arch/riscv/boot/dts/allwinner/Makefile             |    2 +
> > > >  .../boot/dts/allwinner/allwinner-d1-nezha-kit.dts  |   29 +
> > > >  arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi    |  100 +
> > > >  arch/riscv/configs/defconfig                       |    1 +
> > > >  arch/riscv/include/asm/cacheflush.h                |   48 +-
> > > >  arch/riscv/include/asm/mmu_context.h               |    2 +
> > > >  arch/riscv/include/asm/pgtable-64.h                |    8 +-
> > > >  arch/riscv/include/asm/pgtable-bits.h              |   20 +-
> > > >  arch/riscv/include/asm/pgtable.h                   |   44 +-
> > > >  arch/riscv/include/asm/sbi.h                       |   15 +
> > > >  arch/riscv/include/asm/soc.h                       |    1 +
> > > >  arch/riscv/include/asm/tlbflush.h                  |   22 +
> > > >  arch/riscv/include/asm/vendorid_list.h             |    1 +
> > > >  arch/riscv/kernel/sbi.c                            |   19 +
> > > >  arch/riscv/kernel/soc.c                            |   22 +
> > > >  arch/riscv/kernel/vdso/flush_icache.S              |   33 +-
> > > >  arch/riscv/mm/Makefile                             |    1 +
> > > >  arch/riscv/mm/cacheflush.c                         |    3 +-
> > > >  arch/riscv/mm/context.c                            |    2 +-
> > > >  arch/riscv/mm/dma-mapping.c                        |   53 +
> > > >  arch/riscv/mm/init.c                               |   26 +
> > > >  arch/riscv/mm/tlbflush.c                           |   57 +-
> > > >  drivers/net/ethernet/Kconfig                       |    1 +
> > > >  drivers/net/ethernet/Makefile                      |    1 +
> > > >  drivers/net/ethernet/allwinnertmp/Kconfig          |   17 +
> > > >  drivers/net/ethernet/allwinnertmp/Makefile         |    7 +
> > > >  drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c |  690 ++++++
> > > >  drivers/net/ethernet/allwinnertmp/sunxi-gmac.c     | 2240
> > > >
> > > > ++++++++++++++++++++ drivers/net/ethernet/allwinnertmp/sunxi-gmac.h
> > > > |
> > > > 258 +++
> > > >
> > > >  drivers/net/phy/realtek.c                          |    2 +-
> > > >  mm/mmap.c                                          |    4 +
> > > >  34 files changed, 3714 insertions(+), 37 deletions(-)
> > > >  create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
> > > >  create mode 100644
> > > >  arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > > >
> > > > create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > > > create
> > > > mode 100644 arch/riscv/mm/dma-mapping.c
> > > >
> > > >  create mode 100644 drivers/net/ethernet/allwinnertmp/Kconfig
> > > >  create mode 100644 drivers/net/ethernet/allwinnertmp/Makefile
> > > >  create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac-op=
s.c
> > > >  create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac.c
> > > >  create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac.h
>
>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
