Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F992CC8E7
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 22:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgLBV1k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 16:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgLBV1j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 16:27:39 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDEFC0617A6;
        Wed,  2 Dec 2020 13:26:59 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id g1so2934807ilk.7;
        Wed, 02 Dec 2020 13:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zrYzroKAEjKEUz6Dayur4doAVmg1tb9TZLAGX2zBSU=;
        b=oKmb7TfchXi0OffgSdCSXNR8lpQ//10m1CWjOOsM+cN8DGr2uMf6qqSmO8vVLNbE5W
         eEM4rdVaeNbnGTuhX8sT6Y8+zsxM9Tu/AsgY88IWXpA5lWQDytkW8j4LF2d3/xcSWWeK
         fAMWhmwjQ5nzbiSPRmVfx4N2H/erQuljYYlpQq1KdJvyokj8zkPi5aOFelibgbZpcSxG
         kfEFPlbc/seBmxmEBPkCuJeJAFAgAfO7NIHAjFUqjuyh29870BUMuu1AZ1rjpxDzYayy
         x+8b6vJYHZSBT8xzEsqk6VlYLDbQu9Bcp+vejKnUCB4QUE+ktnPmpi3fmUmU8he4Y3T4
         Esow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zrYzroKAEjKEUz6Dayur4doAVmg1tb9TZLAGX2zBSU=;
        b=FBcf5vNcMxA0UdivBono2E5+Elg6eNf+bRyCKR9UVGKHOz2bezvgC/SY56yp9NqKL8
         xJIYrQ2I+HC84Du0YohBdEzIiwp7vIfZIE5pQLoaJY03LgPlDTu5xSnEvFzaEUyQXsXo
         KdEZKhigWWHZkYKKL7l82Cmh7/XyeYJargLWXh+coEV50Xqbn6JtjO/eGpSso/Pwth8x
         B3bA3mlUW86sTIJFjZY6arK/a7CjzvNUSIpO7mOqHn1E835BlYrcUL/C0y4NZ9I0mQqM
         nlPZ1K6nhbPVYDDYV8hVw6xg9kRj0rSFhV67nQEtFSBLQ5TJ8g8lMVyTWLs0c9O4GtgX
         AkwA==
X-Gm-Message-State: AOAM530Q1B7djOCsKuOmLmZZeiJYchOFC5j9MS91np/XPz9ZyL65n8Vr
        6BIcC1UtlgN1hv+aqlkgOo6bkDM7mDkXPhZqvzo=
X-Google-Smtp-Source: ABdhPJwUbyNMipanIXBRNLfu3QIjuANypOxjlWhJUhz3pIC3U6vDS+gerEjRZjtkKRUZiyazx4RO4CJZie7jszKDk3Y=
X-Received: by 2002:a05:6e02:1805:: with SMTP id a5mr3987930ilv.170.1606944418592;
 Wed, 02 Dec 2020 13:26:58 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com> <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com> <CAM7-yPRBPP6SFzdmwWF5Y99g+aWcp=OY9Uvp-5h1MSDPmsORNw@mail.gmail.com>
In-Reply-To: <CAM7-yPRBPP6SFzdmwWF5Y99g+aWcp=OY9Uvp-5h1MSDPmsORNw@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 2 Dec 2020 13:26:47 -0800
Message-ID: <CAAH8bW-+XnNsd9p3xZ1utmyY24gaBa0ko4tngBii4T+2cMkcYg@mail.gmail.com>
Subject: Re:
To:     Yun Levi <ppbuk5246@gmail.com>
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

On Wed, Dec 2, 2020 at 10:22 AM Yun Levi <ppbuk5246@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 2:26 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> > Also look at lib/find_bit_benchmark.c
> Thanks. I'll see.
>
> > We need find_next_*_bit() because find_first_*_bit() can start searching only at word-aligned
> > bits. In the case of find_last_*_bit(), we can start at any bit. So, if my understanding is correct,
> > for the purpose of reverse traversing we can go with already existing find_last_bit(),
>
> Thank you. I haven't thought that way.
> But I think if we implement reverse traversing using find_last_bit(),
> we have a problem.
> Suppose the last bit 0, 1, 2, is set.
> If we start
>     find_last_bit(bitmap, 3) ==> return 2;
>     find_last_bit(bitmap, 2) ==> return 1;
>     find_last_bit(bitmap, 1) ==> return 0;
>     find_last_bit(bitmap, 0) ===> return 0? // here we couldn't
> distinguish size 0 input or 0 is set

If you traverse backward and reach bit #0, you're done. No need to continue.

>
> and the for_each traverse routine prevent above case by returning size
> (nbits) using find_next_bit.
> So, for compatibility and the same expected return value like next traversing,
> I think we need to find_prev_*_bit routine. if my understanding is correct.
>
>
> >  I think this patch has some good catches. We definitely need to implement
> > find_last_zero_bit(), as it is used by fs/ufs, and their local implementation is not optimal.
> >
> > We also should consider adding reverse traversing macros based on find_last_*_bit(),
> > if there are proposed users.
>
> Not only this, I think 'steal_from_bitmap_to_front' can be improved
> using ffind_prev_zero_bit
> like
>
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index af0013d3df63..9debb9707390 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2372,7 +2372,6 @@ static bool steal_from_bitmap_to_front(struct
> btrfs_free_space_ctl *ctl,
>   u64 bitmap_offset;
>   unsigned long i;
>   unsigned long j;
> - unsigned long prev_j;
>   u64 bytes;
>
>   bitmap_offset = offset_to_bitmap(ctl, info->offset);
> @@ -2388,20 +2387,15 @@ static bool steal_from_bitmap_to_front(struct
> btrfs_free_space_ctl *ctl,
>   return false;
>
>   i = offset_to_bit(bitmap->offset, ctl->unit, info->offset) - 1;
> - j = 0;
> - prev_j = (unsigned long)-1;
> - for_each_clear_bit_from(j, bitmap->bitmap, BITS_PER_BITMAP) {
> - if (j > i)
> - break;
> - prev_j = j;
> - }
> - if (prev_j == i)
> + j = find_prev_zero_bit(bitmap->bitmap, BITS_PER_BITMAP, i);

This one may be implemented with find_last_zero_bit() as well:

unsigned log j = find_last_zero_bit(bitmap, BITS_PER_BITMAP);
if (j <= i || j >= BITS_PER_BITMAP)
        return false;

I believe the latter version is better because find_last_*_bit() is simpler in
implementation (and partially exists), has less parameters, and therefore
simpler for users, and doesn't introduce functionality duplication.

The only consideration I can imagine to advocate find_prev*() is the performance
advantage in the scenario when we know for sure that first N bits of
bitmap are all
set/clear, and we can bypass traversing that area. But again, in this
case we can pass the
bitmap address with the appropriate offset, and stay with find_last_*()

> +
> + if (j == i)
>   return false;
>
> - if (prev_j == (unsigned long)-1)
> + if (j == BITS_PER_BITMAP)
>   bytes = (i + 1) * ctl->unit;
>   else
> - bytes = (i - prev_j) * ctl->unit;
> + bytes = (i - j) * ctl->unit;
>
>   info->offset -= bytes;
>   info->bytes += bytes;
>
> Thanks.
>
> HTH
> Levi.
