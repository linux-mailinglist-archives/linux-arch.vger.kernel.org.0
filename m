Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245822CCA6C
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 00:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgLBXRK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 18:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbgLBXRJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 18:17:09 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B94DC0617A6;
        Wed,  2 Dec 2020 15:16:29 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id i2so5884947wrs.4;
        Wed, 02 Dec 2020 15:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MB3FdpRELFWiz8q8bY0RBSJbKRTsMS1clEeRrf7bS9Q=;
        b=iD5OSnKX1fSJz6wfL58VdGDRx67hBdluAh0i0fOjNb0+Z4R6Ew3N58SVawo735wgYC
         5C8i0u/6/w+odTPFD7pOmhl8FX1jiUK9WuL4epY2n6DhOfs7h5PwIbLe+rJulz+9Fxqh
         aiUqniQiODlz5n1Xy3xt5O1qUifOLMlozAP6KpifQy4EGQwPoMdsw02pOEHKrTWZ8WR1
         zXCiGXlZ/vLekLua4cNjQZt2oVfhRykjbnvYu/CPhFh5EgieOS/itUVYaZ9IXXNG7CJj
         LToGqi+62bgJBEj3mB2D0o6zVOGhTPrjX0P5l3v5vV21u9G41iZjN9i56jD+juRjVfUe
         eSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MB3FdpRELFWiz8q8bY0RBSJbKRTsMS1clEeRrf7bS9Q=;
        b=RnFZEtUYeI2Sz4/Jjg3MZ/lt1WjZ4XS5s4t0lyUA7bxtKxdDla9FJhSBgAnLaaETFC
         SpIzxEIctkVZFZ4EDLNvIkPA9k/mBpA/7L5342dzdZbsUAk9lvLf8KpdrD38ax9m6HFw
         Bb7KBGSDQbLysbqgLWee7TlqyGuQHOL+kq7EHtGWsFEeeItKom3f58qNEMykLiZ0NWJL
         Ngxbzvf5rp1STN0bRRlR+mrG5w7rD3sENRcwhXriW8YPN1G3/pc8iqdH65odFlz9mwnm
         6jExApN0zWM/fHg+yBczg2odLEIjmzu1svWsHddX4tAfgC6AVkRIfi1+LAVyQjAEAu/l
         QsfA==
X-Gm-Message-State: AOAM531KFbXDo/KlngKyG0OKsTLJF4JwF0bhCC5qgMC+0ljPCQGdIqke
        vj+pp3WLGWNdXgQ/UqPSqYjewlVfvioe2QULEIA=
X-Google-Smtp-Source: ABdhPJwgVgOsBXqXmqTU695QWXsGhe/ppPXKWz5ZbuUFkQoZkTl3k+PQ28qFQfaSCIJPpjHubbITwzHqMfF2C/oegy8=
X-Received: by 2002:adf:f602:: with SMTP id t2mr475526wrp.40.1606950987817;
 Wed, 02 Dec 2020 15:16:27 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com> <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
 <20201202173701.GM4077@smile.fi.intel.com> <CAM7-yPSWvsySweXSmbvW2hucce8T7BOSkz-eF5t7PJE6zv5tjg@mail.gmail.com>
 <20201202185127.GO4077@smile.fi.intel.com> <20201202185631.GQ4077@smile.fi.intel.com>
In-Reply-To: <20201202185631.GQ4077@smile.fi.intel.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 3 Dec 2020 08:16:16 +0900
Message-ID: <CAM7-yPQfzyOAyjyeFp2cMDXMrk292_AN6+6ZvahugS_h387SyA@mail.gmail.com>
Subject: 
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, dushistov@mail.ru,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 3, 2020 at 3:55 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Dec 02, 2020 at 08:51:27PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 03, 2020 at 03:27:33AM +0900, Yun Levi wrote:
> > > On Thu, Dec 3, 2020 at 2:36 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Dec 02, 2020 at 09:26:05AM -0800, Yury Norov wrote:
>
> ...
>
> > > > Side note: speaking of performance, any plans to fix for_each_*_bit*() for
> > > > cases when the nbits is known to be <= BITS_PER_LONG?
> > > >
> > > > Now it makes an awful code generation (something like few hundred bytes of
> > > > code).
> >
> > > Frankly Speaking, I don't have an idea in now.....
> > > Could you share your idea or wisdom?
> >
> > Something like (I may be mistaken by names, etc, I'm not a compiler expert,
> > and this is in pseudo language, I don't remember all API names by hart,
> > just to express the idea) as a rough first step
> >
> > __builtin_constant(nbits, find_next_set_bit_long, find_next_set_bit)
> >
> > find_next_set_bit_long()
> > {
> >       unsigned long v = BIT_LAST_WORD(i);
> >       return ffs_long(v);
> > }
> >

I think this idea is hard to apply to find_next_set_bit.
because __builtin_constant should be not only to size but also to offset.
though we find size && offset is const under BITS_PER_LONG,
I'm not sure it could be implemented as const expression..

> > Same for find_first_set_bit() -> map it to ffs_long().
> >
> > And I believe it can be optimized more.

In case of the find_first_set_bit, I think it would be possible,
But I think it much better to separate as another patch set.
So I want to focus on adding find_prev_*_bit, find_last_zero_bit to
this patchset and mail-thread. Frankly speaking I need time to see
that suggestion and think so, in next patch v2,
it wouldn't be included.

>
> Btw it will also require to reconsider test cases where such constant small
> nbits values are passed (forcing compiler to avoid optimization somehow, one
> way is to try random nbits for some test cases).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


if my understanding and attitude are wrong, I really apologize for my
rudeness and stubbornness but please let me know what thing is wrong.

Sincerely
Levi.
