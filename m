Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF13E352E5D
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhDBRbS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 13:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhDBRbF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 13:31:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63ECC06178C;
        Fri,  2 Apr 2021 10:31:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so2871713pjv.1;
        Fri, 02 Apr 2021 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZh3mSDQYQE4cryDjboNauvPGmXp8rg2ygYGDJ2001s=;
        b=uti1Q7UenDxJjSzrbi/Y+R9MqhtCk5ki73a/PkSsfbXLG2vCctRNOtellfI/d77Pbe
         KpJ5TO2lQxQ6HWlZ8YIEdneuOV1gPhhwKQO5PkgHsJvv6k/rtcJ7vqarbSoFIGVY5R35
         NRAa5szbAjGqdKjSRv6eizO5naZBpUBWvqIP46n9+3CjECqvRcrgKxdhbbZYymx6YmJX
         DBJ+xah/0RKHOmC8RXzQKsI8FcBiGqw8o69IQlcXrAiS8EUPQGHlSAgMm7x2gZ+lSqEc
         guyhTWR2cY1VHsknOiTZpJz+MYH8oXYG6qYJMRjbpkbqqW3XF/qvEdMFeFGPcW27k2ec
         GQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZh3mSDQYQE4cryDjboNauvPGmXp8rg2ygYGDJ2001s=;
        b=Ra/4vrGSZJufyD4yPtue9EppOeJyKs+G3sO4CMKy5u0pVFX6mv1gbtI9urIUIwic7A
         nG2ec+KteZBC9JqBOBnfhkEMLs+x11vipiiBjHxXKTXE3hdXMC86aXjryEsNVPtglZfH
         c1hyOSTH8TefiliBwZKMo2Ibpdv7ANU0dA59HKX5DwVpqGbjh+SF17Dn1Kq+zz+AaHkA
         FK82D7TwJag/zjk6Z4L+pEOm0atIiRh5BnMY2vuVfcHsSy1+FatwKqJ9/CA+G4t29xc+
         0mk4tzbitFs5ENHhtDhTKRTMeItVVbfnP/1PGQsQQRRxVdy2OWu7C4X34n1vXa6jik5H
         Eufg==
X-Gm-Message-State: AOAM532/KEy2EcKyJfnhIm07D2A+t+DMDWYA7MSWdwodgkHpCgZt6y4x
        bAKQuETsMAmXevkO5jwqHGUrEkjfhKdBG/XwdaZEpRwvJHc=
X-Google-Smtp-Source: ABdhPJxCTl+Sc6X0Z4Dse3zRWdNYRmPss0rGxu3wQV2szTOEDu9IZf9Q9PG0rFPR5VkGvD0TXyjN+3Q3K64Fclz9qjY=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr15258280pjx.181.1617384663176;
 Fri, 02 Apr 2021 10:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617380819.git.syednwaris@gmail.com>
In-Reply-To: <cover.1617380819.git.syednwaris@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Apr 2021 20:30:45 +0300
Message-ID: <CAHp75VdUJE_G7D8prW53_p9s06Qs_XzoF9AaYL5HRkDooKCUcw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/3] Introduce the for_each_set_nbits macro
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

On Fri, Apr 2, 2021 at 7:36 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> Hello Bartosz,
>
> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?
>
> This patchset introduces a new generic version of for_each_set_nbits.
> The previous version of for_each_set_clump8 used a fixed size 8-bit
> clump, but the new generic version can work with clump of any size but

clumps

> less than or equal to BITS_PER_LONG. The patchset utilizes the new macro
> in several GPIO drivers.
>
> The earlier 8-bit for_each_set_clump8 facilitated a
> for-loop syntax that iterates over a memory region entire groups of set
> bits at a time.
>
> For example, suppose you would like to iterate over a 32-bit integer 8
> bits at a time, skipping over 8-bit groups with no set bit, where
> XXXXXXXX represents the current 8-bit group:
>
>     Example:        10111110 00000000 11111111 00110011
>     First loop:     10111110 00000000 11111111 XXXXXXXX
>     Second loop:    10111110 00000000 XXXXXXXX 00110011
>     Third loop:     XXXXXXXX 00000000 11111111 00110011
>
> Each iteration of the loop returns the next 8-bit group that has at
> least one set bit.
>
> But with the new for_each_set_nbits the clump size can be different from 8 bits.
> Moreover, the clump can be split at word boundary in situations where word

