Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC612BB1EE
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 19:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgKTSDJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 13:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgKTSDI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 13:03:08 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51516C0613CF;
        Fri, 20 Nov 2020 10:03:07 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id l12so9344532ilo.1;
        Fri, 20 Nov 2020 10:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qvqz11R6f8JI5zsBDFVuBEzAMW6fNdbI/OnEdkYk48=;
        b=RHVlUyuc/jgWCGOtrINdtrjVi44N6tl4aeFWrZQXyiJSNNMXTwj4bAuUGrJNx+KZtz
         3eB0wDFU4t4X2hmzFLvaJj/MWsktOi6XOL26dZNs69o2n4KEnU28En57NqL9a2HmDre7
         GCeWDuCmgWnLPIwFoasY0b2vDyGSfJ8fBs/GFvrhrfvRvXDjVYjItQRaJ5lsu6FBvV9f
         6/xenz4/TMXRhcbTjSafEgOgjdyGkgn1pDjmz1McA8I2o/y5EOb17A5zgi4qYAmZGV3z
         EuSB+qy7OOn9NdxEwKv2U7FuSxkstVGLGvr9185+rOZVjMHeWkyYFJURQeyHvJgalCTb
         6W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qvqz11R6f8JI5zsBDFVuBEzAMW6fNdbI/OnEdkYk48=;
        b=q4UTZTs176d1ijZg+J42pW3dQK3kIY8mqSfavv0n4NXCepNRY+cJK2w85P9kxuoGkU
         UMJ5KB3G3cXTKUA6tjchkjnBDK8TydJ9bkQhU4F3UdiHB0RZgsSeSwqA+XzgoSUxiqk8
         xIjFJG3rPR3PEALHuHK52IkcabzaeNAHErRTE2OmuXenW03PMvRUfUHw+vMLD7wsR0op
         PaWVDNqnXkLl92ecDTlJRkgUYWnfSZpxURhIyN03tCjx+oRlxS9NNjd0eMSJeueB4lOc
         +cC4Kba2kbKv+FcwUI7rn58tY3BoazNahRtDWNd7QeqLoq8AZder0mgj0PtnQvsN2vvo
         iXvw==
X-Gm-Message-State: AOAM532YkpJd5OVmbU87Odm1cugDxZ9ZyQnr9EcEQayNznHGqzymTEXR
        DiZJI1IOckxpa8l2IuCBFp+jRKHD9lv03o1olKw1ZLRb4NE=
X-Google-Smtp-Source: ABdhPJyydj+hM5HvBcpEvaW9M2cKq6pn/UfAvmG9+CIxFGpE+iODkbPxPsMOBPozQuDc4258F6K0WtzIY9ML+5DtKrw=
X-Received: by 2002:a92:96c1:: with SMTP id g184mr16340833ilh.205.1605895385704;
 Fri, 20 Nov 2020 10:03:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605893641.git.syednwaris@gmail.com> <b2011fb2e0438bdfd0b663b9f0456d0aef20f04b.1605893642.git.syednwaris@gmail.com>
 <X7gD7Q/63qoUuGpi@shinobu>
In-Reply-To: <X7gD7Q/63qoUuGpi@shinobu>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 20 Nov 2020 23:32:53 +0530
Message-ID: <CACG_h5qjvPN-LFH-JGm=8xeM-k4KB9pd==xvf0DDBMgRb-TXUQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] bitmap: Modify bitmap_set_value() to check bitmap length
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 20, 2020 at 11:29 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Fri, Nov 20, 2020 at 11:14:16PM +0530, Syed Nayyar Waris wrote:
> > Add explicit check to see if the value being written into the bitmap
> > does not fall outside the bitmap.
> > The situation that it is falling outside would never be possible in the
> > code because the boundaries are required to be correct before the function
> > is called. The responsibility is on the caller for ensuring the boundaries
> > are correct.
> > This is just to suppress the GCC -Wtype-limits warnings.
>
> Hi Syed,
>
> This commit message sounds a bit strange without the context of our
> earlier discussion thread. Would you be able to reword the commit
> message to explain the motivation for using __builtin_unreachable()?
>
> Thanks,
>
> William Breathitt Gray

Hi William,

Actually I explained the motivation for using __builtin_unreachable()
in the cover letter.
So, left it here in this patch.

I am sending this patch again updating the commit message.

Regards
Syed Nayyar Waris

>
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  include/linux/bitmap.h | 35 +++++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index 386d08777342..efb6199ea1e7 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -78,8 +78,9 @@
> >   *  bitmap_get_value(map, start, nbits)              Get bit value of size
> >   *                                              'nbits' from map at start
> >   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
> > - *  bitmap_set_value(map, value, start, nbits)       Set bit value of size 'nbits'
> > - *                                              of map at start
> > + *  bitmap_set_value(map, nbits, value, value_width, start)
> > + *                                              Set bit value of size value_width
> > + *                                              to map at start
> >   *
> >   * Note, bitmap_zero() and bitmap_fill() operate over the region of
> >   * unsigned longs, that is, bits behind bitmap till the unsigned long
> > @@ -610,30 +611,36 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
> >  }
> >
> >  /**
> > - * bitmap_set_value - set n-bit value within a memory region
> > + * bitmap_set_value - set value within a memory region
> >   * @map: address to the bitmap memory region
> > - * @value: value of nbits
> > - * @start: bit offset of the n-bit value
> > - * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG inclusive).
> > + * @nbits: size of map in bits
> > + * @value: value of clump
> > + * @value_width: size of value in bits (must be between 1 and BITS_PER_LONG inclusive)
> > + * @start: bit offset of the value
> >   */
> > -static inline void bitmap_set_value(unsigned long *map,
> > -                                 unsigned long value,
> > -                                 unsigned long start, unsigned long nbits)
> > +static inline void bitmap_set_value(unsigned long *map, unsigned long nbits,
> > +                                 unsigned long value, unsigned long value_width,
> > +                                 unsigned long start)
> >  {
> > -     const size_t index = BIT_WORD(start);
> > +     const unsigned long index = BIT_WORD(start);
> > +     const unsigned long length = BIT_WORD(nbits);
> >       const unsigned long offset = start % BITS_PER_LONG;
> >       const unsigned long ceiling = round_up(start + 1, BITS_PER_LONG);
> >       const unsigned long space = ceiling - start;
> >
> > -     value &= GENMASK(nbits - 1, 0);
> > +     value &= GENMASK(value_width - 1, 0);
> >
> > -     if (space >= nbits) {
> > -             map[index] &= ~(GENMASK(nbits - 1, 0) << offset);
> > +     if (space >= value_width) {
> > +             map[index] &= ~(GENMASK(value_width - 1, 0) << offset);
> >               map[index] |= value << offset;
> >       } else {
> >               map[index + 0] &= ~BITMAP_FIRST_WORD_MASK(start);
> >               map[index + 0] |= value << offset;
> > -             map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> > +
> > +             if (index + 1 >= length)
> > +                     __builtin_unreachable();
> > +
> > +             map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + value_width);
> >               map[index + 1] |= value >> space;
> >       }
> >  }
> > --
> > 2.29.0
> >
