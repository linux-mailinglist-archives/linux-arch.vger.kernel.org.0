Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73655C204
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiF1DWw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jun 2022 23:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiF1DWc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2022 23:22:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0BD2529E;
        Mon, 27 Jun 2022 20:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23DA1615BC;
        Tue, 28 Jun 2022 03:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C638C341CE;
        Tue, 28 Jun 2022 03:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656386546;
        bh=IX9GpJCf5zFk83qLHuc5OtFoLqfpiJ8Lh1FdnhW9AN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VQrIYAO6vwg+696izoP5SrdL119ptxuLxDTzlMy5952K7SVAji6NzqdfgeYKpO57Q
         Be2+pA3wgSkglkl1si+HjfhLb2sx8Z89pnuJsoe6YdX0xyqIoeIp4jZ8fXvLgoQ4rw
         PtBN3woDHU2blgSxAFrIjEjaL9+U9zHkmXqbxo1dul56S+5hzgZfuJ3m0y6BPcEk+p
         3mA5xVn4OYmK3xC92hv3mcftMjiqmsjALEGEwFGKs8XjGvstBkv/E9m/nkXNB7eOWJ
         NS169tFOgOZRQ5G+8UrwZIlb8LGuYbc3zFyEGH0VgCB44a5+7zKmopaKI/y2gStc0c
         ddrPGp7EbHZPw==
Received: by mail-ua1-f54.google.com with SMTP id x24so4110666uaf.11;
        Mon, 27 Jun 2022 20:22:26 -0700 (PDT)
X-Gm-Message-State: AJIora8xyXajS3bt9y7Jeq0shDR5Dtzx4gI+Uu9CrzhLHb6w/xAOPPTR
        0vVdsFM6GjZv0aqbyglB8bqulzCz0AgQMubAw6A=
X-Google-Smtp-Source: AGRyM1sjidVZYwRvP3tNHlyivh9KqOslGHyvzIkw0RPJ6Lxv4Z7nL1Y3kfPSPQa8e7yoJah9FVuf86MK62jV+u504Gw=
X-Received: by 2002:a9f:2c9a:0:b0:381:c1c7:82a6 with SMTP id
 w26-20020a9f2c9a000000b00381c1c782a6mr4752539uaj.23.1656386545380; Mon, 27
 Jun 2022 20:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220625095459.3786827-1-chenhuacai@loongson.cn>
 <20220625095459.3786827-2-chenhuacai@loongson.cn> <CAMZfGtV+xJ_FLooUPhZDcBOae_VnRHwGZqc3Ae1a0oNoLKk=iA@mail.gmail.com>
In-Reply-To: <CAMZfGtV+xJ_FLooUPhZDcBOae_VnRHwGZqc3Ae1a0oNoLKk=iA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 28 Jun 2022 11:22:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7hY7BJVvfNNXWKvkM+CUjjP84cY=90VVuZP5=Y0r974g@mail.gmail.com>
Message-ID: <CAAhV-H7hY7BJVvfNNXWKvkM+CUjjP84cY=90VVuZP5=Y0r974g@mail.gmail.com>
Subject: Re: [PATCH 2/3] LoongArch: Add sparse memory vmemmap support
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Min Zhou <zhoumin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Muchun,

