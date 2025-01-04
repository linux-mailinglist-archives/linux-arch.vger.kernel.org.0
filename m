Return-Path: <linux-arch+bounces-9582-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95FCA0137B
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 10:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567893A4175
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 09:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFC41586CF;
	Sat,  4 Jan 2025 09:04:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D5149C7B;
	Sat,  4 Jan 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735981474; cv=none; b=Dc9dGokjQLUrYf8QDP1zPeHD7LZUolCh+9bG6pG0hUjFc5zzBWymZaOf9MXyL7He11jpL/5PsLDF62U32zfHOypBil9nEgojoSdLyvEFfHulTaE8jfIypMIjxHKaVIH9m9BfC72WxtvzbLdhksHkBBls2UNkej7D10M/zSud7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735981474; c=relaxed/simple;
	bh=hEuB/J7zP2edHo4dvm7fC0suWAyFCtd0xvrZ+aaZc2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQ/6PgmkXrY642PWYImdcuy7Ut9VAcYVF6G65uvAWpWrSjxUgndSCbhQl63831+VgjToRZkf8IIPex3iv4hw/H89hSKOTMzxig6MDOaec85XvFHfcWiLsxa/MnabaSrcgsMUt0xlZqI3+e21AHJxSUe7+AGT06a/uQwYwTwMdI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.80.44.60])
	by gateway (Coremail) with SMTP id _____8CxCeGc+XhnO+ldAA--.53711S3;
	Sat, 04 Jan 2025 17:04:28 +0800 (CST)
Received: from [10.80.44.60] (unknown [10.80.44.60])
	by front1 (Coremail) with SMTP id qMiowMAxvsWZ+XhncpgTAA--.9426S2;
	Sat, 04 Jan 2025 17:04:26 +0800 (CST)
Message-ID: <c47a9589-bc19-4e0a-866c-08e022e89539@loongson.cn>
Date: Sat, 4 Jan 2025 17:04:25 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] loongarch: Introduce sys_loongarch_flush_icache
 syscall
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
 <20250102-la32-uapi-v1-2-db32aa769b88@flygoat.com>
Content-Language: en-US
From: Jinyang Shen <shenjinyang@loongson.cn>
In-Reply-To: <20250102-la32-uapi-v1-2-db32aa769b88@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMAxvsWZ+XhncpgTAA--.9426S2
X-CM-SenderInfo: hvkh0yplq1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww1fCr17Wr4UWw48KFy5ZFc_yoW7CF1DpF
	y2y3Z5Jr4rCr18C3ZxJw1xWr1rJ3s7GF1a93Wakry5ArnFqr1jgrnaqa4DZF1jv393KrWI
	gFyFg3s8WF4UXabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17
	MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
	AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7IU8uuWJUUUUU==

Hi, Jiaxun,

