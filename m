Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41B33510FA
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 10:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhDAIiZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 04:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhDAIiD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 04:38:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE70C0613E6;
        Thu,  1 Apr 2021 01:38:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ay2so671356plb.3;
        Thu, 01 Apr 2021 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/DR/oCvdUrivLyxVjX0k5t5viZTaG5ynlKBdZ6XK8yw=;
        b=DigLtN+n47ZECxKDEDBm0jjd/+WlZN7IgCN/xHvrAdNSYQtIkAUW7+ofQ8xfZBpj2v
         hmu7oy9Q0/dYIW1+mJC79XH/yRwwVSAijMsqN6nxFEx55vyZCATNO3bKTGcnPOQ92OpF
         avWVuZYCWQQsrb7Z3+bsLGdB9n+BtHsWybs+dTsBRe2R7OtuIeRN2do5Xv1kFy9IOo1o
         3M1WJ2deKgSDCVyjsYhBwiktQSDSPoHPYqSXrXXe/zpK7JrFQZyR6CGtXDDS688lA/Rs
         ud7Kt39BPY2iBXYCKV9BDh9IztDOXF6QX+6z20PMjCOPnfvL3SPE9bAQ5bTrOwzuxzWp
         O89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DR/oCvdUrivLyxVjX0k5t5viZTaG5ynlKBdZ6XK8yw=;
        b=nKM16HZBC+gw2R3KGmnLxtFPzZ31jQpZeBcXaQrgazLFooO6NKU22lf5lLdEIp/64n
         Mbpk6iWd5LTqvLm8aYQWYDql/Jp4T070QuQvh3TyYeTO4DaJ0tcrBhgTSTae4QgPWP3e
         XXhK/y/FcQOA9AqZxUZiJZttzW05N6wM/A/LA8ZJY4TtKGC29YH1zydl2QxrSoiOIFkn
         DrO8FUZ0n2Iia37fUkdySOD8+Ponbdfo/DbO9SWKx12+elVwJgpolq+uQmor3eYCEPr4
         IR08y3yV/baslcO910LDXlp+zXAD24TwteiOMFwb+RIGkte9JZABqzkaJASBlGnuzQFM
         1OLg==
X-Gm-Message-State: AOAM5335PgpiodNpsyYCGX5KMLM9YXlWhreXDEhMqC8I/c9M6/k2iDpM
        7vqJD7bJO4tjqNTZ7IAq3grXCIx0Zgirl+/jMoE=
X-Google-Smtp-Source: ABdhPJy9tIhXmtaO9mcQAPSIZ87x41BYVA/mQb8L8/H9DJeVdXaSW5XcFHUXzVTFLyWkxfeZt9vTK3wDR8r9BtKHZpg=
X-Received: by 2002:a17:902:ee02:b029:e6:5397:d79c with SMTP id
 z2-20020a170902ee02b02900e65397d79cmr7139694plb.21.1617266282119; Thu, 01 Apr
 2021 01:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210401003153.97325-1-yury.norov@gmail.com> <20210401003153.97325-8-yury.norov@gmail.com>
In-Reply-To: <20210401003153.97325-8-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Apr 2021 11:37:45 +0300
Message-ID: <CAHp75VdSgTC7JaNeWY66evEW1FaX+aKG33oO87ESSJQBC0qLHA@mail.gmail.com>
Subject: Re: [PATCH 07/12] lib: inline _find_next_bit() wrappers
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

