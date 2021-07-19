Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEEE3CCBF6
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 03:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhGSBbX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Jul 2021 21:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhGSBbX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Jul 2021 21:31:23 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CB1C061762
        for <linux-arch@vger.kernel.org>; Sun, 18 Jul 2021 18:28:24 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id v26so18131171iom.11
        for <linux-arch@vger.kernel.org>; Sun, 18 Jul 2021 18:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Pd7eY6FDwjAP/yjrCCPVN7E5zY4tRma9TYQTxYcKHk=;
        b=guJ4FL+M5iYfp6VCmSIITZa+PFWj/l8ccQgVY+mjZCracGpsSPIPYcta0SKrDaGHmb
         9ei+q3Six/jA0bkyP14MSU07300tSq9kzYhsLkAi0ma7WozXN3UaxyWLKSl/0CR91OSj
         nPZSqjif5/BiJIvS3/q4Xj0sUJyh7yYBOVzgXIkzKVHoR8U+63IphTCRsrneQn3c9Xdo
         eOFQG8feAQG9buVG58dyCJMdYPbA2D800eX7QOTJqCveDpMoufQO/5TTvIYGeCwgOjTy
         0PU924+Yb05w/CueDon8/wOLkNcV9fnGlHpb+VhOk5hWv08wEpduyPcePfEvImsr04VI
         r52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Pd7eY6FDwjAP/yjrCCPVN7E5zY4tRma9TYQTxYcKHk=;
        b=Jdt4f2vCkVrA4JhPppWweBDKewiXoYIQqZ5IFA7ufJ5W9VMZG/Tvt+Z7WoMAFFMwc3
         qb+Qb1u6A2VIZUMCo9HfAJtzF/9ASBdh4tQyzSKvME93zcvzr4tARiiFkb2p6H+kAPZu
         x+eaDytf0vFgE6zoI5ulMU6N6fu2E8IM5hTWR8QHKTkuFz7xWnswSDdBRrGgpoiP0ria
         aAD3/aXBpy+gRaMMJfaAyQlRBUcbSUcgkCF9D8Bcs6J462hL62KNlYkrgC5BsaYVPiH4
         AHxFte8Tgx/Zw2lvGtVu+9h0xD/DmWbTZp/fN2a66mvtaQdrQ8H0liV7t+a3rbikWAPQ
         8D+g==
X-Gm-Message-State: AOAM530xzaYYRKS9s0z8lYblucFw1oZLbify7xUZgDTDiCT/AjhIVQIn
        Rq0Q2/6SxkC6nQG/DnntZrDBPBirNFeH9JUo55Y=
X-Google-Smtp-Source: ABdhPJzWcDjQAELj19a9iiMMvNYgLp84mQe5vKjU/tbH4Ufrn1DgtEwAUVCbZn8zSdTun9Xc3CZoqgRl+78dvoNSoUw=
X-Received: by 2002:a05:6602:190:: with SMTP id m16mr16912125ioo.14.1626658104086;
 Sun, 18 Jul 2021 18:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-4-chenhuacai@loongson.cn> <00abb0cc-6a82-e4fd-c554-7cf7c039ded3@infradead.org>
In-Reply-To: <00abb0cc-6a82-e4fd-c554-7cf7c039ded3@infradead.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 19 Jul 2021 09:28:09 +0800
Message-ID: <CAAhV-H4nt16ZFwV6kgyTmFhUCUSgkDvrV1tKOSW=3Yq3Rw0=DQ@mail.gmail.com>
Subject: Re: [PATCH 03/19] LoongArch: Add build infrastructure
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Randy,

On Wed, Jul 7, 2021 at 8:00 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> On 7/5/21 9:18 PM, Huacai Chen wrote:
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > new file mode 100644
> > index 000000000000..7d5889a264c6
> > --- /dev/null
> > +++ b/arch/loongarch/Kconfig
> > @@ -0,0 +1,403 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +config LOONGARCH
> > +     bool
> > +     default y
>
> Some arch/ maintainers prefer to keep this list in alphabetical order...
> It may make it easier to find entries -- prevent duplicates from being added.
I will try my best, but I will still keep function groups placed together.

