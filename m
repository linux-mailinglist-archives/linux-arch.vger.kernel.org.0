Return-Path: <linux-arch+bounces-4643-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BDC8D7E69
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 11:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AAE28306C
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 09:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22F47F7D1;
	Mon,  3 Jun 2024 09:22:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF556BFA7;
	Mon,  3 Jun 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406527; cv=none; b=R1I5K6p4qkrbrXPJGibPppYpDT3a0zqhPU0VwV5iAXjBb/CidRNnDDkQL/09xx8p0KfDfdcs4tcqHx2iVL1/RlpoSvSqugP0s470myTQR8jrQJ4TBV6VS/mC0mI6HMqVeEnrVF2hFre10KnOyk2d6RYErOJ6DCtpioqJBznld+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406527; c=relaxed/simple;
	bh=eO007ahsU76TA5vzcldIle7ry1ZjCcPqs5Xf2h+2Ff8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJV4pLRuAR0hCqoTabO8i17SZ/bJyLLUPezEOgw2Qv84UzxAWkrH+sxmAVFMEXYgqiY1VSbzL4LIMQkV8c7tE4R9CdGoODJEP+F7iBg0sL7en9ou76n3ud0v9H/ZoORdzsMS/CzOb50wztP9WkSQjXhlhlRTnTCcPZ/WDVTIqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DDDAFF80F;
	Mon,  3 Jun 2024 09:21:54 +0000 (UTC)
Message-ID: <6adf71fb-287b-490c-b7b0-4f8fa4fc1560@ghiti.fr>
Date: Mon, 3 Jun 2024 11:21:53 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] riscv: Add qspinlock support based on Zabha extension
Content-Language: en-US
To: Guo Ren <guoren@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-8-alexghiti@rivosinc.com>
 <CAJF2gTQgg-7Fzoz9TsjWD-_8ABbS7M66aEztCsZ9Ejk8LOvmiQ@mail.gmail.com>
 <CAHVXubg=T3AMER0z8-iRqqFmDQp8iEM92cXwPZcW2Sfm=_KOHQ@mail.gmail.com>
 <CAJF2gTRWSZsD3vDcXvawCxt665PZcbwurUqXx3juaoZaDrdttQ@mail.gmail.com>
 <CAHVXubiE2_MJgTj4nq7Vkv0D60niRgZ0QkCXNz6PiNQ8h+Wy1A@mail.gmail.com>
 <CAJF2gTTM1=cP9yB_3xs20pN_vscEe+WzuOUyTMB1UPU3aYMZEQ@mail.gmail.com>
 <CAHVXubh+mK3VHT3zB=9MDudNd5gDQLbT0NqfEedqY=dG43or6A@mail.gmail.com>
 <CAJF2gTR6y3K3RGE_n_Efr=LasYtCK9dHE5VPscbzz7P9yHHHww@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAJF2gTR6y3K3RGE_n_Efr=LasYtCK9dHE5VPscbzz7P9yHHHww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Guo,

