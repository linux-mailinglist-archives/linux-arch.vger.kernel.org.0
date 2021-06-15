Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2583A75A7
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 06:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhFOEN7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 00:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhFOEN7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 00:13:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2B4C061574
        for <linux-arch@vger.kernel.org>; Mon, 14 Jun 2021 21:11:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a20so16742118wrc.0
        for <linux-arch@vger.kernel.org>; Mon, 14 Jun 2021 21:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIthCyOADyGSTh5Byeq6cd/YHzqh+mHMo35OuYz80tE=;
        b=mFF0htP8ItyAGBQf3O2fDnk/JnGf5RYZUBF5XWJeUot5Q756UCB7+N14Cu2lSfKisp
         fEMMncUrvDKG2TqzBOOMew6VkB/4DPmzpOExdqbfz1nUjnvbc8b8+f0k5potFH6RhxHN
         AwSYo9Un/75a2UMZjxp6mqTWWt66B3aNTAST3Urvb4Xjw50jl/FufOpHDQkgctTWUB1p
         OY7Ii1aABHOURx6KJK1gZ/McHFgLwkbmSLP/kCUBTFiWFXIwOk1Ccn7ns9eD2/H7irOh
         FfxytNaNRUQpUqH0k90VOzplYY/n13tQWL28uZ0ZE7lIl7arBq8u/Pg57GiRX1T6XRet
         LfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIthCyOADyGSTh5Byeq6cd/YHzqh+mHMo35OuYz80tE=;
        b=Lf060RtfN2bAfQc9oRxT1B3qclGmHvdP862USYZavjqbNEaK9FWJ10YYNqVYP34/IM
         bKXMLd8qmhsUNryq0ACNcM2VfXlBTi+EhScbmdLQ9/WPveG0QlveJ2xZbSbozoheIgbS
         dCtWwexxWWVCazPSy1kVk8MqnbW6Mg+wpS1AIlpqJhCd2aipaUyF3PO3WqROGPk/VIoA
         Sv0pGPlXgHC9uOr04JpSEFJGVXGVuad1uIr+08s2s6XNcbLfCZBtv/IN0zyEf1K1c1l+
         SbzIBLFIN9PlOp7C+y9nrYVDT/3XLtlEzz8m4XshNQz/LwbATbRBKBJb+UP7P0gSkddJ
         N21w==
X-Gm-Message-State: AOAM532/hWaQ+TzbMx8tGTMlaqDUZ7VljxubgpxTY8iWsjI8KshootE/
        ZIxpGY0CQz05iM7mnWrcnA6lWrvvK6BYN3g1wK4OUw==
X-Google-Smtp-Source: ABdhPJwXY3kfHHlPahEc05tvQ2azEdbAIvgNY7DI+BxNSGIVimUaiQsgD/l9x0PIKetddon1oVv05ipCDcCyMa46pMI=
X-Received: by 2002:a5d:540b:: with SMTP id g11mr23239319wrv.390.1623730311278;
 Mon, 14 Jun 2021 21:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <1623693067-53886-1-git-send-email-guoren@kernel.org> <1623693067-53886-3-git-send-email-guoren@kernel.org>
In-Reply-To: <1623693067-53886-3-git-send-email-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 15 Jun 2021 09:41:39 +0530
Message-ID: <CAAhSdy2NTw2fHmCztXHXi+FExC12qHH0nziO7wuHOp+Ufk08KA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] riscv: pgtable: Add "PBMT" extension supported
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, wens@csie.org,
        maxime@cerno.tech, Drew Fustini <drew@beagleboard.org>,
        liush <liush@allwinnertech.com>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        wefu@redhat.com, linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 14, 2021 at 11:22 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> "PBMT" - Page-Based Memory Types (see Link for detail), current it
> has defined 3 memory types [62:61] in PTE:
>  - WB 00 "Cacheable 'main memory'"
>  - NC 01 "Noncacheable 'main memory'"
>  - IO 11 "Non-cacheable non-idempotent 'I/O'"
>
> The patch not only implements the current PBMT extension but also
> considers future scalability. It uses 3 words of image header to
> store 8 memory types' values plus a mask value. That means there
> are still 5 memory types reserved for future scalability.

This is the worst work-around to the Linux RISC-V patch acceptance
policy.

Passing PTE attributes in the Linux Image header means boot-loaders
will have to update the image header before jumping to Linux kernel.
Basically, this is changing the Linux boot-process by adding platform
specific image header updation step.

Further, this patch is doing too many things in one-go. I needs to be
broken down into smaller fine-grained patches.

