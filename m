Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E724039D004
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFFQfo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 12:35:44 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38837 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhFFQfo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 12:35:44 -0400
Received: by mail-wr1-f48.google.com with SMTP id c9so5938550wrt.5;
        Sun, 06 Jun 2021 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WY+YV1R5ZgejabQGRTVw30i8+uym8jnUtOXA94/K5lw=;
        b=pDNjmTE9Fw2s8w/IYPMqwLkqVK0ZnfsZyN/vW6EZdkc8VQu8pqVkSoqHa/IFNWsah0
         Xk9BMZau+4UajqSK3D6dGg9P2rhhLCOmi49Thovi1uREAelVPdWtwCJLxP5qfadEmcAk
         b2BZ5h+5krfK1+iC/Y9oNZbhBtDU73wA3wE8xcB+jfluZLoEG4bVfDcWOvtrpwIwxMka
         pGHdyi+gkGIxMEUcjdmpiHN9Kn+clhkiEW8J2p/XBP+PlgVLPT9ckvUgFsLnaQ/B+foi
         RqwU+ggam2Xp/MYk7kvLqMZawzi/wp6yZ/Z9D12EerUa3MUOheTlO/q9Km5c7kScfYZ2
         FZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WY+YV1R5ZgejabQGRTVw30i8+uym8jnUtOXA94/K5lw=;
        b=Eawgr46hjtnqLJNqlUkQcdHTlCB8rtVJKAoCLJvVJmi83IGgly2/R0UFTP9o+PZ1VN
         XjZ/Ovl0cy6uQMfuVplvOo15R+r63YYbplQmep8HDVulFnITwFnFTNMR7LQyfppvnLPW
         jIBzcY/FgxBNMiD1XJTDDK4pLwkaDDbc38hl08BbIaFjp27vJeYkL8WKD+HZhW3z3oGa
         RMXJtqkX/14G+b5FBe2PBcosT9iQzUz8FIKkEMw1sfKxs7mcOTPcowUKS63cXo8gYTME
         mVh9ANP7quNtIpmKmDoWCxBXjUP3X32SDGm7Q36hUVzeNIqX8umIePQPEHQvE1R1UzGq
         KXLQ==
X-Gm-Message-State: AOAM530w4SjNCep1OE+0/ebhsJtq+iq3vi68u17MNp5CfVphswdZZmD/
        7LmAQ0J8DjX44OB0awluXg0=
X-Google-Smtp-Source: ABdhPJx9EE3POJCPH3kxhrEgOKzF6jzZizEM4HKXVQ6BY0PswtcBRetUeMuVDjcmubaKep41FB6ang==
X-Received: by 2002:adf:a28c:: with SMTP id s12mr13841510wra.105.1622997173876;
        Sun, 06 Jun 2021 09:32:53 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id w11sm13382470wrv.89.2021.06.06.09.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 09:32:53 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Drew Fustini <drew@beagleboard.org>, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH v2 11/11] riscv: soc: Allwinner D1 GMAC driver only for temp use
Date:   Sun, 06 Jun 2021 18:32:51 +0200
Message-ID: <811499816.OAcyhOWOk8@jernej-laptop>
In-Reply-To: <CAK8P3a0yHEGH8=o_TQ+ajRn53j+mHxYxqyYLPXnUe=YWkTHDBw@mail.gmail.com>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org> <1622970249-50770-15-git-send-email-guoren@kernel.org> <CAK8P3a0yHEGH8=o_TQ+ajRn53j+mHxYxqyYLPXnUe=YWkTHDBw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dne nedelja, 06. junij 2021 ob 18:16:44 CEST je Arnd Bergmann napisal(a):
> On Sun, Jun 6, 2021 at 11:04 AM <guoren@kernel.org> wrote:
> > diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts index
> > cd9f7c9..31b681d 100644
> > --- a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> > @@ -11,7 +11,7 @@
> >=20
> >         compatible =3D "allwinner,d1-nezha-kit";
> >        =20
> >         chosen {
> >=20
> > -               bootargs =3D "console=3DttyS0,115200";
> > +               bootargs =3D "console=3DttyS0,115200 rootwait init=3D/s=
bin/init
> > root=3D/dev/nfs rw nfsroot=3D192.168.101.200:/tmp/rootfs_nfs,v3,tcp,nol=
ock
> > ip=3D192.168.101.23";
> These are not board specific options, they should be set by the bootloader
> according to the network environment. It clearly doens't belong
> into this patch .
>=20
> >                 stdout-path =3D &serial0;
> >        =20
> >         };
> >=20
> > diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi index 11cd938..d317e19
> > 100644
> > --- a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> > @@ -80,5 +80,21 @@
> >=20
> >                         clocks =3D <&dummy_apb>;
> >                         status =3D "disabled";
> >                =20
> >                 };
> >=20
> > +
> > +               eth@4500000 {
> > +                       compatible =3D "allwinner,sunxi-gmac";
> > +                       reg =3D <0x00 0x4500000 0x00 0x10000 0x00 0x300=
0030
> > 0x00 0x04>; +                       interrupts-extended =3D <&plic 0x3e
> > 0x04>;
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
>=20
> Before you add this in the dts file, the properties need to be documented=
 in
> the binding file. The "allwinner,sunxi-gmac" identifier does not appear to
> be specific enough here, and the properties don't match what dwmac uses,
> which would make it unnecessarily hard to change to the other driver later
> on without breaking compatibility to old dtb files.
>=20
> > +++ b/drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c
> > @@ -0,0 +1,690 @@
> > +/*
> > + * linux/drivers/net/ethernet/allwinner/sunxi_gmac_ops.c
> > + *
> > + * Copyright =A9 2016-2018, fuzhaoke
> > + *             Author: fuzhaoke <fuzhaoke@allwinnertech.com>
> > + *
> > + * This file is provided under a dual BSD/GPL license.  When using or
> > + * redistributing this file, you may do so under either license.
>=20
> Are you sure this is the correct copyright information and "fuzhaoke" is
> the copyright holder for this file? If this is derived from either the
> designware
> code or the Linux stmmac driver, the authors should be mentioned,
> and the license be compatible with the original license terms.
>=20
> Andre already commented on the driver quality and code duplication, those
> are also show-stoppers, but the unclear license terms and dt binding
> compatibility are even stronger reasons to not get anywhere close to this
> driver.

I got impression that this patch is not meant to be merged and it's forward=
=20
ported from vendor kernel as a stop gap measure for developers until proper=
=20
mainline ethernet driver is developed.

Best regards,
Jernej




