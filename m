Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E7437B029
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 22:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEKUjL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 16:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhEKUjK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 May 2021 16:39:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF38C061574;
        Tue, 11 May 2021 13:38:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z9so30503124lfu.8;
        Tue, 11 May 2021 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DK5tJmmDmMugyANGMz6uGMnaLAd2KYOdGC6b7FxAiPM=;
        b=DoPsmcM0KMuwfSZoXP7+nCQ7uK43uv743oLY70bnV1QUOvnfM4y5EHwQaKkPWi1VES
         SxtAnBgAZMdaJFYgPmdUQUv8TH4AiQXQHWo7O+/1Pfn4h5Up20uBgbaaacNWop3q5UKg
         Ylf/U1gg6eXP87OZsGStjMPh/9kY3JO4zR4/vJEa6/dQojwHrn7lzZlVGwzwYDlQgkdv
         Ni33StgwcAh/hZcDa3bWYvGxfZuXrmeNH1lpn5AmlIZkY+tk1Chiv/AgineevkA0s+Pr
         0rdE227eoKrvXDJklMEC2k8R6Iz8F0ruvSMz/4YKaWXxiijC5i7HPm3GEOkvup3N+NG6
         S15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DK5tJmmDmMugyANGMz6uGMnaLAd2KYOdGC6b7FxAiPM=;
        b=WWN8/FULwNE6vElDSyC4nCXF9Nk6hLVHDSv026HJYQYlx8IZ5ciaRYTHALGfcq7HcW
         FAyl7o0blcLU8ITKQfRCpMSeLNjfDXRL5uBNw/sMzLV0BmwDYnje+a2naRvS5yqsK3jn
         Y7b1ApMjJb45rp0KwpjIqisAb40SzoSQmMGXnfbyIcJhAMpBx17LifeG1t6xHwR9wOUt
         SL0ys2WUH8YtLTSfcmyVa6AVNJkzymDcZmmUxwsbFOBe64nwclAxgQlkW2YU/fB5ihMD
         kmEHgeuObrYfGgmpglh/jnS+df9uhKKX4dVklnfHjMeCoybJihZvxjD0UNnChm4CJcar
         kidQ==
X-Gm-Message-State: AOAM532RnyhZlyHsGAGIC2fdCEOHM3pmBKdP8ldiLKfokBAK6b+S7TpM
        Kx/+6xU6v9Wlihtf43rjgZs=
X-Google-Smtp-Source: ABdhPJxtflci7Mz+vugabPHlCz0Q0Gx5fwa6L+2OG/Z8QYy5+y8O3N6sL1J9naRsa6hASsDD5zduvA==
X-Received: by 2002:a05:6512:3e14:: with SMTP id i20mr21586920lfv.142.1620765481818;
        Tue, 11 May 2021 13:38:01 -0700 (PDT)
Received: from rikard (h-158-174-22-223.NA.cust.bahnhof.se. [158.174.22.223])
        by smtp.gmail.com with ESMTPSA id f24sm834191ljc.80.2021.05.11.13.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:38:01 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Tue, 11 May 2021 22:37:58 +0200
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 11/12] tools: sync lib/find_bit implementation
Message-ID: <YJrrJhvwq7RUvDXD@rikard>
References: <20210401003153.97325-1-yury.norov@gmail.com>
 <20210401003153.97325-12-yury.norov@gmail.com>
 <1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp>
 <CAHp75Vea0Y_LfWC7LNDoDZqO4t+SVHV5HZMzErfyMPoBAjjk1g@mail.gmail.com>
 <YJm5Dpo+RspbAtye@rikard>
 <YJoyMrqRtB3GSAny@smile.fi.intel.com>
 <YJpePAHS3EDw6PK1@rikard>
 <151de51e-9302-1f59-407a-e0d68bbaf11c@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151de51e-9302-1f59-407a-e0d68bbaf11c@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 11, 2021 at 08:53:53PM +0900, Tetsuo Handa wrote:
