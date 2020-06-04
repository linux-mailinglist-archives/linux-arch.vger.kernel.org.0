Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA481EEE3F
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jun 2020 01:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgFDXaN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Jun 2020 19:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFDXaN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2020 19:30:13 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8579C08C5C0;
        Thu,  4 Jun 2020 16:30:11 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d7so4648014lfi.12;
        Thu, 04 Jun 2020 16:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I0vuUFn5lxY4ZF0l56Dcb/jEGjNG4DbmwhvxyyMPgFw=;
        b=Kg8aticP3IKjVpca+ZUnaFUbo1XmSje5MTgMHLbA175Z7Vj6zao07yhWOZMaW8iwu2
         INL0uum1R/xTH/dFMjQDQfdDCJa7Ntnr8epduST0J8mzbwRNX22ZN+Dtu1N3qwFyDAB3
         ot3F0fLUQMMz3Oqj801DbZ7zWzcdd3V9gX0+teie4SbyymgARBA2M8IiJX8JHWZh0ET0
         Vzo4CKoLeVoZJVpY2BvFsVnOMFk48W7pSzn/oAAA7dB3pKzP8kOAxetkgeHZjLCROa+j
         kDzx0GTpONQY9aZnoaVkylf7RbnODasp4SoM3SQ0MuVbDuMGSeMF7+xWFyzouMEiWX2a
         b2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I0vuUFn5lxY4ZF0l56Dcb/jEGjNG4DbmwhvxyyMPgFw=;
        b=JKcOVbxNB2EbOdlKh3WfLhVpLyYu1XjAia1zHB6PTz+DqyqskWeteYmBgCrHcMndR6
         gKAgIXwT8c8F1TKGBM3iNeh/X5+11SjNSkr2FmHLAoCmGCyIWoSanHG5N/0mReIGwLgN
         3OP8jCzxd0EDUvHeQDijdAjU4R+82NmtzTmBJHWc2nOymECIFlQJaXAfsAQfseIdbAjY
         RUkZyZLcL8tuPnAHxZZkWYa/lgQRLlQa1Ksw+RC2QDJZxUxrYwKTRlTc4nVg0+jEJET5
         6pEq4U/1SUdlhColm8n8kUQq9jzDd1Ct8gtXhswMyjnWQv3ji5MaF0x2pXSianpKBj23
         2s5Q==
X-Gm-Message-State: AOAM531R/i64Nl4gvQrRCCOJ4NvCwsk6rF+KCkkivKrnYec4ry0ddb+g
        K0l4fyGGa0zakW8i8eYFuHo=
X-Google-Smtp-Source: ABdhPJxH/js4G33ereVaiRIUVNQRv6Ll062i1P+wVJpPeK3xc6TcdwhSz3K8iXeQngKTe+Q31wII0g==
X-Received: by 2002:a19:c3d5:: with SMTP id t204mr3759447lff.50.1591313410394;
        Thu, 04 Jun 2020 16:30:10 -0700 (PDT)
Received: from rikard (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id v5sm26129lji.73.2020.06.04.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 16:30:09 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Fri, 5 Jun 2020 01:30:03 +0200
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, emil.l.velikov@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] linux/bits.h: fix unsigned less than zero warnings
Message-ID: <20200604233003.GA102768@rikard>
References: <20200603215314.GA916134@rikard>
 <20200603220226.916269-1-rikard.falkeborn@gmail.com>
 <CAHp75VcNVOF6jHZ7gtpqskg9rDgwt3MmtGZJJOXE-GwvXRPOhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcNVOF6jHZ7gtpqskg9rDgwt3MmtGZJJOXE-GwvXRPOhw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 04, 2020 at 09:41:29AM +0300, Andy Shevchenko wrote:
> On Thu, Jun 4, 2020 at 1:03 AM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> >
> > When calling the GENMASK and GENMASK_ULL macros with zero lower bit and
> > an unsigned unknown high bit, some gcc versions warn due to the
> > comparisons of the high and low bit in GENMASK_INPUT_CHECK.
> >
> > To silence the warnings, cast the inputs to int before doing the
> > comparisons. The only valid inputs to GENMASK() and GENMASK_ULL() are
> > are 0 to 31 or 63. Anything outside this is undefined due to the shifts
> > in GENMASK()/GENMASK_ULL(). Therefore, casting the inputs to int do not
> > change the values for valid known inputs. For unknown values, the check
> > does not change anything since it's a compile-time check only.
> >
> > As an example of the warning, kindly reported by the kbuild test robot:
> >
> > from drivers/mfd/atmel-smc.c:11:
> > drivers/mfd/atmel-smc.c: In function 'atmel_smc_cs_encode_ncycles':
> > include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> > 26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > |                            ^
> > include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> > 16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> > |                                                              ^
> > include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> > 39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > |   ^~~~~~~~~~~~~~~~~~~
> > >> drivers/mfd/atmel-smc.c:49:25: note: in expansion of macro 'GENMASK'
> > 49 |  unsigned int lsbmask = GENMASK(msbpos - 1, 0);
> > |                         ^~~~~~~
> >
> 
> Thank you for the patch!
> 
> I think there is still a possibility to improve (as I mentioned there
> are test cases that are absent right now).
> What if we will have unsigned long value 0x100000001? Would it be 1
> after casting?
> 
> Maybe cast to (long) or (long long) more appropriate?

It you're entering 0x10000001 you're going to get a compiler warning
since it's going to be shifted out of range, when I wrote the check I
figured that should be enough, but perhaps I was wrong?

How about requiring both l and h bit to be constant? (that's
arguably the way I should have written in the first place). That's going
to remove the warnings for GENMASK(x, 0). It will not work as expected
when mixing negative and unsigned input, like GENMASK(-1, 0u) is not
going to fail the build while GENMASK(1u, -1) will. For GENMASK(-1, 0u),
you will get a compiler warning due to the shifts in GENMASK.

If we need to handle the negative inputs as well. I think I'd prefer to add
explicit checks for negative values over the casting. A macro for that
can probably be reused in other places as well.

> 
> Please, add test cases.

Will do.

Rikard
> 
> > Fixes: 295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
> > Reported-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> >  include/linux/bits.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index 4671fbf28842..293d1ee71a48 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -21,9 +21,10 @@
> >  #if !defined(__ASSEMBLY__) && \
> >         (!defined(CONFIG_CC_IS_GCC) || CONFIG_GCC_VERSION >= 49000)
> >  #include <linux/build_bug.h>
> > +/* Avoid Wtype-limits warnings by casting the inputs to int */
> >  #define GENMASK_INPUT_CHECK(h, l) \
> >         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > +               __builtin_constant_p((int)(l) > (int)(h)), (int)(l) > (int)(h), 0)))
> >  #else
> >  /*
> >   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> > --
> > 2.27.0
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
