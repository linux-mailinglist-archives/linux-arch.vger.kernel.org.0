Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B092CC9EE
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 23:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgLBWwB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 17:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgLBWwA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 17:52:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB8EC0613D6;
        Wed,  2 Dec 2020 14:51:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a6so705702wmc.2;
        Wed, 02 Dec 2020 14:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlZW5TDu5jAoSGgUpIKIdqJkT/tu5xUY/rPMts9/Lgw=;
        b=I99JFfgzw5zVRQwJP7I3tfgDOQe/3u+NYs890iN5pwTZ76QFf0lVYCfWX0Alpsmhrf
         xOhLYT21gNMMS/ROcpHS9xPo5DktFqACshbhZxgs/rRI1P6CibXViMCDkqYitADY2EzQ
         QSWvHU4yXh1z2pUFYKLUf+4p5Jg1hdLdbvRN4++U8hkyjNU+zZmOvhLQFpCX13I+rmHa
         aKumgzfthm3ynap63xIdo6TQAn6S7ZOopevH0PSs5w/NSnwXLESOgQ2yYvIeTtFySL/g
         Z6lnon43kfz6RgqwmvzH6YPXpfJuUGeQxkwe8tbf0m2YsbXadi+6d7Ky+X5+PIK1rPU8
         yDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlZW5TDu5jAoSGgUpIKIdqJkT/tu5xUY/rPMts9/Lgw=;
        b=ERFk5uyJsinX6RfewDOdMgwmBXNYY5oHLP7SrChlATqK/L/YANjnzCAaKQeVSnHsso
         zF3Q5Fw3IiRdJ/WYzgtCQfpMmKcizrvtsmjmJ7b9AzztazF6q7vl1dccSEp/2lsg0y5Q
         ZB5LjwJ/lZ6MpKOHZeWeYnM+zdTaLalxpUFtr5x0rhxbyEFklEyMPmtFYUrBM/JngzvW
         1txfxPxwOhpReS4A8MZfoZR6TaoKx1SLuyaZIK/iJl1TCRf/U9WaHnxspPuGXRF3Mctp
         BRJ4A07m3Vax68QHSn8HS5y3keRsOOVvUxuNBleNfqDl9L3rHDbGW+Ug6psVFt2MNj8t
         Aj6A==
X-Gm-Message-State: AOAM532CSVPB3spMikV7KxelV8Szvft/MQur6kPa+VpkjfK+0SVtTxAl
        E9rcGv2kHnAQJ8hj8Fwow5eIpscMCJDMwTcm6yY=
X-Google-Smtp-Source: ABdhPJwK+p2rlDn7QnwnrlQli03/5Ecgz1Qa/J80GxKWa1mr26aBriD5/aTEfk5kJm8Smhu6kYvu33ezKhfPrVYB2Hg=
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr203554wmh.44.1606949478753;
 Wed, 02 Dec 2020 14:51:18 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com> <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
 <CAM7-yPRBPP6SFzdmwWF5Y99g+aWcp=OY9Uvp-5h1MSDPmsORNw@mail.gmail.com> <CAAH8bW-+XnNsd9p3xZ1utmyY24gaBa0ko4tngBii4T+2cMkcYg@mail.gmail.com>
In-Reply-To: <CAAH8bW-+XnNsd9p3xZ1utmyY24gaBa0ko4tngBii4T+2cMkcYg@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 3 Dec 2020 07:51:07 +0900
Message-ID: <CAM7-yPQCWj6rOyLEgOqF3HGkFV1WKtqyVhEtDbS3HW=2A-HuBA@mail.gmail.com>
Subject: 
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>, dushistov@mail.ru,
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

On Thu, Dec 3, 2020 at 6:26 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Wed, Dec 2, 2020 at 10:22 AM Yun Levi <ppbuk5246@gmail.com> wrote:
> >
> > On Thu, Dec 3, 2020 at 2:26 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > > Also look at lib/find_bit_benchmark.c
> > Thanks. I'll see.
> >
> > > We need find_next_*_bit() because find_first_*_bit() can start searching only at word-aligned
> > > bits. In the case of find_last_*_bit(), we can start at any bit. So, if my understanding is correct,
> > > for the purpose of reverse traversing we can go with already existing find_last_bit(),
> >
> > Thank you. I haven't thought that way.
> > But I think if we implement reverse traversing using find_last_bit(),
> > we have a problem.
> > Suppose the last bit 0, 1, 2, is set.
> > If we start
> >     find_last_bit(bitmap, 3) ==> return 2;
> >     find_last_bit(bitmap, 2) ==> return 1;
> >     find_last_bit(bitmap, 1) ==> return 0;
> >     find_last_bit(bitmap, 0) ===> return 0? // here we couldn't
> > distinguish size 0 input or 0 is set
>
> If you traverse backward and reach bit #0, you're done. No need to continue.
I think the case when I consider the this macro like

