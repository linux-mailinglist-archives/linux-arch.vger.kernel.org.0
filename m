Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D956A202769
	for <lists+linux-arch@lfdr.de>; Sun, 21 Jun 2020 01:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgFTXli (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Jun 2020 19:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgFTXli (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Jun 2020 19:41:38 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B2DC061794;
        Sat, 20 Jun 2020 16:41:38 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so15622488iow.7;
        Sat, 20 Jun 2020 16:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmpFquU+RDwglEiu3g5XtI6L0MxQfiK9BIIU4+njr4c=;
        b=p42qoBX0x+QUwBEMwTlvIJFwxVb/vk6enFnuiqGy03GJN0Hqzv4C8aSDtnKrjjrMxI
         zd3oiTy1wEfluO1kZ28JEdhsf+1h46J+/917uK2jBVQ7vCewZk1QHFM8aBW+so8ROTKJ
         PvGBz+0Ed9b02BquP/17ZEnjb6ePpNByePVilFbkloA6WtOG3eiJnKxfW9QPSZf7oTsJ
         tKCbDAzm7+57WDaBdmkW9ohSTy4OHCbTmIvkEcmz59OWS98q+lnvqrNIV7k32KIF1azs
         4RkLkhLeOYCv8HOWa28LsDK/1md+bZcz+tyAKUzeI4GsEmOIRm5q7AaajoqlzMyK1Bm6
         lD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmpFquU+RDwglEiu3g5XtI6L0MxQfiK9BIIU4+njr4c=;
        b=i5MTwiDtkVQlmu9hosDko/5u40W8ZE0j/gaUzXtM/TpvPnrYW8W9YjusiEFLia3dhQ
         Wx8UwQik/2URNcqwtE9idIfAfKCCde78c7w6Ji1K1BcdGG+4ccsUqzHFhQaX6P7mymn5
         soOqNzYuaTIln+bcAe+Upmd4Ww11AaNwPNvXitOvFPanvuaioMeGM6lc673K6ZGTteG1
         Kga+CiKX/0PXQuQ1TK/LYt+Yw+om5huHnDr8bjHNzrFvu9/b+ofqEQAK6Hgbi8OrIxBw
         6Op9RiUoa+dqhWyoDSgtlMWzCxdSBNO65uXac/5LfBn4au0W5wSewmiolwenFs96GZc1
         1b2w==
X-Gm-Message-State: AOAM532alFS/G3BY8PV6wOrELDz4lYUm2Pm2wZonku2Kbg7PQ45pzsi5
        iVpJmSiA68Q/nWVIsi9OBF51u/ZPyWcz8Xle4dc=
X-Google-Smtp-Source: ABdhPJw1IKuvOhcqf7f1u5K8GleW+PAeAyMI1zht7qE+jj4nFzqK8yEt5hmb/7ucU8pHAL3X8xS9smg8nIMPszuldqI=
X-Received: by 2002:a05:6602:1204:: with SMTP id y4mr12192258iot.44.1592696497456;
 Sat, 20 Jun 2020 16:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592224128.git.syednwaris@gmail.com> <fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com>
 <20200616081428.GP2428291@smile.fi.intel.com>
In-Reply-To: <20200616081428.GP2428291@smile.fi.intel.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sun, 21 Jun 2020 05:11:25 +0530
Message-ID: <CACG_h5qK3KN5xYK=6h+U8u2kLo95979uC4_xfHhD8GqYeVgMLw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] bitops: Introduce the for_each_set_clump macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 16, 2020 at 1:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jun 15, 2020 at 06:21:18PM +0530, Syed Nayyar Waris wrote:
> > This macro iterates for each group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to
> > the bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value and bitmap_set_value functions are introduced to
> > respectively get and set a value of n-bits in a bitmap memory region.
> > The n-bits can have any size less than or equal to BITS_PER_LONG.
> > Moreover, during setting value of n-bit in bitmap, if a situation arise
> > that the width of next n-bit is exceeding the word boundary, then it
> > will divide itself such that some portion of it is stored in that word,
> > while the remaining portion is stored in the next higher word. Similar
> > situation occurs while retrieving value of n-bits from bitmap.
>
> On the second view...
>
> > +static inline unsigned long bitmap_get_value(const unsigned long *map,
> > +                                           unsigned long start,
> > +                                           unsigned long nbits)
> > +{
> > +     const size_t index = BIT_WORD(start);
> > +     const unsigned long offset = start % BITS_PER_LONG;
>
> > +     const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
>
> This perhaps should use round_up()

I checked with 'round_up'. I am getting the same values as I was
getting with 'roundup'.
I have checked with different clump tests.
Moreover, wherever the 'space' was being evaluated as 64, in the case
of 'roundup', it is also getting evaluated to the same value (of 64),
in case of  'round_up' also.

Further below ...

>
> > +     const unsigned long space = ceiling - start;
>
> And I think I see a scenario to complain.
>
> If start == 0, then ceiling will be 64.
> space == 64. Not good.

Yes, you are right, when the 'start' is '0', then 'space' will be 64
(on arch where BITS_PER_LONG is 64).
But actually I want this to happen. I need 'space' to hold value 64
when 'start' is '0'. The reason is as follows:

Taking the example of bitmap_set_value(). If the nbits is 16 (as
example) and 'start' is zero, The 'if' condition will be executed
inside bitmap_set_value() when 'start' is zero because space(64) >=
nbits(16) is true. This 'if' condition is for the case when nbits
falls completely into the first word and the nbits doesn't have to
divide itself into another higher word of the bitmap.

This is what should happen according to me. If space is less than 64,
lets say 63 or 62, then it will not correctly indicate the remaining
space for nbits to fill in (bitmap_set_value) or to extract from
(bitmap_get_value).

Kindly let me know If I have misunderstood something. Thanks !

>
> > +     unsigned long value_low, value_high;
> > +
> > +     if (space >= nbits)
> > +             return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > +     else {
> > +             value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> > +             value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> > +             return (value_low >> offset) | (value_high << space);
> > +     }
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
> > +                                 unsigned long value,
> > +                                 unsigned long start, unsigned long nbits)
> > +{
> > +     const size_t index = BIT_WORD(start);
> > +     const unsigned long offset = start % BITS_PER_LONG;
>
> > +     const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> > +     const unsigned long space = ceiling - start;
>
> Ditto for both lines.
>
> > +     value &= GENMASK(nbits - 1, 0);
> > +
> > +     if (space >= nbits) {
> > +             map[index] &= ~(GENMASK(nbits + offset - 1, offset));
> > +             map[index] |= value << offset;
> > +     } else {
> > +             map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> > +             map[index] |= value << offset;
> > +             map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> > +             map[index + 1] |= (value >> space);
> > +     }
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
