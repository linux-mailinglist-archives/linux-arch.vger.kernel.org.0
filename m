Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78062CC4F3
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 19:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgLBSXl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 13:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgLBSXl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 13:23:41 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3A2C0613D4;
        Wed,  2 Dec 2020 10:22:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id h21so10991206wmb.2;
        Wed, 02 Dec 2020 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Q0DeOHNN0molUdBXmfUTbrUNjvgkKKs8RuBf1nEwac=;
        b=akiQqHrDY+J7iANyemLJb7ZkkQMgqWdfXV3uiwhBv9k7KSqDRfKO0l7CBFZdRlippZ
         chDFgor/uouSlFGUVD9cDjb22i4K5y0/6UFnjjnMcFKZKhV75AzIpSyONdW9stF3Xwfa
         pB1Wc3qg1LYGMIC6jcq09UJuzHBi64V01inzGT+m1V0xYLOd2IkFglKD6/z3JHUSBr2l
         tECycgy6GidKn7BjhdnMuRGxOFk8XI/jUuf3s4Fblh/NQbpHXWmhMQ5q/YkC1vfvF+ro
         emTOdIeFxC0dPjQgPOqSV1cboJ+5MANgLInMi6NonxR/xmhqlKeWNhuQBXWKJzNJO4pX
         TAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Q0DeOHNN0molUdBXmfUTbrUNjvgkKKs8RuBf1nEwac=;
        b=ETYhvbOfzC6rMBZaxkopGikDoGpdq5SwcRIcUMZL2A8/utdhs0VYEk2w72BXAFrfS0
         W+jyEp5zJ7bidyLgrsq46uCBR3SPLfIZUxGn9vAUaLk2CIupJ2X8+4uPh4GUkPTarzSw
         Sc0cs66zH2GDEmdgt2koMZuX1Of49fu6fuj1zC6AIVPO02qfXLkZHpwEZzb2ATJoZcgZ
         OlgFQxyj0BvZxQD5o17Z+DqohAwwKjGv+nOsr/y+vDGFz5wN17I0oseiLcrc6r9v0S7t
         fJ4nl1Odn8LBUeTYmdN0VNGuhSSQqpp6q8FdiNr/eTGU/TW7x+6UOXSQEExsn+7FDdhX
         sXvQ==
X-Gm-Message-State: AOAM530VEL+BeFvklIdiakYGAcjOl6JvdJ6EdTGI3dmO3Mudj4Qv6EJ6
        FzQqDvC46gahKmif9smxRx3fWkbJEVGB9ElZ3OM=
X-Google-Smtp-Source: ABdhPJzqwvz25DNmqAysi1yeqEILO3da91lUGtp0ysPUKW1zNQuscdLxoh72mY2vBaQyw+G0nNmYjxN7O1K87zTLmCg=
X-Received: by 2002:a7b:c385:: with SMTP id s5mr4414705wmj.170.1606933373565;
 Wed, 02 Dec 2020 10:22:53 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com> <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com> <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
In-Reply-To: <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 3 Dec 2020 03:22:42 +0900
Message-ID: <CAM7-yPRBPP6SFzdmwWF5Y99g+aWcp=OY9Uvp-5h1MSDPmsORNw@mail.gmail.com>
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

On Thu, Dec 3, 2020 at 2:26 AM Yury Norov <yury.norov@gmail.com> wrote:

> Also look at lib/find_bit_benchmark.c
Thanks. I'll see.

> We need find_next_*_bit() because find_first_*_bit() can start searching only at word-aligned
> bits. In the case of find_last_*_bit(), we can start at any bit. So, if my understanding is correct,
> for the purpose of reverse traversing we can go with already existing find_last_bit(),

Thank you. I haven't thought that way.
But I think if we implement reverse traversing using find_last_bit(),
we have a problem.
Suppose the last bit 0, 1, 2, is set.
If we start
    find_last_bit(bitmap, 3) ==> return 2;
    find_last_bit(bitmap, 2) ==> return 1;
    find_last_bit(bitmap, 1) ==> return 0;
    find_last_bit(bitmap, 0) ===> return 0? // here we couldn't
distinguish size 0 input or 0 is set

and the for_each traverse routine prevent above case by returning size
(nbits) using find_next_bit.
So, for compatibility and the same expected return value like next traversing,
I think we need to find_prev_*_bit routine. if my understanding is correct.


>  I think this patch has some good catches. We definitely need to implement
> find_last_zero_bit(), as it is used by fs/ufs, and their local implementation is not optimal.
>
> We also should consider adding reverse traversing macros based on find_last_*_bit(),
> if there are proposed users.

Not only this, I think 'steal_from_bitmap_to_front' can be improved
using ffind_prev_zero_bit
like

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index af0013d3df63..9debb9707390 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2372,7 +2372,6 @@ static bool steal_from_bitmap_to_front(struct
btrfs_free_space_ctl *ctl,
  u64 bitmap_offset;
  unsigned long i;
  unsigned long j;
- unsigned long prev_j;
  u64 bytes;

  bitmap_offset = offset_to_bitmap(ctl, info->offset);
@@ -2388,20 +2387,15 @@ static bool steal_from_bitmap_to_front(struct
btrfs_free_space_ctl *ctl,
  return false;

  i = offset_to_bit(bitmap->offset, ctl->unit, info->offset) - 1;
- j = 0;
- prev_j = (unsigned long)-1;
- for_each_clear_bit_from(j, bitmap->bitmap, BITS_PER_BITMAP) {
- if (j > i)
- break;
- prev_j = j;
- }
- if (prev_j == i)
+ j = find_prev_zero_bit(bitmap->bitmap, BITS_PER_BITMAP, i);
+
+ if (j == i)
  return false;

- if (prev_j == (unsigned long)-1)
+ if (j == BITS_PER_BITMAP)
  bytes = (i + 1) * ctl->unit;
  else
- bytes = (i - prev_j) * ctl->unit;
+ bytes = (i - j) * ctl->unit;

  info->offset -= bytes;
  info->bytes += bytes;

Thanks.

HTH
Levi.
