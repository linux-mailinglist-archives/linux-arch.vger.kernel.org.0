Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAE2351158
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhDAI6e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 04:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhDAI62 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 04:58:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6B8C0613E6;
        Thu,  1 Apr 2021 01:58:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h20so694614plr.4;
        Thu, 01 Apr 2021 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNcEUdL+Y2EFFIxydzK2lkO73+Grx7yUTd4+U1ZR2Co=;
        b=iepTEBY9UHxW4HJcHM3NpviYdGyMD0zHQy1yz3FTDDFpVHSlie5TVN2fqTwFoVmwXY
         s8hnEeMYsY1/vIIMf8gNvNHpKpz7nP+DdMLiZ10i8zV9QugSWJm3zBcReBIX/FcrEse3
         wbVcqdJ95Fvl8ggf+nJgOpptWWaHk3Feyyp1t9En7lgS7mHxEGZ8sNL0xKHeJROmUL++
         vA2FUfHy9qcFo4CCRB46y61NYmj/nBmEDcTW6TrBPzgAUxVH9dy9fyLJmWlCfPm4nqef
         PTh78fLB4zKNg2+LHreObaXnzKnloJdCbKa1laozju8t7ue+iv7zwJWwJFel1O+WnyEH
         kt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNcEUdL+Y2EFFIxydzK2lkO73+Grx7yUTd4+U1ZR2Co=;
        b=bfvnfEoP2EcfjgqsFhm7pu5ghKx5X+62bYM8gEJkO2rnw95dqtFrJYxo/M35GPHVXs
         ajGemffbunBShHvMrKKzLjGjIKxCpMLz9UEtZR5d05bqKisnsuL9EzapDY/Z9rmFB6JX
         GRpocU7bnd6bxD42VdRkrQyDft6EpC4XPTQD0bcuLMYKsnnrTiy/Bs40hjSotl7QiQAt
         +KrIoImmOJfjyW+wkUW2goSKHy9EstnU2sh5oHUamifSEIgUJix2Won/VXHboeCpPmGj
         SfxnaYWAm/WmtM0KH2LAWZSv39wqejAKVqkIG5cEbJzTHDJUgHUsR84VbhLHOdgcXP8u
         Pcxg==
X-Gm-Message-State: AOAM533wsPRkBE6B/77LGzvg+wFOnTDbishUn5wHlHZUP+sMjeVygZWM
        hFZoWgO29Q3KsSDb7s1oj0yXLKfmiSQcwPIZkPw=
X-Google-Smtp-Source: ABdhPJzEzb75COZ6+ksiycIV+rVeckcELZI+Vey5LZL67pRGO8TjUwA3qD9uZ3Ar7unIpfcrYoM4GH6Fkky8CnYszPc=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr8124742pjx.181.1617267506376;
 Thu, 01 Apr 2021 01:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210401003153.97325-1-yury.norov@gmail.com> <20210401003153.97325-11-yury.norov@gmail.com>
