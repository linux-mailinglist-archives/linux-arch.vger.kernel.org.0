Return-Path: <linux-arch+bounces-5497-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53670934DCD
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 15:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC1C2821AA
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7C613C3F6;
	Thu, 18 Jul 2024 13:08:47 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB75839E3;
	Thu, 18 Jul 2024 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308127; cv=none; b=VoqclKVnetjB7IwJ0QMlIw8iMPouOZrqGQH1KCTEP/3VRmJsc2LJZj1CUevQLGaz+si78TdV2cwjvS1xd8PuU/Jc5y/wMhamTnQg5941R/WUfjxZdxPqg0pELvbKo/g65GXlUL0Z0MSYiyuzat3/Wf6cejOSRzSC01zCrWmH3m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308127; c=relaxed/simple;
	bh=fPG4In1liwBLGKmi0Zhpipjq4VcDJmEnF0sgTNwj5CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJk0XdOBkDpLutQPJCZe3RKBmFbUDrRZVznpFUacm/tk7syg1hNy3M+4QjS6NMRpk9bFFT44x9nKjqi7NL2xLGqK9iU36AiJDXAr9cteOumymQJv4BjeEM4uZ5aY85w5tisBt586eK7gR5gE9EinCw4OU+BWijY1/fDpwIXUy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A304B1C0009;
	Thu, 18 Jul 2024 13:08:39 +0000 (UTC)
Message-ID: <2c227c58-d414-4994-9382-11feb80bb818@ghiti.fr>
Date: Thu, 18 Jul 2024 15:08:39 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] riscv: Add qspinlock support
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-12-alexghiti@rivosinc.com> <ZpfxUvIx+0ClOqCc@andrea>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ZpfxUvIx+0ClOqCc@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Andrea,

On 17/07/2024 18:29, Andrea Parri wrote:
>> +config RISCV_QUEUED_SPINLOCKS
> I'm seeing the following warnings with CONFIG_RISCV_QUEUED_SPINLOCKS=y:
>
> In file included from ./arch/riscv/include/generated/asm/qspinlock.h:1,
>                   from kernel/locking/qspinlock.c:24:
> ./include/asm-generic/qspinlock.h:144:9: warning: "arch_spin_is_locked" redefined
>    144 | #define arch_spin_is_locked(l)          queued_spin_is_locked(l)
>        |         ^~~~~~~~~~~~~~~~~~~
> In file included from ./arch/riscv/include/generated/asm/ticket_spinlock.h:1,
>                   from ./arch/riscv/include/asm/spinlock.h:33,
>                   from ./include/linux/spinlock.h:95,
>                   from ./include/linux/sched.h:2142,
>                   from ./include/linux/percpu.h:13,
>                   from kernel/locking/qspinlock.c:19:
> ./include/asm-generic/ticket_spinlock.h:97:9: note: this is the location of the previous definition
>     97 | #define arch_spin_is_locked(l)          ticket_spin_is_locked(l)
>        |         ^~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/qspinlock.h:145:9: warning: "arch_spin_is_contended" redefined
>    145 | #define arch_spin_is_contended(l)       queued_spin_is_contended(l)
>        |         ^~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/ticket_spinlock.h:98:9: note: this is the location of the previous definition
>     98 | #define arch_spin_is_contended(l)       ticket_spin_is_contended(l)
>        |         ^~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/qspinlock.h:146:9: warning: "arch_spin_value_unlocked" redefined
>    146 | #define arch_spin_value_unlocked(l)     queued_spin_value_unlocked(l)
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/ticket_spinlock.h:99:9: note: this is the location of the previous definition
>     99 | #define arch_spin_value_unlocked(l)     ticket_spin_value_unlocked(l)
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/qspinlock.h:147:9: warning: "arch_spin_lock" redefined
>    147 | #define arch_spin_lock(l)               queued_spin_lock(l)
>        |         ^~~~~~~~~~~~~~
> ./include/asm-generic/ticket_spinlock.h:100:9: note: this is the location of the previous definition
>    100 | #define arch_spin_lock(l)               ticket_spin_lock(l)
>        |         ^~~~~~~~~~~~~~
> ./include/asm-generic/qspinlock.h:148:9: warning: "arch_spin_trylock" redefined
>    148 | #define arch_spin_trylock(l)            queued_spin_trylock(l)
>        |         ^~~~~~~~~~~~~~~~~
> ./include/asm-generic/ticket_spinlock.h:101:9: note: this is the location of the previous definition
>    101 | #define arch_spin_trylock(l)            ticket_spin_trylock(l)
>        |         ^~~~~~~~~~~~~~~~~
> ./include/asm-generic/qspinlock.h:149:9: warning: "arch_spin_unlock" redefined
>    149 | #define arch_spin_unlock(l)             queued_spin_unlock(l)
>        |         ^~~~~~~~~~~~~~~~
> ./include/asm-generic/ticket_spinlock.h:102:9: note: this is the location of the previous definition
>    102 | #define arch_spin_unlock(l)             ticket_spin_unlock(l)
>
>
> The following diff resolves them for me (please double check):
>
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> index 4856d50006f28..2d59f56a9e2d1 100644
> --- a/arch/riscv/include/asm/spinlock.h
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -30,7 +30,11 @@ SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
>   
>   #else
>   
> +#if defined(CONFIG_RISCV_TICKET_SPINLOCKS)
>   #include <asm/ticket_spinlock.h>
> +#elif defined(CONFIG_RISCV_QUEUED_SPINLOCKS)
> +#include <asm/qspinlock.h>
> +#endif
>   
>   #endif


