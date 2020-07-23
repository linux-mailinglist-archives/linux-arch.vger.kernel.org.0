Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3784322B081
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 15:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgGWNaQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 09:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWNaQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 09:30:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD51C0619DC;
        Thu, 23 Jul 2020 06:30:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a23so2999953pfk.13;
        Thu, 23 Jul 2020 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Td5n8VLQM5VzC3/ySr0x0FkE92YfVlucA4U3oDMBrpc=;
        b=nJOThBN3e0u2wPmuKSDicZ+MnhpMP1D4iUV1NevDGUNLVV/pnTf9+zsjxy0Qbbio20
         0MiiX36MZ0ZC4E71DLYgt/cADBAmI3H4MzayuAZG7DzEI7kaA9e9QwPC8lL1JqZQP+NL
         9MGVBFha1s2QXAWnx1C1AGhlwjqS8hcx22i1c5WfIxY0DFbIb6mc4Y32KjmVk6PiLbeG
         GoPigoJt0ecu9QSJzK2R1EDHjtsTbmfloVX4mn/0GnuomG5yEie0b35EjQ2/6Q5Wp5I4
         n22LyNjNL9sMD5ZFQyhsBEiiaJmT4JxbN546p048mlxo3r6w7CQPF4aegWwn/eZpecgd
         nubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Td5n8VLQM5VzC3/ySr0x0FkE92YfVlucA4U3oDMBrpc=;
        b=U68f/gtFbtKvxUV4sgZu50k/fSeTm4DtrirRpfbUyK4su/4G5G1A3SNpQoHpSvyGVP
         Rck4bvwmFQu0Nr4oJ4eWoprP1coRx4V4UiWGQWZCrzbNge2U8VwwIDRS6rP3sDjJFbxq
         WtjrJ59/F3KwsklIx53SFAT9e8/Jj0iFyrnpOVc5d6XnGkcseyO4Ih25dP2AfzEeB6Hy
         CwISqokUaL7Tz6h4pFAkKaujX/Iy5cfn+hAtHxDH6+wUccT4Bh3JELejirwfAeLB4DOy
         bJBoCg0Kezux068UVQ4ATVF2YX5fFEeneRXxizBqhhGkQlSf+C0wl2VHCKHSpElk5Zrn
         Nlcw==
X-Gm-Message-State: AOAM533F0BAA4DNKQ5IgW/j+pZS8GXD8niPAepCJ3VrSjUncyO7cmP4G
        gATIZPUhVTIAD5IDzPuio7I=
X-Google-Smtp-Source: ABdhPJzDRciPPyx06p/TELG6ZbrzJ5oreW4i8vpZMSYQR38q69s9sCgkLuLjxZA90YTp1MLQk8mQMQ==
X-Received: by 2002:a65:644d:: with SMTP id s13mr4226469pgv.103.1595511015960;
        Thu, 23 Jul 2020 06:30:15 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id u26sm3148320pfn.54.2020.07.23.06.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 06:30:15 -0700 (PDT)
Date:   Thu, 23 Jul 2020 23:30:09 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
To:     Waiman Long <longman@redhat.com>,
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
        <eaabf501-80fe-dd15-c03c-f75ce4f75877@redhat.com>
In-Reply-To: <eaabf501-80fe-dd15-c03c-f75ce4f75877@redhat.com>
MIME-Version: 1.0
Message-Id: <1595510571.u39qfc8d1o.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Waiman Long's message of July 22, 2020 12:36 am:
> On 7/21/20 7:08 AM, Nicholas Piggin wrote:
>> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include=
/asm/qspinlock.h
>> index b752d34517b3..26d8766a1106 100644
>> --- a/arch/powerpc/include/asm/qspinlock.h
>> +++ b/arch/powerpc/include/asm/qspinlock.h
>> @@ -31,16 +31,57 @@ static inline void queued_spin_unlock(struct qspinlo=
ck *lock)
>>  =20
>>   #else
>>   extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)=
;
>> +extern void queued_spin_lock_slowpath_queue(struct qspinlock *lock);
>>   #endif
>>  =20
>>   static __always_inline void queued_spin_lock(struct qspinlock *lock)
>>   {
>> -	u32 val =3D 0;
>> -
>> -	if (likely(atomic_try_cmpxchg_lock(&lock->val, &val, _Q_LOCKED_VAL)))
>> +	atomic_t *a =3D &lock->val;
>> +	u32 val;
>> +
>> +again:
>> +	asm volatile(
>> +"1:\t"	PPC_LWARX(%0,0,%1,1) "	# queued_spin_lock			\n"
>> +	: "=3D&r" (val)
>> +	: "r" (&a->counter)
>> +	: "memory");
>> +
>> +	if (likely(val =3D=3D 0)) {
>> +		asm_volatile_goto(
>> +	"	stwcx.	%0,0,%1							\n"
>> +	"	bne-	%l[again]						\n"
>> +	"\t"	PPC_ACQUIRE_BARRIER "						\n"
>> +		:
>> +		: "r"(_Q_LOCKED_VAL), "r" (&a->counter)
>> +		: "cr0", "memory"
>> +		: again );
>>   		return;
>> -
>> -	queued_spin_lock_slowpath(lock, val);
>> +	}
>> +
>> +	if (likely(val =3D=3D _Q_LOCKED_VAL)) {
>> +		asm_volatile_goto(
>> +	"	stwcx.	%0,0,%1							\n"
>> +	"	bne-	%l[again]						\n"
>> +		:
>> +		: "r"(_Q_LOCKED_VAL | _Q_PENDING_VAL), "r" (&a->counter)
>> +		: "cr0", "memory"
>> +		: again );
>> +
>> +		atomic_cond_read_acquire(a, !(VAL & _Q_LOCKED_MASK));
>> +//		clear_pending_set_locked(lock);
>> +		WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
>> +//		lockevent_inc(lock_pending);
>> +		return;
>> +	}
>> +
>> +	if (val =3D=3D _Q_PENDING_VAL) {
>> +		int cnt =3D _Q_PENDING_LOOPS;
>> +		val =3D atomic_cond_read_relaxed(a,
>> +					       (VAL !=3D _Q_PENDING_VAL) || !cnt--);
>> +		if (!(val & ~_Q_LOCKED_MASK))
>> +			goto again;
>> +        }
>> +	queued_spin_lock_slowpath_queue(lock);
>>   }
>>   #define queued_spin_lock queued_spin_lock
>>  =20
>=20
> I am fine with the arch code override some part of the generic code.

