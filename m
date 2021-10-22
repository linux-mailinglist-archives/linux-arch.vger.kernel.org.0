Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2CD436FC2
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 04:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhJVCHS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 22:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231996AbhJVCHS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Oct 2021 22:07:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FF12611C3;
        Fri, 22 Oct 2021 02:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634868301;
        bh=y3WecNbFeV0ytwz02XEpT0LlCwC4tZAbDX5MoNIUjAE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tKk6EDCa+P8WJL6nY8DF4NgZIIZ2BFOuwxuUWYQHJS/cKwHlpSIRzcVkga5VNCEQr
         Yloczu74TOFdoo5eh8MAaDTAMP2UbnOVXoPewaKltEjpd4St33Oee4aT4NuPGJThSM
         P9EHFHgXVmandXjpzFZwBG+zFnz3VvpWblTiXUXdgRMsAlPp/emYSL8Pcwa5i48DO7
         HAtVmSslLxVVQ7ra8pC7YbhlBCv89bRue5QzzYcyACAXX8GJGFHqhxwyu/sNpVO0/q
         uhXP0qed2ZvqBDSJoPGSFeyzOYg28dR7+HLWNIHEkem6RB13xgsjto24ZPlotbkPiv
         40iGoFnHz2S0g==
Received: by mail-ua1-f48.google.com with SMTP id e2so4890217uax.7;
        Thu, 21 Oct 2021 19:05:01 -0700 (PDT)
X-Gm-Message-State: AOAM532woC95nDEPg1spo9+ZuX4PDZdcc9OLTBG7PmLNW25Evsqu45Ne
        jvbnf04FFb0IINdEJW+HNLjvSQ71/SRuLtFXtxE=
X-Google-Smtp-Source: ABdhPJw6tqt7XtPD1oQtadfQ/HJNK5k8ey+Bn1x034g6Dm99vv/qEKLKo29ld1xI9ZJxtc/hBMZcVuA2aFPSmtM6MZg=
X-Received: by 2002:ab0:5a93:: with SMTP id w19mr11133228uae.58.1634868300474;
 Thu, 21 Oct 2021 19:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
In-Reply-To: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 22 Oct 2021 10:04:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTt85x66y+abT=czvqSNtbxKYneiO_ABffUg_AwOcon=Q@mail.gmail.com>
Message-ID: <CAJF2gTTt85x66y+abT=czvqSNtbxKYneiO_ABffUg_AwOcon=Q@mail.gmail.com>
Subject: Re: [PATCH] locking: Generic ticket lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>,
        Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

