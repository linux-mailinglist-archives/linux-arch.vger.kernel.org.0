Return-Path: <linux-arch+bounces-5511-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9619371CB
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 03:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1911C2131E
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 01:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478474404;
	Fri, 19 Jul 2024 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ml2aDEIe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B38BF7
	for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2024 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721351129; cv=none; b=ctXupXS+onemTjCudNJ5vRdeKrAJorXWX18NVXtiiURMMqW3JsjeIn/0aLYuk5LtPEkbUgcCkpXfTkhypOq1KSFd4wi2HVTaWsfCC0l8Pbb5prj3AL32Q7XwCDRCzJOOi3EXfdyttqo55JANZ9oCRhYAzu7WVzt2ftUJ+BPfrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721351129; c=relaxed/simple;
	bh=P5tdODM4uOWKJAr8TMb/PKCNU1wa6kKfGQv2OEGO0JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ADMWqA7x7rrwx5pkRagH05/sqtLWTTqE0UaJIWQWwiCtf9kXRdX0Kqb+mkC0j6gVq1tigxcM23NG1VUUk+7sazI/hxTH50uUVDhhzDLLJHsYkspka1B5LMSLeEmhvWjpJpkn6OITwURibDOXis5wS2MzVpJQJm9yPvuoRvJcjdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ml2aDEIe; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f6e9662880so53211739f.2
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 18:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721351126; x=1721955926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FMAHxtscGqlGqItcz1n/Ls2fY0sL2MuwrS/B9YqzrMM=;
        b=ml2aDEIeit5UD4dKey7do30YQPgAslpxBq/oGg+CURlPO/Y8T4/shxPccXIdm985pD
         1uVyWT4Tq2cEGE9FlVFnUv1JBTUEb4GVJ7OZ+kr/1JDN5+6Bhe4z4Sg9FWRz+Hh2ELuA
         nIGgcoZNcOMmpU9se8Y9qZZOafqbJSxwPYF15yWMN3hKHqu6y5d19CMB+Kdt0AZpeCTR
         df/ncnIjuqWJ+nGFgIWsp5sX1u3HMaECQ5vAQPZMa0ye66HRA1ZpMEps8zun/fSuDZea
         kIZtbrrzUmcKdDGIAh+IR8FgR7KMJzrV4sQ7i7kKkg3qg3ZV6Nmdh3XgYl9A+XMoOX7r
         Vd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721351126; x=1721955926;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMAHxtscGqlGqItcz1n/Ls2fY0sL2MuwrS/B9YqzrMM=;
        b=rlG5Ds5QNbN7fD+Kchwz5zjfFrd0SMMTzkLvnOukfqEP5UeUz2rc3rkPRl1uyX/Nh1
         YFmLuVCEymLDK54Hlfcy3QG8o8jiPtBjiVnwuF34k2qJKjROEKz5o+HamcNab4sW0eZu
         E2VGG6Ia1zImchK+xub691//+xV+JR7Kgs9Za0fdHLYcI+SWrigyQjWLve6PhxUodIRD
         CHRaZziYRuZrjRAa7/bvKsOAnwaGLKXaOB8i93jKgrDlBxznoCOUH/4UTH0MTQpCISV2
         CgfakBRtZJDTx4UXOJme8OFCcOyM4WKziPBzETbEKibyjNJjuufMo6sD909jfZUr+2Re
         T0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWvOjiwaWjIzUh+K7n3FrgCTocfnxpqZj97wr8+8FdaV9f5qZLT5eqmHYwEH4JoAkJW4fByp2UkDr8KalDvfa+1TVGimt/abMo5+g==
X-Gm-Message-State: AOJu0Yysv2WR4KdCAaf5cqWjPDzEEgHDVOKS4AE1zNmgfQ0YZOvlmJou
	nBYORoagDC7TIag+Q3vP3U+gnsrggHYQWWeiTwyr97G7Me5MrkW9VcIHcJGbAVE=
