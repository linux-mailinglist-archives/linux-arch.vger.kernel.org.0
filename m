Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1EE50AE96
	for <lists+linux-arch@lfdr.de>; Fri, 22 Apr 2022 05:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443797AbiDVDsS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Apr 2022 23:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiDVDsR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2022 23:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898F3BBCD;
        Thu, 21 Apr 2022 20:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B6F761A90;
        Fri, 22 Apr 2022 03:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA05C385AF;
        Fri, 22 Apr 2022 03:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650599124;
        bh=tmez4P5V6x2mGY+oYdwSCDpGcMlFQL7bGA1+b5tLcj4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R6gCSXNdxplxUOAnsGUYLm4lANFgJkdEL0RiE8VKlm9aH15wOSkv1q8tRuZLxqwKm
         YvfTUveVbg1ynV3+HVE+6sn4X2r79hoP//Xe8Gg3oSlnh951h6OAnazm38TBhhg5xe
         heq5rQiH8fOCsU8DWAYFqXdEapVHMtvjy4JUCiys/ER40fiRIJLg3Tytxv6piBERlj
         snk5ZSeQT2CjQxidUDBMiyuOc8jaAwvXkMHUuujFmNsV5SVPEWyluR9c013hl1nPn8
         LZlUgjD/WeTnmOrC4HVP12TDY6HrvTQ4ChwQj4jSOjbOGXAKYexBxVqF4T4AImCiTc
         m86FmGTy3i9JA==
Received: by mail-vs1-f48.google.com with SMTP id t202so6332948vst.8;
        Thu, 21 Apr 2022 20:45:24 -0700 (PDT)
X-Gm-Message-State: AOAM533qJ5v2C/qt6pcc2v4uOdGiDeke852BsBSBypHUpFJ2hYuPeglY
        AWu5gYtsqjm6oJXNdX0Kg6UiY/keyPVr96wEQtU=
X-Google-Smtp-Source: ABdhPJwdFIbt41ljQQ8r2gKIQEXrsHC5o0ouBqmKTuaxB5urgUsqP3gFhZOSzPCig/IhGXkagPauRNHnS+5M064lgN4=
X-Received: by 2002:a67:e28a:0:b0:32a:4917:9f08 with SMTP id
 g10-20020a67e28a000000b0032a49179f08mr728853vsf.51.1650599123631; Thu, 21 Apr
 2022 20:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220417083204.2048364-1-guoren@kernel.org> <20220417083204.2048364-2-guoren@kernel.org>
 <YmIfBmisFVBu8Z5R@tardis>
