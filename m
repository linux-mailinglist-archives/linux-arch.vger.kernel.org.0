Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4572CD2D4
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 10:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgLCJsB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 04:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbgLCJsB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 04:48:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81E3C061A4D;
        Thu,  3 Dec 2020 01:47:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u12so1211419wrt.0;
        Thu, 03 Dec 2020 01:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dK0NRUVlAwcsui5gjsw4Jx8irBvWKCUPKqEJTVl5wOo=;
        b=l1lrmNDPTiMcqF3XHdUmkuFymB7t/+6GhZaptCheNCB/E4tKzI98WHPUd86C9vCKzO
         0jifMY7QINRUs335PhOcNWgbNcLxVDUYdEHWbOeXm4okWFIAGliMxV+yp1lIVv+s4Wn/
         lHQWanmUgmORQ5HoQKKzzlaeIN7uZTRWOOMwzKEpxMowjf818GD1syz36VOtU1vLOhcE
         xUkQ24LiJbqp0Xb4tou4Uc8AezF1LTVGcuKYEla3wc6VaNu41JRVv8aIm45ckulHwEGB
         jmm0EQQY3UcqNpsgyYUbnaYhAXSjyXufY6WqyEIKwH+J9gGgqlRGcTsd/iGkF7lEQiRs
         dqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dK0NRUVlAwcsui5gjsw4Jx8irBvWKCUPKqEJTVl5wOo=;
        b=HC5YkAGjdbx79uGmiSun+LiZqrTRn0S/D/5LBzSW9ICEWT7GXK08hYx54vnjZd4Tnm
         DQDZaNu3AW1jIT1u4YOk63i6YqzGO+vRG3oUHvepO4mFQHoWNUr0IQfKOQA/L7xMtkHI
         rUVNWXig6Ds5XCarMiOgAVBP6bjR2KW4AtoHrZCyYUnPa01gb3a1rN/GUCHDRzyXUXeu
         wweol1FMndQKBL5ZzIdquoocIq7Yc7tYL/U8c+1JIA/sjoDmqfhE6ytHWDvH6svbsJTJ
         TvduYz2WTpm4VEaKpvDxASmrD92lmpqi7Zses0iXGWMicjw4KNyeqeJkoZEvLleJIQJd
         dSbw==
X-Gm-Message-State: AOAM533zpmvbiEpEWDzhXLt7QlFpsfBsW0iE8YhhTkS9X7zSbX1hOc7B
        9W99pCizmUl5advZkV1ERUeTst9YNEnNBMHtD8s=
X-Google-Smtp-Source: ABdhPJxjznigo6gl5tQEWfaCO9AliUqwf5NewBcU5kIKVjbpla8ZRtAOVQ8gb+vd0AekhlHCFDcqfCeBv/7Mdy7/npQ=
X-Received: by 2002:adf:f602:: with SMTP id t2mr2797924wrp.40.1606988839446;
 Thu, 03 Dec 2020 01:47:19 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com> <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
 <CAM7-yPRBPP6SFzdmwWF5Y99g+aWcp=OY9Uvp-5h1MSDPmsORNw@mail.gmail.com>
 <CAAH8bW-+XnNsd9p3xZ1utmyY24gaBa0ko4tngBii4T+2cMkcYg@mail.gmail.com>
 <CAM7-yPQCWj6rOyLEgOqF3HGkFV1WKtqyVhEtDbS3HW=2A-HuBA@mail.gmail.com>
 <CAM7-yPTtiVnUztE=xpNYgRcZTGd1aX_V9ZHd=2YZYc1uQNBXtw@mail.gmail.com> <a0cc0d2e-9c55-8546-f070-26feed5de37f@rasmusvillemoes.dk>
In-Reply-To: <a0cc0d2e-9c55-8546-f070-26feed5de37f@rasmusvillemoes.dk>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 3 Dec 2020 18:47:06 +0900
Message-ID: <CAM7-yPQrvYUwX-cbgpzhomCTFEi9sQ9iGuLNcL-Fsj7XZ0knhw@mail.gmail.com>
Subject: Re:
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>, dushistov@mail.ru,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> If one uses UINT_MAX, a for_each_bit_reverse() macro would just be
> something like
>
> for (i = find_last_bit(bitmap, size); i < size; i =
> find_last_bit(bitmap, i))
>
> if one wants to use the size argument as the sentinel, the caller would
> have to supply a scratch variable to keep track of the last i value:
>
> for (j = size, i = find_last_bit(bitmap, j); i < j; j = i, i =
> find_last_bit(bitmap, j))
>
> which is probably a little less ergonomic.