X-Google-Smtp-Source: AGHT+IGTr5yippsBWg1d4Fb5evY8uvrbI/lZKSa+eJ+BxjsJNRV5+mZtYRjoliAsRZT3xzQpYODt/g==
X-Received: by 2002:a05:6602:2b8c:b0:7f9:b435:4f5 with SMTP id ca18e2360f4ac-81710dc020amr846001239f.11.1721351126397;
        Thu, 18 Jul 2024 18:05:26 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c2343ab670sm105595173.120.2024.07.18.18.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 18:05:26 -0700 (PDT)
Message-ID: <b28bc3c6-19de-4d40-8af2-6e5ce78ba89c@sifive.com>
Date: Thu, 18 Jul 2024 20:05:23 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] riscv: Add qspinlock support
To: Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-12-alexghiti@rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
 Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org
In-Reply-To: <20240717061957.140712-12-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 2024-07-17 1:19 AM, Alexandre Ghiti wrote:
> In order to produce a generic kernel, a user can select
> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> spinlock implementation if Zabha or Ziccrse are not present.
> 
> Note that we can't use alternatives here because the discovery of
> extensions is done too late and we need to start with the qspinlock
> implementation because the ticket spinlock implementation would pollute
> the spinlock value, so let's use static keys.
> 
> This is largely based on Guo's work and Leonardo reviews at [1].
> 
> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  .../locking/queued-spinlocks/arch-support.txt |  2 +-
>  arch/riscv/Kconfig                            | 29 ++++++++++++++
>  arch/riscv/include/asm/Kbuild                 |  4 +-
>  arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++++
>  arch/riscv/kernel/setup.c                     | 33 ++++++++++++++++
>  include/asm-generic/qspinlock.h               |  2 +
>  include/asm-generic/ticket_spinlock.h         |  2 +
>  7 files changed, 109 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/spinlock.h
> 
> diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> index 22f2990392ff..cf26042480e2 100644
> --- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
> +++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> @@ -20,7 +20,7 @@
>      |    openrisc: |  ok  |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: | TODO |
>      |          sh: | TODO |
>      |       sparc: |  ok  |
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0bbaec0444d0..5040c7eac70d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -72,6 +72,7 @@ config RISCV
>  	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>  	select ARCH_WANTS_NO_INSTR
>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> +	select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>  	select BUILDTIME_TABLE_SORT if MMU
>  	select CLINT_TIMER if RISCV_M_MODE
> @@ -482,6 +483,34 @@ config NODES_SHIFT
>  	  Specify the maximum number of NUMA Nodes available on the target
>  	  system.  Increases memory reserved to accommodate various tables.
>  
> +choice
> +	prompt "RISC-V spinlock type"
> +	default RISCV_COMBO_SPINLOCKS
> +
> +config RISCV_TICKET_SPINLOCKS
> +	bool "Using ticket spinlock"
> +
> +config RISCV_QUEUED_SPINLOCKS
> +	bool "Using queued spinlock"
> +	depends on SMP && MMU

This needs:

	depends on NONPORTABLE

