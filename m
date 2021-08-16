Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB93ECC83
	for <lists+linux-arch@lfdr.de>; Mon, 16 Aug 2021 03:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhHPB6X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 Aug 2021 21:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhHPB6X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 15 Aug 2021 21:58:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8A7A6136A
        for <linux-arch@vger.kernel.org>; Mon, 16 Aug 2021 01:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629079072;
        bh=aRoEFfFpmSjZh6HTp7quso1ddEYGIkZhWaXW6kTeOYg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ijN0sAdSGdujtUlke5DqrMUxC2BHC+oeij+ql598kmfKW6f6+bURvm01PAGRyxFDu
         uB6afGzCxEcHItqDyDf1NBpEEi7IGoUcgAMkmsVLO0YmjaEgMFAKmysoeNdR4vT1zl
         bfLAMek9aQvfzl72+pnaV9m6lNkBWZipmsQdSv8F3q1p5Uc7nYB/zIbK8mIHZjOUIR
         3Kp2VWeqKD0jJC6B7Toarc8ZwFWpI7mjMVl0LIGqnAQmSWBwMvQaUCuaiFo0xaA+4A
         RrhkWh1Xc85rsQcUyuxWBi/t3hkiynaENe8LxeBOjmt9zeZKobg/KGsfIkjQXSJB7Q
         oqeFuDZRx+Upg==
Received: by mail-lf1-f50.google.com with SMTP id d4so31318657lfk.9
        for <linux-arch@vger.kernel.org>; Sun, 15 Aug 2021 18:57:51 -0700 (PDT)
X-Gm-Message-State: AOAM531fsYyvSjqIPgZKT8dOcJRNtIwD8oOaRCN+Ht48B6M/lzF6tJal
        1etxolsAqtGHvQK6zfanisXerctQ0LvoRWmvHKg=
X-Google-Smtp-Source: ABdhPJyqx7FbDKQam4f+IJbfIupjV2GF3iuIqqEhvd+eMlkJT+8RBu71PptrGQk5eMeS/uQbR928NuQWIONovtrCyh8=
X-Received: by 2002:a05:6512:990:: with SMTP id w16mr9946147lft.346.1629079069673;
 Sun, 15 Aug 2021 18:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-9-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-9-chenhuacai@loongson.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 16 Aug 2021 09:57:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQpqkpyN-q1DFaMTNg4tL+TyeCct-s3sS2CG9KaMbaTwg@mail.gmail.com>
Message-ID: <CAJF2gTQpqkpyN-q1DFaMTNg4tL+TyeCct-s3sS2CG9KaMbaTwg@mail.gmail.com>
Subject: Re: [PATCH 08/19] LoongArch: Add memory management
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

 .

On Tue, Jul 6, 2021 at 12:19 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> This patch adds memory management support for LoongArch, including:
> cache and tlb management, page fault handling and ioremap/mmap support.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/cache.h      |  15 +
>  arch/loongarch/include/asm/cacheflush.h |  79 ++++
>  arch/loongarch/include/asm/cacheops.h   |  32 ++
>  arch/loongarch/include/asm/fixmap.h     |  15 +
>  arch/loongarch/include/asm/hugetlb.h    |  79 ++++
>  arch/loongarch/include/asm/kmalloc.h    |  10 +
>  arch/loongarch/include/asm/shmparam.h   |  12 +
>  arch/loongarch/include/asm/sparsemem.h  |  21 ++
>  arch/loongarch/include/asm/tlb.h        | 216 +++++++++++
>  arch/loongarch/include/asm/tlbflush.h   |  36 ++
>  arch/loongarch/include/asm/vmalloc.h    |   4 +
>  arch/loongarch/mm/cache.c               | 194 ++++++++++
>  arch/loongarch/mm/extable.c             |  22 ++
>  arch/loongarch/mm/fault.c               | 289 +++++++++++++++
>  arch/loongarch/mm/hugetlbpage.c         |  87 +++++
>  arch/loongarch/mm/init.c                | 199 ++++++++++
>  arch/loongarch/mm/ioremap.c             |  27 ++
>  arch/loongarch/mm/maccess.c             |  10 +
>  arch/loongarch/mm/mmap.c                | 204 ++++++++++
>  arch/loongarch/mm/page.S                |  93 +++++
>  arch/loongarch/mm/pgtable-64.c          | 116 ++++++
>  arch/loongarch/mm/pgtable.c             |  24 ++
>  arch/loongarch/mm/tlb.c                 | 278 ++++++++++++++
>  arch/loongarch/mm/tlbex.S               | 473 ++++++++++++++++++++++++
>  24 files changed, 2535 insertions(+)
>  create mode 100644 arch/loongarch/include/asm/cache.h
>  create mode 100644 arch/loongarch/include/asm/cacheflush.h
>  create mode 100644 arch/loongarch/include/asm/cacheops.h
>  create mode 100644 arch/loongarch/include/asm/fixmap.h
>  create mode 100644 arch/loongarch/include/asm/hugetlb.h
>  create mode 100644 arch/loongarch/include/asm/kmalloc.h
>  create mode 100644 arch/loongarch/include/asm/shmparam.h
>  create mode 100644 arch/loongarch/include/asm/sparsemem.h
>  create mode 100644 arch/loongarch/include/asm/tlb.h
>  create mode 100644 arch/loongarch/include/asm/tlbflush.h
>  create mode 100644 arch/loongarch/include/asm/vmalloc.h
>  create mode 100644 arch/loongarch/mm/cache.c
>  create mode 100644 arch/loongarch/mm/extable.c
>  create mode 100644 arch/loongarch/mm/fault.c
>  create mode 100644 arch/loongarch/mm/hugetlbpage.c
>  create mode 100644 arch/loongarch/mm/init.c
>  create mode 100644 arch/loongarch/mm/ioremap.c
>  create mode 100644 arch/loongarch/mm/maccess.c
>  create mode 100644 arch/loongarch/mm/mmap.c
>  create mode 100644 arch/loongarch/mm/page.S
>  create mode 100644 arch/loongarch/mm/pgtable-64.c
>  create mode 100644 arch/loongarch/mm/pgtable.c
>  create mode 100644 arch/loongarch/mm/tlb.c
>  create mode 100644 arch/loongarch/mm/tlbex.S
>
> diff --git a/arch/loongarch/include/asm/cache.h b/arch/loongarch/include/asm/cache.h
> new file mode 100644
> index 000000000000..641b2a0090e8
> --- /dev/null
> +++ b/arch/loongarch/include/asm/cache.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_CACHE_H
> +#define _ASM_CACHE_H
> +
> +#include <asm/kmalloc.h>
> +
> +#define L1_CACHE_SHIFT         CONFIG_L1_CACHE_SHIFT
> +#define L1_CACHE_BYTES         (1 << L1_CACHE_SHIFT)
> +
> +#define __read_mostly __section(".data..read_mostly")
> +
> +#endif /* _ASM_CACHE_H */
> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
> new file mode 100644
> index 000000000000..214ec714a27b
> --- /dev/null
> +++ b/arch/loongarch/include/asm/cacheflush.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_CACHEFLUSH_H
> +#define _ASM_CACHEFLUSH_H
> +
> +#include <linux/mm.h>
> +#include <asm/cpu-features.h>
> +#include <asm/cacheops.h>
> +
> +/*
> + * This flag is used to indicate that the page pointed to by a pte
> + * is dirty and requires cleaning before returning it to the user.
> + */
> +#define PG_dcache_dirty                        PG_arch_1
> +
> +#define Page_dcache_dirty(page)                \
> +       test_bit(PG_dcache_dirty, &(page)->flags)
> +#define SetPageDcacheDirty(page)       \
> +       set_bit(PG_dcache_dirty, &(page)->flags)
> +#define ClearPageDcacheDirty(page)     \
> +       clear_bit(PG_dcache_dirty, &(page)->flags)
> +
> +extern void local_flush_icache_range(unsigned long start, unsigned long end);
> +
> +#define flush_icache_range     local_flush_icache_range
> +#define flush_icache_user_range        local_flush_icache_range
> +
> +extern void copy_to_user_page(struct vm_area_struct *vma,
> +       struct page *page, unsigned long vaddr, void *dst, const void *src,
> +       unsigned long len);
> +
> +extern void copy_from_user_page(struct vm_area_struct *vma,
> +       struct page *page, unsigned long vaddr, void *dst, const void *src,
> +       unsigned long len);
> +
> +#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> +
> +#define flush_cache_all()                              do { } while (0)
> +#define flush_cache_mm(mm)                             do { } while (0)
> +#define flush_cache_dup_mm(mm)                         do { } while (0)
> +#define flush_cache_range(vma, start, end)             do { } while (0)
> +#define flush_cache_page(vma, vmaddr, pfn)             do { } while (0)
> +#define flush_cache_vmap(start, end)                   do { } while (0)
> +#define flush_cache_vunmap(start, end)                 do { } while (0)
> +#define flush_icache_page(vma, page)                   do { } while (0)
> +#define flush_icache_user_page(vma, page, addr, len)   do { } while (0)
> +#define flush_dcache_page(page)                                do { } while (0)
> +#define flush_dcache_mmap_lock(mapping)                        do { } while (0)
> +#define flush_dcache_mmap_unlock(mapping)              do { } while (0)
> +
> +#define cache_op(op, addr)                                             \
> +       __asm__ __volatile__(                                           \
> +       "       cacop   %0, %1                                  \n"     \
> +       :                                                               \
> +       : "i" (op), "R" (*(unsigned char *)(addr)))
> +
> +static inline void flush_icache_line_indexed(unsigned long addr)
> +{
> +       cache_op(Index_Invalidate_I, addr);
> +}
> +
> +static inline void flush_dcache_line_indexed(unsigned long addr)
> +{
> +       cache_op(Index_Writeback_Inv_D, addr);
> +}
> +
> +static inline void flush_icache_line(unsigned long addr)
> +{
> +       cache_op(Hit_Invalidate_I, addr);
> +}
> +
> +static inline void flush_dcache_line(unsigned long addr)
> +{
> +       cache_op(Hit_Writeback_Inv_D, addr);
> +}
> +
> +#endif /* _ASM_CACHEFLUSH_H */
> diff --git a/arch/loongarch/include/asm/cacheops.h b/arch/loongarch/include/asm/cacheops.h
> new file mode 100644
> index 000000000000..470354b92d0d
> --- /dev/null
> +++ b/arch/loongarch/include/asm/cacheops.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cache operations for the cache instruction.
> + *
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_CACHEOPS_H
> +#define __ASM_CACHEOPS_H
> +
> +/*
> + * Most cache ops are split into a 2 bit field identifying the cache, and a 3
> + * bit field identifying the cache operation.
> + */
> +#define CacheOp_Cache                  0x03
> +#define CacheOp_Op                     0x1c
> +
> +#define Cache_I                                0x00
> +#define Cache_D                                0x01
> +#define Cache_V                                0x02
> +#define Cache_S                                0x03
> +
> +#define Index_Invalidate               0x08
> +#define Index_Writeback_Inv            0x08
> +#define Hit_Invalidate                 0x10
> +#define Hit_Writeback_Inv              0x10
> +
> +#define Index_Invalidate_I             (Cache_I | Index_Invalidate)
> +#define Index_Writeback_Inv_D          (Cache_D | Index_Writeback_Inv)
> +#define Hit_Invalidate_I               (Cache_I | Hit_Invalidate)
> +#define Hit_Writeback_Inv_D            (Cache_D | Hit_Writeback_Inv)
> +
> +#endif /* __ASM_CACHEOPS_H */
> diff --git a/arch/loongarch/include/asm/fixmap.h b/arch/loongarch/include/asm/fixmap.h
> new file mode 100644
> index 000000000000..2ba4df6ec88d
> --- /dev/null
> +++ b/arch/loongarch/include/asm/fixmap.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * fixmap.h: compile-time virtual memory allocation
> + *
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef _ASM_FIXMAP_H
> +#define _ASM_FIXMAP_H
> +
> +#include <asm/page.h>
> +
> +#define NR_FIX_BTMAPS 64
> +
> +#endif
> diff --git a/arch/loongarch/include/asm/hugetlb.h b/arch/loongarch/include/asm/hugetlb.h
> new file mode 100644
> index 000000000000..5548ab8ceac2
> --- /dev/null
> +++ b/arch/loongarch/include/asm/hugetlb.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __ASM_HUGETLB_H
> +#define __ASM_HUGETLB_H
> +
> +#include <asm/page.h>
> +
> +uint64_t pmd_to_entrylo(unsigned long pmd_val);
> +
> +#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
> +static inline int prepare_hugepage_range(struct file *file,
> +                                        unsigned long addr,
> +                                        unsigned long len)
> +{
> +       unsigned long task_size = STACK_TOP;
> +       struct hstate *h = hstate_file(file);
> +
> +       if (len & ~huge_page_mask(h))
> +               return -EINVAL;
> +       if (addr & ~huge_page_mask(h))
> +               return -EINVAL;
> +       if (len > task_size)
> +               return -ENOMEM;
> +       if (task_size - len < addr)
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +#define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
> +static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> +                                           unsigned long addr, pte_t *ptep)
> +{
> +       pte_t clear;
> +       pte_t pte = *ptep;
> +
> +       pte_val(clear) = (unsigned long)invalid_pte_table;
> +       set_pte_at(mm, addr, ptep, clear);
> +       return pte;
> +}
> +
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
> +static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
> +                                        unsigned long addr, pte_t *ptep)
> +{
> +       flush_tlb_page(vma, addr & huge_page_mask(hstate_vma(vma)));
> +}
> +
> +#define __HAVE_ARCH_HUGE_PTE_NONE
> +static inline int huge_pte_none(pte_t pte)
> +{
> +       unsigned long val = pte_val(pte) & ~_PAGE_GLOBAL;
> +       return !val || (val == (unsigned long)invalid_pte_table);
> +}
> +
> +#define __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
> +static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> +                                            unsigned long addr,
> +                                            pte_t *ptep, pte_t pte,
> +                                            int dirty)
> +{
> +       int changed = !pte_same(*ptep, pte);
> +
> +       if (changed) {
> +               set_pte_at(vma->vm_mm, addr, ptep, pte);
> +               /*
> +                * There could be some standard sized pages in there,
> +                * get them all.
> +                */
> +               flush_tlb_range(vma, addr, addr + HPAGE_SIZE);
> +       }
> +       return changed;
> +}
> +
> +#include <asm-generic/hugetlb.h>
> +
> +#endif /* __ASM_HUGETLB_H */
> diff --git a/arch/loongarch/include/asm/kmalloc.h b/arch/loongarch/include/asm/kmalloc.h
> new file mode 100644
> index 000000000000..b318c41520d8
> --- /dev/null
> +++ b/arch/loongarch/include/asm/kmalloc.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_KMALLOC_H
> +#define __ASM_KMALLOC_H
> +
> +#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
> +
> +#endif /* __ASM_KMALLOC_H */
> diff --git a/arch/loongarch/include/asm/shmparam.h b/arch/loongarch/include/asm/shmparam.h
> new file mode 100644
> index 000000000000..f726ac537710
> --- /dev/null
> +++ b/arch/loongarch/include/asm/shmparam.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_SHMPARAM_H
> +#define _ASM_SHMPARAM_H
> +
> +#define __ARCH_FORCE_SHMLBA    1
> +
> +#define        SHMLBA  (4 * PAGE_SIZE)          /* attach addr a multiple of this */
> +
> +#endif /* _ASM_SHMPARAM_H */
> diff --git a/arch/loongarch/include/asm/sparsemem.h b/arch/loongarch/include/asm/sparsemem.h
> new file mode 100644
> index 000000000000..9b57dc69f523
> --- /dev/null
> +++ b/arch/loongarch/include/asm/sparsemem.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LOONGARCH_SPARSEMEM_H
> +#define _LOONGARCH_SPARSEMEM_H
> +
> +#ifdef CONFIG_SPARSEMEM
> +
> +/*
> + * SECTION_SIZE_BITS           2^N: how big each section will be
> + * MAX_PHYSMEM_BITS            2^N: how much memory we can have in that space
> + */
> +#define SECTION_SIZE_BITS      29
> +#define MAX_PHYSMEM_BITS       48
> +
> +#endif /* CONFIG_SPARSEMEM */
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +int memory_add_physaddr_to_nid(u64 addr);
> +#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> +#endif
> +
> +#endif /* _LOONGARCH_SPARSEMEM_H */
> diff --git a/arch/loongarch/include/asm/tlb.h b/arch/loongarch/include/asm/tlb.h
> new file mode 100644
> index 000000000000..7a1745ea404d
> --- /dev/null
> +++ b/arch/loongarch/include/asm/tlb.h
> @@ -0,0 +1,216 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_TLB_H
> +#define __ASM_TLB_H
> +
> +#include <linux/mm_types.h>
> +#include <asm/cpu-features.h>
> +#include <asm/loongarchregs.h>
> +
> +/*
> + * TLB Invalidate Flush
> + */
> +static inline void tlbclr(void)
> +{
> +       __asm__ __volatile__("tlbclr");
> +}
> +
> +static inline void tlbflush(void)
> +{
> +       __asm__ __volatile__("tlbflush");
> +}
> +
> +/*
> + * TLB R/W operations.
> + */
> +static inline void tlb_probe(void)
> +{
> +       __asm__ __volatile__("tlbsrch");
> +}
> +
> +static inline void tlb_read(void)
> +{
> +       __asm__ __volatile__("tlbrd");
> +}
> +
> +static inline void tlb_write_indexed(void)
> +{
> +       __asm__ __volatile__("tlbwr");
> +}
> +
> +static inline void tlb_write_random(void)
> +{
> +       __asm__ __volatile__("tlbfill");
> +}
> +
> +/*
> + * Guest TLB Invalidate Flush
> + */
> +static inline void guest_tlbflush(void)
> +{
> +       __asm__ __volatile__(
> +               ".word 0x6482401\n\t");
> +}
> +
> +/*
> + * Guest TLB R/W operations.
> + */
> +static inline void guest_tlb_probe(void)
> +{
> +       __asm__ __volatile__(
> +               ".word 0x6482801\n\t");
> +}
> +
> +static inline void guest_tlb_read(void)
> +{
> +       __asm__ __volatile__(
> +               ".word 0x6482c01\n\t");
> +}
> +
> +static inline void guest_tlb_write_indexed(void)
> +{
> +       __asm__ __volatile__(
> +               ".word 0x6483001\n\t");
> +}
> +
> +static inline void guest_tlb_write_random(void)
> +{
> +       __asm__ __volatile__(
> +               ".word 0x6483401\n\t");
> +}
All opcodes need comments and macro defined properly in headers. I
guess these are for MIPS assembler.