#define for_each_clear_bit_reverse(bit, addr, size)
    for ((bit) = find_last_zero_bit((addr), (size))
          (bit) < (size);
          (bit) = find_prev_zero_bit((addr), (size), (bit)))

If we implement the above macro only with find_last_zero_bit,
I think there is no way without adding any additional variable to finish loop.
But I don't want to add additional variable to sustain same format
with for_each_clear_bit,
That's why i decide to implement find_prev_*_bit series.

I don't know it's correct thinking or biased. Am I wrong?

>
> >
> > and the for_each traverse routine prevent above case by returning size
> > (nbits) using find_next_bit.
> > So, for compatibility and the same expected return value like next traversing,
> > I think we need to find_prev_*_bit routine. if my understanding is correct.
> >
> >
> > >  I think this patch has some good catches. We definitely need to implement
> > > find_last_zero_bit(), as it is used by fs/ufs, and their local implementation is not optimal.
> > >
> > > We also should consider adding reverse traversing macros based on find_last_*_bit(),
> > > if there are proposed users.
> >
> > Not only this, I think 'steal_from_bitmap_to_front' can be improved
> > using ffind_prev_zero_bit
> > like
> >
> > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > index af0013d3df63..9debb9707390 100644
> > --- a/fs/btrfs/free-space-cache.c
> > +++ b/fs/btrfs/free-space-cache.c
> > @@ -2372,7 +2372,6 @@ static bool steal_from_bitmap_to_front(struct
> > btrfs_free_space_ctl *ctl,
> >   u64 bitmap_offset;
> >   unsigned long i;
> >   unsigned long j;
> > - unsigned long prev_j;
> >   u64 bytes;
> >
> >   bitmap_offset = offset_to_bitmap(ctl, info->offset);
> > @@ -2388,20 +2387,15 @@ static bool steal_from_bitmap_to_front(struct
> > btrfs_free_space_ctl *ctl,
> >   return false;
> >
> >   i = offset_to_bit(bitmap->offset, ctl->unit, info->offset) - 1;
> > - j = 0;
> > - prev_j = (unsigned long)-1;
> > - for_each_clear_bit_from(j, bitmap->bitmap, BITS_PER_BITMAP) {
> > - if (j > i)
> > - break;
> > - prev_j = j;
> > - }
> > - if (prev_j == i)
> > + j = find_prev_zero_bit(bitmap->bitmap, BITS_PER_BITMAP, i);
>
> This one may be implemented with find_last_zero_bit() as well:
>
> unsigned log j = find_last_zero_bit(bitmap, BITS_PER_BITMAP);
> if (j <= i || j >= BITS_PER_BITMAP)
>         return false;
>
Actually, in that code, we don't need to check the bit after i.
Originally, if my understanding is correct, former code tries to find
the last 0 bit before i.
and if all bits are fully set before i, it use next one as i + 1

that's why i think the if condition should be
   if (j >= i)

But above condition couldn't the discern the case when all bits are
fully set before i.
Also, I think we don't need to check the bit after i and In this case,
find_prev_zero_bit which
specifies the start point is clear to show the meaning of the code.


> I believe the latter version is better because find_last_*_bit() is simpler in
> implementation (and partially exists), has less parameters, and therefore
> simpler for users, and doesn't introduce functionality duplication.
>
> The only consideration I can imagine to advocate find_prev*() is the performance
> advantage in the scenario when we know for sure that first N bits of
> bitmap are all
> set/clear, and we can bypass traversing that area. But again, in this
> case we can pass the
> bitmap address with the appropriate offset, and stay with find_last_*()
>
> > +
> > + if (j == i)
> >   return false;
> >
> > - if (prev_j == (unsigned long)-1)
> > + if (j == BITS_PER_BITMAP)
> >   bytes = (i + 1) * ctl->unit;
> >   else
> > - bytes = (i - prev_j) * ctl->unit;
> > + bytes = (i - j) * ctl->unit;
> >
> >   info->offset -= bytes;
> >   info->bytes += bytes;
> >
> > Thanks.
> >
> > HTH
> > Levi.

Thanks but
