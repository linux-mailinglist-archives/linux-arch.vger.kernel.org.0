Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597D559754B
	for <lists+linux-arch@lfdr.de>; Wed, 17 Aug 2022 19:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbiHQRqx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Aug 2022 13:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbiHQRqw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Aug 2022 13:46:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFC85AC5E;
        Wed, 17 Aug 2022 10:46:49 -0700 (PDT)
Received: from mail-ej1-f45.google.com ([209.85.218.45]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTREY-1nuhjf49QS-00Tl7C; Wed, 17 Aug 2022 19:46:48 +0200
Received: by mail-ej1-f45.google.com with SMTP id uj29so25856532ejc.0;
        Wed, 17 Aug 2022 10:46:47 -0700 (PDT)
X-Gm-Message-State: ACgBeo0xVLOdX32DzTidd8O5fsitiaeZQkI/9s6CbACZcF+YP85gO9sq
        +yuN7BT+wHa1ARVaEMLkghVHNIlveTeBt0JzxKk=
X-Google-Smtp-Source: AA6agR7P+akdEIVBystZ3tdT1LJBc/Kz2X/p17BDIwuamejB2ijCkX0uATAcgT/myy62wF1uRwHfDAnHQqOrE7z8DJE=
X-Received: by 2002:a17:907:960f:b0:731:1e3:b198 with SMTP id
 gb15-20020a170907960f00b0073101e3b198mr17396224ejc.470.1660758407495; Wed, 17
 Aug 2022 10:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
In-Reply-To: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Aug 2022 19:46:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3bJVTLZy3HnVvEN8zDgzAMhSUdUkZ5Jd=omNjYJZKA4Q@mail.gmail.com>
Message-ID: <CAK8P3a3bJVTLZy3HnVvEN8zDgzAMhSUdUkZ5Jd=omNjYJZKA4Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jLlZYgV6MYmH7PB2PjUXZmuF3KTog82Q/7hiq4glnTCUZJysan5
 2D36PBAJJ5Q3/dNEKSD0TdekL5XZozqpWsJt7fBi2ZUKICDvXMw4IXj4sHhGnwAzphVstvT
 CH1IWRVap+w7s3+fWBFiFhyPseQNpj0Dq7eg3tRayrCRwmBMTLQpcnVhPMHn+FSmpvuvbe0
 JvO6NU+zr77PyYywVzw5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GYWZlLCLJmU=:HvaRNLOOyE2ORoo9woWSl3
 Q2oI0LikGdV99euy6QTgVr9jW4H9HzZ6KoKzgpfOCzV8SkKm1bMf0S+ccWXXzPrBpZOv9SdPz
 Vwb0DNpqObRzJzIBedunoG2qjeULP9IfrssldfjTjAMHGEboDy0hngdWmKeCiuTRpgz89NXMw
 KnetaxI8/jB0uzm4nPDUcT3WwRxmi/JNAQsWUzH7ABdCPngfGFVNrWQr8sFrcazmfhTggKbdV
 Ot/PQId/q8y2ZouXk+rK0L/sXOUz3DxN8HLzK9fu+4nSoMfHMxQ7xEy53o5f+/8SmABT6lTXm
 Y63gY7+DGpkiXB+9BQqa37C+53Wkc1e6Tt95VU/xJG14LLHLEgq3zOM72dnvJulC8TxRTnhBW
 uqe4g5q0MzJ+zIH6adaHJu3xjm3tA7QH7RrTVkQ1CNuTJhCNNIEe1mk2hmrCsYDWpHPNWBj3u
 Ds7fuyQ2fZoWP2sMa6bOdBwxkPZKTA84fGdZE+x5ivXydRdjW53ww1H0XDtTpL6qbkPV4SITk
 ylgCNEh4C4FGEJSdpVFhxTAoJVzbbDOgHvNVfIMACNK1+542W3YZowK4WnvvXJtnP1Oyp6uU3
 ogXzLOOfZQuG7+HoXQRY0yOZXmJKRfbeor5z0GKZ2BeXkwLt81U9XO7jXBuxjNGADIKeJoL5i
 2daGKk2dTpyNZLO0jEr2b2t+1mG7DFOgYJIbp7z31sx0uIx5RwAKC9ig9XOHn28yGlBnFT53g
 mjq1o9qBBu+KxRD3LJ7yWzCRWMDzg9ptkKnqDpeyPW5UPnvNNMJ6p/dn7AIVkn26KquZZbE9r
 C+a6Ufn8Udbx0rR6KDO5nWuoYFjEyYr2vGTdEAnu8RKxmcTjfdDnULwzscLyw5NmayVmSHhXn
 ctp1jSAC14Z/95HR4vDw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 9, 2022 at 12:40 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> At the time being, the default maximum number of GPIOs is set to 512
> and can only get customised via an architecture specific
> CONFIG_ARCH_NR_GPIO.
>
> The maximum number of GPIOs might be dependent on the number of
> interface boards and is somewhat independent of architecture.
>
> Allow the user to select that maximum number outside of any
> architecture configuration. To enable that, re-define a
> core CONFIG_ARCH_NR_GPIO for architectures which don't already
> define one. Guard it with a new hidden CONFIG_ARCH_HAS_NR_GPIO.
>
> Only two architectures will need CONFIG_ARCH_HAS_NR_GPIO: x86 and arm.
>
> On arm, do like x86 and set 512 as the default instead of 0, that
> allows simplifying the logic in asm-generic/gpio.h
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  Documentation/driver-api/gpio/legacy.rst |  2 +-
>  arch/arm/Kconfig                         |  3 ++-
>  arch/arm/include/asm/gpio.h              |  1 -
>  arch/x86/Kconfig                         |  1 +
>  drivers/gpio/Kconfig                     | 14 ++++++++++++++
>  include/asm-generic/gpio.h               |  6 ------
>  6 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
> index 9b12eeb89170..566b06a584cf 100644
> --- a/Documentation/driver-api/gpio/legacy.rst
> +++ b/Documentation/driver-api/gpio/legacy.rst
> @@ -558,7 +558,7 @@ Platform Support
>  To force-enable this framework, a platform's Kconfig will "select" GPIOLIB,
>  else it is up to the user to configure support for GPIO.
>
> -It may also provide a custom value for ARCH_NR_GPIOS, so that it better
> +It may also provide a custom value for CONFIG_ARCH_NR_GPIO, so that it better
>  reflects the number of GPIOs in actual use on that platform, without
>  wasting static table space.  (It should count both built-in/SoC GPIOs and
>  also ones on GPIO expanders.
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 53e6a1da9af5..e55b6560fe4f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -14,6 +14,7 @@ config ARM
>         select ARCH_HAS_KCOV
>         select ARCH_HAS_MEMBARRIER_SYNC_CORE
>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> +       select ARCH_HAS_NR_GPIO
>         select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
>         select ARCH_HAS_PHYS_TO_DMA
>         select ARCH_HAS_SETUP_DMA_OPS
> @@ -1243,7 +1244,7 @@ config ARCH_NR_GPIO
>         default 352 if ARCH_VT8500
>         default 288 if ARCH_ROCKCHIP
>         default 264 if MACH_H4700
> -       default 0
> +       default 512

This list should be kept sorted, otherwise you still get e.g. the '264' default
value. If you have a GPIO extender that provides hardcoded GPIO
numbers on your machine, there should be a configuration option for
that driver.

Which driver is it that needs extra hardcoded GPIO numbers for you?
Have you tried converting it to use GPIO descriptors so you don't
need the number assignment?

        Arnd