> +
> +enum invtlb_ops {
> +       /* Invalid all tlb */
> +       INVTLB_ALL = 0x0,
> +       /* Invalid current tlb */
> +       INVTLB_CURRENT_ALL = 0x1,
> +       /* Invalid all global=1 lines in current tlb */
> +       INVTLB_CURRENT_GTRUE = 0x2,
> +       /* Invalid all global=0 lines in current tlb */
> +       INVTLB_CURRENT_GFALSE = 0x3,
> +       /* Invalid global=0 and matched asid lines in current tlb */
> +       INVTLB_GFALSE_AND_ASID = 0x4,
> +       /* Invalid addr with global=0 and matched asid in current tlb */
> +       INVTLB_ADDR_GFALSE_AND_ASID = 0x5,
> +       /* Invalid addr with global=1 or matched asid in current tlb */
> +       INVTLB_ADDR_GTRUE_OR_ASID = 0x6,
> +       /* Invalid matched gid in guest tlb */
> +       INVGTLB_GID = 0x9,
> +       /* Invalid global=1, matched gid in guest tlb */
> +       INVGTLB_GID_GTRUE = 0xa,
> +       /* Invalid global=0, matched gid in guest tlb */
> +       INVGTLB_GID_GFALSE = 0xb,
> +       /* Invalid global=0, matched gid and asid in guest tlb */
> +       INVGTLB_GID_GFALSE_ASID = 0xc,
> +       /* Invalid global=0 , matched gid, asid and addr in guest tlb */
> +       INVGTLB_GID_GFALSE_ASID_ADDR = 0xd,
> +       /* Invalid global=1 , matched gid, asid and addr in guest tlb */
> +       INVGTLB_GID_GTRUE_ASID_ADDR = 0xe,
> +       /* Invalid all gid gva-->gpa guest tlb */
> +       INVGTLB_ALLGID_GVA_TO_GPA = 0x10,
> +       /* Invalid all gid gpa-->hpa tlb */
> +       INVTLB_ALLGID_GPA_TO_HPA = 0x11,
> +       /* Invalid all gid tlb, including  gva-->gpa and gpa-->hpa */
> +       INVTLB_ALLGID = 0x12,
> +       /* Invalid matched gid gva-->gpa guest tlb */
> +       INVGTLB_GID_GVA_TO_GPA = 0x13,
> +       /* Invalid matched gid gpa-->hpa tlb */
> +       INVTLB_GID_GPA_TO_HPA = 0x14,
> +       /* Invalid matched gid tlb,including gva-->gpa and gpa-->hpa */
> +       INVTLB_GID_ALL = 0x15,
> +       /* Invalid matched gid and addr gpa-->hpa tlb */
> +       INVTLB_GID_ADDR = 0x16,
> +};
> +
> +/*
> + * invtlb op info addr
> + * (0x1 << 26) | (0x24 << 20) | (0x13 << 15) |
> + * (addr << 10) | (info << 5) | op
> + */
> +static inline void invtlb(u32 op, u32 info, u64 addr)
> +{
> +       __asm__ __volatile__(
> +               "parse_r addr,%0\n\t"
> +               "parse_r info,%1\n\t"
> +               ".word ((0x6498000) | (addr << 10) | (info << 5) | %2)\n\t"
> +               :
> +               : "r"(addr), "r"(info), "i"(op)
> +               :
> +               );
> +}
> +
> +static inline void invtlb_addr(u32 op, u32 info, u64 addr)
> +{
> +       __asm__ __volatile__(
> +               "parse_r addr,%0\n\t"
> +               ".word ((0x6498000) | (addr << 10) | (0 << 5) | %1)\n\t"
> +               :
> +               : "r"(addr), "i"(op)
> +               :
> +               );
> +}
> +
> +static inline void invtlb_info(u32 op, u32 info, u64 addr)
> +{
> +       __asm__ __volatile__(
> +               "parse_r info,%0\n\t"
> +               ".word ((0x6498000) | (0 << 10) | (info << 5) | %1)\n\t"
> +               :
> +               : "r"(info), "i"(op)
> +               :
> +               );
> +}
> +
> +static inline void invtlb_all(u32 op, u32 info, u64 addr)
> +{
> +       __asm__ __volatile__(
> +               ".word ((0x6498000) | (0 << 10) | (0 << 5) | %0)\n\t"
> +               :
> +               : "i"(op)
> +               :
> +               );
> +}
Ditto