In-Reply-To: <20210401003153.97325-11-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Apr 2021 11:58:10 +0300
Message-ID: <CAHp75VeCqgZjq001DHkiDqWLAde-OKT8Ff+n8j01jJDyCCgX=g@mail.gmail.com>
Subject: Re: [PATCH 10/12] lib: add fast path for find_first_*_bit() and find_last_bit()
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
> Similarly to bitmap functions, users would benefit if we'll handle
> a case of small-size bitmaps that fit into a single word.
>
> While here, move the find_last_bit() declaration to bitops/find.h
> where other find_*_bit() functions sit.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/asm-generic/bitops/find.h | 50 ++++++++++++++++++++++++++++---
>  include/linux/bitops.h            | 12 --------
>  lib/find_bit.c                    | 12 ++++----
>  3 files changed, 52 insertions(+), 22 deletions(-)
>
> diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> index 4148c74a1e4d..0d132ee2a291 100644
> --- a/include/asm-generic/bitops/find.h
> +++ b/include/asm-generic/bitops/find.h
> @@ -5,6 +5,9 @@
>  extern unsigned long _find_next_bit(const unsigned long *addr1,
>                 const unsigned long *addr2, unsigned long nbits,
>                 unsigned long start, unsigned long invert, unsigned long le);
> +extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
> +extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
> +extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
>
>  #ifndef find_next_bit
>  /**
> @@ -102,8 +105,17 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>   * Returns the bit number of the first set bit.
>   * If no bits are set, returns @size.
>   */
> -extern unsigned long find_first_bit(const unsigned long *addr,
> -                                   unsigned long size);
> +static inline
> +unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
> +{
> +       if (small_const_nbits(size)) {
> +               unsigned long val = *addr & GENMASK(size - 1, 0);
> +
> +               return val ? __ffs(val) : size;
> +       }
> +
> +       return _find_first_bit(addr, size);
> +}
>
>  /**
>   * find_first_zero_bit - find the first cleared bit in a memory region
> @@ -113,8 +125,17 @@ extern unsigned long find_first_bit(const unsigned long *addr,
>   * Returns the bit number of the first cleared bit.
>   * If no bits are zero, returns @size.
>   */
> -extern unsigned long find_first_zero_bit(const unsigned long *addr,
> -                                        unsigned long size);
> +static inline
> +unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
> +{
> +       if (small_const_nbits(size)) {
> +               unsigned long val = *addr | ~GENMASK(size - 1, 0);
> +
> +               return val == ~0UL ? size : ffz(val);
> +       }
> +
> +       return _find_first_zero_bit(addr, size);
> +}
>  #else /* CONFIG_GENERIC_FIND_FIRST_BIT */
>
>  #ifndef find_first_bit
> @@ -126,6 +147,27 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
>
>  #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
>
> +#ifndef find_last_bit
> +/**
> + * find_last_bit - find the last set bit in a memory region
> + * @addr: The address to start the search at
> + * @size: The number of bits to search
> + *
> + * Returns the bit number of the last set bit, or size.
> + */
> +static inline
> +unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
> +{
> +       if (small_const_nbits(size)) {
> +               unsigned long val = *addr & GENMASK(size - 1, 0);
> +
> +               return val ? __fls(val) : size;
> +       }
> +
> +       return _find_last_bit(addr, size);
> +}
> +#endif
> +
>  /**
>   * find_next_clump8 - find next 8-bit clump with set bits in a memory region
>   * @clump: location to store copy of found clump
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index a5a48303b0f1..26bf15e6cd35 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -286,17 +286,5 @@ static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
>  })
>  #endif
>
> -#ifndef find_last_bit
> -/**
> - * find_last_bit - find the last set bit in a memory region
> - * @addr: The address to start the search at
> - * @size: The number of bits to search
> - *
> - * Returns the bit number of the last set bit, or size.
> - */
> -extern unsigned long find_last_bit(const unsigned long *addr,
> -                                  unsigned long size);
> -#endif
> -
>  #endif /* __KERNEL__ */
>  #endif
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index b03a101367f8..0f8e2e369b1d 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -75,7 +75,7 @@ EXPORT_SYMBOL(_find_next_bit);
>  /*
>   * Find the first set bit in a memory region.
>   */
> -unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
> +unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
>  {
>         unsigned long idx;
>
> @@ -86,14 +86,14 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
>
>         return size;
>  }
> -EXPORT_SYMBOL(find_first_bit);
> +EXPORT_SYMBOL(_find_first_bit);
>  #endif
>
>  #ifndef find_first_zero_bit
>  /*
>   * Find the first cleared bit in a memory region.
>   */
> -unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
> +unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
>  {
>         unsigned long idx;
>
> @@ -104,11 +104,11 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
>
>         return size;
>  }
> -EXPORT_SYMBOL(find_first_zero_bit);
> +EXPORT_SYMBOL(_find_first_zero_bit);
>  #endif
>
>  #ifndef find_last_bit
> -unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
> +unsigned long _find_last_bit(const unsigned long *addr, unsigned long size)
>  {
>         if (size) {
>                 unsigned long val = BITMAP_LAST_WORD_MASK(size);
> @@ -124,7 +124,7 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
>         }
>         return size;
>  }
> -EXPORT_SYMBOL(find_last_bit);
> +EXPORT_SYMBOL(_find_last_bit);
>  #endif
>
>  unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
