Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBC83519F4
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhDAR5J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 13:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbhDARxQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 13:53:16 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B38C05BD41
        for <linux-arch@vger.kernel.org>; Thu,  1 Apr 2021 05:51:48 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id j2so1657384ybj.8
        for <linux-arch@vger.kernel.org>; Thu, 01 Apr 2021 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1VB1ralBR7+e/H7JqA/6mMiYo3JOylCfFNbfyvT27M=;
        b=C8Z1fGmD0ugXE9aGQpDEEcbJPwy2biu89w6Y8hjTLRV+uZ6Y+fa5ayeevztvzJk+dU
         PX2Rwh+sIiRbjGzRPRKXUXZk7IfGSsgtMCvqlVkz2WF9P4XXjC9JtmvDJGd8cQp5iUEW
         7h6YWHc3ZAchF/U59kTlgfc/r1dtfTFNnoFrMgOKzlAVOcb3zHPu9VtojLYbJwtLFk/6
         +oKvoicUnGd7b8+54QGsxVhMEFiJZjn8JHAoY4jACV/jFQTp8R152wz4eg52V/LGZfJp
         JojHcn5GNEp6DijbKwabno/N5j2/fkHlrKTeccFq0wC3lrmyC7nKB0xUN6+/ttzTnaXt
         bEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1VB1ralBR7+e/H7JqA/6mMiYo3JOylCfFNbfyvT27M=;
        b=r7c4wId7lxvCEx8oaFOssHAYUuV8H0CkcDKUKfId11lYIUlzaFhEzUVeNpR91+1a1u
         Atsz1l2yQHQoEM/Wwk5Q6j8dHrBKWFddNPm6TBDf9nKaLYs+ugSnL0RzH5Eewp+fIqLN
         hkBAlmyMeetfENVfuqp20UYHBmmqt9AroxrQAggfnwIbypP9Mmh7UIkj4a91PGb+Qoep
         m075ZscvKYIQIdVDovya9Fy01qvTm2mt3xda/LD7EytvzKVGjUxq1oSKkH4ApkxSnrHh
         nyMWdBSDqdIB13frFpFVTLXHNj0Bmkn6LdDNoHFeG5apb+pb2Hsyn/+bg2uq5BqgTaB+
         tAKQ==
X-Gm-Message-State: AOAM5306cpsT08R+uqmDy6jXyysB/R2D6tRjkmpf6SiJZWmxJKSFfc0i
        BoRaNGa6aFOgHEPEvUtQwZclh4N9bsWTI/uk2pNoQw==
X-Google-Smtp-Source: ABdhPJzvynb+mFT6Mi7hEx6IXLxnNBonNu1ObAo/1/4cv6eeRaXfFt+HU09XZQgNU5/AQabX6bp6nFyK8dybNvj64T8=
X-Received: by 2002:a25:d2d3:: with SMTP id j202mr11341988ybg.157.1617281507590;
 Thu, 01 Apr 2021 05:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615038553.git.syednwaris@gmail.com> <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
 <36db7be3-73b6-c822-02e8-13e3864b0463@xilinx.com> <CAMpxmJUv0iU0Ntmks1f6ThDAG6x_eJLYYCaDSjy+1Syedzc5dQ@mail.gmail.com>
 <DM6PR02MB53863852A28F782B0942ECD8AF7C9@DM6PR02MB5386.namprd02.prod.outlook.com>
 <CACG_h5q6P5NiNByttQ-NZvq8x3GCTKfSU=Yyywk7PcO6_=i2Mw@mail.gmail.com>
In-Reply-To: <CACG_h5q6P5NiNByttQ-NZvq8x3GCTKfSU=Yyywk7PcO6_=i2Mw@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 1 Apr 2021 14:51:36 +0200
Message-ID: <CAMpxmJUO48Aor0zSofOPJgtKJPL-DKe01a=FOd-Aqz-OHYeZOg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     Syed Nayyar Waris <syednwaris@gmail.com>
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

