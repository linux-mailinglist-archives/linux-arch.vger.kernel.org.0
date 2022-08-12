Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F3A5916FC
	for <lists+linux-arch@lfdr.de>; Fri, 12 Aug 2022 23:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiHLV7P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Aug 2022 17:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiHLV7O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Aug 2022 17:59:14 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2755798D06;
        Fri, 12 Aug 2022 14:59:13 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id e28so1788711qts.1;
        Fri, 12 Aug 2022 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GjUDLuXzW1eUvP6FX/7o5Xq4pQ7lZJ0+fEeVLZ9I0Yw=;
        b=FiZDuTxWWY5epmm1aNeA7myYoG9e2hWZqJmv3nk28e1h/8gYXgrzdQ3Q8dOen1XRUP
         MR1FecG7Euhv2pE5x2tWoBnUPIY5yCKo+dYUFfoiLBAsRK81OQCf9f7TQSUQyd7gSkU/
         Vzg+t5sT53Ocjl1eogRfHuWeE51IsRRFuydXQHJBP/o3cKFAtMCYLTuBZtAKeMA/bQI9
         0pYQxuhVINLkzjAy2NuXAYY8EMvMz6+vQkoIxurrkYqljPYvzjG3C23jgwsa4Hvt+1Ml
         h9ucs0yoy09BKH4aBzXFFzI0aR1A82xkq3Bxf+GBUwsO6GNVm2pVkJAQOZpu3OCArt91
         81fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GjUDLuXzW1eUvP6FX/7o5Xq4pQ7lZJ0+fEeVLZ9I0Yw=;
        b=cx1GK4hDOQNDbty7IqTufNMEw0MVUF5UWDXXugFz/PejH8c686f2ZB5hVYAgFB3HvK
         gkeM5mY/X++TopBNDlsR9SRSVMshy9GqRsGQiEsE9Uptk6I4mPGxbfJ3xbO7FDCiMN5/
         lSXMGer5UPuNo59OSrM5S3NCR1XJDWZG/9UxnXWJ1oJM/p0htEGHal3EFw7SkYU/IQLc
         Os3HxNhb/UgWb2tl92VCwHY1DArvYT9q0237SXs3v0dqkLfr/W+Gr8JKY3p3HOWj8NJA
         YCOv9udPkuQgubFK0AY9feB+CpkA+upn1O+WXXgytpvkw43QZuMqQw5+vigl38Fntz9U
         gfZg==
X-Gm-Message-State: ACgBeo3jaBDAIN9GxhwSrmxkWuAKk4wrAfxLCzr+1NS/zZFo6ZxH+l5g
        Z0c1+7+H6cZY0aLiZycoayjEvfE0pB7Maw7vqNM=
X-Google-Smtp-Source: AA6agR4Jz1gAcQZX/oXxYMX2qzmwEI5SyMqu8DUMD2rPlXAwK7xmH3fsliqwwTuH5OTPr0DLHyLnH+xATRpJ37fIM8E=
X-Received: by 2002:a05:622a:48f:b0:343:463:351a with SMTP id
 p15-20020a05622a048f00b003430463351amr5361998qtx.61.1660341552210; Fri, 12
 Aug 2022 14:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <C1886F9A-1799-4E3D-9153-579D31488695@zytor.com>
In-Reply-To: <C1886F9A-1799-4E3D-9153-579D31488695@zytor.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 13 Aug 2022 00:58:36 +0300
Message-ID: <CAHp75VfFQe3Ce-Si1sax8CCG1-rq+Y=8JhwH=82d3XgytCAmOQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
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

On Thu, Aug 11, 2022 at 11:12 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On August 9, 2022 3:40:38 AM PDT, Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> >At the time being, the default maximum number of GPIOs is set to 512
> >and can only get customised via an architecture specific
> >CONFIG_ARCH_NR_GPIO.
> >
> >The maximum number of GPIOs might be dependent on the number of
> >interface boards and is somewhat independent of architecture.
> >
> >Allow the user to select that maximum number outside of any
> >architecture configuration. To enable that, re-define a
> >core CONFIG_ARCH_NR_GPIO for architectures which don't already
> >define one. Guard it with a new hidden CONFIG_ARCH_HAS_NR_GPIO.
> >
> >Only two architectures will need CONFIG_ARCH_HAS_NR_GPIO: x86 and arm.
> >
> >On arm, do like x86 and set 512 as the default instead of 0, that
> >allows simplifying the logic in asm-generic/gpio.h

...

> This seems very odd to me. GPIOs can be, and often are, attached to peripheral buses which means that the *same system* can have anything from none to thousands of gpios ..

Basically this setting should give us a *minimum* GPIO lines that are
present on the system. And that is perfectly SoC dependent. The real
issue is that the GPIO framework has these global arrays that (still?)
can't be initialized from the heap due to too early initialization (is
it the true reason?).

-- 
With Best Regards,
Andy Shevchenko
