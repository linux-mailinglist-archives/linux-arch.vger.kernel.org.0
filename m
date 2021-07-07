Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA763BDFFC
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jul 2021 02:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhGGAD3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 20:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGGAD3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 20:03:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91293C061574
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=c5t3rh7LynbnlM1uMCXYtKJ3QWdrf1PdPq9CVzO0MBI=; b=IC+AQE91GwaZVIvefNmGVpiA3k
        y9Zg7Nie3+kN1VZWVIZgTiMGo4Jvs/e9ALcIbgnRYuH7PWSfxdY2FOZSVxHlARXzKcAhsYtjSHsGk
        SHLE+4ZZhObwvfB38ufx/Iz0AiB7QHPjYN5PLf/dLrvnQBCGnt+lxB81kEYo8P4/EJ9W2VghTqW1k
        LNZzW9LY2nQkmIE6HOm08mpFWUgKX5uFXednfHmY4YyKEmNweR4v5buIWcvzNfoIr4Hs9Y7tqfa0+
        HOurCniKvj+RWqfWnLQHckoI0FVIgIjN3Ubr9LOLcEhJhZaBsCppr0mcwt3Vqe6Nl/BJULuDnBnXp
        98gM9+3g==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0uza-00D46q-7J; Wed, 07 Jul 2021 00:00:42 +0000
Subject: Re: [PATCH 03/19] LoongArch: Add build infrastructure
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-4-chenhuacai@loongson.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <00abb0cc-6a82-e4fd-c554-7cf7c039ded3@infradead.org>
Date:   Tue, 6 Jul 2021 17:00:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706041820.1536502-4-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 7/5/21 9:18 PM, Huacai Chen wrote:
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> new file mode 100644
> index 000000000000..7d5889a264c6
> --- /dev/null
> +++ b/arch/loongarch/Kconfig
> @@ -0,0 +1,403 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config LOONGARCH
> +	bool
> +	default y

Some arch/ maintainers prefer to keep this list in alphabetical order...
It may make it easier to find entries -- prevent duplicates from being added.

