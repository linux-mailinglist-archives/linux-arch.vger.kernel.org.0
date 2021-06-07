Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD7139D6C3
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 10:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbhFGIJp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 04:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhFGIJn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 04:09:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0178D6124B;
        Mon,  7 Jun 2021 08:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623053273;
        bh=gwgVr5c272t593y2hbVai/Z8i5e3WgEC6rqKmwLt5gk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D0VrrAd7gklOYFaN6ChWZc+RdjynB0Rc8D9ObxZinZUTZBbrcEhGH45cDmKBICGaO
         khCAsJvQdBK1GuWzfUrSLVeq3ixE2b15olqjfZeKa0h1SVlLrmXmedGby2wXicL9wq
         DHEI9daq2vYmTchuwi7wT5nT3iNW2MJ9+eGiAX94GnypYQFuqs4PYqjy75Tc0SeTuq
         Z7Cn4b+p2VxipC00KmOK+f4syk5YbpZPZyJicJ7Sk+OekbIfmBo5oKzUtjsjKx0E8t
         JMYXkKTtdKVb66HJrdQWMUqjSkKHwMY/mEfkDJKjsfaparAgk8x5jbXVS2+Si1/QDu
         smgygylAryUJA==
Received: by mail-lj1-f170.google.com with SMTP id x14so6611989ljp.7;
        Mon, 07 Jun 2021 01:07:52 -0700 (PDT)
X-Gm-Message-State: AOAM533gP7PTKeigEuqpNPb9C57zh6P0sVRG5Zi5gF+fn5vi9roWG/9A
        3zWsPZcICbit8tws/DWzNh3Vd2PEkDwE46xkiYI=
X-Google-Smtp-Source: ABdhPJxQwxzldkvMT2Zq76A9rwF/pw+Z7buOBHq1OvQ06vSkOjbCmmydHefXi5GC0MUf1nYm1BsIrpmiOK3ACBaRfKw=
X-Received: by 2002:a2e:8e90:: with SMTP id z16mr13480638ljk.508.1623053271241;
 Mon, 07 Jun 2021 01:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-13-git-send-email-guoren@kernel.org> <20210607072434.3g3bqxdlpxjirg6k@gilmour>
In-Reply-To: <20210607072434.3g3bqxdlpxjirg6k@gilmour>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Jun 2021 16:07:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTStppyEoLD-ZToeHYdnzNoFhH2+3Lhd76=M8OFKS=Syow@mail.gmail.com>
Message-ID: <CAJF2gTStppyEoLD-ZToeHYdnzNoFhH2+3Lhd76=M8OFKS=Syow@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/11] riscv: soc: Initial DTS for Allwinner D1
 NeZha board
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

On Mon, Jun 7, 2021 at 3:24 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> Thanks for the patches
>
> On Sun, Jun 06, 2021 at 09:04:07AM +0000, guoren@kernel.org wrote:
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
> >  arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi    | 84 ++++++++++++++++++++++
>
> Can you add the riscv folder to our MAINTAINERS entry as well?
Yes

>
> >  4 files changed, 116 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
> >  create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> >  create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> >
> > diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> > index fe996b8..3e7b264 100644
> > --- a/arch/riscv/boot/dts/Makefile
> > +++ b/arch/riscv/boot/dts/Makefile
> > @@ -2,5 +2,6 @@
> >  subdir-y += sifive
> >  subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
> >  subdir-y += microchip
> > +subdir-y += allwinner
>
> I assume they should be ordered alphabetically?
Thx for pointing it out.

>
> >  obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
> > diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts/allwinner/Makefile
> > new file mode 100644
> > index 00000000..4adbf4b
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/allwinner/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +dtb-$(CONFIG_SOC_SUNXI) += allwinner-d1-nezha-kit.dtb
> > diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > new file mode 100644
> > index 00000000..cd9f7c9
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > @@ -0,0 +1,29 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +/dts-v1/;
> > +
> > +#include "allwinner-d1.dtsi"
> > +
> > +/ {
> > +     #address-cells = <2>;
> > +     #size-cells = <2>;
> > +     model = "Allwinner D1 NeZha Kit";
> > +     compatible = "allwinner,d1-nezha-kit";
> > +
> > +     chosen {
> > +             bootargs = "console=ttyS0,115200";
> > +             stdout-path = &serial0;
> > +     };
> > +
> > +     memory@40000000 {
> > +             device_type = "memory";
> > +             reg = <0x0 0x40000000 0x0 0x20000000>;
> > +     };
> > +
> > +     soc {
> > +     };
> > +};
> > +
> > +&serial0 {
> > +     status = "okay";
> > +};
> > diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > new file mode 100644
> > index 00000000..11cd938
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > @@ -0,0 +1,84 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +     #address-cells = <2>;
> > +     #size-cells = <2>;
> > +     model = "Allwinner D1 Soc";
> > +     compatible = "allwinner,d1-nezha-kit";
> > +
> > +     chosen {
> > +     };
> > +
> > +     cpus {
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +             timebase-frequency = <2400000>;
> > +             cpu@0 {
> > +                     device_type = "cpu";
> > +                     reg = <0>;
> > +                     status = "okay";
> > +                     compatible = "riscv";
> > +                     riscv,isa = "rv64imafdcv";
> > +                     mmu-type = "riscv,sv39";
> > +                     cpu0_intc: interrupt-controller {
> > +                             #interrupt-cells = <1>;
> > +                             compatible = "riscv,cpu-intc";
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +     };
> > +
> > +     soc {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             compatible = "simple-bus";
> > +             ranges;
> > +
> > +             reset: reset-sample {
> > +                     compatible = "thead,reset-sample";
> > +                     plic-delegate = <0x0 0x101ffffc>;
> > +             };
>
> This compatible is not documented anywhere?
It used by opensbi (riscv runtime firmware), not in Linux. But I think
we should keep it.

>
> Maxime



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