On Thu, Apr 1, 2021 at 1:16 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> On Wed, Mar 31, 2021 at 8:56 PM Srinivas Neeli <sneeli@xilinx.com> wrote:
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > Sent: Friday, March 26, 2021 10:58 PM
> > > To: Michal Simek <michals@xilinx.com>
> > > Cc: Syed Nayyar Waris <syednwaris@gmail.com>; Srinivas Neeli
> > > <sneeli@xilinx.com>; Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com>; William Breathitt Gray
> > > <vilhelm.gray@gmail.com>; Arnd Bergmann <arnd@arndb.de>; Robert
> > > Richter <rrichter@marvell.com>; Linus Walleij <linus.walleij@linaro.org>;
> > > Masahiro Yamada <yamada.masahiro@socionext.com>; Andrew Morton
> > > <akpm@linux-foundation.org>; Zhang Rui <rui.zhang@intel.com>; Daniel
> > > Lezcano <daniel.lezcano@linaro.org>; Amit Kucheria
> > > <amit.kucheria@verdurent.com>; Linux-Arch <linux-arch@vger.kernel.org>;
> > > linux-gpio <linux-gpio@vger.kernel.org>; LKML <linux-
> > > kernel@vger.kernel.org>; arm-soc <linux-arm-kernel@lists.infradead.org>;
> > > linux-pm <linux-pm@vger.kernel.org>; Srinivas Goud <sgoud@xilinx.com>
> > > Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and
> > > _set_value
> > >
> > > On Mon, Mar 8, 2021 at 8:13 AM Michal Simek <michal.simek@xilinx.com>
> > > wrote:
> > > >
> > > >
> > > >
> > > > On 3/6/21 3:06 PM, Syed Nayyar Waris wrote:
> > > > > This patch reimplements the xgpio_set_multiple() function in
> > > > > drivers/gpio/gpio-xilinx.c to use the new generic functions:
> > > > > bitmap_get_value() and bitmap_set_value(). The code is now simpler
> > > > > to read and understand. Moreover, instead of looping for each bit in
> > > > > xgpio_set_multiple() function, now we can check each channel at a
> > > > > time and save cycles.
> > > > >
> > > > > Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > > Cc: Michal Simek <michal.simek@xilinx.com>
> > > > > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > > > > Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > > > ---
> > > > >  drivers/gpio/gpio-xilinx.c | 63
> > > > > +++++++++++++++++++-------------------
> > > > >  1 file changed, 32 insertions(+), 31 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> > > > > index be539381fd82..8445e69cf37b 100644
> > > > > --- a/drivers/gpio/gpio-xilinx.c
> > > > > +++ b/drivers/gpio/gpio-xilinx.c
> > > > > @@ -15,6 +15,7 @@
> > > > >  #include <linux/of_device.h>
> > > > >  #include <linux/of_platform.h>
> > > > >  #include <linux/slab.h>
> > > > > +#include "gpiolib.h"
> > > > >
> > > > >  /* Register Offset Definitions */
> > > > >  #define XGPIO_DATA_OFFSET   (0x0)    /* Data register  */
> > > > > @@ -141,37 +142,37 @@ static void xgpio_set_multiple(struct
> > > > > gpio_chip *gc, unsigned long *mask,  {
> > > > >       unsigned long flags;
> > > > >       struct xgpio_instance *chip = gpiochip_get_data(gc);
> > > > > -     int index = xgpio_index(chip, 0);
> > > > > -     int offset, i;
> > > > > -
> > > > > -     spin_lock_irqsave(&chip->gpio_lock[index], flags);
> > > > > -
> > > > > -     /* Write to GPIO signals */
> > > > > -     for (i = 0; i < gc->ngpio; i++) {
> > > > > -             if (*mask == 0)
> > > > > -                     break;
> > > > > -             /* Once finished with an index write it out to the register */
> > > > > -             if (index !=  xgpio_index(chip, i)) {
> > > > > -                     xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> > > > > -                                    index * XGPIO_CHANNEL_OFFSET,
> > > > > -                                    chip->gpio_state[index]);
> > > > > -                     spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
> > > > > -                     index =  xgpio_index(chip, i);
> > > > > -                     spin_lock_irqsave(&chip->gpio_lock[index], flags);
> > > > > -             }
> > > > > -             if (__test_and_clear_bit(i, mask)) {
> > > > > -                     offset =  xgpio_offset(chip, i);
> > > > > -                     if (test_bit(i, bits))
> > > > > -                             chip->gpio_state[index] |= BIT(offset);
> > > > > -                     else
> > > > > -                             chip->gpio_state[index] &= ~BIT(offset);
> > > > > -             }
> > > > > -     }
> > > > > -
> > > > > -     xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> > > > > -                    index * XGPIO_CHANNEL_OFFSET, chip->gpio_state[index]);
> > > > > -
> > > > > -     spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
> > > > > +     u32 *const state = chip->gpio_state;
> > > > > +     unsigned int *const width = chip->gpio_width;
> > > > > +
> > > > > +     DECLARE_BITMAP(old, 64);
> > > > > +     DECLARE_BITMAP(new, 64);
> > > > > +     DECLARE_BITMAP(changed, 64);
> > > > > +
> > > > > +     spin_lock_irqsave(&chip->gpio_lock[0], flags);
> > > > > +     spin_lock(&chip->gpio_lock[1]);
> > > > > +
> > > > > +     bitmap_set_value(old, 64, state[0], width[0], 0);
> > > > > +     bitmap_set_value(old, 64, state[1], width[1], width[0]);
> > > > > +     bitmap_replace(new, old, bits, mask, gc->ngpio);
> > > > > +
> > > > > +     bitmap_set_value(old, 64, state[0], 32, 0);
> > > > > +     bitmap_set_value(old, 64, state[1], 32, 32);
> > > > > +     state[0] = bitmap_get_value(new, 0, width[0]);
> > > > > +     state[1] = bitmap_get_value(new, width[0], width[1]);
> > > > > +     bitmap_set_value(new, 64, state[0], 32, 0);
> > > > > +     bitmap_set_value(new, 64, state[1], 32, 32);
> > > > > +     bitmap_xor(changed, old, new, 64);
> > > > > +
> > > > > +     if (((u32 *)changed)[0])
> > > > > +             xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET,
> > > > > +                             state[0]);
> > > > > +     if (((u32 *)changed)[1])
> > > > > +             xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> > > > > +                             XGPIO_CHANNEL_OFFSET, state[1]);
> > > > > +
> > > > > +     spin_unlock(&chip->gpio_lock[1]);
> > > > > +     spin_unlock_irqrestore(&chip->gpio_lock[0], flags);
> > > > >  }
> > > > >
> > > > >  /**
> > > > >
> > > >
> > > > Srinivas N: Can you please test this code?
> > > >
> > > > Thanks,
> > > > Michal
> > >
> > > Hey, any chance of getting that Tested-by?
> > I tested patches with few modifications in code (spin_lock handling and merge conflict).
> > functionality wise it's working fine.
> >
> > >
> > > Bart
>
> Hi Bartosz,
>
> May I please know the URL of the tree that you are using. I had been
> using the tree below for submitting this patchset on GPIO to you.
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
>
> I think I am using the wrong tree. On which tree should I base my
> patches on for my next  (v4) submission? Should I use the tree below?
> :
> https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
>
> Regards
> Syed Nayyar Waris

Yes this is the one. Please address new issues raised by reviewers.

Bart
