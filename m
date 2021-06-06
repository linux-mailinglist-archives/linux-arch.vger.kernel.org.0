Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B2539D015
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 18:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhFFQzG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 12:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhFFQzF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 12:55:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF3726143B;
        Sun,  6 Jun 2021 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622998395;
        bh=ppjcq7VkjHh/NHO3vr18zVl9plR0YmQ9qVLmLi4Sae4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SsgkBUl/7i3Itnk/2lYHQ6qkHBIdtlMQ97FPgEBiUoYr0MUafs8RAXPe8DUUEV4C5
         PIl2u36DcrOQBEFleqsoKaFavfm5qYyLz1lbACW2HBT+0wvNcpNQQ27+u/mnKFsL7u
         zBdq/+HM56zeXzA0tboM0KZIhTKM2NXI9mNHOlpZ721+WMQbhEFjIxYKB902yIk/9w
         vVj+h38nXxR7Seg+1Od61P85ynXtpmSDkinV+ns4ZJZvk0HAf+FZP1wDwbe0kvYUXh
         S9W7d+19pEUgxrFLXmnPLv3cY/5QXpqhhFRRW3EBxSrGVTBeo42WR/nGAwJ+P2NBQ8
         twVTKW8NwZzcQ==
Received: by mail-lj1-f169.google.com with SMTP id a4so18651373ljd.5;
        Sun, 06 Jun 2021 09:53:14 -0700 (PDT)
X-Gm-Message-State: AOAM530x19ZFthSQfej6jwZZeH2JV33FNriMfPogeA+dI1T7ZTnkMR2h
        HWGJ6VSh9BvoF+NUw+q9SU8AVzA0Ge9GhWuggN0=
X-Google-Smtp-Source: ABdhPJy9NxOQCV1ZlTuxLXychZNM2kX2ZVKFBTMqs91GG1T/HBvezNA7d5kTjc5TxQ1zjFWPC1Y5PAOynB67SzT8zZA=
X-Received: by 2002:a2e:320f:: with SMTP id y15mr11478502ljy.498.1622998392940;
 Sun, 06 Jun 2021 09:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-15-git-send-email-guoren@kernel.org> <CAK8P3a0yHEGH8=o_TQ+ajRn53j+mHxYxqyYLPXnUe=YWkTHDBw@mail.gmail.com>
In-Reply-To: <CAK8P3a0yHEGH8=o_TQ+ajRn53j+mHxYxqyYLPXnUe=YWkTHDBw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Jun 2021 00:53:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT-nBuOybOq3qsBhP7nJOexG36D=GMJaut1qqcm3p1Uuw@mail.gmail.com>
Message-ID: <CAJF2gTT-nBuOybOq3qsBhP7nJOexG36D=GMJaut1qqcm3p1Uuw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/11] riscv: soc: Allwinner D1 GMAC driver only
 for temp use
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Drew Fustini <drew@beagleboard.org>, liush@allwinnertech.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        wefu@redhat.com, linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sorry, wast your time reviewing the patch. It's not ready to merge,
just for the test.

On Mon, Jun 7, 2021 at 12:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Jun 6, 2021 at 11:04 AM <guoren@kernel.org> wrote:
>
> > diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts b=
/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > index cd9f7c9..31b681d 100644
> > --- a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > @@ -11,7 +11,7 @@
> >         compatible =3D "allwinner,d1-nezha-kit";
> >
> >         chosen {
> > -               bootargs =3D "console=3DttyS0,115200";
> > +               bootargs =3D "console=3DttyS0,115200 rootwait init=3D/s=
bin/init root=3D/dev/nfs rw nfsroot=3D192.168.101.200:/tmp/rootfs_nfs,v3,tc=
p,nolock ip=3D192.168.101.23";
>
> These are not board specific options, they should be set by the bootloade=
r
> according to the network environment. It clearly doens't belong
> into this patch .
>
> >                 stdout-path =3D &serial0;
> >         };
> >
> > diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi b/arch/ris=
cv/boot/dts/allwinner/allwinner-d1.dtsi
> > index 11cd938..d317e19 100644
> > --- a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > @@ -80,5 +80,21 @@
> >                         clocks =3D <&dummy_apb>;
> >                         status =3D "disabled";
> >                 };
> > +
> > +               eth@4500000 {
> > +                       compatible =3D "allwinner,sunxi-gmac";
> > +                       reg =3D <0x00 0x4500000 0x00 0x10000 0x00 0x300=
0030 0x00 0x04>;
> > +                       interrupts-extended =3D <&plic 0x3e 0x04>;
> > +                       interrupt-names =3D "gmacirq";
> > +                       device_type =3D "gmac0";
> > +                       phy-mode =3D "rgmii";
> > +                       use_ephy25m =3D <0x01>;
> > +                       tx-delay =3D <0x03>;
> > +                       rx-delay =3D <0x03>;
> > +                       gmac-power0;
> > +                       gmac-power1;
> > +                       gmac-power2;
> > +                       status =3D "okay";
> > +               };
>
> Before you add this in the dts file, the properties need to be documented=
 in
> the binding file. The "allwinner,sunxi-gmac" identifier does not appear t=
o
> be specific enough here, and the properties don't match what dwmac uses,
> which would make it unnecessarily hard to change to the other driver
> later on without breaking compatibility to old dtb files.
>
> > +++ b/drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c
> > @@ -0,0 +1,690 @@
> > +/*
> > + * linux/drivers/net/ethernet/allwinner/sunxi_gmac_ops.c
> > + *
> > + * Copyright =C2=A9 2016-2018, fuzhaoke
> > + *             Author: fuzhaoke <fuzhaoke@allwinnertech.com>
> > + *
> > + * This file is provided under a dual BSD/GPL license.  When using or
> > + * redistributing this file, you may do so under either license.
>
> Are you sure this is the correct copyright information and "fuzhaoke" is
> the copyright holder for this file? If this is derived from either the
> designware
> code or the Linux stmmac driver, the authors should be mentioned,
> and the license be compatible with the original license terms.
>
> Andre already commented on the driver quality and code duplication, those=
 are
> also show-stoppers, but the unclear license terms and dt binding compatib=
ility
> are even stronger reasons to not get anywhere close to this driver.
>
>         Arnd



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
