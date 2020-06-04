Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8758A1EDD53
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jun 2020 08:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgFDGlr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Jun 2020 02:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgFDGlr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2020 02:41:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C97C05BD1E;
        Wed,  3 Jun 2020 23:41:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ga6so729188pjb.1;
        Wed, 03 Jun 2020 23:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XfO8TQWsKbgmttZdJsjsbuG8/l2FKfNiqjpmWnGFt2Y=;
        b=ls8yGKOxOkkDTayRMXM+oAYVPWdSU+KsHEMMWQG7GchBHiYWmwOShVp55XnM/huqpx
         YIsXxFj5wxi5PMQuTQd90JSBUsb8uHo6PTpSP3UVxm1tib6nHCbcZmgz107ryl9f9noy
         8T1MDdcqS0IKWe+ZFKqQ99GdVxr2u/L874472ams2Y4LnQXud4x4ifDxHZ/lCWkaNKL8
         GWvH1/fyUJxAtaeKVLpAm5lBSoremXuatNTEer1xX6Xd2yzlVIHaEYLJ95oCk/FqZp8x
         C1914CD+qMmUaX1Yq3Nzx7/+2AOEuqRyFV6iw8T84BH0zG8wirCgNrfC37o/3uKHFVZ2
         U7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfO8TQWsKbgmttZdJsjsbuG8/l2FKfNiqjpmWnGFt2Y=;
        b=hErNa7az4MV2C7JMLj/9P2+6hsLPRVhwVytvRNM1Hgsm1jJUjwsLsDTtKVqV+H65Ce
         13Wm+MX28onyYxB/LVnIz+/u+G/e3n4hzmuOHlOY2l4dgKFbiRPlDErgC6Ck0HfHXfWV
         SB4pYJdgvUefIcq6ZOzG/qzA7vSJc1m6eqnyYC+duow/WCG9XdzLpdYYmSnk+LvLcKXd
         d0K+MhXpu+Ih2cMh59HBn9aThRmWYQHYK1b7191vUOydoiO6BG2HXUhV8z+ARBJ9q1VD
         LGCRKyMiiwfscsigVIuJ69j7ynNA9I1tHSVTWZTplHWeiaMnahZO8y6nSqU94z7EW/qz
         9srg==
X-Gm-Message-State: AOAM531sRLvlyMaGCgYDdYNFR/ZbF0itz3XZ0n1aH/B6VK+RhblRPKjo
        k0orPg+Wh/EEz21CD1HzcBOepopLWqRr6qCr/rwukWUBjKM=
X-Google-Smtp-Source: ABdhPJx/7dpfk4vPbg8kFRwS1O9JuGLzOAhpwDM90TbH+B132fWjwdrXCZmiGFuthJ3QNJt40m945hGb54FhxeP+0lo=
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr4367943pje.129.1591252906576;
 Wed, 03 Jun 2020 23:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200603215314.GA916134@rikard> <20200603220226.916269-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200603220226.916269-1-rikard.falkeborn@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Jun 2020 09:41:29 +0300
Message-ID: <CAHp75VcNVOF6jHZ7gtpqskg9rDgwt3MmtGZJJOXE-GwvXRPOhw@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix unsigned less than zero warnings
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, emil.l.velikov@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 4, 2020 at 1:03 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> When calling the GENMASK and GENMASK_ULL macros with zero lower bit and
> an unsigned unknown high bit, some gcc versions warn due to the
> comparisons of the high and low bit in GENMASK_INPUT_CHECK.
>
> To silence the warnings, cast the inputs to int before doing the
> comparisons. The only valid inputs to GENMASK() and GENMASK_ULL() are
> are 0 to 31 or 63. Anything outside this is undefined due to the shifts
> in GENMASK()/GENMASK_ULL(). Therefore, casting the inputs to int do not
> change the values for valid known inputs. For unknown values, the check
> does not change anything since it's a compile-time check only.
>
> As an example of the warning, kindly reported by the kbuild test robot:
>
> from drivers/mfd/atmel-smc.c:11:
> drivers/mfd/atmel-smc.c: In function 'atmel_smc_cs_encode_ncycles':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> |                            ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> 16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> |                                                              ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> 39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> |   ^~~~~~~~~~~~~~~~~~~
> >> drivers/mfd/atmel-smc.c:49:25: note: in expansion of macro 'GENMASK'
> 49 |  unsigned int lsbmask = GENMASK(msbpos - 1, 0);
> |                         ^~~~~~~
>

Thank you for the patch!

I think there is still a possibility to improve (as I mentioned there
are test cases that are absent right now).
What if we will have unsigned long value 0x100000001? Would it be 1
after casting?

Maybe cast to (long) or (long long) more appropriate?

Please, add test cases.

> Fixes: 295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
> Reported-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  include/linux/bits.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 4671fbf28842..293d1ee71a48 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -21,9 +21,10 @@
>  #if !defined(__ASSEMBLY__) && \
>         (!defined(CONFIG_CC_IS_GCC) || CONFIG_GCC_VERSION >= 49000)
>  #include <linux/build_bug.h>
> +/* Avoid Wtype-limits warnings by casting the inputs to int */
>  #define GENMASK_INPUT_CHECK(h, l) \
>         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> +               __builtin_constant_p((int)(l) > (int)(h)), (int)(l) > (int)(h), 0)))
>  #else
>  /*
>   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
