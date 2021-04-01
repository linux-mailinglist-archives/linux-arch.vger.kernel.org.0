Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C985351119
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 10:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhDAIsu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 04:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhDAIsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 04:48:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25487C0613E6;
        Thu,  1 Apr 2021 01:48:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso650531pjb.3;
        Thu, 01 Apr 2021 01:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zaMKRvnuGzCN3sXjasGo8hmNFZefS5kSQGclo2fJbBI=;
        b=RljTDOEYU5XD+dZbqPCT0sRbBCzSo+UFmVUzBkTwHvl4gZ2pUQe0+WjEXJEE2jsBd6
         ZWO9Ffluvko6gBrEZ0GS10VRCIyB6hVuXie4Nwh9bY9G6SuxCwdc0PzYkXi1/HjViyQ6
         TApFIOfDUzfXslu7xPtrqUQPFu80STdM5GhiLc8KR6OQasaosPaJ5ixgWUUTyEgZS4El
         2BghF6UtLpMLhSvxFwEWAo7bq8D1tTrlWSXbAai0HJ/max4AVhSFR4Fq5mYbD6tGkxWb
         gJL1+IjFzf5SQBwxB433GSOiVcD7Y+QTe8k28x1u1nSvip/Vpd7sXQS1kHqzG4ypzI0r
         tAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zaMKRvnuGzCN3sXjasGo8hmNFZefS5kSQGclo2fJbBI=;
        b=EkQhlsMCz0BVeL85lWfnRrN6gx7Cly4liXydf9S3tdW+nec9zu4NZvv8BOxSaFJIab
         hX0lQ/aS8ser4tCD1oq9EwOAdBcX1NiKq9X0/sibjpIstD/XdqkVc8xoMa2j0V4wquRd
         KIOvJErq/gc8LJUu87AxmlOqhZJfq73bPF2tjNQyszWiDniDsSow2EOftxH2q+ibZXST
         5uF9bkGpBZ+zK5YqMsf2QZKszQurejOBjtsgXztVj1S4DkLwhC4+pgKvYcaBrK9t9SDL
         N1GCNJdRqPM46mnDSw2hY/hrYDf6iTFeyT1/34pMWUChiq/QU7MEw1O11npeTXpZNW7X
         bZ0w==
X-Gm-Message-State: AOAM531nn71IalLsr8izbqlkxX0A5z8qWdvL4y2VumvYiPwF4UMxVSsG
        XgWaFe4qArZz437k6HmagaQ1FzOCXDYb5ofqcDs=
X-Google-Smtp-Source: ABdhPJwD8VPdnqmAWIPa4E1ZC+MKDhMghA/DJtHpKqSt5PzZvEnlukiOQ/Q9RsJYH72bZmvB9GrVcr8b7RqVItcMmks=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr7035221plq.17.1617266917618; Thu, 01 Apr
 2021 01:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210401003153.97325-1-yury.norov@gmail.com> <20210401003153.97325-10-yury.norov@gmail.com>
