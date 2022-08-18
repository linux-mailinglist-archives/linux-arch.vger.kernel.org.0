Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DC3598010
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 10:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbiHRIZk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 18 Aug 2022 04:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiHRIZj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 04:25:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081F3AE9E9;
        Thu, 18 Aug 2022 01:25:37 -0700 (PDT)
Received: from mail-ed1-f41.google.com ([209.85.208.41]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mwfj0-1nRWuo1AqY-00yDhG; Thu, 18 Aug 2022 10:25:36 +0200
Received: by mail-ed1-f41.google.com with SMTP id b16so958233edd.4;
        Thu, 18 Aug 2022 01:25:36 -0700 (PDT)
X-Gm-Message-State: ACgBeo1cN15+F++pNgEo6dbkbN3+J06Dt7mCPymGfERrQjzzAX897EFA
        dC3biyypPGfZai8tzDLKE4cVRzGazGm59R1IUp8=
X-Google-Smtp-Source: AA6agR6FvBdJh9Cs4OxvKtiMY3DiW5ICoJPeqRHLQrQQDG+0EvOMe5DnH8e2Ff0iYfqki2M4kbO0/96IJyg8Jxguy2A=
X-Received: by 2002:a05:6402:51c6:b0:43d:dd3a:196e with SMTP id
 r6-20020a05640251c600b0043ddd3a196emr1408019edd.213.1660811135827; Thu, 18
 Aug 2022 01:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CAK8P3a3bJVTLZy3HnVvEN8zDgzAMhSUdUkZ5Jd=omNjYJZKA4Q@mail.gmail.com> <6103c908-dc48-40e2-2a89-b0f31e4c55f4@csgroup.eu>
In-Reply-To: <6103c908-dc48-40e2-2a89-b0f31e4c55f4@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Aug 2022 10:25:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0RRzpZH6vmd=sC7u5n11ZaK2uoMC9xG7FXXgEy=R8HrA@mail.gmail.com>
Message-ID: <CAK8P3a0RRzpZH6vmd=sC7u5n11ZaK2uoMC9xG7FXXgEy=R8HrA@mail.gmail.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Kk8I+ZYW7qNanVffZc7tgzVb8GEhv6PGi5iLk0ucXbgdhf+04XC
 SUo1RchJb8wpQKcvKcYG6ozWrQ9FeSs4SVOqcE87ZQktfRttDa8kEjmfDE3ojwTiplcLGY/
 0OGWc8cChXZjCZzYW6yqXGPbmVkFuc58cHZThvjU2uuI02O43CIrVcLiw43qWpbEo1bS/5Z
 JBwy5ToxN07d/afyEUGJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HYPG9BVU+7A=:Z5M0w8lGOF+X+qPUAd4Lle
 Vz7yAliTuP28+NI4iNgsF+LPOZ9iF6V3nxSj/ZnvmD5IMcBh8nOG/iC72W3k9WyEnO+gFevtP
 yCuSyixA6NjiDVtCTDMQbcVShJwsohUFfGoQ32jfxb2q6ab92HlW5pvNuex8idymyksRnwDjX
 FPCELcqVDZrzye3ewStVwNq9rsd58NTtZalxExlLv5f2tYkRg6BLojrOdW/wV3OLcy0UCS/br
 f0G0JWtQxLhDADMq7DedudWTYXffI3dE/gz4Sw2Xv1tfgFxfSoE+0Bhpz84tHT1EZAOhn2kbc
 rfpwStz0xsYn6uc1482gYYbS3UZehvXWG+hiPGUm63rlVE4c9ZE0gs2TyQ2F3irnHBalLEZi7
 tCFisHF7vmmPRNZlM7uobDwbTP7KL6m2d17Ug/afZXIccF1t84HfDRToF31YoLMnGOcLjWtUo
 1fTeJUAWj4Wq7HnxzBlE3GPB7lxchfeg0f403+8gH9nG/0YSA40e38eBVlWV0BjafjciTLvvX
 B5tCh1Jo6aj8aBcUkB05ecICAvI3nwXKFAHtiGmfVjSktbwLrAnaxxbgVSGi7wF1gRvy87xLV
 LAH2kso3NElvkgKn3q7Z6wvfPuSAOxqEjVBtsr0aNID3eLoo+lkIw0xrN1OKzJDBB7Jfc4XX/
 0hTs+dmJc6ku4HJEMzUBMnKDxKQvQBlnkdyHlrdpTW0Ug5Qp7tJYEO8iZaNugqUxiBB7UzIYl
 5SY89nSnnW/UAH8QosNifTGnrzMf0pB0ELvF4w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 18, 2022 at 8:00 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 17/08/2022 à 19:46, Arnd Bergmann a écrit :
> > On Tue, Aug 9, 2022 at 12:40 PM Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 53e6a1da9af5..e55b6560fe4f 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -14,6 +14,7 @@ config ARM
> >>          select ARCH_HAS_KCOV
> >>          select ARCH_HAS_MEMBARRIER_SYNC_CORE
> >>          select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> >> +       select ARCH_HAS_NR_GPIO
> >>          select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
> >>          select ARCH_HAS_PHYS_TO_DMA
> >>          select ARCH_HAS_SETUP_DMA_OPS
> >> @@ -1243,7 +1244,7 @@ config ARCH_NR_GPIO
> >>          default 352 if ARCH_VT8500
> >>          default 288 if ARCH_ROCKCHIP
> >>          default 264 if MACH_H4700
> >> -       default 0
> >> +       default 512
> >
> > This list should be kept sorted, otherwise you still get e.g. the '264' default
> > value. If you have a GPIO extender that provides hardcoded GPIO
> > numbers on your machine, there should be a configuration option for
> > that driver.
>
> I don't want to change the behaviour for existing configurations. If the
> unconditional default goes before conditional ones, then all following
> defaults will be ignored and you'll get 512 instead of 264 if MAC_H4700
> is selected for instance.
>
> At the time being, you get 0 only when no other default was selected,
> then that 0 implies 512 in asm-generic/gpio.h by:
>
> #if defined(CONFIG_ARCH_NR_GPIO) && CONFIG_ARCH_NR_GPIO > 0
> #define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
> #else
> #define ARCH_NR_GPIOS           512
> #endif

Ok, I see what you are doing now. I'm not sure this is actually intentional
behavior of the current implementation though, my guess would be that
the 'default 0' was intended as a fallback for platforms that have no
GPIO providers at all.

This is of course not entirely appropriate any more as

> > Which driver is it that needs extra hardcoded GPIO numbers for you?
> > Have you tried converting it to use GPIO descriptors so you don't
> > need the number assignment?
>
> It is a max7301 (drivers/gpio/gpio-max730x.c) but I can't understand
> what you mean. GPIO descriptors are for consumers, aren't they ?

I meant the consumers, yes.

> During boot I get :
>
> [    0.601942] gpiochip_find_base: found new base at 496
> [    0.606337] gpiochip_find_base: found new base at 464
> [    0.616408] gpiochip_find_base: found new base at 448
> [    0.621826] gpiochip_find_base: found new base at 432
> [    0.627228] gpiochip_find_base: found new base at 400
> [    0.660984] gpiochip_find_base: found new base at 384
> [    0.669631] gpiochip_find_base: found new base at 368
> [    0.672713] gpiochip_find_base: found new base at 352
> [    0.675805] gpiochip_find_base: found new base at 336
> [    0.678885] gpiochip_find_base: found new base at 320
> [    0.682178] gpiochip_find_base: found new base at 304
> [    0.685275] gpiochip_find_base: found new base at 288
> [    0.688366] gpiochip_find_base: found new base at 272
> [    0.691678] gpiochip_find_base: found new base at 256
> [    0.694762] gpiochip_find_base: found new base at 240
> [    0.697847] gpiochip_find_base: found new base at 224
> [    0.701441] gpiochip_find_base: found new base at 208
> [    0.709427] gpiochip_find_base: found new base at 192
> [    0.713859] gpiochip_find_base: found new base at 176
> [    0.718002] gpiochip_find_base: found new base at 160
> [    0.723316] gpiochip_find_base: found new base at 144
> [    0.731105] gpiochip_find_base: found new base at 128
> [    0.737403] gpiochip_find_base: found new base at 112
> [    0.740614] gpiochip_find_base: found new base at 96
> [    0.743701] gpiochip_find_base: found new base at 80
> [    0.747246] gpiochip_find_base: found new base at 64
> [    4.663677] gpiochip_find_base: found new base at 36
> [    5.050792] gpiochip_find_base: found new base at 16
> [    5.064892] gpiochip_find_base: cannot find free range
> [    5.095527] gpiochip_find_base: cannot find free range
>
> gpiochip_find_base() is called for any GPIO driver, by gpiochip_add() /
> gpiochip_add_data_with_key(), and there is the following comment:
>
>         /*
>          * TODO: this allocates a Linux GPIO number base in the global
>          * GPIO numberspace for this chip. In the long run we want to
>          * get *rid* of this numberspace and use only descriptors, but
>          * it may be a pipe dream. It will not happen before we get rid
>          * of the sysfs interface anyways.
>          */
>
> So, what did I miss ?

I missed the fact that the registration fails if it runs out of gpio numbers,
as I was assuming that you could still use the additional gpio chips
with the descriptor based API as long as all of the consumers on the
system use that and you don't use CONFIG_GPIO_SYSFS.

I see that this does not work today, but maybe it wouldn't be too hard to
change? I see that CONFIG_GPIO_SYSFS continued to move towards
deprecation after the comment was added in the code, and these days it
can only be enabled if CONFIG_EXPERT=y is set.

        Arnd