In-Reply-To: <YmIfBmisFVBu8Z5R@tardis>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 22 Apr 2022 11:45:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQU251odn6BQOQzma-cyEdw4vE39hauCPunnPY6v0fuyQ@mail.gmail.com>
Message-ID: <CAJF2gTQU251odn6BQOQzma-cyEdw4vE39hauCPunnPY6v0fuyQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] csky: cmpxchg: Optimize with acquire & release
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 22, 2022 at 11:20 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Sun, Apr 17, 2022 at 04:32:02PM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Optimize arch_xchg|cmpxchg|cmpxchg_local with ASM acquire|release
> > instructions instead of previous C based.
> >
> > Important reference comment by Rutland:
> > 8e86f0b409a4 ("arm64: atomics: fix use of acquire + release for
> > full barrier semantics")
> >
> > Link: https://lore.kernel.org/linux-riscv/CAJF2gTSAxpAi=LbAdu7jntZRUa=-dJwL0VfmDfBV5MHB=rcZ-w@mail.gmail.com/T/#m27a0f1342995deae49ce1d0e1f2683f8a181d6c3
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  arch/csky/include/asm/barrier.h | 11 +++---
> >  arch/csky/include/asm/cmpxchg.h | 64 ++++++++++++++++++++++++++++++---
> >  2 files changed, 67 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
> > index f4045dd53e17..fb63335ffa33 100644
> > --- a/arch/csky/include/asm/barrier.h
> > +++ b/arch/csky/include/asm/barrier.h
> > @@ -37,17 +37,21 @@
> >   * bar.brar
> >   * bar.bwaw
> >   */
> > +#define ACQUIRE_FENCE                ".long 0x8427c000\n"
> > +#define RELEASE_FENCE                ".long 0x842ec000\n"
> > +#define FULL_FENCE           ".long 0x842fc000\n"
> > +
> >  #define __bar_brw()  asm volatile (".long 0x842cc000\n":::"memory")
> >  #define __bar_br()   asm volatile (".long 0x8424c000\n":::"memory")
> >  #define __bar_bw()   asm volatile (".long 0x8428c000\n":::"memory")
> >  #define __bar_arw()  asm volatile (".long 0x8423c000\n":::"memory")
> >  #define __bar_ar()   asm volatile (".long 0x8421c000\n":::"memory")
> >  #define __bar_aw()   asm volatile (".long 0x8422c000\n":::"memory")
> > -#define __bar_brwarw()       asm volatile (".long 0x842fc000\n":::"memory")
> > -#define __bar_brarw()        asm volatile (".long 0x8427c000\n":::"memory")
> > +#define __bar_brwarw()       asm volatile (FULL_FENCE:::"memory")
> > +#define __bar_brarw()        asm volatile (ACQUIRE_FENCE:::"memory")
> >  #define __bar_bwarw()        asm volatile (".long 0x842bc000\n":::"memory")
> >  #define __bar_brwar()        asm volatile (".long 0x842dc000\n":::"memory")
> > -#define __bar_brwaw()        asm volatile (".long 0x842ec000\n":::"memory")
> > +#define __bar_brwaw()        asm volatile (RELEASE_FENCE:::"memory")
> >  #define __bar_brar() asm volatile (".long 0x8425c000\n":::"memory")
> >  #define __bar_brar() asm volatile (".long 0x8425c000\n":::"memory")
> >  #define __bar_bwaw() asm volatile (".long 0x842ac000\n":::"memory")
> > @@ -56,7 +60,6 @@
> >  #define __smp_rmb()  __bar_brar()
> >  #define __smp_wmb()  __bar_bwaw()
> >
> > -#define ACQUIRE_FENCE                ".long 0x8427c000\n"
> >  #define __smp_acquire_fence()        __bar_brarw()
> >  #define __smp_release_fence()        __bar_brwaw()
> >
> > diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
> > index d1bef11f8dc9..06c550448bf1 100644
> > --- a/arch/csky/include/asm/cmpxchg.h
> > +++ b/arch/csky/include/asm/cmpxchg.h
> > @@ -64,15 +64,71 @@ extern void __bad_xchg(void);
> >  #define arch_cmpxchg_relaxed(ptr, o, n) \
> >       (__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
> >
> > -#define arch_cmpxchg(ptr, o, n)                              \
> > +#define __cmpxchg_acquire(ptr, old, new, size)                       \
> >  ({                                                           \
> > +     __typeof__(ptr) __ptr = (ptr);                          \
> > +     __typeof__(new) __new = (new);                          \
> > +     __typeof__(new) __tmp;                                  \
> > +     __typeof__(old) __old = (old);                          \
> > +     __typeof__(*(ptr)) __ret;                               \
> > +     switch (size) {                                         \
> > +     case 4:                                                 \
> > +             asm volatile (                                  \
> > +             "1:     ldex.w          %0, (%3) \n"            \
> > +             "       cmpne           %0, %4   \n"            \
> > +             "       bt              2f       \n"            \
> > +             "       mov             %1, %2   \n"            \
> > +             "       stex.w          %1, (%3) \n"            \
> > +             "       bez             %1, 1b   \n"            \
> > +             ACQUIRE_FENCE                                   \
> > +             "2:                              \n"            \
> > +                     : "=&r" (__ret), "=&r" (__tmp)          \
> > +                     : "r" (__new), "r"(__ptr), "r"(__old)   \
> > +                     :);                                     \
> > +             break;                                          \
> > +     default:                                                \
> > +             __bad_xchg();                                   \
> > +     }                                                       \
> > +     __ret;                                                  \
> > +})
> > +
> > +#define arch_cmpxchg_acquire(ptr, o, n) \
> > +     (__cmpxchg_acquire((ptr), (o), (n), sizeof(*(ptr))))
> > +
> > +#define __cmpxchg(ptr, old, new, size)                               \
> > +({                                                           \
> > +     __typeof__(ptr) __ptr = (ptr);                          \
> > +     __typeof__(new) __new = (new);                          \
> > +     __typeof__(new) __tmp;                                  \
> > +     __typeof__(old) __old = (old);                          \
> >       __typeof__(*(ptr)) __ret;                               \
> > -     __smp_release_fence();                                  \
> > -     __ret = arch_cmpxchg_relaxed(ptr, o, n);                \
> > -     __smp_acquire_fence();                                  \
> > +     switch (size) {                                         \
> > +     case 4:                                                 \
> > +             asm volatile (                                  \
> > +             "1:     ldex.w          %0, (%3) \n"            \
> > +             "       cmpne           %0, %4   \n"            \
> > +             "       bt              2f       \n"            \
> > +             "       mov             %1, %2   \n"            \
> > +             RELEASE_FENCE                                   \
>
> FWIW, you probably need to make sure that a barrier instruction inside
> an lr/sc loop is a good thing. IIUC, the execution time of a barrier
> instruction is determined by the status of store buffers and invalidate
> queues (and probably other stuffs), so it may increase the execution
> time of the lr/sc loop, and make it unlikely to succeed. But this really
> depends on how the arch executes these instructions.
Yes, you are right. FENCE would plus overhead in lr/sc loop and that
would make it harder to succeed.

I would fix up it and include your comment in the next version of the patchset.

>
> Regards,
> Boqun
>
> > +             "       stex.w          %1, (%3) \n"            \
> > +             "       bez             %1, 1b   \n"            \
> > +             FULL_FENCE                                      \
> > +             "2:                              \n"            \
> > +                     : "=&r" (__ret), "=&r" (__tmp)          \
> > +                     : "r" (__new), "r"(__ptr), "r"(__old)   \
> > +                     :);                                     \
> > +             break;                                          \
> > +     default:                                                \
> > +             __bad_xchg();                                   \
> > +     }                                                       \
> >       __ret;                                                  \
> >  })
> >
> > +#define arch_cmpxchg(ptr, o, n) \
> > +     (__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
> > +
> > +#define arch_cmpxchg_local(ptr, o, n)                                \
> > +     (__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
> >  #else
> >  #include <asm-generic/cmpxchg.h>
> >  #endif
> > --
> > 2.25.1
> >



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