>
> > +     select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
> > +     select ARCH_BINFMT_ELF_STATE
> > +     select ARCH_DISCARD_MEMBLOCK
> > +     select ARCH_HAS_ACPI_TABLE_UPGRADE      if ACPI
> > +     select ARCH_HAS_ELF_RANDOMIZE
> > +     select ARCH_HAS_PTE_SPECIAL if !32BIT
> > +     select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> > +     select ARCH_INLINE_READ_LOCK if !PREEMPTION
> > +     select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
> > +     select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
> > +     select ARCH_INLINE_READ_LOCK_IRQSAVE if !PREEMPTION
> > +     select ARCH_INLINE_READ_UNLOCK if !PREEMPTION
> > +     select ARCH_INLINE_READ_UNLOCK_BH if !PREEMPTION
> > +     select ARCH_INLINE_READ_UNLOCK_IRQ if !PREEMPTION
> > +     select ARCH_INLINE_READ_UNLOCK_IRQRESTORE if !PREEMPTION
> > +     select ARCH_INLINE_WRITE_LOCK if !PREEMPTION
> > +     select ARCH_INLINE_WRITE_LOCK_BH if !PREEMPTION
> > +     select ARCH_INLINE_WRITE_LOCK_IRQ if !PREEMPTION
> > +     select ARCH_INLINE_WRITE_LOCK_IRQSAVE if !PREEMPTION
> > +     select ARCH_INLINE_WRITE_UNLOCK if !PREEMPTION
> > +     select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPTION
> > +     select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPTION
> > +     select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPTION
> > +     select ARCH_INLINE_SPIN_TRYLOCK if !PREEMPTION
> > +     select ARCH_INLINE_SPIN_TRYLOCK_BH if !PREEMPTION
> > +     select ARCH_INLINE_SPIN_LOCK if !PREEMPTION
> > +     select ARCH_INLINE_SPIN_LOCK_BH if !PREEMPTION
> > +     select ARCH_INLINE_SPIN_LOCK_IRQ if !PREEMPTION
> > +     select ARCH_INLINE_SPIN_LOCK_IRQSAVE if !PREEMPTION
> > +     select ARCH_INLINE_SPIN_UNLOCK if !PREEMPTION
> > +     select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
> > +     select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
> > +     select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
> > +     select ARCH_SUPPORTS_ACPI
> > +     select ARCH_SUPPORTS_HUGETLBFS
> > +     select ARCH_USE_BUILTIN_BSWAP
> > +     select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
> > +     select ARCH_USE_QUEUED_RWLOCKS
> > +     select ARCH_USE_QUEUED_SPINLOCKS
> > +     select BUILDTIME_TABLE_SORT
> > +     select GENERIC_ATOMIC64 if !64BIT
> > +     select GENERIC_CLOCKEVENTS
> > +     select GENERIC_CMOS_UPDATE
> > +     select GENERIC_CPU_AUTOPROBE
> > +     select GENERIC_GETTIMEOFDAY
> > +     select GENERIC_IOMAP
> > +     select GENERIC_IRQ_PROBE
> > +     select GENERIC_IRQ_SHOW
> > +     select GENERIC_LIB_ASHLDI3
> > +     select GENERIC_LIB_ASHRDI3
> > +     select GENERIC_LIB_CMPDI2
> > +     select GENERIC_LIB_LSHRDI3
> > +     select GENERIC_LIB_UCMPDI2
> > +     select GENERIC_TIME_VSYSCALL
> > +     select HANDLE_DOMAIN_IRQ
> > +     select HAVE_ARCH_AUDITSYSCALL
> > +     select HAVE_ARCH_COMPILER_H
> > +     select HAVE_ARCH_MMAP_RND_BITS if MMU
> > +     select HAVE_ARCH_SECCOMP_FILTER
> > +     select HAVE_ARCH_TRACEHOOK
> > +     select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> > +     select HAVE_ASM_MODVERSIONS
> > +     select HAVE_CBPF_JIT if !64BIT
> > +     select HAVE_EBPF_JIT if 64BIT
> > +     select HAVE_CONTEXT_TRACKING
> > +     select HAVE_COPY_THREAD_TLS
> > +     select HAVE_DEBUG_KMEMLEAK
> > +     select HAVE_DEBUG_STACKOVERFLOW
> > +     select HAVE_DMA_CONTIGUOUS
> > +     select HAVE_EXIT_THREAD
> > +     select HAVE_FAST_GUP
> > +     select HAVE_FUTEX_CMPXCHG if FUTEX
> > +     select HAVE_GENERIC_VDSO
> > +     select HAVE_IDE
> > +     select HAVE_IOREMAP_PROT
> > +     select HAVE_IRQ_EXIT_ON_IRQ_STACK
> > +     select HAVE_IRQ_TIME_ACCOUNTING
> > +     select HAVE_MEMBLOCK
> > +     select HAVE_MEMBLOCK_NODE_MAP
> > +     select HAVE_MOD_ARCH_SPECIFIC
> > +     select HAVE_NMI
> > +     select HAVE_PERF_EVENTS
> > +     select HAVE_REGS_AND_STACK_ACCESS_API
> > +     select HAVE_RSEQ
> > +     select HAVE_SYSCALL_TRACEPOINTS
> > +     select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT
> > +     select IRQ_FORCED_THREADING
> > +     select MODULES_USE_ELF_RELA if MODULES && 64BIT
> > +     select MODULES_USE_ELF_REL if MODULES
> > +     select PCI_DOMAINS if PCI
> > +     select PCI_MSI_ARCH_FALLBACKS
> > +     select PERF_USE_VMALLOC
> > +     select RTC_LIB
> > +     select SYSCTL_EXCEPTION_TRACE
> > +     select VIRT_TO_BUS
> > +
> > +menu "Machine selection"
> > +
> > +choice
> > +     prompt "System type"
> > +     default MACH_LOONGSON64
> > +
> > +config MACH_LOONGSON64
>
>
> [...]
>
> > +choice
> > +     prompt "Kernel page size"
> > +     default PAGE_SIZE_16KB
> > +
> > +config PAGE_SIZE_4KB
> > +     bool "4kB"
> > +     help
> > +       This option select the standard 4kB Linux page size.
>
>                       selects
>
> > +
> > +config PAGE_SIZE_16KB
> > +     bool "16kB"
> > +     help
> > +       This option select the standard 16kB Linux page size.
>
>                       selects
>
> > +
> > +config PAGE_SIZE_64KB
> > +     bool "64kB"
> > +     help
> > +       This option select the standard 64kB Linux page size.
>
>                       selects
OK, thanks.

Huacai
>
> > +
> > +endchoice
>
>
> --
> ~Randy
>
