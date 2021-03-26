Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89AC34AD50
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 18:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCZR1t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCZR1p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2021 13:27:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA4BC0613AA
        for <linux-arch@vger.kernel.org>; Fri, 26 Mar 2021 10:27:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hq27so9550359ejc.9
        for <linux-arch@vger.kernel.org>; Fri, 26 Mar 2021 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1JrvGVjvnU4OleZHvZNBHn3IUwN+tQcLM7GpfSmRkZk=;
        b=cwpkHyQrULLTxS7hyIyPePeFi/FNtWZ3wrU8DFAd6e74G1o94qmH7Z5PjWR8yr5z1r
         sgpyKyCURNT2pAZYYtT4o1xIv830XPuXSi07uQQ+jqPykxJW/tfNNu1GDRVqbAXCl4Hz
         nBRpS61VfXySqkW2Bx1fZJC4qhxNH9f04jCpVCDUd1Brf9Ko4JlEUr1S5u+1WhMo9n/Z
         GkzwtQ0CYVWe4DfIsGLtfv6b+/ocnK8JELWYGPm57NUUs4U0GaouCUQWF/T81DrMcXuq
         Z6tLBq2cU/VsK4UcPMjLnxwxXN++4BJ+LINlfni/VXPu6o1YOZnpxfeGHVfUjnDUYY1l
         hhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JrvGVjvnU4OleZHvZNBHn3IUwN+tQcLM7GpfSmRkZk=;
        b=nYQp8vPjXs0t24th3rzeXK7kfjMljRRLZiYzdOcvR0yTa/zBc2VZ+4jXCBC7/vkdkA
         gdEVNfuBPrl4GtCVPCHRM9WU2vRaxBa+tTZAMAbAMCahlWTQ+rXLo61hltf67R9yq5L0
         ZtbZZJU2E4CK2m/tKea+/6Iim6WZCyV0+QYMUaYdclSNNX+RONSLEyN9OnEE1Zx4nTKd
         fZ9iDJ7TE3pzKCFXt/RspHbz2MuSdsrblGvTEsUT1BAFmf1p9TIysSQDTt91Xtp/ozeD
         uv7lEZ30ySYpWnIRPorWnftIATcAaScntTgT0rCsWj8SpNap9AoWy4uESt2ghO/5SsOR
         vSQw==
X-Gm-Message-State: AOAM530z7Y1p2S/G85GSr4UHfn95KrAKvAbcH7yvjQ9hC2m31z/+8Jhl
        j4cSb4KQhrFr46wH6YgzlWgQHgxlFGSj0ur0C+6TpA==
X-Google-Smtp-Source: ABdhPJwkzOGb6kE59IAEyH6N7nsGGo1eTapaAq2lAelIByUXV1mPNIRkTEVwayCCs+LsYnVuKETqP2Nuv9zd7ozrBwM=
X-Received: by 2002:a17:906:c0c8:: with SMTP id bn8mr16475296ejb.445.1616779663961;
 Fri, 26 Mar 2021 10:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615038553.git.syednwaris@gmail.com> <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
 <36db7be3-73b6-c822-02e8-13e3864b0463@xilinx.com>
In-Reply-To: <36db7be3-73b6-c822-02e8-13e3864b0463@xilinx.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 26 Mar 2021 18:27:33 +0100
Message-ID: <CAMpxmJUv0iU0Ntmks1f6ThDAG6x_eJLYYCaDSjy+1Syedzc5dQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        Srinivas Goud <srinivas.goud@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 8, 2021 at 8:13 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
>
>
> On 3/6/21 3:06 PM, Syed Nayyar Waris wrote:
> > This patch reimplements the xgpio_set_multiple() function in
> > drivers/gpio/gpio-xilinx.c to use the new generic functions:
> > bitmap_get_value() and bitmap_set_value(). The code is now simpler
> > to read and understand. Moreover, instead of looping for each bit
> > in xgpio_set_multiple() function, now we can check each channel at
> > a time and save cycles.
> >
> > Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  drivers/gpio/gpio-xilinx.c | 63 +++++++++++++++++++-------------------
> >  1 file changed, 32 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> > index be539381fd82..8445e69cf37b 100644
> > --- a/drivers/gpio/gpio-xilinx.c
> > +++ b/drivers/gpio/gpio-xilinx.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/slab.h>
> > +#include "gpiolib.h"
> >
> >  /* Register Offset Definitions */
> >  #define XGPIO_DATA_OFFSET   (0x0)    /* Data register  */
> > @@ -141,37 +142,37 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> >  {
> >       unsigned long flags;
> >       struct xgpio_instance *chip = gpiochip_get_data(gc);
> > -     int index = xgpio_index(chip, 0);
> > -     int offset, i;
> > -
> > -     spin_lock_irqsave(&chip->gpio_lock[index], flags);
> > -
> > -     /* Write to GPIO signals */
> > -     for (i = 0; i < gc->ngpio; i++) {
> > -             if (*mask == 0)
> > -                     break;
> > -             /* Once finished with an index write it out to the register */
> > -             if (index !=  xgpio_index(chip, i)) {
> > -                     xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> > -                                    index * XGPIO_CHANNEL_OFFSET,
> > -                                    chip->gpio_state[index]);
> > -                     spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
> > -                     index =  xgpio_index(chip, i);
> > -                     spin_lock_irqsave(&chip->gpio_lock[index], flags);
> > -             }
> > -             if (__test_and_clear_bit(i, mask)) {
> > -                     offset =  xgpio_offset(chip, i);
> > -                     if (test_bit(i, bits))
> > -                             chip->gpio_state[index] |= BIT(offset);
> > -                     else
> > -                             chip->gpio_state[index] &= ~BIT(offset);
> > -             }
> > -     }
> > -
> > -     xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> > -                    index * XGPIO_CHANNEL_OFFSET, chip->gpio_state[index]);
> > -
> > -     spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
> > +     u32 *const state = chip->gpio_state;
> > +     unsigned int *const width = chip->gpio_width;
> > +
> > +     DECLARE_BITMAP(old, 64);
> > +     DECLARE_BITMAP(new, 64);
> > +     DECLARE_BITMAP(changed, 64);
> > +
> > +     spin_lock_irqsave(&chip->gpio_lock[0], flags);
> > +     spin_lock(&chip->gpio_lock[1]);
> > +
> > +     bitmap_set_value(old, 64, state[0], width[0], 0);
> > +     bitmap_set_value(old, 64, state[1], width[1], width[0]);
> > +     bitmap_replace(new, old, bits, mask, gc->ngpio);
> > +
> > +     bitmap_set_value(old, 64, state[0], 32, 0);
> > +     bitmap_set_value(old, 64, state[1], 32, 32);
> > +     state[0] = bitmap_get_value(new, 0, width[0]);
> > +     state[1] = bitmap_get_value(new, width[0], width[1]);
> > +     bitmap_set_value(new, 64, state[0], 32, 0);
> > +     bitmap_set_value(new, 64, state[1], 32, 32);
> > +     bitmap_xor(changed, old, new, 64);
> > +
> > +     if (((u32 *)changed)[0])
> > +             xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET,
> > +                             state[0]);
> > +     if (((u32 *)changed)[1])
> > +             xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> > +                             XGPIO_CHANNEL_OFFSET, state[1]);
> > +
> > +     spin_unlock(&chip->gpio_lock[1]);
> > +     spin_unlock_irqrestore(&chip->gpio_lock[0], flags);
> >  }
> >
> >  /**
> >
>
> Srinivas N: Can you please test this code?
>
> Thanks,
> Michal

Hey, any chance of getting that Tested-by?

Bart
