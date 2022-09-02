Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A185AB509
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 17:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiIBP0O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbiIBPZ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 11:25:27 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D5A11A0E;
        Fri,  2 Sep 2022 07:58:38 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id jy14so1573609qvb.12;
        Fri, 02 Sep 2022 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2d5MdwjguIxwbj6Za95JVK80ynCPGt/Wk3co+Z7DYxk=;
        b=IdQCyPv5b/J4rZljCG/duWqbyByLgWx/0+dz9x+Wurb3kpyGt3XOVrrsTTGICh35Z2
         AamGXZYk9lhjmLXff2CVSGZbnMQ2hWYSm6XaJ4oLD0z7H8ReLGrAxNcx2jNt51TIsAUN
         P6MqidRYeN1ux+wqPPoa5jSCTMZabastalRQVZvfxU4otLyr3eIPPqtqM/kZHTilhAKY
         S2RScwUg/rrgTBhoGG8J4zCgorzKO1vUQes2aQHffVggLbF7ZE6F79Ocd++UlY7M0UxQ
         ZZYE096imLhkE0vYC32jORJ2mV+xqEkMAGjjHEvFviHMtmPZZJV7GY+wUf6z4JFDnnPl
         288g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2d5MdwjguIxwbj6Za95JVK80ynCPGt/Wk3co+Z7DYxk=;
        b=8AYVfNxCV1EOdeX6GQwN6z7xNStXyVpCRN+aHaOo1AunkuWNIvwe63gG0CEorDk+E2
         ReeGp2hDI7J7AdpUDJ6mqkL1c3OrfbkPvwrVmOg57Yvoh3N/VSRRcDI7EIO9ctbiV23L
         SRu/04P5seKVZH7+LSrEpCuvTmT6uZHdML7oZP2PubBpZc/JnGa18kUmoJ+/O5aNTyFY
         +4F0oJMOyCQ909lINrkGeOsmGIG67clThKk3L+gJ/rouAVa0EyP2sNDhx8w63bCUTCFm
         t+7V7F2qmUewnIrI1yhrMRfIRtd+UZEtPZ0UzgsoiPve3606l687Lf9cabsoGZM6jXrw
         pQZA==
X-Gm-Message-State: ACgBeo0uM/2m6gN+b1eYGTSaakFz4tALNN66iGQRrZwWebyDWcMdMhgP
        zizBKG9yEGMoAcIIZ8BGPqyfbT/3+ryB7I/dk0I=
X-Google-Smtp-Source: AA6agR4U4C8fAMU0i3LIRRlTdojE81WLiwuDEgOyaYmkse0bdgODkqUo3kIXspGe9h6sAtCI8gNvo3iNhuy3sitJW0s=
X-Received: by 2002:a05:6214:c26:b0:499:19f1:1a73 with SMTP id
 a6-20020a0562140c2600b0049919f11a73mr13781988qvd.48.1662130716955; Fri, 02
 Sep 2022 07:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662116601.git.christophe.leroy@csgroup.eu> <97011204619556ecb3d8c9aaff2b58c28790fe8a.1662116601.git.christophe.leroy@csgroup.eu>
In-Reply-To: <97011204619556ecb3d8c9aaff2b58c28790fe8a.1662116601.git.christophe.leroy@csgroup.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 17:58:01 +0300
Message-ID: <CAHp75Ve6zMC9s=TZT_pWoyxnKtXE0xipFCv_RDY4r4amnVbVxQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] gpiolib: Get rid of ARCH_NR_GPIOS
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
        Davide Ciminaghi <ciminaghi@gnudd.com>,
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

On Fri, Sep 2, 2022 at 4:57 PM Christophe Leroy
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
> allocation to allocate upwards, allowing approx 2 millions of
> GPIOs.
>
> In order to still allow static allocation for legacy drivers, define
> GPIO_DYNAMIC_BASE with the value 512 as the start for dynamic
> allocation. The 512 value is chosen because it is the end of
> the current default range so all current static allocations are
> expected to be below that value. Of course that's just a rough
> estimate based on the default value, but assuming static
> allocations come first, even if there are more static allocations
> it should fit under the 512 value.
>
> In the future, it is expected that all static allocations go away
> and then dynamic allocation will be patched to start at 0.