On Thu, Apr 1, 2021 at 3:42 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> lib/find_bit.c declares five single-line wrappers for _find_next_bit().
> We may turn those wrappers to inline functions. It eliminates unneeded
> function calls and opens room for compile-time optimizations.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/asm-generic/bitops/find.h | 28 ++++++++++++----
>  include/asm-generic/bitops/le.h   | 17 +++++++---
>  lib/find_bit.c                    | 56 ++-----------------------------
>  3 files changed, 37 insertions(+), 64 deletions(-)
>
> diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> index 9fdf21302fdf..7ad70dab8e93 100644
> --- a/include/asm-generic/bitops/find.h
> +++ b/include/asm-generic/bitops/find.h
> @@ -2,6 +2,10 @@
>  #ifndef _ASM_GENERIC_BITOPS_FIND_H_
>  #define _ASM_GENERIC_BITOPS_FIND_H_
>
> +extern unsigned long _find_next_bit(const unsigned long *addr1,
> +               const unsigned long *addr2, unsigned long nbits,
> +               unsigned long start, unsigned long invert, unsigned long le);
> +
>  #ifndef find_next_bit
>  /**
>   * find_next_bit - find the next set bit in a memory region
> @@ -12,8 +16,12 @@
>   * Returns the bit number for the next set bit
>   * If no bits are set, returns @size.
>   */
> -extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
> -               size, unsigned long offset);
> +static inline
> +unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
> +                           unsigned long offset)
> +{
> +       return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
> +}
>  #endif
>
>  #ifndef find_next_and_bit
> @@ -27,9 +35,13 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
>   * Returns the bit number for the next set bit
>   * If no bits are set, returns @size.
>   */
> -extern unsigned long find_next_and_bit(const unsigned long *addr1,
> +static inline
> +unsigned long find_next_and_bit(const unsigned long *addr1,
>                 const unsigned long *addr2, unsigned long size,
> -               unsigned long offset);
> +               unsigned long offset)
> +{
> +       return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
> +}
>  #endif
>
>  #ifndef find_next_zero_bit
> @@ -42,8 +54,12 @@ extern unsigned long find_next_and_bit(const unsigned long *addr1,
>   * Returns the bit number of the next zero bit
>   * If no bits are zero, returns @size.
>   */
> -extern unsigned long find_next_zero_bit(const unsigned long *addr, unsigned
> -               long size, unsigned long offset);
> +static inline
> +unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
> +                                unsigned long offset)
> +{
> +       return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
> +}
>  #endif
>
>  #ifdef CONFIG_GENERIC_FIND_FIRST_BIT
> diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
> index 188d3eba3ace..21305f6cea0b 100644
> --- a/include/asm-generic/bitops/le.h
> +++ b/include/asm-generic/bitops/le.h
> @@ -2,6 +2,7 @@
>  #ifndef _ASM_GENERIC_BITOPS_LE_H_
>  #define _ASM_GENERIC_BITOPS_LE_H_
>
> +#include <asm-generic/bitops/find.h>
>  #include <asm/types.h>
>  #include <asm/byteorder.h>
>
> @@ -32,13 +33,21 @@ static inline unsigned long find_first_zero_bit_le(const void *addr,
>  #define BITOP_LE_SWIZZLE       ((BITS_PER_LONG-1) & ~0x7)
>
>  #ifndef find_next_zero_bit_le
> -extern unsigned long find_next_zero_bit_le(const void *addr,
> -               unsigned long size, unsigned long offset);
> +static inline
> +unsigned long find_next_zero_bit_le(const void *addr, unsigned
> +               long size, unsigned long offset)
> +{
> +       return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
> +}
>  #endif
>
>  #ifndef find_next_bit_le
> -extern unsigned long find_next_bit_le(const void *addr,
> -               unsigned long size, unsigned long offset);
> +static inline
> +unsigned long find_next_bit_le(const void *addr, unsigned
> +               long size, unsigned long offset)
> +{
> +       return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
> +}
>  #endif
>
>  #ifndef find_first_zero_bit_le
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index f67f86fd2f62..b03a101367f8 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -29,7 +29,7 @@
>   *    searching it for one bits.
>   *  - The optional "addr2", which is anded with "addr1" if present.
>   */
> -static unsigned long _find_next_bit(const unsigned long *addr1,
> +unsigned long _find_next_bit(const unsigned long *addr1,
>                 const unsigned long *addr2, unsigned long nbits,
>                 unsigned long start, unsigned long invert, unsigned long le)
>  {
> @@ -68,37 +68,7 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
>
>         return min(start + __ffs(tmp), nbits);
>  }
> -#endif
> -
> -#ifndef find_next_bit
> -/*
> - * Find the next set bit in a memory region.
> - */
> -unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
> -                           unsigned long offset)
> -{
> -       return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
> -}
> -EXPORT_SYMBOL(find_next_bit);
> -#endif
> -
> -#ifndef find_next_zero_bit
> -unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
> -                                unsigned long offset)
> -{
> -       return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
> -}
> -EXPORT_SYMBOL(find_next_zero_bit);
> -#endif
> -
> -#if !defined(find_next_and_bit)
> -unsigned long find_next_and_bit(const unsigned long *addr1,
> -               const unsigned long *addr2, unsigned long size,
> -               unsigned long offset)
> -{
> -       return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
> -}
> -EXPORT_SYMBOL(find_next_and_bit);
> +EXPORT_SYMBOL(_find_next_bit);
>  #endif
>
>  #ifndef find_first_bit
> @@ -157,28 +127,6 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
>  EXPORT_SYMBOL(find_last_bit);
>  #endif
>
> -#ifdef __BIG_ENDIAN
> -
> -#ifndef find_next_zero_bit_le
> -unsigned long find_next_zero_bit_le(const void *addr, unsigned
> -               long size, unsigned long offset)
> -{
> -       return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
> -}
> -EXPORT_SYMBOL(find_next_zero_bit_le);
> -#endif
> -
> -#ifndef find_next_bit_le
> -unsigned long find_next_bit_le(const void *addr, unsigned
> -               long size, unsigned long offset)
> -{
> -       return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
> -}
> -EXPORT_SYMBOL(find_next_bit_le);
> -#endif
> -
> -#endif /* __BIG_ENDIAN */
> -
>  unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
>                                unsigned long size, unsigned long offset)
>  {
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
