Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B81E1E8864
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 22:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2UC5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 16:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2UC5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 16:02:57 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09569C03E969;
        Fri, 29 May 2020 13:02:57 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y5so617917iob.12;
        Fri, 29 May 2020 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZtbTwAj0lIfYzvNENTLyBSfS0LJ0yCLNur1aeSmgfQ=;
        b=HxFIb0jCfOtSSdq6lyXoQx+BYeySUC6KpI7g63Ee6cm95kuwBW4oU//SZhuzFPi59W
         xGgHzOUzjgbHIRmxzK3WGgHANpkbfT+LQYvYEiNDCwYSxDu+7mcR9f2LoYcl+D8HRpCN
         sn5obL8xHSnnxVOv4ngQFKnKAbb23JH4A6aYLKo/wGXe0NIy3ouaqg+YMMasL+Z+xXx4
         rgCtlWwNvbUR9KnMTmbBzFLFVdSrpeWxMMcizo9hv5x23pfJ1rz/hZzBdzVPiiRgh1Sp
         YQkc+P8HSYzGnUhmLCl0KotLp2cW5yNtG6h9ddVy6+W3fDvF63i2068UReNWnm7kbLXP
         cBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZtbTwAj0lIfYzvNENTLyBSfS0LJ0yCLNur1aeSmgfQ=;
        b=m41KG/Ty89cLScNzUbGq+XUo6tlznJKclhtCZ05qLHStHBprdKPoiBBwfRt6z4Dl+R
         7tIuyOp7l7tXp4BlOq1NYr+R0c9kvyAwYbZ7Bpp4jRXvx+kkfBLqu30+swa1zhS14E6V
         rBlctMJSaCrvrRbaOwiwde4lp8YmIU4kIejzHNkAYgeqnZvxbyXvkzYT23tS6Pr3RKI0
         E664aYINaMYorvDY7uXPbYJe585Q21qnVv/LliT9aeFnGv8LC9c20tqdmtRz5YpO2oya
         ngkhjiOfhILk1NhP2fUb1aRH5DWCQRFTJQPb/lG12F0LoxlbHT16cgPrzuN50uxJi5po
         VRXg==
X-Gm-Message-State: AOAM5309z/uEuTXnsLJCttVpw2uK+byc8k1yqMcX1kP1DzyFUUQHaRG7
        UoneHwjLhvdJ2k76fgH15QttKiALq68cUeJaQOM=
X-Google-Smtp-Source: ABdhPJzyrSJO4Ra0iuDkgm4KVa4FRQM+r2An2zrayttiKnhr2ein+SbnCJRf7ncHZZEBXT1arFqv7wj5xzcq4X/54JQ=
X-Received: by 2002:a6b:bb81:: with SMTP id l123mr7946142iof.2.1590782576377;
 Fri, 29 May 2020 13:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com> <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com>
In-Reply-To: <20200529183824.GW1634618@smile.fi.intel.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sat, 30 May 2020 01:32:44 +0530
Message-ID: <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 30, 2020 at 12:08 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, May 29, 2020 at 11:38:18PM +0530, Syed Nayyar Waris wrote:
> > On Sun, May 24, 2020 at 8:15 PM kbuild test robot <lkp@intel.com> wrote:
>
> ...
>
> > >    579  static inline unsigned long bitmap_get_value(const unsigned long *map,
> > >    580                                                unsigned long start,
> > >    581                                                unsigned long nbits)
> > >    582  {
> > >    583          const size_t index = BIT_WORD(start);
> > >    584          const unsigned long offset = start % BITS_PER_LONG;
> > >    585          const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> > >    586          const unsigned long space = ceiling - start;
> > >    587          unsigned long value_low, value_high;
> > >    588
> > >    589          if (space >= nbits)
> > >  > 590                  return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > >    591          else {
> > >    592                  value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> > >    593                  value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> > >    594                  return (value_low >> offset) | (value_high << space);
> > >    595          }
> > >    596  }
>
> > Regarding the above compilation warnings. All the warnings are because
> > of GENMASK usage in my patch.
> > The warnings are coming because of sanity checks present for 'GENMASK'
> > macro in include/linux/bits.h.
> >
> > Taking the example statement (in my patch) where compilation warning
> > is getting reported:
> > return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> >
> > 'nbits' is of type 'unsigned long'.
> > In above, the sanity check is comparing '0' with unsigned value. And
> > unsigned value can't be less than '0' ever, hence the warning.
> > But this warning will occur whenever there will be '0' as one of the
> > 'argument' and an unsigned variable as another 'argument' for GENMASK.
> >
> > This warning is getting cleared if I cast the 'nbits' to 'long'.
> >
> > Let me know if I should submit a next patch with the casts applied.
> > What do you guys think?
>
> Proper fix is to fix GENMASK(), but allowed workaround is to use
>         (BIT(nbits) - 1)
> instead.
>
> --
> With Best Regards,
> Andy Shevchenko
>

Hi Andy. Thank You for your comment.

When I used BIT macro (earlier), I had faced a problem. I want to tell
you about that.

Inside functions 'bitmap_set_value' and 'bitmap_get_value' when nbits (or
clump size) is BITS_PER_LONG, unexpected calculation happens.

Explanation:
Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64 on my computer),
(BIT(nbits) - 1)
gives a value of zero and when this zero is ANDed with any value, it
makes it full zero. This is unexpected and incorrect calculation happening.

What actually happens is in the macro expansion of BIT(64), that is 1
<< 64, the '1' overflows from leftmost bit position (most significant
bit) and re-enters at the rightmost bit position (least significant
bit), therefore 1 << 64 becomes '0x1', and when another '1' is
subtracted from this, the final result becomes 0.

Since this macro is being used in both bitmap_get_value and
bitmap_set_value functions, it will give unexpected results when nbits or clump
size is BITS_PER_LONG (32 or 64 depending on arch).

William also knows about this issue:

"This is undefined behavior in the C standard (section 6.5.7 in the N1124)"

Andy, William,
Let me know what do you think ?

Regards
Syed Nayyar Waris
