Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861AF22825A
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 16:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgGUOg2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 10:36:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38236 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729162AbgGUOg1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jul 2020 10:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595342185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NycHO4cCvRulg7ZB9M1xTLI2cl8/0+geie9uWHt9/cE=;
        b=a7xqnZUuSH3CwlBWbCupdKoCpDN0vZaEXIRcD1ZrXxk33bYBZFloERqLPsBAi2vFcvtoly
        6bI2sSNIhWUW//3doyPYQh1lODTFnogW15/R66JZpRA3Li2nC/zcTAcaHWdvl7jTjbXRtc
        GlornLz9Gf6CIlBY3VZAgsom4LxEgkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-Zm_0Vb-1P1eJUlH4iKjACg-1; Tue, 21 Jul 2020 10:36:22 -0400
X-MC-Unique: Zm_0Vb-1P1eJUlH4iKjACg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE3FE80183C;
        Tue, 21 Jul 2020 14:36:19 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-32.rdu2.redhat.com [10.10.115.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A76752B6E2;
        Tue, 21 Jul 2020 14:36:16 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
To:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <20200708084106.GE597537@hirez.programming.kicks-ass.net>
 <1595327263.lk78cqolxm.astroid@bobo.none>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <eaabf501-80fe-dd15-c03c-f75ce4f75877@redhat.com>
Date:   Tue, 21 Jul 2020 10:36:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1595327263.lk78cqolxm.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/21/20 7:08 AM, Nicholas Piggin wrote:
> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
> index b752d34517b3..26d8766a1106 100644
> --- a/arch/powerpc/include/asm/qspinlock.h
> +++ b/arch/powerpc/include/asm/qspinlock.h
> @@ -31,16 +31,57 @@ static inline void queued_spin_unlock(struct qspinlock *lock)
>   
>   #else
>   extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> +extern void queued_spin_lock_slowpath_queue(struct qspinlock *lock);
>   #endif
>   
>   static __always_inline void queued_spin_lock(struct qspinlock *lock)
>   {
> -	u32 val = 0;
> -
> -	if (likely(atomic_try_cmpxchg_lock(&lock->val, &val, _Q_LOCKED_VAL)))
> +	atomic_t *a = &lock->val;
> +	u32 val;
> +
> +again:
> +	asm volatile(
> +"1:\t"	PPC_LWARX(%0,0,%1,1) "	# queued_spin_lock			\n"
> +	: "=&r" (val)
> +	: "r" (&a->counter)
> +	: "memory");
> +
> +	if (likely(val == 0)) {
> +		asm_volatile_goto(
> +	"	stwcx.	%0,0,%1							\n"
> +	"	bne-	%l[again]						\n"
> +	"\t"	PPC_ACQUIRE_BARRIER "						\n"
> +		:
> +		: "r"(_Q_LOCKED_VAL), "r" (&a->counter)
> +		: "cr0", "memory"
> +		: again );
>   		return;
> -
> -	queued_spin_lock_slowpath(lock, val);
> +	}
> +
> +	if (likely(val == _Q_LOCKED_VAL)) {
> +		asm_volatile_goto(
> +	"	stwcx.	%0,0,%1							\n"
> +	"	bne-	%l[again]						\n"
> +		:
> +		: "r"(_Q_LOCKED_VAL | _Q_PENDING_VAL), "r" (&a->counter)
> +		: "cr0", "memory"
> +		: again );
> +
> +		atomic_cond_read_acquire(a, !(VAL & _Q_LOCKED_MASK));
> +//		clear_pending_set_locked(lock);
> +		WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
> +//		lockevent_inc(lock_pending);
> +		return;
> +	}
> +
> +	if (val == _Q_PENDING_VAL) {
> +		int cnt = _Q_PENDING_LOOPS;
> +		val = atomic_cond_read_relaxed(a,
> +					       (VAL != _Q_PENDING_VAL) || !cnt--);
> +		if (!(val & ~_Q_LOCKED_MASK))
> +			goto again;
> +        }
> +	queued_spin_lock_slowpath_queue(lock);
>   }
>   #define queued_spin_lock queued_spin_lock
>   

I am fine with the arch code override some part of the generic code.


> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index b9515fcc9b29..ebcc6f5d99d5 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -287,10 +287,14 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
>   
>   #ifdef CONFIG_PARAVIRT_SPINLOCKS
>   #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
> +#define queued_spin_lock_slowpath_queue	native_queued_spin_lock_slowpath_queue
>   #endif
>   
>   #endif /* _GEN_PV_LOCK_SLOWPATH */
>   
> +void queued_spin_lock_slowpath_queue(struct qspinlock *lock);
> +static void __queued_spin_lock_slowpath_queue(struct qspinlock *lock);
> +
>   /**
>    * queued_spin_lock_slowpath - acquire the queued spinlock
>    * @lock: Pointer to queued spinlock structure
> @@ -314,12 +318,6 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
>    */
>   void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>   {
> -	struct mcs_spinlock *prev, *next, *node;
> -	u32 old, tail;
> -	int idx;
> -
> -	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
> -
>   	if (pv_enabled())
>   		goto pv_queue;
>   
> @@ -397,6 +395,26 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>   queue:
>   	lockevent_inc(lock_slowpath);
>   pv_queue:
> +	__queued_spin_lock_slowpath_queue(lock);
> +}
> +EXPORT_SYMBOL(queued_spin_lock_slowpath);
> +
> +void queued_spin_lock_slowpath_queue(struct qspinlock *lock)
> +{
> +	lockevent_inc(lock_slowpath);
> +	__queued_spin_lock_slowpath_queue(lock);
> +}
> +EXPORT_SYMBOL(queued_spin_lock_slowpath_queue);
> +
> +static void __queued_spin_lock_slowpath_queue(struct qspinlock *lock)
> +{
> +	struct mcs_spinlock *prev, *next, *node;
> +	u32 old, tail;
> +	u32 val;
> +	int idx;
> +
> +	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
> +
>   	node = this_cpu_ptr(&qnodes[0].mcs);
>   	idx = node->count++;
>   	tail = encode_tail(smp_processor_id(), idx);
> @@ -559,7 +577,6 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>   	 */
>   	__this_cpu_dec(qnodes[0].mcs.count);
>   }
> -EXPORT_SYMBOL(queued_spin_lock_slowpath);
>   
>   /*
>    * Generate the paravirt code for queued_spin_unlock_slowpath().
>
I would prefer to extract out the pending bit handling code out into a 
separate helper function which can be overridden by the arch code 
instead of breaking the slowpath into 2 pieces.

Cheers,
Longman