> +
> +/*
> + * LoongArch doesn't need any special per-pte or per-vma handling, except
> + * we need to flush cache for area to be unmapped.
> + */
> +#define tlb_start_vma(tlb, vma)                                        \
> +       do {                                                    \
> +               if (!(tlb)->fullmm)                             \
> +                       flush_cache_range(vma, vma->vm_start, vma->vm_end); \
> +       }  while (0)
> +#define tlb_end_vma(tlb, vma) do { } while (0)
> +#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
> +
> +static void tlb_flush(struct mmu_gather *tlb);
> +
> +#define tlb_flush tlb_flush
> +#include <asm-generic/tlb.h>
> +
> +static inline void tlb_flush(struct mmu_gather *tlb)
> +{
> +       struct vm_area_struct vma;
> +
> +       vma.vm_mm = tlb->mm;
> +       vma.vm_flags = 0;
> +       if (tlb->fullmm) {
> +               flush_tlb_mm(tlb->mm);
> +               return;
> +       }
> +
> +       flush_tlb_range(&vma, tlb->start, tlb->end);
> +}
> +
> +extern void handle_tlb_load(void);
> +extern void handle_tlb_store(void);
> +extern void handle_tlb_modify(void);
> +extern void handle_tlb_refill(void);
> +extern void handle_tlb_rixi(void);
> +
> +extern void dump_tlb_all(void);
> +extern void dump_tlb_regs(void);
> +
> +#endif /* __ASM_TLB_H */
> diff --git a/arch/loongarch/include/asm/tlbflush.h b/arch/loongarch/include/asm/tlbflush.h
> new file mode 100644
> index 000000000000..a5672367d966
> --- /dev/null
> +++ b/arch/loongarch/include/asm/tlbflush.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_TLBFLUSH_H
> +#define __ASM_TLBFLUSH_H
> +
> +#include <linux/mm.h>
> +
> +/*
> + * TLB flushing:
> + *
> + *  - flush_tlb_all() flushes all processes TLB entries
> + *  - flush_tlb_mm(mm) flushes the specified mm context TLB entries
> + *  - flush_tlb_page(vma, vmaddr) flushes one page
> + *  - flush_tlb_range(vma, start, end) flushes a range of pages
> + *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
> + */
> +extern void local_flush_tlb_all(void);
> +extern void local_flush_tlb_mm(struct mm_struct *mm);
> +extern void local_flush_tlb_range(struct vm_area_struct *vma,
> +       unsigned long start, unsigned long end);
> +extern void local_flush_tlb_kernel_range(unsigned long start,
> +       unsigned long end);
> +extern void local_flush_tlb_page(struct vm_area_struct *vma,
> +       unsigned long page);
> +extern void local_flush_tlb_one(unsigned long vaddr);
> +
> +#define flush_tlb_all()                        local_flush_tlb_all()
> +#define flush_tlb_mm(mm)               local_flush_tlb_mm(mm)
> +#define flush_tlb_range(vma, vmaddr, end)      local_flush_tlb_range(vma, vmaddr, end)
> +#define flush_tlb_kernel_range(vmaddr, end)    local_flush_tlb_kernel_range(vmaddr, end)
> +#define flush_tlb_page(vma, page)      local_flush_tlb_page(vma, page)
> +#define flush_tlb_one(vaddr)           local_flush_tlb_one(vaddr)
> +
> +#endif /* __ASM_TLBFLUSH_H */
> diff --git a/arch/loongarch/include/asm/vmalloc.h b/arch/loongarch/include/asm/vmalloc.h
> new file mode 100644
> index 000000000000..965a0d41ac2d
> --- /dev/null
> +++ b/arch/loongarch/include/asm/vmalloc.h
> @@ -0,0 +1,4 @@
> +#ifndef _ASM_LOONGARCH_VMALLOC_H
> +#define _ASM_LOONGARCH_VMALLOC_H
> +
> +#endif /* _ASM_LOONGARCH_VMALLOC_H */
> diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
> new file mode 100644
> index 000000000000..945087a88d03
> --- /dev/null
> +++ b/arch/loongarch/mm/cache.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#include <linux/export.h>
> +#include <linux/fcntl.h>
> +#include <linux/fs.h>
> +#include <linux/highmem.h>
> +#include <linux/kernel.h>
> +#include <linux/linkage.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/syscalls.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/cpu.h>
> +#include <asm/cpu-features.h>
> +#include <asm/dma.h>
> +#include <asm/loongarchregs.h>
> +#include <asm/processor.h>
> +#include <asm/setup.h>
> +
> +/* Cache operations. */
> +void local_flush_icache_range(unsigned long start, unsigned long end)
> +{
> +       asm volatile ("\tibar 0\n"::);
> +}
Would loongarch support any broadcast icache invalid instructions in SMP?