On 31/05/2024 08:42, Guo Ren wrote:
> On Fri, May 31, 2024 at 2:22 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> On Fri, May 31, 2024 at 3:57 AM Guo Ren <guoren@kernel.org> wrote:
>>> On Thu, May 30, 2024 at 1:30 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>>> Hi Guo,
>>>>
>>>> On Thu, May 30, 2024 at 3:55 AM Guo Ren <guoren@kernel.org> wrote:
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
>>>>>>>>
>>>>>>>> This is largely based on Guo's work and Leonardo reviews at [1].
>>>>>>>>
>>>>>>>> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]
>>>>>>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>>>>>>> ---
>>>>>>>>   .../locking/queued-spinlocks/arch-support.txt |  2 +-
>>>>>>>>   arch/riscv/Kconfig                            |  1 +
>>>>>>>>   arch/riscv/include/asm/Kbuild                 |  4 +-
>>>>>>>>   arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++++
>>>>>>>>   arch/riscv/kernel/setup.c                     | 18 +++++++++
>>>>>>>>   include/asm-generic/qspinlock.h               |  2 +
>>>>>>>>   include/asm-generic/ticket_spinlock.h         |  2 +
>>>>>>>>   7 files changed, 66 insertions(+), 2 deletions(-)
>>>>>>>>   create mode 100644 arch/riscv/include/asm/spinlock.h
>>>>>>>>
>>>>>>>> diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
>>>>>>>> index 22f2990392ff..cf26042480e2 100644
>>>>>>>> --- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
>>>>>>>> +++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
>>>>>>>> @@ -20,7 +20,7 @@
>>>>>>>>       |    openrisc: |  ok  |
>>>>>>>>       |      parisc: | TODO |
>>>>>>>>       |     powerpc: |  ok  |
>>>>>>>> -    |       riscv: | TODO |
>>>>>>>> +    |       riscv: |  ok  |
>>>>>>>>       |        s390: | TODO |
>>>>>>>>       |          sh: | TODO |
>>>>>>>>       |       sparc: |  ok  |
>>>>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>>>>>> index 184a9edb04e0..ccf1703edeb9 100644
>>>>>>>> --- a/arch/riscv/Kconfig
>>>>>>>> +++ b/arch/riscv/Kconfig
>>>>>>>> @@ -59,6 +59,7 @@ config RISCV
>>>>>>>>          select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
>>>>>>>>          select ARCH_USE_MEMTEST
>>>>>>>>          select ARCH_USE_QUEUED_RWLOCKS
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
>>>>> The problem with the v12 combo-spinlock is using a static_branch
>>>>> instead of the full ALTERNATIVE. Frankly, that's a bad example that
>>>>> costs more code space. I found that your cmpxchg32/64 also uses a
>>>>> condition branch, which has a similar problem, right?
>>>>>
>>>>> Anyway, your patch series inspired me to update the v13
>>>>> combo-spinlock. My plan is:
>>>>> 1. Separate native-qspinlock out of paravirt-qspinlock.
>>>>> 2. Re-design an ALTERNATIVE(asm) code instead of static_branch generic
>>>>> ticket-lock or qspinlock.
>>>> What's your plan to make use of alternatives here? The alternatives
>>>> patching depends on the discovery of the extensions, which is done too
>>>> late, at least after the first use of a spinlock (the printk
>>>> spinlock). So you'd need to find a way to first use qspinlocks (but
>>>> without knowing Zabha is available) and then do the correct patching:
>>> I do that in v12:
>>> 1. Use qspinlock as init.
>>> 2. Change to ticket-lock or not.
>>> (Only qspinlock -> ticket-lock, No reverse direction)
>>>
>>> If there is no contention, Qspinlock is okay for all platforms before
>>> smp bringup & no-irq environment.
>>>
>> Yes, by using static keys not alternatives. My question was: how do
>> you plan to use alternatives here instead of static keys? To me, it's
>> not that simple, hence my suggestions in my previous answer.
> Yes, it's not that simple. The current framework doesn't support that
> and has two problems:
> 1. We need to re-implement ticket-lock & qspinlock-fast-path with assembly code.
> 2. Current alternatives patching only for extensions, but qspinlock is
> not a formal extension. Could we accept
> __RISCV_ISA_EXT_DATA(xqspinlock, RISCV_ISA_EXT_XQSPINLOCK)?


But the problem is that the alternatives needs to patch the code very 
early in the boot process which is not possible since we don't have the 
list of extensions yet (for ACPI systems), so your 
RISCV_ISA_EXT_XQSPINLOCK proposal would not help.

Thanks,

Alex


