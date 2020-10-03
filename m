Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82A428241F
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgJCMpV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 08:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgJCMpV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 08:45:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C461C0613E7;
        Sat,  3 Oct 2020 05:45:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q18so2742905pgk.7;
        Sat, 03 Oct 2020 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPoZS/C6bxcfITu/W+yIBJI+GExKu/BJ5DCw9Ls50r4=;
        b=Fky/HHJoRbBIb6hSzwlkyIXNL7wRqIl7nXw1j99ZAQJo/d5IjpZmT1jmzhMKvqIYXf
         zNptfg38oLZa65mz1ISGiO+/O9WIs+LhhBe4ZBTNjpCG1hwzPEsAE/AM00DDRoeqhwqz
         5aIAhBSCtm943JRa4fq9mWhYhA7++qM4Y5ahPXU/Ve8custwYQ7jm1kX66DOXZMuZzEO
         d5a2cxijtidLPw9hsiPyMFM0wQ8d2hEuS/h7j6FyqTLLLmnpB2z4LiwaBb6EWTkBKL9t
         I8/T4wlWLM9pUt4zLWP73bfxlXcgZOpcre6l6q/mEJsO2AKvCDmXrrryVPQIBGKL/7PU
         L2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPoZS/C6bxcfITu/W+yIBJI+GExKu/BJ5DCw9Ls50r4=;
        b=VAvO8pqEm9reTjK8H+adKLQcNP8Gzs+MxE7WvZmzl/2+ZB20CNgiU1+DRqzL7Typ6j
         9sJozyabp7OkHpvTVKtBHI6BZ5K9y0JASitoQTZ9uHtL/zO/bMZzc1BToDsxn0F1knbT
         OoqXMLa+HxJXrq5qXl6XqBxqpdLSzz2uJ1OlnvYdDDxlyv3SB9PEvjvAEzPnWF0jGssO
         ZMJqRGWKQ2dgbepd7oqwiZVXQm8VXos9xlVbbAIs9L44VpqrSVlMg9eURwV4bcn+3pqa
         OkGd5EeewVteuNOJ7zISnSqOellSQ6TTyNJb7Sd7QJQB2x9A4YuKf6LpCITw2Y5hHpRt
         gTqg==
X-Gm-Message-State: AOAM5308ssOFCl/4GwfdYVpCRR9RHCj7cIs1vkumH0ZZx8J9kmI2SHjt
        aFkm37D9kNHvUHImyyHxtsjzs/rt2zDq5CnwIas=
X-Google-Smtp-Source: ABdhPJzIxKZR2UU+ufct2lETww0w4/Ezm6PwYI6PH1GypeX7k4Z3cEMsmztf/b3qBzTIVyDWDy2P54D1PK1qmTuNyTo=
X-Received: by 2002:a05:6a00:8b:b029:14f:be90:a83a with SMTP id
 c11-20020a056a00008bb029014fbe90a83amr7523962pfj.70.1601729120721; Sat, 03
 Oct 2020 05:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601679791.git.syednwaris@gmail.com> <dcd0580812ebae079e6f5035b990b195ccc6b709.1601679791.git.syednwaris@gmail.com>
 <CAHp75VcoGAjrPa7rcORsaDXZLb-n+U3hG0k6O+weMVYweSPVxg@mail.gmail.com> <CACG_h5pianK4DRL5YeuSuN0gv6Jvcndc=_wLCL4QgmZyR=bOMw@mail.gmail.com>
In-Reply-To: <CACG_h5pianK4DRL5YeuSuN0gv6Jvcndc=_wLCL4QgmZyR=bOMw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 3 Oct 2020 15:45:04 +0300
Message-ID: <CAHp75VdC+eH0ScksdAVp==HnDMTMY3vVUZM5NZy6mfVSR0YoLA@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] bitops: Introduce the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 3, 2020 at 2:37 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> On Sat, Oct 3, 2020 at 2:14 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Oct 3, 2020 at 2:51 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

...

> > > +/**
> > > + * bitmap_get_value - get a value of n-bits from the memory region
> > > + * @map: address to the bitmap memory region
> > > + * @start: bit offset of the n-bit value
> > > + * @nbits: size of value in bits
> > > + *
> > > + * Returns value of nbits located at the @start bit offset within the @map
> > > + * memory region.
> > > + */

...

> > > +               return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> >
> > This is UB in GENMASK() when nbits == 0.
>
> 'nbits' actually specifies the width of clump value. Basically 'nbits'
> denotes how-many-bits wide the clump value is.
> 'nbits' having a value of '0' means zero-width-sized clump, meaning
> nothing. 'nbits' can take valid values from '1' to BITS_PER_LONG.
> The minimum value the 'nbits' can have is 1 because the smallest sized
> clump can be 1-bit-wide. It can't be smaller than that.
>
> Let me know if I have misunderstood something?

It's still possible to call with an nbits parameter be equal to 0.
If code is optimized to allow it, it should be documented that 0
parameter is not valid and behaviour is undefined.

...

> > > +/**
> > > + * bitmap_set_value - set n-bit value within a memory region
> > > + * @map: address to the bitmap memory region
> > > + * @value: value of nbits
> > > + * @start: bit offset of the n-bit value
> > > + * @nbits: size of value in bits
> > > + */

...

> > > +       value &= GENMASK(nbits - 1, 0);
> >
> > This is UB when nbits == 0.
>
> Same as above.
> 'nbits' actually specifies the width of clump value. Basically 'nbits'
> denotes how-many-bits wide the clump value is.
> 'nbits' having a value of '0' means zero-width-sized clump, meaning
> nothing. 'nbits' can take valid values from '1' to BITS_PER_LONG.
> The minimum value the 'nbits' can have is 1 because the smallest sized
> clump can be 1-bit-wide. It can't be smaller than that.

Same as above.

...

> > > +               map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> > > +               map[index] |= value << offset;

Side note: I would prefer + 0 here and there, but it's up to you.

> > > +               map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> > > +               map[index + 1] |= (value >> space);

By the way, what about this in the case of start=0, nbits > 64?
space == 64 -> UB.

(And btw parentheses are redundant here)

> > And another LKP finding was among these lines, but I don't remember the details.
>
> Yes you are right. There was sparse warning reported for this.
> sparse: shift too big (64) for type unsigned long
> The warning was reported in patch [4/4] referring to this patch [1/4].
>
> Later it was clarified by the sparse-check maintainer that this
> warning is to be ignored and no code fix is required.
>
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2202377.html

Ah, okay!
--
With Best Regards,
Andy Shevchenko
