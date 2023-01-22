Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A91677063
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 17:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAVQJ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Jan 2023 11:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjAVQJ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2023 11:09:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DC221953;
        Sun, 22 Jan 2023 08:09:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3A8E60C5F;
        Sun, 22 Jan 2023 16:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378B5C433D2;
        Sun, 22 Jan 2023 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674403790;
        bh=ODzfQPyaT4cdyEV0nYuY5HUpq2D58BwT3hQJyL+ScWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AtTPeTbUL3cLoeaAgCFO1fMAmkRMjHW2bLJsN9b5uwSYzD/GUEPKbVVpH4gXRQbEc
         jN0aPXgrIYLqYaJ39OwvcmOMIlkiEzzO5fzfFb8Bmlu2easVK+Gzb/yXvsCldY33zf
         3vR4/zA2vFOLgKkfIXA97pqvKyo4MXUGUaJATr1ZX9wd+EYZXPH/82OvYAL8SQc3Uk
         Q39CWxdnYyGHSFiLQMugQQYcoPBtmqpmTjQzyw7x4dPH+IS8GCkhhtK5pTyDVIhQb4
         Ulrz7q0dGGX1DFgxTEPB2TcUME/1b/VyRG5GrVdWa7a81MTxCWZF2pqpdbbGsM9NIM
         QzPOZ0LkJeXcg==
Date:   Sun, 22 Jan 2023 18:09:19 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?iso-8859-1?Q?Poulhi=E8s?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v2 20/31] kvx: Add memory management
Message-ID: <Y81fr4qewOpj5lQl@kernel.org>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-21-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230120141002.2442-21-ysionneau@kalray.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 20, 2023 at 03:09:51PM +0100, Yann Sionneau wrote:
> Add memory management support for kvx, including: cache and tlb
> management, page fault handling, ioremap/mmap and streaming dma support.
> 
> Co-developed-by: Clement Leger <clement@clement-leger.fr>
> Signed-off-by: Clement Leger <clement@clement-leger.fr>
> Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
> Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
> Co-developed-by: Jean-Christophe Pince <jcpince@gmail.com>
> Signed-off-by: Jean-Christophe Pince <jcpince@gmail.com>
> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> Co-developed-by: Julian Vetter <jvetter@kalray.eu>
> Signed-off-by: Julian Vetter <jvetter@kalray.eu>
> Co-developed-by: Julien Hascoet <jhascoet@kalray.eu>
> Signed-off-by: Julien Hascoet <jhascoet@kalray.eu>
> Co-developed-by: Louis Morhet <lmorhet@kalray.eu>
> Signed-off-by: Louis Morhet <lmorhet@kalray.eu>
> Co-developed-by: Marc Poulhiès <dkm@kataplop.net>
> Signed-off-by: Marc Poulhiès <dkm@kataplop.net>
> Co-developed-by: Marius Gligor <mgligor@kalray.eu>
> Signed-off-by: Marius Gligor <mgligor@kalray.eu>
> Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
> Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
> Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
> 
> Notes:
>     V1 -> V2: removed L2 cache management
> 
>  arch/kvx/include/asm/cache.h        |  43 +++
>  arch/kvx/include/asm/cacheflush.h   | 158 ++++++++++
>  arch/kvx/include/asm/fixmap.h       |  47 +++
>  arch/kvx/include/asm/hugetlb.h      |  36 +++
>  arch/kvx/include/asm/mem_map.h      |  44 +++
>  arch/kvx/include/asm/mmu.h          | 289 ++++++++++++++++++
>  arch/kvx/include/asm/mmu_context.h  | 156 ++++++++++
>  arch/kvx/include/asm/mmu_stats.h    |  38 +++
>  arch/kvx/include/asm/page.h         | 187 ++++++++++++
>  arch/kvx/include/asm/page_size.h    |  29 ++
>  arch/kvx/include/asm/pgalloc.h      | 101 +++++++
>  arch/kvx/include/asm/pgtable-bits.h | 102 +++++++
>  arch/kvx/include/asm/pgtable.h      | 451 ++++++++++++++++++++++++++++
>  arch/kvx/include/asm/rm_fw.h        |  16 +
>  arch/kvx/include/asm/sparsemem.h    |  15 +
>  arch/kvx/include/asm/symbols.h      |  16 +
>  arch/kvx/include/asm/tlb.h          |  24 ++
>  arch/kvx/include/asm/tlb_defs.h     | 131 ++++++++
>  arch/kvx/include/asm/tlbflush.h     |  58 ++++
>  arch/kvx/include/asm/vmalloc.h      |  10 +
>  arch/kvx/mm/cacheflush.c            | 154 ++++++++++
>  arch/kvx/mm/dma-mapping.c           |  85 ++++++
>  arch/kvx/mm/extable.c               |  24 ++
>  arch/kvx/mm/fault.c                 | 264 ++++++++++++++++
>  arch/kvx/mm/init.c                  | 277 +++++++++++++++++
>  arch/kvx/mm/mmap.c                  |  31 ++
>  arch/kvx/mm/mmu.c                   | 202 +++++++++++++
>  arch/kvx/mm/mmu_stats.c             |  94 ++++++
>  arch/kvx/mm/tlb.c                   | 433 ++++++++++++++++++++++++++
>  29 files changed, 3515 insertions(+)
>  create mode 100644 arch/kvx/include/asm/cache.h
>  create mode 100644 arch/kvx/include/asm/cacheflush.h
>  create mode 100644 arch/kvx/include/asm/fixmap.h
>  create mode 100644 arch/kvx/include/asm/hugetlb.h
>  create mode 100644 arch/kvx/include/asm/mem_map.h
>  create mode 100644 arch/kvx/include/asm/mmu.h
>  create mode 100644 arch/kvx/include/asm/mmu_context.h
>  create mode 100644 arch/kvx/include/asm/mmu_stats.h
>  create mode 100644 arch/kvx/include/asm/page.h
>  create mode 100644 arch/kvx/include/asm/page_size.h
>  create mode 100644 arch/kvx/include/asm/pgalloc.h
>  create mode 100644 arch/kvx/include/asm/pgtable-bits.h
>  create mode 100644 arch/kvx/include/asm/pgtable.h
>  create mode 100644 arch/kvx/include/asm/rm_fw.h
>  create mode 100644 arch/kvx/include/asm/sparsemem.h
>  create mode 100644 arch/kvx/include/asm/symbols.h
>  create mode 100644 arch/kvx/include/asm/tlb.h
>  create mode 100644 arch/kvx/include/asm/tlb_defs.h
>  create mode 100644 arch/kvx/include/asm/tlbflush.h
>  create mode 100644 arch/kvx/include/asm/vmalloc.h
>  create mode 100644 arch/kvx/mm/cacheflush.c
>  create mode 100644 arch/kvx/mm/dma-mapping.c
>  create mode 100644 arch/kvx/mm/extable.c
>  create mode 100644 arch/kvx/mm/fault.c
>  create mode 100644 arch/kvx/mm/init.c
>  create mode 100644 arch/kvx/mm/mmap.c
>  create mode 100644 arch/kvx/mm/mmu.c
>  create mode 100644 arch/kvx/mm/mmu_stats.c
>  create mode 100644 arch/kvx/mm/tlb.c

