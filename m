Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC3A5A5D5D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 09:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiH3Hv2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 03:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiH3Hv1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 03:51:27 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82473C875E;
        Tue, 30 Aug 2022 00:51:25 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id cb8so7969339qtb.0;
        Tue, 30 Aug 2022 00:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZkiMUlokxu0ZjwJhIo5t8XhexBqN5FwsjKKznRVGZ34=;
        b=axQ9vdhYx5urMZeQd6VwcPt1Ffm82QfTn6+rGRKmql3B8ptOLQcuarfClxWP45+/de
         G5pQX+OySyHKLO54/I3mgqnKywVnsmeuASbNuRsowaBX/I8A7TtivF1qnYcozsd+6Wl5
         gmMHi9gZSAqNJqLUrnu5uP4iKh7h0/yT/w/NQh3I1DV5/CwVyoCoB/wRFwOTNckEhPzw
         zNim08/aTmhh4NzWwnky+lnTsIPexx6WSHTPbUFMyPUs2C6rKw9L0xOK/Q1o2IqyAKVT
         ekcAMcsijDST1YfOTcNOj96V3FKk7sRnf5bgoS7WJkikgXqLxvievu8tqH3el6jcD7LY
         JK7w==
X-Gm-Message-State: ACgBeo0yk2vMfc0WDs5GHAG/GfHydR9FVnRcBoSyAGHW0/cG72hKbaCa
        wEs1wySwpvSo4OsSWHJsx3vmE+ejiLb+jA==
X-Google-Smtp-Source: AA6agR4T+HVEpLKyj8/eaZ4NCF32af2XmOqgREgWnT0IoGqV6+X2JtCi/XH3K5qIJ2XIQ6EyiYhzGQ==
X-Received: by 2002:ac8:5fd6:0:b0:343:4b4:1022 with SMTP id k22-20020ac85fd6000000b0034304b41022mr13554515qta.616.1661845883989;
        Tue, 30 Aug 2022 00:51:23 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id c7-20020ac80547000000b0031ee918e9f9sm6370689qth.39.2022.08.30.00.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:51:23 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-32a09b909f6so254064777b3.0;
        Tue, 30 Aug 2022 00:51:23 -0700 (PDT)
X-Received: by 2002:a25:d80b:0:b0:696:6d79:4891 with SMTP id
 p11-20020a25d80b000000b006966d794891mr11379827ybg.89.1661845882749; Tue, 30
 Aug 2022 00:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661789204.git.christophe.leroy@csgroup.eu> <621cf12492b03bb251d30078ae1594788d74529f.1661789204.git.christophe.leroy@csgroup.eu>
In-Reply-To: <621cf12492b03bb251d30078ae1594788d74529f.1661789204.git.christophe.leroy@csgroup.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Aug 2022 09:51:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVjkqpPqtmpHOfZsxappRf42x+V+Ze7qFAaMWPE6wzrOQ@mail.gmail.com>
Message-ID: <CAMuHMdVjkqpPqtmpHOfZsxappRf42x+V+Ze7qFAaMWPE6wzrOQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] gpio: aggregator: Stop using ARCH_NR_GPIOS
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christophe,

On Mon, Aug 29, 2022 at 6:15 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> ARCH_NR_GPIOS is used locally in aggr_parse() as the maximum number
> of GPIOs to be aggregated together by the driver since
> commit ec75039d5550 ("gpio: aggregator: Use bitmap_parselist() for
> parsing GPIO offsets").
>
> Don't rely on the total possible number of GPIOs in the system but
> define a local arbitrary macro for that, set to 512 which should be
> large enough as it is also the default value for ARCH_NR_GPIOS.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks for your patch!

> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -56,6 +56,8 @@ static int aggr_add_gpio(struct gpio_aggregator *aggr, const char *key,
>         return 0;
>  }
>
> +#define AGGREGATOR_MAX_GPIOS 512

I would insert this definition at the top, so it is not buried inside the code,
and easier to spot.

> +
>  static int aggr_parse(struct gpio_aggregator *aggr)
>  {
>         char *args = skip_spaces(aggr->args);

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
