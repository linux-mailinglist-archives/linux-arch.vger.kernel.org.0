Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FDC5AACD2
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 12:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiIBKxR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 06:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIBKxQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 06:53:16 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF86C1654;
        Fri,  2 Sep 2022 03:53:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a15so1382719qko.4;
        Fri, 02 Sep 2022 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LGFWBpXGuGtPPFnyd0g7vGaOWidpAnEGhpM4DC7jOvU=;
        b=LQN7OCs87Q7FvHg8zuWABcEGqqz46CqxTMRZgyCtFDODSb4aVWVzKKohKOgRl80nJQ
         3spxwhsHptQb3FfaknuK3qJ2w88ZZWKvYPfc2VxtDO/D0gdhOozb5J6r+Oo9IzNxE/rx
         Qb1sZBiUmNMkxx8aF76b2JC4VpOqEjdYVudd4SNZj8Xrw8zWXOB9GS8rdGCh2DTuHblJ
         vV3E2ybZjvQB8RmXY0WMy+cGrX+b/po/PdVaYB4V8cOkE7joBx5w3pNcefJG1ET2t9iX
         8H/vWMl5LY3DoWaSMWGnmWDP2ps2UvRIVihRRM8lsil/jHehr/FiS+RVEsBDAeSnp3MH
         TQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LGFWBpXGuGtPPFnyd0g7vGaOWidpAnEGhpM4DC7jOvU=;
        b=Sx70aaKIwg98GcRDq/GKz8FCd5KIBwCYH858x0AuxaWji8lC571/Nhodwp5XDdDxas
         fx9WD+iwGIKVNtPTuXufXbhS6y8qbYzFOE2E8kNBN957w64+9l95GDvWWB9E5hFGWjCe
         BIs/GFs3Xe5v+0DA6taxcBibxoA1WUDLSNMAxCnWUh1awyCm2O/tGJaqaB6QzBp5u7CJ
         pEAxNbw7uFccZD/fVrpto28ZbbgQl2XOSiBlwpciRug4tqFLwc3VWQkch8aMrl5FbFy0
         dR5Nd0QW9NsAUu7mKmYUql4KuyT7FUo2Zhx7bLGejgEDgrVjF4p6l7KDLrSNvitwmnAA
         mDXg==
X-Gm-Message-State: ACgBeo2vOiO71O3YG1jZDzuXRvUxy5QyyOs6gPW4SyxglbORQmnJEPib
        3RboByMKXCpR2RGT8mfMB+4sNCGC7hXuOcCJ1H0=
X-Google-Smtp-Source: AA6agR4O6WI1xhAjVxdJci/isoGrXNz3yJRxhNxJOeaUWeLr1nI2zULs9b9MMXu3JWTyoUQJGRSKGFUKg1EXOPdGxT8=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr22678075qko.383.1662115994453; Fri, 02
 Sep 2022 03:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
 <abb46a587b76d379ad32d53817d837d8a5fea8bd.1661789204.git.christophe.leroy@csgroup.eu>
 <CAHp75VcngRihpfUkeKs-g+TbPnpOsZ+-Q37zDVoWp8p_2GbSvQ@mail.gmail.com>
 <18cda49e-84f0-a806-566a-6e77705e98b3@csgroup.eu> <1d548a19-feec-42b9-944d-890d6dde2fb8@www.fastmail.com>
In-Reply-To: <1d548a19-feec-42b9-944d-890d6dde2fb8@www.fastmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 13:52:37 +0300
Message-ID: <CAHp75VfF78rWpC6+i2Hu6-PMULFeFMbqXhBVRkx5aFGFTU3U4A@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] gpiolib: Get rid of ARCH_NR_GPIOS
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
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
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(Nuno, one point below for you)

On Wed, Aug 31, 2022 at 11:55 PM Arnd Bergmann <arnd@arndb.de> wrote:

...

> drivers/gpio/gpio-adp5520.c:    gc->base = pdata->gpio_start; // unused
> drivers/gpio/gpio-adp5588.c:            gc->base = pdata->gpio_start; // unused
> drivers/input/keyboard/adp5588-keys.c:  kpad->gc.base = gpio_data->gpio_start; // unused
> drivers/input/keyboard/adp5589-keys.c:  kpad->gc.base = gpio_data->gpio_start; // unused

I believe we should convert them to -1.

> drivers/gpio/gpio-bt8xx.c:      c->base = modparam_gpiobase; // from modprobe
> drivers/gpio/gpio-ich.c:        chip->base = modparam_gpiobase; // from modprobe

I believe it was designed for Intel hardware and so it can't be higher
than 512 - ngpios, where the latter one is small enough (dozen or a
couple of dozens of pins).

> drivers/gpio/gpio-dwapb.c:      port->gc.base = pp->gpio_base; // from DT, deprecated

From board files, since some platforms expect a fixed number for it.

> drivers/gpio/gpio-mockup.c:     gc->base = base; // module parama

This is for testing, so the test cases should be amended accordingly.
But I think the module itself is deprecated, and gpio-sim seems not
using it as a modprobe parameter, but rather as configfs.

> drivers/gpio/gpio-pca953x.c:    gc->base = chip->gpio_start; // ???? used a lot

To answer this one needs to go via all board files (most of them ARM
32-bit based) and look, but it means almost the same case as per Intel
above: 512-ngpios.

> drivers/pinctrl/renesas/gpio.c: gc->base = pfc->nr_gpio_pins; // ??? don't understand

I think, w/o looking into the code, that this just guarantees the
continuous numbering for all banks (chips) on the platform.

> drivers/pinctrl/stm32/pinctrl-stm32.c:          bank->gpio_chip.base = args.args[1];

Device Tree?!

-- 
With Best Regards,
Andy Shevchenko
