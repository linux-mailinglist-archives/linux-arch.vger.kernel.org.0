Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17982CCB97
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 02:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgLCBYS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 20:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgLCBYR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 20:24:17 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DE9C0613D6;
        Wed,  2 Dec 2020 17:23:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i2so197267wrs.4;
        Wed, 02 Dec 2020 17:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuhN0DJ5By/Ek6lXt0sSYskGzF0kcgLtFsk361Xyk0o=;
        b=Z/rQFn5wpMoWreTts4AAVL08vLG4ovM0/6cX2WqJ1CD10QWpuD66eqtlqqHq5xLyon
         p8rdsDCZP1IW3nd5eAGvDSQbfGlwXSybJxN4f2eVAIFIzVJIDrqDhisd/KMSIW+cf2LS
         StcjurGDuMuyM5hZ4xV92mlo70EySZ8a2LsQKl60Lr/jrqHh1fD7aj2iK1bNnrD+BKfi
         gRiQ1SNTJNadYffcbB8ysz3GzJ0DuVJxqIHXbMbqW7niOR3wTZLteOpj+OIiHPrSzNju
         kK5v3FFgixBq2pOcAzmKYCRrcPCRRskJmwlHuV+8bmi/DkB98bZ80dkZtiQ7UwGLn5Of
         o7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuhN0DJ5By/Ek6lXt0sSYskGzF0kcgLtFsk361Xyk0o=;
        b=bbG42wxjGt8NJ7/4W3KLk8pSTV1cHU+BRMXwt8OAMulFL5oLB4VljPhnSOS47kvCJx
         Ezq9RGfZo/XVttyq+mFqC83ZyDipntb//Btt2hkBdw9b6F7jl5+cUI9CPr3Ujv+NL2l8
         FSYLainuOATQNMOCmkGTdH18RaT/jF9hWVncxgewrbOZd2vZ2eCaa6cPslOiRKomAbip
         bEsABO5CMl9Ex6Ed53wgiHYFGaW8ldT4erW8YoRAT90iGmJOetHQtBZ5pEvltrgJfs5X
         A/ZUP+7SsVUzJrDFDQ6sd6LqkXTG2AdEdH/j9sV15NgiDkfe5o0t2ETSPRv5M0Xih/cC
         5Mgg==
X-Gm-Message-State: AOAM531eMsEMKR1Mf9XuxBX7iYdn469R/CKh9X9NYJA8zUsoc/mTRWGE
        WS71v2D7by7WyhNr0RpmzqtKGu3q9OVBk3431tw=
X-Google-Smtp-Source: ABdhPJzHS63idfOQgusbpU5LZi61bnCuD5iNEoC8Vnli6eB/3IEMhHJj1RbJOB2Gtmq7qy6lezdRw0EsQ3ljB6SbrTU=
X-Received: by 2002:adf:f602:: with SMTP id t2mr887976wrp.40.1606958615994;
 Wed, 02 Dec 2020 17:23:35 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com> <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
 <CAM7-yPRBPP6SFzdmwWF5Y99g+aWcp=OY9Uvp-5h1MSDPmsORNw@mail.gmail.com>
 <CAAH8bW-+XnNsd9p3xZ1utmyY24gaBa0ko4tngBii4T+2cMkcYg@mail.gmail.com> <CAM7-yPQCWj6rOyLEgOqF3HGkFV1WKtqyVhEtDbS3HW=2A-HuBA@mail.gmail.com>
In-Reply-To: <CAM7-yPQCWj6rOyLEgOqF3HGkFV1WKtqyVhEtDbS3HW=2A-HuBA@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 3 Dec 2020 10:23:24 +0900
Message-ID: <CAM7-yPTtiVnUztE=xpNYgRcZTGd1aX_V9ZHd=2YZYc1uQNBXtw@mail.gmail.com>
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

