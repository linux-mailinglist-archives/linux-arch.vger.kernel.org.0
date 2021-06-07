Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED08139D660
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhFGHz3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 03:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGHz2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 03:55:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 678746120F;
        Mon,  7 Jun 2021 07:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623052417;
        bh=bZf1oPujuHjZMOhIewYXXJEcGVTtrINZZrYSSOjle5w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NNznX+gSK1ubk2X3/IRC/NKUHBNtUpj3pIv/4c2uJBBiJUtAV/KhZcOXzgKlTc197
         JoaqNhfMIWWrKQn+ytYhGSXvaYtI570te4Vf2QyUsmIwnEioZqlYZoWTtD3s/olZ1r
         zXU5lkoWfLDBysgxbwtN+RMG+JJ6rSHG187xSFhIHkUpAhqI91/h8j7NLXHV+zL4Ya
         kzZSX1foXTx99yEqWn2UEdMCZtAFdYIHFVjM5lYuzSOaV0RKUi40RbmSeLfz2PBK7X
         uWdUT9XRikixdbajY+xQgkc2hyki1enBqAao5zY2bxSkhf1xV+/LbpZIJLfCEA4My/
         KUsm9jil4LFGg==
Received: by mail-lj1-f182.google.com with SMTP id d2so16745867ljj.11;
        Mon, 07 Jun 2021 00:53:37 -0700 (PDT)
X-Gm-Message-State: AOAM531rfeZGcq1+kM3rTS3rfR4v1pQcp+FkSr78r5f2nc3rP68Z5sD3
        oo5ksIIUIQJbSowZ8hfeK7+gE0YSgenWzg9cllk=
X-Google-Smtp-Source: ABdhPJwH/bIcZcv9bYZevLpASI9avmmDzuyYLA4C+R6RK/v/ZYHyxwKOcgETDO+RRKacBwp8wDxom+B3t+B9y1ptv1M=
X-Received: by 2002:a2e:3506:: with SMTP id z6mr14531480ljz.238.1623052415598;
 Mon, 07 Jun 2021 00:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-13-git-send-email-guoren@kernel.org> <2490489.OUOj5N01qN@jernej-laptop>
 <CAJF2gTTDVy89R-gvWUS0sgpX=B14LnH5rDoGP7pv1=OSyJq28Q@mail.gmail.com> <20210607072709.ul4jdvtyspj6t4c6@gilmour>
In-Reply-To: <20210607072709.ul4jdvtyspj6t4c6@gilmour>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Jun 2021 15:53:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS9+JYBg2dPEwQccNGku4_z_tv0qwgWQiFN8dQcQ=WweQ@mail.gmail.com>
Message-ID: <CAJF2gTS9+JYBg2dPEwQccNGku4_z_tv0qwgWQiFN8dQcQ=WweQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/11] riscv: soc: Initial DTS for Allwinner D1
 NeZha board
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Anup Patel <anup.patel@wdc.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thx for the clarification.

On Mon, Jun 7, 2021 at 3:27 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Jun 07, 2021 at 11:44:03AM +0800, Guo Ren wrote:
> > On Mon, Jun 7, 2021 at 12:26 AM Jernej =C5=A0krabec <jernej.skrabec@gma=
il.com> wrote:
> > >
> > > Hi!
> > >
> > > I didn't go through all details. After you fix all comments below, yo=
u should
> > > run "make dtbs_check" and fix all reported warnings too.
> > >
> > > Dne nedelja, 06. junij 2021 ob 11:04:07 CEST je guoren@kernel.org nap=
isal(a):
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Add initial DTS for Allwinner D1 NeZha board having only essential
> > > > devices (uart, dummy, clock, reset, clint, plic, etc).
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
> > > >  arch/riscv/boot/dts/Makefile                       |  1 +
> > > >  arch/riscv/boot/dts/allwinner/Makefile             |  2 +
> > > >  .../boot/dts/allwinner/allwinner-d1-nezha-kit.dts  | 29 ++++++++
> > > >  arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi    | 84
> > > > ++++++++++++++++++++++ 4 files changed, 116 insertions(+)
> > > >  create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
> > > >  create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1-nezh=
a-kit.dts
> > > > create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > > >
> > > > diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Mak=
efile
> > > > index fe996b8..3e7b264 100644
> > > > --- a/arch/riscv/boot/dts/Makefile
> > > > +++ b/arch/riscv/boot/dts/Makefile
> > > > @@ -2,5 +2,6 @@
> > > >  subdir-y +=3D sifive
> > > >  subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) +=3D canaan
> > > >  subdir-y +=3D microchip
> > > > +subdir-y +=3D allwinner
> > > >
> > > >  obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
> > > > diff --git a/arch/riscv/boot/dts/allwinner/Makefile
> > > > b/arch/riscv/boot/dts/allwinner/Makefile new file mode 100644
> > > > index 00000000..4adbf4b
> > > > --- /dev/null
> > > > +++ b/arch/riscv/boot/dts/allwinner/Makefile
> > > > @@ -0,0 +1,2 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +dtb-$(CONFIG_SOC_SUNXI) +=3D allwinner-d1-nezha-kit.dtb
> > > > diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.d=
ts
> > > > b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts new file=
 mode
> > > > 100644
> > > > index 00000000..cd9f7c9
> > > > --- /dev/null
> > > > +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > >
> > > Board DT names are comprised of soc name and board name, in this case=
 it would
> > > be "sun20i-d1-nezha-kit.dts"
> > >
> > > > @@ -0,0 +1,29 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > >
> > > Usually copyrights are added below spdx id.
> > >
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "allwinner-d1.dtsi"
> > > > +
> > > > +/ {
> > > > +     #address-cells =3D <2>;
> > > > +     #size-cells =3D <2>;
> > >
> > > This should be part of SoC level DTSI.
> > >
> > > > +     model =3D "Allwinner D1 NeZha Kit";
> > > > +     compatible =3D "allwinner,d1-nezha-kit";
> > >
> > > Board specific compatible string should be followed with SoC compatib=
le, in
> > > this case "allwinner,sun20i-d1".  You should document it too.
> > >
> > > > +
> > > > +     chosen {
> > > > +             bootargs =3D "console=3DttyS0,115200";
> > >
> > > Above line doesn't belong here. If anything, it should be added dynam=
ically by
> > > bootloader.
> >
> > After discussion, we still want to keep a default value here.
> > Sometimes we could boot with jtag and parse dtb is hard for gdbinit
> > script.
> >
> > >
> > > > +             stdout-path =3D &serial0;
> > > > +     };
> > > > +
> > > > +     memory@40000000 {
> > > > +             device_type =3D "memory";
> > > > +             reg =3D <0x0 0x40000000 0x0 0x20000000>;
> > > > +     };
> > >
> > > Ditto for whole memory node.
> >
> > Ditto
>
> The thing is that there's never a good value for a default. Let's take
> the memory node here: what would be a good default? If we want to make
> it work everywhere it's going to be the lowest amount of memory
> available on the D1 boards. It's going to be hard to maintain and very
> likely to be overlooked, resulting in broken boards anyway.
>
> If someone is savvy enough to use JTAG, it's not really difficult to
> modify the DT for their board when they need it.
okay, I see. I'll follow the rule in the next version of the patchset.

>
> Maxime



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
