Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0196BAA8D
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 09:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjCOIRG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 15 Mar 2023 04:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCOIRF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 04:17:05 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4246286B;
        Wed, 15 Mar 2023 01:17:04 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id cu4so11638946qvb.3;
        Wed, 15 Mar 2023 01:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678868223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V0QfuKISCsuOFNxrXLROjtKcqlhxKao9KY/kU4MtCE=;
        b=Sz2J6d6/wEGEzzaDTff+nAWLIYyFRKYfvzBMi5TyGWkNvErIHDNFhNkBTEJOS7S3+o
         AGAr0xzSnSub8k32+tj5pxKDcM62QTMmishiE1IgYCVSsf3Poe9hmPZfL5pfgGk6dONu
         PKgfG24SKkt2Li5jMaZ2Y/+vtfPnQ2q7Jhd+vDm9sTfXdd2qG1YledC2m46s4beIYooz
         xfTXL3Y6AVJk3xiIegDY4Spr49vs1ZWDEMwuY6ZFOJCHePYQi0c7n9h+w9pejrxrpBw1
         aK4S7IN62dfieU5YJkAqoSjJCNywXbjx7jnWk79vrIeQljXAPXfp88pGFJB67LZytROx
         Vtvw==
X-Gm-Message-State: AO0yUKUwJUWYgTPUeqNREEnhvzTpbY+eawuxF8zXTElf2lEQYWvmoCDE
        MczGPiaqzQDIkGy15MSoE/sfOXg1cPUoIL1B
X-Google-Smtp-Source: AK7set9b4gjFSfD8vRQVIE3sF46b8E3Y1Dt5JH57Nq7usykqdSTmxhgmZA+ZsculXiDVGm+nk81CCg==
X-Received: by 2002:a05:622a:1991:b0:3d5:500a:4808 with SMTP id u17-20020a05622a199100b003d5500a4808mr1335796qtc.37.1678868223056;
        Wed, 15 Mar 2023 01:17:03 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id f2-20020ac86ec2000000b003a81eef14efsm3296268qtv.45.2023.03.15.01.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 01:17:02 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5416b0ab0ecso223862507b3.6;
        Wed, 15 Mar 2023 01:17:02 -0700 (PDT)
X-Received: by 2002:a81:ae5e:0:b0:541:a17f:c779 with SMTP id
 g30-20020a81ae5e000000b00541a17fc779mr6894792ywk.4.1678868221967; Wed, 15 Mar
 2023 01:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com> <20230314121216.413434-36-schnelle@linux.ibm.com>
In-Reply-To: <20230314121216.413434-36-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Mar 2023 09:16:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW4f8GJ-kFDPg6Ao=g3ZAXq79u9nUZ_dW1LonHu+vxk8Q@mail.gmail.com>
Message-ID: <CAMuHMdW4f8GJ-kFDPg6Ao=g3ZAXq79u9nUZ_dW1LonHu+vxk8Q@mail.gmail.com>
Subject: Re: [PATCH v3 35/38] video: handle HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
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
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Tue, Mar 14, 2023 at 1:13 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them and guard inline code in headers.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for your patch!

> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig

> @@ -1284,7 +1285,7 @@ config FB_ATY128_BACKLIGHT
>
>  config FB_ATY
>         tristate "ATI Mach64 display support" if PCI || ATARI
> -       depends on FB && !SPARC32
> +       depends on FB && HAS_IOPORT && !SPARC32

On Atari, this works without ATARI_ROM_ISA, hence it must not depend
on HAS_IOPORT.
The only call to inb() is inside a section protected by #ifdef
CONFIG_PCI. So:

    depends on FB && !SPARC32
    depends on ATARI || HAS_IOPORT

>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
