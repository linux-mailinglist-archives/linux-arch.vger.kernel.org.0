Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475BE7471A4
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 14:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjGDMqk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 4 Jul 2023 08:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjGDMqj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 08:46:39 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2A5FC;
        Tue,  4 Jul 2023 05:46:38 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5701eaf0d04so63442037b3.2;
        Tue, 04 Jul 2023 05:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688474797; x=1691066797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsNvAMnSUofmRnmSjEUJ3mWWbVeL8c/aa7qR+cnWQFc=;
        b=bpKdjo0PJRGD2hslPW3U84g02EoL7z+pWsCPBA/wA12i/bUeGyvtK5WEfhykj/Uive
         PhJ/B/5K6XYew87tIKJ3BD6DTv6Deq29L9m0p0gxwEFiXO+Plby3qVI6PBzE2wJ44tB8
         2fOPuuq0Jf61KLpXUY5gNTimBYVvRSEjHYc0SFDqxHD9QMGqRhj8FpT1b+C+OcUwFIeZ
         th6GJrYWsoAC11fzDXQ2U/lix6+QTWo1KvCdHw1S4MOuCbSZ8lPbCPsW8k8s/6K3reSK
         1mkd18WdOisYhkL+RAdY63biIPGAAJCLr2ocpHJ5YcZMXafijsxkA/GkGeWgWha4QN8r
         cVJA==
X-Gm-Message-State: ABy/qLaKwFcD/ouzeyyFTDel4+Qj1r+jSDM+S+XeeM9WRmq739QKKVoP
        32yTkjNEnlwPR8GJIt/iKOFqWhTP0idt1w==
X-Google-Smtp-Source: APBJJlEprUem1w4DutjWd/uw6IbAAIX0kkVfJEgSSavd8k2WOgnGt02uBNTvdhN7a1/CrM3xu0Of9g==
X-Received: by 2002:a25:ce8c:0:b0:c18:bbaa:754 with SMTP id x134-20020a25ce8c000000b00c18bbaa0754mr10944507ybe.51.1688474797062;
        Tue, 04 Jul 2023 05:46:37 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id g64-20020a25a4c6000000b00ba73c26f0d6sm4895523ybi.15.2023.07.04.05.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 05:46:35 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-c581c758ad8so1754570276.1;
        Tue, 04 Jul 2023 05:46:35 -0700 (PDT)
X-Received: by 2002:a25:6d02:0:b0:c5c:35d0:1c0f with SMTP id
 i2-20020a256d02000000b00c5c35d01c0fmr1671423ybc.20.1688474795342; Tue, 04 Jul
 2023 05:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-31-schnelle@linux.ibm.com> <CAMuHMdUAkRB9z2cqq6XBDKi-8zLyKxdw_PaT_TwLj78S5B6J8g@mail.gmail.com>
 <28a513fd-1e7c-4772-a3c1-f312938459ed@app.fastmail.com>
In-Reply-To: <28a513fd-1e7c-4772-a3c1-f312938459ed@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jul 2023 14:46:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWEx0F=fNei4Bz_JPkuvoaN-+zk08h0i8KnSi_VjO615g@mail.gmail.com>
Message-ID: <CAMuHMdWEx0F=fNei4Bz_JPkuvoaN-+zk08h0i8KnSi_VjO615g@mail.gmail.com>
Subject: Re: [PATCH v5 30/44] rtc: add HAS_IOPORT dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-rtc@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Tue, Jul 4, 2023 at 1:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jul 4, 2023, at 10:06, Geert Uytterhoeven wrote:
> > On Mon, May 22, 2023 at 12:51 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> >> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> >> not being declared. We thus need to add HAS_IOPORT as dependency for
> >> those drivers using them.
> >>
> >> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> >> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> >> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> >
> > Thanks for your patch, which is now commit 8bb12adb214b2d7c ("rtc:
> > add HAS_IOPORT dependencies") upstream.
> >
> >> --- a/drivers/rtc/Kconfig
> >> +++ b/drivers/rtc/Kconfig
> >> @@ -1193,7 +1195,7 @@ config RTC_DRV_MSM6242
> >>
> >>  config RTC_DRV_BQ4802
> >>         tristate "TI BQ4802"
> >> -       depends on HAS_IOMEM
> >> +       depends on HAS_IOMEM && HAS_IOPORT
> >>         help
> >>           If you say Y here you will get support for the TI
> >>           BQ4802 RTC chip.
> >
> > This driver can use either iomem or ioport.
> > By adding a dependency on HAS_IOPORT, it can no longer be used
> > on platforms that provide HAS_IOMEM only.
>
> You are correct, we could allow building this driver even
> without IOPORT and make it use ioport_map() or an #ifdef.
>
> > Probably the driver should be refactored to make it use only
> > the accessors that are available.
>
> Since the driver itself has no DT support, it looks like the
> only way it can be used is from the sparc64/ultra45 wrapper,
> but that architecture always provides CONFIG_IOPORT, so I
> don't think it makes any difference in the end. We can change
> this again if another user comes up.

Correct, I made the same reasoning after sending my previous email...

> It might be good to know whether the machine uses a memory or
> I/O resource in its device tree.

Indeed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
