Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ED12CDDF9
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 19:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbgLCSrY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 13:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbgLCSrY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 13:47:24 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197FFC061A51;
        Thu,  3 Dec 2020 10:46:38 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id y9so2907117ilb.0;
        Thu, 03 Dec 2020 10:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zrBMF1cvyyYZySEZeLChuEF0Fk70/ANlwnRnOfR3ukw=;
        b=s7Hi4M0OTksfaBwNZjamg+em1XDDlLy3KudtgYAW60arN/kuue9nttVKdQ3yn9XImF
         jNIiS3zBL5E4Dxs2QOQuwk6e1brsr7L+MNwveg3M9lAqq5B6yKbApYtQUM+cU5G+kSV8
         Y3ECCxgE3b0eqdo7L76g8xegvQMEWaAXlrosZhk45tcPKKF8jtMzZcpPabL9aMFLp11K
         aKAiF4mKR5Zp34+JNwe8Wyx9huEBFDglb/2UUsCylU9ylpPv1VVEFghxxsCPXYCDGS0v
         iR++CNM4kFiZg/6UgZRUU/ZaeWmFIKsNNuuMos6lxM2abKlMxQ6x2XdON4JJMt55LOwE
         F68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zrBMF1cvyyYZySEZeLChuEF0Fk70/ANlwnRnOfR3ukw=;
        b=osRuMFPffrKkoBE66CVaoQsgzqtf1TEzUyEmDeqk/0fG+d0Jdgj/Q/iy2GvQuGJiP8
         ug9XEu9o4LUOgC5y8pamvge9utYTjAkr8FvzxqOvzRvdTrarmsGRNV46/qgpBslhN0Mn
         tqddR6y3P9THdI/rA33cxc6tlrGqMmQqGNQs/7aY74IKEZGgIw6ALV2BndsizRsErQPI
         hBjdpZK99L16YMZzzNQqHen/P1pItjFnw+19e6HA/K2UzWfvfvQTji0V/lxv8Txnwjoa
         cOhisFp+G8NOqdLr/XhYC+ewPgtN7w6xSW4z5GB+0uxE1uqGt9aHFoY8+G9xI2MgyL5u
         dy9A==
X-Gm-Message-State: AOAM531IWEWL6dId1l+uDuDSoayd+xKxzJFnRmVdYt8OlZRPRwIPnWCy
        72xFP/xRnVrd1EtSpP+REjkadlwWknHmzPlqOac=
X-Google-Smtp-Source: ABdhPJxhrDWd8yyesH9r8VCleqJT8yx4vOqur8NyhCmeLkE/p4AcymMpuUZMaiYM73NL+FIqN/QTkUAx2ydeZsODXgM=
X-Received: by 2002:a92:cac4:: with SMTP id m4mr606984ilq.252.1607021197363;
 Thu, 03 Dec 2020 10:46:37 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com> <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
 <CAM7-yPRBPP6SFzdmwWF5Y99g+aWcp=OY9Uvp-5h1MSDPmsORNw@mail.gmail.com>
 <CAAH8bW-+XnNsd9p3xZ1utmyY24gaBa0ko4tngBii4T+2cMkcYg@mail.gmail.com>
 <CAM7-yPQCWj6rOyLEgOqF3HGkFV1WKtqyVhEtDbS3HW=2A-HuBA@mail.gmail.com>
 <CAM7-yPTtiVnUztE=xpNYgRcZTGd1aX_V9ZHd=2YZYc1uQNBXtw@mail.gmail.com>
 <a0cc0d2e-9c55-8546-f070-26feed5de37f@rasmusvillemoes.dk> <CAM7-yPQrvYUwX-cbgpzhomCTFEi9sQ9iGuLNcL-Fsj7XZ0knhw@mail.gmail.com>
In-Reply-To: <CAM7-yPQrvYUwX-cbgpzhomCTFEi9sQ9iGuLNcL-Fsj7XZ0knhw@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 3 Dec 2020 10:46:25 -0800
Message-ID: <CAAH8bW9=J_now4SU=-WzvBOa=ftStgGVpspyw_g7oafbuNHNHQ@mail.gmail.com>
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

Yun, could you please stop top-posting and excessive trimming in the thread?

On Thu, Dec 3, 2020 at 1:47 AM Yun Levi <ppbuk5246@gmail.com> wrote:
> > Either just make the return type of all find_prev/find_last be signed
> > int and use -1 as the sentinel to indicate "no such position exists", so
> > the loop condition would be foo >= 0. Or, change the condition from
> > "stop if we get the size returned" to "only continue if we get something
> > strictly less than the size we passed in (i.e., something which can
> > possibly be a valid bit index). In the latter case, both (unsigned)-1
> > aka UINT_MAX and the actual size value passed work equally well as a
> > sentinel.
> >
> > If one uses UINT_MAX, a for_each_bit_reverse() macro would just be
> > something like
> >
> > for (i = find_last_bit(bitmap, size); i < size; i =
> > find_last_bit(bitmap, i))
> >
> > if one wants to use the size argument as the sentinel, the caller would
> > have to supply a scratch variable to keep track of the last i value:
> >
> > for (j = size, i = find_last_bit(bitmap, j); i < j; j = i, i =
> > find_last_bit(bitmap, j))
> >
> > which is probably a little less ergonomic.
> >
> > Rasmus

I would prefer to avoid changing the find*bit() semantics. As for now,
if any of find_*_bit()
finds nothing, it returns the size of the bitmap it was passed.
Changing this for
a single function would break the consistency, and may cause problems
for those who
rely on existing behaviour.

Passing non-positive size to find_*_bit() should produce undefined
behaviour, because we cannot dereference a pointer to the bitmap in
this case; this is most probably a sign of a problem on a caller side
anyways.

Let's keep this logic unchanged?

> Actually Because I want to avoid the modification of return type of
> find_last_*_bit for new sentinel,
> I add find_prev_*_bit.
> the big difference between find_last_bit and find_prev_bit is
>    find_last_bit doesn't check the size bit and use sentinel with size.
>    but find_prev_bit check the offset bit and use sentinel with size
> which passed by another argument.
>    So if we use find_prev_bit, we could have a clear iteration if
> using find_prev_bit like.
>
>   #define for_each_set_bit_reverse(bit, addr, size) \
>       for ((bit) = find_last_bit((addr), (size));    \
>             (bit) < (size);                                     \
>             (bit) = find_prev_bit((addr), (size), (bit - 1)))
>
>   #define for_each_set_bit_from_reverse(bit, addr, size) \
>       for ((bit) = find_prev_bit((addr), (size), (bit)); \
>              (bit) < (size);                                           \
>              (bit) = find_prev_bit((addr), (size), (bit - 1)))
>
> Though find_prev_*_bit / find_last_*_bit have the same functionality.
> But they also have a small difference.
> I think this small this small difference doesn't make some of
> confusion to user but it help to solve problem
> with a simple way (just like the iteration above).
>
> So I think I need, find_prev_*_bit series.
>
> Am I missing anything?
>
> Thanks.
>
> Levi.

As you said, find_last_bit() and proposed find_prev_*_bit() have the
same functionality.
If you really want to have find_prev_*_bit(), could you please at
least write it using find_last_bit(), otherwise it would be just a
blottering.

Regarding reverse search, we can probably do like this (not tested,
just an idea):

#define for_each_set_bit_reverse(bit, addr, size) \
    for ((bit) = find_last_bit((addr), (size));    \
          (bit) < (size);                                     \
          (size) = (bit), (bit) = find_last_bit((addr), (bit)))

Thanks,
Yury
