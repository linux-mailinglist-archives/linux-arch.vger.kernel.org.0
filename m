Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20ED93528F6
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 11:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhDBJk6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 05:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhDBJk5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 05:40:57 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA1BC0613E6;
        Fri,  2 Apr 2021 02:40:57 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r193so1906323ior.9;
        Fri, 02 Apr 2021 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NpfJ7ZDCsL19dq39DZU8Zv+kNBnx+3lvoUY6iHvhzLo=;
        b=nZ/aoOT7fuDONxs8HFnvIWfKJaJK51Zva46kyAvGnIMwidBbKBzlkk2gsmj++BISZO
         F8XZUaiCCLN6/04DmxBI0e5zYCZ66WhQawVIHWEJmU5ovypVxr1u1SAyB6ev/dGDvQrB
         14lK3pRFbZPcP1xxQKH679gvcHxOPd1OZ2X1UefH/z6Z4XH0wujTz55GfO8fJSIDjWY2
         GvcGcDiz0i4g+UulGa3vNI1PtwT0KYEygyWvup098qM+gOrcHgHDFRbrcnMbfBfawAyV
         Hk2T3AQblyZl252l+SzH4l7jgTYTdlPaiKf0QSvxIYiIhFu/EzQbOD1SzNzpBnXcTu4T
         puog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NpfJ7ZDCsL19dq39DZU8Zv+kNBnx+3lvoUY6iHvhzLo=;
        b=ER6uDKjCVkRigLB82PQy68buBZJ4UgSt22UG4rwRZNSLGOzS5x9QgNdbd29yEGDFR0
         gX1NZ3dVT3JM5cLshXpiAPgqVUY+/j635HjeHQGm8gMuxn/RtAZcJwWB3bFxyNfXMn3L
         yZqtwn26WkS4gfc0DKnI8xBKYUW76QlmMVpCQoEfCT/n8zcDAebjwTpIWHON/AVmpq2X
         /kGYikIfsLKaI0G+WateD0Da04QFBDmLnVbQlFo5tbzQQWGeGNvllZncEq3h3TXJ6DGF
         i01HJxMuJDW4dF/rE7CC0+vbFFfKn+bx/02fygEvdUCxjumpnVVKr+AEo3AMBBfFCPva
         t4Mw==
X-Gm-Message-State: AOAM531rR/YdxOTTOGu5Zg3uXz0Isoa/WyC5LvWbB1cYVSlVn6GQKXun
        vWdALAR0r0I+1/OEo2wbzlLd+mdmmds/5bsOD50=
X-Google-Smtp-Source: ABdhPJzHbK5cq1FQe+dTjZRuzv4fwtZuUKmnl4BPeWlMpMqCEbzOkqZIjKR0aKE8oI8LjfZNuxOmzDMyqlFa1tSC9GQ=
X-Received: by 2002:a05:6638:ec7:: with SMTP id q7mr12109057jas.54.1617356456649;
 Fri, 02 Apr 2021 02:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615038553.git.syednwaris@gmail.com> <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
 <CAHp75VePT-Df1F8ma1__ay8+9DHtYwonvwTZtK-OFqCtXshx-w@mail.gmail.com>
In-Reply-To: <CAHp75VePT-Df1F8ma1__ay8+9DHtYwonvwTZtK-OFqCtXshx-w@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 2 Apr 2021 15:10:37 +0530
Message-ID: <CACG_h5pNhJJQ1nvmPmT1iZJwtLB+a-4nmy=TmgU6GLWiyF=bHA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Fri, Mar 26, 2021 at 11:27 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Mar 6, 2021 at 4:08 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> >
> > This patch reimplements the xgpio_set_multiple() function in
> > drivers/gpio/gpio-xilinx.c to use the new generic functions:
> > bitmap_get_value() and bitmap_set_value(). The code is now simpler
> > to read and understand. Moreover, instead of looping for each bit
> > in xgpio_set_multiple() function, now we can check each channel at
> > a time and save cycles.
>
> ...
>
> > +       u32 *const state = chip->gpio_state;
> > +       unsigned int *const width = chip->gpio_width;
>
> > +
>
> Extra blank line.
>
> > +       DECLARE_BITMAP(old, 64);
> > +       DECLARE_BITMAP(new, 64);
> > +       DECLARE_BITMAP(changed, 64);
>
> > +       spin_lock_irqsave(&chip->gpio_lock[0], flags);
> > +       spin_lock(&chip->gpio_lock[1]);
>
> I understand why this is done at the top of the function in the original code.
> I do not understand why you put some operations under spin lock.
>
> Have you checked what each of these spin locks protects?
> Please check and try to lock as minimum as possible.
>
> > +       bitmap_set_value(old, 64, state[0], width[0], 0);
> > +       bitmap_set_value(old, 64, state[1], width[1], width[0]);
> > +       bitmap_replace(new, old, bits, mask, gc->ngpio);
> > +
> > +       bitmap_set_value(old, 64, state[0], 32, 0);
> > +       bitmap_set_value(old, 64, state[1], 32, 32);
> > +       state[0] = bitmap_get_value(new, 0, width[0]);
> > +       state[1] = bitmap_get_value(new, width[0], width[1]);
> > +       bitmap_set_value(new, 64, state[0], 32, 0);
> > +       bitmap_set_value(new, 64, state[1], 32, 32);
> > +       bitmap_xor(changed, old, new, 64);
>
> Original code and this is cryptic. Can you add a few comments
> explaining what is going on here?
>
> > +       spin_unlock(&chip->gpio_lock[1]);
> > +       spin_unlock_irqrestore(&chip->gpio_lock[0], flags);
>
> --
> With Best Regards,
> Andy Shevchenko

Have removed the extra line and added comments. Regarding locking - I
see that now there is just a single lock available instead of 2 locks.
Have made necessary changes. Thanks
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpio/gpio-xilinx.c?id=37ef334680800263b32bb96a5156a4b47f0244a2

Regards

Syed Nayyar Waris
