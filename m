Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C095BD14D7
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfJIRFO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:05:14 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35268 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfJIRFO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 13:05:14 -0400
Received: by mail-yw1-f65.google.com with SMTP id r134so1086199ywg.2;
        Wed, 09 Oct 2019 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cXYEAzqhy4HyxKWCqy6LZ1LbETT8kg39/BhJJ7xImgY=;
        b=XzVmSlbV54ObweYND+EDGBljHGj8sj2ueCWS95v8Cm859OOOsxIuOqof31AgJZJrgP
         sYoUG7ZWjf0njqLgiU/hHNjEW3C0MMBKx89WWFO4DlJsMsmXm9jBIVcqPd+ZLd3OohCE
         KhSVBkByAnQTmF2FGZmUJkgGhHEEaZhRl6B9NyXxJUeV2DGCqJZ0MjYh5FNdExNErUXW
         GEbdBw/gn5VkXbsjJ7FErGQIO1W5a+kZIEUbAKx6L4oG0gifFpjsyGy6tO64qy7oFvz6
         37uGRsoh98fhFqLA7+BGliNL2VfTiKSiDP9UYDDl71wQtxmr3M3OEC59H09+EJL7JJen
         pD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cXYEAzqhy4HyxKWCqy6LZ1LbETT8kg39/BhJJ7xImgY=;
        b=LCvPtMumfKNP3A8dkOFeffqUuv80fN7PyFhiTl61Z/TwINmYrVqfJt9VYPRBDtzXrp
         ZH5vrlOozTPyvqQ5lYvKRLjm/+1a6MSgAldxvfHPuGwsEzyGuFGPjqCIYfQfg3p+6nWJ
         1/YaKP2ilapc9Zvd9wuZ+ChtJqAQZGuVrIdC4yitdHgstJLb93Zw30kWzjJ2lMElNocB
         E4qwecSB5lAemO/AZjQ8po9xpDmrD8Q2mUHuNO8710J0Rn1re0EhmIcUuK8KpvvQ/B8m
         3Gu3cP66XlYPtM8zr1ul5XRvsp9WTG0bRBCDfKd4l5/v4MHFEjh8yR3vvIvk+RPCfRUN
         s2GQ==
X-Gm-Message-State: APjAAAVQ00+TOWBqUIyNg+eJTv8EIt5+x4vliiVSAf4lTa/unE4NVELT
        0rD2V6UZZsoG6oc1Wn1tKnI=
X-Google-Smtp-Source: APXvYqyrAU/nAC3kYzoD94JUe4/RiRHCUfehRJlN8ivjdiAlO4Zf6n0Riga+hkaAtINX8fhZjpe9Nw==
X-Received: by 2002:a0d:e1c2:: with SMTP id k185mr3552287ywe.103.1570640712141;
        Wed, 09 Oct 2019 10:05:12 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id u67sm682257ywf.44.2019.10.09.10.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:05:11 -0700 (PDT)
Date:   Wed, 9 Oct 2019 13:05:08 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        preid@electromag.com.au, Lukas Wunner <lukas@wunner.de>,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk
Subject: Re: [PATCH v17 09/14] gpio: uniphier: Utilize for_each_set_clump8
 macro
Message-ID: <20191009170508.GB93820@icarus>
References: <cover.1570633189.git.vilhelm.gray@gmail.com>
 <271a7735b02b6a8b1f54c018e38ea932d1fd299e.1570633189.git.vilhelm.gray@gmail.com>
 <CAK7LNAQStJsZ4cYTJyAPvjyngWkKs+5y=yzJb6vz3-cco+2-ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAQStJsZ4cYTJyAPvjyngWkKs+5y=yzJb6vz3-cco+2-ug@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 01:33:06AM +0900, Masahiro Yamada wrote:
> On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > Replace verbose implementation in set_multiple callback with
> > for_each_set_clump8 macro to simplify code and improve clarity. An
> > improvement in this case is that banks that are not masked will now be
> > skipped.
> >
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  drivers/gpio/gpio-uniphier.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
> > index 93cdcc41e9fb..3e4b15d0231e 100644
> > --- a/drivers/gpio/gpio-uniphier.c
> > +++ b/drivers/gpio/gpio-uniphier.c
> > @@ -15,9 +15,6 @@
> >  #include <linux/spinlock.h>
> >  #include <dt-bindings/gpio/uniphier-gpio.h>
> >
> > -#define UNIPHIER_GPIO_BANK_MASK                \
> > -                               GENMASK((UNIPHIER_GPIO_LINES_PER_BANK) - 1, 0)
> > -
> >  #define UNIPHIER_GPIO_IRQ_MAX_NUM      24
> >
> >  #define UNIPHIER_GPIO_PORT_DATA                0x0     /* data */
> > @@ -147,15 +144,14 @@ static void uniphier_gpio_set(struct gpio_chip *chip,
> >  static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
> >                                        unsigned long *mask, unsigned long *bits)
> >  {
> > -       unsigned int bank, shift, bank_mask, bank_bits;
> > -       int i;
> > +       unsigned long i;
> > +       unsigned long bank_mask;
> > +       unsigned long bank;
> > +       unsigned long bank_bits;
> 
> 
> Please do not split it into multiple lines
> unless you need to do so.
> 
> Thanks.

No problem, I'll update this patch to declare them all on the same line.

William Breathitt Gray

> > -       for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
> > +       for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
> >                 bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
> > -               shift = i % BITS_PER_LONG;
> > -               bank_mask = (mask[BIT_WORD(i)] >> shift) &
> > -                                               UNIPHIER_GPIO_BANK_MASK;
> > -               bank_bits = bits[BIT_WORD(i)] >> shift;
> > +               bank_bits = bitmap_get_value8(bits, i);
> >
> >                 uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
> >                                          bank_mask, bank_bits);
> > --
> > 2.23.0
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
