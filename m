Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A260F34CD3A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 11:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhC2Jl4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 05:41:56 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42527 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhC2Jlh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Mar 2021 05:41:37 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Moex5-1lxOCs2N5t-00p5X4; Mon, 29 Mar 2021 11:41:35 +0200
Received: by mail-ot1-f47.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso11692096otq.3;
        Mon, 29 Mar 2021 02:41:35 -0700 (PDT)
X-Gm-Message-State: AOAM531nzaHFqcbkJpvb86X+4zZjtvNGQOxd5vrkaCPPLE+/q0pE3UmV
        aZKAEPBKR22GWrXRGXNgIyyf6QxYMqvi0HUB9rE=
X-Google-Smtp-Source: ABdhPJxL0UJP5P1kWHY4Vwg+0uu5/aXzFNnE6DPhiRa4ILVvkxMo1SzhkH24nsZdTPp3TzHp49EK1KZBWv4f9Ey1t6I=
X-Received: by 2002:a9d:316:: with SMTP id 22mr22008090otv.210.1617010894060;
 Mon, 29 Mar 2021 02:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
In-Reply-To: <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Mar 2021 11:41:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
Message-ID: <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:on1MeP+NZu/Qqs6aC1Hye/UfhyvXSQJXYSayp/Z1fjK+Mc1m/jL
 83koxMAWhtBPJ0frk/kY0DC0ddjHc8xKnOe3i8z4bqDGfUY6ppERGFemxg9b62LUITLdHCP
 UYUy61SHZf8Y7CEmwmFJJ8ySA5sA8iYW0rYMFBkE09Ot7QV4eJV0u/TuZWYwhN7q95Bb41X
 bjwgurLdQ0y7tV/t0u6Fg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:foRlqoscMSo=:vWXtAZF8T9YfjPjY7eHYsK
 idCVUPYNFUSojO0UQDgx7g+FFZBB6jCXDeQvAGZ8AWat+LPnMy8p5d5etvxcs/X1WVUxTMVBj
 v3aN6BaKe5N4WRadtQiEnClkc1Hg6JRQxmS2qVa5TVgeV0S01YZNYqOJEmQVr2mQEAN/Sdk7u
 wKtc63ZgGT70MrOaj6efP5xH1vXHKBP5rpTAmR0uoLDxoz8EXJiZRPLAAchHW4IPKI1uTyHiQ
 2GzqbE6t/lWpdk89f9EjXTewoH5R5Xz+Y+DW6lFU0+3FnRiHOL+htZTAAPuT2CIJQp1PEK8Eq
 GlL8GDd/PxtU9SMzYs4/2+HYHd1/kY+GblDQYTCFkhq8g+KqtkSqEi5IQ4OtRK1kiTh+/TUH5
 NOT9FY0T09JPRUYUv5Q2PLWE/Czo9VrTOSqO2cXtPcKUHQjc8RZ+CgLjcJ63brKiL73vRrQS3
 IovlSQPPmjChCaClmcfmmyV5HoCHMTHQdTTOnKM4q0x0VFIIpcUz2eFSDIlmu8tEEyunaDPtQ
 GXqVTeueJZLZc4/P0TWwcZsjkfaaD7SjyAN1En3JedeifVJTVrng8MsR0lbzck/lh062+R1EB
 xAVKXx//QhwwC8KPd08J4Rl+lRS22sZIwj
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 29, 2021 at 9:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Sat, Mar 27, 2021 at 06:06:38PM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Some architectures don't have sub-word swap atomic instruction,
> > they only have the full word's one.
> >
> > The sub-word swap only improve the performance when:
> > NR_CPUS < 16K
> >  *  0- 7: locked byte
> >  *     8: pending
> >  *  9-15: not used
> >  * 16-17: tail index
> >  * 18-31: tail cpu (+1)
> >
> > The 9-15 bits are wasted to use xchg16 in xchg_tail.
> >
> > Please let architecture select xchg16/xchg32 to implement
> > xchg_tail.
>
> So I really don't like this, this pushes complexity into the generic
> code for something that's really not needed.
>
> Lots of RISC already implement sub-word atomics using word ll/sc.
> Obviously they're not sharing code like they should be :/ See for
> example arch/mips/kernel/cmpxchg.c.

That is what the previous version of the patch set did, right?

I think this v4 is nicer because the code is already there in
qspinlock.c and just gets moved around, and the implementation
is likely more efficient this way. The mips version could be made
more generic, but it is also less efficient than a simple xchg
since it requires an indirect function call plus nesting a pair of
loops instead in place of the single single ll/sc loop in the 32-bit
xchg.

I think the weakly typed xchg/cmpxchg implementation causes
more problems than it solves, and we'd be better off using
a stronger version in general, with the 8-bit and 16-bit exchanges
using separate helpers in the same way that the fixed-length
cmpxchg64 is separate already, there are only a couple of instances
for each of these in the kernel.

Unfortunately, there is roughly a 50:50 split between fixed 32-bit
and long/pointer-sized xchg/cmpxchg users in the kernel, so
making the interface completely fixed-type would add a ton of
churn. I created an experimental patch for this, but it's probably
not worth it.

> Also, I really do think doing ticket locks first is a far more sensible
> step.

I think this is the important point to look at first. From what I can
tell, most users of ticket spinlocks have moved to qspinlock over
time, but I'm not sure about the exact tradeoff, in particular on
large machines without a 16-bit xchg operation.

FWIW, the implementations in the other SMP capable
architectures are

alpha    simple
arc      simple+custom
arm      ticket
arm64    qspinlock (formerly ticket)
csky     ticket/qrwlock (formerly simple+ticket/qrwlock)
hexagon  simple
ia64     ticket
mips     qspinlock (formerly ticket)
openrisc qspinlock
parisc   custom
powerpc  simple+qspinlock (formerly simple)
riscv    simple
s390     custom-queue
sh       simple
sparc    qspinlock
x86      qspinlock (formerly ticket+qspinlock)
xtensa   qspinlock

32-bit Arm is the only relevant user of ticket locks these days, but its
hardware has a practical limit of 16 CPUs and four nodes, with most
implementations having a single CPU cluster of at most four cores.

We had the same discussion about xchg16() when Sebastian submitted
the arm32 qspinlock implementation:
https://lore.kernel.org/linux-arm-kernel/20191007214439.27891-1-sebastian@breakpoint.cc/

        Arnd
