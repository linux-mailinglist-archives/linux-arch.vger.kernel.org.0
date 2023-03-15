Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5DB6BAAAF
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 09:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjCOIXj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 15 Mar 2023 04:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjCOIXg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 04:23:36 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D3B40C2;
        Wed, 15 Mar 2023 01:23:30 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id nv15so15384045qvb.7;
        Wed, 15 Mar 2023 01:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678868610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaoW6/JdJH8lfXUx6KbDnZfqvHebZRWorOeb874e6r4=;
        b=VchdIcvTTDhOatXzudnq1ZkAdPGKKvInlXw69joXHFRjbeg3GVBgLndWnI71OICvBc
         4iL0XkHG6DG34nofJ7RBOvbyumYDO+j8RVlO148xksYdYKylc0kpR8rgfNmAmFb4YBr1
         lNYTIrTPfWYlI3wm5/sCOdf6YYoA97gT/1EjltUNFM89dbk5wepTuWtQzfMA7t4yFx5C
         7/ruJ/6ic3NCEXFxCDSXQ5HJw4o1ROs/4kJSS+c9KY1JofR7ohEPOw7Au1LZIZuBjczi
         GPDnxaqs3ssfoF9YYaZLshr5AEL9lJxVjWONUD7B0MxAuw/ohMHg7RljfpuFLLZ6ocif
         0GaQ==
X-Gm-Message-State: AO0yUKWH+gzShfWrDf13OCYeZS5YWCLxomab2LCNCLg1MrgQSvFC3coF
        BAhJv1ccIH7u7XYJDdf2WtteB9HvEcytoues
X-Google-Smtp-Source: AK7set+/QuD48RBcMyneZTsffzUy8QoPqxNYBNUGSYYkwcT6k3aWzfa7JjHPNwxHsGsGTJhS/xfNFg==
X-Received: by 2002:a05:6214:27c6:b0:5a1:451a:8d31 with SMTP id ge6-20020a05621427c600b005a1451a8d31mr22473603qvb.10.1678868609803;
        Wed, 15 Mar 2023 01:23:29 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id bs37-20020a05620a472500b00738e8e81dc9sm3368797qkb.75.2023.03.15.01.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 01:23:07 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id r1so5649845ybu.5;
        Wed, 15 Mar 2023 01:23:04 -0700 (PDT)
X-Received: by 2002:a5b:2cc:0:b0:a02:a3a6:78fa with SMTP id
 h12-20020a5b02cc000000b00a02a3a678famr20093284ybp.12.1678868583785; Wed, 15
 Mar 2023 01:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com> <20230314121216.413434-14-schnelle@linux.ibm.com>
In-Reply-To: <20230314121216.413434-14-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Mar 2023 09:22:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUbaFhb3HURhSfrkDyq_cz6z=S3TtTr0-5f6svho9MftQ@mail.gmail.com>
Message-ID: <CAMuHMdUbaFhb3HURhSfrkDyq_cz6z=S3TtTr0-5f6svho9MftQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/38] Input: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
        linux-input@vger.kernel.org
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

> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -75,6 +75,7 @@ config SERIO_Q40KBD
>  config SERIO_PARKBD
>         tristate "Parallel port keyboard adapter"
>         depends on PARPORT
> +       depends on HAS_IOPORT
>         help
>           Say Y here if you built a simple parallel port adapter to attach
>           an additional AT keyboard, XT keyboard or PS/2 mouse.

This driver seems to use only the parport and serio APIs, so it might
work on systems without HAS_IOPORT.  Dunno for sure.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
