Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453175AAD0A
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiIBLC1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 07:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiIBLC0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 07:02:26 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FAFC58EC;
        Fri,  2 Sep 2022 04:02:25 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id l5so1151434qtv.4;
        Fri, 02 Sep 2022 04:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dZTws1L2y2xyjbs91n4hGu/TU6dg0KKGjBmfL0/vaak=;
        b=aofngmOsGOIslWnPv0kCg6/DJjGt52Eh3RGbfiln+J5wyI+7p1HxTFggisKIJRM+zR
         tlLuy7xlPv08uTqW0NH/PbAe8+1LtA+41b6FA62gknkeEY97jdApDYOvnm8dsVsKAGA/
         DPU/d/3kEntm4ESAphszrPeyTlG4t2aiN085LJN/fyP2+rrsQH0Prx72o0oGSpITyOd6
         6V2mwjMilK3c6l8Bvjud0FYnYlyLal/gIcTZZwvzY7qri+5hXeNkGjOz155Ve0jpuOlp
         jymsTBsPNqwi8F+wrw2ej3d0xDbSDwJy6vWEzjC3Gbddow+FSB1gyuocfZ773BJtR07e
         wHNQ==
X-Gm-Message-State: ACgBeo3qGEIMXgXi9h5QnctZB2x5omtfpaOn/I/z3NSbLKtrV/HGUupF
        NxQqBuGwuWLFJp+BwwPUzXMcBqxjPSzRpg==
X-Google-Smtp-Source: AA6agR76vP7Mjxh6TP8BWzfMH1ghKzbUlRSbiuv5NFRKVUkG3DHdqfDFIg+pjA43PLVExa16S9+BIQ==
X-Received: by 2002:a05:622a:512:b0:343:6f1:a026 with SMTP id l18-20020a05622a051200b0034306f1a026mr27548265qtx.323.1662116543504;
        Fri, 02 Sep 2022 04:02:23 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id l21-20020a37f915000000b006bbe7ded98csm1128981qkj.112.2022.09.02.04.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 04:02:22 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-324ec5a9e97so12900707b3.7;
        Fri, 02 Sep 2022 04:02:22 -0700 (PDT)
X-Received: by 2002:a0d:e895:0:b0:340:ab79:3285 with SMTP id
 r143-20020a0de895000000b00340ab793285mr26854285ywe.358.1662116542087; Fri, 02
 Sep 2022 04:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
 <abb46a587b76d379ad32d53817d837d8a5fea8bd.1661789204.git.christophe.leroy@csgroup.eu>
 <CAHp75VcngRihpfUkeKs-g+TbPnpOsZ+-Q37zDVoWp8p_2GbSvQ@mail.gmail.com>
 <18cda49e-84f0-a806-566a-6e77705e98b3@csgroup.eu> <1d548a19-feec-42b9-944d-890d6dde2fb8@www.fastmail.com>
 <CAHp75VfF78rWpC6+i2Hu6-PMULFeFMbqXhBVRkx5aFGFTU3U4A@mail.gmail.com>
In-Reply-To: <CAHp75VfF78rWpC6+i2Hu6-PMULFeFMbqXhBVRkx5aFGFTU3U4A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 2 Sep 2022 13:02:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVVup8J0uge02H4u6o8NzxfkuFuZfExJ5u2M3FBE+RSAQ@mail.gmail.com>
Message-ID: <CAMuHMdVVup8J0uge02H4u6o8NzxfkuFuZfExJ5u2M3FBE+RSAQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] gpiolib: Get rid of ARCH_NR_GPIOS
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
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

Hi Andy,

CC linux-sh

On Fri, Sep 2, 2022 at 12:53 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Aug 31, 2022 at 11:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > drivers/pinctrl/renesas/gpio.c: gc->base = pfc->nr_gpio_pins; // ??? don't understand
>
> I think, w/o looking into the code, that this just guarantees the
> continuous numbering for all banks (chips) on the platform.

This part of the code depends on CONFIG_PINCTRL_SH_FUNC_GPIO,
which is used only on SH.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
