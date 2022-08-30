Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89595A6E5F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 22:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiH3UVL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 16:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiH3UVK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 16:21:10 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83FE74DDC;
        Tue, 30 Aug 2022 13:21:08 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g14so9483112qto.11;
        Tue, 30 Aug 2022 13:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Bz05174cqW7AMJyc+1JWBKlip7+1YmmDgJ2cawhFu4c=;
        b=gj0Nt3Kfe7oKlaasQM0+pr69WnfRr6SXKyZpFUQn0OOmPGD1eNeaTX6dGK+w1p6EZV
         +rDx2cujr94wYsIKWm35MNqcnq7QKByDb2L/4TygQcZOJMDP/+1u6lkcW1PqRr7wTT4T
         8vqNF17itYMfobBmaaQOz5N1O6U325tWC+aS/ryAYcPWsVKP607APVOiSR0Vr78DjK50
         /3/umVXuzVTQni+o7FativAUOTelebzUmdKQj/Xi8gqXLFc9532TV+i73L+UFR8h9Mq8
         XcaZALp7iS4CPOWyozHBGXrsmFn9DrK165/phQSi4/X9I514bj/HqiLq3FQNmVnpHqZ2
         B5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Bz05174cqW7AMJyc+1JWBKlip7+1YmmDgJ2cawhFu4c=;
        b=bgayfL4MHjvXjgmkTNARtyu9aBW7MlHkwujJ5Yuh4n/JSKAb5ggDQ7rF/EYEjezHtr
         uUq93rkdH4uvQiMT76zLtVifrhyUWdpPuzczSg6ls/83OE73bfnfsbkrYajNapUJnIMV
         NhpZkZ3ig6GfOW9hbv38XvN2w4smVEPmEeh9dhnU/1EXHP1Qb9V1p60IfJaryah9ZBaA
         wm4OtpWOzn/uZ8ZinZ1VQltpakPOAEKEGDYULObK2BnpC/ToWC4EdZrhwYpgw4zcn4kb
         OBI5TW6JtxRJjeULAmQjW7Fj6r/2/3YZ+a1cecJW8xJ2ZXWPz93k2XyvnOFiqDMuRkaX
         JZjA==
X-Gm-Message-State: ACgBeo3uaR2ZSu0Swo3t4KjagvarqRF+yZvOP/fWcE2a+yOaBTr7ElF4
        bnWAgWNJW7nYN4IE1Xni6zXP1yrev7P6UvHGjXE=
X-Google-Smtp-Source: AA6agR4of83BnXvtH1YLHe2IfGvNgWbJOdijvYQwtUd6ZD4mR9Jg/N3+N6Cij8KJTFh2kZBkptMbjiTgWk2ltNGoaHk=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr16412498qtx.61.1661890867719; Tue, 30
 Aug 2022 13:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1661789204.git.christophe.leroy@csgroup.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Aug 2022 23:20:31 +0300
Message-ID: <CAHp75Vc5um3=gwnjoJNPxp+kbhFHT0Kp4gi1Qd+q5TL-y6-+oQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] gpio: Get rid of ARCH_NR_GPIOS (v1)
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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

On Mon, Aug 29, 2022 at 7:17 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Since commit 14e85c0e69d5 ("gpio: remove gpio_descs global array")
> there is no limitation on the number of GPIOs that can be allocated
> in the system since the allocation is fully dynamic.
>
> ARCH_NR_GPIOS is today only used in order to provide downwards
> gpiobase allocation from that value, while static allocation is
> performed upwards from 0. However that has the disadvantage of
> limiting the number of GPIOs that can be registered in the system.
>
> To overcome this limitation without requiring each and every
> platform to provide its 'best-guess' maximum number, rework the
> allocation to allocate from 256 upwards, allowing approx 2 millions
> of GPIOs.
>
> In the meantime, add a warning for drivers how are still doing
> static allocation, so that in the future the static allocation gets
> removed completely and dynamic allocation can start at base 0.

For non-commented (by me or others) patches
Reviewed-by: Andy Shevchenko <andy.shevchenko!gmail.com>
For the patch 1 if you are going to address as suggested by the author
of the driver, you may also add my tag.

> Christophe Leroy (8):
>   gpio: aggregator: Stop using ARCH_NR_GPIOS
>   gpio: davinci: Stop using ARCH_NR_GPIOS
>   gpiolib: Warn on drivers still using static gpiobase allocation
>   gpiolib: Get rid of ARCH_NR_GPIOS
>   Documentation: gpio: Remove text about ARCH_NR_GPIOS
>   x86: Remove CONFIG_ARCH_NR_GPIO
>   arm: Remove CONFIG_ARCH_NR_GPIO
>   arm64: Remove CONFIG_ARCH_NR_GPIO
>
>  Documentation/driver-api/gpio/legacy.rst |  5 ---
>  arch/arm/Kconfig                         | 21 ---------
>  arch/arm/include/asm/gpio.h              |  1 -
>  arch/arm64/Kconfig                       | 12 ------
>  arch/x86/Kconfig                         |  5 ---
>  drivers/gpio/gpio-aggregator.c           |  8 ++--
>  drivers/gpio/gpio-davinci.c              |  3 --
>  drivers/gpio/gpio-sta2x11.c              |  5 +--
>  drivers/gpio/gpiolib.c                   | 13 +++---
>  include/asm-generic/gpio.h               | 55 +++++++++---------------
>  10 files changed, 36 insertions(+), 92 deletions(-)
>
> --
> 2.37.1
>


-- 
With Best Regards,
Andy Shevchenko
