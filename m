Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C3139D017
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 18:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFFQzV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 12:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhFFQzU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 12:55:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F324361408;
        Sun,  6 Jun 2021 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622998411;
        bh=PCUFcvjW5ZdETuEdS+iuJT4t+i6zWG2NG3M7MxBOHHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gglq4Xlt5gvuQ2fLEjSSCEa4SXhxH8EAJPmIoSJl5R4VFssDmKArB2wk7IQwzfdxd
         Ky3RQal+ElhyemZkSiSkNAaTf/aaowATH8TQvdmjOV1aH7XcTpzQSu3oDzotcCG+UP
         ckS4mXSbIRWBHZBHzQNN8MdLQDdHwQHrQlP7jPcGYUhQiQDFGPlEvVtjmfhhkR7xQX
         s/XW2EjXKdzDyNdNGPAgiwElC+pCxNj24NpgpbWv8IgZsmTSz626fwVkZ5sMTuHBDE
         Tc1cmWN3CjbJMp8md/019RLT2onFF8K1HK6FSb4A/NCjM0B9IxjUbTlz7+nPRQltOw
         UiR7do94hc3Qw==
Received: by mail-lj1-f181.google.com with SMTP id m3so18596075lji.12;
        Sun, 06 Jun 2021 09:53:30 -0700 (PDT)
X-Gm-Message-State: AOAM530wzO4XSAZWFETeTVftPEyfaWyqoTO3xJKdX6EqL95paqS+59vv
        wSgDCxRj5/LwBTHzDyPx1Pegn2jh44QfDoNzirU=
X-Google-Smtp-Source: ABdhPJzAAGqPqoJ/9s8vs6/WdE8E4ilC4UMPN8WuVGr0yxKfHLU/QAH6LQmWLKgXClq7E3ciDqVU172ziLiu5afqFXM=
X-Received: by 2002:a05:651c:502:: with SMTP id o2mr11713139ljp.105.1622998409312;
 Sun, 06 Jun 2021 09:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-15-git-send-email-guoren@kernel.org> <CAK8P3a0yHEGH8=o_TQ+ajRn53j+mHxYxqyYLPXnUe=YWkTHDBw@mail.gmail.com>
 <811499816.OAcyhOWOk8@jernej-laptop>
In-Reply-To: <811499816.OAcyhOWOk8@jernej-laptop>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Jun 2021 00:53:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTChtcDaznZSRvU6TvknkCH=St8Fv9Eux1tJDy+s1AagQ@mail.gmail.com>
Message-ID: <CAJF2gTTChtcDaznZSRvU6TvknkCH=St8Fv9Eux1tJDy+s1AagQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/11] riscv: soc: Allwinner D1 GMAC driver only
 for temp use
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup.patel@wdc.com>,
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

On Mon, Jun 7, 2021 at 12:32 AM Jernej =C5=A0krabec <jernej.skrabec@gmail.c=
om> wrote:
>
> Dne nedelja, 06. junij 2021 ob 18:16:44 CEST je Arnd Bergmann napisal(a):
> > On Sun, Jun 6, 2021 at 11:04 AM <guoren@kernel.org> wrote:
> > > diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > > b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts index
> > > cd9f7c9..31b681d 100644
> > > --- a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > > +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > > @@ -11,7 +11,7 @@
> > >
> > >         compatible =3D "allwinner,d1-nezha-kit";
> > >
> > >         chosen {
> > >
> > > -               bootargs =3D "console=3DttyS0,115200";
> > > +               bootargs =3D "console=3DttyS0,115200 rootwait init=3D=
/sbin/init
> > > root=3D/dev/nfs rw nfsroot=3D192.168.101.200:/tmp/rootfs_nfs,v3,tcp,n=
olock
> > > ip=3D192.168.101.23";
> > These are not board specific options, they should be set by the bootloa=
der
> > according to the network environment. It clearly doens't belong
> > into this patch .
> >
> > >                 stdout-path =3D &serial0;
> > >
> > >         };
> > >
> > > diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > > b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi index 11cd938..d317=
e19
> > > 100644
> > > --- a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > > +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > > @@ -80,5 +80,21 @@
> > >
> > >                         clocks =3D <&dummy_apb>;
> > >                         status =3D "disabled";
> > >
> > >                 };
> > >
> > > +
> > > +               eth@4500000 {
> > > +                       compatible =3D "allwinner,sunxi-gmac";
> > > +                       reg =3D <0x00 0x4500000 0x00 0x10000 0x00 0x3=
000030
> > > 0x00 0x04>; +                       interrupts-extended =3D <&plic 0x=
3e
> > > 0x04>;
> > > +                       interrupt-names =3D "gmacirq";
> > > +                       device_type =3D "gmac0";
> > > +                       phy-mode =3D "rgmii";
> > > +                       use_ephy25m =3D <0x01>;
> > > +                       tx-delay =3D <0x03>;
> > > +                       rx-delay =3D <0x03>;
> > > +                       gmac-power0;
> > > +                       gmac-power1;
> > > +                       gmac-power2;
> > > +                       status =3D "okay";
> > > +               };
> >
> > Before you add this in the dts file, the properties need to be document=
ed in
> > the binding file. The "allwinner,sunxi-gmac" identifier does not appear=
 to
> > be specific enough here, and the properties don't match what dwmac uses=
,
> > which would make it unnecessarily hard to change to the other driver la=
ter
> > on without breaking compatibility to old dtb files.
> >
> > > +++ b/drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c
> > > @@ -0,0 +1,690 @@
> > > +/*
> > > + * linux/drivers/net/ethernet/allwinner/sunxi_gmac_ops.c
> > > + *
> > > + * Copyright =C2=A9 2016-2018, fuzhaoke
> > > + *             Author: fuzhaoke <fuzhaoke@allwinnertech.com>
> > > + *
> > > + * This file is provided under a dual BSD/GPL license.  When using o=
r
> > > + * redistributing this file, you may do so under either license.
> >
> > Are you sure this is the correct copyright information and "fuzhaoke" i=
s
> > the copyright holder for this file? If this is derived from either the
> > designware
> > code or the Linux stmmac driver, the authors should be mentioned,
> > and the license be compatible with the original license terms.
> >
> > Andre already commented on the driver quality and code duplication, tho=
se
> > are also show-stoppers, but the unclear license terms and dt binding
> > compatibility are even stronger reasons to not get anywhere close to th=
is
> > driver.
>
> I got impression that this patch is not meant to be merged and it's forwa=
rd
> ported from vendor kernel as a stop gap measure for developers until prop=
er
> mainline ethernet driver is developed.
Yes

>
> Best regards,
> Jernej
>
>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
