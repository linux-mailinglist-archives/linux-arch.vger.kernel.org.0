Return-Path: <linux-arch+bounces-4649-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C684E8D8188
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 13:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3688A1F25ADC
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 11:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9FC8565A;
	Mon,  3 Jun 2024 11:49:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5883CC6;
	Mon,  3 Jun 2024 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415350; cv=none; b=Gs/eBRg9G7iG2n9aPupcaHQL8CRqi5zkRruVVkAXUrRZ0pALASW2I8oYHpAO+M7E0qgr42pWtvxTttTTp9Sx5gFTyz1p8geYBieP377AaV6w+3+t4WLbA2Si5RCClzzDkGK37GC/bqBmUY/W3wrD9uTUPudFOg9tJ4aD4TeUH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415350; c=relaxed/simple;
	bh=yCezOmk3y4Kupe9wHnDCE6p87HOowhmHy3OvWbiKBlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTSgbVzMdO8tFE+t2CjaeDGI/hIZJBRzb6OgrU7r8npbA3RqY7uluG1c34SqoxpnGyZ/glomV99QSuqArTQe7JDJ9hEwd5Z5nIrdYbg+T0X2ffB0chONhTj7RyY6CGW8XMoiq79GE6Z1snqCGWweMYqFQH2AXcXw4DyZYJAyTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85164C0009;
	Mon,  3 Jun 2024 11:49:03 +0000 (UTC)
Message-ID: <3130486a-2269-4e6e-821f-d1a643794c01@ghiti.fr>
Date: Mon, 3 Jun 2024 13:49:03 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] riscv: Add qspinlock support based on Zabha extension
Content-Language: en-US
To: Guo Ren <guoren@kernel.org>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Jonathan Corbet
 <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-8-alexghiti@rivosinc.com>
 <CAJF2gTQgg-7Fzoz9TsjWD-_8ABbS7M66aEztCsZ9Ejk8LOvmiQ@mail.gmail.com>
 <CAHVXubg=T3AMER0z8-iRqqFmDQp8iEM92cXwPZcW2Sfm=_KOHQ@mail.gmail.com>
 <CAJF2gTT51oZqEq-1TV_UEUufsrq=jRr4FAbmdtrChAHyUC1rXg@mail.gmail.com>
 <b6b6d273-4d57-4611-8c67-1a67d443b7d0@ghiti.fr>
 <CAJF2gTTiz_gkaA8OVkZynKUAFHFGij1W97qVSS3RKyMK5vkpdw@mail.gmail.com>
 <1cb05816-6f2f-4940-8051-b645f9f52c14@ghiti.fr>
 <CAJF2gTS-8KHs8LqiR70AxKQB9=sAZznXAXSbk=Q8PVwdKQSrbg@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAJF2gTS-8KHs8LqiR70AxKQB9=sAZznXAXSbk=Q8PVwdKQSrbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 03/06/2024 13:44, Guo Ren wrote:
> On Mon, Jun 3, 2024 at 7:34 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> On 03/06/2024 13:28, Guo Ren wrote:
>>> On Mon, Jun 3, 2024 at 5:49 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>> Hi Guo,
>>>>
>>>> On 31/05/2024 15:10, Guo Ren wrote:
>>>>> On Wed, May 29, 2024 at 9:03 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>>>>> Hi Guo,
>>>>>>
>>>>>> On Wed, May 29, 2024 at 11:24 AM Guo Ren <guoren@kernel.org> wrote:
>>>>>>> On Tue, May 28, 2024 at 11:18 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>>>>>>> In order to produce a generic kernel, a user can select
>>>>>>>> CONFIG_QUEUED_SPINLOCKS which will fallback at runtime to the ticket
>>>>>>>> spinlock implementation if Zabha is not present.
>>>>>>>>
>>>>>>>> Note that we can't use alternatives here because the discovery of
>>>>>>>> extensions is done too late and we need to start with the qspinlock
>>>>>>>> implementation because the ticket spinlock implementation would pollute
>>>>>>>> the spinlock value, so let's use static keys.
>>>>> Zabha is not a prerequisite for qspinlock; the prerequisite for
>>>>> qspinlock is the *forward progress guarantee* in the atomic operation
>>>>> loop during intense contention. Even with Zabha enabled to meet the
>>>>> requirements of xchg_tail, that still only applies when the number of
>>>>> CPUs is less than 16K. The qspinlock uses cmpxchg loop instead of
>>>>> xchg_tail when the number of cores is more than 16K. Thus, hardware
>>>>> support for Zabha does not equate to the safe use of qspinlock.
>>>> But if we have Zacas to implement cmpxchg(), we still provide the
>>>> "forward progress guarantee" then right? Let me know if I missed something.
>>> The qspinlock needs a "forward progress guarantee," not Zacas, and
>>> Zabha could give a guarantee to qspinlock xchg_tail (CPUs < 16K) with
>>> AMOSWAP.H instruction. But, using "LR/SC pairs" also could give enough
>>> fwd guarantee that depends on the micro-arch design of the riscv core.
>>> I think the help of AMO instead of LR/SC is it could off-load AMO
>>> operations from LSU to CIU(Next Level Cache or Interconnect), which
>>> gains better performance. "LR/SC pairs" only provide Near-Atomic, but
>>> AMO gives Far-Atomic additionally.
>>
>> I understand qspinlocks require forward progress and that your company's
>> LR/SC implementations provide such guarantee, I'm not arguing against
>> your new extension proposal.
>>
>> It seemed to me in your previous message that you implied that when
>> NR_CPUS > 16k, we should not use qspinlocks. My question was: "Don't
>> Zacas provide such guarantee"? I think it does, so qspinlocks should
>> actually depend on Zabha *and* Zacas. Is that correct to you?
> See kernel/locking/qspinlock.c
> #if _Q_PENDING_BITS == 8 (NR_CPUS < 16K)
> static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> {
>          /*
>           * We can use relaxed semantics since the caller ensures that the
>           * MCS node is properly initialized before updating the tail.
>           */
>          return (u32)xchg_relaxed(&lock->tail,
>                                   tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
> }
> #else /* NR_CPUS >= 16K */
> static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> {
>          u32 old, new;
>
>          old = atomic_read(&lock->val);
>          do {
>                  new = (old & _Q_LOCKED_PENDING_MASK) | tail;
>                  /*
>                   * We can use relaxed semantics since the caller ensures that
>                   * the MCS node is properly initialized before updating the
>                   * tail.
>                   */
>          } while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
>
>          return old;
> }
> #endif
>
> Look! You, Zacas, still need an additional FWD guarantee to break the
> loop. That is, how *stickiness* your cache line is?


But then the problem comes from this generic implementation of 
xchg_tail(), not from the arch cas implementation right?


>
>> Let me know if I misunderstood something again.
>>
>> Thanks,
>>
>> Alex
>>
>>
>>>
>>>> Thanks,
>>>>
>>>> Alex
>>>>
>>>>
>>>>> Therefore, I would like to propose a new ISA extension: Zafpg(Atomic
>>>>> Forward Progress Guarantee). If RISC-V vendors can ensure the progress
>>>>> of LR/SC or CMPXCHG LOOP at the microarchitectural level or if cache
>>>>> lines are sufficiently sticky, they could then claim support for this
>>>>> extension. Linux could then select different spinlock implementations
>>>>> based on this extension's support or not.
>>>>>
>>>>>>>> This is largely based on Guo's work and Leonardo reviews at [1].
>>>>>>>>
>>>>>>>> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]
>>>>>>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>>>>>>> ---
>>>>>>>>     .../locking/queued-spinlocks/arch-support.txt |  2 +-
>>>>>>>>     arch/riscv/Kconfig                            |  1 +
>>>>>>>>     arch/riscv/include/asm/Kbuild                 |  4 +-
>>>>>>>>     arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++++
>>>>>>>>     arch/riscv/kernel/setup.c                     | 18 +++++++++
>>>>>>>>     include/asm-generic/qspinlock.h               |  2 +
>>>>>>>>     include/asm-generic/ticket_spinlock.h         |  2 +
>>>>>>>>     7 files changed, 66 insertions(+), 2 deletions(-)
>>>>>>>>     create mode 100644 arch/riscv/include/asm/spinlock.h
>>>>>>>>
>>>>>>>> diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
>>>>>>>> index 22f2990392ff..cf26042480e2 100644
>>>>>>>> --- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
>>>>>>>> +++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
>>>>>>>> @@ -20,7 +20,7 @@
>>>>>>>>         |    openrisc: |  ok  |
>>>>>>>>         |      parisc: | TODO |
>>>>>>>>         |     powerpc: |  ok  |
>>>>>>>> -    |       riscv: | TODO |
>>>>>>>> +    |       riscv: |  ok  |
>>>>>>>>         |        s390: | TODO |
>>>>>>>>         |          sh: | TODO |
>>>>>>>>         |       sparc: |  ok  |
>>>>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>>>>>> index 184a9edb04e0..ccf1703edeb9 100644
>>>>>>>> --- a/arch/riscv/Kconfig
>>>>>>>> +++ b/arch/riscv/Kconfig
>>>>>>>> @@ -59,6 +59,7 @@ config RISCV
>>>>>>>>            select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
>>>>>>>>            select ARCH_USE_MEMTEST
>>>>>>>>            select ARCH_USE_QUEUED_RWLOCKS
>>>>>>>> +       select ARCH_USE_QUEUED_SPINLOCKS if TOOLCHAIN_HAS_ZABHA
>>>>>>> Using qspinlock or not depends on real hardware capabilities, not the
>>>>>>> compiler flag. That's why I introduced combo-spinlock, ticket-spinlock
>>>>>>> & qspinlock three Kconfigs, and the combo-spinlock would compat all
>>>>>>> hardware platforms but waste some qspinlock code size.
>>>>>> You're right, and I think your comment matches what Conor mentioned
>>>>>> about the lack of clarity with some extensions: TOOLCHAIN_HAS_ZABHA
>>>>>> will allow a platform with Zabha capability to use qspinlocks. But if
>>>>>> the hardware does not, it will fallback to the ticket spinlocks.
>>>>>>
>>>>>> But I agree that looking at the config alone may be misleading, even
>>>>>> though it will work as expected at runtime. So I agree with you:
>>>>>> unless anyone is strongly against the combo spinlocks, I will do what
>>>>>> you suggest and add them.
>>>>>>
>>>>>> Thanks again for your initial work,
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>>>            select ARCH_USES_CFI_TRAPS if CFI_CLANG
>>>>>>>>            select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
>>>>>>>>            select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>>>>>>>> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
>>>>>>>> index 504f8b7e72d4..ad72f2bd4cc9 100644
>>>>>>>> --- a/arch/riscv/include/asm/Kbuild
>>>>>>>> +++ b/arch/riscv/include/asm/Kbuild
>>>>>>>> @@ -2,10 +2,12 @@
>>>>>>>>     generic-y += early_ioremap.h
>>>>>>>>     generic-y += flat.h
>>>>>>>>     generic-y += kvm_para.h
>>>>>>>> +generic-y += mcs_spinlock.h
>>>>>>>>     generic-y += parport.h
>>>>>>>> -generic-y += spinlock.h
>>>>>>>>     generic-y += spinlock_types.h
>>>>>>>> +generic-y += ticket_spinlock.h
>>>>>>>>     generic-y += qrwlock.h
>>>>>>>>     generic-y += qrwlock_types.h
>>>>>>>> +generic-y += qspinlock.h
>>>>>>>>     generic-y += user.h
>>>>>>>>     generic-y += vmlinux.lds.h
>>>>>>>> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..e00429ac20ed
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/arch/riscv/include/asm/spinlock.h
>>>>>>>> @@ -0,0 +1,39 @@
>>>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>>>> +
>>>>>>>> +#ifndef __ASM_RISCV_SPINLOCK_H
>>>>>>>> +#define __ASM_RISCV_SPINLOCK_H
>>>>>>>> +
>>>>>>>> +#ifdef CONFIG_QUEUED_SPINLOCKS
>>>>>>>> +#define _Q_PENDING_LOOPS       (1 << 9)
>>>>>>>> +
>>>>>>>> +#define __no_arch_spinlock_redefine
>>>>>>>> +#include <asm/ticket_spinlock.h>
>>>>>>>> +#include <asm/qspinlock.h>
>>>>>>>> +#include <asm/alternative.h>
>>>>>>>> +
>>>>>>>> +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
>>>>>>>> +
>>>>>>>> +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                     \
>>>>>>>> +static __always_inline type arch_spin_##op(type_lock lock)             \
>>>>>>>> +{                                                                      \
>>>>>>>> +       if (static_branch_unlikely(&qspinlock_key))                     \
>>>>>>>> +               return queued_spin_##op(lock);                          \
>>>>>>>> +       return ticket_spin_##op(lock);                                  \
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
>>>>>>>> +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
>>>>>>>> +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
>>>>>>>> +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
>>>>>>>> +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
>>>>>>>> +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
>>>>>>>> +
>>>>>>>> +#else
>>>>>>>> +
>>>>>>>> +#include <asm/ticket_spinlock.h>
>>>>>>>> +
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>> +#include <asm/qrwlock.h>
>>>>>>>> +
>>>>>>>> +#endif /* __ASM_RISCV_SPINLOCK_H */
>>>>>>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>>>>>>> index 4f73c0ae44b2..31ce75522fd4 100644
>>>>>>>> --- a/arch/riscv/kernel/setup.c
>>>>>>>> +++ b/arch/riscv/kernel/setup.c
>>>>>>>> @@ -244,6 +244,23 @@ static void __init parse_dtb(void)
>>>>>>>>     #endif
>>>>>>>>     }
>>>>>>>>
>>>>>>>> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
>>>>>>>> +EXPORT_SYMBOL(qspinlock_key);
>>>>>>>> +
>>>>>>>> +static void __init riscv_spinlock_init(void)
>>>>>>>> +{
>>>>>>>> +       asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_EXT_ZABHA, 1)
>>>>>>>> +                : : : : qspinlock);
>>>>>>>> +
>>>>>>>> +       static_branch_disable(&qspinlock_key);
>>>>>>>> +       pr_info("Ticket spinlock: enabled\n");
>>>>>>>> +
>>>>>>>> +       return;
>>>>>>>> +
>>>>>>>> +qspinlock:
>>>>>>>> +       pr_info("Queued spinlock: enabled\n");
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>     extern void __init init_rt_signal_env(void);
>>>>>>>>
>>>>>>>>     void __init setup_arch(char **cmdline_p)
>>>>>>>> @@ -295,6 +312,7 @@ void __init setup_arch(char **cmdline_p)
>>>>>>>>            riscv_set_dma_cache_alignment();
>>>>>>>>
>>>>>>>>            riscv_user_isa_enable();
>>>>>>>> +       riscv_spinlock_init();
>>>>>>>>     }
>>>>>>>>
>>>>>>>>     bool arch_cpu_is_hotpluggable(int cpu)
>>>>>>>> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
>>>>>>>> index 0655aa5b57b2..bf47cca2c375 100644
>>>>>>>> --- a/include/asm-generic/qspinlock.h
>>>>>>>> +++ b/include/asm-generic/qspinlock.h
>>>>>>>> @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
>>>>>>>>     }
>>>>>>>>     #endif
>>>>>>>>
>>>>>>>> +#ifndef __no_arch_spinlock_redefine
>>>>>>>>     /*
>>>>>>>>      * Remapping spinlock architecture specific functions to the corresponding
>>>>>>>>      * queued spinlock functions.
>>>>>>>> @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
>>>>>>>>     #define arch_spin_lock(l)              queued_spin_lock(l)
>>>>>>>>     #define arch_spin_trylock(l)           queued_spin_trylock(l)
>>>>>>>>     #define arch_spin_unlock(l)            queued_spin_unlock(l)
>>>>>>>> +#endif
>>>>>>>>
>>>>>>>>     #endif /* __ASM_GENERIC_QSPINLOCK_H */
>>>>>>>> diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/ticket_spinlock.h
>>>>>>>> index cfcff22b37b3..325779970d8a 100644
>>>>>>>> --- a/include/asm-generic/ticket_spinlock.h
>>>>>>>> +++ b/include/asm-generic/ticket_spinlock.h
>>>>>>>> @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
>>>>>>>>            return (s16)((val >> 16) - (val & 0xffff)) > 1;
>>>>>>>>     }
>>>>>>>>
>>>>>>>> +#ifndef __no_arch_spinlock_redefine
>>>>>>>>     /*
>>>>>>>>      * Remapping spinlock architecture specific functions to the corresponding
>>>>>>>>      * ticket spinlock functions.
>>>>>>>> @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
>>>>>>>>     #define arch_spin_lock(l)              ticket_spin_lock(l)
>>>>>>>>     #define arch_spin_trylock(l)           ticket_spin_trylock(l)
>>>>>>>>     #define arch_spin_unlock(l)            ticket_spin_unlock(l)
>>>>>>>> +#endif
>>>>>>>>
>>>>>>>>     #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
>>>>>>>> --
>>>>>>>> 2.39.2
>>>>>>>>
>>>>>>> --
>>>>>>> Best Regards
>>>>>>>     Guo Ren
>>>
>
>