On Thu, Dec 3, 2020 at 7:51 AM Yun Levi <ppbuk5246@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 6:26 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Wed, Dec 2, 2020 at 10:22 AM Yun Levi <ppbuk5246@gmail.com> wrote:
> > >
> > > On Thu, Dec 3, 2020 at 2:26 AM Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > > > Also look at lib/find_bit_benchmark.c
> > > Thanks. I'll see.
> > >
> > > > We need find_next_*_bit() because find_first_*_bit() can start searching only at word-aligned
> > > > bits. In the case of find_last_*_bit(), we can start at any bit. So, if my understanding is correct,
> > > > for the purpose of reverse traversing we can go with already existing find_last_bit(),
> > >
> > > Thank you. I haven't thought that way.
> > > But I think if we implement reverse traversing using find_last_bit(),
> > > we have a problem.
> > > Suppose the last bit 0, 1, 2, is set.
> > > If we start
> > >     find_last_bit(bitmap, 3) ==> return 2;
> > >     find_last_bit(bitmap, 2) ==> return 1;
> > >     find_last_bit(bitmap, 1) ==> return 0;
> > >     find_last_bit(bitmap, 0) ===> return 0? // here we couldn't
> > > distinguish size 0 input or 0 is set
> >
> > If you traverse backward and reach bit #0, you're done. No need to continue.
> I think the case when I consider the this macro like
>
> #define for_each_clear_bit_reverse(bit, addr, size)
>     for ((bit) = find_last_zero_bit((addr), (size))
>           (bit) < (size);
>           (bit) = find_prev_zero_bit((addr), (size), (bit)))
>
> If we implement the above macro only with find_last_zero_bit,
> I think there is no way without adding any additional variable to finish loop.
> But I don't want to add additional variable to sustain same format
> with for_each_clear_bit,
> That's why i decide to implement find_prev_*_bit series.
>
> I don't know it's correct thinking or biased. Am I wrong?
>
> >
> > >
> > > and the for_each traverse routine prevent above case by returning size
> > > (nbits) using find_next_bit.
> > > So, for compatibility and the same expected return value like next traversing,
> > > I think we need to find_prev_*_bit routine. if my understanding is correct.
> > >
> > >
> > > >  I think this patch has some good catches. We definitely need to implement
> > > > find_last_zero_bit(), as it is used by fs/ufs, and their local implementation is not optimal.
> > > >
> > > > We also should consider adding reverse traversing macros based on find_last_*_bit(),
> > > > if there are proposed users.
> > >
> > > Not only this, I think 'steal_from_bitmap_to_front' can be improved
> > > using ffind_prev_zero_bit
> > > like
> > >
> > > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > > index af0013d3df63..9debb9707390 100644
> > > --- a/fs/btrfs/free-space-cache.c
> > > +++ b/fs/btrfs/free-space-cache.c
> > > @@ -2372,7 +2372,6 @@ static bool steal_from_bitmap_to_front(struct
> > > btrfs_free_space_ctl *ctl,
> > >   u64 bitmap_offset;
> > >   unsigned long i;
> > >   unsigned long j;
> > > - unsigned long prev_j;
> > >   u64 bytes;
> > >
> > >   bitmap_offset = offset_to_bitmap(ctl, info->offset);
> > > @@ -2388,20 +2387,15 @@ static bool steal_from_bitmap_to_front(struct
> > > btrfs_free_space_ctl *ctl,
> > >   return false;
> > >
> > >   i = offset_to_bit(bitmap->offset, ctl->unit, info->offset) - 1;
> > > - j = 0;
> > > - prev_j = (unsigned long)-1;
> > > - for_each_clear_bit_from(j, bitmap->bitmap, BITS_PER_BITMAP) {
> > > - if (j > i)
> > > - break;
> > > - prev_j = j;
> > > - }
> > > - if (prev_j == i)
> > > + j = find_prev_zero_bit(bitmap->bitmap, BITS_PER_BITMAP, i);
> >
> > This one may be implemented with find_last_zero_bit() as well:
> >
> > unsigned log j = find_last_zero_bit(bitmap, BITS_PER_BITMAP);
> > if (j <= i || j >= BITS_PER_BITMAP)
> >         return false;
> >
> Actually, in that code, we don't need to check the bit after i.
> Originally, if my understanding is correct, former code tries to find
> the last 0 bit before i.
> and if all bits are fully set before i, it use next one as i + 1
>
> that's why i think the if condition should be
>    if (j >= i)
>
> But above condition couldn't the discern the case when all bits are
> fully set before i.
> Also, I think we don't need to check the bit after i and In this case,
> find_prev_zero_bit which
> specifies the start point is clear to show the meaning of the code.
>
>
> > I believe the latter version is better because find_last_*_bit() is simpler in
> > implementation (and partially exists), has less parameters, and therefore
> > simpler for users, and doesn't introduce functionality duplication.

I think it's not duplication.
Actually, former you teach me find_first_*_bit should be start word-aligned bit,
But as find_first_*_bit declares it as "size of bitmap" not a start offset.
Though the bitmap size it's word-aligned, it doesn't matter to fine
first bit in the specified size of bitmap (it no, it will return just
size of bitmap)

Likewise, find_last_*_bit is also similar in context.
Fundamentally, it's not a start offset of bitmap but I think it just
size of bitmap.

That's the reason why we need to find_next_*_bit to start at the
specified offset.
In this matter, I think it's better to have find_prev_*_bit.

So, I think we can use both of these functions to be used to achieve a goal.
But, each function has different concept actually that's why I don't
think it's not duplication.

if my understanding is wrong.. Forgive me. and let me know..

Thanks.



> >
> > The only consideration I can imagine to advocate find_prev*() is the performance
> > advantage in the scenario when we know for sure that first N bits of
> > bitmap are all
> > set/clear, and we can bypass traversing that area. But again, in this
> > case we can pass the
> > bitmap address with the appropriate offset, and stay with find_last_*()
> >
> > > +
> > > + if (j == i)
> > >   return false;
> > >
> > > - if (prev_j == (unsigned long)-1)
> > > + if (j == BITS_PER_BITMAP)
> > >   bytes = (i + 1) * ctl->unit;
> > >   else
> > > - bytes = (i - prev_j) * ctl->unit;
> > > + bytes = (i - j) * ctl->unit;
> > >
> > >   info->offset -= bytes;
> > >   info->bytes += bytes;
> > >
> > > Thanks.
> > >
> > > HTH
> > > Levi.
>
> Thanks but