... 

> diff --git a/arch/kvx/include/asm/mmu.h b/arch/kvx/include/asm/mmu.h
> new file mode 100644
> index 000000000000..09f3fdd66a34
> --- /dev/null
> +++ b/arch/kvx/include/asm/mmu.h
> @@ -0,0 +1,289 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Guillaume Thouvenin
> + *            Clement Leger
> + *            Marc Poulhiès
> + */
> +
> +#ifndef _ASM_KVX_MMU_H
> +#define _ASM_KVX_MMU_H
> +
> +#include <linux/bug.h>
> +#include <linux/types.h>
> +#include <linux/threads.h>
> +
> +#include <asm/page.h>
> +#include <asm/sfr.h>
> +#include <asm/page.h>
> +#include <asm/pgtable-bits.h>
> +#include <asm/tlb_defs.h>
> +
> +/* Virtual addresses can use at most 41 bits */
> +#define MMU_VIRT_BITS		41
> +
> +/*
> + * See Documentation/kvx/kvx-mmu.txt for details about the division of the
> + * virtual memory space.
> + */
> +#if defined(CONFIG_KVX_4K_PAGES)
> +#define MMU_USR_ADDR_BITS	39
> +#else
> +#error "Only 4Ko page size is supported at this time"
> +#endif
> +
> +typedef struct mm_context {
> +	unsigned long end_brk;
> +	unsigned long asn[NR_CPUS];
> +	unsigned long sigpage;
> +} mm_context_t;
> +
> +struct __packed tlb_entry_low {
> +	unsigned int es:2;       /* Entry Status */
> +	unsigned int cp:2;       /* Cache Policy */
> +	unsigned int pa:4;       /* Protection Attributes */
> +	unsigned int r:2;        /* Reserved */
> +	unsigned int ps:2;       /* Page Size */
> +	unsigned int fn:28;      /* Frame Number */
> +};
> +
> +struct __packed tlb_entry_high {
> +	unsigned int asn:9;  /* Address Space Number */
> +	unsigned int g:1;    /* Global Indicator */
> +	unsigned int vs:2;   /* Virtual Space */
> +	unsigned int pn:29;  /* Page Number */
> +};
> +
> +struct kvx_tlb_format {
> +	union {
> +		struct tlb_entry_low tel;
> +		uint64_t tel_val;
> +	};
> +	union {
> +		struct tlb_entry_high teh;
> +		uint64_t teh_val;
> +	};
> +};

I believe tlb_entry is a better name and unless I've missed something, this
struct is only used internally in arch/kvx/mm, so it'd be better to declare
it in a header at arch/kvx/mm.

Generally, it's better to move internal definitions out of include/asm and
have them near the .c files that use them. For instance, I randomly picked
several functions below, e.g. kvx_mmu_probetlb(), tlb_entry_overlaps(), and
it seems they are only used in arch/kvx/mm.

> +
> +#define KVX_EMPTY_TLB_ENTRY { .tel_val = 0x0, .teh_val = 0x0 }
> +
> +/* Bit [0:39] of the TLB format corresponds to TLB Entry low */
> +/* Bit [40:80] of the TLB format corresponds to the TLB Entry high */
> +#define kvx_mmu_set_tlb_entry(tlbf) do { \
> +	kvx_sfr_set(TEL, (uint64_t) tlbf.tel_val); \
> +	kvx_sfr_set(TEH, (uint64_t) tlbf.teh_val); \
> +} while (0)
> +
> +#define kvx_mmu_get_tlb_entry(tlbf) do { \
> +	tlbf.tel_val = kvx_sfr_get(TEL); \
> +	tlbf.teh_val = kvx_sfr_get(TEH); \
> +} while (0)
> +
> +/* Use kvx_mmc_ to read a field from MMC value passed as parameter */
> +#define __kvx_mmc(mmc_reg, field) \
> +	kvx_sfr_field_val(mmc_reg, MMC, field)
> +

...

> diff --git a/arch/kvx/include/asm/mmu_context.h b/arch/kvx/include/asm/mmu_context.h
> new file mode 100644
> index 000000000000..39fa92f1506b
> --- /dev/null
> +++ b/arch/kvx/include/asm/mmu_context.h
> @@ -0,0 +1,156 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + *            Guillaume Thouvenin
> + */
> +
> +#ifndef __ASM_KVX_MMU_CONTEXT_H
> +#define __ASM_KVX_MMU_CONTEXT_H
> +
> +/*
> + * Management of the Address Space Number:
> + * Coolidge architecture provides a 9-bit ASN to tag TLB entries. This can be
> + * used to allow several entries with the same virtual address (so from
> + * different process) to be in the TLB at the same time. That means that won't
> + * necessarily flush the TLB when a context switch occurs and so it will
> + * improve performances.
> + */
> +#include <linux/smp.h>
> +
> +#include <asm/mmu.h>
> +#include <asm/sfr_defs.h>
> +#include <asm/tlbflush.h>
> +
> +#include <asm-generic/mm_hooks.h>

...

> +/**
> + * Redefining the generic hooks that are:
> + *   - activate_mm
> + *   - deactivate_mm
> + *   - enter_lazy_tlb
> + *   - init_new_context
> + *   - destroy_context
> + *   - switch_mm
> + */

Please drop this comment, it does not add any information
> +
> +#define activate_mm(prev, next) switch_mm((prev), (next), NULL)
> +#define deactivate_mm(tsk, mm) do { } while (0)
> +#define enter_lazy_tlb(mm, tsk) do { } while (0)
> +

...

> +#endif /* __ASM_KVX_MMU_CONTEXT_H */
> diff --git a/arch/kvx/include/asm/mmu_stats.h b/arch/kvx/include/asm/mmu_stats.h
> new file mode 100644
> index 000000000000..999352dbc1ce

