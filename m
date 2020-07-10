Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF76E21B0F5
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgGJIFK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 04:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgGJIFJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 04:05:09 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2A6C08C5CE;
        Fri, 10 Jul 2020 01:05:09 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x9so4357913ila.3;
        Fri, 10 Jul 2020 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+G1uuop498qwxWK2qrr1h0MxQXkOdDS2Ry0PGIWZu8=;
        b=YvxH9ESyKpS9/V9ii1PS6FtzJiZYFA9wClEEPvL0ONzCRrvtIAMoymOPopdNGOU9es
         cCl/HDFzk52+lGUbBZ+KmCmFp+UFDkGYrQQ3LWsgLQzvzybigUzJT6u/ULtzOQ1Es58P
         xvVaBNoICUYtGdRBHgOLhP3tRs6xjwLg5iqZ+RPvY7re1B+fPSavTcqfOIAa1LOetTAt
         zT7LT7aaF8tICr7NRKZD4I49axIwa1877DsXecpUN9kN+S5lxOsp8h9vKCz1oQuSdjQO
         6KENMzaEJM2UZnXDkTVJBWfFDVKZPM8CyTwus9kcN1b66+hHvLMgDJTw8mNcfKqN/xXt
         yU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+G1uuop498qwxWK2qrr1h0MxQXkOdDS2Ry0PGIWZu8=;
        b=eFJ23Eq2mDGJ8DRm+CvF4xbgcrIY+RnSarIRAedN5sGpYp80Boj9c0I4aF8pyISnPt
         O3HnNWCjhM4htbJbdNBDDl0fhfVHEAqGOfBc/Weq35ge3Td5H9LHUYvr3unGb481JHAU
         54dUD2jFEVLVQ1XQhS34CJSaT8S4wuMKnT6KQdoMnp8itRkAucmsJrRuuIkCBSVrsUaV
         UUFOSXyHhowPUXs+szAkdtURNcv9MmvpB8gX5dC5BvNjmbuDSFanGhD8/EDa6u5pJykz
         nxTv6Obi0sGADdf1p2+W1ph/6r53COSNj8u7tG4bdfaDJiEK//uVsoc0SUBcH+MHiGB7
         Ndqw==
X-Gm-Message-State: AOAM531XBKe96fAkICnE91RoD9xX7t9H9AhK3CXv8bJcecZV8AQZVm8/
        Hl2pgpC8DmbkPtkFzEJ/erixpCy8kl2V7RyF7hw=
X-Google-Smtp-Source: ABdhPJwQ7A/l6ebIgnp1a0yl+jTVZOrJKIN8Eqvyz9/+o7LaU3fFKI251S+kcR6ZFj4ZommmbaR0Ib6nr+7bNly3SpI=
X-Received: by 2002:a92:c7c3:: with SMTP id g3mr51239040ilk.164.1594368308678;
 Fri, 10 Jul 2020 01:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593243079.git.syednwaris@gmail.com>
In-Reply-To: <cover.1593243079.git.syednwaris@gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 10 Jul 2020 13:34:57 +0530
Message-ID: <CACG_h5q9UJcAx9q7guqH1nKhrg+k2CbWSDuFF4kBab8z6jdPhg@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce the for_each_set_clump macro
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, rrichter@marvell.com,
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
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 27, 2020 at 1:40 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> Hello Linus,
>
> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?
>
> This patchset introduces a new generic version of for_each_set_clump.
> The previous version of for_each_set_clump8 used a fixed size 8-bit
> clump, but the new generic version can work with clump of any size but
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
> But with the new for_each_set_clump the clump size can be different from 8 bits.
> Moreover, the clump can be split at word boundary in situations where word
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
> Different iterations of for_each_set_clump:-
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
> Different iterations of for_each_set_clump:
> 'offset' is the bit position and 'clump' is the 6 bit clump from the
> above bitmap.
> Iteration first:        offset: 6 clump: 0x2b
> Loop breaks because 6 * 3 = 18 bits traversed in bitmap.
> Here 6 * 3 is clump size * no. of clumps.
>
> Changes in v9:
>  - [Patch 4/4]: Remove looping of 'for_each_set_clump' and instead process two
>    halves of a 64-bit bitmap separately or individually. Use normal spin_lock
>    call for second inner lock. And take the spin_lock_init call outside the 'if'
>    condition in the probe function of driver.
>
> Changes in v8:
>  - [Patch 2/4]: Minor change: Use '__initdata' for correct section mismatch
>    in 'clump_test_data' array.
>
> Changes in v7:
>  - [Patch 2/4]: Minor changes: Use macro 'DECLARE_BITMAP()' and split 'struct'
>    definition and test data.
>
> Changes in v6:
>  - [Patch 2/4]: Make 'for loop' inside test_for_each_set_clump more
>    succinct.
>
> Changes in v5:
>  - [Patch 4/4]: Minor change: Hardcode value for better code readability.
>
> Changes in v4:
>  - [Patch 2/4]: Use 'for' loop in test function of for_each_set_clump.
>  - [Patch 3/4]: Minor change: Inline value for better code readability.
>  - [Patch 4/4]: Minor change: Inline value for better code readability.
>
> Changes in v3:
>  - [Patch 3/4]: Change datatype of some variables from u64 to unsigned long
>    in function thunderx_gpio_set_multiple.
>
> CHanges in v2:
>  - [Patch 2/4]: Unify different tests for 'for_each_set_clump'. Pass test data as
>    function parameters.
>  - [Patch 2/4]: Remove unnecessary bitmap_zero calls.
>
> Syed Nayyar Waris (4):
>   bitops: Introduce the for_each_set_clump macro
>   lib/test_bitmap.c: Add for_each_set_clump test cases
>   gpio: thunderx: Utilize for_each_set_clump macro
>   gpio: xilinx: Utilize generic bitmap_get_value and _set_value.
>
>  drivers/gpio/gpio-thunderx.c      |  11 ++-
>  drivers/gpio/gpio-xilinx.c        |  66 +++++++-------
>  include/asm-generic/bitops/find.h |  19 ++++
>  include/linux/bitmap.h            |  61 +++++++++++++
>  include/linux/bitops.h            |  13 +++
>  lib/find_bit.c                    |  14 +++
>  lib/test_bitmap.c                 | 145 ++++++++++++++++++++++++++++++
>  7 files changed, 292 insertions(+), 37 deletions(-)
>
>
> base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
> --
> 2.26.2
>


Hi Andrew, Linus

What do you think about this patchset on 'for_each_set_clump' ?

if there's anything else you think that should be changed in this, or if this
version looks good to you to pick up, kindly, let me know.

Regards
Syed Nayyar Waris