On Mon, Jun 27, 2022 at 6:33 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Sat, Jun 25, 2022 at 5:54 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > From: Feiyang Chen <chenfeiyang@loongson.cn>
> >
> > Add sparse memory vmemmap support for LoongArch. SPARSEMEM_VMEMMAP
> > uses a virtually mapped memmap to optimise pfn_to_page and page_to_pfn
> > operations. This is the most efficient option when sufficient kernel
> > resources are available.
> >
> > Signed-off-by: Min Zhou <zhoumin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > ---
> >  arch/loongarch/Kconfig                 |  2 +
> >  arch/loongarch/include/asm/pgtable.h   |  5 +-
> >  arch/loongarch/include/asm/sparsemem.h |  8 +++
> >  arch/loongarch/mm/init.c               | 71 +++++++++++++++++++++++++-
> >  include/linux/mm.h                     |  2 +
> >  mm/sparse-vmemmap.c                    | 10 ++++
> >  6 files changed, 96 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index dc19cf3071ea..8e56ca28165e 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -49,6 +49,7 @@ config LOONGARCH
> >         select ARCH_USE_QUEUED_RWLOCKS
> >         select ARCH_USE_QUEUED_SPINLOCKS
> >         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> > +       select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>
> I think this should be a separate patch to enable HVO (HugeTLB Vmemmap
> Optimization) since it is irrelevant to this patch.
It seems I have misunderstood HVO, then I will remove HVO parts from
this patch. Thank you.