Looks like this entire header can be moved to arch/kvx/mm

> --- /dev/null
> +++ b/arch/kvx/include/asm/mmu_stats.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + */
> +
> +#ifndef _ASM_KVX_MMU_STATS_H
> +#define _ASM_KVX_MMU_STATS_H
> +
> +#ifdef CONFIG_KVX_MMU_STATS
> +#include <linux/percpu.h>
> +
> +struct mmu_refill_stats {
> +	unsigned long count;
> +	unsigned long total;
> +	unsigned long min;
> +	unsigned long max;
> +};
> +
> +enum mmu_refill_type {
> +	MMU_REFILL_TYPE_USER,
> +	MMU_REFILL_TYPE_KERNEL,
> +	MMU_REFILL_TYPE_KERNEL_DIRECT,
> +	MMU_REFILL_TYPE_COUNT,
> +};
> +
> +struct mmu_stats {
> +	struct mmu_refill_stats refill[MMU_REFILL_TYPE_COUNT];
> +	/* keep these fields ordered this way for assembly */
> +	unsigned long cycles_between_refill;
> +	unsigned long last_refill;
> +	unsigned long tlb_flush_all;
> +};
> +
> +DECLARE_PER_CPU(struct mmu_stats, mmu_stats);
> +#endif
> +
> +#endif /* _ASM_KVX_MMU_STATS_H */

...

> diff --git a/arch/kvx/include/asm/pgalloc.h b/arch/kvx/include/asm/pgalloc.h
> new file mode 100644
> index 000000000000..0e654dd1a072
> --- /dev/null
> +++ b/arch/kvx/include/asm/pgalloc.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Guillaume Thouvenin
> + *            Clement Leger
> + */
> +
> +#ifndef _ASM_KVX_PGALLOC_H
> +#define _ASM_KVX_PGALLOC_H
> +
> +#include <linux/mm.h>
> +#include <asm/tlb.h>
> +
> +#define __HAVE_ARCH_PGD_FREE
> +#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
> +
> +static inline void check_pgt_cache(void)
> +{
> +	/*
> +	 * check_pgt_cache() is called to check watermarks from counters that
> +	 * computes the number of pages allocated by cached allocation functions
> +	 * pmd_alloc_one_fast() and pte_alloc_one_fast().
> +	 * Currently we just skip this test.
> +	 */

It seems this function is never called.

> +}
> +
> +/**
> + * PGD
> + */

Please drop these comments (here and for lower levels as well), they don't
add information but only take space.

> +
> +static inline void
> +pgd_free(struct mm_struct *mm, pgd_t *pgd)
> +{
> +	free_pages((unsigned long) pgd, PAGES_PER_PGD);
> +}
> +
> +static inline
> +pgd_t *pgd_alloc(struct mm_struct *mm)
> +{
> +	pgd_t *pgd;
> +
> +	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL, PAGES_PER_PGD);
> +	if (unlikely(pgd == NULL))
> +		return NULL;
> +
> +	memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
> +
> +	/* Copy kernel mappings */
> +	memcpy(pgd + USER_PTRS_PER_PGD,
> +	       init_mm.pgd + USER_PTRS_PER_PGD,
> +	       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> +
> +	return pgd;
> +}
> +
> +/**
> + * PUD
> + */
> +
> +static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
> +{
> +	unsigned long pfn = virt_to_pfn(pmd);
> +
> +	set_pud(pud, __pud((unsigned long)pfn << PAGE_SHIFT));
> +}
> +
> +/**
> + * PMD
> + */
> +
> +static inline void pmd_populate_kernel(struct mm_struct *mm,
> +	pmd_t *pmd, pte_t *pte)
> +{
> +	unsigned long pfn = virt_to_pfn(pte);
> +
> +	set_pmd(pmd, __pmd((unsigned long)pfn << PAGE_SHIFT));
> +}
> +
> +static inline void pmd_populate(struct mm_struct *mm,
> +	pmd_t *pmd, pgtable_t pte)
> +{
> +	unsigned long pfn = virt_to_pfn(page_address(pte));
> +
> +	set_pmd(pmd, __pmd((unsigned long)pfn << PAGE_SHIFT));
> +}
> +
> +#if CONFIG_PGTABLE_LEVELS > 2
> +#define __pmd_free_tlb(tlb, pmd, addr) pmd_free((tlb)->mm, pmd)
> +#endif /* CONFIG_PGTABLE_LEVELS > 2 */
> +
> +/**
> + * PTE
> + */
> +
> +#define __pte_free_tlb(tlb, pte, buf)   \
> +do {                                    \
> +	pgtable_pte_page_dtor(pte);         \
> +	tlb_remove_page((tlb), pte);    \
> +} while (0)
> +
> +#endif /* _ASM_KVX_PGALLOC_H */

...

> diff --git a/arch/kvx/include/asm/pgtable.h b/arch/kvx/include/asm/pgtable.h
> new file mode 100644
> index 000000000000..9e36db4d98a7
> --- /dev/null
> +++ b/arch/kvx/include/asm/pgtable.h
> @@ -0,0 +1,451 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Guillaume Thouvenin
> + *            Clement Leger
> + *            Marius Gligor
> + *            Yann Sionneau
> + */
> +
> +#ifndef _ASM_KVX_PGTABLE_H
> +#define _ASM_KVX_PGTABLE_H
> +

...

> +
> +/*
> + * PGD definitions:
> + *   - pgd_ERROR
> + */

With macro name pgd_ERROR, it's already clear that this is pgd_ERROR.
Please drop the comment.

> +#define pgd_ERROR(e) \
> +	pr_err("%s:%d: bad pgd %016lx.\n", __FILE__, __LINE__, pgd_val(e))
> +
> +/*
> + * PUD
> + *
> + * As we manage a three level page table the call to set_pud is used to fill
> + * PGD.
> + */
> +static inline void set_pud(pud_t *pudp, pud_t pmd)
> +{
> +	*pudp = pmd;
> +}
> +
> +static inline int pud_none(pud_t pud)
> +{
> +	return pud_val(pud) == 0;
> +}
> +
> +static inline int pud_bad(pud_t pud)
> +{
> +	return pud_none(pud);
> +}
> +static inline int pud_present(pud_t pud)
> +{
> +	return pud_val(pud) != 0;
> +}
> +
> +static inline void pud_clear(pud_t *pud)
> +{
> +	set_pud(pud, __pud(0));
> +}
> +
> +/*
> + * PMD definitions:
> + *   - set_pmd
> + *   - pmd_present
> + *   - pmd_none
> + *   - pmd_bad
> + *   - pmd_clear
> + *   - pmd_page
> + */