C-SKY would follow this, thx.

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, Oct 21, 2021 at 9:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> There's currently a number of architectures that want/have graduated
> from test-and-set locks and are looking at qspinlock.
>
> *HOWEVER* qspinlock is very complicated and requires a lot of an
> architecture to actually work correctly. Specifically it requires
> forward progress between a fair number of atomic primitives, including
> an xchg16 operation, which I've seen a fair number of fundamentally
> broken implementations of in the tree (specifically for qspinlock no
> less).
>
> The benefit of qspinlock over ticket lock is also non-obvious, esp.
> at low contention (the vast majority of cases in the kernel), and it
> takes a fairly large number of CPUs (typically also NUMA) to make
> qspinlock beat ticket locks.
>
> Esp. things like ARM64's WFE can move the balance a lot in favour of
> simpler locks by reducing the cacheline pressure due to waiters (see
> their smp_cond_load_acquire() implementation for details).
>
> Unless you've audited qspinlock for your architecture and found it
> sound *and* can show actual benefit, simpler is better.
>
> Therefore provide ticket locks, which depend on a single atomic
> operation (fetch_add) while still providing fairness.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/asm-generic/qspinlock.h         |   30 +++++++++
>  include/asm-generic/ticket_lock_types.h |   11 +++
>  include/asm-generic/ticket_lock.h       |   97 ++++++++++++++++++++++++++++++++
>  3 files changed, 138 insertions(+)
>
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -2,6 +2,36 @@
>  /*
>   * Queued spinlock
>   *
> + * A 'generic' spinlock implementation that is based on MCS locks. An
> + * architecture that's looking for a 'generic' spinlock, please first consider
> + * ticket_lock.h and only come looking here when you've considered all the
> + * constraints below and can show your hardware does actually perform better
> + * with qspinlock.
> + *
> + *
> + * It relies on smp_store_release() + atomic_*_acquire() to be RCsc (or no
> + * weaker than RCtso if you're Power, also see smp_mb__after_unlock_lock()),
> + *
> + * It relies on a far greater (compared to ticket_lock.h) set of atomic
> + * operations to behave well together, please audit them carefully to ensure
> + * they all have forward progress. Many atomic operations may default to
> + * cmpxchg() loops which will not have good forward progress properties on
> + * LL/SC architectures.
> + *
> + * One notable example is atomic_fetch_or_acquire(), which x86 cannot (cheaply)
> + * do. Carefully read the patches that introduced
> + * queued_fetch_set_pending_acquire().
> + *
> + * It also heavily relies on mixed size atomic operations, in specific it
> + * requires architectures to have xchg16; something which many LL/SC
> + * architectures need to implement as a 32bit and+or in order to satisfy the
> + * forward progress guarantees mentioned above.
> + *
> + * Further reading on mixed size atomics that might be relevant:
> + *
> + *   http://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf
> + *
> + *
>   * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
>   * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
>   *
> --- /dev/null
> +++ b/include/asm-generic/ticket_lock_types.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_GENERIC_TICKET_LOCK_TYPES_H
> +#define __ASM_GENERIC_TICKET_LOCK_TYPES_H
> +
> +#include <linux/types.h>
> +typedef atomic_t arch_spinlock_t;
> +
> +#define __ARCH_SPIN_LOCK_UNLOCKED      ATOMIC_INIT(0)
> +
> +#endif /* __ASM_GENERIC_TICKET_LOCK_TYPES_H */
> --- /dev/null
> +++ b/include/asm-generic/ticket_lock.h
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * 'Generic' ticket lock implementation.
> + *
> + * It relies on atomic_fetch_add() having well defined forward progress
> + * guarantees under contention. If your architecture cannot provide this, stick
> + * to a test-and-set lock.
> + *
> + * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
> + * sub-word of the value. This is generally true for anything LL/SC although
> + * you'd be hard pressed to find anything useful in architecture specifications
> + * about this. If your architecture cannot do this you might be better off with
> + * a test-and-set.
> + *
> + * It relies on smp_store_release() + atomic_*_acquire() to be RCsc (or no
> + * weaker than RCtso if you're Power, also see smp_mb__after_unlock_lock()),
> + *
> + * The implementation uses smp_cond_load_acquire() to spin, so if the
> + * architecture has WFE like instructions to sleep instead of poll for word
> + * modifications be sure to implement that (see ARM64 for example).
> + *
> + */
> +
> +#ifndef __ASM_GENERIC_TICKET_LOCK_H
> +#define __ASM_GENERIC_TICKET_LOCK_H
> +
> +#include <linux/atomic.h>
> +#include <asm/ticket_lock_types.h>
> +
> +#define ONE_TICKET     (1 << 16)
> +#define __ticket(val)  (u16)((val) >> 16)
> +#define __owner(val)   (u16)((val) & 0xffff)
> +
> +static __always_inline bool __ticket_is_locked(u32 val)
> +{
> +       return __ticket(val) != __owner(val);
> +}
> +
> +static __always_inline void ticket_lock(arch_spinlock_t *lock)
> +{
> +       u32 val = atomic_fetch_add_acquire(ONE_TICKET, lock);
> +       u16 ticket = __ticket(val);
> +
> +       if (ticket == __owner(val))
> +               return;
> +
> +       atomic_cond_read_acquire(lock, ticket == __owner(VAL));
> +}
> +
> +static __always_inline bool ticket_trylock(arch_spinlock_t *lock)
> +{
> +       u32 old = atomic_read(lock);
> +
> +       if (__ticket_is_locked(old))
> +               return false;
> +
> +       return atomic_try_cmpxchg_acquire(lock, &old, old + ONE_TICKET);
> +}
> +
> +static __always_inline void ticket_unlock(arch_spinlock_t *lock)
> +{
> +       u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);
> +       u32 val = atomic_read(lock);
> +
> +       smp_store_release(ptr, __owner(val) + 1);
> +}
> +
> +static __always_inline int ticket_is_contended(arch_spinlock_t *lock)
> +{
> +       u32 val = atomic_read(lock);
> +
> +       return (__ticket(val) - __owner(val)) > 1;
> +}
> +
> +static __always_inline int ticket_is_locked(arch_spinlock_t *lock)
> +{
> +       return __ticket_is_locked(atomic_read(lock));
> +}
> +
> +static __always_inline int ticket_value_unlocked(arch_spinlock_t lock)
> +{
> +       return !__ticket_is_locked(lock.counter);
> +}
> +
> +#undef __owner
> +#undef __ticket
> +#undef ONE_TICKET
> +
> +#define arch_spin_lock(l)              ticket_lock(l)
> +#define arch_spin_trylock(l)           ticket_trylock(l)
> +#define arch_spin_unlock(l)            ticket_unlock(l)
> +#define arch_spin_is_locked(l)         ticket_is_locked(l)
> +#define arch_spin_is_contended(l)      ticket_is_contended(l)
> +#define arch_spin_value_unlocked(l)    ticket_value_unlocked(l)
> +
> +#endif /* __ASM_GENERIC_TICKET_LOCK_H */



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
