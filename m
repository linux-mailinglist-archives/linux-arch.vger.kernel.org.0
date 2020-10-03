Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC5D2823D8
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 13:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgJCLhM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 07:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgJCLhL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 07:37:11 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EE3C0613D0;
        Sat,  3 Oct 2020 04:37:11 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id u9so3602412ilj.7;
        Sat, 03 Oct 2020 04:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDIrc79AJ4xWJONqBKbp/xE/awnhYPlRc+BDwTgV1oc=;
        b=e+jmq+N9nTxpC676tT3yU47npM2EQpxGRsrOznkYzg2DEH3VP4cVzqZodFh7cOkU/x
         bvqO48pK9zqGDKE4wuoOaQjksMdEfNLrdYqn3Q81ET02jnHwWOkzisTAs521a/b9IvHd
         CGB5S19ZYwxxFQGInMwsO++CkFAmwsyxWpNtkhZ/K8ZPEvZTGYqiQljbddN1KOdPU0Tg
         xOkSmtiSuevnMq/y4oC1LvkwQNDT1ZxRtjpiHe7xMMjM1gkNvk44YDEatzmAQaGF9mb4
         AhF7ZLaW+qarr7xApcvNG/qjXDR/Q6sHn2Oj8zf64l6lYvRp8H5cSvQXALLYLcKyrLDv
         GEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDIrc79AJ4xWJONqBKbp/xE/awnhYPlRc+BDwTgV1oc=;
        b=Sa5u3iQVRB2mfSHvfEZAqF+X36gyLG8KaMEtJZjzBX6/uZlisfmSOFHDtJZnsRF4Vr
         WCJW6T4RVJ0ZBqAaIjYiKq6Rah/A24sbL1WHejXBHT41bJO0gFemjFnt7z6l4+07QxH8
         PMGlgabWCP2i0JNypgaLtLruwdz9Yv3tyQTddsDawoSwLXH5EhAucW6Icaka1a7Jy0q/
         MlRHvxnb9W+o+ckFOOyPQ5OJsr6kJx5Sq2ynF6Zu56QqE/p73aBKhQU1BW/5GVOrioHM
         1BbS+dxurjJv2Ct/L0oYWNcA5MkHlLxuwSc1SM+6/xNQKqe9IzlKLrNA+9avr3lnN0Yf
         lfeA==
X-Gm-Message-State: AOAM5302UFVuUDRIMrJk8J4G/0i1QC0GN+DuXX6rQFlKM7HB/qhu6pQR
        HHNYYZLDCyzCPhIx36Yrrrl9KMvwDpbTCUfWFz4=
X-Google-Smtp-Source: ABdhPJxteT0FDEK1JgVnbvql8r8XJH2XORfm6IG1wLS5lo1xiAB76tledd9yo1CIoFnJTjVGOXRD4XuZktlUubQJqIU=
X-Received: by 2002:a05:6e02:547:: with SMTP id i7mr1325513ils.0.1601725030542;
 Sat, 03 Oct 2020 04:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601679791.git.syednwaris@gmail.com> <dcd0580812ebae079e6f5035b990b195ccc6b709.1601679791.git.syednwaris@gmail.com>
 <CAHp75VcoGAjrPa7rcORsaDXZLb-n+U3hG0k6O+weMVYweSPVxg@mail.gmail.com>
In-Reply-To: <CAHp75VcoGAjrPa7rcORsaDXZLb-n+U3hG0k6O+weMVYweSPVxg@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sat, 3 Oct 2020 17:06:59 +0530
Message-ID: <CACG_h5pianK4DRL5YeuSuN0gv6Jvcndc=_wLCL4QgmZyR=bOMw@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] bitops: Introduce the for_each_set_clump macro
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Sat, Oct 3, 2020 at 2:14 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Oct 3, 2020 at 2:51 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> Now I remember...
> This needs to be revisited.
>
> > This macro iterates for each group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to
> > the bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value and bitmap_set_value functions are introduced to
>
> Mark functions like func() in the text as well.
Okay

>
> > respectively get and set a value of n-bits in a bitmap memory region.
> > The n-bits can have any size less than or equal to BITS_PER_LONG.
> > Moreover, during setting value of n-bit in bitmap, if a situation arise
> > that the width of next n-bit is exceeding the word boundary, then it
> > will divide itself such that some portion of it is stored in that word,
> > while the remaining portion is stored in the next higher word. Similar
> > situation occurs while retrieving value of n-bits from bitmap.
>
> retrieving the value
> from a bitmap
Okay