Ditto

> +
> +static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
> +{
> +	*pmdp = pmd;
> +}
> +
> +/* Returns 1 if entry is present */
> +static inline int pmd_present(pmd_t pmd)
> +{
> +	return pmd_val(pmd) != 0;
> +}
> +
> +/* Returns 1 if the corresponding entry has the value 0 */
> +static inline int pmd_none(pmd_t pmd)
> +{
> +	return pmd_val(pmd) == 0;
> +}
> +
> +/* Used to check that a page middle directory entry is valid */
> +static inline int pmd_bad(pmd_t pmd)
> +{
> +	return pmd_none(pmd);
> +}
> +
> +/* Clears the entry to prevent process to use the linear address that
> + * mapped it.
> + */
> +static inline void pmd_clear(pmd_t *pmdp)
> +{
> +	set_pmd(pmdp, __pmd(0));
> +}
> +
> +/*
> + * Returns the address of the descriptor of the page table referred by the
> + * PMD entry.
> + */
> +static inline struct page *pmd_page(pmd_t pmd)
> +{
> +	if (pmd_val(pmd) & _PAGE_HUGE)
> +		return pfn_to_page(
> +				(pmd_val(pmd) & KVX_PFN_MASK) >> KVX_PFN_SHIFT);
> +
> +	return pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT);
> +}
> +
> +#define pmd_ERROR(e) \
> +	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
> +
> +static inline pmd_t *pud_pgtable(pud_t pud)
> +{
> +	return (pmd_t *)pfn_to_virt(pud_val(pud) >> PAGE_SHIFT);
> +}
> +
> +static inline struct page *pud_page(pud_t pud)
> +{
> +	return pfn_to_page(pud_val(pud) >> PAGE_SHIFT);
> +}
> +
> +/*
> + * PTE definitions:
> + *   - set_pte
> + *   - set_pte_at
> + *   - pte_clear
> + *   - pte_page
> + *   - pte_pfn
> + *   - pte_present
> + *   - pte_none
> + *   - pte_write
> + *   - pte_dirty
> + *   - pte_young
> + *   - pte_special
> + *   - pte_mkdirty
> + *   - pte_mkwrite
> + *   - pte_mkclean
> + *   - pte_mkyoung
> + *   - pte_mkold
> + *   - pte_mkspecial
> + *   - pte_wrprotect
> + */

Ditto

> +
> +static inline void set_pte(pte_t *ptep, pte_t pteval)
> +{
> +	*ptep = pteval;
> +}
> +
> +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> +			      pte_t *ptep, pte_t pteval)
> +{
> +	set_pte(ptep, pteval);
> +}
> +
> +#define pte_clear(mm, addr, ptep) set_pte(ptep, __pte(0))
> +
> +/* Constructs a page table entry */
> +static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
> +{
> +	return __pte(((pfn << KVX_PFN_SHIFT) & KVX_PFN_MASK) |
> +		     pgprot_val(prot));
> +}
> +
> +/* Builds a page table entry by combining a page descriptor and a group of
> + * access rights.
> + */
> +#define mk_pte(page, prot)	(pfn_pte(page_to_pfn(page), prot))
> +
> +/* Modifies page access rights */
> +static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> +{
> +	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
> +}
> +
> +#define pte_page(x)     pfn_to_page(pte_pfn(x))
> +
> +static inline unsigned long pmd_page_vaddr(pmd_t pmd)
> +{
> +	return (unsigned long)pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT);
> +}
> +
> +/* Yields the page frame number (PFN) of a page table entry */
> +static inline unsigned long pte_pfn(pte_t pte)
> +{
> +	return ((pte_val(pte) & KVX_PFN_MASK) >> KVX_PFN_SHIFT);
> +}
> +
> +static inline int pte_present(pte_t pte)
> +{
> +	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_NONE));
> +}
> +
> +static inline int pte_none(pte_t pte)
> +{
> +	return (pte_val(pte) == 0);
> +}
> +
> +static inline int pte_write(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_WRITE;
> +}
> +
> +static inline int pte_dirty(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_DIRTY;
> +}
> +
> +static inline int pte_young(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_ACCESSED;
> +}
> +
> +static inline int pte_special(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_SPECIAL;
> +}
> +
> +static inline int pte_huge(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_HUGE;
> +}
> +
> +static inline pte_t pte_mkdirty(pte_t pte)
> +{
> +	return __pte(pte_val(pte) | _PAGE_DIRTY);
> +}
> +
> +static inline pte_t pte_mkwrite(pte_t pte)
> +{
> +	return __pte(pte_val(pte) | _PAGE_WRITE);
> +}
> +
> +static inline pte_t pte_mkclean(pte_t pte)
> +{
> +	return __pte(pte_val(pte) & ~(_PAGE_DIRTY));
> +}
> +
> +static inline pte_t pte_mkyoung(pte_t pte)
> +{
> +	return __pte(pte_val(pte) | _PAGE_ACCESSED);
> +}
> +
> +static inline pte_t pte_mkold(pte_t pte)
> +{
> +	return __pte(pte_val(pte) & ~(_PAGE_ACCESSED));
> +}
> +
> +static inline pte_t pte_mkspecial(pte_t pte)
> +{
> +	return __pte(pte_val(pte) | _PAGE_SPECIAL);
> +}
> +
> +static inline pte_t pte_wrprotect(pte_t pte)
> +{
> +	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
> +}
> +
> +static inline pte_t pte_mkhuge(pte_t pte)
> +{
> +	return __pte(pte_val(pte) | _PAGE_HUGE);
> +}
> +
> +static inline pte_t pte_of_pmd(pmd_t pmd)
> +{
> +	return __pte(pmd_val(pmd));
> +}
> +
> +#define pmd_pfn(pmd)       pte_pfn(pte_of_pmd(pmd))
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE

I don't see HAVE_ARCH_TRANSPARENT_HUGEPAGE in arch/kvx/Kconfig. Please
remove this part for now.