> +	select ARCH_USE_QUEUED_SPINLOCKS
> +	help
> +	  The queued spinlock implementation requires the forward progress
> +	  guarantee of cmpxchg()/xchg() atomic operations: CAS with Zabha or
> +	  LR/SC with Ziccrse provide such guarantee.
> +
> +	  Select this if and only if Zabha or Ziccrse is available on your
> +	  platform.
> +
> +config RISCV_COMBO_SPINLOCKS
> +	bool "Using combo spinlock"
> +	depends on SMP && MMU
> +	select ARCH_USE_QUEUED_SPINLOCKS
> +	help
> +	  Embed both queued spinlock and ticket lock so that the spinlock
> +	  implementation can be chosen at runtime.
> +endchoice
> +
>  config RISCV_ALTERNATIVE
>  	bool
>  	depends on !XIP_KERNEL
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 504f8b7e72d4..ad72f2bd4cc9 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -2,10 +2,12 @@
>  generic-y += early_ioremap.h
>  generic-y += flat.h
>  generic-y += kvm_para.h
> +generic-y += mcs_spinlock.h
>  generic-y += parport.h
> -generic-y += spinlock.h
>  generic-y += spinlock_types.h
> +generic-y += ticket_spinlock.h
>  generic-y += qrwlock.h
>  generic-y += qrwlock_types.h
> +generic-y += qspinlock.h
>  generic-y += user.h
>  generic-y += vmlinux.lds.h
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> new file mode 100644
> index 000000000000..4856d50006f2
> --- /dev/null
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_RISCV_SPINLOCK_H
> +#define __ASM_RISCV_SPINLOCK_H
> +
> +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> +#define _Q_PENDING_LOOPS	(1 << 9)
> +
> +#define __no_arch_spinlock_redefine
> +#include <asm/ticket_spinlock.h>
> +#include <asm/qspinlock.h>
> +#include <asm/alternative.h>
> +
> +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> +
> +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)			\
> +static __always_inline type arch_spin_##op(type_lock lock)		\
> +{									\
> +	if (static_branch_unlikely(&qspinlock_key))			\
> +		return queued_spin_##op(lock);				\
> +	return ticket_spin_##op(lock);					\
> +}
> +
> +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> +
> +#else
> +
> +#include <asm/ticket_spinlock.h>
> +
> +#endif
> +
> +#include <asm/qrwlock.h>
> +
> +#endif /* __ASM_RISCV_SPINLOCK_H */
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 4f73c0ae44b2..d7c31c9b8ead 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -244,6 +244,38 @@ static void __init parse_dtb(void)
>  #endif
>  }
>  
> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> +EXPORT_SYMBOL(qspinlock_key);
> +
> +static void __init riscv_spinlock_init(void)
> +{
> +	char *using_ext;
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
> +	    IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {
> +		using_ext = "using Zabha";
> +
> +		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0, RISCV_ISA_EXT_ZACAS, 1)
> +			 : : : : no_zacas);
> +		asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_EXT_ZABHA, 1)
> +			 : : : : qspinlock);
> +	}
> +
> +no_zacas:
> +	using_ext = "using Ziccrse";
> +	asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0,
> +			     RISCV_ISA_EXT_ZICCRSE, 1)
> +		 : : : : qspinlock);
> +
> +	static_branch_disable(&qspinlock_key);
> +	pr_info("Ticket spinlock: enabled\n");
> +
> +	return;
> +
> +qspinlock:
> +	pr_info("Queued spinlock %s: enabled\n", using_ext);
> +}

This function would be much easier to read with
riscv_has_extension_[un]likely(), or even riscv_isa_extension_available() since
it only gets called once. Thankfully the concerns about using those inside
macros don't apply here :)

Regards,
Samuel

> +
>  extern void __init init_rt_signal_env(void);
>  
>  void __init setup_arch(char **cmdline_p)
> @@ -295,6 +327,7 @@ void __init setup_arch(char **cmdline_p)
>  	riscv_set_dma_cache_alignment();
>  
>  	riscv_user_isa_enable();
> +	riscv_spinlock_init();
>  }
>  
>  bool arch_cpu_is_hotpluggable(int cpu)
> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
> index 0655aa5b57b2..bf47cca2c375 100644
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
>  }
>  #endif
>  
> +#ifndef __no_arch_spinlock_redefine
>  /*
>   * Remapping spinlock architecture specific functions to the corresponding
>   * queued spinlock functions.
> @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
>  #define arch_spin_lock(l)		queued_spin_lock(l)
>  #define arch_spin_trylock(l)		queued_spin_trylock(l)
>  #define arch_spin_unlock(l)		queued_spin_unlock(l)
> +#endif
>  
>  #endif /* __ASM_GENERIC_QSPINLOCK_H */
> diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/ticket_spinlock.h
> index cfcff22b37b3..325779970d8a 100644
> --- a/include/asm-generic/ticket_spinlock.h
> +++ b/include/asm-generic/ticket_spinlock.h
> @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
>  	return (s16)((val >> 16) - (val & 0xffff)) > 1;
>  }
>  
> +#ifndef __no_arch_spinlock_redefine
>  /*
>   * Remapping spinlock architecture specific functions to the corresponding
>   * ticket spinlock functions.
> @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
>  #define arch_spin_lock(l)		ticket_spin_lock(l)
>  #define arch_spin_trylock(l)		ticket_spin_trylock(l)
>  #define arch_spin_unlock(l)		ticket_spin_unlock(l)
> +#endif
>  
>  #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */


