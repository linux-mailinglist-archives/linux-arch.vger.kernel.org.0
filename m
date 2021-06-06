Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C1B39CFFB
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 18:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFFQUX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 6 Jun 2021 12:20:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:35155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhFFQUW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 12:20:22 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MKsWr-1m4Qzi2Vn3-00LBNb; Sun, 06 Jun 2021 18:18:31 +0200
Received: by mail-wr1-f50.google.com with SMTP id z8so14562410wrp.12;
        Sun, 06 Jun 2021 09:18:31 -0700 (PDT)
X-Gm-Message-State: AOAM531WPIApp/3dTACWgGwzv+YYXKyk4d8INGVJ9LV9PfSrdblW6HSr
        VGdLLOsCrnlb9WoHo+vzUdpbRw0HDGZyaOwTOAI=
X-Google-Smtp-Source: ABdhPJx9dKNalsIrm0Lf+lcVcT23HpzJ96dWZFvRiQpmmC6lCKzyeQIjKu301k2n374UAlf86nYIV+I5I0wPvzdJTug=
X-Received: by 2002:a5d:5084:: with SMTP id a4mr13649030wrt.286.1622996311239;
 Sun, 06 Jun 2021 09:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org> <1622970249-50770-15-git-send-email-guoren@kernel.org>
In-Reply-To: <1622970249-50770-15-git-send-email-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 6 Jun 2021 18:16:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0yHEGH8=o_TQ+ajRn53j+mHxYxqyYLPXnUe=YWkTHDBw@mail.gmail.com>
Message-ID: <CAK8P3a0yHEGH8=o_TQ+ajRn53j+mHxYxqyYLPXnUe=YWkTHDBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/11] riscv: soc: Allwinner D1 GMAC driver only
 for temp use
To:     Guo Ren <guoren@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:/MGZnMBDbvOBy2ufwzkv3Bpgism9RsJeJJIloGQt8nBNdPqZgpl
 K5vxUNNZ2BPmcynYaGguauDmlIZ2TJroeCnv1Lj9ZYc/HJDTc/FmChj0E0GVwvnzlFhKKyT
 xC2GYeMt5TdzKc9i5KSJ572+oMEStJksmTk2A0wZJbDVq91uHRxc5sfMcG4cbi7Qr8AjwBX
 j2M5Lj2cbCxlDHdrGBrMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kxD8Q8MOOes=:57tPMWwBsX0K3TZEELVhsM
 knMsYMUDKxfbKJsTgzXDrvKwQe7yszFG1VAo9wJnBPmJD861ZQUjUAbV2PavOua8cq4Ycua/P
 gMFXcFZua1YYblpZNMGqSnjBFIwh8rPqQPSInyH8l1BChM2zZ6DIQ8/ffNZSwOdK8UeL2TAho
 tthOcyRPz4Iz0F+UQlLyVFVfju1y5qGNEun+JUTrMkbgU45gKUeSQiBEIM3P4LcpB3MNw8cPV
 kkcaY40wXoCZhFXDc8H9Dc848LsSABnw4A348j/yhG3S+CrUVwufR9eNC+jV85N+prhApAjRK
 +G2G9pZYa7J4vJ0JcCra59jJhexxn8EPLjv3ayZ2dRrEsHpANMvfw0taRoD7xyYhVHbDC0qMD
 oOecRbbU/7qfhyIbG1RccIImxQIwk0aM5YAC3Rdd7AGxraP/+qUxu/5we1OJmXx2C2CpT2FLk
 ZDSWezZI6dBNnBrL17Wq8efDX4Ipw6gThP+UcV8ahylakl4J6GpGi/6FFDev7K9yythVBFBhO
 fDiOzl9LD5xtam8oqxv5CFBBFoB0QpcMyLuP99nRaB2ffptnFuBUtu21cePUjMPb6Tcftnjzl
 B16MM3QTpeyaR1eejrh6xY5okRHy2pKMgqZ0q7n2tQm/6sUBrZ8DnFs4ywJNLlwDqCHubIjQE
 oSIOKuIIscnEZEtzmVTkmjDKJi4vTsV+XZsexQosXBL0u+g==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 6, 2021 at 11:04 AM <guoren@kernel.org> wrote:

> diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> index cd9f7c9..31b681d 100644
> --- a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> @@ -11,7 +11,7 @@
>         compatible = "allwinner,d1-nezha-kit";
>
>         chosen {
> -               bootargs = "console=ttyS0,115200";
> +               bootargs = "console=ttyS0,115200 rootwait init=/sbin/init root=/dev/nfs rw nfsroot=192.168.101.200:/tmp/rootfs_nfs,v3,tcp,nolock ip=192.168.101.23";

These are not board specific options, they should be set by the bootloader
according to the network environment. It clearly doens't belong
into this patch .

>                 stdout-path = &serial0;
>         };
>
> diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> index 11cd938..d317e19 100644
> --- a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> @@ -80,5 +80,21 @@
>                         clocks = <&dummy_apb>;
>                         status = "disabled";
>                 };
> +
> +               eth@4500000 {
> +                       compatible = "allwinner,sunxi-gmac";
> +                       reg = <0x00 0x4500000 0x00 0x10000 0x00 0x3000030 0x00 0x04>;
> +                       interrupts-extended = <&plic 0x3e 0x04>;
> +                       interrupt-names = "gmacirq";
> +                       device_type = "gmac0";
> +                       phy-mode = "rgmii";
> +                       use_ephy25m = <0x01>;
> +                       tx-delay = <0x03>;
> +                       rx-delay = <0x03>;
> +                       gmac-power0;
> +                       gmac-power1;
> +                       gmac-power2;
> +                       status = "okay";
> +               };

Before you add this in the dts file, the properties need to be documented in
the binding file. The "allwinner,sunxi-gmac" identifier does not appear to
be specific enough here, and the properties don't match what dwmac uses,
which would make it unnecessarily hard to change to the other driver
later on without breaking compatibility to old dtb files.

> +++ b/drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c
> @@ -0,0 +1,690 @@
> +/*
> + * linux/drivers/net/ethernet/allwinner/sunxi_gmac_ops.c
> + *
> + * Copyright © 2016-2018, fuzhaoke
> + *             Author: fuzhaoke <fuzhaoke@allwinnertech.com>
> + *
> + * This file is provided under a dual BSD/GPL license.  When using or
> + * redistributing this file, you may do so under either license.

Are you sure this is the correct copyright information and "fuzhaoke" is
the copyright holder for this file? If this is derived from either the
designware
code or the Linux stmmac driver, the authors should be mentioned,
and the license be compatible with the original license terms.

Andre already commented on the driver quality and code duplication, those are
also show-stoppers, but the unclear license terms and dt binding compatibility
are even stronger reasons to not get anywhere close to this driver.

        Arnd
