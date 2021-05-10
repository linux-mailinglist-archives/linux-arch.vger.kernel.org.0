Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20B4379546
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 19:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhEJRWh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhEJRWe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2021 13:22:34 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698F4C061574;
        Mon, 10 May 2021 10:21:28 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u7so8718483qvv.12;
        Mon, 10 May 2021 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9sjLsVt8xymIh+A7BLyf2HYNixYx504wOSrn7OVFJwY=;
        b=dYpRd8UBzBUQr2X+7B7FSdpW0/245RPF7H10qWxN/QAuMadAda8cqB23N8kMNFAW4G
         VXTqhTJdMMcipdhAHP/yZyUDFkuw2NbZiW2/iHG95N8hheGFHCO29mX7vOK4CisCLB9A
         bojYgFTYdlONo+rg0WcdAu4+XjjFTiE3LHh7oAkpISnOO5fo5tQxIbcvNnS1u+piVij/
         t8kK8RFhv26nqqszVTM8ymQkgaG4ChC4kE70jtizruU+x6rOT5OWjvwHqWHuPw8aSKuV
         +mtXB6E5nNy24Npd/nOHXex4J2Lt4At2gBAcEZkg9RyXWaYyOKVMzndNq4kwagP4zwKQ
         G8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9sjLsVt8xymIh+A7BLyf2HYNixYx504wOSrn7OVFJwY=;
        b=RmbSDdzBV55UclbeEfIxLAxyM/jeNi3HYJbO1zChhqaQG2in/HVWs584z59cVoKOA4
         pGerOO3QuEaYoSItA3ijlOxYMNGitc69ex89eH0+SO/0g/Qm5uBcEtI5VQ8RFAim3CZU
         OGRuInWwzuCEFuzrMLBWDCzrPwDergsjp3mVJOhPW2wLJGPpz9VYkXsAlyChYa1Fdztn
         PYKQ7KDz5W+5DL0DLyPG2xIzHhe98ut9jdtU2UdnxULchuDttwNps+dr6XNWWCcyb+5C
         kokLXBeSP/xSZuiUmUCVcvSBhvlf3x3909NatCdXgxFeGuw7ZkOyzRbI3YJwONOvI144
         WLOA==
X-Gm-Message-State: AOAM5316XhRI3wS4IYFnxoCu4F0g3NPO68j3NL+6CRrjpPGalSkQr0um
        u2wEJcjGrYm02E7aCsS0Gjg=
X-Google-Smtp-Source: ABdhPJyx7jsRK8LEcdf7aWQRrTJWrrHx58JYmuJLXj76C8df16j2xWAHfu2XyIx87yYxQtDpoR4wBQ==
X-Received: by 2002:ad4:5c68:: with SMTP id i8mr24688332qvh.53.1620667287417;
        Mon, 10 May 2021 10:21:27 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id h7sm1744818qtj.35.2021.05.10.10.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:21:26 -0700 (PDT)
Date:   Mon, 10 May 2021 10:21:26 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
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
Message-ID: <YJlravuhJLlWaqjs@yury-ThinkPad>
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
> > Applying below diff seems to solve the build failure.
> >
> It will desynchronize this implementation with the mother's one (i.e.
> in bits.h).
> 
> > Do we need to use BUILD_BUG_ON_ZERO() here?
> 
> Rikard?
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
 
As Andy said, we need to sync tools/GENMASK_INPUT_CHECK() with the
kernel version, and if I do this, I have many build failures:

https://pastebin.com/Fan1VLVF

Maybe in this case we should use __GENMASK() to bypass GENMASK_INPUT_CHECK()...
I'll check everything carefully this evening.
 
> > Also, why the fast path of find_*_bit() functions does not check
> > __builtin_constant_p(offset) as well as small_const_nbits(size), for the fast
> > path fails to catch BUILD_BUG_ON_ZERO() when offset argument is not a constant.
>
> How would this help anything?
> 
> If you ask a bit from a bitmap behind the size, what do you expect to get?
> 
> And I'm a bit lost here, because I can't imagine the offset being
> constant along with a size of bitmap. What do we want to achieve by
> this? Any examples to better understand the case?

If offset is constant, the existing fast path optimization would work
even better, without any modifications. (Not sure there's an example of
it in the existing codebase.) But even if the offset is not constant,
fast path works quite well - it saves ~1K of .text and improves on
performance:

https://lore.kernel.org/linux-m68k/20210321215457.588554-10-yury.norov@gmail.com/

We don't need to disable the optimization for non-constant offsets,
for sure. If asserts in GENMASK() break build, we should use __GENMASK().

Thanks,
Yury
