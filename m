Return-Path: <linux-arch+bounces-5498-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72AA934DD7
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 15:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B5F1C21C1C
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016D13D28C;
	Thu, 18 Jul 2024 13:11:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6213C802;
	Thu, 18 Jul 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308303; cv=none; b=k/xA8hI93JVO1vNe5JpiA3xmEZoGn0PLna3DEjPCpydQiRr/1zMFyOPHwRc7INPr2IZJFdadHqeGsxeIxFG+evFbaUd2HpEy3+NmLowhjmnISrN/4Lr9mROpomogtqxJQYLUub9z8pmnjYJZemH5a3SJn/yz4O+nJt/jhDntuL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308303; c=relaxed/simple;
	bh=h8nVFlgb9Xd54gcrrMTusWTBlTcF4WJ91u1miu+YWIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/DBPFaQ9fxMiVxK40UBEj4PjZD1ZFM6L/EVCm2Hv7kdLYpnAcx4TuOwcVizeBKrRq1snVCVFcQw7RnbNsWwJOJrxrphkzWiWFzzU4Fcu33/6OmkP2qgSgiZoxVVOqKiUDVnwFIKIFHbNYrrGdKGuLIwT+/Cb7I/W+Gl/ObyQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04B676000B;
	Thu, 18 Jul 2024 13:11:32 +0000 (UTC)
Message-ID: <8b817513-a901-4445-b523-54ad8ceaf8c8@ghiti.fr>
Date: Thu, 18 Jul 2024 15:11:32 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] riscv: Add qspinlock support
Content-Language: en-US
To: Guo Ren <guoren@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-12-alexghiti@rivosinc.com>
 <CAJF2gTQtT5KxpjjOs5QMcrxz6wEKTjHgxrgXZvXy1HbQ3AhhTQ@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAJF2gTQtT5KxpjjOs5QMcrxz6wEKTjHgxrgXZvXy1HbQ3AhhTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Guo,

On 17/07/2024 11:30, Guo Ren wrote:
> On Wed, Jul 17, 2024 at 2:31 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> In order to produce a generic kernel, a user can select
>> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
>> spinlock implementation if Zabha or Ziccrse are not present.
>>
>> Note that we can't use alternatives here because the discovery of
>> extensions is done too late and we need to start with the qspinlock
>> implementation because the ticket spinlock implementation would pollute
>> the spinlock value, so let's use static keys.
>>
>> This is largely based on Guo's work and Leonardo reviews at [1].
>>
>> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]
>> Signed-off-by: Guo Ren <guoren@kernel.org>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   .../locking/queued-spinlocks/arch-support.txt |  2 +-
>>   arch/riscv/Kconfig                            | 29 ++++++++++++++
>>   arch/riscv/include/asm/Kbuild                 |  4 +-
>>   arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++++
>>   arch/riscv/kernel/setup.c                     | 33 ++++++++++++++++
>>   include/asm-generic/qspinlock.h               |  2 +
>>   include/asm-generic/ticket_spinlock.h         |  2 +
>>   7 files changed, 109 insertions(+), 2 deletions(-)
>>   create mode 100644 arch/riscv/include/asm/spinlock.h
>>
>> diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
>> index 22f2990392ff..cf26042480e2 100644
>> --- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
>> +++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
>> @@ -20,7 +20,7 @@
>>       |    openrisc: |  ok  |
>>       |      parisc: | TODO |
>>       |     powerpc: |  ok  |
>> -    |       riscv: | TODO |
>> +    |       riscv: |  ok  |
>>       |        s390: | TODO |
>>       |          sh: | TODO |
>>       |       sparc: |  ok  |
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 0bbaec0444d0..5040c7eac70d 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -72,6 +72,7 @@ config RISCV
>>          select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>>          select ARCH_WANTS_NO_INSTR
>>          select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
>> +       select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
>>          select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>>          select BUILDTIME_TABLE_SORT if MMU
>>          select CLINT_TIMER if RISCV_M_MODE
>> @@ -482,6 +483,34 @@ config NODES_SHIFT
>>            Specify the maximum number of NUMA Nodes available on the target
>>            system.  Increases memory reserved to accommodate various tables.
>>
>> +choice
>> +       prompt "RISC-V spinlock type"
>> +       default RISCV_COMBO_SPINLOCKS
>> +
>> +config RISCV_TICKET_SPINLOCKS
>> +       bool "Using ticket spinlock"
>> +
>> +config RISCV_QUEUED_SPINLOCKS
>> +       bool "Using queued spinlock"
>> +       depends on SMP && MMU
>> +       select ARCH_USE_QUEUED_SPINLOCKS
>> +       help
>> +         The queued spinlock implementation requires the forward progress
>> +         guarantee of cmpxchg()/xchg() atomic operations: CAS with Zabha or
>> +         LR/SC with Ziccrse provide such guarantee.
>> +
>> +         Select this if and only if Zabha or Ziccrse is available on your
>> +         platform.
>> +
>> +config RISCV_COMBO_SPINLOCKS
>> +       bool "Using combo spinlock"
>> +       depends on SMP && MMU
>> +       select ARCH_USE_QUEUED_SPINLOCKS
>> +       help
>> +         Embed both queued spinlock and ticket lock so that the spinlock
>> +         implementation can be chosen at runtime.
>> +endchoice
>> +
>>   config RISCV_ALTERNATIVE
>>          bool
>>          depends on !XIP_KERNEL
>> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
>> index 504f8b7e72d4..ad72f2bd4cc9 100644
>> --- a/arch/riscv/include/asm/Kbuild
>> +++ b/arch/riscv/include/asm/Kbuild
>> @@ -2,10 +2,12 @@
>>   generic-y += early_ioremap.h
>>   generic-y += flat.h
>>   generic-y += kvm_para.h
>> +generic-y += mcs_spinlock.h
>>   generic-y += parport.h
>> -generic-y += spinlock.h
>>   generic-y += spinlock_types.h
>> +generic-y += ticket_spinlock.h
>>   generic-y += qrwlock.h
>>   generic-y += qrwlock_types.h
>> +generic-y += qspinlock.h
>>   generic-y += user.h
>>   generic-y += vmlinux.lds.h
>> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
>> new file mode 100644
>> index 000000000000..4856d50006f2
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/spinlock.h
>> @@ -0,0 +1,39 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __ASM_RISCV_SPINLOCK_H
>> +#define __ASM_RISCV_SPINLOCK_H
>> +
>> +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
>> +#define _Q_PENDING_LOOPS       (1 << 9)
>> +
>> +#define __no_arch_spinlock_redefine
>> +#include <asm/ticket_spinlock.h>
>> +#include <asm/qspinlock.h>
>> +#include <asm/alternative.h>
>> +
>> +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
>> +
>> +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                     \
>> +static __always_inline type arch_spin_##op(type_lock lock)             \
>> +{                                                                      \
>> +       if (static_branch_unlikely(&qspinlock_key))                     \
>> +               return queued_spin_##op(lock);                          \
>> +       return ticket_spin_##op(lock);                                  \
>> +}
>> +
>> +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
>> +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
>> +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
>> +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
>> +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
>> +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
>> +
>> +#else
>> +
>> +#include <asm/ticket_spinlock.h>
>> +
>> +#endif
>> +
>> +#include <asm/qrwlock.h>
>> +
>> +#endif /* __ASM_RISCV_SPINLOCK_H */
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 4f73c0ae44b2..d7c31c9b8ead 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -244,6 +244,38 @@ static void __init parse_dtb(void)
>>   #endif
>>   }
>>
>> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
>> +EXPORT_SYMBOL(qspinlock_key);
>> +
>> +static void __init riscv_spinlock_init(void)
>> +{
>> +       char *using_ext;
>> +
>> +       if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
>> +           IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {
>> +               using_ext = "using Zabha";
>> +
>> +               asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0, RISCV_ISA_EXT_ZACAS, 1)
>> +                        : : : : no_zacas);
>> +               asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_EXT_ZABHA, 1)
>> +                        : : : : qspinlock);
>> +       }
> I'm okay with this patch.


