Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF934AE12
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 18:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCZR6I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 13:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhCZR5w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2021 13:57:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76164C0613AA;
        Fri, 26 Mar 2021 10:57:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h20so1282427plr.4;
        Fri, 26 Mar 2021 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHogjTfSCS2FM3EMJ+VUC86fJfamL4FpcAdJOuvKlos=;
        b=Nxm3UcRVOUnmqeZwyVEW2OWDZ+j/aPRFVyefMabGxG3BS3rOGuwLSh8EzzgfuAJR65
         6pmIMcCvJvrgQ5/XnrCfBj3Dp+qvE2tQMHH0Go01Re229FUzTv2YHp5O+n88s5WqZLen
         IREhlsbWStqk6gWirYZ6dO0FBlzQDfOcvuJlI/b/dY/rDyOnUmJZnYmD8+KyPUpggHE+
         XDQB6AVmwEKflOV/CTo1yOuowEWlyFOalhWIi7H7eESp5pFw/qxD0+p6N5mimzNTkcI6
         uE7sRt4/S9UKoFp8Rd8dVW4ogLVXTZ+dlxowSJbMkoXLZA7k9aOuCDwk+eD8srOAWX8E
         95vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHogjTfSCS2FM3EMJ+VUC86fJfamL4FpcAdJOuvKlos=;
        b=eM+SA6zipqZF69EyBo/MteOodzwYGK1EuOLK0oIE4ieZdGgt2iBTuaFR1/HC+ykCq4
         vWjpbBSozpmTXCXJV5SZeS833C26j7oCnhkHj4Nz9CFzckLfEH7FC2D5jRE2kBGO5rJM
         C2IOPYEHytFQWbXayp6499htv7bZGyEVDen2xyNm0UgKBbN8ZIswfnHostNBfrIvY+US
         FszJjGAaS78KFbXbpzus8JLOiT2xCNjGQPUPnqw43IZDvfrcWM2oOuQkn3CoDzmNDkoa
         ZyIADlQ159ZhVIi2wKRWQqw/6xrJrPZt8E8yl434utG3lRQxT820rH1m+or3Z+Da7NMo
         GPPA==
X-Gm-Message-State: AOAM53264FMN9/Fn7iHhUh4T7PMAQO+TIlfn0BF9mtjRfKYcvXsswgHs
        VmqtGU/shuUhfDDIhQdlLGJ+2/IMhNyzDuGhBj0=
X-Google-Smtp-Source: ABdhPJwAbExeWIMbpFKTjqhO748MOLVjDiBBlAwJFixGI71xALQdNhI30s9oEel/s31WNXXDIHX6ULECiPqQDy/fkXQ=
X-Received: by 2002:a17:90a:e454:: with SMTP id jp20mr15425421pjb.129.1616781471941;
 Fri, 26 Mar 2021 10:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615038553.git.syednwaris@gmail.com> <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
In-Reply-To: <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Mar 2021 19:57:35 +0200
Message-ID: <CAHp75VePT-Df1F8ma1__ay8+9DHtYwonvwTZtK-OFqCtXshx-w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 6, 2021 at 4:08 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> This patch reimplements the xgpio_set_multiple() function in
> drivers/gpio/gpio-xilinx.c to use the new generic functions:
> bitmap_get_value() and bitmap_set_value(). The code is now simpler
> to read and understand. Moreover, instead of looping for each bit
> in xgpio_set_multiple() function, now we can check each channel at
> a time and save cycles.

...

> +       u32 *const state = chip->gpio_state;
> +       unsigned int *const width = chip->gpio_width;

> +

Extra blank line.

> +       DECLARE_BITMAP(old, 64);
> +       DECLARE_BITMAP(new, 64);
> +       DECLARE_BITMAP(changed, 64);

> +       spin_lock_irqsave(&chip->gpio_lock[0], flags);
> +       spin_lock(&chip->gpio_lock[1]);

I understand why this is done at the top of the function in the original code.
I do not understand why you put some operations under spin lock.

Have you checked what each of these spin locks protects?
Please check and try to lock as minimum as possible.

> +       bitmap_set_value(old, 64, state[0], width[0], 0);
> +       bitmap_set_value(old, 64, state[1], width[1], width[0]);
> +       bitmap_replace(new, old, bits, mask, gc->ngpio);
> +
> +       bitmap_set_value(old, 64, state[0], 32, 0);
> +       bitmap_set_value(old, 64, state[1], 32, 32);
> +       state[0] = bitmap_get_value(new, 0, width[0]);
> +       state[1] = bitmap_get_value(new, width[0], width[1]);
> +       bitmap_set_value(new, 64, state[0], 32, 0);
> +       bitmap_set_value(new, 64, state[1], 32, 32);
> +       bitmap_xor(changed, old, new, 64);

Original code and this is cryptic. Can you add a few comments
explaining what is going on here?

> +       spin_unlock(&chip->gpio_lock[1]);
> +       spin_unlock_irqrestore(&chip->gpio_lock[0], flags);

-- 
With Best Regards,
Andy Shevchenko
