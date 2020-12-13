Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95362D8E10
	for <lists+linux-arch@lfdr.de>; Sun, 13 Dec 2020 15:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404671AbgLMO4x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Dec 2020 09:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729813AbgLMO4x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Dec 2020 09:56:53 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB8FC0613CF;
        Sun, 13 Dec 2020 06:56:13 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id m6so653439pfm.6;
        Sun, 13 Dec 2020 06:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GVFJG5+b4wwaYZGJY5Q+Ty6yteB44I1X0LEyJpOD4Q=;
        b=GQo8nLjwy/A+Xg4osxyLYZrO41bSCW7aCe+uxkuHo9PGo+M0tWYbKc6bxIYPizyS7J
         juIeeq/7CO8m/xfEpcWNZz39mf5LauZ2R3bAxoGjyyrdpVA4rSEcYEpU/JdfDwP/1G+k
         KY2595tBSlNf2HLzMdrabbvmr0S4Qalr/IjpBZVlDtpMWbSXu3vC5wFzOaMWgXY8gacy
         PJriOKpHfdn3eLCHFLgIIiZzuw2TIi1bjREXPFIvRsV2yDY888gAlfZok/r5diHJ2r78
         SStpmIAx39oRh98debp8Qce656veGXmBj8zjOM8klMCHFLiCDgXoja8XHicnrA3Uk5fr
         Hpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GVFJG5+b4wwaYZGJY5Q+Ty6yteB44I1X0LEyJpOD4Q=;
        b=cIc8vZeMEZVNRrg/jLG/KexPxo5ZFIQjsTcQGHbUhJPQmi2RUrhxsAJB5xqCk5lbHc
         pnd+QsbS87juUscZQshljBksqRj2HIf4tTpw/53rdkxbveNnm8zW2jKhcy7UHd2K4iSq
         hSsNy9J8XtMhOm7GYNCwQhUB1ft4nBtD2WVPSMX1dcWZEhFnh6NWOdq8I0GCUNFEbIQw
         qEeDMMvBvbFqg9RErYytlhWc/UUc/XEq5OOY6vAM1V+KWJX7nEMSa/re9j4KJxW+uuJL
         j0hyR3jq2K4o0DII0zkxtvOCgE/4xrVhIIbXPnxPzvUKbDL+ikTBibMxe2T5A4sW/hWF
         YN3w==
X-Gm-Message-State: AOAM532JDn9fi0+527gu4/GcB61wpjzV5WI7pZjGfW7AFy/Enw9heJsi
        /YSUhO9weiaHe7Go5xjtx1cktiIPBoOWHo7Id0A=
X-Google-Smtp-Source: ABdhPJyHCjy5gjCeZf12NOQT17rVqbmsRh+vBivyM/+Ci93YR1wXBbG3c7sP9pW22RPlYkg5PP+otes6jmJuO6o0IMM=
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id
 66-20020a6204450000b029019c162bbbefmr20182418pfe.40.1607871372903; Sun, 13
 Dec 2020 06:56:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607765147.git.syednwaris@gmail.com> <20268bfeb500ad8819e3a11aa1bea27eade4fd39.1607765147.git.syednwaris@gmail.com>
In-Reply-To: <20268bfeb500ad8819e3a11aa1bea27eade4fd39.1607765147.git.syednwaris@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 13 Dec 2020 16:55:56 +0200
Message-ID: <CAHp75Vef2WDjD=DkoTV13Akk9yxwbF1oJH-=O4Kg_uxtY1qOdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bitmap: Modify bitmap_set_value() to check bitmap length
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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

On Sun, Dec 13, 2020 at 4:24 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> Add explicit check to see if the value being written into the bitmap
> does not fall outside the bitmap.
> The situation that it is falling outside would never be possible in the
> code because the boundaries are required to be correct before the
> function is called. The responsibility is on the caller for ensuring the
> boundaries are correct.
> The code change is simply to silence the GCC warning messages
> because GCC is not aware that the boundaries have already been checked.
> As such, we're better off using __builtin_unreachable() here because we
> can avoid the latency of the conditional check entirely.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>
> lib/test_bitmap.c: Modify for_each_set_clump test
>
> Modify the test where bitmap_set_value() is called. bitmap_set_value()
> now takes an extra bitmap-width as second argument and the width of
> value is now present as the fourth argument.
>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
>
> gpio: xilinx: Modify bitmap_set_value() calls
>
> Modify the bitmap_set_value() calls. bitmap_set_value()
> now takes an extra bitmap width as second argument and the width of
> value is now present as the fourth argument.
>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>

Commit message here definitely needs more work.
First of all, it's now quite awkward to see this squashed stuff like this.
Second, it misses the warning examples it's talking about.
Third, it repeats some tags.
Fourth, it misses the Fixes tag.

Please, redone it correctly (one commit message with clear purpose and
example of warnings followed by Fixes tag) and resend a v3.

You may mention in the cover letter that this is squashed of three
patches from v1 (and give a link to lore.kernel.org).

-- 
With Best Regards,
Andy Shevchenko
