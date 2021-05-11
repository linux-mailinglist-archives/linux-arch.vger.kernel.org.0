Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E07137A61D
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 13:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhEKL4R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 07:56:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57102 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhEKL4R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 May 2021 07:56:17 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 14BBrwGp025007;
        Tue, 11 May 2021 20:53:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Tue, 11 May 2021 20:53:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 14BBrvka024961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 May 2021 20:53:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 11/12] tools: sync lib/find_bit implementation
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
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
References: <20210401003153.97325-1-yury.norov@gmail.com>
 <20210401003153.97325-12-yury.norov@gmail.com>
 <1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp>
 <CAHp75Vea0Y_LfWC7LNDoDZqO4t+SVHV5HZMzErfyMPoBAjjk1g@mail.gmail.com>
 <YJm5Dpo+RspbAtye@rikard> <YJoyMrqRtB3GSAny@smile.fi.intel.com>
 <YJpePAHS3EDw6PK1@rikard>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <151de51e-9302-1f59-407a-e0d68bbaf11c@i-love.sakura.ne.jp>
Date:   Tue, 11 May 2021 20:53:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJpePAHS3EDw6PK1@rikard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021/05/11 0:44, Andy Shevchenko wrote:
> And I'm a bit lost here, because I can't imagine the offset being
> constant along with a size of bitmap. What do we want to achieve by
> this? Any examples to better understand the case?

Because I feel that the GENMASK() macro cannot be evaluated without
both arguments being a constant.

The usage is

 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
                            unsigned long offset)
 {
+       if (small_const_nbits(size)) {
+               unsigned long val;
+
+               if (unlikely(offset >= size))
+                       return size;
+
+               val = *addr & GENMASK(size - 1, offset);
+               return val ? __ffs(val) : size;
+       }
+
        return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
 }

where GENMASK() might be called even if "offset" is not a constant.

#define GENMASK(h, l) \
     (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))

#define __GENMASK(h, l) \
     (((~UL(0)) - (UL(1) << (l)) + 1) & \
       (~UL(0) >> (BITS_PER_LONG - 1 - (h))))

#define GENMASK_INPUT_CHECK(h, l) \
     (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
          __builtin_constant_p((l) > (h)), (l) > (h), 0)))

__GENMASK() does not need "h" and "l" being a constant.

Yes, small_const_nbits(size) in find_next_bit() can guarantee that "size" is a
constant and hence "h" argument in GENMASK_INPUT_CHECK() call is also a constant.
But nothing can guarantee that "offset" is a constant, and hence nothing can
guarantee that "l" argument in GENMASK_INPUT_CHECK() call is also a constant.

Then, how can (l) > (h) in __builtin_constant_p((l) > (h)) be evaluated at build time
if either l or h (i.e. "offset" and "size - 1" in find_next_bit()) lacks a guarantee of
being a constant?

But what a surprise,

On 2021/05/11 7:51, Rikard Falkeborn wrote:
> Does the following work for you? For simplicity, I copied__is_constexpr from
> include/linux/minmax.h (which isn't available in tools/). A proper patch
> would reuse __is_constexpr (possibly refactoring it to a separate
> header since bits.h including minmax.h for that only seems smelly) and fix
> bits.h in the kernel header as well, to keep the files in sync.

this works for me.

> 
> diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
> index 7f475d59a097..7bc4c31a7df0 100644
> --- a/tools/include/linux/bits.h
> +++ b/tools/include/linux/bits.h
> @@ -19,10 +19,13 @@
>   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
>   */
>  #if !defined(__ASSEMBLY__)
> +
> +#define __is_constexpr(x) \
> +       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
>  #include <linux/build_bug.h>
>  #define GENMASK_INPUT_CHECK(h, l) \
>         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> +               __is_constexpr((l) > (h)), (l) > (h), 0)))
>  #else
>  /*
>   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> 



On 2021/05/11 7:52, Yury Norov wrote:
> I tested the objtool build with the 8.4.0 and 7.5.0 compilers from
> ubuntu 21 distro, and it looks working. Can you please share more
> details about your system? 

Nothing special. A plain x86_64 CentOS 7.9 system with devtoolset-8.

$ /opt/rh/devtoolset-8/root/bin/gcc --version
gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3)
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ rpm -qi devtoolset-8-gcc
Name        : devtoolset-8-gcc
Version     : 8.3.1
Release     : 3.2.el7
Architecture: x86_64
Install Date: Wed Apr 22 07:58:16 2020
Group       : Development/Languages
Size        : 74838011
License     : GPLv3+ and GPLv3+ with exceptions and GPLv2+ with exceptions and LGPLv2+ and BSD
Signature   : RSA/SHA1, Thu Apr 16 19:44:43 2020, Key ID 4eb84e71f2ee9d55
Source RPM  : devtoolset-8-gcc-8.3.1-3.2.el7.src.rpm
Build Date  : Sat Mar 28 00:06:45 2020
Build Host  : c1be.rdu2.centos.org
Relocations : (not relocatable)
Packager    : CBS <cbs@centos.org>
Vendor      : CentOS
URL         : http://gcc.gnu.org
Summary     : GCC version 8
Description :
The devtoolset-8-gcc package contains the GNU Compiler Collection version 7.