In-Reply-To: <20210401003153.97325-10-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Apr 2021 11:48:21 +0300
Message-ID: <CAHp75Vd6c4+Q5+-FYcMPL_64FX2qjqmz9u0hJ7N0m2Ojs0RCcA@mail.gmail.com>
Subject: Re: [PATCH 09/12] lib: add fast path for find_next_*_bit()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 1, 2021 at 3:41 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> Similarly to bitmap functions, find_next_*_bit() users will benefit
> if we'll handle a case of bitmaps that fit into a single word inline.
> In the very best case, the compiler may replace a function call with
> a few instructions.
>
> This is the quite typical find_next_bit() user:
>
>         unsigned int cpumask_next(int n, const struct cpumask *srcp)
>         {
>                 /* -1 is a legal arg here. */
>                 if (n != -1)
>                         cpumask_check(n);
>                 return find_next_bit(cpumask_bits(srcp), nr_cpumask_bits, n + 1);
>         }
>         EXPORT_SYMBOL(cpumask_next);
>
> Currently, on ARM64 the generated code looks like this:
>         0000000000000000 <cpumask_next>:
>            0:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
>            4:   11000402        add     w2, w0, #0x1
>            8:   aa0103e0        mov     x0, x1
>            c:   d2800401        mov     x1, #0x40                       // #64
>           10:   910003fd        mov     x29, sp
>           14:   93407c42        sxtw    x2, w2
>           18:   94000000        bl      0 <find_next_bit>
>           1c:   a8c17bfd        ldp     x29, x30, [sp], #16
>           20:   d65f03c0        ret
>           24:   d503201f        nop
>
> After applying this patch:
>         0000000000000140 <cpumask_next>:
>          140:   11000400        add     w0, w0, #0x1
>          144:   93407c00        sxtw    x0, w0
>          148:   f100fc1f        cmp     x0, #0x3f
>          14c:   54000168        b.hi    178 <cpumask_next+0x38>  // b.pmore
>          150:   f9400023        ldr     x3, [x1]
>          154:   92800001        mov     x1, #0xffffffffffffffff         // #-1
>          158:   9ac02020        lsl     x0, x1, x0
>          15c:   52800802        mov     w2, #0x40                       // #64
>          160:   8a030001        and     x1, x0, x3
>          164:   dac00020        rbit    x0, x1
>          168:   f100003f        cmp     x1, #0x0
>          16c:   dac01000        clz     x0, x0
>          170:   1a800040        csel    w0, w2, w0, eq  // eq = none
>          174:   d65f03c0        ret
>          178:   52800800        mov     w0, #0x40                       // #64
>          17c:   d65f03c0        ret
>
> find_next_bit() call is replaced with 6 instructions. find_next_bit()
> itself is 41 instructions plus function call overhead.
>
> Despite inlining, the scripts/bloat-o-meter report smaller .text size
> after applying the series:
>         add/remove: 11/9 grow/shrink: 233/176 up/down: 5780/-6768 (-988)

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/asm-generic/bitops/find.h | 30 ++++++++++++++++++++++++++++++
>  include/asm-generic/bitops/le.h   | 21 +++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> index 7ad70dab8e93..4148c74a1e4d 100644
> --- a/include/asm-generic/bitops/find.h
> +++ b/include/asm-generic/bitops/find.h
> @@ -20,6 +20,16 @@ static inline
>  unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
>                             unsigned long offset)
>  {
> +       if (small_const_nbits(size)) {
> +               unsigned long val;
> +
> +               if (unlikely(offset >= size))
> +                       return size;
> +
> +               val = *addr & GENMASK(size - 1, offset);
> +               return val ? __ffs(val) : size;
> +       }
> +
>         return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
>  }
>  #endif
> @@ -40,6 +50,16 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
>                 const unsigned long *addr2, unsigned long size,
>                 unsigned long offset)
>  {
> +       if (small_const_nbits(size)) {
> +               unsigned long val;
> +
> +               if (unlikely(offset >= size))
> +                       return size;
> +
> +               val = *addr1 & *addr2 & GENMASK(size - 1, offset);
> +               return val ? __ffs(val) : size;
> +       }
> +
>         return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
>  }
>  #endif
> @@ -58,6 +78,16 @@ static inline
>  unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>                                  unsigned long offset)
>  {
> +       if (small_const_nbits(size)) {
> +               unsigned long val;
> +
> +               if (unlikely(offset >= size))
> +                       return size;
> +
> +               val = *addr | ~GENMASK(size - 1, offset);
> +               return val == ~0UL ? size : ffz(val);
> +       }
> +
>         return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
>  }
>  #endif
> diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
> index 21305f6cea0b..5a28629cbf4d 100644
> --- a/include/asm-generic/bitops/le.h
> +++ b/include/asm-generic/bitops/le.h
> @@ -5,6 +5,7 @@
>  #include <asm-generic/bitops/find.h>
>  #include <asm/types.h>
>  #include <asm/byteorder.h>
> +#include <linux/swab.h>
>
>  #if defined(__LITTLE_ENDIAN)
>
> @@ -37,6 +38,16 @@ static inline
>  unsigned long find_next_zero_bit_le(const void *addr, unsigned
>                 long size, unsigned long offset)
>  {
> +       if (small_const_nbits(size)) {
> +               unsigned long val = *(const unsigned long *)addr;
> +
> +               if (unlikely(offset >= size))
> +                       return size;
> +
> +               val = swab(val) | ~GENMASK(size - 1, offset);
> +               return val == ~0UL ? size : ffz(val);
> +       }
> +
>         return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
>  }
>  #endif
> @@ -46,6 +57,16 @@ static inline
>  unsigned long find_next_bit_le(const void *addr, unsigned
>                 long size, unsigned long offset)
>  {
> +       if (small_const_nbits(size)) {
> +               unsigned long val = *(const unsigned long *)addr;
> +
> +               if (unlikely(offset >= size))
> +                       return size;
> +
> +               val = swab(val) & GENMASK(size - 1, offset);
> +               return val ? __ffs(val) : size;
> +       }
> +
>         return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
>  }
>  #endif
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
