Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F79AD13FE
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 18:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfJIQ2x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 12:28:53 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:53370 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfJIQ2x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 12:28:53 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x99GSjFp013815;
        Thu, 10 Oct 2019 01:28:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x99GSjFp013815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570638527;
        bh=zM7dxD3GmLuJA27n7tj6vmU9wclV7umhFu5rYXOd+6c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SQPud2h0OWu0HF3XYWYxty13tni/EzU9iRFSRy6Ulcx1nol+bNQtyk6jfN+yVAkj9
         h+1IgrHE8gA9JeygREhqo4gg9/wYVIGeKZhCmqsSUE6VXOrLL+ACe9eQZsn4NawO2s
         AlEmlOyZcmN613ziPcn6hFKqxpPkhCRc6qGmrQYUaN/7OF+NQB9oJIHQnk0EW9ucMD
         Az87WvdwWY3kelGhzYJoMQobsQcGwf1gRZkrRUmeb6p+B7GF/l92EYD0vsO7aPfvCC
         5WvOZTmb6JWM+lY+xsEmT7fmfk1tXwa/EMz5qmVGOJZMNHXRwJd28CPdhWITzNvYTB
         jKj3Q/x9Dcqlw==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id m22so1910937vsl.9;
        Wed, 09 Oct 2019 09:28:46 -0700 (PDT)
X-Gm-Message-State: APjAAAV9TeKYg9gLswCJwGEiVSqpbtKjisMiA2+QcRscDA7Wd1+OiVTF
        cLef8Vw7m7fhqQgzglAeGVjFnzeKVDTafYuOWIE=
X-Google-Smtp-Source: APXvYqzH0lno0Jfiz/rFQhtYHfui45CzQbPKiMY0yhhlnjAVEgFdHdM9+zJ7EOc9vXnfVbLZJAT9ZLaAw0J1HbDFjmA=
X-Received: by 2002:a67:2e81:: with SMTP id u123mr1224042vsu.155.1570638525039;
 Wed, 09 Oct 2019 09:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570633189.git.vilhelm.gray@gmail.com> <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570633189.git.vilhelm.gray@gmail.com>
In-Reply-To: <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570633189.git.vilhelm.gray@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 10 Oct 2019 01:28:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATgW7bXUmqV=3QAaJ0Qu73Kox-TgDCQJb=s0=mwewSCUg@mail.gmail.com>
Message-ID: <CAK7LNATgW7bXUmqV=3QAaJ0Qu73Kox-TgDCQJb=s0=mwewSCUg@mail.gmail.com>
Subject: Re: [PATCH v17 01/14] bitops: Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        preid@electromag.com.au, Lukas Wunner <lukas@wunner.de>,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  include/asm-generic/bitops/find.h | 17 +++++++++++++++
>  include/linux/bitmap.h            | 35 +++++++++++++++++++++++++++++++
>  include/linux/bitops.h            |  5 +++++
>  lib/find_bit.c                    | 14 +++++++++++++
>  4 files changed, 71 insertions(+)
>
> diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> index 8a1ee10014de..9fdf21302fdf 100644
> --- a/include/asm-generic/bitops/find.h
> +++ b/include/asm-generic/bitops/find.h
> @@ -80,4 +80,21 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
>
>  #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
>
> +/**
> + * find_next_clump8 - find next 8-bit clump with set bits in a memory region
> + * @clump: location to store copy of found clump
> + * @addr: address to base the search on
> + * @size: bitmap size in number of bits
> + * @offset: bit offset at which to start searching
> + *
> + * Returns the bit offset for the next set clump; the found clump value is
> + * copied to the location pointed by @clump. If no bits are set, returns @size.
> + */
> +extern unsigned long find_next_clump8(unsigned long *clump,
> +                                     const unsigned long *addr,
> +                                     unsigned long size, unsigned long offset);
> +
> +#define find_first_clump8(clump, bits, size) \
> +       find_next_clump8((clump), (bits), (size), 0)
> +
>  #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 90528f12bdfa..761fab5b60a7 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -66,6 +66,8 @@
>   *  bitmap_allocate_region(bitmap, pos, order)  Allocate specified bit region
>   *  bitmap_from_arr32(dst, buf, nbits)          Copy nbits from u32[] buf to dst
>   *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
> + *  bitmap_get_value8(map, start)               Get 8bit value from map at start
> + *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
>   *
>   * Note, bitmap_zero() and bitmap_fill() operate over the region of
>   * unsigned longs, that is, bits behind bitmap till the unsigned long
> @@ -488,6 +490,39 @@ static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
>                 dst[1] = mask >> 32;
>  }
>
> +/**
> + * bitmap_get_value8 - get an 8-bit value within a memory region
> + * @map: address to the bitmap memory region
> + * @start: bit offset of the 8-bit value; must be a multiple of 8
> + *
> + * Returns the 8-bit value located at the @start bit offset within the @src
> + * memory region.
> + */
> +static inline unsigned long bitmap_get_value8(const unsigned long *map,
> +                                             unsigned long start)

Why is the return type "unsigned long" where you know
it return the 8-bit value ?

u8?



> +{
> +       const size_t index = BIT_WORD(start);
> +       const unsigned long offset = start % BITS_PER_LONG;
> +
> +       return (map[index] >> offset) & 0xFF;
> +}
> +
> +/**
> + * bitmap_set_value8 - set an 8-bit value within a memory region
> + * @map: address to the bitmap memory region
> + * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
> + * @start: bit offset of the 8-bit value; must be a multiple of 8
> + */
> +static inline void bitmap_set_value8(unsigned long *map, unsigned long value,


Same here,   "u8 value"



> +                                    unsigned long start)
> +{
> +       const size_t index = BIT_WORD(start);
> +       const unsigned long offset = start % BITS_PER_LONG;
> +
> +       map[index] &= ~(0xFF << offset);
> +       map[index] |= value << offset;
> +}
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* __LINUX_BITMAP_H */
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index cf074bce3eb3..fb94a10f7853 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -40,6 +40,11 @@ extern unsigned long __sw_hweight64(__u64 w);
>              (bit) < (size);                                    \
>              (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
>
> +#define for_each_set_clump8(start, clump, bits, size) \
> +       for ((start) = find_first_clump8(&(clump), (bits), (size)); \
> +            (start) < (size); \
> +            (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
> +
>  static inline int get_bitmask_order(unsigned int count)
>  {
>         int order;
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 5c51eb45178a..e35a76b291e6 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -214,3 +214,17 @@ EXPORT_SYMBOL(find_next_bit_le);
>  #endif
>
>  #endif /* __BIG_ENDIAN */
> +
> +unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,


Ditto.   "u8 *clump"




> +                              unsigned long size, unsigned long offset)
> +{
> +       offset = find_next_bit(addr, size, offset);
> +       if (offset == size)
> +               return size;
> +
> +       offset = round_down(offset, 8);
> +       *clump = bitmap_get_value8(addr, offset);
> +
> +       return offset;
> +}
> +EXPORT_SYMBOL(find_next_clump8);
> --
> 2.23.0
>


--
Best Regards

Masahiro Yamada
