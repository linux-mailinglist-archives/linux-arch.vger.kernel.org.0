Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5B62023FC
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jun 2020 15:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgFTNp6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Jun 2020 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgFTNp5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Jun 2020 09:45:57 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6ADC06174E;
        Sat, 20 Jun 2020 06:45:57 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i4so11457563iov.11;
        Sat, 20 Jun 2020 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNXH1YyCsCCl1PMwAp+oXRKvH3YYWfnwY9YvlVxqdww=;
        b=rcxaeLlz/cgHimzyoWhZdWGHIbENtRp2IsSWqCwO0Cwf3isdxM8xKq/gDUNc3Zk7cE
         p747aOnwWPvG/Y4JTrI5jg2xyU77w77Hrm+hXGJdlddukqkMncO2o5GLb61u2ggOZotB
         errbF9SKLDVyYf0hySHJasYmmAXl57Cz29wl8NcccwTzNMbDKoIF1ojelhyUrglBmS+l
         ieIZ4/MILunQnTe79G2qbK2a41INV/3Ce9jF4hAwgdRL/kGCjhnbHaSI25275MOH8OMc
         fY4v9/iewjdumxIwwr0fLSDfn88cWr8lwjBtENKvY3qIxcEK7KeX1yWi8/4NBUMmIqTs
         5gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNXH1YyCsCCl1PMwAp+oXRKvH3YYWfnwY9YvlVxqdww=;
        b=iMg/FfxPvIQE/nA5JCMaXIhZfLSo3F9H46qgVjDTRx8MQdEdarWadfVyczx59rRURq
         AeomT/HtM/Ln+6kXZp/dSt1k7dTgAG6753LkeMhTsNURmEieFJMMQQFV/1AurlrxuKrj
         F0NcdeQLxTylfWoA9785RY++bgjYykmEJXNkJhWkaadAmULlA2SeDFFkf9quokvCDyse
         zhNoy/Sz+kJkpFwNNWsnI/fBNU5/BW8zf2Dnldr4N5Nj/mK8BclcSX1bL4hpg4ZI7Sf2
         PSBChzAWfjScRd6zNWmvQ1XQtKUNcNxVd/vghMsUECeQ1FlTRjB2j577mDap1cCj4RX9
         IUrw==
X-Gm-Message-State: AOAM5334oWxB0gtZOEHZ10Nt0hqDrkOXFR0caHn2BeWPPoHLTW5Ol0qJ
        TWBKdhkD/28UenQjhD3+rD7tjzmSrJzKSPoojHA=
X-Google-Smtp-Source: ABdhPJyLtGRtpXnIWl94atiG4W1tkPfkoeM7pynAOTFue99EdcoR7NJAVK+TmeaitSyzQMqns7VsTbyYaihfRUHhPcM=
X-Received: by 2002:a02:c4c8:: with SMTP id h8mr8758326jaj.64.1592660756641;
 Sat, 20 Jun 2020 06:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592224128.git.syednwaris@gmail.com> <fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com>
 <20200616081428.GP2428291@smile.fi.intel.com>
In-Reply-To: <20200616081428.GP2428291@smile.fi.intel.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sat, 20 Jun 2020 19:15:44 +0530
Message-ID: <CACG_h5rDCX10qdbvtD93hL0-hNgJ-J_Orr6X_1WW-9u-CCU36g@mail.gmail.com>
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

Hi Andy. I will see with round_up(). I will check and inform you.
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

This is what I want to happen. I will think more about this and let
you know further.

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