Cool.

>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index b9515fcc9b29..ebcc6f5d99d5 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -287,10 +287,14 @@ static __always_inline u32  __pv_wait_head_or_lock=
(struct qspinlock *lock,
>>  =20
>>   #ifdef CONFIG_PARAVIRT_SPINLOCKS
>>   #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
>> +#define queued_spin_lock_slowpath_queue	native_queued_spin_lock_slowpat=
h_queue
>>   #endif
>>  =20
>>   #endif /* _GEN_PV_LOCK_SLOWPATH */
>>  =20
>> +void queued_spin_lock_slowpath_queue(struct qspinlock *lock);
>> +static void __queued_spin_lock_slowpath_queue(struct qspinlock *lock);
>> +
>>   /**
>>    * queued_spin_lock_slowpath - acquire the queued spinlock
>>    * @lock: Pointer to queued spinlock structure
>> @@ -314,12 +318,6 @@ static __always_inline u32  __pv_wait_head_or_lock(=
struct qspinlock *lock,
>>    */
>>   void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>   {
>> -	struct mcs_spinlock *prev, *next, *node;
>> -	u32 old, tail;
>> -	int idx;
>> -
>> -	BUILD_BUG_ON(CONFIG_NR_CPUS >=3D (1U << _Q_TAIL_CPU_BITS));
>> -
>>   	if (pv_enabled())
>>   		goto pv_queue;
>>  =20
>> @@ -397,6 +395,26 @@ void queued_spin_lock_slowpath(struct qspinlock *lo=
ck, u32 val)
>>   queue:
>>   	lockevent_inc(lock_slowpath);
>>   pv_queue:
>> +	__queued_spin_lock_slowpath_queue(lock);
>> +}
>> +EXPORT_SYMBOL(queued_spin_lock_slowpath);
>> +
>> +void queued_spin_lock_slowpath_queue(struct qspinlock *lock)
>> +{
>> +	lockevent_inc(lock_slowpath);
>> +	__queued_spin_lock_slowpath_queue(lock);
>> +}
>> +EXPORT_SYMBOL(queued_spin_lock_slowpath_queue);
>> +
>> +static void __queued_spin_lock_slowpath_queue(struct qspinlock *lock)
>> +{
>> +	struct mcs_spinlock *prev, *next, *node;
>> +	u32 old, tail;
>> +	u32 val;
>> +	int idx;
>> +
>> +	BUILD_BUG_ON(CONFIG_NR_CPUS >=3D (1U << _Q_TAIL_CPU_BITS));
>> +
>>   	node =3D this_cpu_ptr(&qnodes[0].mcs);
>>   	idx =3D node->count++;
>>   	tail =3D encode_tail(smp_processor_id(), idx);
>> @@ -559,7 +577,6 @@ void queued_spin_lock_slowpath(struct qspinlock *loc=
k, u32 val)
>>   	 */
>>   	__this_cpu_dec(qnodes[0].mcs.count);
>>   }
>> -EXPORT_SYMBOL(queued_spin_lock_slowpath);
>>  =20
>>   /*
>>    * Generate the paravirt code for queued_spin_unlock_slowpath().
>>
> I would prefer to extract out the pending bit handling code out into a=20
> separate helper function which can be overridden by the arch code=20
> instead of breaking the slowpath into 2 pieces.

You mean have the arch provide a queued_spin_lock_slowpath_pending=20
function that the slow path calls?

I would actually prefer the pending handling can be made inline in
the queued_spin_lock function, especially with out-of-line locks it=20
makes sense to put it there.

We could ifdef out queued_spin_lock_slowpath_queue if it's not used,
then __queued_spin_lock_slowpath_queue would be inlined into the
caller so there would be no split?

Thanks,
Nick