> On 2021/05/11 0:44, Andy Shevchenko wrote:
> > And I'm a bit lost here, because I can't imagine the offset being
> > constant along with a size of bitmap. What do we want to achieve by
> > this? Any examples to better understand the case?
> 
> Because I feel that the GENMASK() macro cannot be evaluated without
> both arguments being a constant.
> 
> The usage is
> 
>  unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
>                             unsigned long offset)
>  {
> +       if (small_const_nbits(size)) {
> +               unsigned long val;
> +
> +               if (unlikely(offset >= size))
> +                       return size;
> +
> +               val = *addr & GENMASK(size - 1, offset);
> +               return val ? __ffs(val) : size;
> +       }
> +
>         return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
>  }
> 
> where GENMASK() might be called even if "offset" is not a constant.
> 
> #define GENMASK(h, l) \
>      (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> 
> #define __GENMASK(h, l) \
>      (((~UL(0)) - (UL(1) << (l)) + 1) & \
>        (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> 
> #define GENMASK_INPUT_CHECK(h, l) \
>      (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>           __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> 
> __GENMASK() does not need "h" and "l" being a constant.
> 
> Yes, small_const_nbits(size) in find_next_bit() can guarantee that "size" is a
> constant and hence "h" argument in GENMASK_INPUT_CHECK() call is also a constant.
> But nothing can guarantee that "offset" is a constant, and hence nothing can
> guarantee that "l" argument in GENMASK_INPUT_CHECK() call is also a constant.
> 
> Then, how can (l) > (h) in __builtin_constant_p((l) > (h)) be evaluated at build time
> if either l or h (i.e. "offset" and "size - 1" in find_next_bit()) lacks a guarantee of
> being a constant?
> 

So the idea is that if (l > h) is constant, __builtin_constant_p should
evaluate that, and if it is not it should use zero instead as input to
__builtin_chose_expr(). This works with non-const inputs in many other
places in the kernel, but apparently in this case with a certain
compiler, it doesn't so I guess we need to work around it.

> But what a surprise,
> 
> On 2021/05/11 7:51, Rikard Falkeborn wrote:
> > Does the following work for you? For simplicity, I copied__is_constexpr from
> > include/linux/minmax.h (which isn't available in tools/). A proper patch
> > would reuse __is_constexpr (possibly refactoring it to a separate
> > header since bits.h including minmax.h for that only seems smelly) and fix
> > bits.h in the kernel header as well, to keep the files in sync.
> 
> this works for me.
> 

Great, thanks for testing!

I sent a patch for this here:
https://lore.kernel.org/lkml/20210511203716.117010-1-rikard.falkeborn@gmail.com/

Rikard

> > 
> > diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
> > index 7f475d59a097..7bc4c31a7df0 100644
> > --- a/tools/include/linux/bits.h
> > +++ b/tools/include/linux/bits.h
> > @@ -19,10 +19,13 @@
> >   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> >   */
> >  #if !defined(__ASSEMBLY__)
> > +
> > +#define __is_constexpr(x) \
> > +       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> >  #include <linux/build_bug.h>
> >  #define GENMASK_INPUT_CHECK(h, l) \
> >         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > +               __is_constexpr((l) > (h)), (l) > (h), 0)))
> >  #else
> >  /*
> >   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> > 
> 
> 
> 
> On 2021/05/11 7:52, Yury Norov wrote:
> > I tested the objtool build with the 8.4.0 and 7.5.0 compilers from
> > ubuntu 21 distro, and it looks working. Can you please share more
> > details about your system? 
> 
> Nothing special. A plain x86_64 CentOS 7.9 system with devtoolset-8.
> 
> $ /opt/rh/devtoolset-8/root/bin/gcc --version
> gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3)
> Copyright (C) 2018 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> $ rpm -qi devtoolset-8-gcc
> Name        : devtoolset-8-gcc
> Version     : 8.3.1
> Release     : 3.2.el7
> Architecture: x86_64
> Install Date: Wed Apr 22 07:58:16 2020
> Group       : Development/Languages
> Size        : 74838011
> License     : GPLv3+ and GPLv3+ with exceptions and GPLv2+ with exceptions and LGPLv2+ and BSD
> Signature   : RSA/SHA1, Thu Apr 16 19:44:43 2020, Key ID 4eb84e71f2ee9d55
> Source RPM  : devtoolset-8-gcc-8.3.1-3.2.el7.src.rpm
> Build Date  : Sat Mar 28 00:06:45 2020
> Build Host  : c1be.rdu2.centos.org
> Relocations : (not relocatable)
> Packager    : CBS <cbs@centos.org>
> Vendor      : CentOS
> URL         : http://gcc.gnu.org
> Summary     : GCC version 8
> Description :
> The devtoolset-8-gcc package contains the GNU Compiler Collection version 7.
> 
