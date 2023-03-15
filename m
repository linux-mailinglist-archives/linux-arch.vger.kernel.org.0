Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27A36BAAEC
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 09:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCOIjY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 15 Mar 2023 04:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCOIjX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 04:39:23 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7623E1F4AE;
        Wed, 15 Mar 2023 01:39:21 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id op8so15419238qvb.11;
        Wed, 15 Mar 2023 01:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678869560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uK8SYGT7bTD8H1jPAKwresu1h0ClqZnQVBVABXZukEk=;
        b=X05VsDP+z/p1qbx2LcD2S55Mx7xuF5MfFd/lRpxPzU6LXWKlm8NI3raazMoLBn+cs9
         4SjbnI4NZuEFs+STO0kG9LmOPCU2c3utwXJTYJiJSsNAd8xQjs2s7b/9e+f8ftw4yUlK
         GkEkTWwY/4gntU8v+jRt+U+XtkJdDWLQRsePT2dlHTovM06az9klA3Mv8PjJMv7KrE7L
         y6feo2ZXfaDJlHBsW+LLL4k6jh30QcrfOKsgtUvqjRFgNVWmqSlXiuSvblnUMLhNG/kd
         IQeiv7eGL58ZvfS8MY+hMUEPScGLB6ro7dBPeqpwso4wEFdHhsjVbh0Nh7HWaG2qje/t
         9DKg==
X-Gm-Message-State: AO0yUKVsb5Y+0qQGRgNd5bKNtXXb5hIEk5rhFZzh8kCb2mIcdyIP3jIJ
        hchHxwiM+vR5ur4+u7pZmTrUD4fqhypTmusP
X-Google-Smtp-Source: AK7set+TIfKWkDNFAqiqL6XRg0WXzPq6qqVeJNIOmKj98qpQnoO8b03j813O1Dy8znNlVtCFo2lsaw==
X-Received: by 2002:a05:622a:3d1:b0:3c0:40c1:7a71 with SMTP id k17-20020a05622a03d100b003c040c17a71mr36429085qtx.66.1678869560320;
        Wed, 15 Mar 2023 01:39:20 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id s135-20020a37a98d000000b007290be5557bsm3308031qke.38.2023.03.15.01.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 01:39:19 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id r1so5686758ybu.5;
        Wed, 15 Mar 2023 01:39:19 -0700 (PDT)
X-Received: by 2002:a5b:68c:0:b0:b30:d9c:b393 with SMTP id j12-20020a5b068c000000b00b300d9cb393mr11119061ybq.12.1678869558588;
 Wed, 15 Mar 2023 01:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com> <20230314121216.413434-3-schnelle@linux.ibm.com>
In-Reply-To: <20230314121216.413434-3-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Mar 2023 09:39:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVry2YViJ5oFgo9i+uStWbhy7mXKWdWvCX=qgAu1-_Y1w@mail.gmail.com>
Message-ID: <CAMuHMdVry2YViJ5oFgo9i+uStWbhy7mXKWdWvCX=qgAu1-_Y1w@mail.gmail.com>
Subject: Re: [PATCH v3 02/38] ata: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Niklas,

On Tue, Mar 14, 2023 at 1:12 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for your patch!

> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -342,6 +342,7 @@ endif # HAS_DMA
>
>  config ATA_SFF
>         bool "ATA SFF support (for legacy IDE and PATA)"
> +       depends on HAS_IOPORT
>         default y
>         help
>           This option adds support for ATA controllers with SFF

ATA_SFF is a dependency for lots of (S)ATA drivers.
(at least) The following don't use I/O port access:

    CONFIG_SATA_RCAR (arm/arm64)
    CONFIG_PATA_FALCON (m68k/atari and m68k/q40)
    CONFIG_PATA_GAYLE (m68k/amiga)
    CONFIG_PATA_BUDDHA (m68k/amiga)

(at least) The following can use either MMIO or I/O port accesses:

    CONFIG_PATA_PLATFORM (m68k/mac)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