Great, thanks!


> I suggest putting an arg such as "enable_qspinlock," which people
> could use on the non-ZABHA machines. I hope it could happen in this
> series. That's all I need, thank you very much.


Do you think that's really necessary? I added Ziccrse support just 
below, to me that fits your needs to use qspinlocks on !Ziccrse.

BTW, can I add you SoB on this patch? Or a Co-developed-by or anything 
to show that you greatly contributed to this patch?

Thanks,

Alex


>
>> +
>> +no_zacas:
>> +       using_ext = "using Ziccrse";
>> +       asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0,
>> +                            RISCV_ISA_EXT_ZICCRSE, 1)
>> +                : : : : qspinlock);
>> +
>> +       static_branch_disable(&qspinlock_key);
>> +       pr_info("Ticket spinlock: enabled\n");
>> +
>> +       return;
>> +
>> +qspinlock:
>> +       pr_info("Queued spinlock %s: enabled\n", using_ext);
>> +}
>> +
>>   extern void __init init_rt_signal_env(void);
>>
>>   void __init setup_arch(char **cmdline_p)
>> @@ -295,6 +327,7 @@ void __init setup_arch(char **cmdline_p)
>>          riscv_set_dma_cache_alignment();
>>
>>          riscv_user_isa_enable();
>> +       riscv_spinlock_init();
>>   }
>>
>>   bool arch_cpu_is_hotpluggable(int cpu)
>> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
>> index 0655aa5b57b2..bf47cca2c375 100644
>> --- a/include/asm-generic/qspinlock.h
>> +++ b/include/asm-generic/qspinlock.h
>> @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
>>   }
>>   #endif
>>
>> +#ifndef __no_arch_spinlock_redefine
>>   /*
>>    * Remapping spinlock architecture specific functions to the corresponding
>>    * queued spinlock functions.
>> @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
>>   #define arch_spin_lock(l)              queued_spin_lock(l)
>>   #define arch_spin_trylock(l)           queued_spin_trylock(l)
>>   #define arch_spin_unlock(l)            queued_spin_unlock(l)
>> +#endif
>>
>>   #endif /* __ASM_GENERIC_QSPINLOCK_H */
>> diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/ticket_spinlock.h
>> index cfcff22b37b3..325779970d8a 100644
>> --- a/include/asm-generic/ticket_spinlock.h
>> +++ b/include/asm-generic/ticket_spinlock.h
>> @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
>>          return (s16)((val >> 16) - (val & 0xffff)) > 1;
>>   }
>>
>> +#ifndef __no_arch_spinlock_redefine
>>   /*
>>    * Remapping spinlock architecture specific functions to the corresponding
>>    * ticket spinlock functions.
>> @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
>>   #define arch_spin_lock(l)              ticket_spin_lock(l)
>>   #define arch_spin_trylock(l)           ticket_spin_trylock(l)
>>   #define arch_spin_unlock(l)            ticket_spin_unlock(l)
>> +#endif
>>
>>   #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
>> --
>> 2.39.2
>>
>

