Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF61352DC5
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhDBQel (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 12:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhDBQek (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 12:34:40 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704EFC0613E6;
        Fri,  2 Apr 2021 09:34:38 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id v26so5837526iox.11;
        Fri, 02 Apr 2021 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8v8CIhwHDdz8dsy06Gqi7STRaNHQYTG480K0RPsixk=;
        b=b2KbPYk3xnSitGK4Ia0w5NnItEvDnmeZR/PhXitHfptzC99XrALhuNe9i369QaVOLf
         K0Ys7YEcMx3cXq4DHwIN3OAQDLX77abaWK6+qXsYJuGl8oKa9cQpXejI9o2AXYNgRwE3
         u6OlWwZxXejNWM7FtP2uveX44xJDxoH2fdPnz7wpKAaQgxhvsDwShrTKAuE0I9e7uodF
         NSn8n41NGpMsZ2qZBpUJsmKqFSGsZqd0yoo+JTZgkQwvoCBYLZ5YnsENI3cVqOhACyHh
         fwR48rltLme7xFR2etcz38QWApistPFz80xqkGFVL26eu3Pe03jXykKP4KSN898KR6RU
         EP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8v8CIhwHDdz8dsy06Gqi7STRaNHQYTG480K0RPsixk=;
        b=iY7jHR1qoYMSm5AgqKOHh5TtbZPlNLD/IDuxMSQK4JjpHUBPzPoZAOUugeKxjENIzW
         MAbuGhArN9wPy/ueOEbBOGRYvfMF5GjCQiss3KkjHEPpLC/oNZ907sI3D6sDBTU8pqHM
         hLT4LRgXM3b077EhmQLXK9ZeImHzi4UXrhh/xbscJkF6aFL+F3vkBMqZbi7v4dmkE3b4
         FLAx5vdSTmcNkezOLSgigunqFthRmJI56OnQRcuBTlZpFuLxQieFb6zzRy0M7Bs7o6Py
         zXGehpJWS2BbjT1V7exHj1Ac8KtuiJFdlg+CZq7rbI46ccPCIJAVpdpCnYmcsFx3Onb1
         IW0Q==
X-Gm-Message-State: AOAM531BkNjuaTQaNiCeMvni+Q1JkJ0CVHZRiWxTL5blzE/5jischgNt
        4QjtWc4ackdyVe7Hlp+pMFGYytiPELrKVQ/Pof4=
X-Google-Smtp-Source: ABdhPJzc6dF+lA6jScJy+mZTDqxwOqU1OzmImnZ+6BCgmMFhu695HZUKhFXQXRGwrEGF9+lq89pUhj4lWYwDK3jQT/E=
X-Received: by 2002:a02:c017:: with SMTP id y23mr13743431jai.3.1617381277426;
 Fri, 02 Apr 2021 09:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617357235.git.syednwaris@gmail.com> <00d085d4068be651c58a61564926d4f3d495ab80.1617357235.git.syednwaris@gmail.com>
In-Reply-To: <00d085d4068be651c58a61564926d4f3d495ab80.1617357235.git.syednwaris@gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 2 Apr 2021 22:04:25 +0530
Message-ID: <CACG_h5rCPSdQApNzGziqxpd9aVc4uP9Q7zKRnBW5NBrH=ZxTcw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     bgolaszewski@baylibre.com
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, yamada.masahiro@socionext.com,
        akpm@linux-foundation.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 2, 2021 at 3:42 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> This patch reimplements the xgpio_set_multiple() function in
> drivers/gpio/gpio-xilinx.c to use the new generic functions:
> bitmap_get_value() and bitmap_set_value(). The code is now simpler
> to read and understand. Moreover, instead of looping for each bit
> in xgpio_set_multiple() function, now we can check each channel at
> a time and save cycles.
>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/gpio/gpio-xilinx.c | 60 +++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index b411d3156e0b..e0ad3a81f216 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> +#include "gpiolib.h"
>
>  /* Register Offset Definitions */
>  #define XGPIO_DATA_OFFSET   (0x0)      /* Data register  */
> @@ -161,37 +162,36 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>  {
>         unsigned long flags;
>         struct xgpio_instance *chip = gpiochip_get_data(gc);
> -       int index = xgpio_index(chip, 0);
> -       int offset, i;
>
> -       spin_lock_irqsave(&chip->gpio_lock, flags);
> -
> -       /* Write to GPIO signals */
> -       for (i = 0; i < gc->ngpio; i++) {
> -               if (*mask == 0)
> -                       break;
> -               /* Once finished with an index write it out to the register */
> -               if (index !=  xgpio_index(chip, i)) {
> -                       xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> -                                      index * XGPIO_CHANNEL_OFFSET,
> -                                      chip->gpio_state[index]);
> -                       spin_unlock_irqrestore(&chip->gpio_lock, flags);
> -                       index =  xgpio_index(chip, i);
> -                       spin_lock_irqsave(&chip->gpio_lock, flags);
> -               }
> -               if (__test_and_clear_bit(i, mask)) {
> -                       offset =  xgpio_offset(chip, i);
> -                       if (test_bit(i, bits))
> -                               chip->gpio_state[index] |= BIT(offset);
> -                       else
> -                               chip->gpio_state[index] &= ~BIT(offset);
> -               }
> -       }
> -
> -       xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> -                      index * XGPIO_CHANNEL_OFFSET, chip->gpio_state[index]);
> -
> -       spin_unlock_irqrestore(&chip->gpio_lock, flags);
> +    u32 *state = chip->gpio_state;
> +    unsigned int *width = chip->gpio_width;
> +    DECLARE_BITMAP(old, 64);
> +    DECLARE_BITMAP(new, 64);
> +    DECLARE_BITMAP(changed, 64);
> +
> +    spin_lock_irqsave(&chip->gpio_lock, flags);
> +
> +    /* Copy initial value of state bits into 'old' bit-wise */
> +    bitmap_set_value(old, 64, state[0], width[0], 0);
> +    bitmap_set_value(old, 64, state[1], width[1], width[0]);
> +    /* Copy value from 'old' into 'new' with mask applied */
> +    bitmap_replace(new, old, bits, mask, gc->ngpio);
> +
> +    bitmap_from_arr32(old, state, 64);
> +    /* Update 'state' */
> +    state[0] = bitmap_get_value(new, 0, width[0]);
> +    state[1] = bitmap_get_value(new, width[0], width[1]);
> +    bitmap_from_arr32(new, state, 64);
> +    /* XOR operation sets only changed bits */
> +    bitmap_xor(changed, old, new, 64);
> +
> +    if (((u32 *)changed)[0])
> +        xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET, state[0]);
> +    if (((u32 *)changed)[1])
> +        xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> +                XGPIO_CHANNEL_OFFSET, state[1]);
> +
> +    spin_unlock_irqrestore(&chip->gpio_lock, flags);
>  }
>
>  /**
> --
> 2.29.0
>

Hi All,

There were indentation errors reported. I am Re-sending the patchset.
I am keeping the version same as v4.

Kindly consider the "RESEND" prefixed v4 patchset for future.

Regards
Syed Nayyar Waris
