Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52359436A0B
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhJUSHU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 14:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232404AbhJUSHT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Oct 2021 14:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634839502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c0lV1SQm+A/6nuLSjE1bEl9hT+k65LUuD9ohANoqFLs=;
        b=E1MEDAaoK9HLO+3nnRk7/ZM0gIbxwhrlILqInePs0O1bR/N+KV1nAHhXU8r0S5bBKa/f/x
        IkrpLMZWKZhW/U65hyLwifDtkqD9VLGWZJAEBqzjfLJkKhcPYaH35W+nN4Enp1wnSQA2/U
        kTsriahqlO4U9Ky+5KAu8e1+lGFohzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-hZ17UqHQNxCGp75wNuNVrw-1; Thu, 21 Oct 2021 14:04:59 -0400
X-MC-Unique: hZ17UqHQNxCGp75wNuNVrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3846B80668D;
        Thu, 21 Oct 2021 18:04:57 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.22.18.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DD6119D9F;
        Thu, 21 Oct 2021 18:04:55 +0000 (UTC)
Subject: Re: [PATCH] locking: Generic ticket lock
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        =?UTF-8?Q?Christoph_M=c3=bcllner?= <christophm30@gmail.com>,
        Stafford Horne <shorne@gmail.com>
References: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Message-ID: <4de96b16-a146-f82a-a7f2-706dba4f901f@redhat.com>
Date:   Thu, 21 Oct 2021 14:04:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/21 9:05 AM, Peter Zijlstra wrote:
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
>   include/asm-generic/qspinlock.h         |   30 +++++++++
>   include/asm-generic/ticket_lock_types.h |   11 +++
>   include/asm-generic/ticket_lock.h       |   97 ++++++++++++++++++++++++++++++++
>   3 files changed, 138 insertions(+)
>
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -2,6 +2,36 @@
>   /*
>    * Queued spinlock
>    *
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
>    * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
>    * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
>    *
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
> +#define __ARCH_SPIN_LOCK_UNLOCKED	ATOMIC_INIT(0)
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
> +#define ONE_TICKET	(1 << 16)
> +#define __ticket(val)	(u16)((val) >> 16)
> +#define __owner(val)	(u16)((val) & 0xffff)
> +
> +static __always_inline bool __ticket_is_locked(u32 val)
> +{
> +	return __ticket(val) != __owner(val);
> +}
> +
> +static __always_inline void ticket_lock(arch_spinlock_t *lock)
> +{
> +	u32 val = atomic_fetch_add_acquire(ONE_TICKET, lock);
> +	u16 ticket = __ticket(val);
> +
> +	if (ticket == __owner(val))
> +		return;
> +
> +	atomic_cond_read_acquire(lock, ticket == __owner(VAL));
> +}
> +
> +static __always_inline bool ticket_trylock(arch_spinlock_t *lock)
> +{
> +	u32 old = atomic_read(lock);
> +
> +	if (__ticket_is_locked(old))
> +		return false;
> +
> +	return atomic_try_cmpxchg_acquire(lock, &old, old + ONE_TICKET);
> +}
> +
> +static __always_inline void ticket_unlock(arch_spinlock_t *lock)
> +{
> +	u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);
> +	u32 val = atomic_read(lock);
> +
> +	smp_store_release(ptr, __owner(val) + 1);
> +}
> +
> +static __always_inline int ticket_is_contended(arch_spinlock_t *lock)
> +{
> +	u32 val = atomic_read(lock);
> +
> +	return (__ticket(val) - __owner(val)) > 1;
Nit: The left side is unsigned, but the right is signed. I think you are 
relying on the implicit signed to unsigned conversion. It may be a bit 
clearer if you use 1U instead.
> +}
> +
> +static __always_inline int ticket_is_locked(arch_spinlock_t *lock)
> +{
> +	return __ticket_is_locked(atomic_read(lock));
> +}
> +
> +static __always_inline int ticket_value_unlocked(arch_spinlock_t lock)
> +{
> +	return !__ticket_is_locked(lock.counter);
> +}
> +
> +#undef __owner
> +#undef __ticket
> +#undef ONE_TICKET
> +
> +#define arch_spin_lock(l)		ticket_lock(l)
> +#define arch_spin_trylock(l)		ticket_trylock(l)
> +#define arch_spin_unlock(l)		ticket_unlock(l)
> +#define arch_spin_is_locked(l)		ticket_is_locked(l)
> +#define arch_spin_is_contended(l)	ticket_is_contended(l)
> +#define arch_spin_value_unlocked(l)	ticket_value_unlocked(l)
> +
> +#endif /* __ASM_GENERIC_TICKET_LOCK_H */

Other than the nit above, the patch looks good to me.

Reviewed-by: Waiman Long <longman@redhat.com>