I totally disapprove of this patch in it's current shape since the
Linux boot-protocol should not have any platform specific part.

Also, please don't CC RVI mailing list for Linux patches because
the people can post to RVI mailing list only by joining it.

Regards,
Anup

>
> This patch does not introduce any manufacturer-defined attribute
> codes, because RISC-V requires manufacturers to follow the PBMT
> extension specification. However, if the manufacturer implements
> a custom PBMT code, it can be compatible by modifying
> image_hdr.pbmt[3] during the startup phase.
>
> The patch is trying to keep both below works together:
>  - "Linux Keep real hardware work" (Allwinner D1 needs custom mt)
>  - "riscv spec acceptance policy" (Svpbmt extension)
>
> Link: https://lists.riscv.org/g/tech-virt-mem/topic/simplified_latest_pbmt/83389883?p=,,,20,0,0,0::recentpostdate%2Fsticky,,,20,2,0,83389883
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Drew Fustini <drew@beagleboard.org>
> Cc: Wei Fu <wefu@redhat.com>
> Cc: Wei Wu <lazyparser@gmail.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Maxime Ripard <maxime@cerno.tech>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Greg Favor <gfavor@ventanamicro.com>
> Cc: Andrea Mondelli <andrea.mondelli@huawei.com>
> Cc: Jonathan Behrens <behrensj@mit.edu>
> Cc: Xinhaoqu (Freddie) <xinhaoqu@huawei.com>
> Cc: Bill Huffman <huffman@cadence.com>
> Cc: Nick Kossifidis <mick@ics.forth.gr>
> Cc: Allen Baum <allen.baum@esperantotech.com>
> Cc: Josh Scheid <jscheid@ventanamicro.com>
> Cc: Richard Trauben <rtrauben@gmail.com>
> ---
>  arch/riscv/include/asm/image.h        |  6 ++--
>  arch/riscv/include/asm/pgtable-64.h   |  8 +++--
>  arch/riscv/include/asm/pgtable-bits.h | 55 +++++++++++++++++++++++++++++++++--
>  arch/riscv/include/asm/pgtable.h      | 17 +++++------
>  arch/riscv/kernel/head.S              |  6 ++++
>  arch/riscv/mm/init.c                  | 46 +++++++++++++++++++++++++++++
>  6 files changed, 119 insertions(+), 19 deletions(-)
>
> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> index e0b319a..15e13de 100644
> --- a/arch/riscv/include/asm/image.h
> +++ b/arch/riscv/include/asm/image.h
> @@ -38,8 +38,7 @@
>   * @image_size:                Effective Image size (little endian)
>   * @flags:             kernel flags (little endian)
>   * @version:           version
> - * @res1:              reserved
> - * @res2:              reserved
> + * @pbmt[3]:           Page-Based Memory Types (Encode within 3 words)
>   * @magic:             Magic number (RISC-V specific; deprecated)
>   * @magic2:            Magic number 2 (to match the ARM64 'magic' field pos)
>   * @res3:              reserved (will be used for PE COFF offset)
> @@ -55,8 +54,7 @@ struct riscv_image_header {
>         u64 image_size;
>         u64 flags;
>         u32 version;
> -       u32 res1;
> -       u64 res2;
> +       u32 pbmt[3];
>         u64 magic;
>         u32 magic2;
>         u32 res3;
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index e3b7c5d..ecf10bc 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -61,12 +61,14 @@ static inline void pud_clear(pud_t *pudp)
>
>  static inline unsigned long pud_page_vaddr(pud_t pud)
>  {
> -       return (unsigned long)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +       return (unsigned long)pfn_to_virt(
> +               (pud_val(pud) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
>  }
>
>  static inline struct page *pud_page(pud_t pud)
>  {
> -       return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +       return pfn_to_page(
> +               (pud_val(pud) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
>  }
>
>  static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
> @@ -76,7 +78,7 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
>
>  static inline unsigned long _pmd_pfn(pmd_t pmd)
>  {
> -       return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
> +       return (pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT;
>  }
>
>  #define pmd_ERROR(e) \
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index 2ee4139..1aadd00 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -7,7 +7,7 @@
>  #define _ASM_RISCV_PGTABLE_BITS_H
>
>  /*
> - * PTE format:
> + * rv32 PTE format:
>   * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
>   *       PFN      reserved for SW   D   A   G   U   X   W   R   V
>   */
> @@ -24,6 +24,49 @@
>  #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
>  #define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
>
> +#ifdef CONFIG_64BIT
> +/*
> + * rv64 PTE format:
> + * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> + *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
> + * [62:61] Memory Type definitions:
> + *  - WB: 00
> + *  - NC: 01
> + *  - IO: 11
> + */
> +#define _PAGE_MT_MASK          (0x3 << 61)
> +#define _PAGE_MT_WB            (0x0 << 61)
> +#define _PAGE_MT_NC            (0x1 << 61)
> +#define _PAGE_MT_IO            (0x2 << 61)
> +
> +/*
> + * Using 96 bits of image header to encode memory types. Every types occupy 10
> + * bits and every word contains 3 elements.
> + *  - word0: dma   + mt[0] + mt[1]
> + *  - word1: mt[2] + mt[3] + mt[4]
> + *  - word2: mt[5] + mt[6] + mt[7]
> + */
> +#define _IMG_HDR_MT_WORD0      (_PAGE_MT_MASK  >> 54) | \
> +                               (_PAGE_MT_WB    >> 44) | \
> +                               (_PAGE_MT_NC    >> 34)
> +#define _IMG_HDR_MT_WORD1      (_PAGE_MT_IO    >> 54) | \
> +                               (0              >> 44) | \
> +                               (0              >> 34)
> +#define _IMG_HDR_MT_WORD2      (0              >> 54) | \
> +                               (0              >> 44) | \
> +                               (0              >> 34)
> +
> +#define _PAGE_DMA_MASK         __riscv_pbmt.mask
> +#define _PAGE_DMA_WB           __riscv_pbmt.mt[0]
> +#define _PAGE_DMA_NC           __riscv_pbmt.mt[1]
> +#define _PAGE_DMA_IO           __riscv_pbmt.mt[2]
> +#else
> +#define _PAGE_DMA_MASK         0
> +#define _PAGE_DMA_WB           0
> +#define _PAGE_DMA_NC           0
> +#define _PAGE_DMA_IO           0
> +#endif
> +
>  #define _PAGE_SPECIAL   _PAGE_SOFT
>  #define _PAGE_TABLE     _PAGE_PRESENT
>
> @@ -35,10 +78,18 @@
>
>  #define _PAGE_PFN_SHIFT 10
>
> +#ifndef __ASSEMBLY__
> +extern struct __riscv_pbmt_struct {
> +       unsigned long mask;
> +       unsigned long mt[8];
> +} __riscv_pbmt;
> +#endif
> +
>  /* Set of bits to preserve across pte_modify() */
>  #define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ | \
>                                           _PAGE_WRITE | _PAGE_EXEC |    \
> -                                         _PAGE_USER | _PAGE_GLOBAL))
> +                                         _PAGE_USER | _PAGE_GLOBAL |   \
> +                                         _PAGE_DMA_MASK))
>  /*
>   * when all of R/W/X are zero, the PTE is a pointer to the next level
>   * of the page table; otherwise, it is a leaf PTE.
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 46a8aa6..d59c1d3 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -116,7 +116,7 @@
>  #define USER_PTRS_PER_PGD   (TASK_SIZE / PGDIR_SIZE)
>
>  /* Page protection bits */
> -#define _PAGE_BASE     (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_USER)
> +#define _PAGE_BASE     (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_USER | _PAGE_DMA_WB)
>
>  #define PAGE_NONE              __pgprot(_PAGE_PROT_NONE)
>  #define PAGE_READ              __pgprot(_PAGE_BASE | _PAGE_READ)
> @@ -137,7 +137,8 @@
>                                 | _PAGE_PRESENT \
>                                 | _PAGE_ACCESSED \
>                                 | _PAGE_DIRTY \
> -                               | _PAGE_GLOBAL)
> +                               | _PAGE_GLOBAL \
> +                               | _PAGE_DMA_WB)
>
>  #define PAGE_KERNEL            __pgprot(_PAGE_KERNEL)
>  #define PAGE_KERNEL_READ       __pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
> @@ -147,11 +148,7 @@
>
>  #define PAGE_TABLE             __pgprot(_PAGE_TABLE)
>
> -/*
> - * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so we can't
> - * change the properties of memory regions.
> - */
> -#define _PAGE_IOREMAP _PAGE_KERNEL
> +#define _PAGE_IOREMAP  ((_PAGE_KERNEL & ~_PAGE_DMA_MASK) | _PAGE_DMA_IO)
>
>  extern pgd_t swapper_pg_dir[];
>
> @@ -231,12 +228,12 @@ static inline unsigned long _pgd_pfn(pgd_t pgd)
>
>  static inline struct page *pmd_page(pmd_t pmd)
>  {
> -       return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> +       return pfn_to_page((pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
>  }
>
>  static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  {
> -       return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> +       return (unsigned long)pfn_to_virt((pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
>  }
>
>  static inline pte_t pmd_pte(pmd_t pmd)
> @@ -252,7 +249,7 @@ static inline pte_t pud_pte(pud_t pud)
>  /* Yields the page frame number (PFN) of a page table entry */
>  static inline unsigned long pte_pfn(pte_t pte)
>  {
> -       return (pte_val(pte) >> _PAGE_PFN_SHIFT);
> +       return ((pte_val(pte) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
>  }
>
>  #define pte_page(x)     pfn_to_page(pte_pfn(x))
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 89cc58a..6037df9 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -63,8 +63,14 @@ ENTRY(_start)
>         .dword _end - _start
>         .dword __HEAD_FLAGS
>         .word RISCV_HEADER_VERSION
> +#ifdef CONFIG_64BIT
> +       .word _IMG_HDR_MT_WORD0
> +       .word _IMG_HDR_MT_WORD1
> +       .word _IMG_HDR_MT_WORD2
> +#else
>         .word 0
>         .dword 0
> +#endif
>         .ascii RISCV_IMAGE_MAGIC
>         .balign 4
>         .ascii RISCV_IMAGE_MAGIC2
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 4b55046..8c1978a 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -21,6 +21,7 @@
>  #include <linux/crash_dump.h>
>
>  #include <asm/fixmap.h>
> +#include <asm/image.h>
>  #include <asm/tlbflush.h>
>  #include <asm/sections.h>
>  #include <asm/soc.h>
> @@ -554,6 +555,27 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size, bo
>  }
>  #endif
>
> +#ifdef CONFIG_64BIT
> +#define PBMT_HDR_TO_MT(val, off)       ((unsigned long)((val >> off) & 0x3ff) << 54)
> +
> +static void __init setup_pbmt(void)
> +{
> +       unsigned int *pbmt = ((struct riscv_image_header *)(&_start))->pbmt;
> +
> +       __riscv_pbmt.mask  = PBMT_HDR_TO_MT(pbmt[0], 0);
> +       __riscv_pbmt.mt[0] = PBMT_HDR_TO_MT(pbmt[0], 10);
> +       __riscv_pbmt.mt[1] = PBMT_HDR_TO_MT(pbmt[0], 20);
> +
> +       __riscv_pbmt.mt[2] = PBMT_HDR_TO_MT(pbmt[1], 0);
> +       __riscv_pbmt.mt[3] = PBMT_HDR_TO_MT(pbmt[1], 10);
> +       __riscv_pbmt.mt[4] = PBMT_HDR_TO_MT(pbmt[1], 20);
> +
> +       __riscv_pbmt.mt[5] = PBMT_HDR_TO_MT(pbmt[2], 0);
> +       __riscv_pbmt.mt[6] = PBMT_HDR_TO_MT(pbmt[2], 10);
> +       __riscv_pbmt.mt[7] = PBMT_HDR_TO_MT(pbmt[2], 20);
> +}
> +#endif
> +
>  static void __init setup_protection_map(void)
>  {
>         protection_map[0]  = __P000;
> @@ -582,6 +604,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         pmd_t fix_bmap_spmd, fix_bmap_epmd;
>  #endif
>
> +#ifdef CONFIG_64BIT
> +       setup_pbmt();
> +#endif
>         setup_protection_map();
>
>  #ifdef CONFIG_XIP_KERNEL
> @@ -915,6 +940,19 @@ void __init paging_init(void)
>         setup_vm_final();
>  }
>
> +#ifdef CONFIG_64BIT
> +void __init pbmt_init(void)
> +{
> +       struct device_node *cpu;
> +
> +       cpu = of_find_node_by_path("/cpus");
> +       if (!cpu || of_property_read_bool(cpu, "pbmt-extension"))
> +               return;
> +
> +       memset(&__riscv_pbmt, 0, sizeof(__riscv_pbmt));
> +}
> +#endif
> +
>  void __init misc_mem_init(void)
>  {
>         early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
> @@ -925,6 +963,9 @@ void __init misc_mem_init(void)
>         reserve_crashkernel();
>  #endif
>         memblock_dump_all();
> +#ifdef CONFIG_64BIT
> +       pbmt_init();
> +#endif
>  }
>
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> @@ -934,3 +975,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>         return vmemmap_populate_basepages(start, end, node, NULL);
>  }
>  #endif
> +
> +#ifdef CONFIG_64BIT
> +struct __riscv_pbmt_struct __riscv_pbmt __ro_after_init;
> +EXPORT_SYMBOL(__riscv_pbmt);
> +#endif
> --
> 2.7.4
>