Eventually we have to get rid of gpio_is_valid() completely...
But this is another story.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Enhanced commit description and change from 256 to 512.
> ---
>  arch/arm/include/asm/gpio.h |  1 -
>  drivers/gpio/gpiolib.c      | 10 +++----
>  include/asm-generic/gpio.h  | 55 ++++++++++++++-----------------------
>  3 files changed, 26 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index f3bb8a2bf788..4ebbb58f06ea 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -2,7 +2,6 @@
>  #ifndef _ARCH_ARM_GPIO_H
>  #define _ARCH_ARM_GPIO_H
>
> -/* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
>  #include <asm-generic/gpio.h>
>
>  /* The trivial gpiolib dispatchers */
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 4e2fcb7b0a01..1846f24971e3 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -183,14 +183,14 @@ EXPORT_SYMBOL_GPL(gpiod_to_chip);
>  static int gpiochip_find_base(int ngpio)
>  {
>         struct gpio_device *gdev;
> -       int base = ARCH_NR_GPIOS - ngpio;
> +       int base = GPIO_DYNAMIC_BASE;
>
> -       list_for_each_entry_reverse(gdev, &gpio_devices, list) {
> +       list_for_each_entry(gdev, &gpio_devices, list) {
>                 /* found a free space? */
> -               if (gdev->base + gdev->ngpio <= base)
> +               if (gdev->base >= base + ngpio)
>                         break;
> -               /* nope, check the space right before the chip */
> -               base = gdev->base - ngpio;
> +               /* nope, check the space right after the chip */
> +               base = gdev->base + gdev->ngpio;
>         }
>
>         if (gpio_is_valid(base)) {
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index aea9aee1f3e9..a7752cf152ce 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -11,40 +11,18 @@
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/consumer.h>
>
> -/* Platforms may implement their GPIO interface with library code,
> +/*
> + * Platforms may implement their GPIO interface with library code,
>   * at a small performance cost for non-inlined operations and some
>   * extra memory (for code and for per-GPIO table entries).
> - *
> - * While the GPIO programming interface defines valid GPIO numbers
> - * to be in the range 0..MAX_INT, this library restricts them to the
> - * smaller range 0..ARCH_NR_GPIOS-1.
> - *
> - * ARCH_NR_GPIOS is somewhat arbitrary; it usually reflects the sum of
> - * builtin/SoC GPIOs plus a number of GPIOs on expanders; the latter is
> - * actually an estimate of a board-specific value.
>   */
>
> -#ifndef ARCH_NR_GPIOS
> -#if defined(CONFIG_ARCH_NR_GPIO) && CONFIG_ARCH_NR_GPIO > 0
> -#define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
> -#else
> -#define ARCH_NR_GPIOS          512
> -#endif
> -#endif
> -
>  /*
> - * "valid" GPIO numbers are nonnegative and may be passed to
> - * setup routines like gpio_request().  only some valid numbers
> - * can successfully be requested and used.
> - *
> - * Invalid GPIO numbers are useful for indicating no-such-GPIO in
> - * platform data and other tables.
> + * At the end we want all GPIOs to be dynamically allocated from 0.
> + * However, some legacy drivers still perform fixed allocation.
> + * Until they are all fixed, leave 0-512 space for them.
>   */
> -
> -static inline bool gpio_is_valid(int number)
> -{
> -       return number >= 0 && number < ARCH_NR_GPIOS;
> -}
> +#define GPIO_DYNAMIC_BASE      512
>
>  struct device;
>  struct gpio;
> @@ -140,12 +118,6 @@ static inline void gpio_unexport(unsigned gpio)
>
>  #include <linux/kernel.h>
>
> -static inline bool gpio_is_valid(int number)
> -{
> -       /* only non-negative numbers are valid */
> -       return number >= 0;
> -}
> -
>  /* platforms that don't directly support access to GPIOs through I2C, SPI,
>   * or other blocking infrastructure can use these wrappers.
>   */
> @@ -169,4 +141,19 @@ static inline void gpio_set_value_cansleep(unsigned gpio, int value)
>
>  #endif /* !CONFIG_GPIOLIB */
>
> +/*
> + * "valid" GPIO numbers are nonnegative and may be passed to
> + * setup routines like gpio_request().  only some valid numbers
> + * can successfully be requested and used.
> + *
> + * Invalid GPIO numbers are useful for indicating no-such-GPIO in
> + * platform data and other tables.
> + */
> +
> +static inline bool gpio_is_valid(int number)
> +{
> +       /* only non-negative numbers are valid */
> +       return number >= 0;
> +}
> +
>  #endif /* _ASM_GENERIC_GPIO_H */
> --
> 2.37.1
>


-- 
With Best Regards,
Andy Shevchenko
