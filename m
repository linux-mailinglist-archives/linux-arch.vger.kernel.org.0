Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07039D398
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 05:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFGDqS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 23:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFGDqH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 23:46:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7741B6121F;
        Mon,  7 Jun 2021 03:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623037456;
        bh=c60CDqV6p7Kd3UDTUiVAt24axwk5o6zlDQrBKbr7YCU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qyKAb1xsRD8NYbAev53bHKcf2b2q03vd3XXEpxouKKf5p0Z5XeZ0GUHrGIjGflQfu
         Q7XA4FUHiaQ8zCd5rnvxVxerMcS45K5a3HOBpMmfRH56r3EpDPQh1S9GWIYEUQd1bx
         yO9WuqtJtm346DqUyTsQgk+Zh4GxDCoMZ/9oOVMAmCW9UOLUq4K2RiITbK5bVdFp0S
         CG/LTGIiL5Kwq+xPcfViVMyxdgKGRcxOwlSoXbDZIfMebzH+DINbY6acxPodqriP8E
         EseS86/I/Ld+VS+3PBxifDPd18d9T7SZ9H8iMJ1fpMAl6Pipt3It6Y0EDUeBNJdJzq
         neWsQVHQybQAQ==
Received: by mail-lj1-f175.google.com with SMTP id c11so20187933ljd.6;
        Sun, 06 Jun 2021 20:44:16 -0700 (PDT)
X-Gm-Message-State: AOAM530ytW2dTXRyjIxo15HkkSXbJV6Zd+VRBMbNcFah1NuxzSUxEWJH
        6OrlmtaShO5fmefzdNM+TF/g3tPZMV0mrfi4b/I=
X-Google-Smtp-Source: ABdhPJxVwyq5zhei4IJxvlVnSxGqBmJFaiWoq+sWTDo9IriWGiiKvzTPtTJYdj8TU5zWiybFiqIm8X9VqGngTq2M6FI=
X-Received: by 2002:a05:651c:502:: with SMTP id o2mr13237819ljp.105.1623037454729;
 Sun, 06 Jun 2021 20:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-13-git-send-email-guoren@kernel.org> <2490489.OUOj5N01qN@jernej-laptop>
In-Reply-To: <2490489.OUOj5N01qN@jernej-laptop>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Jun 2021 11:44:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTDVy89R-gvWUS0sgpX=B14LnH5rDoGP7pv1=OSyJq28Q@mail.gmail.com>
Message-ID: <CAJF2gTTDVy89R-gvWUS0sgpX=B14LnH5rDoGP7pv1=OSyJq28Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/11] riscv: soc: Initial DTS for Allwinner D1
 NeZha board
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
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

On Mon, Jun 7, 2021 at 12:26 AM Jernej =C5=A0krabec <jernej.skrabec@gmail.c=
om> wrote:
>
> Hi!
>
> I didn't go through all details. After you fix all comments below, you sh=
ould
> run "make dtbs_check" and fix all reported warnings too.
>
> Dne nedelja, 06. junij 2021 ob 11:04:07 CEST je guoren@kernel.org napisal=
(a):
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add initial DTS for Allwinner D1 NeZha board having only essential
> > devices (uart, dummy, clock, reset, clint, plic, etc).
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
> >  arch/riscv/boot/dts/Makefile                       |  1 +
> >  arch/riscv/boot/dts/allwinner/Makefile             |  2 +
> >  .../boot/dts/allwinner/allwinner-d1-nezha-kit.dts  | 29 ++++++++
> >  arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi    | 84
> > ++++++++++++++++++++++ 4 files changed, 116 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
> >  create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-ki=
t.dts
> > create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> >
> > diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefil=
e
> > index fe996b8..3e7b264 100644
> > --- a/arch/riscv/boot/dts/Makefile
> > +++ b/arch/riscv/boot/dts/Makefile
> > @@ -2,5 +2,6 @@
> >  subdir-y +=3D sifive
> >  subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) +=3D canaan
> >  subdir-y +=3D microchip
> > +subdir-y +=3D allwinner
> >
> >  obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
> > diff --git a/arch/riscv/boot/dts/allwinner/Makefile
> > b/arch/riscv/boot/dts/allwinner/Makefile new file mode 100644
> > index 00000000..4adbf4b
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/allwinner/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +dtb-$(CONFIG_SOC_SUNXI) +=3D allwinner-d1-nezha-kit.dtb
> > diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts new file mod=
e
> > 100644
> > index 00000000..cd9f7c9
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
>
> Board DT names are comprised of soc name and board name, in this case it =
would
> be "sun20i-d1-nezha-kit.dts"
>
> > @@ -0,0 +1,29 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>
> Usually copyrights are added below spdx id.
>
> > +
> > +/dts-v1/;
> > +
> > +#include "allwinner-d1.dtsi"
> > +
> > +/ {
> > +     #address-cells =3D <2>;
> > +     #size-cells =3D <2>;
>
> This should be part of SoC level DTSI.
>
> > +     model =3D "Allwinner D1 NeZha Kit";
> > +     compatible =3D "allwinner,d1-nezha-kit";
>
> Board specific compatible string should be followed with SoC compatible, =
in
> this case "allwinner,sun20i-d1".  You should document it too.
>
> > +
> > +     chosen {
> > +             bootargs =3D "console=3DttyS0,115200";
>
> Above line doesn't belong here. If anything, it should be added dynamical=
ly by
> bootloader.
After discussion, we still want to keep a default value here.
Sometimes we could boot with jtag and parse dtb is hard for gdbinit
script.

>
> > +             stdout-path =3D &serial0;
> > +     };
> > +
> > +     memory@40000000 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x0 0x40000000 0x0 0x20000000>;
> > +     };
>
> Ditto for whole memory node.
Ditto

