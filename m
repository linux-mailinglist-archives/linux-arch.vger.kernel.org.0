Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA871379A65
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 00:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhEJWxM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 18:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhEJWxL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2021 18:53:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEC8C061574;
        Mon, 10 May 2021 15:52:05 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s25so22799458lji.0;
        Mon, 10 May 2021 15:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bzm3rypOxbJbMzyY1AHpqIfOJiBxIp+aKUWdKrOtWWU=;
        b=dtvTFeP4Sf0gmUydfxS1Y3xjVmufjX7xvHnw+aCzGk8r4enSUxOywZ89y70QquUKKU
         YTW7W2m0WirKsnT2Vw1Gdp1cjXRg5w5UO6VfTiyWfZFu0iYBnezJKI3KPQdzW4XQf9lR
         JknevdRb2fUIeePOPue2mZraoNiAd2q3cPSbBn4qMlLHzDEmN4p2tNVLxLRwZwDh/SL3
         dSqZ8qqu+awVHT1O3aImeMSQ14cZphHDz+r6ffmY42Pgk562gEAhMFMKaOf3dnZfum3N
         jUdMu7NlvLWm/47rv4893wsGYh+9VGYx1IvS69jv4jLFoeq37h+HZXyjUpLUWu37+Xub
         /59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bzm3rypOxbJbMzyY1AHpqIfOJiBxIp+aKUWdKrOtWWU=;
        b=PoNABuY57Ztk59tw3SLp63vzWQaQmiUCVie1PYAfTDf1zzGQ+liKOa7uDJpXJPL3kY
         HMkk7Ay5pt6IA97oHys7vWGHWdrzQSiKUWMAst4XVWaRzvxNMrYh2Slc1QdqB2NvvvqF
         PmVnIdLLNVR6scQIqRBJi4NgPOu37vaEp6DZNxpwueNDJwfu1wZeiq267TbsdvwSMD4B
         XE4MBrmcRx6rt7TtvojISxcj4G8qj7aimZmSmcXfZI51oBLacLfS2zKOpv4Xx2Z7a9xK
         U6iHdm4LKIp3gAR6rh10iIc9Qm7CnwZg94OjR5jmdTTPzdn1fBicvAx0rziaiFyVzI9z
         8HQg==
X-Gm-Message-State: AOAM530tK2qkU1nZrZ8GCtknnwjrrVl4/u/KW3bTA/bpg6da8HGU4OAE
        Ee6RhNNygPkxJji48NjcGPQ=
X-Google-Smtp-Source: ABdhPJzQ9GJvVFZ8paFOaIDFOOSrJkz+flU43OeyViz53iYoO62EmIGYT/iVEwk6MPQepf2hcnwuiQ==
X-Received: by 2002:a05:651c:2049:: with SMTP id t9mr13002236ljo.180.1620687123806;
        Mon, 10 May 2021 15:52:03 -0700 (PDT)
Received: from rikard (h-158-174-22-223.NA.cust.bahnhof.se. [158.174.22.223])
        by smtp.gmail.com with ESMTPSA id z11sm2395073lfr.73.2021.05.10.15.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 15:52:03 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Tue, 11 May 2021 00:51:58 +0200
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <YJm5Dpo+RspbAtye@rikard>
References: <20210401003153.97325-1-yury.norov@gmail.com>
 <20210401003153.97325-12-yury.norov@gmail.com>
 <1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp>
 <CAHp75Vea0Y_LfWC7LNDoDZqO4t+SVHV5HZMzErfyMPoBAjjk1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vea0Y_LfWC7LNDoDZqO4t+SVHV5HZMzErfyMPoBAjjk1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 10, 2021 at 06:44:44PM +0300, Andy Shevchenko wrote:
> +Cc: Rikard
> 
> On Mon, May 10, 2021 at 6:31 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > Commit eaae7841ba83bb42 ("tools: sync lib/find_bit implementation") broke
> > build of 5.13-rc1 using gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3).
> >
> >   DESCEND  objtool
> >   CC       /usr/src/linux/tools/objtool/exec-cmd.o
> >   CC       /usr/src/linux/tools/objtool/help.o
> >   CC       /usr/src/linux/tools/objtool/pager.o
> >   CC       /usr/src/linux/tools/objtool/parse-options.o
> >   CC       /usr/src/linux/tools/objtool/run-command.o
> >   CC       /usr/src/linux/tools/objtool/sigchain.o
> >   CC       /usr/src/linux/tools/objtool/subcmd-config.o
> >   LD       /usr/src/linux/tools/objtool/libsubcmd-in.o
> >   AR       /usr/src/linux/tools/objtool/libsubcmd.a
> >   CC       /usr/src/linux/tools/objtool/arch/x86/special.o
> > In file included from /usr/src/linux/tools/include/linux/kernel.h:8:0,
> >                  from /usr/src/linux/tools/include/linux/list.h:7,
> >                  from /usr/src/linux/tools/objtool/include/objtool/arch.h:10,
> >                  from /usr/src/linux/tools/objtool/include/objtool/check.h:11,
> >                  from /usr/src/linux/tools/objtool/include/objtool/special.h:10,
> >                  from arch/x86/special.c:4:
> > /usr/src/linux/tools/include/asm-generic/bitops/find.h: In function 'find_next_bit':
> > /usr/src/linux/tools/include/linux/bits.h:24:21: error: first argument to '__builtin_choose_expr' not a constant
> >   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> >                      ^
> > /usr/src/linux/tools/include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> >  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> >                                                               ^
> > /usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> >   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >    ^
> > /usr/src/linux/tools/include/asm-generic/bitops/find.h:32:17: note: in expansion of macro 'GENMASK'
> >    val = *addr & GENMASK(size - 1, offset);
> >                  ^
> > /usr/src/linux/tools/include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
> >  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> >                                                    ^
> > /usr/src/linux/tools/include/linux/bits.h:24:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
> >   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> >    ^
> > /usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> >   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >    ^
> > /usr/src/linux/tools/include/asm-generic/bitops/find.h:32:17: note: in expansion of macro 'GENMASK'
> >    val = *addr & GENMASK(size - 1, offset);
> >                  ^
> > /usr/src/linux/tools/include/asm-generic/bitops/find.h: In function 'find_next_and_bit':
> > /usr/src/linux/tools/include/linux/bits.h:24:21: error: first argument to '__builtin_choose_expr' not a constant
> >   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> >                      ^
> > /usr/src/linux/tools/include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> >  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> >                                                               ^
> > /usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> >   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >    ^
> > /usr/src/linux/tools/include/asm-generic/bitops/find.h:62:27: note: in expansion of macro 'GENMASK'
> >    val = *addr1 & *addr2 & GENMASK(size - 1, offset);
> >                            ^
> > /usr/src/linux/tools/include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
> >  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> >                                                    ^
> > /usr/src/linux/tools/include/linux/bits.h:24:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
> >   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> >    ^
> > /usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> >   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >    ^
> > /usr/src/linux/tools/include/asm-generic/bitops/find.h:62:27: note: in expansion of macro 'GENMASK'
> >    val = *addr1 & *addr2 & GENMASK(size - 1, offset);
> >                            ^
> > /usr/src/linux/tools/include/asm-generic/bitops/find.h: In function 'find_next_zero_bit':
> > /usr/src/linux/tools/include/linux/bits.h:24:21: error: first argument to '__builtin_choose_expr' not a constant
> >   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> >                      ^
> > /usr/src/linux/tools/include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> >  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> >                                                               ^
> > /usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> >   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >    ^
> > /usr/src/linux/tools/include/asm-generic/bitops/find.h:90:18: note: in expansion of macro 'GENMASK'
> >    val = *addr | ~GENMASK(size - 1, offset);
> >                   ^
> > /usr/src/linux/tools/include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
> >  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> >                                                    ^
> > /usr/src/linux/tools/include/linux/bits.h:24:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
> >   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> >    ^
> > /usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> >   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >    ^
> > /usr/src/linux/tools/include/asm-generic/bitops/find.h:90:18: note: in expansion of macro 'GENMASK'
> >    val = *addr | ~GENMASK(size - 1, offset);
> >                   ^
> > make[5]: *** [/usr/src/linux/tools/objtool/arch/x86/special.o] Error 1
> > make[4]: *** [arch/x86] Error 2
> > make[3]: *** [/usr/src/linux/tools/objtool/objtool-in.o] Error 2
> > make[2]: *** [objtool] Error 2
> > make[1]: *** [tools/objtool] Error 2
> > make: *** [__sub-make] Error 2
> >
> >

Some background: when I added the input check to GENMASK there was
originally a check that disabled the input check if gcc versions earlier
than 4.9, since for old compilers, there was a bug [1] where for some
constructs, __builtin_constant_p() did not evaluate to a constant. This
was supposedly fixed in gcc 4.9, but apparently there are newer gcc
versions which suffer from this too.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449

> >
> > Applying below diff seems to solve the build failure.
> 
> It will desynchronize this implementation with the mother's one (i.e.
> in bits.h).
> 
> > Do we need to use BUILD_BUG_ON_ZERO() here?
> 
> Rikard?

Yes, (as Yury pointed out), GENMASK is used in for example structure
initializers where  BUIlD_BUG() can not be used.
> 
> >
> > diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
> > index 7f475d59a097..0aba9294f29d 100644
> > --- a/tools/include/linux/bits.h
> > +++ b/tools/include/linux/bits.h
> > @@ -21,8 +21,7 @@
> >  #if !defined(__ASSEMBLY__)
> >  #include <linux/build_bug.h>
> >  #define GENMASK_INPUT_CHECK(h, l) \
> > -       (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > +       ({ BUILD_BUG_ON(__builtin_constant_p((l) > (h)) && ((l) > (h))); 0; })
> >  #else
> >  /*
> >   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,

Does the following work for you? For simplicity, I copied__is_constexpr from
include/linux/minmax.h (which isn't available in tools/). A proper patch
would reuse __is_constexpr (possibly refactoring it to a separate
header since bits.h including minmax.h for that only seems smelly) and fix
bits.h in the kernel header as well, to keep the files in sync.

diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 7f475d59a097..7bc4c31a7df0 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -19,10 +19,13 @@
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
 #if !defined(__ASSEMBLY__)
+
+#define __is_constexpr(x) \
+       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
 #include <linux/build_bug.h>
 #define GENMASK_INPUT_CHECK(h, l) \
        (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
+               __is_constexpr((l) > (h)), (l) > (h), 0)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,

I think any solution which results in using __GENMASK to avoid the input
check will just result in similar reports in the future.

Rikard