> +
> +void __update_cache(unsigned long address, pte_t pte)
> +{
> +       struct page *page;
> +       unsigned long pfn, addr;
> +
> +       pfn = pte_pfn(pte);
> +       if (unlikely(!pfn_valid(pfn)))
> +               return;
> +       page = pfn_to_page(pfn);
> +       if (Page_dcache_dirty(page)) {
> +               if (PageHighMem(page))
> +                       addr = (unsigned long)kmap_atomic(page);
> +               else
> +                       addr = (unsigned long)page_address(page);
nothing here?
> +
> +               if (PageHighMem(page))
> +                       kunmap_atomic((void *)addr);
Why need above codes?

> +
> +               ClearPageDcacheDirty(page);
> +       }
> +}
> +
> +static inline void setup_protection_map(void)
> +{
> +       protection_map[0]  = __pgprot(_CACHE_CC |
> +               _PAGE_PROTNONE | _PAGE_NO_EXEC | _PAGE_NO_READ);
> +       protection_map[1]  = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC);
> +       protection_map[2]  = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> +       protection_map[3]  = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC);
> +       protection_map[4]  = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT);
> +       protection_map[5]  = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT);
> +       protection_map[6]  = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT);
> +       protection_map[7]  = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT);
> +
> +       protection_map[8]  = __pgprot(_CACHE_CC |
> +               _PAGE_PROTNONE | _PAGE_NO_EXEC | _PAGE_NO_READ);
> +       protection_map[9]  = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC);
> +       protection_map[10] = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | _PAGE_NO_READ);
> +       protection_map[11] = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
> +       protection_map[12] = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT);
> +       protection_map[13] = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT);
> +       protection_map[14] = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT | _PAGE_WRITE);
> +       protection_map[15] = __pgprot(_CACHE_CC |
> +               _PAGE_USER | _PAGE_PRESENT | _PAGE_WRITE);
> +}
> +
> +void cache_error_setup(void)
> +{
> +       extern char __weak except_vec_cex;
> +       set_merr_handler(0x0, &except_vec_cex, 0x80);
> +}
> +
> +static unsigned long icache_size __read_mostly;
> +static unsigned long dcache_size __read_mostly;
> +static unsigned long vcache_size __read_mostly;
> +static unsigned long scache_size __read_mostly;
> +
> +static char *way_string[] = { NULL, "direct mapped", "2-way",
> +       "3-way", "4-way", "5-way", "6-way", "7-way", "8-way",
> +       "9-way", "10-way", "11-way", "12-way",
> +       "13-way", "14-way", "15-way", "16-way",
> +};
> +
> +static void probe_pcache(void)
> +{
> +       struct cpuinfo_loongarch *c = &current_cpu_data;
> +       unsigned int lsize, sets, ways;
> +       unsigned int config;
> +
> +       config = read_cpucfg(LOONGARCH_CPUCFG17);
> +       lsize = 1 << ((config & CPUCFG17_L1I_SIZE_M) >> CPUCFG17_L1I_SIZE);
> +       sets  = 1 << ((config & CPUCFG17_L1I_SETS_M) >> CPUCFG17_L1I_SETS);
> +       ways  = ((config & CPUCFG17_L1I_WAYS_M) >> CPUCFG17_L1I_WAYS) + 1;
> +
> +       c->icache.linesz = lsize;
> +       c->icache.sets = sets;
> +       c->icache.ways = ways;
> +       icache_size = sets * ways * lsize;
> +       c->icache.waysize = icache_size / c->icache.ways;
> +
> +       config = read_cpucfg(LOONGARCH_CPUCFG18);
> +       lsize = 1 << ((config & CPUCFG18_L1D_SIZE_M) >> CPUCFG18_L1D_SIZE);
> +       sets  = 1 << ((config & CPUCFG18_L1D_SETS_M) >> CPUCFG18_L1D_SETS);
> +       ways  = ((config & CPUCFG18_L1D_WAYS_M) >> CPUCFG18_L1D_WAYS) + 1;
> +
> +       c->dcache.linesz = lsize;
> +       c->dcache.sets = sets;
> +       c->dcache.ways = ways;
> +       dcache_size = sets * ways * lsize;
> +       c->dcache.waysize = dcache_size / c->dcache.ways;
> +
> +       c->options |= LOONGARCH_CPU_PREFETCH;
> +
> +       pr_info("Primary instruction cache %ldkB, %s, %s, linesize %d bytes.\n",
> +               icache_size >> 10, way_string[c->icache.ways], "VIPT", c->icache.linesz);
> +
> +       pr_info("Primary data cache %ldkB, %s, %s, %s, linesize %d bytes\n",
> +               dcache_size >> 10, way_string[c->dcache.ways], "VIPT", "no aliases", c->dcache.linesz);
> +}
> +
> +static void probe_vcache(void)
> +{
> +       struct cpuinfo_loongarch *c = &current_cpu_data;
> +       unsigned int lsize, sets, ways;
> +       unsigned int config;
> +
> +       config = read_cpucfg(LOONGARCH_CPUCFG19);
> +       lsize = 1 << ((config & CPUCFG19_L2_SIZE_M) >> CPUCFG19_L2_SIZE);
> +       sets  = 1 << ((config & CPUCFG19_L2_SETS_M) >> CPUCFG19_L2_SETS);
> +       ways  = ((config & CPUCFG19_L2_WAYS_M) >> CPUCFG19_L2_WAYS) + 1;
> +
> +       c->vcache.linesz = lsize;
> +       c->vcache.sets = sets;
> +       c->vcache.ways = ways;
> +       vcache_size = lsize * sets * ways;
> +       c->vcache.waysize = vcache_size / c->vcache.ways;
> +
> +       pr_info("Unified victim cache %ldkB %s, linesize %d bytes.\n",
> +               vcache_size >> 10, way_string[c->vcache.ways], c->vcache.linesz);
> +}
> +
> +static void probe_scache(void)
> +{
> +       struct cpuinfo_loongarch *c = &current_cpu_data;
> +       unsigned int lsize, sets, ways;
> +       unsigned int config;
> +
> +       config = read_cpucfg(LOONGARCH_CPUCFG20);
> +       lsize = 1 << ((config & CPUCFG20_L3_SIZE_M) >> CPUCFG20_L3_SIZE);
> +       sets  = 1 << ((config & CPUCFG20_L3_SETS_M) >> CPUCFG20_L3_SETS);
> +       ways  = ((config & CPUCFG20_L3_WAYS_M) >> CPUCFG20_L3_WAYS) + 1;
> +
> +       c->scache.linesz = lsize;
> +       c->scache.sets = sets;
> +       c->scache.ways = ways;
> +       /* 4 cores. scaches are shared */
> +       scache_size = lsize * sets * ways;
> +       c->scache.waysize = scache_size / c->scache.ways;
> +
> +       pr_info("Unified secondary cache %ldkB %s, linesize %d bytes.\n",
> +               scache_size >> 10, way_string[c->scache.ways], c->scache.linesz);
> +}
> +
> +void cpu_cache_init(void)
> +{
> +       probe_pcache();
> +       probe_vcache();
> +       probe_scache();
> +
> +       shm_align_mask = PAGE_SIZE - 1;
> +
> +       setup_protection_map();
> +}
> diff --git a/arch/loongarch/mm/extable.c b/arch/loongarch/mm/extable.c
> new file mode 100644
> index 000000000000..7b367a8dd7e0
> --- /dev/null
> +++ b/arch/loongarch/mm/extable.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#include <linux/extable.h>
> +#include <linux/spinlock.h>
> +#include <asm/branch.h>
> +#include <linux/uaccess.h>
> +
> +int fixup_exception(struct pt_regs *regs)
> +{
> +       const struct exception_table_entry *fixup;
> +
> +       fixup = search_exception_tables(exception_epc(regs));
> +       if (fixup) {
> +               regs->csr_epc = fixup->fixup;
> +
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
> new file mode 100644
> index 000000000000..f3a523379993
> --- /dev/null
> +++ b/arch/loongarch/mm/fault.c
> @@ -0,0 +1,289 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#include <linux/context_tracking.h>
> +#include <linux/signal.h>
> +#include <linux/sched.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/ptrace.h>
> +#include <linux/ratelimit.h>
> +#include <linux/mman.h>
> +#include <linux/mm.h>
> +#include <linux/smp.h>
> +#include <linux/kdebug.h>
> +#include <linux/kprobes.h>
> +#include <linux/perf_event.h>
> +#include <linux/uaccess.h>
> +
> +#include <asm/branch.h>
> +#include <asm/mmu_context.h>
> +#include <asm/ptrace.h>
> +
> +int show_unhandled_signals = 1;
> +
> +/*
> + * This routine handles page faults.  It determines the address,
> + * and the problem, and then passes it off to one of the appropriate
> + * routines.
> + */
> +static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
> +       unsigned long address)
> +{
> +       int si_code;
> +       const int field = sizeof(unsigned long) * 2;
> +       unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
> +       struct task_struct *tsk = current;
> +       struct mm_struct *mm = tsk->mm;
> +       struct vm_area_struct *vma = NULL;
> +       vm_fault_t fault;
> +
> +       static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 10);
> +
> +       si_code = SEGV_MAPERR;
> +
> +       if (user_mode(regs) && (address & __UA_LIMIT))
> +               goto bad_area_nosemaphore;
> +
> +       /*
> +        * We fault-in kernel-space virtual memory on-demand. The
> +        * 'reference' page table is init_mm.pgd.
> +        *
> +        * NOTE! We MUST NOT take any locks for this case. We may
> +        * be in an interrupt or a critical region, and should
> +        * only copy the information from the master page table,
> +        * nothing more.
> +        */
> +#ifdef CONFIG_64BIT
> +# define VMALLOC_FAULT_TARGET no_context
> +#else
> +# define VMALLOC_FAULT_TARGET vmalloc_fault
> +#endif
> +       if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
> +               goto VMALLOC_FAULT_TARGET;
> +
> +       /* Enable interrupts if they were enabled in the parent context. */
> +       if (likely(regs->csr_prmd & CSR_PRMD_PIE))
> +               local_irq_enable();
> +
> +       /*
> +        * If we're in an interrupt or have no user
> +        * context, we must not take the fault..
> +        */
> +       if (faulthandler_disabled() || !mm)
> +               goto bad_area_nosemaphore;
> +
> +       if (user_mode(regs))
> +               flags |= FAULT_FLAG_USER;
> +retry:
> +       mmap_read_lock(mm);
> +       vma = find_vma(mm, address);
> +       if (!vma)
> +               goto bad_area;
> +       if (vma->vm_start <= address)
> +               goto good_area;
> +       if (!(vma->vm_flags & VM_GROWSDOWN))
> +               goto bad_area;
> +       if (expand_stack(vma, address))
> +               goto bad_area;
> +/*
> + * Ok, we have a good vm_area for this memory access, so
> + * we can handle it..
> + */
> +good_area:
> +       si_code = SEGV_ACCERR;
> +
> +       if (write) {
> +               if (!(vma->vm_flags & VM_WRITE))
> +                       goto bad_area;
> +               flags |= FAULT_FLAG_WRITE;
> +       } else {
> +               if (address == regs->csr_epc && !(vma->vm_flags & VM_EXEC))
> +                       goto bad_area;
> +               if (!(vma->vm_flags & VM_READ) &&
> +                   exception_epc(regs) != address)
> +                       goto bad_area;
> +       }
> +
> +       /*
> +        * If for any reason at all we couldn't handle the fault,
> +        * make sure we exit gracefully rather than endlessly redo
> +        * the fault.
> +        */
> +       fault = handle_mm_fault(vma, address, flags, regs);
> +
> +       if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +               return;
> +
> +       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
> +       if (unlikely(fault & VM_FAULT_ERROR)) {
> +               if (fault & VM_FAULT_OOM)
> +                       goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
> +               else if (fault & VM_FAULT_SIGBUS)
> +                       goto do_sigbus;
> +               BUG();
> +       }
> +       if (flags & FAULT_FLAG_ALLOW_RETRY) {
> +               if (fault & VM_FAULT_MAJOR) {
> +                       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> +                                                 regs, address);
> +                       tsk->maj_flt++;
> +               } else {
> +                       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> +                                                 regs, address);
> +                       tsk->min_flt++;
> +               }
> +               if (fault & VM_FAULT_RETRY) {
> +                       flags &= ~FAULT_FLAG_ALLOW_RETRY;
> +                       flags |= FAULT_FLAG_TRIED;
> +
> +                       /*
> +                        * No need to mmap_read_unlock(mm) as we would
> +                        * have already released it in __lock_page_or_retry
> +                        * in mm/filemap.c.
> +                        */
> +
> +                       goto retry;
> +               }
> +       }
> +
> +       mmap_read_unlock(mm);
> +       return;
> +
> +/*
> + * Something tried to access memory that isn't in our memory map..
> + * Fix it, but check if it's kernel or user first..
> + */
> +bad_area:
> +       mmap_read_unlock(mm);
> +
> +bad_area_nosemaphore:
> +       /* User mode accesses just cause a SIGSEGV */
> +       if (user_mode(regs)) {
> +               tsk->thread.csr_badvaddr = address;
> +               tsk->thread.error_code = write;
> +               if (show_unhandled_signals &&
> +                   unhandled_signal(tsk, SIGSEGV) &&
> +                   __ratelimit(&ratelimit_state)) {
> +                       pr_info("do_page_fault(): sending SIGSEGV to %s for invalid %s %0*lx\n",
> +                               tsk->comm,
> +                               write ? "write access to" : "read access from",
> +                               field, address);
> +                       pr_info("epc = %0*lx in", field,
> +                               (unsigned long) regs->csr_epc);
> +                       print_vma_addr(KERN_CONT " ", regs->csr_epc);
> +                       pr_cont("\n");
> +                       pr_info("ra  = %0*lx in", field,
> +                               (unsigned long) regs->regs[1]);
> +                       print_vma_addr(KERN_CONT " ", regs->regs[1]);
> +                       pr_cont("\n");
> +               }
> +               current->thread.trap_nr = read_csr_excode();
> +               force_sig_fault(SIGSEGV, si_code, (void __user *)address);
> +               return;
> +       }
> +
> +no_context:
> +       /* Are we prepared to handle this kernel fault?  */
> +       if (fixup_exception(regs)) {
> +               current->thread.csr_baduaddr = address;
> +               return;
> +       }
> +
> +       /*
> +        * Oops. The kernel tried to access some bad page. We'll have to
> +        * terminate things with extreme prejudice.
> +        */
> +       bust_spinlocks(1);
> +
> +       pr_alert("CPU %d Unable to handle kernel paging request at "
> +              "virtual address %0*lx, epc == %0*lx, ra == %0*lx\n",
> +              raw_smp_processor_id(), field, address, field, regs->csr_epc,
> +              field,  regs->regs[1]);
> +       die("Oops", regs);
> +
> +out_of_memory:
> +       /*
> +        * We ran out of memory, call the OOM killer, and return the userspace
> +        * (which will retry the fault, or kill us if we got oom-killed).
> +        */
> +       mmap_read_unlock(mm);
> +       if (!user_mode(regs))
> +               goto no_context;
> +       pagefault_out_of_memory();
> +       return;
> +
> +do_sigbus:
> +       mmap_read_unlock(mm);
> +
> +       /* Kernel mode? Handle exceptions or die */
> +       if (!user_mode(regs))
> +               goto no_context;
> +
> +       /*
> +        * Send a sigbus, regardless of whether we were in kernel
> +        * or user mode.
> +        */
> +       current->thread.trap_nr = read_csr_excode();
> +       tsk->thread.csr_badvaddr = address;
> +       force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
> +
> +       return;
> +
> +#ifndef CONFIG_64BIT
> +vmalloc_fault:
> +       {
> +               /*
> +                * Synchronize this task's top level page-table
> +                * with the 'reference' page table.
> +                *
> +                * Do _not_ use "tsk" here. We might be inside
> +                * an interrupt in the middle of a task switch..
> +                */
> +               int offset = __pgd_offset(address);
> +               pgd_t *pgd, *pgd_k;
> +               pud_t *pud, *pud_k;
> +               pmd_t *pmd, *pmd_k;
> +               pte_t *pte_k;
> +
> +               pgd = (pgd_t *) pgd_current[raw_smp_processor_id()] + offset;
Please using PER_CPU infrastructure. Or using LOONGARCH_CSR_PGDH.
> +               pgd_k = init_mm.pgd + offset;
> +
> +               if (!pgd_present(*pgd_k))
> +                       goto no_context;
> +               set_pgd(pgd, *pgd_k);
> +
> +               pud = pud_offset(pgd, address);
> +               pud_k = pud_offset(pgd_k, address);
> +               if (!pud_present(*pud_k))
> +                       goto no_context;
> +
> +               pmd = pmd_offset(pud, address);
> +               pmd_k = pmd_offset(pud_k, address);
> +               if (!pmd_present(*pmd_k))
> +                       goto no_context;
> +               set_pmd(pmd, *pmd_k);
> +
> +               pte_k = pte_offset_kernel(pmd_k, address);
> +               if (!pte_present(*pte_k))
> +                       goto no_context;
> +               return;
> +       }
> +#endif
> +}
> +
> +asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
> +       unsigned long write, unsigned long address)
> +{
> +       enum ctx_state prev_state;
> +
> +       prev_state = exception_enter();
> +       __do_page_fault(regs, write, address);
> +       exception_exit(prev_state);
> +}
> diff --git a/arch/loongarch/mm/hugetlbpage.c b/arch/loongarch/mm/hugetlbpage.c
> new file mode 100644
> index 000000000000..f6f56f5e8a08
> --- /dev/null
> +++ b/arch/loongarch/mm/hugetlbpage.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/hugetlb.h>
> +#include <linux/pagemap.h>
> +#include <linux/err.h>
> +#include <linux/sysctl.h>
> +#include <asm/mman.h>
> +#include <asm/tlb.h>
> +#include <asm/tlbflush.h>
> +
> +pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> +                     unsigned long addr, unsigned long sz)
> +{
> +       pgd_t *pgd;
> +       p4d_t *p4d;
> +       pud_t *pud;
> +       pte_t *pte = NULL;
> +
> +       pgd = pgd_offset(mm, addr);
> +       p4d = p4d_alloc(mm, pgd, addr);
> +       pud = pud_alloc(mm, p4d, addr);
> +       if (pud)
> +               pte = (pte_t *)pmd_alloc(mm, pud, addr);
> +
> +       return pte;
> +}
> +
> +pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
> +                      unsigned long sz)
> +{
> +       pgd_t *pgd;
> +       p4d_t *p4d;
> +       pud_t *pud;
> +       pmd_t *pmd = NULL;
> +
> +       pgd = pgd_offset(mm, addr);
> +       if (pgd_present(*pgd)) {
> +               p4d = p4d_offset(pgd, addr);
> +               if (p4d_present(*p4d)) {
> +                       pud = pud_offset(p4d, addr);
> +                       if (pud_present(*pud))
> +                               pmd = pmd_offset(pud, addr);
> +               }
> +       }
> +       return (pte_t *) pmd;
> +}
> +
> +/*
> + * This function checks for proper alignment of input addr and len parameters.
> + */
> +int is_aligned_hugepage_range(unsigned long addr, unsigned long len)
> +{
> +       if (len & ~HPAGE_MASK)
> +               return -EINVAL;
> +       if (addr & ~HPAGE_MASK)
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +int pmd_huge(pmd_t pmd)
> +{
> +       return (pmd_val(pmd) & _PAGE_HUGE) != 0;
> +}
> +
> +int pud_huge(pud_t pud)
> +{
> +       return (pud_val(pud) & _PAGE_HUGE) != 0;
> +}
> +
> +uint64_t pmd_to_entrylo(unsigned long pmd_val)
> +{
> +       uint64_t val;
> +       /* PMD as PTE. Must be huge page */
> +       if (!pmd_huge(__pmd(pmd_val)))
> +               panic("%s", __func__);
> +
> +       val = pmd_val ^ _PAGE_HUGE;
> +       val |= ((val & _PAGE_HGLOBAL) >>
> +               (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT));
> +
> +       return val;
> +}
> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> new file mode 100644
> index 000000000000..e661017ca23e
> --- /dev/null
> +++ b/arch/loongarch/mm/init.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#include <linux/bug.h>
> +#include <linux/init.h>
> +#include <linux/export.h>
> +#include <linux/signal.h>
> +#include <linux/sched.h>
> +#include <linux/smp.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/pagemap.h>
> +#include <linux/ptrace.h>
> +#include <linux/memblock.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/highmem.h>
> +#include <linux/swap.h>
> +#include <linux/proc_fs.h>
> +#include <linux/pfn.h>
> +#include <linux/hardirq.h>
> +#include <linux/gfp.h>
> +#include <linux/initrd.h>
> +#include <linux/mmzone.h>
> +
> +#include <asm/asm-offsets.h>
> +#include <asm/bootinfo.h>
> +#include <asm/cpu.h>
> +#include <asm/dma.h>
> +#include <asm/mmu_context.h>
> +#include <asm/sections.h>
> +#include <asm/pgtable.h>
> +#include <asm/pgalloc.h>
> +#include <asm/tlb.h>
> +
> +/*
> + * We have up to 8 empty zeroed pages so we can map one of the right colour
> + * when needed.         Since page is never written to after the initialization we
> + * don't have to care about aliases on other CPUs.
> + */
> +unsigned long empty_zero_page, zero_page_mask;
> +EXPORT_SYMBOL_GPL(empty_zero_page);
> +EXPORT_SYMBOL(zero_page_mask);
> +
> +void setup_zero_pages(void)
> +{
> +       unsigned int order, i;
> +       struct page *page;
> +
> +       order = 0;
> +
> +       empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +       if (!empty_zero_page)
> +               panic("Oh boy, that early out of memory?");
> +
> +       page = virt_to_page((void *)empty_zero_page);
> +       split_page(page, order);
> +       for (i = 0; i < (1 << order); i++, page++)
> +               mark_page_reserved(page);
> +
> +       zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
> +}
> +
> +void copy_user_highpage(struct page *to, struct page *from,
> +       unsigned long vaddr, struct vm_area_struct *vma)
> +{
> +       void *vfrom, *vto;
> +
> +       vto = kmap_atomic(to);
> +       vfrom = kmap_atomic(from);
> +       copy_page(vto, vfrom);
> +       kunmap_atomic(vfrom);
> +       kunmap_atomic(vto);
> +       /* Make sure this page is cleared on other CPU's too before using it */
> +       smp_wmb();
> +}
> +
> +void copy_to_user_page(struct vm_area_struct *vma,
> +       struct page *page, unsigned long vaddr, void *dst, const void *src,
> +       unsigned long len)
> +{
> +       memcpy(dst, src, len);
> +}
> +
> +void copy_from_user_page(struct vm_area_struct *vma,
> +       struct page *page, unsigned long vaddr, void *dst, const void *src,
> +       unsigned long len)
> +{
> +       memcpy(dst, src, len);
> +}
> +EXPORT_SYMBOL_GPL(copy_from_user_page);
> +
> +void __init paging_init(void)
> +{
> +       unsigned long max_zone_pfns[MAX_NR_ZONES];
> +
> +       pagetable_init();
> +
> +#ifdef CONFIG_ZONE_DMA
> +       max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
> +#endif
> +#ifdef CONFIG_ZONE_DMA32
> +       max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
> +#endif
> +       max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> +
> +       free_area_init(max_zone_pfns);
> +}
> +
> +void __init mem_init(void)
> +{
> +       max_mapnr = max_low_pfn;
> +       high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
> +
> +       memblock_free_all();
> +       setup_zero_pages();     /* Setup zeroed pages.  */
> +}
> +
> +void free_init_pages(const char *what, unsigned long begin, unsigned long end)
> +{
> +       unsigned long pfn;
> +
> +       for (pfn = PFN_UP(begin); pfn < PFN_DOWN(end); pfn++) {
> +               struct page *page = pfn_to_page(pfn);
> +               void *addr = phys_to_virt(PFN_PHYS(pfn));
> +
> +               memset(addr, POISON_FREE_INITMEM, PAGE_SIZE);
> +               free_reserved_page(page);
> +       }
> +       pr_info("Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
> +}
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +void free_initrd_mem(unsigned long start, unsigned long end)
> +{
> +       free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
> +                          "initrd");
> +}
> +#endif
> +
> +void __ref free_initmem(void)
> +{
> +       free_initmem_default(POISON_FREE_INITMEM);
> +}
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +int arch_add_memory(int nid, u64 start, u64 size, struct mhp_params *params)
> +{
> +       unsigned long start_pfn = start >> PAGE_SHIFT;
> +       unsigned long nr_pages = size >> PAGE_SHIFT;
> +       int ret;
> +
> +       ret = __add_pages(nid, start_pfn, nr_pages, params);
> +
> +       if (ret)
> +               pr_warn("%s: Problem encountered in __add_pages() as ret=%d\n",
> +                               __func__,  ret);
> +
> +       return ret;
> +}
> +
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +void arch_remove_memory(int nid, u64 start,
> +               u64 size, struct vmem_altmap *altmap)
> +{
> +       unsigned long start_pfn = start >> PAGE_SHIFT;
> +       unsigned long nr_pages = size >> PAGE_SHIFT;
> +       struct page *page = pfn_to_page(start_pfn);
> +
> +       /* With altmap the first mapped page is offset from @start */
> +       if (altmap)
> +               page += vmem_altmap_offset(altmap);
> +       __remove_pages(start_pfn, nr_pages, altmap);
> +}
> +#endif
> +#endif
> +
> +/*
> + * Align swapper_pg_dir in to 64K, allows its address to be loaded
> + * with a single LUI instruction in the TLB handlers.  If we used
> + * __aligned(64K), its size would get rounded up to the alignment
> + * size, and waste space.  So we place it in its own section and align
> + * it in the linker script.
> + */
> +pgd_t swapper_pg_dir[_PTRS_PER_PGD] __section(".bss..swapper_pg_dir");
> +
> +pgd_t invalid_pg_dir[_PTRS_PER_PGD] __page_aligned_bss;
> +#ifndef __PAGETABLE_PUD_FOLDED
> +pud_t invalid_pud_table[PTRS_PER_PUD] __page_aligned_bss;
> +#endif
> +#ifndef __PAGETABLE_PMD_FOLDED
> +pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
> +EXPORT_SYMBOL_GPL(invalid_pmd_table);
> +#endif
> +pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
> +EXPORT_SYMBOL(invalid_pte_table);
> diff --git a/arch/loongarch/mm/ioremap.c b/arch/loongarch/mm/ioremap.c
> new file mode 100644
> index 000000000000..515462cbbd8c
> --- /dev/null
> +++ b/arch/loongarch/mm/ioremap.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +
> +#include <asm/io.h>
> +
> +void __init __iomem *early_ioremap(u64 phys_addr, unsigned long size)
> +{
> +       return ((void *)TO_CAC(phys_addr));
> +}
> +
> +void __init early_iounmap(void __iomem *addr, unsigned long size)
> +{
> +
> +}
> +
> +void *early_memremap_ro(resource_size_t phys_addr, unsigned long size)
> +{
> +       return early_memremap(phys_addr, size);
> +}
> +
> +void *early_memremap_prot(resource_size_t phys_addr, unsigned long size,
> +                   unsigned long prot_val)
> +{
> +       return early_memremap(phys_addr, size);
> +}
> diff --git a/arch/loongarch/mm/maccess.c b/arch/loongarch/mm/maccess.c
> new file mode 100644
> index 000000000000..58173842c6be
> --- /dev/null
> +++ b/arch/loongarch/mm/maccess.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/uaccess.h>
> +#include <linux/kernel.h>
> +
> +bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
> +{
> +       /* highest bit set means kernel space */
> +       return (unsigned long)unsafe_src >> (BITS_PER_LONG - 1);
> +}
> diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
> new file mode 100644
> index 000000000000..4c05e0dba649
> --- /dev/null
> +++ b/arch/loongarch/mm/mmap.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#include <linux/compiler.h>
> +#include <linux/elf-randomize.h>
> +#include <linux/errno.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/export.h>
> +#include <linux/personality.h>
> +#include <linux/random.h>
> +#include <linux/sched/signal.h>
> +#include <linux/sched/mm.h>
> +
> +unsigned long shm_align_mask = PAGE_SIZE - 1;  /* Sane caches */
> +EXPORT_SYMBOL(shm_align_mask);
> +
> +/* gap between mmap and stack */
> +#define MIN_GAP (128*1024*1024UL)
> +#define MAX_GAP ((TASK_SIZE)/6*5)
> +
> +static int mmap_is_legacy(struct rlimit *rlim_stack)
> +{
> +       if (current->personality & ADDR_COMPAT_LAYOUT)
> +               return 1;
> +
> +       if (rlim_stack->rlim_cur == RLIM_INFINITY)
> +               return 1;
> +
> +       return sysctl_legacy_va_layout;
> +}
> +
> +static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
> +{
> +       unsigned long gap = rlim_stack->rlim_cur;
> +
> +       if (gap < MIN_GAP)
> +               gap = MIN_GAP;
> +       else if (gap > MAX_GAP)
> +               gap = MAX_GAP;
> +
> +       return PAGE_ALIGN(TASK_SIZE - gap - rnd);
> +}
> +
> +#define COLOUR_ALIGN(addr, pgoff)                              \
> +       ((((addr) + shm_align_mask) & ~shm_align_mask) +        \
> +        (((pgoff) << PAGE_SHIFT) & shm_align_mask))
> +
> +enum mmap_allocation_direction {UP, DOWN};
> +
> +static unsigned long arch_get_unmapped_area_common(struct file *filp,
> +       unsigned long addr0, unsigned long len, unsigned long pgoff,
> +       unsigned long flags, enum mmap_allocation_direction dir)
> +{
> +       struct mm_struct *mm = current->mm;
> +       struct vm_area_struct *vma;
> +       unsigned long addr = addr0;
> +       int do_color_align;
> +       struct vm_unmapped_area_info info;
> +
> +       if (unlikely(len > TASK_SIZE))
> +               return -ENOMEM;
> +
> +       if (flags & MAP_FIXED) {
> +               /* Even MAP_FIXED mappings must reside within TASK_SIZE */
> +               if (TASK_SIZE - len < addr)
> +                       return -EINVAL;
> +
> +               /*
> +                * We do not accept a shared mapping if it would violate
> +                * cache aliasing constraints.
> +                */
> +               if ((flags & MAP_SHARED) &&
> +                   ((addr - (pgoff << PAGE_SHIFT)) & shm_align_mask))
> +                       return -EINVAL;
> +               return addr;
> +       }
> +
> +       do_color_align = 0;
> +       if (filp || (flags & MAP_SHARED))
> +               do_color_align = 1;
> +
> +       /* requesting a specific address */
> +       if (addr) {
> +               if (do_color_align)
> +                       addr = COLOUR_ALIGN(addr, pgoff);
> +               else
> +                       addr = PAGE_ALIGN(addr);
> +
> +               vma = find_vma(mm, addr);
> +               if (TASK_SIZE - len >= addr &&
> +                   (!vma || addr + len <= vm_start_gap(vma)))
> +                       return addr;
> +       }
> +
> +       info.length = len;
> +       info.align_mask = do_color_align ? (PAGE_MASK & shm_align_mask) : 0;
> +       info.align_offset = pgoff << PAGE_SHIFT;
> +
> +       if (dir == DOWN) {
> +               info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> +               info.low_limit = PAGE_SIZE;
> +               info.high_limit = mm->mmap_base;
> +               addr = vm_unmapped_area(&info);
> +
> +               if (!(addr & ~PAGE_MASK))
> +                       return addr;
> +
> +               /*
> +                * A failed mmap() very likely causes application failure,
> +                * so fall back to the bottom-up function here. This scenario
> +                * can happen with large stack limits and large mmap()
> +                * allocations.
> +                */
> +       }
> +
> +       info.flags = 0;
> +       info.low_limit = mm->mmap_base;
> +       info.high_limit = TASK_SIZE;
> +       return vm_unmapped_area(&info);
> +}
> +
> +unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr0,
> +       unsigned long len, unsigned long pgoff, unsigned long flags)
> +{
> +       return arch_get_unmapped_area_common(filp,
> +                       addr0, len, pgoff, flags, UP);
> +}
> +
> +/*
> + * There is no need to export this but sched.h declares the function as
> + * extern so making it static here results in an error.
> + */
> +unsigned long arch_get_unmapped_area_topdown(struct file *filp,
> +       unsigned long addr0, unsigned long len, unsigned long pgoff,
> +       unsigned long flags)
> +{
> +       return arch_get_unmapped_area_common(filp,
> +                       addr0, len, pgoff, flags, DOWN);
> +}
> +
> +unsigned long arch_mmap_rnd(void)
> +{
> +       unsigned long rnd;
> +
> +       rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
> +
> +       return rnd << PAGE_SHIFT;
> +}
> +
> +void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> +{
> +       unsigned long random_factor = 0UL;
> +
> +       if (current->flags & PF_RANDOMIZE)
> +               random_factor = arch_mmap_rnd();
> +
> +       if (mmap_is_legacy(rlim_stack)) {
> +               mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> +               mm->get_unmapped_area = arch_get_unmapped_area;
> +       } else {
> +               mm->mmap_base = mmap_base(random_factor, rlim_stack);
> +               mm->get_unmapped_area = arch_get_unmapped_area_topdown;
> +       }
> +}
Duplicated codes, try to use arch_pick_mmap_layout in mm/utils.c.