>
> > +
> > +     soc {
> > +     };
>
> There is no point having empty nodes.
>
> > +};
> > +
> > +&serial0 {
> > +     status =3D "okay";
> > +};
> > diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi new file mode 100644
> > index 00000000..11cd938
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
>
> Current naming approach for Allwinner SoC level DTSI is "sun20i-d1.dtsi".
>
> > @@ -0,0 +1,84 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +     #address-cells =3D <2>;
> > +     #size-cells =3D <2>;
>
> Since all peripherals and memory are below 4 GiB, why have 64-bit address=
es
> and sizes? It just clutters DT.
>
> > +     model =3D "Allwinner D1 Soc";
> > +     compatible =3D "allwinner,d1-nezha-kit";
>
> Compatible and model don't belong to SoC level DTSI.
>
> > +
> > +     chosen {
> > +     };
>
> Remove empty node.
>
> > +
> > +     cpus {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             timebase-frequency =3D <2400000>;
> > +             cpu@0 {
> > +                     device_type =3D "cpu";
> > +                     reg =3D <0>;
> > +                     status =3D "okay";
> > +                     compatible =3D "riscv";
> > +                     riscv,isa =3D "rv64imafdcv";
> > +                     mmu-type =3D "riscv,sv39";
> > +                     cpu0_intc: interrupt-controller {
> > +                             #interrupt-cells =3D <1>;
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +     };
> > +
> > +     soc {
> > +             #address-cells =3D <2>;
> > +             #size-cells =3D <2>;
> > +             compatible =3D "simple-bus";
> > +             ranges;
> > +
> > +             reset: reset-sample {
> > +                     compatible =3D "thead,reset-sample";
> > +                     plic-delegate =3D <0x0 0x101ffffc>;
> > +             };
> > +
> > +             clint: clint@14000000 {
> > +                     compatible =3D "riscv,clint0";
> > +                     interrupts-extended =3D <
> > +                             &cpu0_intc  3 &cpu0_intc  7
> > +                             >;
> > +                     reg =3D <0x0 0x14000000 0x0 0x04000000>;
> > +                     clint,has-no-64bit-mmio;
> > +             };
> > +
> > +             plic: interrupt-controller@10000000 {
> > +                     #interrupt-cells =3D <1>;
> > +                     compatible =3D "riscv,plic0";
> > +                     interrupt-controller;
> > +                     interrupts-extended =3D <
> > +                             &cpu0_intc  0xffffffff &cpu0_intc  9
> > +                             >;
> > +                     reg =3D <0x0 0x10000000 0x0 0x04000000>;
> > +                     reg-names =3D "control";
> > +                     riscv,max-priority =3D <7>;
> > +                     riscv,ndev =3D <200>;
> > +             };
> > +
> > +             dummy_apb: apb-clock {
> > +                     compatible =3D "fixed-clock";
> > +                     clock-frequency =3D <24000000>;
> > +                     clock-output-names =3D "dummy_apb";
> > +                     #clock-cells =3D <0>;
> > +             };
> > +
> > +             serial0: serial@2500000 {
>
> This should be uart0 and board should have alias for it. Check ARM based
> Allwinner DTs.
>
> Best regards,
> Jernej
>
> > +                     compatible =3D "snps,dw-apb-uart";
> > +                     reg =3D <0x0 0x02500000 0x0 0x400>;
> > +                     reg-io-width =3D <4>;
> > +                     reg-shift =3D <2>;
> > +                     interrupt-parent =3D <&plic>;
> > +                     interrupts =3D <18>;
> > +                     clocks =3D <&dummy_apb>;
> > +                     status =3D "disabled";
> > +             };
> > +     };
> > +};
>
>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
