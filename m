Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A72A352982
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 12:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhDBKHk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 06:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhDBKHj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 06:07:39 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C98C0613E6;
        Fri,  2 Apr 2021 03:07:38 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e186so4892622iof.7;
        Fri, 02 Apr 2021 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SeOEv4eerfZMMN9wbPTmtUV41hsInB/cRaOxivaSmYg=;
        b=B0meY3W3X5Y8YLebNNl4XcvfgWTq8mBvPURN1m3huvgOzYL1ZxdoeFGBzQ2RX1O2+X
         Jmx9A8D7rA7yuuLrgmWLz8HRT23m9qJxtCK5dhpHhv59FulYkCJXM6IXl/ymFmntFKNA
         icV+5K9OD4e/ReICmsl4QrcJA+ipoGVoU1ge/Zh4Z0vcE56hZJbgCaZuQD92WX2aqmLe
         kjcEWqz3sv1a9PRo6OOtZZJCQ4rxgr1RSbb/U/9JYKqPLtcOBBzDIFUmktOyepk4+E6w
         Qjd9KqdROlIz5q0DPEd12oMec8tpUuJTxcr3KKEhmLIyr0hGXgmcawD5qUng8F414OTB
         /LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SeOEv4eerfZMMN9wbPTmtUV41hsInB/cRaOxivaSmYg=;
        b=lABBA9uwO2voppOvyz5ZyhEKlFabSd1rd5iGHGf4eXdKiHEbQC/by0WyzrIbGje9TP
         dFGRB/YCR+jIptEoJtcDYChm3IjX2ZhmkQJUDlGZ8BPHUNN5E0VSVtC3wiyLwwKQmt4G
         dXOMuEmY20TR6DIgxKGWSlTTlsAnK0bx0U1RBPg0+sV2VbS0CpJK3J1VGtVum5TYs6Ox
         WxH+Pt6wh3jVN7eeTewzV2L5P/CABBKCSM585myBbsJnZpq6q3QG7Aupk8eGqjFQsHIU
         rRJjiXylrwzaURlGbfSY/jceu46gDRLVPpkBtJaTubM1xnFr+XnClwtIl/spp369VDvz
         iNUA==
X-Gm-Message-State: AOAM532tno637S7LcdgD/iv0Y2U3heARYiMh0RAl4OyH0LpYpMneMcL7
        rMi+3QyZ6N7K/U9e3J7PPm/36o/z670w5CTw+so=
X-Google-Smtp-Source: ABdhPJzGJSd3y77/tYWERkflE7EwK2aNPKQZZnYP6DrG1spSrX7/cbJyzHUyyOK87SbC6l2f8o2iM1U/vAzvLJRTgJY=
X-Received: by 2002:a02:c6c4:: with SMTP id r4mr11861455jan.77.1617358057544;
 Fri, 02 Apr 2021 03:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615038553.git.syednwaris@gmail.com> <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
 <YGHxNFXAjcg4PfnE@smile.fi.intel.com>
In-Reply-To: <YGHxNFXAjcg4PfnE@smile.fi.intel.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 2 Apr 2021 15:37:26 +0530
Message-ID: <CACG_h5qV2g7GUKtktBydxfx2Z-o3_6Tssj_+Dt-xZxYKVo9YMw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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

On Mon, Mar 29, 2021 at 8:54 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Mar 06, 2021 at 07:36:30PM +0530, Syed Nayyar Waris wrote:
> > This patch reimplements the xgpio_set_multiple() function in
> > drivers/gpio/gpio-xilinx.c to use the new generic functions:
> > bitmap_get_value() and bitmap_set_value(). The code is now simpler
> > to read and understand. Moreover, instead of looping for each bit
> > in xgpio_set_multiple() function, now we can check each channel at
> > a time and save cycles.
>
> ...
>
> > +     u32 *const state = chip->gpio_state;
>
> Looking at this... What's the point of the const here?
>
> Am I right that this tells: pointer is a const, while the data underneath
> can be modified?

Yes you are right and the data underneath can be modified.
I have removed the 'const' in v4

>
> > +     unsigned int *const width = chip->gpio_width;
>
> Ditto.
>
> Putting const:s here and there for sake of the const is not good practice.
> It makes code harder to read.

Okay.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
