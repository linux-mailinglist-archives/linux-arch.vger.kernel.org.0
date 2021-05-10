Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA513792F3
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 17:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhEJPqJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhEJPqI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2021 11:46:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2BCC06175F;
        Mon, 10 May 2021 08:45:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so10573159pjv.1;
        Mon, 10 May 2021 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4dcw8IGzv/GIfxvaD9q7KQZLmedoHiUzVJW5atnpXBg=;
        b=nPs4W8LZvy7H1c1ol6+nIU0v1NK1GwdRtI5sI2Eww6SRRjskfQQ3roy4UdV6pmryis
         HyEeFGawJ7iCo74Hbd7Ed4rWgNf5fWYUI0sHwp0MVtMyRAmHzrhB2xgjfzi777OBuzHh
         L95FIpl6ywmPiBnQM9b3cIwQesUir40ix4F7BrAsVEIQgyeaXsKtBAeHLW11S8XgeHzI
         On7UduuyJFKfreRgiLWGAnVjUAG1g0OEcjSmYsFjNS2/NZDfeclI8taqt1ncKxFbFTks
         V3QSY2KO2ZjZaJp2E7h9dtoSd1EW159Pr2VOEeYJ0hcFPuBgj6r1wZd50Q4XOQNGn1Te
         QNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4dcw8IGzv/GIfxvaD9q7KQZLmedoHiUzVJW5atnpXBg=;
        b=Jq54kQGW0Opy29pvIDnEemAaOMEev9JI5LwDQYT3LrcZsEtZcAfYM8cfuet9p/qCjT
         pQvtNPsms2NEHFthsr/jJa3i+lbDoNUYRvqfDXPuPUFXwVKz0yGxl+gFBfoL/FWUW4WF
         /a2u6AfGAL19FGXZPCZzd75R8dW9gvBwrBD7SPCoxKeucjL2/kiYTNj8w0Tjtni3QXTK
         0W2qmH3nk0AnB9QMTMPZuqo70SDDyjXdD3fvBzNvoFmPsThstSBKVNPl507ndYfhC0Gj
         0OvypV31HVuvkHPVfoRyDPIgR1Wo7uXn47vS0P5DjwQh+5Itxl9ByDmIjSXy/c7AmEEz
         nVTg==
X-Gm-Message-State: AOAM533uo8NLaZCrXUA3hes2hTAn5fltMA6+Eu4+mQf+aFNYGIPZRHhW
        f5Gl4FaO1JJBy9QKztzNDZqz91DRHNaIL8z2ZY4=
X-Google-Smtp-Source: ABdhPJwhhCRYPu5m51KljGuXju/lpu/xcv2ZqfhrAqz5iT9glp8u2ivS+wCAIZ4uGX2ldJc+RAkx1237wDVfSUDR1WU=
X-Received: by 2002:a17:90a:d90c:: with SMTP id c12mr42762364pjv.129.1620661501281;
 Mon, 10 May 2021 08:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210401003153.97325-1-yury.norov@gmail.com> <20210401003153.97325-12-yury.norov@gmail.com>
 <1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp>
In-Reply-To: <1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 May 2021 18:44:44 +0300
Message-ID: <CAHp75Vea0Y_LfWC7LNDoDZqO4t+SVHV5HZMzErfyMPoBAjjk1g@mail.gmail.com>
Subject: Re: [PATCH 11/12] tools: sync lib/find_bit implementation
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+Cc: Rikard