boundaries

> size is not multiple of clump size. Following are examples showing the working
> of new macro for clump sizes of 24 bits and 6 bits.
>
> Example 1:
> clump size: 24 bits, Number of clumps (or ports): 10
> bitmap stores the bit information from where successive clumps are retrieved.
>
>      /* bitmap memory region */
>         0x00aa0000ff000000;  /* Most significant bits */
>         0xaaaaaa0000ff0000;
>         0x000000aa000000aa;
>         0xbbbbabcdeffedcba;  /* Least significant bits */
>
> Different iterations of for_each_set_nbits:-
> 'offset' is the bit position and 'clump' is the 24 bit clump from the
> above bitmap.
> Iteration first:        offset: 0 clump: 0xfedcba
> Iteration second:       offset: 24 clump: 0xabcdef
> Iteration third:        offset: 48 clump: 0xaabbbb
> Iteration fourth:       offset: 96 clump: 0xaa
> Iteration fifth:        offset: 144 clump: 0xff
> Iteration sixth:        offset: 168 clump: 0xaaaaaa
> Iteration seventh:      offset: 216 clump: 0xff
> Loop breaks because in the end the remaining bits (0x00aa) size was less
> than clump size of 24 bits.
>
> In above example it can be seen that in iteration third, the 24 bit clump
> that was retrieved was split between bitmap[0] and bitmap[1]. This example
> also shows that 24 bit zeroes if present in between, were skipped (preserving
> the previous for_each_set_macro8 behaviour).
>
> Example 2:
> clump size = 6 bits, Number of clumps (or ports) = 3.
>
>      /* bitmap memory region */
>         0x00aa0000ff000000;  /* Most significant bits */
>         0xaaaaaa0000ff0000;
>         0x0f00000000000000;
>         0x0000000000000ac0;  /* Least significant bits */
>
> Different iterations of for_each_set_nbits:
> 'offset' is the bit position and 'clump' is the 6 bit clump from the
> above bitmap.
> Iteration first:        offset: 6 clump: 0x2b
> Loop breaks because 6 * 3 = 18 bits traversed in bitmap.
> Here 6 * 3 is clump size * no. of clumps.

Bart, I would like to have a fresh look at this.

(missed changelog)

> Changes in v4:
>  - [Patch 3/3]: Remove extra line and add few comments.
>  - [Patch 3/3]: Use single lock (and unlock) call instead of two
>    lock (and two unlock) calls.
>  - [Patch 3/3]: Use bitmap_from_arr32() where applicalble.
>  - [Patch 3/3]: Remove unnecessary 'const'.
>
> Changes in v3:
>  - [Patch 1/3]: Rename for_each_set_clump to for_each_set_nbits.
>  - [Patch 1/3]: Shift function definitions outside 'ifdef CONFIG_DEBUG_FS'
>    macro guard to resolve build (linking) error in xilinx Patch[3/3].
>  - [Patch 2/3]: Rename for_each_set_clump to for_each_set_nbits.
>
> Changes in v2:
>  - [Patch 1/3]: Shift the macros and related functions to gpiolib inside
>    gpio/. Reduce the visibilty of 'for_each_set_clump' to gpio.
>  - [Patch 1/3]: Remove __builtin_unreachable and simply use return
>    statement.
>  - Remove tests from lib/test_bitmap.c as 'for_each_set_clump' is
>    now localised inside gpio/ only.
>
> Syed Nayyar Waris (3):
>   gpiolib: Introduce the for_each_set_nbits macro
>   gpio: thunderx: Utilize for_each_set_nbits macro
>   gpio: xilinx: Utilize generic bitmap_get_value and _set_value
>
>  drivers/gpio/gpio-thunderx.c | 13 ++++--
>  drivers/gpio/gpio-xilinx.c   | 52 ++++++++++-----------
>  drivers/gpio/gpiolib.c       | 90 ++++++++++++++++++++++++++++++++++++
>  drivers/gpio/gpiolib.h       | 28 +++++++++++
>  4 files changed, 152 insertions(+), 31 deletions(-)
>
>
> base-commit: e1b7033ecdac56c1cc4dff72d67cac25d449efc6
> --
> 2.29.0
>


-- 
With Best Regards,
Andy Shevchenko