> +
> +#define pmdp_establish pmdp_establish
> +static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
> +		unsigned long address, pmd_t *pmdp, pmd_t pmd)
> +{
> +	return __pmd(xchg(&pmd_val(*pmdp), pmd_val(pmd)));
> +}
> +
> +static inline int pmd_trans_huge(pmd_t pmd)
> +{
> +	return !!(pmd_val(pmd) & _PAGE_HUGE);
> +}
> +
> +static inline pmd_t pmd_of_pte(pte_t pte)
> +{
> +	return __pmd(pte_val(pte));
> +}
> +
> +
> +#define pmd_mkclean(pmd)      pmd_of_pte(pte_mkclean(pte_of_pmd(pmd)))
> +#define pmd_mkdirty(pmd)      pmd_of_pte(pte_mkdirty(pte_of_pmd(pmd)))
> +#define pmd_mkold(pmd)	      pmd_of_pte(pte_mkold(pte_of_pmd(pmd)))
> +#define pmd_mkwrite(pmd)      pmd_of_pte(pte_mkwrite(pte_of_pmd(pmd)))
> +#define pmd_mkyoung(pmd)      pmd_of_pte(pte_mkyoung(pte_of_pmd(pmd)))
> +#define pmd_modify(pmd, prot) pmd_of_pte(pte_modify(pte_of_pmd(pmd), prot))
> +#define pmd_wrprotect(pmd)    pmd_of_pte(pte_wrprotect(pte_of_pmd(pmd)))
> +
> +static inline pmd_t pmd_mkhuge(pmd_t pmd)
> +{
> +	/* Create a huge page in PMD implies a size of 2 MB */
> +	return __pmd(pmd_val(pmd) |
> +			_PAGE_HUGE | (TLB_PS_2M << KVX_PAGE_SZ_SHIFT));
> +}
> +
> +static inline pmd_t pmd_mkinvalid(pmd_t pmd)
> +{
> +	pmd_val(pmd) &= ~(_PAGE_PRESENT);
> +
> +	return pmd;
> +}
> +
> +#define pmd_dirty(pmd)     pte_dirty(pte_of_pmd(pmd))
> +#define pmd_write(pmd)     pte_write(pte_of_pmd(pmd))
> +#define pmd_young(pmd)     pte_young(pte_of_pmd(pmd))
> +
> +#define mk_pmd(page, prot)  pmd_of_pte(mk_pte(page, prot))
> +
> +static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
> +{
> +	return __pmd(((pfn << KVX_PFN_SHIFT) & KVX_PFN_MASK) |
> +			pgprot_val(prot));
> +}
> +
> +static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +			      pmd_t *pmdp, pmd_t pmd)
> +{
> +	*pmdp = pmd;
> +}
> +
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +#endif	/* _ASM_KVX_PGTABLE_H */
> diff --git a/arch/kvx/include/asm/rm_fw.h b/arch/kvx/include/asm/rm_fw.h
> new file mode 100644
> index 000000000000..f89bdd5915ed
> --- /dev/null
> +++ b/arch/kvx/include/asm/rm_fw.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + */
> +
> +#ifndef _ASM_KVX_RM_FW_H
> +#define _ASM_KVX_RM_FW_H
> +
> +#include <linux/sizes.h>
> +
> +#define KVX_RM_ID	16
> +
> +#define RM_FIRMWARE_REGS_SIZE	(SZ_4K)
> +
> +#endif /* _ASM_KVX_RM_FW_H */
> diff --git a/arch/kvx/include/asm/sparsemem.h b/arch/kvx/include/asm/sparsemem.h
> new file mode 100644
> index 000000000000..2f35743f20fb
> --- /dev/null
> +++ b/arch/kvx/include/asm/sparsemem.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + */
> +
> +#ifndef _ASM_KVX_SPARSEMEM_H
> +#define _ASM_KVX_SPARSEMEM_H

Does kvx support holes between memory banks? If no, FLATMEM should do.

> +
> +#ifdef CONFIG_SPARSEMEM
> +#define MAX_PHYSMEM_BITS	40
> +#define SECTION_SIZE_BITS	30
> +#endif /* CONFIG_SPARSEMEM */
> +
> +#endif /* _ASM_KVX_SPARSEMEM_H */
> diff --git a/arch/kvx/include/asm/symbols.h b/arch/kvx/include/asm/symbols.h
> new file mode 100644
> index 000000000000..a53c1607979f
> --- /dev/null
> +++ b/arch/kvx/include/asm/symbols.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + */
> +
> +#ifndef _ASM_KVX_SYMBOLS_H
> +#define _ASM_KVX_SYMBOLS_H
> +
> +/* Symbols to patch TLB refill handler */
> +extern char kvx_perf_tlb_refill[], kvx_std_tlb_refill[];
> +
> +/* Entry point of the ELF, used to start other PEs in SMP */
> +extern int kvx_start[];
> +
> +#endif
> diff --git a/arch/kvx/include/asm/tlb.h b/arch/kvx/include/asm/tlb.h
> new file mode 100644
> index 000000000000..190b682e1819
> --- /dev/null
> +++ b/arch/kvx/include/asm/tlb.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Guillaume Thouvenin
> + *            Clement Leger
> + */
> +
> +#ifndef _ASM_KVX_TLB_H
> +#define _ASM_KVX_TLB_H
> +
> +struct mmu_gather;
> +
> +static void tlb_flush(struct mmu_gather *tlb);
> +
> +int clear_ltlb_entry(unsigned long vaddr);
> +
> +#include <asm-generic/tlb.h>
> +
> +static inline unsigned int pgprot_cache_policy(unsigned long flags)
> +{
> +	return (flags & KVX_PAGE_CP_MASK) >> KVX_PAGE_CP_SHIFT;
> +}
> +
> +#endif /* _ASM_KVX_TLB_H */
> diff --git a/arch/kvx/include/asm/tlb_defs.h b/arch/kvx/include/asm/tlb_defs.h
> new file mode 100644
> index 000000000000..3f5b29cd529e
> --- /dev/null
> +++ b/arch/kvx/include/asm/tlb_defs.h

It looks like this header can be moved to arch/kvx/mm

> @@ -0,0 +1,131 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + *            Julian Vetter
> + *            Guillaume Thouvenin
> + *            Marius Gligor
> + */
> +
> +#ifndef _ASM_KVX_TLB_DEFS_H
> +#define _ASM_KVX_TLB_DEFS_H
> +

...

