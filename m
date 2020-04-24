Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE971B7896
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDXOwu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 10:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726753AbgDXOwu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 10:52:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30161C09B045;
        Fri, 24 Apr 2020 07:52:50 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id e9so10601727iok.9;
        Fri, 24 Apr 2020 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qwtXw6ySetrqaDrExlzhw4PufVEk1dV+eO14AinrDA=;
        b=A44ePyy72oHlX0WI69D+MZbZP1lLH77RshQHjp+7fT+KAw/6nRN+RtODdK3tLX+Gaf
         xXIRvKAM3/mXBRdBdfQmk4TrVvn2htz5tGOlCaSpk3ymchmDH7Eib856poJSTWXoqqz7
         mVL4uH5rFFToqlWvZ4xQedVUAp9nrDTjIGW8yG9tgkc6kBoy9MyuLulq8ttEciEujKdK
         QfTnjV6RMxw8PKAx1OCWSpOxUbtWgu5924bKGFxR5VNTHe3f2iW3MTueiAUXepO8mTmk
         z5DF1+G9rQlO/b9ajsdMtNAE5Fb3UsM4lt6YMzpZjWFymBLzF75FpYTIUTvTGK/Ze8VQ
         tDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qwtXw6ySetrqaDrExlzhw4PufVEk1dV+eO14AinrDA=;
        b=gzrB1Jv93ZtJupl6hy6QtnRGS9GhCDynnKgoaBXJJ3cVKFg5YaZabFzUv+qBJ95p/r
         xWhA4XfcHOM8tGZGUMeIhIyOCw6WWtV4rrXd85JXa9NXwK9D3UqoFrsRioqx9MRG9Hoy
         0iX2RHr2aFvsvd38h4k++sURtHdCW/fqJn+tCsYYjGoe/CAwv5FdbB39YsjvJ12aov65
         tq9jD0m47XHSgdArse9OGpSGOmnZT64qph3qHeLzfi75/jWpWe8U5IGipPzWMHnISNZt
         NH1IRdcpF919h7iB0/6vksSDCww5CaT06stamLv+oN8GTP0pbHITui5bHrqomLCzzFrP
         AhqA==
X-Gm-Message-State: AGi0PubFMiDRW/SsCCgMjf/IHv3ptJyqTaoru1LuwPw+XmmWx/XsVqoP
        KoLQjig3BfM/zB/hhrJNWlm/lHgv/INPLUmXlcg=
X-Google-Smtp-Source: APiQypI6Hmrqt4/++QwXB0qBw3R+G5sPxYU/OJbgd71hzaDUi0gYuVrFyxZYEJigKNPXsXxMBNa6eeSULYZZrVUQcOI=
X-Received: by 2002:a6b:6302:: with SMTP id p2mr9028610iog.153.1587739969586;
 Fri, 24 Apr 2020 07:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200424122521.GA5552@syed> <20200424141037.ersebbfe7xls37be@wunner.de>
In-Reply-To: <20200424141037.ersebbfe7xls37be@wunner.de>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 24 Apr 2020 20:22:38 +0530
Message-ID: <CACG_h5prcXVdk6ecn2WoT1jas3K6UF+KCrxAM9u4_ZLSyPKCEA@mail.gmail.com>
Subject: Re: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
To:     Lukas Wunner <lukas@wunner.de>
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        arnd@arndb.de, Linus Walleij <linus.walleij@linaro.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 24, 2020 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Fri, Apr 24, 2020 at 05:55:21PM +0530, Syed Nayyar Waris wrote:
> > +static inline void bitmap_set_value(unsigned long *map,
> > +                                 unsigned long value,
> > +                                 unsigned long start, unsigned long nbits)
> > +{
> > +     const size_t index = BIT_WORD(start);
> > +     const unsigned long offset = start % BITS_PER_LONG;
> > +     const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> > +     const unsigned long space = ceiling - start;
> > +
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
> Sorry but what's the advantage of using this complicated function
> as a replacement for the much simpler bitmap_set_value8()?
>
> The drivers calling bitmap_set_value8() *know* that 8-bit accesses
> are possible and take advantage of that knowledge by using a small,
> speed-optimized function.  Replacing that with a more complicated
> (potentially less performant) function doesn't seem to be a step
> forward.
>
> Thanks,
>
> Lukas

Actually this generic function can work with n-bits of any size (less
than equal to BITS_PER_LONG), while the earlier bitmap_set_value8
worked with n-bits having size of 8 bits only.

In the case when n-bits is 8-bits, this new bitmap_set_value()
function would behave very similar to the earlier bitmap_set_value8()
function. For example,  in case of n-bits being 8-bits it will always
execute the 'if' condition and not the 'else' condition, hence
offering the same performance (because of encountering similar code
statements) as earlier bitmap_set_value8() function, most probably.

There is an additional advantage (this can happen when n-bits is not 8
bits): during setting value of n-bit in bitmap, if a situation arise
that the width of next n-bit is exceeding the word boundary, then it
will divide itself such that some portion of it is stored in that
word, while the remaining portion is stored in the next higher word.

So, this function preserves the behaviour of earlier
bitmap_set_value8() function and also adds extra functionality to
that.

Thanks
Syed Nayyar Waris