>
>> Thanks,
>>
>> Alex
>>
>>>> an idea here could be to add an "init" value to the alternatives and
>>>> let the patching process do the right thing when the extensions are
>>>> known.
>>>>
>>>> Another solution would be the early discovery of the extensions, but I
>>>> took a look and it's easy with a device tree, but not with ACPI.
>>>>
>>>> Let me know what you plan to do and how I can help!
>>>>
>>>> Thanks,
>>>>
>>>> Alex
>>>>
>>>>> What do you think?
>>>>>
>>>>>
>>>>>> Thanks again for your initial work,
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>>>          select ARCH_USES_CFI_TRAPS if CFI_CLANG
>>>>>>>>          select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
>>>>>>>>          select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>>>>>>>> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
>>>>>>>> index 504f8b7e72d4..ad72f2bd4cc9 100644
>>>>>>>> --- a/arch/riscv/include/asm/Kbuild
>>>>>>>> +++ b/arch/riscv/include/asm/Kbuild
>>>>>>>> @@ -2,10 +2,12 @@
>>>>>>>>   generic-y += early_ioremap.h
>>>>>>>>   generic-y += flat.h
>>>>>>>>   generic-y += kvm_para.h
>>>>>>>> +generic-y += mcs_spinlock.h
>>>>>>>>   generic-y += parport.h
>>>>>>>> -generic-y += spinlock.h
>>>>>>>>   generic-y += spinlock_types.h
>>>>>>>> +generic-y += ticket_spinlock.h
>>>>>>>>   generic-y += qrwlock.h
>>>>>>>>   generic-y += qrwlock_types.h
>>>>>>>> +generic-y += qspinlock.h
>>>>>>>>   generic-y += user.h
>>>>>>>>   generic-y += vmlinux.lds.h
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
>>>>>>>>   #endif
>>>>>>>>   }
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
>>>>>>>>   extern void __init init_rt_signal_env(void);
>>>>>>>>
>>>>>>>>   void __init setup_arch(char **cmdline_p)
>>>>>>>> @@ -295,6 +312,7 @@ void __init setup_arch(char **cmdline_p)
>>>>>>>>          riscv_set_dma_cache_alignment();
>>>>>>>>
>>>>>>>>          riscv_user_isa_enable();
>>>>>>>> +       riscv_spinlock_init();
>>>>>>>>   }
>>>>>>>>
>>>>>>>>   bool arch_cpu_is_hotpluggable(int cpu)
>>>>>>>> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
>>>>>>>> index 0655aa5b57b2..bf47cca2c375 100644
>>>>>>>> --- a/include/asm-generic/qspinlock.h
>>>>>>>> +++ b/include/asm-generic/qspinlock.h
>>>>>>>> @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
>>>>>>>>   }
>>>>>>>>   #endif
>>>>>>>>
>>>>>>>> +#ifndef __no_arch_spinlock_redefine
>>>>>>>>   /*
>>>>>>>>    * Remapping spinlock architecture specific functions to the corresponding
>>>>>>>>    * queued spinlock functions.
>>>>>>>> @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
>>>>>>>>   #define arch_spin_lock(l)              queued_spin_lock(l)
>>>>>>>>   #define arch_spin_trylock(l)           queued_spin_trylock(l)
>>>>>>>>   #define arch_spin_unlock(l)            queued_spin_unlock(l)
>>>>>>>> +#endif
>>>>>>>>
>>>>>>>>   #endif /* __ASM_GENERIC_QSPINLOCK_H */
>>>>>>>> diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/ticket_spinlock.h
>>>>>>>> index cfcff22b37b3..325779970d8a 100644
>>>>>>>> --- a/include/asm-generic/ticket_spinlock.h
>>>>>>>> +++ b/include/asm-generic/ticket_spinlock.h
>>>>>>>> @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
>>>>>>>>          return (s16)((val >> 16) - (val & 0xffff)) > 1;
>>>>>>>>   }
>>>>>>>>
>>>>>>>> +#ifndef __no_arch_spinlock_redefine
>>>>>>>>   /*
>>>>>>>>    * Remapping spinlock architecture specific functions to the corresponding
>>>>>>>>    * ticket spinlock functions.
>>>>>>>> @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
>>>>>>>>   #define arch_spin_lock(l)              ticket_spin_lock(l)
>>>>>>>>   #define arch_spin_trylock(l)           ticket_spin_trylock(l)
>>>>>>>>   #define arch_spin_unlock(l)            ticket_spin_unlock(l)
>>>>>>>> +#endif
>>>>>>>>
>>>>>>>>   #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
>>>>>>>> --
>>>>>>>> 2.39.2
>>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Best Regards
>>>>>>>   Guo Ren
>>>>>
>>>>>
>>>>> --
>>>>> Best Regards
>>>>>   Guo Ren
>>>
>>>
>>> --
>>> Best Regards
>>>   Guo Ren
>
>