> diff --git a/arch/kvx/mm/init.c b/arch/kvx/mm/init.c
> new file mode 100644
> index 000000000000..bac34bc09eb5
> --- /dev/null
> +++ b/arch/kvx/mm/init.c
> @@ -0,0 +1,277 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + *            Guillaume Thouvenin
> + */
> +
> +/* Memblock header depends on types.h but does not include it ! */
> +#include <linux/types.h>
> +#include <linux/memblock.h>
> +#include <linux/mmzone.h>
> +#include <linux/of_fdt.h>
> +#include <linux/sched.h>
> +#include <linux/sizes.h>
> +#include <linux/init.h>
> +#include <linux/initrd.h>
> +#include <linux/pfn.h>
> +#include <linux/mm.h>
> +
> +#include <asm/sections.h>
> +#include <asm/tlb_defs.h>
> +#include <asm/tlbflush.h>
> +#include <asm/fixmap.h>
> +#include <asm/page.h>
> +
> +/*
> + * On kvx, memory map contains the first 2G of DDR being aliased.
> + * Full contiguous DDR is located at @[4G - 68G].
> + * However, to access this DDR in 32bit mode, the first 2G of DDR are
> + * mirrored from 4G to 2G.
> + * These first 2G are accessible from all DMAs (included 32 bits one).
> + *
> + * Hence, the memory map is the following:
> + *
> + * (68G) 0x1100000000-> +-------------+
> + *                      |             |
> + *              66G     |(ZONE_NORMAL)|
> + *                      |             |
> + *   (6G) 0x180000000-> +-------------+
> + *                      |             |
> + *              2G      |(ZONE_DMA32) |
> + *                      |             |
> + *   (4G) 0x100000000-> +-------------+ +--+
> + *                      |             |    |
> + *              2G      |   (Alias)   |    | 2G Alias
> + *                      |             |    |
> + *    (2G) 0x80000000-> +-------------+ <--+
> + *
> + * The translation of 64 bits -> 32 bits can then be done using dma-ranges property
> + * in device-trees.
> + */
> +
> +#define DDR_64BIT_START		(4ULL * SZ_1G)
> +#define DDR_32BIT_ALIAS_SIZE	(2ULL * SZ_1G)
> +
> +#define MAX_DMA32_PFN	PHYS_PFN(DDR_64BIT_START + DDR_32BIT_ALIAS_SIZE)
> +
> +pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> +
> +/*
> + * empty_zero_page is a special page that is used for zero-initialized data and
> + * COW.
> + */
> +struct page *empty_zero_page;
> +EXPORT_SYMBOL(empty_zero_page);
> +
> +extern char _start[];
> +extern char __kernel_smem_code_start[];
> +extern char __kernel_smem_code_end[];
> +
> +struct kernel_section {
> +	phys_addr_t start;
> +	phys_addr_t end;
> +};
> +
> +struct kernel_section kernel_sections[] = {
> +	{
> +		.start = (phys_addr_t)__kernel_smem_code_start,
> +		.end = (phys_addr_t)__kernel_smem_code_end
> +	},
> +	{
> +		.start = __pa(_start),
> +		.end = __pa(_end)
> +	}
> +};
> +
> +static void __init zone_sizes_init(void)
> +{
> +	unsigned long zones_size[MAX_NR_ZONES];
> +
> +	memset(zones_size, 0, sizeof(zones_size));
> +
> +	zones_size[ZONE_DMA32] = min(MAX_DMA32_PFN, max_low_pfn);
> +	zones_size[ZONE_NORMAL] = max_low_pfn;
> +
> +	free_area_init(zones_size);
> +}
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +static void __init setup_initrd(void)
> +{
> +	u64 base = phys_initrd_start;
> +	u64 end = phys_initrd_start + phys_initrd_size;
> +
> +	if (phys_initrd_size == 0) {
> +		pr_info("initrd not found or empty");
> +		return;
> +	}
> +
> +	if (base < memblock_start_of_DRAM() || end > memblock_end_of_DRAM()) {
> +		pr_err("initrd not in accessible memory, disabling it");
> +		phys_initrd_size = 0;
> +		return;
> +	}
> +
> +	pr_info("initrd: 0x%llx - 0x%llx\n", base, end);
> +
> +	memblock_reserve(phys_initrd_start, phys_initrd_size);
> +
> +	/* the generic initrd code expects virtual addresses */
> +	initrd_start = (unsigned long) __va(base);
> +	initrd_end = initrd_start + phys_initrd_size;
> +}
> +#endif
> +
> +static phys_addr_t memory_limit = PHYS_ADDR_MAX;
> +
> +static int __init early_mem(char *p)
> +{
> +	if (!p)
> +		return 1;
> +
> +	memory_limit = memparse(p, &p) & PAGE_MASK;
> +	pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
> +
> +	return 0;
> +}
> +early_param("mem", early_mem);
> +
> +static void __init setup_bootmem(void)
> +{
> +	phys_addr_t kernel_start, kernel_end;
> +	phys_addr_t start, end = 0;
> +	u64 i;
> +
> +	init_mm.start_code = (unsigned long)_stext;
> +	init_mm.end_code = (unsigned long)_etext;
> +	init_mm.end_data = (unsigned long)_edata;
> +	init_mm.brk = (unsigned long)_end;
> +
> +	for (i = 0; i < ARRAY_SIZE(kernel_sections); i++) {
> +		kernel_start = kernel_sections[i].start;
> +		kernel_end = kernel_sections[i].end;
> +
> +		memblock_reserve(kernel_start, kernel_end - kernel_start);
> +	}
> +
> +	for_each_mem_range(i, &start, &end) {
> +		pr_info("%15s: memory  : 0x%lx - 0x%lx\n", __func__,
> +			(unsigned long)start,
> +			(unsigned long)end);
> +	}
> +
> +	/* min_low_pfn is the lowest PFN available in the system */
> +	min_low_pfn = PFN_UP(memblock_start_of_DRAM());
> +
> +	/* max_low_pfn indicates the end if NORMAL zone */
> +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());

There is also max_pfn that's used by various pfn walkers. In your case it
should be the same as max_low_pfn.

> +
> +	/* Set the maximum number of pages in the system */
> +	set_max_mapnr(max_low_pfn - min_low_pfn);
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	setup_initrd();
> +#endif
> +
> +	if (memory_limit != PHYS_ADDR_MAX)
> +		memblock_mem_limit_remove_map(memory_limit);

This may cut off the initrd memory. It's be better to cap the memory before
setting up the initrd.

