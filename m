Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3C356B9E
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 13:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbhDGL6W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 07:58:22 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40761 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbhDGL6W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 07:58:22 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M8QJq-1lYUXD0Juq-004Qn1; Wed, 07 Apr 2021 13:58:11 +0200
Received: by mail-ot1-f51.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso17705658ott.13;
        Wed, 07 Apr 2021 04:58:10 -0700 (PDT)
X-Gm-Message-State: AOAM532P+LTvgiyg//oDpq268NEDNh6eSWKvORmDfUbh+aveAxW4hblo
        3D+buRw9rzaCN8LVKgzBQ3uX9uB0RQlG6eOwJFs=
X-Google-Smtp-Source: ABdhPJx6go5dv1rl+UzSOJd8wXt6Dn5ysS0pumma2IYLczj0nxb9z8e54FWCSruRNbRkAB1z2p2UWVLfOdOItXz14d4=
X-Received: by 2002:a9d:316:: with SMTP id 22mr2634357otv.210.1617796689525;
 Wed, 07 Apr 2021 04:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net> <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net> <20210330223514.GE1171117@lianli.shorne-pla.net>
 <CAK8P3a0hj2pYr-CuNJkjO==RafZ=J+6kCo4HTWEwvvRXPcngJA@mail.gmail.com>
 <CAJF2gTRxPMURTE3M5WMQ_0q1yZ6K8nraGsFjGLUmpG9nYS_hng@mail.gmail.com>
 <20210406085626.GE3288043@lianli.shorne-pla.net> <CAK8P3a3Pf3TbGoVP7JP7gfPV-WDM8MHV_hdqSwNKKFDr1Sb3zQ@mail.gmail.com>
 <YG2ZTSFMGrikYWuL@hirez.programming.kicks-ass.net>
In-Reply-To: <YG2ZTSFMGrikYWuL@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Apr 2021 13:57:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2E6JYwT7a1HUt=65v2cCJTTZm9mrW4Rxq=sXN4h9ObKg@mail.gmail.com>
Message-ID: <CAK8P3a2E6JYwT7a1HUt=65v2cCJTTZm9mrW4Rxq=sXN4h9ObKg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stafford Horne <shorne@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Q+LxeWOajDm9vRyjc77jrrc4X6RNkbQet1TKLaV84MYFveIGR8s
 svnak3qoEbH/9QKBlQG6pjU7spxHmV/jDhvAKv46K9ejd0hDYOlwVTuGRl+U4aNtgypLKn2
 K12mle/kdzWNvHe4FoZsiF7rqR7fHJnNYJCVOTlc2iLtL16r15Krrag9eiNM6nOAqQDzI++
 f+HXJl6cnAcU2yYOx1Ubg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lqWdy+WePdg=:UQU7Rv1JA6KnhJgErRwsc3
 aOyD+pa8lAxI9cXa/UvP2u9Ax2ISX6ZmFunvnsZUhsPTDSURia9TEeWQj9JkKyzrA3Nnq8GcX
 wDb4Vk42Ua/y5wkVS/8yaJdocczZo+YAz2mDsXtak0YpT9zC9C3zXXpPO91WTch3WAW8hvsxB
 lZvIojSb2IsC5e4Z3DV6x48qbfE4MrD+pfsgsb4s93KZG240mpkUQt31qC+0z9JHj5ePDKzQ7
 f4q2XEpPoYOjzp6+Ok20K6ckpkr4rXzO2IzV1FxGIsyYWz5tys/fPX2R41//OtiE4f4eLiayE
 FWCbnjZte/y82BXXh6qXnRYeBX75CccB+m5xx6Bp9gYfeeaYCsaMyR7v+p6aKFG+xj2j/grSG
 KDboEdIzj/U5ziHLKnGOjpJmtVg0Fynz+vskWJIsCyu6eQscRGJ9OP1uHqhNSJO+851coMY9t
 vULt2L0rcbCRwaQgF5OmwKp8XVT+DmvVcSoAAo4xtJZjXvZHyFGVrjxPy7Cb4xkbKxV6FC3p+
 N0IVfYSjtRt4phfaLBSS2buujV+l93EGxuT+iXRJLI2s0+P+/GJHYICotfZDrYvPARdgudHXI
 jcGQNoHLsL6loAOO2Eu+0SFT0wV0IYY6nK
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 7, 2021 at 1:36 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 07, 2021 at 10:42:50AM +0200, Arnd Bergmann wrote:
> > Since there are really only a handful of instances in the kernel
> > that use the cmpxchg() or xchg() on u8/u16 variables, it would seem
> > best to just disallow those completely
>
> Not going to happen. xchg16 is optimal for qspinlock and if we replace
> that with a cmpxchg loop on x86 we're regressing.

I did not mean to remove the possibility of doing a 16-bit compare-exchange
operation altogether, just removing it from the regular macros.

We already do this for the 64-bit xchg64()/cmpxchg64(), which only some
of the 32-bit architectures provide, so I think having an explicit
xchg8()/xchg16()/cmpxchg8()/cmpxchg16() interface while tightening the
type checking would be more consistent here.

On any 32-bit architecture, cmpxchg()/xchg() macros then only have
to deal with word-sized operations.

> > Interestingly, the s390 version using __sync_val_compare_and_swap()
> > seems to produce nice output on all architectures that have atomic
> > instructions, with any supported compiler, to the point where I think
> > we could just use that to replace most of the inline-asm versions except
> > for arm64:
> >
> > #define cmpxchg(ptr, o, n)                                              \
> > ({                                                                      \
> >         __typeof__(*(ptr)) __o = (o);                                   \
> >         __typeof__(*(ptr)) __n = (n);                                   \
> >         (__typeof__(*(ptr))) __sync_val_compare_and_swap((ptr),__o,__n);\
> > })
>
> It generates the LL/SC loop, but doesn't do sensible optimizations when
> it's again used in a loop itself. That is, it generates a loop of a
> loop, just like what you'd expect, which is sub-optimal for LL/SC.

One thing that it does though is to generate an ll/sc loop for xchg16(),
while mips, openrisc, xtensa and sparc64 currently open-code the
nested loop in their respective xchg16() wrappers. I have not seen
any case in which it produces object code that is worse than the
architecture specific code does today, except for those that rely on
runtime patching (i486+smp, arm64+lse).

> > Not how gcc's acquire/release behavior of __sync_val_compare_and_swap()
> > relates to what the kernel wants here.
> >
> > The gcc documentation also recommends using the standard
> > __atomic_compare_exchange_n() builtin instead, which would allow
> > constructing release/acquire/relaxed versions as well, but I could not
> > get it to produce equally good output. (possibly I was using it wrong)
>
> I'm scared to death of the C11 crap, the compiler will 'optimize' them
> when it feels like it and use the C11 memory model rules for it, which
> are not compatible with the kernel rules.
>
> But the same thing applies, it won't do the right thing for composites.

Makes sense. As I said, I could not even get it to produce optimal code
for the simple case.

         Arnd
