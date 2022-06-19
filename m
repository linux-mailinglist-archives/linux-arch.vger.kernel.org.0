Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D77550C03
	for <lists+linux-arch@lfdr.de>; Sun, 19 Jun 2022 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiFSQLV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Jun 2022 12:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFSQLU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jun 2022 12:11:20 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7FB644A
        for <linux-arch@vger.kernel.org>; Sun, 19 Jun 2022 09:11:18 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAgIQ-1nrz9Y2fN2-00B1WQ for <linux-arch@vger.kernel.org>; Sun, 19 Jun 2022
 18:11:16 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3178acf2a92so45808897b3.6
        for <linux-arch@vger.kernel.org>; Sun, 19 Jun 2022 09:11:16 -0700 (PDT)
X-Gm-Message-State: AJIora89QmkDNOT0WCaL5cM2iJxLHDctFSAQ3DQkzRA/bH63aIQ19YBh
        bnAlI5XMcFUnIxflabXfTyoq/dfZvPJzHePvLfw=
X-Google-Smtp-Source: AGRyM1u4m0E0KW7QvAX/N1AC5hXX0JLkb34rDkvU+flRUeRRk5cxd86INV5u8OCLHfM5t/pAQqDh5AjCDd2lLsBoOKI=
X-Received: by 2002:a0d:ca0f:0:b0:317:a2cc:aa2 with SMTP id
 m15-20020a0dca0f000000b00317a2cc0aa2mr7333201ywd.347.1655655075482; Sun, 19
 Jun 2022 09:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145705.581985-1-chenhuacai@loongson.cn>
 <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
 <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com>
 <CAK8P3a078r6zkZYYeV7Qg3AEOvFxgG+eRN9bFE_3DNwHq=_1ZA@mail.gmail.com>
 <CAJF2gTQL+ysc+juQfNVxz1QtXgrLAYe=CyA9L_c3fzd4F8aFxQ@mail.gmail.com>
 <CAK8P3a3wRqLAvywX2zbD0kdt19m2pKazqA2Y6_sNL1L=_4N3vQ@mail.gmail.com> <CAJF2gTQG0SBninPg7MsCFP=60p8u5KT+HaLNBzgjxM_fTMr+Dg@mail.gmail.com>
In-Reply-To: <CAJF2gTQG0SBninPg7MsCFP=60p8u5KT+HaLNBzgjxM_fTMr+Dg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 19 Jun 2022 18:10:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1LgmZDssQoCciZ0YRy3UHWV3yK99UHTCdvahCFBG+u+Q@mail.gmail.com>
Message-ID: <CAK8P3a1LgmZDssQoCciZ0YRy3UHWV3yK99UHTCdvahCFBG+u+Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add qspinlock support
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yMKLAe5RrTit3xCnQ8YKg2wDtjpyV8JbjzQs2kxKGb/J/9ob3D/
 e8e5fGv+t6kIbiD+c+Gbhmu0v992jWpyQGws3mvdyI5xHSvl9x+x8goBM9pIkCGD9L/Rz9D
 l/15+STAEYxWGuclnbx9x9JvAAIH9zITD2BI9Nm0g3DtGza442WsSw4e/qifEN9Deox2SZN
 Yzlt2DkfDwsu6+JR/+lNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HcyVEUCLy8k=:+Wf8KreONM76xkrElRCEwO
 fM8VTSPUoa0qVWFDy/1kbl+S3U0lWiROFvodTWzG34FN+nLSmKjnDfyKs7SrYVN+cMs9I0Djp
 69tfC1WgMm41Y+sAIXTJl9P83tiNotdFgVkA0j5ExvFK6f/vS2KA45S5IEkOeFDLLOdhZizRP
 E4CQkaD1nqTNbu/poQ7dV/A2YOxpwrmtYWAULm1dCq4fgG3hEFBdE7lArzE5NZ8VauSY3MmdW
 OKNrOopfKH4kPildmPILB9mmvze5hYa2+FYPcKJGqq1osXeLzIpQq+KFhrHZfJ6oC2Rg+ihIv
 h26M01ISTVC/JH+eNVtXaPboHITLN+VwpLRc3kf4WoLuuga+RxIYwYqvbI37sxhQprU+C0VTo
 vyhFem4X+m9cnpTffPrUgYaq1ZiuHhEYlHIrRQCTkx7Y5UcbA0PMbm3M1WI3kNKz+/Z9yJPln
 1l5a7eYDRfN21e2FdUVf0PH+PGMbrhp8z6B9txx+89OMhjQ9f18ceqYKijIBtESyr/6vi+bWX
 kC9A5Bl1ECE4/pZjYicIjuBB5sxJ1J5yDY0MPeecyBxwiJqiCRy1mA+7puX7RBD9kNMva3Lza
 V6C6k0JJiPHi/D2itn6ZdQg4LzbhpGKbKuFQYsINA+PVJ6dir+1ftPAeP96qkwkIC6NHGGFWn
 0WwZqifD+5x0yXtIooa54KJchNRe63bWHaGM/ftE1bSmRkX56WVmnQxJPG5h25/ShMQ7ZxbAL
 GW/nbyYwidr84gbIgRynzMdHD26tY9eWvrTlPQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 19, 2022 at 5:48 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Sat, Jun 18, 2022 at 1:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Jun 18, 2022 at 1:19 AM Guo Ren <guoren@kernel.org> wrote:
> > >
> > > > static inline u32 arch_xchg32(u32 *ptr, u32 x) {...}
> > > > static inline u64 arch_xchg64(u64 *ptr, u64 x) {...}
> > > >
> > > > #ifdef CONFIG_64BIT
> > > > #define xchg(ptr, x) (sizeof(*ptr) == 8) ? \
> > > >             arch_xchg64((u64*)ptr, (uintptr_t)x)  \
> > > >             arch_xchg32((u32*)ptr, x)
> > > > #else
> > > > #define xchg(ptr, x) arch_xchg32((u32*)ptr, (uintptr_t)x)
> > > > #endif
> > >
> > > The above primitive implies only long & int type args are permitted, right?
> >
> > The idea is to allow any scalar or pointer type, but not structures or
> > unions. If we need to deal with those as well, the macro could be extended
> > accordingly, but I would prefer to limit it as much as possible.
> >
> > There is already cmpxchg64(), which is used for types that are fixed to
> > 64 bit integers even on 32-bit architectures, but it is rarely used except
> > to implement the atomic64_t helpers.
> A lot of 32bit arches couldn't provide cmpxchg64 (like arm's ldrexd/strexd).

Most 32-bit architectures also lack SMP support, so they can fall back to
the generic version from include/asm-generic/cmpxchg-local.h

> Another question: Do you know why arm32 didn't implement
> HAVE_CMPXCHG_DOUBLE with ldrexd/strexd?

I think it's just fairly obscure, the slub code appears to be the only
code that would use it.

> >
> > 80% of the uses of cmpxchg() and xchg() deal with word-sized
> > quantities like 'unsigned long', or 'void *', but the others are almost
> > all fixed 32-bit quantities. We could change those to use cmpxchg32()
> > directly and simplify the cmpxchg() function further to only deal
> > with word-sized arguments, but I would not do that in the first step.
> Don't forget cmpxchg_double for this cleanup, when do you want to
> restart the work?

I have no specific plans at the moment. If you or someone else likes
to look into it, I can dig out my old patch though.

The cmpxchg_double() call seems to already fit in, since it is an
inline function and does not expect arbitrary argument types.

       Arnd