>
> ...
>
> > +/**
> > + * bitmap_get_value - get a value of n-bits from the memory region
> > + * @map: address to the bitmap memory region
> > + * @start: bit offset of the n-bit value
> > + * @nbits: size of value in bits
> > + *
> > + * Returns value of nbits located at the @start bit offset within the @map
> > + * memory region.
> > + */
> > +static inline unsigned long bitmap_get_value(const unsigned long *map,
> > +                                             unsigned long start,
> > +                                             unsigned long nbits)
> > +{
> > +       const size_t index = BIT_WORD(start);
> > +       const unsigned long offset = start % BITS_PER_LONG;
> > +       const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> > +       const unsigned long space = ceiling - start;
> > +       unsigned long value_low, value_high;
> > +
> > +       if (space >= nbits)
> > +               return (map[index] >> offset) & GENMASK(nbits - 1, 0);
>
> This is UB in GENMASK() when nbits == 0.

'nbits' actually specifies the width of clump value. Basically 'nbits'
denotes how-many-bits wide the clump value is.
'nbits' having a value of '0' means zero-width-sized clump, meaning
nothing. 'nbits' can take valid values from '1' to BITS_PER_LONG.
The minimum value the 'nbits' can have is 1 because the smallest sized
clump can be 1-bit-wide. It can't be smaller than that.

Let me know if I have misunderstood something?

>
> > +       else {
> > +               value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> > +               value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> > +               return (value_low >> offset) | (value_high << space);
> > +       }
> > +}
>
> ...
>
> > +/**
> > + * bitmap_set_value - set n-bit value within a memory region
> > + * @map: address to the bitmap memory region
> > + * @value: value of nbits
> > + * @start: bit offset of the n-bit value
> > + * @nbits: size of value in bits
> > + */
> > +static inline void bitmap_set_value(unsigned long *map,
> > +                                   unsigned long value,
> > +                                   unsigned long start, unsigned long nbits)
> > +{
> > +       const size_t index = BIT_WORD(start);
> > +       const unsigned long offset = start % BITS_PER_LONG;
> > +       const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> > +       const unsigned long space = ceiling - start;
>
> > +       value &= GENMASK(nbits - 1, 0);
>
> This is UB when nbits == 0.

Same as above.
'nbits' actually specifies the width of clump value. Basically 'nbits'
denotes how-many-bits wide the clump value is.
'nbits' having a value of '0' means zero-width-sized clump, meaning
nothing. 'nbits' can take valid values from '1' to BITS_PER_LONG.
The minimum value the 'nbits' can have is 1 because the smallest sized
clump can be 1-bit-wide. It can't be smaller than that.

>
> > +       if (space >= nbits) {
> > +               map[index] &= ~(GENMASK(nbits + offset - 1, offset));
>
> UB when nbits == 0 and start == 0.
>
> > +               map[index] |= value << offset;
> > +       } else {
> > +               map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> > +               map[index] |= value << offset;
> > +               map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> > +               map[index + 1] |= (value >> space);
>
> And another LKP finding was among these lines, but I don't remember the details.

Yes you are right. There was sparse warning reported for this.
sparse: shift too big (64) for type unsigned long
The warning was reported in patch [4/4] referring to this patch [1/4].

Later it was clarified by the sparse-check maintainer that this
warning is to be ignored and no code fix is required.

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2202377.html

>
> > +       }
> > +}
> > +
> >  #endif /* __ASSEMBLY__ */
> >
> >  #endif /* __LINUX_BITMAP_H */
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index 99f2ac30b1d9..36a445e4a7cc 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -62,6 +62,19 @@ extern unsigned long __sw_hweight64(__u64 w);
> >              (start) < (size); \
> >              (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
> >
> > +/**
> > + * for_each_set_clump - iterate over bitmap for each clump with set bits
> > + * @start: bit offset to start search and to store the current iteration offset
> > + * @clump: location to store copy of current 8-bit clump
> > + * @bits: bitmap address to base the search on
> > + * @size: bitmap size in number of bits
> > + * @clump_size: clump size in bits
> > + */
> > +#define for_each_set_clump(start, clump, bits, size, clump_size) \
> > +       for ((start) = find_first_clump(&(clump), (bits), (size), (clump_size)); \
> > +            (start) < (size); \
> > +            (start) = find_next_clump(&(clump), (bits), (size), (start) + (clump_size), (clump_size)))
> > +
> >  static inline int get_bitmask_order(unsigned int count)
> >  {
> >         int order;
> > diff --git a/lib/find_bit.c b/lib/find_bit.c
> > index 49f875f1baf7..1341bd39b32a 100644
> > --- a/lib/find_bit.c
> > +++ b/lib/find_bit.c
> > @@ -190,3 +190,17 @@ unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
> >         return offset;
> >  }
> >  EXPORT_SYMBOL(find_next_clump8);
> > +
> > +unsigned long find_next_clump(unsigned long *clump, const unsigned long *addr,
> > +                              unsigned long size, unsigned long offset,
> > +                              unsigned long clump_size)
> > +{
> > +       offset = find_next_bit(addr, size, offset);
> > +       if (offset == size)
> > +               return size;
> > +
> > +       offset = rounddown(offset, clump_size);
> > +       *clump = bitmap_get_value(addr, offset, clump_size);
> > +       return offset;
> > +}
> > +EXPORT_SYMBOL(find_next_clump);
> > --
> > 2.26.2
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