On 2025/1/3 02:34, Jiaxun Yang wrote:
> On LoongArch CPUs with ICACHET, writes automatically sync to both local and
> remote instruction caches. CPUs without this feature lack userspace cache
> flush instructions, requiring a syscall to maintain I/D cache coherence and
> propagate to remote caches.
> 
> sys_loongarch_flush_icache() is defined to flush the instruction cache
> over an address range, with the flush applying to either all threads or
> just the caller.
> 
> Currently all LoongArch64 implementations from Loongson comes with ICACHET,
> however most LoongArch32 implementations including openLA500 and emerging
> third party LoongArch64 implementations such as WiredNG are coming without
> ICACHET.
> 
> Sadly many user space applications are assuming ICACHET support, we can't
> recall those binaries. So we'd better get UAPI for cacheflush ready soonish
> and encourage application to start using it.
> 
> The syscall resolves to a ibar for now, it should be revised when we have
> actual non-ICACHET support in kernel.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/loongarch/include/asm/cacheflush.h |  6 ++++++
>   arch/loongarch/include/asm/syscall.h    |  2 ++
>   arch/loongarch/kernel/Makefile.syscalls |  3 +--
>   arch/loongarch/kernel/syscall.c         | 28 ++++++++++++++++++++++++++++
>   scripts/syscall.tbl                     |  2 ++
>   5 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
> index f8754d08a31ab07490717c31b9253871668b9a76..94f4a47f00860977db0b360965a22ff0a461c098 100644
> --- a/arch/loongarch/include/asm/cacheflush.h
> +++ b/arch/loongarch/include/asm/cacheflush.h
> @@ -80,6 +80,12 @@ static inline void flush_cache_line(int leaf, unsigned long addr)
>   	}
>   }
>   
> +/*
> + * Bits in sys_loongarch_flush_icache()'s flags argument.
> + */
> +#define SYS_LOONGARCH_FLUSH_ICACHE_LOCAL 1UL
> +#define SYS_LOONGARCH_FLUSH_ICACHE_ALL   (SYS_LOONGARCH_FLUSH_ICACHE_LOCAL)
> +
>   #include <asm-generic/cacheflush.h>
>   
>   #endif /* _ASM_CACHEFLUSH_H */
> diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
> index e286dc58476e6e6c5d126866a8590a96e4b4089a..6bd414a98a757de3c1bc78643fa1749f07efb1c0 100644
> --- a/arch/loongarch/include/asm/syscall.h
> +++ b/arch/loongarch/include/asm/syscall.h
> @@ -71,4 +71,6 @@ static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
>   	return false;
>   }
>   
> +asmlinkage long sys_loongarch_flush_icache(uintptr_t, uintptr_t, uintptr_t);
> +
>   #endif	/* __ASM_LOONGARCH_SYSCALL_H */
> diff --git a/arch/loongarch/kernel/Makefile.syscalls b/arch/loongarch/kernel/Makefile.syscalls
> index ab7d9baa29152da97932c7e447a183fba265451c..11665e3000beffd24ef9d683a4ac337554e0b320 100644
> --- a/arch/loongarch/kernel/Makefile.syscalls
> +++ b/arch/loongarch/kernel/Makefile.syscalls
> @@ -1,4 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -# No special ABIs on loongarch so far
> -syscall_abis_64 +=
> +syscall_abis_64 += loongarch

LoongArch64 need arch-specific syscall, but LoongArch32 needn't?

> diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
> index b267db6ed79c20199504247c181cc245ef86abfd..2bc164d972b4d41c39e91481803d42bfd0184d3f 100644
> --- a/arch/loongarch/kernel/syscall.c
> +++ b/arch/loongarch/kernel/syscall.c
> @@ -15,6 +15,7 @@
>   #include <linux/unistd.h>
>   
>   #include <asm/asm.h>
> +#include <asm/cacheflush.h>
>   #include <asm/exception.h>
>   #include <asm/loongarch.h>
>   #include <asm/signal.h>
> @@ -51,6 +52,33 @@ SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len, unsigned long,
>   }
>   #endif
>   
> +/*
> + * On LoongArch CPUs with ICACHET, writes automatically sync to both local and
> + * remote instruction caches. CPUs without this feature lack userspace cache
> + * flush instructions, requiring a syscall to maintain I/D cache coherence and
> + * propagate to remote caches.
> + *
> + * sys_loongarch_flush_icache() is defined to flush the instruction cache
> + * over an address range, with the flush applying to either all threads or
> + * just the caller.
> + */
> +SYSCALL_DEFINE3(loongarch_flush_icache, uintptr_t, start, uintptr_t, end,
> +	uintptr_t, flags)
> +{
> +	/* Check the reserved flags. */
> +	if (unlikely(flags & ~SYS_LOONGARCH_FLUSH_ICACHE_ALL))
> +		return -EINVAL;
> +
> +	/*
> +	 * SYS_LOONGARCH_FLUSH_ICACHE_LOCAL is not handled so far, needs
> +	 * to be realized when non-ICACHET CPUs are supported.
> +	 */
> +
> +	flush_icache_user_range(start, end);
> +
> +	return 0;
> +}
> +
>   void *sys_call_table[__NR_syscalls] = {
>   	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
>   #ifdef CONFIG_64BIT
> diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
> index ebbdb3c42e9f74613b003014c0baf44c842bb756..723fe859956809f26d6ec50ad7812933531ef687 100644
> --- a/scripts/syscall.tbl
> +++ b/scripts/syscall.tbl
> @@ -298,6 +298,8 @@
>   244	csky	set_thread_area			sys_set_thread_area
>   245	csky	cacheflush			sys_cacheflush
>   
> +259	loongarch       loongarch_flush_icache	sys_loongarch_flush_icache

Can we use cacheflush as arc, csky and nios2?

Jinyang

> +
>   244	nios2	cacheflush			sys_cacheflush
>   
>   244	or1k	or1k_atomic			sys_or1k_atomic
> 


