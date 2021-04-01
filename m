Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C72351F12
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhDASwo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 14:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbhDASqn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 14:46:43 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CCDC03117E;
        Thu,  1 Apr 2021 10:47:26 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r193so83139ior.9;
        Thu, 01 Apr 2021 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ABGeqwVjSflF2v2NwkfGGEvt0FHlPNp2jDD7Wn08AU=;
        b=dbI+llyCF1qsXCU+57jJILTQijq3LOuUqHcBa+PDsJZd+qYeLYTTrxhGY6p/hL6FS9
         wAJbCLjYGbywRHj93PpB4vFmO+m5MtJRbkLixlRiIF+GJFoT8DOzAUMnhjB9PD4sKCXc
         s0TXQ4V052qyHV9jW8fqVjxsCpESkWxaV/4bHZdtuPi5sH7i2s7q1qWvS6T9+oRlXDEU
         dzx7L1iiHq1TQGJzzO/cUXcOAYWh+tNNocM46kBm3uBWldpm2KKOlGOqM/iQ3yKMAqJH
         oTNyJVPgFuvSz2K5pLp5cRqdr4eQ4AChyDiR/J92aOEoJ8OKbqahX9atC34oh+XoDhT1
         7J+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ABGeqwVjSflF2v2NwkfGGEvt0FHlPNp2jDD7Wn08AU=;
        b=Nd/8EpV3kHK/YrFjULvnc4XYxnHtYdqs8Y6LT66j+gk5hgcJHK/00FwlWKaQT8besN
         gekkQSY8gqkE13mceOetcJbzjqZfTLr9S4yVZMGmCRv/vi2JlX+iFNo/3k/2nz+V32yM
         BDNZhzl//+w0Q6Y9l9T4jpRE6sEDpO+unCV4xVP7SVY4kqjnxhwsMqPk/1G8+kBDd2zo
         aoSxxL2bXEe/x6kPnQ0eArDCNFD7xgYMGVim49NAHIobjHWnvF/989gN3V8OxtRwPxv8
         AHP1HHkamDC4vOzsCJiUEwstEQEPqzEljmbWl56xlclRzzVV2MVnbmbwYRbcl9pgs2hs
         mcfA==
X-Gm-Message-State: AOAM531CT3hpTnIz+wS6Hso2/SH4YM6ic8edcX2hI0XbMfgssom+znLd
        lxuLl2IY2tLW7J94iw3Lm2n3VV0KjRGzav41q00=
X-Google-Smtp-Source: ABdhPJygL2fEG9ynxvRZd0xI2Sl72GRxKCKZUvZoJJ82A3PudPrn5eaoXRizLdc40BLb9nIB+DYon8bznwjnQa0X3Ew=
X-Received: by 2002:a05:6602:21cd:: with SMTP id c13mr7436621ioc.44.1617299246197;
 Thu, 01 Apr 2021 10:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615038553.git.syednwaris@gmail.com> <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
 <YGHxNFXAjcg4PfnE@smile.fi.intel.com>
In-Reply-To: <YGHxNFXAjcg4PfnE@smile.fi.intel.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Thu, 1 Apr 2021 23:17:14 +0530
Message-ID: <CACG_h5pOJKUQd6h+75_Tiv_VVaUn9Dg9O5UBvQBu_2QWE0E9iw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     bgolaszewski@baylibre.com, vilhelm.gray@gmail.com,
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
>
> > +     unsigned int *const width = chip->gpio_width;
>
> Ditto.
>
> Putting const:s here and there for sake of the const is not good practice.
> It makes code harder to read.
>
> --
> With Best Regards,
> Andy Shevchenko
>
Okay. I will incorporate your comments in my next submission. Thank You.

Regards
Syed Nayyar Waris