Actually Because I want to avoid the modification of return type of
find_last_*_bit for new sentinel,
I add find_prev_*_bit.
the big difference between find_last_bit and find_prev_bit is
   find_last_bit doesn't check the size bit and use sentinel with size.
   but find_prev_bit check the offset bit and use sentinel with size
which passed by another argument.
   So if we use find_prev_bit, we could have a clear iteration if
using find_prev_bit like.

  #define for_each_set_bit_reverse(bit, addr, size) \
      for ((bit) = find_last_bit((addr), (size));    \
            (bit) < (size);                                     \
            (bit) = find_prev_bit((addr), (size), (bit - 1)))

  #define for_each_set_bit_from_reverse(bit, addr, size) \
      for ((bit) = find_prev_bit((addr), (size), (bit)); \
             (bit) < (size);                                           \
             (bit) = find_prev_bit((addr), (size), (bit - 1)))

Though find_prev_*_bit / find_last_*_bit have the same functionality.
But they also have a small difference.
I think this small this small difference doesn't make some of
confusion to user but it help to solve problem
with a simple way (just like the iteration above).

So I think I need, find_prev_*_bit series.

Am I missing anything?

Thanks.

Levi.

On Thu, Dec 3, 2020 at 5:33 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 03/12/2020 02.23, Yun Levi wrote:
> > On Thu, Dec 3, 2020 at 7:51 AM Yun Levi <ppbuk5246@gmail.com> wrote:
> >>
> >> On Thu, Dec 3, 2020 at 6:26 AM Yury Norov <yury.norov@gmail.com> wrote:
> >>>
> >>> On Wed, Dec 2, 2020 at 10:22 AM Yun Levi <ppbuk5246@gmail.com> wrote:
> >>>>
> >>>> On Thu, Dec 3, 2020 at 2:26 AM Yury Norov <yury.norov@gmail.com> wrote:
> >>>>
> >>>>> Also look at lib/find_bit_benchmark.c
> >>>> Thanks. I'll see.
> >>>>
> >>>>> We need find_next_*_bit() because find_first_*_bit() can start searching only at word-aligned
> >>>>> bits. In the case of find_last_*_bit(), we can start at any bit. So, if my understanding is correct,
> >>>>> for the purpose of reverse traversing we can go with already existing find_last_bit(),
> >>>>
> >>>> Thank you. I haven't thought that way.
> >>>> But I think if we implement reverse traversing using find_last_bit(),
> >>>> we have a problem.
> >>>> Suppose the last bit 0, 1, 2, is set.
> >>>> If we start
> >>>>     find_last_bit(bitmap, 3) ==> return 2;
> >>>>     find_last_bit(bitmap, 2) ==> return 1;
> >>>>     find_last_bit(bitmap, 1) ==> return 0;
> >>>>     find_last_bit(bitmap, 0) ===> return 0? // here we couldn't
>
> Either just make the return type of all find_prev/find_last be signed
> int and use -1 as the sentinel to indicate "no such position exists", so
> the loop condition would be foo >= 0. Or, change the condition from
> "stop if we get the size returned" to "only continue if we get something
> strictly less than the size we passed in (i.e., something which can
> possibly be a valid bit index). In the latter case, both (unsigned)-1
> aka UINT_MAX and the actual size value passed work equally well as a
> sentinel.
>
> If one uses UINT_MAX, a for_each_bit_reverse() macro would just be
> something like
>
> for (i = find_last_bit(bitmap, size); i < size; i =
> find_last_bit(bitmap, i))
>
> if one wants to use the size argument as the sentinel, the caller would
> have to supply a scratch variable to keep track of the last i value:
>
> for (j = size, i = find_last_bit(bitmap, j); i < j; j = i, i =
> find_last_bit(bitmap, j))
>
> which is probably a little less ergonomic.
>
> Rasmus
