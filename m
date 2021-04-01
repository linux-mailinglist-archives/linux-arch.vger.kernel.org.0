Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E98E351D03
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 20:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhDASX1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 14:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbhDASMt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 14:12:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4C2C06178A;
        Thu,  1 Apr 2021 04:16:05 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b10so1813043iot.4;
        Thu, 01 Apr 2021 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=moOyGRcGHar9YNt0N/Y7uFjPvSME0sZl6mnpRsX5JvU=;
        b=ifnqDCESEWCwygu7Q8TcEEjwG35Ap4TGL1lIxVlgSIHnbzmG25rF7VK74GW/oT/Lgh
         2UJ9bIQNzSDOlkch2hOCYH1HpIqOco9idX9WVqPyouTWaS8Ou04kvDlzHghlRMp4jHPf
         nskapKeDijNI6NmbdwMQ0kmLLDvSqDkg1MFJwvHTqGAGSsKLk5VXeqNC5Euy8zgxYvnF
         O3TzXfeLmGd9cTk7Hw7vPqePTLusUXV5nmy1w7nHwPPWrDqSZAM1o5RCdXpXwBhAZ9SF
         he5bn3R+I/nx5KU477ajaxMPDRxH3dbiHtmAvkpsU7i0mKguLtw3QMN4BcDqvQv0/j90
         uHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moOyGRcGHar9YNt0N/Y7uFjPvSME0sZl6mnpRsX5JvU=;
        b=soWyT1A9W0BaF3W0ttGi3Fr6RaD5QfT0MlnXkKCHFRcaQwKHqNzNYPF689Vrsf5MyY
         0vmI+U0Dxgb9QjCvQ5etBk2ooHAJBm9PGD06fxeAk1vUv3R+U7bWe5MIphILjUtXMsFk
         qCyj7gJiiIpg4kkLkQH98Xbbvg+CxuDS9dL/KZd9uYM+Zw5X58ge9Z5cRsZAW0/5XdAV
         /IqQAOfdBSGgk8Tc87ULekIt/Vo6oQw26TBLtAoVfIvpxo5S3BR0/MwCj+Pf9oOf9PCD
         Pdh2Uu8o5UbEIwkkmQXxphqBIjZgN74hohDj28Ru8FfSb9zdiZ01nIBAPcJoHB1DScnV
         b4AQ==
X-Gm-Message-State: AOAM5301yeH8I1sju1WJfHVnbqiS0AHgrNgbE3kF/w0Li5uAMRErmfB3
        8Vedp6igrX+BfyiUkmlCVJHxEVZhOcIkSUI3f7s=
X-Google-Smtp-Source: ABdhPJxhpMPww1OveGSHxepFu4l+A0e2gZ/exiHFMOBtsrHDLLr9n61X8fXz/bnSkzdlVx94sCa1xegT1QRnmXoNsps=
X-Received: by 2002:a05:6602:21cd:: with SMTP id c13mr6082518ioc.44.1617275764762;
 Thu, 01 Apr 2021 04:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615038553.git.syednwaris@gmail.com> <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
 <36db7be3-73b6-c822-02e8-13e3864b0463@xilinx.com> <CAMpxmJUv0iU0Ntmks1f6ThDAG6x_eJLYYCaDSjy+1Syedzc5dQ@mail.gmail.com>
 <DM6PR02MB53863852A28F782B0942ECD8AF7C9@DM6PR02MB5386.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB53863852A28F782B0942ECD8AF7C9@DM6PR02MB5386.namprd02.prod.outlook.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Thu, 1 Apr 2021 16:45:52 +0530
Message-ID: <CACG_h5q6P5NiNByttQ-NZvq8x3GCTKfSU=Yyywk7PcO6_=i2Mw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Michal Simek <michals@xilinx.com>,
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
        Srinivas Goud <sgoud@xilinx.com>,
        Srinivas Neeli <sneeli@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 8:56 PM Srinivas Neeli <sneeli@xilinx.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Sent: Friday, March 26, 2021 10:58 PM