Huacai
>
> Thanks.
>
> >         select ARCH_WANTS_NO_INSTR
> >         select BUILDTIME_TABLE_SORT
> >         select COMMON_CLK
> > @@ -422,6 +423,7 @@ config ARCH_FLATMEM_ENABLE
> >
> >  config ARCH_SPARSEMEM_ENABLE
> >         def_bool y
> > +       select SPARSEMEM_VMEMMAP_ENABLE
> >         help
> >           Say Y to support efficient handling of sparse physical memory,
> >           for architectures which are either NUMA (Non-Uniform Memory Access)
> > diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> > index 9c811c3f7572..b701ec7a0309 100644
> > --- a/arch/loongarch/include/asm/pgtable.h
> > +++ b/arch/loongarch/include/asm/pgtable.h
> > @@ -92,7 +92,10 @@ extern unsigned long zero_page_mask;
> >  #define VMALLOC_START  MODULES_END
> >  #define VMALLOC_END    \
> >         (vm_map_base +  \
> > -        min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE)
> > +        min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
> > +
> > +#define vmemmap                ((struct page *)((VMALLOC_END + PMD_SIZE) & PMD_MASK))
> > +#define VMEMMAP_END    ((unsigned long)vmemmap + VMEMMAP_SIZE - 1)
> >
> >  #define pte_ERROR(e) \
> >         pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
> > diff --git a/arch/loongarch/include/asm/sparsemem.h b/arch/loongarch/include/asm/sparsemem.h
> > index 3d18cdf1b069..a1e440f6bec7 100644
> > --- a/arch/loongarch/include/asm/sparsemem.h
> > +++ b/arch/loongarch/include/asm/sparsemem.h
> > @@ -11,6 +11,14 @@
> >  #define SECTION_SIZE_BITS      29 /* 2^29 = Largest Huge Page Size */
> >  #define MAX_PHYSMEM_BITS       48
> >
> > +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> > +#define VMEMMAP_SIZE   0
> > +#else
> > +#define VMEMMAP_SIZE   (sizeof(struct page) * (1UL << (cpu_pabits + 1 - PAGE_SHIFT)))
> > +#endif
> > +
> > +#include <linux/mm_types.h>
> > +
> >  #endif /* CONFIG_SPARSEMEM */
> >
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> > diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> > index 7094a68c9b83..35128229fe46 100644
> > --- a/arch/loongarch/mm/init.c
> > +++ b/arch/loongarch/mm/init.c
> > @@ -22,7 +22,7 @@
> >  #include <linux/pfn.h>
> >  #include <linux/hardirq.h>
> >  #include <linux/gfp.h>
> > -#include <linux/initrd.h>
> > +#include <linux/hugetlb.h>
> >  #include <linux/mmzone.h>
> >
> >  #include <asm/asm-offsets.h>
> > @@ -157,6 +157,75 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> >  #endif
> >  #endif
> >
> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> > +int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
> > +                                        int node, struct vmem_altmap *altmap)
> > +{
> > +       unsigned long addr = start;
> > +       unsigned long next;
> > +       pgd_t *pgd;
> > +       p4d_t *p4d;
> > +       pud_t *pud;
> > +       pmd_t *pmd;
> > +
> > +       for (addr = start; addr < end; addr = next) {
> > +               next = pmd_addr_end(addr, end);
> > +
> > +               pgd = vmemmap_pgd_populate(addr, node);
> > +               if (!pgd)
> > +                       return -ENOMEM;
> > +               p4d = vmemmap_p4d_populate(pgd, addr, node);
> > +               if (!p4d)
> > +                       return -ENOMEM;
> > +               pud = vmemmap_pud_populate(p4d, addr, node);
> > +               if (!pud)
> > +                       return -ENOMEM;
> > +
> > +               pmd = pmd_offset(pud, addr);
> > +               if (pmd_none(*pmd)) {
> > +                       void *p = NULL;
> > +
> > +                       p = vmemmap_alloc_block_buf(PMD_SIZE, node, NULL);
> > +                       if (p) {
> > +                               pmd_t entry;
> > +
> > +                               entry = pfn_pmd(virt_to_pfn(p), PAGE_KERNEL);
> > +                               pmd_val(entry) |= _PAGE_HUGE | _PAGE_HGLOBAL;
> > +                               set_pmd_at(&init_mm, addr, pmd, entry);
> > +
> > +                               continue;
> > +                       }
> > +               } else if (pmd_val(*pmd) & _PAGE_HUGE) {
> > +                       vmemmap_verify((pte_t *)pmd, node, addr, next);
> > +                       continue;
> > +               }
> > +               if (vmemmap_populate_basepages(addr, next, node, NULL))
> > +                       return -ENOMEM;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +#if CONFIG_PGTABLE_LEVELS == 2
> > +int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> > +               struct vmem_altmap *altmap)
> > +{
> > +       return vmemmap_populate_basepages(start, end, node, NULL);
> > +}
> > +#else
> > +int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> > +               struct vmem_altmap *altmap)
> > +{
> > +       return vmemmap_populate_hugepages(start, end, node, NULL);
> > +}
> > +#endif
> > +
> > +void vmemmap_free(unsigned long start, unsigned long end,
> > +               struct vmem_altmap *altmap)
> > +{
> > +}
> > +#endif
> > +
> >  /*
> >   * Align swapper_pg_dir in to 64K, allows its address to be loaded
> >   * with a single LUI instruction in the TLB handlers.  If we used
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index bc8f326be0ce..3472b924a1ea 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3203,6 +3203,8 @@ void *sparse_buffer_alloc(unsigned long size);
> >  struct page * __populate_section_memmap(unsigned long pfn,
> >                 unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
> >                 struct dev_pagemap *pgmap);
> > +void pmd_init(void *addr);
> > +void pud_init(void *addr);
> >  pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
> >  p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
> >  pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index f4fa61dbbee3..33e2a1ceee72 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -587,6 +587,10 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
> >         return pmd;
> >  }
> >
> > +void __weak __meminit pmd_init(void *addr)
> > +{
> > +}
> > +
> >  pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
> >  {
> >         pud_t *pud = pud_offset(p4d, addr);
> > @@ -594,11 +598,16 @@ pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
> >                 void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
> >                 if (!p)
> >                         return NULL;
> > +               pmd_init(p);
> >                 pud_populate(&init_mm, pud, p);
> >         }
> >         return pud;
> >  }
> >
> > +void __weak __meminit pud_init(void *addr)
> > +{
> > +}
> > +
> >  p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
> >  {
> >         p4d_t *p4d = p4d_offset(pgd, addr);
> > @@ -606,6 +615,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
> >                 void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
> >                 if (!p)
> >                         return NULL;
> > +               pud_init(p);
> >                 p4d_populate(&init_mm, p4d, p);
> >         }
> >         return p4d;
> > --
> > 2.27.0
> >