> +
> +	/* Don't reserve the device tree if its builtin */
> +	if (!is_kernel_rodata((unsigned long) initial_boot_params))
> +		early_init_fdt_reserve_self();
> +	early_init_fdt_scan_reserved_mem();
> +
> +	memblock_allow_resize();
> +	memblock_dump_all();
> +}
> +
> +static pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
> +static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss __maybe_unused;
> +
> +void __init early_fixmap_init(void)
> +{
> +	unsigned long vaddr;
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	/*
> +	 * Fixed mappings:
> +	 */
> +	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1);
> +	pgd = pgd_offset_pgd(swapper_pg_dir, vaddr);
> +	set_pgd(pgd, __pgd(__pa_symbol(fixmap_pmd)));
> +
> +	p4d = p4d_offset(pgd, vaddr);
> +	pud = pud_offset(p4d, vaddr);
> +	pmd = pmd_offset(pud, vaddr);
> +	set_pmd(pmd, __pmd(__pa_symbol(fixmap_pte)));
> +}
> +
> +void __init setup_arch_memory(void)
> +{
> +	setup_bootmem();
> +	sparse_init();
> +	zone_sizes_init();
> +}
> +
> +void __init mem_init(void)
> +{
> +	memblock_free_all();
> +
> +	/* allocate the zero page */
> +	empty_zero_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!empty_zero_page)
> +		panic("Failed to allocate the empty_zero_page");
> +}
> +
> +void free_initmem(void)
> +{
> +#ifdef CONFIG_POISON_INITMEM
> +	free_initmem_default(0x0);
> +#else
> +	free_initmem_default(-1);
> +#endif

Any reason not to use default implementation in init/main.c?

> +}
> +
> +void __set_fixmap(enum fixed_addresses idx,
> +				phys_addr_t phys, pgprot_t flags)
> +{
> +	unsigned long addr = __fix_to_virt(idx);
> +	pte_t *pte;
> +
> +
> +	BUG_ON(idx >= __end_of_fixed_addresses);
> +
> +	pte = &fixmap_pte[pte_index(addr)];
> +
> +	if (pgprot_val(flags)) {
> +		set_pte(pte, pfn_pte(phys_to_pfn(phys), flags));
> +	} else {
> +		/* Remove the fixmap */
> +		pte_clear(&init_mm, addr, pte);
> +	}
> +	local_flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +}
> +
> +static const pgprot_t protection_map[16] = {
> +	[VM_NONE]					= PAGE_NONE,
> +	[VM_READ]					= PAGE_READ,
> +	[VM_WRITE]					= PAGE_READ,
> +	[VM_WRITE | VM_READ]				= PAGE_READ,
> +	[VM_EXEC]					= PAGE_READ_EXEC,
> +	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
> +	[VM_EXEC | VM_WRITE]				= PAGE_READ_EXEC,
> +	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_READ_EXEC,
> +	[VM_SHARED]					= PAGE_NONE,
> +	[VM_SHARED | VM_READ]				= PAGE_READ,
> +	[VM_SHARED | VM_WRITE]				= PAGE_READ_WRITE,
> +	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_READ_WRITE,
> +	[VM_SHARED | VM_EXEC]				= PAGE_READ_EXEC,
> +	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READ_EXEC,
> +	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_READ_WRITE_EXEC,
> +	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_READ_WRITE_EXEC
> +};
> +DECLARE_VM_GET_PAGE_PROT
> diff --git a/arch/kvx/mm/mmap.c b/arch/kvx/mm/mmap.c
> new file mode 100644
> index 000000000000..a2225db64438
> --- /dev/null
> +++ b/arch/kvx/mm/mmap.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * derived from arch/arm64/mm/mmap.c
> + *
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + */
> +
> +#ifdef CONFIG_STRICT_DEVMEM
> +
> +#include <linux/mm.h>
> +#include <linux/ioport.h>
> +
> +#include <asm/page.h>
> +
> +/*
> + * devmem_is_allowed() checks to see if /dev/mem access to a certain address
> + * is valid. The argument is a physical page number.  We mimic x86 here by
> + * disallowing access to system RAM as well as device-exclusive MMIO regions.
> + * This effectively disable read()/write() on /dev/mem.
> + */
> +int devmem_is_allowed(unsigned long pfn)
> +{
> +	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
> +		return 0;
> +	if (!page_is_ram(pfn))

This won't work because it relies on "System RAM" in the resource tree and
you don't setup this.

> +		return 1;
> +	return 0;
> +}
> +
> +#endif
> diff --git a/arch/kvx/mm/mmu.c b/arch/kvx/mm/mmu.c
> new file mode 100644
> index 000000000000..9cb11bd2dfdf
> --- /dev/null
> +++ b/arch/kvx/mm/mmu.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + *            Guillaume Thouvenin
> + *            Vincent Chardon
> + *            Jules Maselbas
> + */
> +
> +#include <linux/cache.h>
> +#include <linux/types.h>
> +#include <linux/irqflags.h>
> +#include <linux/printk.h>
> +#include <linux/percpu.h>
> +#include <linux/kernel.h>
> +#include <linux/spinlock.h>
> +#include <linux/spinlock_types.h>
> +
> +#include <asm/mmu.h>
> +#include <asm/tlb.h>
> +#include <asm/page_size.h>
> +#include <asm/mmu_context.h>
> +
> +#define DUMP_LTLB 0
> +#define DUMP_JTLB 1
> +
> +DEFINE_PER_CPU_ALIGNED(uint8_t[MMU_JTLB_SETS], jtlb_current_set_way);
> +static struct kvx_tlb_format ltlb_entries[MMU_LTLB_WAYS];
> +static unsigned long ltlb_entries_bmp;
> +
> +static int kvx_mmu_ltlb_overlaps(struct kvx_tlb_format tlbe)
> +{
> +	int bit = LTLB_ENTRY_FIXED_COUNT;
> +
> +	for_each_set_bit_from(bit, &ltlb_entries_bmp, MMU_LTLB_WAYS) {
> +		if (tlb_entry_overlaps(tlbe, ltlb_entries[bit]))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * kvx_mmu_ltlb_add_entry - Add a kernel entry in the LTLB
> + *
> + * In order to lock some entries in the LTLB and be always mapped, this
> + * function can be called with a physical address, a virtual address and
> + * protection attribute to add an entry into the LTLB. This is mainly for
> + * performances since there won't be any NOMAPPING traps for these pages.
> + *
> + * @vaddr: Virtual address for the entry (must be aligned according to tlb_ps)
> + * @paddr: Physical address for the entry (must be aligned according to tlb_ps)
> + * @flags: Protection attributes
> + * @tlb_ps: Page size attribute for TLB (TLB_PS_*)
> + */
> +void kvx_mmu_ltlb_add_entry(unsigned long vaddr, phys_addr_t paddr,
> +			    pgprot_t flags, unsigned long tlb_ps)
> +{
> +	unsigned int cp;
> +	unsigned int idx;
> +	unsigned long irqflags;
> +	struct kvx_tlb_format tlbe;
> +	u64 page_size = BIT(get_page_size_shift(tlb_ps));
> +
> +	BUG_ON(!IS_ALIGNED(vaddr, page_size) || !IS_ALIGNED(paddr, page_size));
> +
> +	cp = pgprot_cache_policy(pgprot_val(flags));
> +
> +	tlbe = tlb_mk_entry(
> +		(void *) paddr,
> +		(void *) vaddr,

All occurrences of tlb_mk_entry() case paddr and vaddr parameters and then
tlb_mk_entry() essentially treats them as unsigned longs. Isn't it 
better to pass declare tlb_mk_entry as 

	tlb_mk_entry(phys_addr_t paddr, unsigned long vaddr, ... 

> +		tlb_ps,
> +		TLB_G_GLOBAL,
> +		TLB_PA_NA_RW,
> +		cp,
> +		0,
> +		TLB_ES_A_MODIFIED);

Please avoid having a parameter per line.

> +
> +	local_irq_save(irqflags);
> +
> +	if (IS_ENABLED(CONFIG_KVX_DEBUG_TLB_WRITE) &&
> +	    kvx_mmu_ltlb_overlaps(tlbe))
> +		panic("VA %lx overlaps with an existing LTLB mapping", vaddr);
> +
> +	idx = find_next_zero_bit(&ltlb_entries_bmp, MMU_LTLB_WAYS,
> +				 LTLB_ENTRY_FIXED_COUNT);
> +	/* This should never happen */
> +	BUG_ON(idx >= MMU_LTLB_WAYS);
> +	__set_bit(idx, &ltlb_entries_bmp);
> +	ltlb_entries[idx] = tlbe;
> +	kvx_mmu_add_entry(MMC_SB_LTLB, idx, tlbe);
> +
> +	if (kvx_mmc_error(kvx_sfr_get(MMC)))
> +		panic("Failed to write entry to the LTLB");
> +
> +	local_irq_restore(irqflags);
> +}
> +
> +void kvx_mmu_ltlb_remove_entry(unsigned long vaddr)
> +{
> +	int ret, bit = LTLB_ENTRY_FIXED_COUNT;
> +	struct kvx_tlb_format tlbe;
> +
> +	for_each_set_bit_from(bit, &ltlb_entries_bmp, MMU_LTLB_WAYS) {
> +		tlbe = ltlb_entries[bit];
> +		if (tlb_entry_match_addr(tlbe, vaddr)) {
> +			__clear_bit(bit, &ltlb_entries_bmp);
> +			break;
> +		}
> +	}
> +
> +	if (bit == MMU_LTLB_WAYS)
> +		panic("Trying to remove non-existent LTLB entry for addr %lx\n",
> +		      vaddr);
> +
> +	ret = clear_ltlb_entry(vaddr);
> +	if (ret)
> +		panic("Failed to remove LTLB entry for addr %lx\n", vaddr);
> +}
> +
> +/**
> + * kvx_mmu_jtlb_add_entry - Add an entry into JTLB
> + *
> + * JTLB is used both for kernel and user entries.
> + *
> + * @address: Virtual address for the entry (must be aligned according to tlb_ps)
> + * @ptep: pte entry pointer
> + * @asn: ASN (if pte entry is not global)
> + */
> +void kvx_mmu_jtlb_add_entry(unsigned long address, pte_t *ptep,
> +			    unsigned int asn)
> +{
> +	unsigned int shifted_addr, set, way;
> +	unsigned long flags, pte_val;
> +	struct kvx_tlb_format tlbe;
> +	unsigned int pa, cp, ps;
> +	phys_addr_t pfn;
> +
> +	pte_val = pte_val(*ptep);
> +
> +	pfn = (phys_addr_t)pte_pfn(*ptep);
> +
> +	asn &= MM_CTXT_ASN_MASK;
> +
> +	/* Set page as accessed */
> +	pte_val(*ptep) |= _PAGE_ACCESSED;
> +
> +	BUILD_BUG_ON(KVX_PAGE_SZ_SHIFT != KVX_SFR_TEL_PS_SHIFT);
> +
> +	ps = (pte_val & KVX_PAGE_SZ_MASK) >> KVX_PAGE_SZ_SHIFT;
> +	pa = get_page_access_perms(KVX_ACCESS_PERMS_INDEX(pte_val));
> +	cp = pgprot_cache_policy(pte_val);
> +
> +	tlbe = tlb_mk_entry(
> +		(void *)pfn_to_phys(pfn),
> +		(void *)address,
> +		ps,
> +		(pte_val & _PAGE_GLOBAL) ? TLB_G_GLOBAL : TLB_G_USE_ASN,
> +		pa,
> +		cp,
> +		asn,
> +		TLB_ES_A_MODIFIED);

Ditto

> +
> +	shifted_addr = address >> get_page_size_shift(ps);
> +	set = shifted_addr & MMU_JTLB_SET_MASK;
> +
> +	local_irq_save(flags);
> +
> +	if (IS_ENABLED(CONFIG_KVX_DEBUG_TLB_WRITE) &&
> +	    kvx_mmu_ltlb_overlaps(tlbe))
> +		panic("VA %lx overlaps with an existing LTLB mapping", address);
> +
> +	way = get_cpu_var(jtlb_current_set_way)[set]++;
> +	put_cpu_var(jtlb_current_set_way);
> +
> +	way &= MMU_JTLB_WAY_MASK;
> +
> +	kvx_mmu_add_entry(MMC_SB_JTLB, way, tlbe);
> +
> +	if (IS_ENABLED(CONFIG_KVX_DEBUG_TLB_WRITE) &&
> +	    kvx_mmc_error(kvx_sfr_get(MMC)))
> +		panic("Failed to write entry to the JTLB (in update_mmu_cache)");
> +
> +	local_irq_restore(flags);
> +}
> +
> +void __init kvx_mmu_early_setup(void)
> +{
> +	int bit;
> +	struct kvx_tlb_format tlbe;
> +
> +	kvx_mmu_remove_ltlb_entry(LTLB_ENTRY_EARLY_SMEM);
> +
> +	if (raw_smp_processor_id() != 0) {
> +		/* Apply existing ltlb entries starting from first one free */
> +		bit = LTLB_ENTRY_FIXED_COUNT;
> +		for_each_set_bit_from(bit, &ltlb_entries_bmp, MMU_LTLB_WAYS) {
> +			tlbe = ltlb_entries[bit];
> +			kvx_mmu_add_entry(MMC_SB_LTLB, bit, tlbe);
> +		}
> +	}
> +}

--
Sincerely yours,
Mike.