> > To: Michal Simek <michals@xilinx.com>
> > Cc: Syed Nayyar Waris <syednwaris@gmail.com>; Srinivas Neeli
> > <sneeli@xilinx.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; William Breathitt Gray
> > <vilhelm.gray@gmail.com>; Arnd Bergmann <arnd@arndb.de>; Robert
> > Richter <rrichter@marvell.com>; Linus Walleij <linus.walleij@linaro.org>;
> > Masahiro Yamada <yamada.masahiro@socionext.com>; Andrew Morton
> > <akpm@linux-foundation.org>; Zhang Rui <rui.zhang@intel.com>; Daniel
> > Lezcano <daniel.lezcano@linaro.org>; Amit Kucheria
> > <amit.kucheria@verdurent.com>; Linux-Arch <linux-arch@vger.kernel.org>;
> > linux-gpio <linux-gpio@vger.kernel.org>; LKML <linux-
> > kernel@vger.kernel.org>; arm-soc <linux-arm-kernel@lists.infradead.org>;
> > linux-pm <linux-pm@vger.kernel.org>; Srinivas Goud <sgoud@xilinx.com>
> > Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and
> > _set_value
> >
> > On Mon, Mar 8, 2021 at 8:13 AM Michal Simek <michal.simek@xilinx.com>
> > wrote:
> > >
> > >
> > >
> > > On 3/6/21 3:06 PM, Syed Nayyar Waris wrote:
> > > > This patch reimplements the xgpio_set_multiple() function in
> > > > drivers/gpio/gpio-xilinx.c to use the new generic functions:
> > > > bitmap_get_value() and bitmap_set_value(). The code is now simpler
> > > > to read and understand. Moreover, instead of looping for each bit in
> > > > xgpio_set_multiple() function, now we can check each channel at a
> > > > time and save cycles.
> > > >
> > > > Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > Cc: Michal Simek <michal.simek@xilinx.com>
> > > > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > > > Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > > ---
> > > >  drivers/gpio/gpio-xilinx.c | 63
> > > > +++++++++++++++++++-------------------
> > > >  1 file changed, 32 insertions(+), 31 deletions(-)
> > > >
> > > > diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> > > > index be539381fd82..8445e69cf37b 100644
> > > > --- a/drivers/gpio/gpio-xilinx.c
> > > > +++ b/drivers/gpio/gpio-xilinx.c
> > > > @@ -15,6 +15,7 @@
> > > >  #include <linux/of_device.h>
> > > >  #include <linux/of_platform.h>
> > > >  #include <linux/slab.h>
> > > > +#include "gpiolib.h"
> > > >
> > > >  /* Register Offset Definitions */
> > > >  #define XGPIO_DATA_OFFSET   (0x0)    /* Data register  */
> > > > @@ -141,37 +142,37 @@ static void xgpio_set_multiple(struct
> > > > gpio_chip *gc, unsigned long *mask,  {
> > > >       unsigned long flags;
> > > >       struct xgpio_instance *chip = gpiochip_get_data(gc);
> > > > -     int index = xgpio_index(chip, 0);
> > > > -     int offset, i;
> > > > -
> > > > -     spin_lock_irqsave(&chip->gpio_lock[index], flags);
> > > > -
> > > > -     /* Write to GPIO signals */
> > > > -     for (i = 0; i < gc->ngpio; i++) {
> > > > -             if (*mask == 0)
> > > > -                     break;
> > > > -             /* Once finished with an index write it out to the register */
> > > > -             if (index !=  xgpio_index(chip, i)) {
> > > > -                     xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> > > > -                                    index * XGPIO_CHANNEL_OFFSET,
> > > > -                                    chip->gpio_state[index]);
> > > > -                     spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
> > > > -                     index =  xgpio_index(chip, i);
> > > > -                     spin_lock_irqsave(&chip->gpio_lock[index], flags);
> > > > -             }
> > > > -             if (__test_and_clear_bit(i, mask)) {
> > > > -                     offset =  xgpio_offset(chip, i);
> > > > -                     if (test_bit(i, bits))
> > > > -                             chip->gpio_state[index] |= BIT(offset);
> > > > -                     else
> > > > -                             chip->gpio_state[index] &= ~BIT(offset);
> > > > -             }
> > > > -     }
> > > > -
> > > > -     xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> > > > -                    index * XGPIO_CHANNEL_OFFSET, chip->gpio_state[index]);
> > > > -
> > > > -     spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
> > > > +     u32 *const state = chip->gpio_state;
> > > > +     unsigned int *const width = chip->gpio_width;
> > > > +
> > > > +     DECLARE_BITMAP(old, 64);
> > > > +     DECLARE_BITMAP(new, 64);
> > > > +     DECLARE_BITMAP(changed, 64);
> > > > +
> > > > +     spin_lock_irqsave(&chip->gpio_lock[0], flags);
> > > > +     spin_lock(&chip->gpio_lock[1]);
> > > > +
> > > > +     bitmap_set_value(old, 64, state[0], width[0], 0);
> > > > +     bitmap_set_value(old, 64, state[1], width[1], width[0]);
> > > > +     bitmap_replace(new, old, bits, mask, gc->ngpio);
> > > > +
> > > > +     bitmap_set_value(old, 64, state[0], 32, 0);
> > > > +     bitmap_set_value(old, 64, state[1], 32, 32);
> > > > +     state[0] = bitmap_get_value(new, 0, width[0]);
> > > > +     state[1] = bitmap_get_value(new, width[0], width[1]);
> > > > +     bitmap_set_value(new, 64, state[0], 32, 0);
> > > > +     bitmap_set_value(new, 64, state[1], 32, 32);
> > > > +     bitmap_xor(changed, old, new, 64);
> > > > +
> > > > +     if (((u32 *)changed)[0])
> > > > +             xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET,
> > > > +                             state[0]);
> > > > +     if (((u32 *)changed)[1])
> > > > +             xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> > > > +                             XGPIO_CHANNEL_OFFSET, state[1]);
> > > > +
> > > > +     spin_unlock(&chip->gpio_lock[1]);
> > > > +     spin_unlock_irqrestore(&chip->gpio_lock[0], flags);
> > > >  }
> > > >
> > > >  /**
> > > >
> > >
> > > Srinivas N: Can you please test this code?
> > >
> > > Thanks,
> > > Michal
> >
> > Hey, any chance of getting that Tested-by?
> I tested patches with few modifications in code (spin_lock handling and merge conflict).
> functionality wise it's working fine.
>
> >
> > Bart

Hi Bartosz,

May I please know the URL of the tree that you are using. I had been
using the tree below for submitting this patchset on GPIO to you.
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git

I think I am using the wrong tree. On which tree should I base my
patches on for my next  (v4) submission? Should I use the tree below?
:
https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git

Regards
Syed Nayyar Waris