Thanks for testing this config (when I did not...)!

I came up with something slightly different, but same fix in the end, 
thanks!


>
>> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
>> +EXPORT_SYMBOL(qspinlock_key);
>> +
>> +static void __init riscv_spinlock_init(void)
>> +{
>> +	char *using_ext;
>> +
>> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
>> +	    IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {
>> +		using_ext = "using Zabha";
>> +
>> +		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0, RISCV_ISA_EXT_ZACAS, 1)
>> +			 : : : : no_zacas);
>> +		asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_EXT_ZABHA, 1)
>> +			 : : : : qspinlock);
>> +	}
>> +
>> +no_zacas:
>> +	using_ext = "using Ziccrse";
>> +	asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0,
>> +			     RISCV_ISA_EXT_ZICCRSE, 1)
>> +		 : : : : qspinlock);
>> +
>> +	static_branch_disable(&qspinlock_key);
>> +	pr_info("Ticket spinlock: enabled\n");
>> +
>> +	return;
>> +
>> +qspinlock:
>> +	pr_info("Queued spinlock %s: enabled\n", using_ext);
>> +}
>> +
> Your commit message suggests that riscv_spinlock_init() doesn't need to
> do anything if CONFIG_RISCV_COMBO_SPINLOCKS=n:
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index d7c31c9b8ead2..b2be1b0b700d2 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -244,6 +244,7 @@ static void __init parse_dtb(void)
>   #endif
>   }
>   
> +#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
>   DEFINE_STATIC_KEY_TRUE(qspinlock_key);
>   EXPORT_SYMBOL(qspinlock_key);
>   
> @@ -275,6 +276,11 @@ static void __init riscv_spinlock_init(void)
>   qspinlock:
>   	pr_info("Queued spinlock %s: enabled\n", using_ext);
>   }
> +#else
> +static void __init riscv_spinlock_init(void)
> +{
> +}
> +#endif
>   
>   extern void __init init_rt_signal_env(void);
>
>
> Makes sense?  What am I missing?


Totally makes sense, I completely overlooked this when I added the 
ticket/queued configs, thanks for taking the time to look into it.

That will be fixed in the next version.

Thanks again,

Alex


>
>    Andrea
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