On Mon, May 10, 2021 at 6:31 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Commit eaae7841ba83bb42 ("tools: sync lib/find_bit implementation") broke
> build of 5.13-rc1 using gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3).
>
>   DESCEND  objtool
>   CC       /usr/src/linux/tools/objtool/exec-cmd.o
>   CC       /usr/src/linux/tools/objtool/help.o
>   CC       /usr/src/linux/tools/objtool/pager.o
>   CC       /usr/src/linux/tools/objtool/parse-options.o
>   CC       /usr/src/linux/tools/objtool/run-command.o
>   CC       /usr/src/linux/tools/objtool/sigchain.o
>   CC       /usr/src/linux/tools/objtool/subcmd-config.o
>   LD       /usr/src/linux/tools/objtool/libsubcmd-in.o
>   AR       /usr/src/linux/tools/objtool/libsubcmd.a
>   CC       /usr/src/linux/tools/objtool/arch/x86/special.o
> In file included from /usr/src/linux/tools/include/linux/kernel.h:8:0,
>                  from /usr/src/linux/tools/include/linux/list.h:7,
>                  from /usr/src/linux/tools/objtool/include/objtool/arch.h:10,
>                  from /usr/src/linux/tools/objtool/include/objtool/check.h:11,
>                  from /usr/src/linux/tools/objtool/include/objtool/special.h:10,
>                  from arch/x86/special.c:4:
> /usr/src/linux/tools/include/asm-generic/bitops/find.h: In function 'find_next_bit':
> /usr/src/linux/tools/include/linux/bits.h:24:21: error: first argument to '__builtin_choose_expr' not a constant
>   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>                      ^
> /usr/src/linux/tools/include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
>  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>                                                               ^
> /usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
>   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>    ^
> /usr/src/linux/tools/include/asm-generic/bitops/find.h:32:17: note: in expansion of macro 'GENMASK'
>    val = *addr & GENMASK(size - 1, offset);
>                  ^
> /usr/src/linux/tools/include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
>  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>                                                    ^
> /usr/src/linux/tools/include/linux/bits.h:24:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>    ^
> /usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
>   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>    ^
> /usr/src/linux/tools/include/asm-generic/bitops/find.h:32:17: note: in expansion of macro 'GENMASK'
>    val = *addr & GENMASK(size - 1, offset);
>                  ^
> /usr/src/linux/tools/include/asm-generic/bitops/find.h: In function 'find_next_and_bit':
> /usr/src/linux/tools/include/linux/bits.h:24:21: error: first argument to '__builtin_choose_expr' not a constant
>   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>                      ^
> /usr/src/linux/tools/include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
>  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>                                                               ^
> /usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
>   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>    ^
> /usr/src/linux/tools/include/asm-generic/bitops/find.h:62:27: note: in expansion of macro 'GENMASK'
>    val = *addr1 & *addr2 & GENMASK(size - 1, offset);
>                            ^
> /usr/src/linux/tools/include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
>  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>                                                    ^
> /usr/src/linux/tools/include/linux/bits.h:24:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>    ^
> /usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
>   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>    ^
> /usr/src/linux/tools/include/asm-generic/bitops/find.h:62:27: note: in expansion of macro 'GENMASK'
>    val = *addr1 & *addr2 & GENMASK(size - 1, offset);
>                            ^
> /usr/src/linux/tools/include/asm-generic/bitops/find.h: In function 'find_next_zero_bit':
> /usr/src/linux/tools/include/linux/bits.h:24:21: error: first argument to '__builtin_choose_expr' not a constant
>   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>                      ^
> /usr/src/linux/tools/include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
>  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>                                                               ^
> /usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
>   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>    ^
> /usr/src/linux/tools/include/asm-generic/bitops/find.h:90:18: note: in expansion of macro 'GENMASK'
>    val = *addr | ~GENMASK(size - 1, offset);
>                   ^
> /usr/src/linux/tools/include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
>  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>                                                    ^
> /usr/src/linux/tools/include/linux/bits.h:24:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>   (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>    ^
> /usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
>   (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>    ^
> /usr/src/linux/tools/include/asm-generic/bitops/find.h:90:18: note: in expansion of macro 'GENMASK'
>    val = *addr | ~GENMASK(size - 1, offset);
>                   ^
> make[5]: *** [/usr/src/linux/tools/objtool/arch/x86/special.o] Error 1
> make[4]: *** [arch/x86] Error 2
> make[3]: *** [/usr/src/linux/tools/objtool/objtool-in.o] Error 2
> make[2]: *** [objtool] Error 2
> make[1]: *** [tools/objtool] Error 2
> make: *** [__sub-make] Error 2
>
>
>
> Applying below diff seems to solve the build failure.

It will desynchronize this implementation with the mother's one (i.e.
in bits.h).

> Do we need to use BUILD_BUG_ON_ZERO() here?

Rikard?

>
> diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
> index 7f475d59a097..0aba9294f29d 100644
> --- a/tools/include/linux/bits.h
> +++ b/tools/include/linux/bits.h
> @@ -21,8 +21,7 @@
>  #if !defined(__ASSEMBLY__)
>  #include <linux/build_bug.h>
>  #define GENMASK_INPUT_CHECK(h, l) \
> -       (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> +       ({ BUILD_BUG_ON(__builtin_constant_p((l) > (h)) && ((l) > (h))); 0; })
>  #else
>  /*
>   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,


> Also, why the fast path of find_*_bit() functions does not check
> __builtin_constant_p(offset) as well as small_const_nbits(size), for the fast
> path fails to catch BUILD_BUG_ON_ZERO() when offset argument is not a constant.

How would this help anything?

If you ask a bit from a bitmap behind the size, what do you expect to get?

And I'm a bit lost here, because I can't imagine the offset being
constant along with a size of bitmap. What do we want to achieve by
this? Any examples to better understand the case?

-- 
With Best Regards,
Andy Shevchenko
