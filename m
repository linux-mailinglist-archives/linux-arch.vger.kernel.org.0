Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56E639D601
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 09:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhFGHbA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 03:31:00 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48689 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGHbA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 03:31:00 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MC3L9-1ldoQz0pDx-00CTKF; Mon, 07 Jun 2021 09:29:08 +0200
Received: by mail-wm1-f48.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso1193106wms.1;
        Mon, 07 Jun 2021 00:29:08 -0700 (PDT)
X-Gm-Message-State: AOAM531BZmiG3BBkO1ugwt2mFupnLmbH3U1YdziQqKp7pN643959Kl0B
        rtp7AEjtIUdEjtG2xDJ9FyrAqcrTdy5EkpKSOk4=
X-Google-Smtp-Source: ABdhPJx1sZM7+jb/Er05kwck+NjL97VzTgij1Tl9s8181a57Xul7USu5v5ud860aYtGnhwYz/l+yS+/2ilFrTbwmUPQ=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr15633427wmb.142.1623050947892;
 Mon, 07 Jun 2021 00:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-14-git-send-email-guoren@kernel.org> <20210607071916.kwdbtafbqp3icgia@gilmour>
In-Reply-To: <20210607071916.kwdbtafbqp3icgia@gilmour>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Jun 2021 09:27:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0YVh5T8MmUcAAjhxGBhNm_OeZq9S=rwAsZVMJNAttyOw@mail.gmail.com>
Message-ID: <CAK8P3a0YVh5T8MmUcAAjhxGBhNm_OeZq9S=rwAsZVMJNAttyOw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/11] riscv: soc: Add Allwinner SoC kconfig option
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Guo Ren <guoren@kernel.org>, Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Drew Fustini <drew@beagleboard.org>, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:aPORLvlDH2w1f7tqUEyZq9BKSn4Ke4GvGyAB0NAbwN/1c+7HBli
 5MsSf94ln9B6Wd0Ft6H5lQnka0dfZpn7qO9o5DGjBFU72G42HJ5insnQvwfqZBUDz2c2nzI
 f+a0CvwSh0nVcRibRdkcVTQ/utCUWKUgYLcVZ8+5fXhRbdPGD+eisz49An4VgmBpYNT0i7h
 TqdBAO81qikdIkv1Snx1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MWdlhbDtBRM=:d0hcH6YAbdet5Q3OmXW0BJ
 C32ztU+0DGgK+p5d/VbcZBcikRaJXRixLIp69CnaepxXucsVlQzo0QGFPiRr+cko71dtZm02x
 c5Au5Du5BklwGXW1WVZgAIsNUIhOc03zRnYrGEkrlOM+E7Ldrcq6cQSd101DFuveBqJzobuyf
 o2ATD21SIkUCpmKMJD25f/euyNXjSsSeK0cGvh/zh8h7nXwrzlTxGbSw2Sot7W/XenJpiHRXc
 MwSUSLidPJCvsB1T19wDskvF/5ihto3tZm0a+pHcNoYu2b/YbNC+/KUtrcDgytCNKG2vFTcFd
 UENHM0DHY2Dlh2CCPjFGRDu3iZdaJQQRuqFBU6gspLLbuvVUYLONra/YmtL2XZ1q3hN7IGAUN
 BDvwzF1D+cQIj/iwJSmNDQtoS+LXQ5OXM5deV0FwUPEm75ob3FGUdjfoovRPwgHGZZ5IFs6m+
 4N1LTA7UbPHQLv2CRpuWKW5nz7KbNpfexs6riXirdioj/NxQrPy+0nvG8OeghtJMTZf/JvCH2
 iMZmakLV4ywE6Ihq8O0S9DVTFugR8KAjQGbbq9hIGSnV9eITPd1JYxuWA3IjTWyFJsbW2oRxo
 PWzm+eMM5FrAfW0F5+tCsvgOsPjET2VkRoTJgr5s2g75T0YoaantdVI8Zr0374XpEnvsv8EpY
 3a7o=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 7, 2021 at 9:20 AM Maxime Ripard <maxime@cerno.tech> wrote:
> On Sun, Jun 06, 2021 at 09:04:08AM +0000, guoren@kernel.org wrote:

> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index ed96376..055fb3e 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -69,4 +69,16 @@ config SOC_CANAAN_K210_DTB_SOURCE
> >
> >  endif
> >
> > +config SOC_SUNXI
> > +     bool "Allwinner SoCs"
> > +     depends on MMU
> > +     select DWMAC_GENERIC
> > +     select SERIAL_8250
> > +     select SERIAL_8250_CONSOLE
> > +     select SERIAL_8250_DW
> > +     select SIFIVE_PLIC
> > +     select STMMAC_ETH
> > +     help
> > +       This enables support for Allwinner SoC platforms like the D1.
> > +
>
> We probably don't want to select DWMAC, STMMAC_ETH and the 8250 options,
> looks good otherwise.

Correct: those subsystems may be completely disabled, which would lead to a
build failure, and a platform should not force-enable drivers or
subsystems unless
those are build time dependencies.

       Arnd
