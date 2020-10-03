Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FD1282294
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgJCIog (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 04:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgJCIof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 04:44:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF586C0613D0;
        Sat,  3 Oct 2020 01:44:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t7so2604482pjd.3;
        Sat, 03 Oct 2020 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uekdk4bnoQ9uyr+i+y+H1e6zvQYULlhUFCRw8k+89s0=;
        b=EFko9OGm1ESErx2DkIq7237qWLTzufJCnZoiyblZobkujhS0bSX3aTzIraGcXV+/K6
         D+++DPpXm86cR901ecqdrQP8CoRMI70hKw2shuiQpQP8yKTBoVEygkhczCfJ5wX9yuqX
         aR/+uklLZaz1e/Tko+4OwVIfprGSdJYuU6aW1JDd8G/Y/ZpsXjGKINjYo8ZjfWdpEDW/
         pb4hEKSEPx+5wTvqo90xEsJtYzttN4mBRZMzruIjQaZ3Hedj6ZepU/b/wGVi5HOcO1Rc
         1fBvMyR4LX54ylC8+RE2wwzEtGR6jL09FF/ABq66BjK71Q3lh5JIM905RbIPCbgz+RBx
         mr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uekdk4bnoQ9uyr+i+y+H1e6zvQYULlhUFCRw8k+89s0=;
        b=Jg6jNuHO9ALw92La/IO9oDXS5v6dvdAmuwJuOQQIeyFJKzGPo1nT/3ajzp3gnNE+YM
         KP2xALpXX8OLzHF9hcFAtQ7uPCcYZteOhQytnBTd8oMN+Im4Twy4o2HjsOOHB/74ZCgT
         T6fliGOd3XvQVXOE64hk/1mDLgbEDRmY3PcmjfojbvBRRmO7brLm67m5zTaYXBRK3LQM
         Ehj16Siwxge0q2RnFCH++YmV7RdNe+UyF+x1X6L/adPVOGmem7zE2bdnTs5kiskrpjvj
         pn8J6SwLDa6/q8PjRt76Fm/SiEfb1V09LYcxrGPDRnIjnrqx+VtsM8X7nV1raRz4lNdI
         9Yrw==
X-Gm-Message-State: AOAM532+HJrZGq36exyrG780P8ZbyjkVaP8KYI8HsR9cSdYAMVvZBT7J
        dD9l+VpMELHkySiLe2XS+srRUZXUaCjuMuH71SM=
X-Google-Smtp-Source: ABdhPJymbR28KMqeLWMKrcdyKI/s7LkoVTGxy6pdlfeuUFJybjboWHcOrtnVavqXlNPJo/3e8yz9IOqFatYaD29RQzU=
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr6487749pjs.181.1601714674066;
 Sat, 03 Oct 2020 01:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601679791.git.syednwaris@gmail.com> <dcd0580812ebae079e6f5035b990b195ccc6b709.1601679791.git.syednwaris@gmail.com>
In-Reply-To: <dcd0580812ebae079e6f5035b990b195ccc6b709.1601679791.git.syednwaris@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 3 Oct 2020 11:44:17 +0300
Message-ID: <CAHp75VcoGAjrPa7rcORsaDXZLb-n+U3hG0k6O+weMVYweSPVxg@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] bitops: Introduce the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 3, 2020 at 2:51 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

Now I remember...
This needs to be revisited.

> This macro iterates for each group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to
> the bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value and bitmap_set_value functions are introduced to

Mark functions like func() in the text as well.

> respectively get and set a value of n-bits in a bitmap memory region.
> The n-bits can have any size less than or equal to BITS_PER_LONG.
> Moreover, during setting value of n-bit in bitmap, if a situation arise
> that the width of next n-bit is exceeding the word boundary, then it
> will divide itself such that some portion of it is stored in that word,
> while the remaining portion is stored in the next higher word. Similar
> situation occurs while retrieving value of n-bits from bitmap.

retrieving the value
from a bitmap

...

> +/**
> + * bitmap_get_value - get a value of n-bits from the memory region
> + * @map: address to the bitmap memory region
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits
> + *
> + * Returns value of nbits located at the @start bit offset within the @map
> + * memory region.
> + */
> +static inline unsigned long bitmap_get_value(const unsigned long *map,
> +                                             unsigned long start,
> +                                             unsigned long nbits)
> +{
> +       const size_t index = BIT_WORD(start);
> +       const unsigned long offset = start % BITS_PER_LONG;
> +       const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> +       const unsigned long space = ceiling - start;
> +       unsigned long value_low, value_high;
> +
> +       if (space >= nbits)
> +               return (map[index] >> offset) & GENMASK(nbits - 1, 0);

This is UB in GENMASK() when nbits == 0.

> +       else {
> +               value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> +               value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> +               return (value_low >> offset) | (value_high << space);
> +       }
> +}

...

> +/**
> + * bitmap_set_value - set n-bit value within a memory region
> + * @map: address to the bitmap memory region
> + * @value: value of nbits
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits
> + */
> +static inline void bitmap_set_value(unsigned long *map,
> +                                   unsigned long value,
> +                                   unsigned long start, unsigned long nbits)
> +{
> +       const size_t index = BIT_WORD(start);
> +       const unsigned long offset = start % BITS_PER_LONG;
> +       const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> +       const unsigned long space = ceiling - start;

> +       value &= GENMASK(nbits - 1, 0);

This is UB when nbits == 0.

> +       if (space >= nbits) {
> +               map[index] &= ~(GENMASK(nbits + offset - 1, offset));

UB when nbits == 0 and start == 0.

> +               map[index] |= value << offset;
> +       } else {
> +               map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> +               map[index] |= value << offset;
> +               map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> +               map[index + 1] |= (value >> space);

And another LKP finding was among these lines, but I don't remember the details.

> +       }
> +}
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* __LINUX_BITMAP_H */
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 99f2ac30b1d9..36a445e4a7cc 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -62,6 +62,19 @@ extern unsigned long __sw_hweight64(__u64 w);
>              (start) < (size); \
>              (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
>
> +/**
> + * for_each_set_clump - iterate over bitmap for each clump with set bits
> + * @start: bit offset to start search and to store the current iteration offset
> + * @clump: location to store copy of current 8-bit clump
> + * @bits: bitmap address to base the search on
> + * @size: bitmap size in number of bits
> + * @clump_size: clump size in bits
> + */
> +#define for_each_set_clump(start, clump, bits, size, clump_size) \
> +       for ((start) = find_first_clump(&(clump), (bits), (size), (clump_size)); \
> +            (start) < (size); \
> +            (start) = find_next_clump(&(clump), (bits), (size), (start) + (clump_size), (clump_size)))
> +
>  static inline int get_bitmask_order(unsigned int count)
>  {
>         int order;
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 49f875f1baf7..1341bd39b32a 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -190,3 +190,17 @@ unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
>         return offset;
>  }
>  EXPORT_SYMBOL(find_next_clump8);
> +
> +unsigned long find_next_clump(unsigned long *clump, const unsigned long *addr,
> +                              unsigned long size, unsigned long offset,
> +                              unsigned long clump_size)
> +{
> +       offset = find_next_bit(addr, size, offset);
> +       if (offset == size)
> +               return size;
> +
> +       offset = rounddown(offset, clump_size);
> +       *clump = bitmap_get_value(addr, offset, clump_size);
> +       return offset;
> +}
> +EXPORT_SYMBOL(find_next_clump);
> --
> 2.26.2
>


-- 
With Best Regards,
Andy Shevchenko