> +	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
> +	select ARCH_BINFMT_ELF_STATE
> +	select ARCH_DISCARD_MEMBLOCK
> +	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
> +	select ARCH_HAS_ELF_RANDOMIZE
> +	select ARCH_HAS_PTE_SPECIAL if !32BIT
> +	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> +	select ARCH_INLINE_READ_LOCK if !PREEMPTION
> +	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
> +	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
> +	select ARCH_INLINE_READ_LOCK_IRQSAVE if !PREEMPTION
> +	select ARCH_INLINE_READ_UNLOCK if !PREEMPTION
> +	select ARCH_INLINE_READ_UNLOCK_BH if !PREEMPTION
> +	select ARCH_INLINE_READ_UNLOCK_IRQ if !PREEMPTION
> +	select ARCH_INLINE_READ_UNLOCK_IRQRESTORE if !PREEMPTION
> +	select ARCH_INLINE_WRITE_LOCK if !PREEMPTION
> +	select ARCH_INLINE_WRITE_LOCK_BH if !PREEMPTION
> +	select ARCH_INLINE_WRITE_LOCK_IRQ if !PREEMPTION
> +	select ARCH_INLINE_WRITE_LOCK_IRQSAVE if !PREEMPTION
> +	select ARCH_INLINE_WRITE_UNLOCK if !PREEMPTION
> +	select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPTION
> +	select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPTION
> +	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPTION
> +	select ARCH_INLINE_SPIN_TRYLOCK if !PREEMPTION
> +	select ARCH_INLINE_SPIN_TRYLOCK_BH if !PREEMPTION
> +	select ARCH_INLINE_SPIN_LOCK if !PREEMPTION
> +	select ARCH_INLINE_SPIN_LOCK_BH if !PREEMPTION
> +	select ARCH_INLINE_SPIN_LOCK_IRQ if !PREEMPTION
> +	select ARCH_INLINE_SPIN_LOCK_IRQSAVE if !PREEMPTION
> +	select ARCH_INLINE_SPIN_UNLOCK if !PREEMPTION
> +	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
> +	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
> +	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
> +	select ARCH_SUPPORTS_ACPI
> +	select ARCH_SUPPORTS_HUGETLBFS
> +	select ARCH_USE_BUILTIN_BSWAP
> +	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
> +	select ARCH_USE_QUEUED_RWLOCKS
> +	select ARCH_USE_QUEUED_SPINLOCKS
> +	select BUILDTIME_TABLE_SORT
> +	select GENERIC_ATOMIC64 if !64BIT
> +	select GENERIC_CLOCKEVENTS
> +	select GENERIC_CMOS_UPDATE
> +	select GENERIC_CPU_AUTOPROBE
> +	select GENERIC_GETTIMEOFDAY
> +	select GENERIC_IOMAP
> +	select GENERIC_IRQ_PROBE
> +	select GENERIC_IRQ_SHOW
> +	select GENERIC_LIB_ASHLDI3
> +	select GENERIC_LIB_ASHRDI3
> +	select GENERIC_LIB_CMPDI2
> +	select GENERIC_LIB_LSHRDI3
> +	select GENERIC_LIB_UCMPDI2
> +	select GENERIC_TIME_VSYSCALL
> +	select HANDLE_DOMAIN_IRQ
> +	select HAVE_ARCH_AUDITSYSCALL
> +	select HAVE_ARCH_COMPILER_H
> +	select HAVE_ARCH_MMAP_RND_BITS if MMU
> +	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_TRACEHOOK
> +	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> +	select HAVE_ASM_MODVERSIONS
> +	select HAVE_CBPF_JIT if !64BIT
> +	select HAVE_EBPF_JIT if 64BIT
> +	select HAVE_CONTEXT_TRACKING
> +	select HAVE_COPY_THREAD_TLS
> +	select HAVE_DEBUG_KMEMLEAK
> +	select HAVE_DEBUG_STACKOVERFLOW
> +	select HAVE_DMA_CONTIGUOUS
> +	select HAVE_EXIT_THREAD
> +	select HAVE_FAST_GUP
> +	select HAVE_FUTEX_CMPXCHG if FUTEX
> +	select HAVE_GENERIC_VDSO
> +	select HAVE_IDE
> +	select HAVE_IOREMAP_PROT
> +	select HAVE_IRQ_EXIT_ON_IRQ_STACK
> +	select HAVE_IRQ_TIME_ACCOUNTING
> +	select HAVE_MEMBLOCK
> +	select HAVE_MEMBLOCK_NODE_MAP
> +	select HAVE_MOD_ARCH_SPECIFIC
> +	select HAVE_NMI
> +	select HAVE_PERF_EVENTS
> +	select HAVE_REGS_AND_STACK_ACCESS_API
> +	select HAVE_RSEQ
> +	select HAVE_SYSCALL_TRACEPOINTS
> +	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT
> +	select IRQ_FORCED_THREADING
> +	select MODULES_USE_ELF_RELA if MODULES && 64BIT
> +	select MODULES_USE_ELF_REL if MODULES
> +	select PCI_DOMAINS if PCI
> +	select PCI_MSI_ARCH_FALLBACKS
> +	select PERF_USE_VMALLOC
> +	select RTC_LIB
> +	select SYSCTL_EXCEPTION_TRACE
> +	select VIRT_TO_BUS
> +
> +menu "Machine selection"
> +
> +choice
> +	prompt "System type"
> +	default MACH_LOONGSON64
> +
> +config MACH_LOONGSON64


[...]

> +choice
> +	prompt "Kernel page size"
> +	default PAGE_SIZE_16KB
> +
> +config PAGE_SIZE_4KB
> +	bool "4kB"
> +	help
> +	  This option select the standard 4kB Linux page size.

	              selects

> +
> +config PAGE_SIZE_16KB
> +	bool "16kB"
> +	help
> +	  This option select the standard 16kB Linux page size.

	              selects

> +
> +config PAGE_SIZE_64KB
> +	bool "64kB"
> +	help
> +	  This option select the standard 64kB Linux page size.

	              selects

> +
> +endchoice


-- 
~Randy

