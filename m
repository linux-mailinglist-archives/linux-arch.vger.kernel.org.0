Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8DA2E330F
	for <lists+linux-arch@lfdr.de>; Sun, 27 Dec 2020 23:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgL0WEE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Dec 2020 17:04:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgL0WEE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 27 Dec 2020 17:04:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 313262242A;
        Sun, 27 Dec 2020 22:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609106603;
        bh=gQ23fPbegXnDwD7TFyM8SYshRz6kzvTEijfM7w8+3s0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eP3I77v/R0SuCfmOw5xMVPxQnv7vqNSHyEb7kTOVyaOZ56khQIC881SVGrCvmRuK/
         OnGKFQmEba8jgBZfYtBJesyyezVYlmLJBBG5TbALHXgihg0mgp9u2ugEiaJYvE8LHh
         21A0ExJ0hASZRD8stNtGn1jR15j6gRyE4V6d5calcnUKi9ph1/hg7PXnZokDkU9Sid
         a2SxFj7ukZSCw1ttAyk6DXtPfKYYCohivw5nxHOOPg6tf6O4JZDuV2H0FJzVPDYGzC
         stWxbH8KXccygJLVdQnwgqfZbDZgv6R7PK/PHxxP+2vN1AVylU6Xip5xt/VWhKO/F5
         FZHmn9dBUPs+w==
Received: by mail-ot1-f51.google.com with SMTP id n42so7770925ota.12;
        Sun, 27 Dec 2020 14:03:23 -0800 (PST)
X-Gm-Message-State: AOAM532R4llhtRLxOWgVET0xMYZu5SJnsiCH5LkX7MO+h6bZ9At8DG4N
        9h+slvgjWzmcDqIWZFRRt2N3G8Q0t0WbcD7pzdE=
X-Google-Smtp-Source: ABdhPJyy+i6e8QV64+vlH7BXLIF7x52lnf5sVIHwLc1ReRHJuAXnbd8gDZmUHonkqTZ2Cj12WLLoqyQ2phtmg8WnFeI=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr31374431otm.305.1609106602554;
 Sun, 27 Dec 2020 14:03:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608963094.git.syednwaris@gmail.com> <bc7bf5556fce464179550c67fbec121626d08e85.1608963095.git.syednwaris@gmail.com>
In-Reply-To: <bc7bf5556fce464179550c67fbec121626d08e85.1608963095.git.syednwaris@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 27 Dec 2020 23:03:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a35N1TvRQsGt+G52XSx0N4FQe_76pU4sf4EiH3Gq=s66A@mail.gmail.com>
Message-ID: <CAK8P3a35N1TvRQsGt+G52XSx0N4FQe_76pU4sf4EiH3Gq=s66A@mail.gmail.com>
Subject: Re: [PATCH 1/5] clump_bits: Introduce the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Dec 26, 2020 at 7:42 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> This macro iterates for each group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to
> the bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value() and bitmap_set_value() functions are introduced to
> respectively get and set a value of n-bits in a bitmap memory region.
> The n-bits can have any size from 1 to BITS_PER_LONG. size less
> than 1 or more than BITS_PER_LONG causes undefined behaviour.
> Moreover, during setting value of n-bit in bitmap, if a situation arise
> that the width of next n-bit is exceeding the word boundary, then it
> will divide itself such that some portion of it is stored in that word,
> while the remaining portion is stored in the next higher word. Similar
> situation occurs while retrieving the value from bitmap.
>
> GCC gives warning in bitmap_set_value(): https://godbolt.org/z/rjx34r
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

Didn't the __builtin_unreachable() end up leading to an objtool
warning about incorrect stack frames for the code path that leads
into the undefined behavior? I thought I saw a message from the 0day
build bot about that and didn't expect to see it again after that.

Can you actually measure any performance difference compared
to BUG_ON() that avoids the undefined behavior? Practically
all CPUs from the past 20 years have branch predictors that should
completely hide measurable overhead from this.

      Arnd
