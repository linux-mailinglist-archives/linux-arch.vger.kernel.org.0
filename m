Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AC92D85C8
	for <lists+linux-arch@lfdr.de>; Sat, 12 Dec 2020 11:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438693AbgLLKMB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Dec 2020 05:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405248AbgLLJyA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Dec 2020 04:54:00 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1001C0619D8;
        Sat, 12 Dec 2020 01:39:58 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id q137so12046933iod.9;
        Sat, 12 Dec 2020 01:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hYZSVCjgqXKtM8w9BwAb1e1KcOhU0SGPdZRd58OQmRs=;
        b=pKxu+obPNk7a6SYH3xsDSt9agGgQZDuXzchVjSYTXgwLjARonlnuEGrm0W8cep4KiV
         pZ6Hw2bwsHjcWiCbt28qizIlyUtAMdcoihnbQnzcbntdmT7Rvnl0t8c/Gt5wiS8DxOeP
         1iggijddzfqkYPRaWE7CN1x6gHG3Lwv33dLJAsxQbilBbNl9SJj1fxtgk+x4k1tHpE8u
         RmuuBwnd8FNsEXX5YRGf3JrTdl8NZ/xqnDJcfs4ADrMvr9YM9woWdWD4UGNcNyCMyRDH
         BliWGJIhb0svXU6lKpUilyzj/VsLI43NSzurW15Qv9s72uakm+6ZbM3z9lIRfsmhmwLv
         sOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYZSVCjgqXKtM8w9BwAb1e1KcOhU0SGPdZRd58OQmRs=;
        b=hCVuA60IdAwIiOUNe5lvLV/fvec5Zj7n9KTWLlzUU46KSMWJhzEV6TmR6sYWMtGhgG
         VxZmtzWLnYSNuSnigkRX3iWdqo2ZH30Dmt7pQr8Fs9fGz+xxuEjMzAgzFfnjXSHIVeSn
         d7ynQMQQ177CiNPaY7rU99KhEdS4NrjsYgBaAxvY1K6Yn5Ru8Bxe4RbgcDOhKrjLGVrL
         7md8Mi1GSabyEoezfz6s7p9yUV5vJNyTaWUEXrMXLIpbRr1ilMCwiJDWld9ODkY3TE9n
         +GiAVPiICyQ4/w85QSKCNqwqG4sYTTlP5ibAoGB0l2W+cuURYLraWa6CZ0GWwmT4JxEU
         DfhQ==
X-Gm-Message-State: AOAM531O14l+7ApM0lC57J7ubm4fHRbLxt1BS7IrAyroDeeP4fY0Uvb+
        ej7a+I1kSQ1bK4RnWZQoJ1DGWEYuRGxtioggPHY=
X-Google-Smtp-Source: ABdhPJwnV020ZqaXHNufnjXvtw7jCXttXeXdrOYLOXHKXep/NLPywmuK1frHKxV/Hkp6JjYfTA+aW1xFR5T8rXufrG4=
X-Received: by 2002:a05:6602:14c5:: with SMTP id b5mr20317154iow.44.1607765998041;
 Sat, 12 Dec 2020 01:39:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605893641.git.syednwaris@gmail.com> <c509c26eb9903414bd730bdd344b7864aedaa6f1.1605893642.git.syednwaris@gmail.com>
 <CAMpxmJVNPWCUFnBXzDW3uJ_1Sv4rQ=M0WbKmoW4juYLUQP-ABA@mail.gmail.com>
In-Reply-To: <CAMpxmJVNPWCUFnBXzDW3uJ_1Sv4rQ=M0WbKmoW4juYLUQP-ABA@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sat, 12 Dec 2020 15:09:46 +0530
Message-ID: <CACG_h5o1SCRyU4b_d49S7u1OVeEX_2b0mkBgnzJGNotGw-VwkA@mail.gmail.com>
Subject: Re: [RESEND PATCH 3/4] gpio: xilinx: Modify bitmap_set_value() calls
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 1, 2020 at 9:03 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> On Fri, Nov 20, 2020 at 7:46 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> >
> > Modify the bitmap_set_value() calls. bitmap_set_value()
> > now takes an extra bitmap width as second argument and the width of
> > value is now present as the fourth argument.
> >
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > ---
> >  drivers/gpio/gpio-xilinx.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> > index ad4ee4145db4..05dae086c4d0 100644
> > --- a/drivers/gpio/gpio-xilinx.c
> > +++ b/drivers/gpio/gpio-xilinx.c
> > @@ -151,16 +151,16 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> >         spin_lock_irqsave(&chip->gpio_lock[0], flags);
> >         spin_lock(&chip->gpio_lock[1]);
> >
> > -       bitmap_set_value(old, state[0], 0, width[0]);
> > -       bitmap_set_value(old, state[1], width[0], width[1]);
> > +       bitmap_set_value(old, 64, state[0], width[0], 0);
> > +       bitmap_set_value(old, 64, state[1], width[1], width[0]);
> >         bitmap_replace(new, old, bits, mask, gc->ngpio);
> >
> > -       bitmap_set_value(old, state[0], 0, 32);
> > -       bitmap_set_value(old, state[1], 32, 32);
> > +       bitmap_set_value(old, 64, state[0], 32, 0);
> > +       bitmap_set_value(old, 64, state[1], 32, 32);
> >         state[0] = bitmap_get_value(new, 0, width[0]);
> >         state[1] = bitmap_get_value(new, width[0], width[1]);
> > -       bitmap_set_value(new, state[0], 0, 32);
> > -       bitmap_set_value(new, state[1], 32, 32);
> > +       bitmap_set_value(new, 64, state[0], 32, 0);
> > +       bitmap_set_value(new, 64, state[1], 32, 32);
> >         bitmap_xor(changed, old, new, 64);
> >
> >         if (((u32 *)changed)[0])
> > --
> > 2.29.0
> >
>
> This series is not bisectable because you modify the interface -
> breaking existing users - and you only fix them later. Please squash
> those changes into a single commit.
>
> Bartosz

Hi Bartosz,

I have squashed the changes and have sent a new patchset v2.

Regards
Syed Nayyar Waris