> +
> +static inline unsigned long brk_rnd(void)
> +{
> +       unsigned long rnd = get_random_long();
> +
> +       rnd = rnd << PAGE_SHIFT;
> +       /* 8MB for 32bit, 256MB for 64bit */
> +       if (TASK_IS_32BIT_ADDR)
> +               rnd = rnd & 0x7ffffful;
> +       else
> +               rnd = rnd & 0xffffffful;
> +
> +       return rnd;
> +}
> +
> +unsigned long arch_randomize_brk(struct mm_struct *mm)
> +{
> +       unsigned long base = mm->brk;
> +       unsigned long ret;
> +
> +       ret = PAGE_ALIGN(base + brk_rnd());
> +
> +       if (ret < mm->brk)
> +               return mm->brk;
> +
> +       return ret;
> +}
Ditto, try CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT

> +
> +int __virt_addr_valid(const volatile void *kaddr)
> +{
> +       unsigned long vaddr = (unsigned long)kaddr;
> +
> +       if ((vaddr < PAGE_OFFSET) || (vaddr >= vm_map_base))
> +               return 0;
> +
> +       return pfn_valid(PFN_DOWN(virt_to_phys(kaddr)));
> +}
> +EXPORT_SYMBOL_GPL(__virt_addr_valid);
> diff --git a/arch/loongarch/mm/page.S b/arch/loongarch/mm/page.S
> new file mode 100644
> index 000000000000..548e3e325795
> --- /dev/null
> +++ b/arch/loongarch/mm/page.S
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +#include <asm/export.h>
> +#include <asm/regdef.h>
> +
> +#ifdef CONFIG_PAGE_SIZE_4KB
> +#define PAGE_SHIFT      12
> +#endif
> +#ifdef CONFIG_PAGE_SIZE_16KB
> +#define PAGE_SHIFT      14
> +#endif
> +#ifdef CONFIG_PAGE_SIZE_64KB
> +#define PAGE_SHIFT      16
> +#endif
> +
> +       .align 5
> +SYM_FUNC_START(clear_page)
> +       lu12i.w  t0, 1 << (PAGE_SHIFT - 12)
> +       add.d    t0, t0, a0
> +1:
> +       st.d     zero, a0, 0
> +       st.d     zero, a0, 8
> +       st.d     zero, a0, 16
> +       st.d     zero, a0, 24
> +       st.d     zero, a0, 32
> +       st.d     zero, a0, 40
> +       st.d     zero, a0, 48
> +       st.d     zero, a0, 56
> +       addi.d   a0,   a0, 128
> +       st.d     zero, a0, -64
> +       st.d     zero, a0, -56
> +       st.d     zero, a0, -48
> +       st.d     zero, a0, -40
> +       st.d     zero, a0, -32
> +       st.d     zero, a0, -24
> +       st.d     zero, a0, -16
> +       st.d     zero, a0, -8
> +       bne      t0,   a0, 1b
> +
> +       jirl     $r0, ra, 0
> +SYM_FUNC_END(clear_page)
> +EXPORT_SYMBOL(clear_page)
> +
> +.align 5
> +SYM_FUNC_START(copy_page)
> +       lu12i.w  t8, 1 << (PAGE_SHIFT - 12)
> +       add.d    t8, t8, a0
> +1:
> +       ld.d     t0, a1,  0
> +       ld.d     t1, a1,  8
> +       ld.d     t2, a1,  16
> +       ld.d     t3, a1,  24
> +       ld.d     t4, a1,  32
> +       ld.d     t5, a1,  40
> +       ld.d     t6, a1,  48
> +       ld.d     t7, a1,  56
> +
> +       st.d     t0, a0,  0
> +       st.d     t1, a0,  8
> +       ld.d     t0, a1,  64
> +       ld.d     t1, a1,  72
> +       st.d     t2, a0,  16
> +       st.d     t3, a0,  24
> +       ld.d     t2, a1,  80
> +       ld.d     t3, a1,  88
> +       st.d     t4, a0,  32
> +       st.d     t5, a0,  40
> +       ld.d     t4, a1,  96
> +       ld.d     t5, a1,  104
> +       st.d     t6, a0,  48
> +       st.d     t7, a0,  56
> +       ld.d     t6, a1,  112
> +       ld.d     t7, a1,  120
> +       addi.d   a0, a0,  128
> +       addi.d   a1, a1,  128
> +
> +       st.d     t0, a0,  -64
> +       st.d     t1, a0,  -56
> +       st.d     t2, a0,  -48
> +       st.d     t3, a0,  -40
> +       st.d     t4, a0,  -32
> +       st.d     t5, a0,  -24
> +       st.d     t6, a0,  -16
> +       st.d     t7, a0,  -8
> +
> +       bne      t8, a0, 1b
> +       jirl     $r0, ra, 0
> +SYM_FUNC_END(copy_page)
> +EXPORT_SYMBOL(copy_page)
> diff --git a/arch/loongarch/mm/pgtable-64.c b/arch/loongarch/mm/pgtable-64.c
> new file mode 100644
> index 000000000000..caa6792429b9
> --- /dev/null
> +++ b/arch/loongarch/mm/pgtable-64.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <asm/pgtable.h>
> +#include <asm/pgalloc.h>
> +#include <asm/tlbflush.h>
> +
> +void pgd_init(unsigned long page)
> +{
> +       unsigned long *p, *end;
> +       unsigned long entry;
> +
> +#if !defined(__PAGETABLE_PUD_FOLDED)
> +       entry = (unsigned long)invalid_pud_table;
> +#elif !defined(__PAGETABLE_PMD_FOLDED)
> +       entry = (unsigned long)invalid_pmd_table;
> +#else
> +       entry = (unsigned long)invalid_pte_table;
> +#endif
> +
> +       p = (unsigned long *) page;
> +       end = p + PTRS_PER_PGD;
> +
> +       do {
> +               p[0] = entry;
> +               p[1] = entry;
> +               p[2] = entry;
> +               p[3] = entry;
> +               p[4] = entry;
> +               p += 8;
> +               p[-3] = entry;
> +               p[-2] = entry;
> +               p[-1] = entry;
> +       } while (p != end);
> +}
> +
> +#ifndef __PAGETABLE_PMD_FOLDED
> +void pmd_init(unsigned long addr, unsigned long pagetable)
> +{
> +       unsigned long *p, *end;
> +
> +       p = (unsigned long *) addr;
> +       end = p + PTRS_PER_PMD;
> +
> +       do {
> +               p[0] = pagetable;
> +               p[1] = pagetable;
> +               p[2] = pagetable;
> +               p[3] = pagetable;
> +               p[4] = pagetable;
> +               p += 8;
> +               p[-3] = pagetable;
> +               p[-2] = pagetable;
> +               p[-1] = pagetable;
> +       } while (p != end);
> +}
> +EXPORT_SYMBOL_GPL(pmd_init);
> +#endif
> +
> +#ifndef __PAGETABLE_PUD_FOLDED
> +void pud_init(unsigned long addr, unsigned long pagetable)
> +{
> +       unsigned long *p, *end;
> +
> +       p = (unsigned long *)addr;
> +       end = p + PTRS_PER_PUD;
> +
> +       do {
> +               p[0] = pagetable;
> +               p[1] = pagetable;
> +               p[2] = pagetable;
> +               p[3] = pagetable;
> +               p[4] = pagetable;
> +               p += 8;
> +               p[-3] = pagetable;
> +               p[-2] = pagetable;
> +               p[-1] = pagetable;
> +       } while (p != end);
> +}
> +#endif
> +
> +pmd_t mk_pmd(struct page *page, pgprot_t prot)
> +{
> +       pmd_t pmd;
> +
> +       pmd_val(pmd) = (page_to_pfn(page) << _PFN_SHIFT) | pgprot_val(prot);
> +
> +       return pmd;
> +}
> +
> +void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +               pmd_t *pmdp, pmd_t pmd)
> +{
> +       *pmdp = pmd;
> +       flush_tlb_all();
> +}
> +
> +void __init pagetable_init(void)
> +{
> +       pgd_t *pgd_base;
> +
> +       /* Initialize the entire pgd.  */
> +       pgd_init((unsigned long)swapper_pg_dir);
> +       pgd_init((unsigned long)invalid_pg_dir);
> +#ifndef __PAGETABLE_PUD_FOLDED
> +       pud_init((unsigned long)invalid_pud_table, (unsigned long)invalid_pmd_table);
> +#endif
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       pmd_init((unsigned long)invalid_pmd_table, (unsigned long)invalid_pte_table);
> +#endif
> +       pgd_base = swapper_pg_dir;
> +}
> diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
> new file mode 100644
> index 000000000000..9f776f200f5c
> --- /dev/null
> +++ b/arch/loongarch/mm/pgtable.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#include <linux/export.h>
> +#include <linux/mm.h>
> +#include <linux/string.h>
> +#include <asm/pgalloc.h>
> +
> +pgd_t *pgd_alloc(struct mm_struct *mm)
> +{
> +       pgd_t *ret, *init;
> +
> +       ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
> +       if (ret) {
> +               init = pgd_offset(&init_mm, 0UL);
> +               pgd_init((unsigned long)ret);
> +               memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
> +                      (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(pgd_alloc);
> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> new file mode 100644
> index 000000000000..ec961f6a9688
> --- /dev/null
> +++ b/arch/loongarch/mm/tlb.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/smp.h>
> +#include <linux/mm.h>
> +#include <linux/hugetlb.h>
> +#include <linux/export.h>
> +
> +#include <asm/cpu.h>
> +#include <asm/bootinfo.h>
> +#include <asm/mmu_context.h>
> +#include <asm/pgtable.h>
> +#include <asm/tlb.h>
> +
> +void local_flush_tlb_all(void)
> +{
> +       invtlb_all(INVTLB_CURRENT_ALL, 0, 0);
> +}
> +EXPORT_SYMBOL(local_flush_tlb_all);
> +
> +/*
> + * All entries common to a mm share an asid. To effectively flush
> + * these entries, we just bump the asid.
> + */
> +void local_flush_tlb_mm(struct mm_struct *mm)
> +{
> +       int cpu;
> +
> +       preempt_disable();
> +
> +       cpu = smp_processor_id();
> +
> +       if (asid_valid(mm, cpu))
> +               drop_mmu_context(mm, cpu);
> +       else
> +               cpumask_clear_cpu(cpu, mm_cpumask(mm));
> +
> +       preempt_enable();
> +}
> +
> +void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> +       unsigned long end)
> +{
> +       struct mm_struct *mm = vma->vm_mm;
> +       int cpu = smp_processor_id();
> +
> +       if (asid_valid(mm, cpu)) {
> +               unsigned long size, flags;
> +
> +               local_irq_save(flags);
> +               start = round_down(start, PAGE_SIZE << 1);
> +               end = round_up(end, PAGE_SIZE << 1);
> +               size = (end - start) >> (PAGE_SHIFT + 1);
> +               if (size <= (current_cpu_data.tlbsizestlbsets ?
> +                            current_cpu_data.tlbsize / 8 :
> +                            current_cpu_data.tlbsize / 2)) {
> +                       int asid = cpu_asid(cpu, mm);
> +
> +                       while (start < end) {
> +                               invtlb(INVTLB_ADDR_GFALSE_AND_ASID, asid, start);
> +                               start += (PAGE_SIZE << 1);
> +                       }
> +               } else {
> +                       drop_mmu_context(mm, cpu);
> +               }
> +               local_irq_restore(flags);
> +       } else {
> +               cpumask_clear_cpu(cpu, mm_cpumask(mm));
> +       }
> +}
> +
> +void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
> +{
> +       unsigned long size, flags;
> +
> +       local_irq_save(flags);
> +       size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
> +       size = (size + 1) >> 1;
> +       if (size <= (current_cpu_data.tlbsizestlbsets ?
> +                    current_cpu_data.tlbsize / 8 :
> +                    current_cpu_data.tlbsize / 2)) {
> +
> +               start &= (PAGE_MASK << 1);
> +               end += ((PAGE_SIZE << 1) - 1);
> +               end &= (PAGE_MASK << 1);
> +
> +               while (start < end) {
> +                       invtlb_addr(INVTLB_ADDR_GTRUE_OR_ASID, 0, start);
> +                       start += (PAGE_SIZE << 1);
> +               }
> +       } else {
> +               local_flush_tlb_all();
> +       }
> +       local_irq_restore(flags);
> +}
> +
> +void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
> +{
> +       int cpu = smp_processor_id();
> +
> +       if (asid_valid(vma->vm_mm, cpu)) {
> +               int newpid;
> +
> +               newpid = cpu_asid(cpu, vma->vm_mm);
> +               page &= (PAGE_MASK << 1);
> +               invtlb(INVTLB_ADDR_GFALSE_AND_ASID, newpid, page);
> +       } else {
> +               cpumask_clear_cpu(cpu, mm_cpumask(vma->vm_mm));
> +       }
> +}
> +
> +/*
> + * This one is only used for pages with the global bit set so we don't care
> + * much about the ASID.
> + */
> +void local_flush_tlb_one(unsigned long page)
> +{
> +       page &= (PAGE_MASK << 1);
> +       invtlb_addr(INVTLB_ADDR_GTRUE_OR_ASID, 0, page);
> +}
> +
> +static void __update_hugetlb(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
> +{
> +       int idx;
> +       unsigned long lo;
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +
> +       address &= (PAGE_MASK << 1);
> +       write_csr_entryhi(address);
> +       tlb_probe();
> +       idx = read_csr_tlbidx();
> +       write_csr_pagesize(PS_HUGE_SIZE);
> +       lo = pmd_to_entrylo(pte_val(*ptep));
> +       write_csr_entrylo0(lo);
> +       write_csr_entrylo1(lo + (HPAGE_SIZE >> 1));
> +
> +       if (idx < 0)
> +               tlb_write_random();
> +       else
> +               tlb_write_indexed();
> +       write_csr_pagesize(PS_DEFAULT_SIZE);
> +
> +       local_irq_restore(flags);
> +}
> +
> +void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
> +{
> +       int idx;
> +       unsigned long flags;
> +
> +       /*
> +        * Handle debugger faulting in for debugee.
> +        */
> +       if (current->active_mm != vma->vm_mm)
> +               return;
> +
> +       if (pte_val(*ptep) & _PAGE_HUGE)
> +               return __update_hugetlb(vma, address, ptep);
> +
> +       local_irq_save(flags);
> +
> +       if ((unsigned long)ptep & sizeof(pte_t))
> +               ptep--;
> +
> +       address &= (PAGE_MASK << 1);
> +       write_csr_entryhi(address);
> +       tlb_probe();
> +       idx = read_csr_tlbidx();
> +       write_csr_pagesize(PS_DEFAULT_SIZE);
> +       write_csr_entrylo0(pte_val(*ptep++));
> +       write_csr_entrylo1(pte_val(*ptep));
> +       if (idx < 0)
> +               tlb_write_random();
> +       else
> +               tlb_write_indexed();
> +
> +       local_irq_restore(flags);
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +
> +int has_transparent_hugepage(void)
> +{
> +       static unsigned int size = -1;
> +
> +       if (size == -1) {       /* first call comes during __init */
> +               unsigned long flags;
> +
> +               local_irq_save(flags);
> +               write_csr_pagesize(PS_HUGE_SIZE);
> +               size = read_csr_pagesize();
> +               write_csr_pagesize(PS_DEFAULT_SIZE);
> +               local_irq_restore(flags);
> +       }
> +       return size == PS_HUGE_SIZE;
> +}
> +
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE  */
> +
> +static void setup_pw(void)
> +{
> +       unsigned long pgd_i, pgd_w;
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       unsigned long pmd_i, pmd_w;
> +#endif
> +       unsigned long pte_i, pte_w;
> +
> +       pgd_i = PGDIR_SHIFT;  /* 1st level PGD */
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       pgd_w = PGDIR_SHIFT - PMD_SHIFT + PGD_ORDER;
> +       pmd_i = PMD_SHIFT;    /* 2nd level PMD */
> +       pmd_w = PMD_SHIFT - PAGE_SHIFT;
> +#else
> +       pgd_w = PGDIR_SHIFT - PAGE_SHIFT + PGD_ORDER;
> +#endif
> +       pte_i  = PAGE_SHIFT;    /* 3rd level PTE */
> +       pte_w  = PAGE_SHIFT - 3;
> +
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       csr_writeq(pte_i | pte_w << 5 | pmd_i << 10 | pmd_w << 15, LOONGARCH_CSR_PWCTL0);
> +       csr_writeq(pgd_i | pgd_w << 6, LOONGARCH_CSR_PWCTL1);
> +#else
> +       csr_writeq(pte_i | pte_w << 5, LOONGARCH_CSR_PWCTL0);
> +       csr_writeq(pgd_i | pgd_w << 6, LOONGARCH_CSR_PWCTL1);
> +#endif
> +       csr_writeq((long)swapper_pg_dir, LOONGARCH_CSR_PGDH);
> +}
> +
> +static void output_pgtable_bits_defines(void)
> +{
> +#define pr_define(fmt, ...)                                    \
> +       pr_debug("#define " fmt, ##__VA_ARGS__)
> +
> +       pr_debug("#include <asm/asm.h>\n");
> +       pr_debug("#include <asm/regdef.h>\n");
> +       pr_debug("\n");
> +
> +       pr_define("_PAGE_VALID_SHIFT %d\n", _PAGE_VALID_SHIFT);
> +       pr_define("_PAGE_DIRTY_SHIFT %d\n", _PAGE_DIRTY_SHIFT);
> +       pr_define("_PAGE_HUGE_SHIFT %d\n", _PAGE_HUGE_SHIFT);
> +       pr_define("_PAGE_GLOBAL_SHIFT %d\n", _PAGE_GLOBAL_SHIFT);
> +       pr_define("_PAGE_PRESENT_SHIFT %d\n", _PAGE_PRESENT_SHIFT);
> +       pr_define("_PAGE_WRITE_SHIFT %d\n", _PAGE_WRITE_SHIFT);
> +       pr_define("_PAGE_NO_READ_SHIFT %d\n", _PAGE_NO_READ_SHIFT);
> +       pr_define("_PAGE_NO_EXEC_SHIFT %d\n", _PAGE_NO_EXEC_SHIFT);
> +       pr_define("_PFN_SHIFT %d\n", _PFN_SHIFT);
> +       pr_debug("\n");
> +}
> +
> +void setup_tlb_handler(void)
> +{
> +       static int run_once = 0;
> +
> +       setup_pw();
> +       output_pgtable_bits_defines();
> +
> +       /* The tlb handlers are generated only once */
> +       if (!run_once) {
> +               memcpy((void *)tlbrentry, handle_tlb_refill, 0x80);
> +               local_flush_icache_range(tlbrentry, tlbrentry + 0x80);
> +               run_once++;
> +       }
> +}
> +void tlb_init(void)
> +{
> +       write_csr_pagesize(PS_DEFAULT_SIZE);
> +
> +       if (read_csr_pagesize() != PS_DEFAULT_SIZE)
> +               panic("MMU doesn't support PAGE_SIZE=0x%lx", PAGE_SIZE);
> +
> +       setup_tlb_handler();
> +       local_flush_tlb_all();
> +}
> diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
> new file mode 100644
> index 000000000000..4ba35d6d7a49
> --- /dev/null
> +++ b/arch/loongarch/mm/tlbex.S
> @@ -0,0 +1,473 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#include <asm/asm.h>
> +#include <asm/export.h>
> +#include <asm/loongarchregs.h>
> +#include <asm/page.h>
> +#include <asm/pgtable-bits.h>
> +#include <asm/regdef.h>
> +#include <asm/stackframe.h>
> +
> +#ifdef CONFIG_64BIT
> +#include <asm/pgtable-64.h>
> +#endif
> +
> +       .macro tlb_do_page_fault, write
> +       SYM_FUNC_START(tlb_do_page_fault_\write)
> +       SAVE_ALL
> +       csrrd   a2, LOONGARCH_CSR_BADV
> +       KMODE
> +       move    a0, sp
> +       REG_S   a2, sp, PT_BVADDR
> +       li.w    a1, \write
> +       la.abs  t0, do_page_fault
> +       jirl    ra, t0, 0
> +       la.abs  t0, ret_from_exception
> +       jirl    zero, t0, 0
> +       SYM_FUNC_END(tlb_do_page_fault_\write)
> +       .endm
> +
> +SYM_FUNC_START(handle_tlb_rixi)
> +       csrwr   t0, EXCEPTION_KS0
> +       csrwr   t1, EXCEPTION_KS1
> +SYM_FUNC_END(handle_tlb_rixi)
> +       /* Go through */
> +       tlb_do_page_fault 0
> +       tlb_do_page_fault 1
> +
> +SYM_FUNC_START(handle_tlb_load)
> +       csrwr   t0, EXCEPTION_KS0
> +       csrwr   t1, EXCEPTION_KS1
> +       csrwr   ra, EXCEPTION_KS2
> +
> +       /*
> +        * The vmalloc handling is not in the hotpath.
> +        */
> +       csrrd   t0, LOONGARCH_CSR_BADV
> +       blt     t0, $r0, vmalloc_load
> +       csrrd   t1, LOONGARCH_CSR_PGDL
> +
> +vmalloc_done_load:
> +       /* Get PGD offset in bytes */
> +       srli.d  t0, t0, PGDIR_SHIFT
> +       andi    t0, t0, (PTRS_PER_PGD - 1)
> +       slli.d  t0, t0, 3
> +       add.d   t1, t1, t0
> +#if CONFIG_PGTABLE_LEVELS > 3
> +       csrrd   t0, LOONGARCH_CSR_BADV
> +       ld.d t1, t1, 0
> +       srli.d  t0, t0, PUD_SHIFT
> +       andi    t0, t0, (PTRS_PER_PUD - 1)
> +       slli.d  t0, t0, 3
> +       add.d   t1, t1, t0
> +#endif
> +#if CONFIG_PGTABLE_LEVELS > 2
> +       csrrd   t0, LOONGARCH_CSR_BADV
> +       ld.d    t1, t1, 0
> +       srli.d  t0, t0, PMD_SHIFT
> +       andi    t0, t0, (PTRS_PER_PMD - 1)
> +       slli.d  t0, t0, 3
> +       add.d   t1, t1, t0
> +#endif
> +       ld.d    ra, t1, 0
> +
> +       /*
> +        * For huge tlb entries, pmde doesn't contain an address but
> +        * instead contains the tlb pte. Check the PAGE_HUGE bit and
> +        * see if we need to jump to huge tlb processing.
> +        */
> +       andi    t0, ra, _PAGE_HUGE
> +       bne     t0, $r0, tlb_huge_update_load
> +
> +       csrrd   t0, LOONGARCH_CSR_BADV
> +       srli.d  t0, t0, (PAGE_SHIFT + PTE_ORDER)
> +       andi    t0, t0, (PTRS_PER_PTE - 1)
> +       slli.d  t0, t0, _PTE_T_LOG2
> +       add.d   t1, ra, t0
> +
> +       ld.d    t0, t1, 0
> +       tlbsrch
> +
> +       srli.d  ra, t0, _PAGE_PRESENT_SHIFT
> +       andi    ra, ra, 1
> +       beq     ra, $r0, nopage_tlb_load
> +
> +       ori     t0, t0, _PAGE_VALID
> +       st.d    t0, t1, 0
> +       ori     t1, t1, 8
> +       xori    t1, t1, 8
> +       ld.d    t0, t1, 0
> +       ld.d    t1, t1, 8
> +       csrwr   t0, LOONGARCH_CSR_TLBELO0
> +       csrwr   t1, LOONGARCH_CSR_TLBELO1
> +       tlbwr
> +leave_load:
> +       csrrd   t0, EXCEPTION_KS0
> +       csrrd   t1, EXCEPTION_KS1
> +       csrrd   ra, EXCEPTION_KS2
> +       ertn
> +#ifdef CONFIG_64BIT
> +vmalloc_load:
> +       la.abs  t1, swapper_pg_dir
> +       b       vmalloc_done_load
> +#endif
> +
> +       /*
> +        * This is the entry point when build_tlbchange_handler_head
> +        * spots a huge page.
> +        */
> +tlb_huge_update_load:
> +       ld.d    t0, t1, 0
> +       srli.d  ra, t0, _PAGE_PRESENT_SHIFT
> +       andi    ra, ra, 1
> +       beq     ra, $r0, nopage_tlb_load
> +       tlbsrch
> +
> +       ori     t0, t0, _PAGE_VALID
> +       st.d    t0, t1, 0
> +       addu16i.d       t1, $r0, -(CSR_TLBIDX_EHINV >> 16)
> +       addi.d  ra, t1, 0
> +       csrxchg ra, t1, LOONGARCH_CSR_TLBIDX
> +       tlbwr
> +
> +       csrxchg $r0, t1, LOONGARCH_CSR_TLBIDX
> +
> +       /*
> +        * A huge PTE describes an area the size of the
> +        * configured huge page size. This is twice the
> +        * of the large TLB entry size we intend to use.
> +        * A TLB entry half the size of the configured
> +        * huge page size is configured into entrylo0
> +        * and entrylo1 to cover the contiguous huge PTE
> +        * address space.
> +        */
> +       /* Huge page: Move Global bit */
> +       xori    t0, t0, _PAGE_HUGE
> +       lu12i.w t1, _PAGE_HGLOBAL >> 12
> +       and     t1, t0, t1
> +       srli.d  t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
> +       or      t0, t0, t1
> +
> +       addi.d  ra, t0, 0
> +       csrwr   t0, LOONGARCH_CSR_TLBELO0
> +       addi.d  t0, ra, 0
> +
> +       /* Convert to entrylo1 */
> +       addi.d  t1, $r0, 1
> +       slli.d  t1, t1, (HPAGE_SHIFT - 1)
> +       add.d   t0, t0, t1
> +       csrwr   t0, LOONGARCH_CSR_TLBELO1
> +
> +       /* Set huge page tlb entry size */
> +       addu16i.d       t0, $r0, (PS_MASK >> 16)
> +       addu16i.d       t1, $r0, (PS_HUGE_SIZE << (PS_SHIFT - 16))
> +       csrxchg         t1, t0, LOONGARCH_CSR_TLBIDX
> +
> +       tlbfill
> +
> +       addu16i.d       t0, $r0, (PS_MASK >> 16)
> +       addu16i.d       t1, $r0, (PS_DEFAULT_SIZE << (PS_SHIFT - 16))
> +       csrxchg         t1, t0, LOONGARCH_CSR_TLBIDX
> +
> +nopage_tlb_load:
> +       csrrd   ra, EXCEPTION_KS2
> +       la.abs  t0, tlb_do_page_fault_0
> +       jirl    $r0, t0, 0
> +SYM_FUNC_END(handle_tlb_load)
> +
> +SYM_FUNC_START(handle_tlb_store)
> +       csrwr   t0, EXCEPTION_KS0
> +       csrwr   t1, EXCEPTION_KS1
> +       csrwr   ra, EXCEPTION_KS2
> +
> +       /*
> +        * The vmalloc handling is not in the hotpath.
> +        */
> +       csrrd   t0, LOONGARCH_CSR_BADV
> +       blt     t0, $r0, vmalloc_store
> +       csrrd   t1, LOONGARCH_CSR_PGDL
> +
> +vmalloc_done_store:
> +       /* Get PGD offset in bytes */
> +       srli.d  t0, t0, PGDIR_SHIFT
> +       andi    t0, t0, (PTRS_PER_PGD - 1)
> +       slli.d  t0, t0, 3
> +       add.d   t1, t1, t0
> +
> +#if CONFIG_PGTABLE_LEVELS > 3
> +       csrrd   t0, LOONGARCH_CSR_BADV
> +       ld.d t1, t1, 0
> +       srli.d  t0, t0, PUD_SHIFT
> +       andi    t0, t0, (PTRS_PER_PUD - 1)
> +       slli.d  t0, t0, 3
> +       add.d   t1, t1, t0
> +#endif
> +#if CONFIG_PGTABLE_LEVELS > 2
> +       csrrd   t0, LOONGARCH_CSR_BADV
> +       ld.d    t1, t1, 0
> +       srli.d  t0, t0, PMD_SHIFT
> +       andi    t0, t0, (PTRS_PER_PMD - 1)
> +       slli.d  t0, t0, 3
> +       add.d   t1, t1, t0
> +#endif
> +       ld.d    ra, t1, 0
> +
> +       /*
> +        * For huge tlb entries, pmde doesn't contain an address but
> +        * instead contains the tlb pte. Check the PAGE_HUGE bit and
> +        * see if we need to jump to huge tlb processing.
> +        */
> +       andi    t0, ra, _PAGE_HUGE
> +       bne     t0, $r0, tlb_huge_update_store
> +
> +       csrrd   t0, LOONGARCH_CSR_BADV
> +       srli.d  t0, t0, (PAGE_SHIFT + PTE_ORDER)
> +       andi    t0, t0, (PTRS_PER_PTE - 1)
> +       slli.d  t0, t0, _PTE_T_LOG2
> +       add.d   t1, ra, t0
> +
> +       ld.d    t0, t1, 0
> +       tlbsrch
> +
> +       srli.d  ra, t0, _PAGE_PRESENT_SHIFT
> +       andi    ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
> +       xori    ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
> +       bne     ra, $r0, nopage_tlb_store
> +
> +       ori     t0, t0, (_PAGE_VALID | _PAGE_DIRTY)
> +       st.d    t0, t1, 0
> +
> +       ori     t1, t1, 8
> +       xori    t1, t1, 8
> +       ld.d    t0, t1, 0
> +       ld.d    t1, t1, 8
> +       csrwr   t0, LOONGARCH_CSR_TLBELO0
> +       csrwr   t1, LOONGARCH_CSR_TLBELO1
> +       tlbwr
> +leave_store:
> +       csrrd   t0, EXCEPTION_KS0
> +       csrrd   t1, EXCEPTION_KS1
> +       csrrd   ra, EXCEPTION_KS2
> +       ertn
> +#ifdef CONFIG_64BIT
> +vmalloc_store:
> +       la.abs  t1, swapper_pg_dir
> +       b       vmalloc_done_store
> +#endif
> +
> +       /*
> +        * This is the entry point when build_tlbchange_handler_head
> +        * spots a huge page.
> +        */
> +tlb_huge_update_store:
> +       ld.d    t0, t1, 0
> +       srli.d  ra, t0, _PAGE_PRESENT_SHIFT
> +       andi    ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
> +       xori    ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
> +       bne     ra, $r0, nopage_tlb_store
> +
> +       tlbsrch
> +       ori     t0, t0, (_PAGE_VALID | _PAGE_DIRTY)
> +
> +       st.d    t0, t1, 0
> +       addu16i.d       t1, $r0, -(CSR_TLBIDX_EHINV >> 16)
> +       addi.d  ra, t1, 0
> +       csrxchg ra, t1, LOONGARCH_CSR_TLBIDX
> +       tlbwr
> +
> +       csrxchg $r0, t1, LOONGARCH_CSR_TLBIDX
> +       /*
> +        * A huge PTE describes an area the size of the
> +        * configured huge page size. This is twice the
> +        * of the large TLB entry size we intend to use.
> +        * A TLB entry half the size of the configured
> +        * huge page size is configured into entrylo0
> +        * and entrylo1 to cover the contiguous huge PTE
> +        * address space.
> +        */
> +       /* Huge page: Move Global bit */
> +       xori    t0, t0, _PAGE_HUGE
> +       lu12i.w t1, _PAGE_HGLOBAL >> 12
> +       and     t1, t0, t1
> +       srli.d  t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
> +       or      t0, t0, t1
> +
> +       addi.d  ra, t0, 0
> +       csrwr   t0, LOONGARCH_CSR_TLBELO0
> +       addi.d  t0, ra, 0
> +
> +       /* Convert to entrylo1 */
> +       addi.d  t1, $r0, 1
> +       slli.d  t1, t1, (HPAGE_SHIFT - 1)
> +       add.d   t0, t0, t1
> +       csrwr   t0, LOONGARCH_CSR_TLBELO1
> +
> +       /* Set huge page tlb entry size */
> +       addu16i.d       t0, $r0, (PS_MASK >> 16)
> +       addu16i.d       t1, $r0, (PS_HUGE_SIZE << (PS_SHIFT - 16))
> +       csrxchg         t1, t0, LOONGARCH_CSR_TLBIDX
> +
> +       tlbfill
> +
> +       /* Reset default page size */
> +       addu16i.d       t0, $r0, (PS_MASK >> 16)
> +       addu16i.d       t1, $r0, (PS_DEFAULT_SIZE << (PS_SHIFT - 16))
> +       csrxchg         t1, t0, LOONGARCH_CSR_TLBIDX
> +
> +nopage_tlb_store:
> +       csrrd   ra, EXCEPTION_KS2
> +       la.abs  t0, tlb_do_page_fault_1
> +       jirl    $r0, t0, 0
> +SYM_FUNC_END(handle_tlb_store)
> +
> +SYM_FUNC_START(handle_tlb_modify)
> +       csrwr   t0, EXCEPTION_KS0
> +       csrwr   t1, EXCEPTION_KS1
> +       csrwr   ra, EXCEPTION_KS2
> +
> +       /*
> +        * The vmalloc handling is not in the hotpath.
> +        */
> +       csrrd   t0, LOONGARCH_CSR_BADV
> +       blt     t0, $r0, vmalloc_modify
> +       csrrd   t1, LOONGARCH_CSR_PGDL
> +
> +vmalloc_done_modify:
> +       /* Get PGD offset in bytes */
> +       srli.d  t0, t0, PGDIR_SHIFT
> +       andi    t0, t0, (PTRS_PER_PGD - 1)
> +       slli.d  t0, t0, 3
> +       add.d   t1, t1, t0
> +#if CONFIG_PGTABLE_LEVELS > 3
> +       csrrd   t0, LOONGARCH_CSR_BADV
> +       ld.d t1, t1, 0
> +       srli.d  t0, t0, PUD_SHIFT
> +       andi    t0, t0, (PTRS_PER_PUD - 1)
> +       slli.d  t0, t0, 3
> +       add.d   t1, t1, t0
> +#endif
> +#if CONFIG_PGTABLE_LEVELS > 2
> +       csrrd   t0, LOONGARCH_CSR_BADV
> +       ld.d    t1, t1, 0
> +       srli.d  t0, t0, PMD_SHIFT
> +       andi    t0, t0, (PTRS_PER_PMD - 1)
> +       slli.d  t0, t0, 3
> +       add.d   t1, t1, t0
> +#endif
> +       ld.d    ra, t1, 0
> +
> +       /*
> +        * For huge tlb entries, pmde doesn't contain an address but
> +        * instead contains the tlb pte. Check the PAGE_HUGE bit and
> +        * see if we need to jump to huge tlb processing.
> +        */
> +       andi    t0, ra, _PAGE_HUGE
> +       bne     t0, $r0, tlb_huge_update_modify
> +
> +       csrrd   t0, LOONGARCH_CSR_BADV
> +       srli.d  t0, t0, (PAGE_SHIFT + PTE_ORDER)
> +       andi    t0, t0, (PTRS_PER_PTE - 1)
> +       slli.d  t0, t0, _PTE_T_LOG2
> +       add.d   t1, ra, t0
> +
> +       ld.d    t0, t1, 0
> +       tlbsrch
> +
> +       srli.d  ra, t0, _PAGE_WRITE_SHIFT
> +       andi    ra, ra, 1
> +       beq     ra, $r0, nopage_tlb_modify
> +
> +       ori     t0, t0, (_PAGE_VALID | _PAGE_DIRTY)
> +       st.d    t0, t1, 0
> +       ori     t1, t1, 8
> +       xori    t1, t1, 8
> +       ld.d    t0, t1, 0
> +       ld.d    t1, t1, 8
> +       csrwr   t0, LOONGARCH_CSR_TLBELO0
> +       csrwr   t1, LOONGARCH_CSR_TLBELO1
> +       tlbwr
> +leave_modify:
> +       csrrd   t0, EXCEPTION_KS0
> +       csrrd   t1, EXCEPTION_KS1
> +       csrrd   ra, EXCEPTION_KS2
> +       ertn
> +#ifdef CONFIG_64BIT
> +vmalloc_modify:
> +       la.abs  t1, swapper_pg_dir
> +       b       vmalloc_done_modify
> +#endif
> +
> +       /*
> +        * This is the entry point when
> +        * build_tlbchange_handler_head spots a huge page.
> +        */
> +tlb_huge_update_modify:
> +       ld.d    t0, t1, 0
> +
> +       srli.d  ra, t0, _PAGE_WRITE_SHIFT
> +       andi    ra, ra, 1
> +       beq     ra, $r0, nopage_tlb_modify
> +
> +       tlbsrch
> +       ori     t0, t0, (_PAGE_VALID | _PAGE_DIRTY)
> +
> +       st.d    t0, t1, 0
> +       /*
> +        * A huge PTE describes an area the size of the
> +        * configured huge page size. This is twice the
> +        * of the large TLB entry size we intend to use.
> +        * A TLB entry half the size of the configured
> +        * huge page size is configured into entrylo0
> +        * and entrylo1 to cover the contiguous huge PTE
> +        * address space.
> +        */
> +       /* Huge page: Move Global bit */
> +       xori    t0, t0, _PAGE_HUGE
> +       lu12i.w t1, _PAGE_HGLOBAL >> 12
> +       and     t1, t0, t1
> +       srli.d  t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
> +       or      t0, t0, t1
> +
> +       addi.d  ra, t0, 0
> +       csrwr   t0, LOONGARCH_CSR_TLBELO0
> +       addi.d  t0, ra, 0
> +
> +       /* Convert to entrylo1 */
> +       addi.d  t1, $r0, 1
> +       slli.d  t1, t1, (HPAGE_SHIFT - 1)
> +       add.d   t0, t0, t1
> +       csrwr   t0, LOONGARCH_CSR_TLBELO1
> +
> +       /* Set huge page tlb entry size */
> +       addu16i.d       t0, $r0, (PS_MASK >> 16)
> +       addu16i.d       t1, $r0, (PS_HUGE_SIZE << (PS_SHIFT - 16))
> +       csrxchg t1, t0, LOONGARCH_CSR_TLBIDX
> +
> +       tlbwr
> +
> +       /* Reset default page size */
> +       addu16i.d       t0, $r0, (PS_MASK >> 16)
> +       addu16i.d       t1, $r0, (PS_DEFAULT_SIZE << (PS_SHIFT - 16))
> +       csrxchg t1, t0, LOONGARCH_CSR_TLBIDX
> +
> +nopage_tlb_modify:
> +       csrrd   ra, EXCEPTION_KS2
> +       la.abs  t0, tlb_do_page_fault_1
> +       jirl    $r0, t0, 0
> +SYM_FUNC_END(handle_tlb_modify)
> +
> +SYM_FUNC_START(handle_tlb_refill)
> +       csrwr   t0, LOONGARCH_CSR_TLBRSAVE
> +       csrrd   t0, LOONGARCH_CSR_PGD
> +       lddir   t0, t0, 3
> +#if CONFIG_PGTABLE_LEVELS > 2
> +       lddir   t0, t0, 1
> +#endif
> +       ldpte   t0, 0
> +       ldpte   t0, 1
> +       tlbfill
> +       csrrd   t0, LOONGARCH_CSR_TLBRSAVE
> +       ertn
> +SYM_FUNC_END(handle_tlb_refill)
The handle_tlb_refill is all loongarch PTW mechanism for all PAGE_SIZEs, right?

> --
> 2.27.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
