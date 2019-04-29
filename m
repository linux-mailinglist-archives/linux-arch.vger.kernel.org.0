Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6CCEB63
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2019 22:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfD2ULq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Apr 2019 16:11:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34093 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbfD2ULq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Apr 2019 16:11:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck18so1306209plb.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Apr 2019 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6YszmraZk0PIvbH3wLg7kw3GDQli+Qt1spMZezEYAP8=;
        b=Hde1DtRPRuIT/8sX45rLjipJED224JpEvnG7gwmtp4z1uwo6Uxz1c+9B7f6HA7fe9o
         dvPnFlGJZn6EImJo/qWD2VrlKqagpRb5z7tvGlyR1n7EvsDc6TkjJKQUGCfedT+l956M
         er8fnJa6LVMNLsAv8ngG0D2ef1ejHPkdNc0sT07oqDg7KWmocGnlKShjxGfLJZ083k28
         bglx+IWvMwDWVvH8xhoZ7qfHzspVtZHOiT9daAFuc4lWLr5JzsRVFxM7xske1K0ma+N9
         Y+BptlBrzZkcAl5xcwFxoq1mtclQx/1wsCPdBkbcgI0l84lbDwrSNGW4DK5KnLTZ9qbu
         hKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6YszmraZk0PIvbH3wLg7kw3GDQli+Qt1spMZezEYAP8=;
        b=AVxJKKG+ScqfWzI4/IWAIscUA3O9o2uRbVbKQvkAXWyptrxBvsqnwIEGdhafjNA6PM
         EgbkgOFfKT4JqY88/7vxAJLjekAVriIssMJ0XZGh8TkwMYtHE1IIs8qPh8o3FJhPpUvx
         ZNgnENh7B37iRicKmsIR1zzhbrJAMguMyLNFREiR4HGnQkdu+LVL03w0FPFZ4sxzRk8d
         o7UZDKrxYB8PAgHjrnUyYMUEfHx07EL/sMp2xIPLA1Se0ljd8DHPiIpnu6SKrTTJhDbZ
         8nJJNzFIoe+PNIWqZhWaDatSpbuaOM5OSQ25o+hqImmaJs9pQanbIAXPodR6OKFugKQH
         JTRA==
X-Gm-Message-State: APjAAAUfGUnv1hd3oGd91xVHVNcUCEKaDVK5aOxfyeAwH4Rfz+oVWdXd
        nxU1AjwLAVsAk1U1RX6kSgjT1g==
X-Google-Smtp-Source: APXvYqzhfh0ZUl8cmoBYCxOLChPzLpo0MLmmlTQLlURkrDXuO7GpeA3XqI9PqSK+o5BXSaZBcKYCjA==
X-Received: by 2002:a17:902:b48a:: with SMTP id y10mr5371936plr.86.1556568704852;
        Mon, 29 Apr 2019 13:11:44 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h127sm49384318pgc.31.2019.04.29.13.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 13:11:43 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:11:43 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 11:37:51 PDT (-0700)
Subject:     Re: [PATCH] riscv: Support non-coherency memory model
In-Reply-To: <1555947870-23014-1-git-send-email-guoren@kernel.org>
CC:     ren_guo@c-sky.com, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, tech-privileged@lists.riscv.org,
        Andrew Waterman <andrew@sifive.com>, anup.patel@wdc.com,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        green.hu@gmail.com, m.szyprowski@samsung.com, rppt@linux.ibm.com,
        robin.murphy@arm.com, swood@redhat.com, vincentc@andestech.com,
        xiaoyan_xiang@c-sky.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     guoren@kernel.org
Message-ID: <mhng-4889b94b-2734-4657-83c2-654d3677733e@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 22 Apr 2019 08:44:30 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
>
> The current riscv linux implementation requires SOC system to support
> memory coherence between all I/O devices and CPUs. But some SOC systems
> cannot maintain the coherence and they need support cache clean/invalid
> operations to synchronize data.
>
> Current implementation is no problem with SiFive FU540, because FU540
> keeps all IO devices and DMA master devices coherence with CPU. But to a
> traditional SOC vendor, it may already have a stable non-coherency SOC
> system, the need is simply to replace the CPU with RV CPU and rebuild
> the whole system with IO-coherency is very expensive.
>
> So we should make riscv linux also support non-coherency memory model.
> Here are the two points that riscv linux needs to be modified:
>
>  - Add _PAGE_COHERENCY bit in current page table entry attributes. The bit
>    designates a coherence for this page mapping. Software set the bit to
>    tell the hardware that the region of the page's memory area must be
>    coherent with IOs devices in SOC system by PMA settings.
>    If IOs and CPU are already coherent in SOC system, CPU just ignore
>    this bit.
>
>    PTE format:
>    | XLEN-1  10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
>          PFN      C  RSW  D   A   G   U   X   W   R   V
>                   ^
>    BIT(9): Coherence attribute bit
>           0: hardware needn't keep the page coherenct and software will
>              maintain the coherence with cache clear/invalid operations.
>           1: hardware must keep the page coherenct and software needn't
>              maintain the coherence.
>    BIT(8): Reserved for software and now it's _PAGE_SPECIAL in linux
>
>    Add a new hardware bit in PTE also need to modify Privileged
>    Architecture Supervisor-Level ISA:
>    https://github.com/riscv/riscv-isa-manual/pull/374

This is a RISC-V ISA modification, which isn't really appropriate to suggest on
the kernel mailing lists.  The right place to talk about this is at the RISC-V
foundation, which owns the ISA -- we can't change the hardware with a patch to
Linux :).

>  - Add SBI_FENCE_DMA 9 in riscv-sbi.
>    sbi_fence_dma(start, size, dir) could synchronize CPU cache data with
>    DMA device in non-coherency memory model. The third param's definition
>    is the same with linux's in include/linux/dma-direction.h:
>
>    enum dma_data_direction {
> 	DMA_BIDIRECTIONAL = 0,
> 	DMA_TO_DEVICE = 1,
> 	DMA_FROM_DEVICE = 2,
> 	DMA_NONE = 3,
>    };
>
>    The first param:start must be physical address which could be handled
>    in M-state.
>
>    Here is a pull request to the riscv-sbi-doc:
>    https://github.com/riscv/riscv-sbi-doc/pull/15
>
> We have tested the patch on our fpga SOC system which network controller
> connected to a non-cache-coherency interconnect in and it couldn't work
> without the patch.
>
> There is no side effect for FU540 whose CPU don't care _PAGE_COHERENCY
> in PTE, but FU540's bbl also need to implement a simple sbi_fence_dma
> by directly return. In fact, if you give a correct configuration for
> dev_is_dma_conherent(), linux dma framework wouldn't call sbi_fence_dma
> any more.

Non-coherent fences also need to be discussed as part of a RISC-V ISA
extension.  I know people have expressed interest, but I don't know of a
working group that's already been set up.

>
> Changelog:
>  - Use coherency instead of consistency for all to maintain term
>    consistency. (Xiang Xiaoyan)
>  - Add riscv-isa-manual modification pull request link.
>  - Correct grammatical errors.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Andrew Waterman <andrew@sifive.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Scott Wood <swood@redhat.com>
> Cc: Vincent Chen <vincentc@andestech.com>
> Cc: Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>
> ---
>  arch/riscv/Kconfig                    |  4 ++++
>  arch/riscv/include/asm/pgtable-bits.h |  1 +
>  arch/riscv/include/asm/pgtable.h      | 11 +++++++++
>  arch/riscv/include/asm/sbi.h          | 10 ++++++++
>  arch/riscv/mm/Makefile                |  1 +
>  arch/riscv/mm/dma-mapping.c           | 44 +++++++++++++++++++++++++++++++++++
>  arch/riscv/mm/ioremap.c               |  2 +-
>  7 files changed, 72 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/mm/dma-mapping.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index eb56c82..f0fc503 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -16,9 +16,12 @@ config RISCV
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select OF_IRQ
> +	select ARCH_HAS_SYNC_DMA_FOR_CPU
> +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_WANT_FRAME_POINTERS
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
> +	select DMA_DIRECT_REMAP
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_CPU_DEVICES
>  	select GENERIC_IRQ_SHOW
> @@ -27,6 +30,7 @@ config RISCV
>  	select GENERIC_STRNCPY_FROM_USER
>  	select GENERIC_STRNLEN_USER
>  	select GENERIC_SMP_IDLE_THREAD
> +	select GENERIC_ALLOCATOR
>  	select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_MEMBLOCK_NODE_MAP
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index 470755c..104f8c0 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -31,6 +31,7 @@
>  #define _PAGE_ACCESSED  (1 << 6)    /* Set by hardware on any access */
>  #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
>  #define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
> +#define _PAGE_COHERENCY (1 << 9)    /* Coherency */
>
>  #define _PAGE_SPECIAL   _PAGE_SOFT
>  #define _PAGE_TABLE     _PAGE_PRESENT
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 1141364..26debb4 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -66,6 +66,7 @@
>
>  #define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
>  #define PAGE_KERNEL_EXEC	__pgprot(_PAGE_KERNEL | _PAGE_EXEC)
> +#define PAGE_KERNEL_COHERENCY	__pgprot(_PAGE_KERNEL | _PAGE_COHERENCY)
>
>  extern pgd_t swapper_pg_dir[];
>
> @@ -375,6 +376,16 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>  	return ptep_test_and_clear_young(vma, address, ptep);
>  }
>
> +#define pgprot_noncached pgprot_noncached
> +static inline pgprot_t pgprot_noncached(pgprot_t _prot)
> +{
> +	unsigned long prot = pgprot_val(_prot);
> +
> +	prot |= _PAGE_COHERENCY;
> +
> +	return __pgprot(prot);
> +}
> +
>  /*
>   * Encode and decode a swap entry
>   *
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index b6bb10b..b945e50 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -25,6 +25,7 @@
>  #define SBI_REMOTE_SFENCE_VMA 6
>  #define SBI_REMOTE_SFENCE_VMA_ASID 7
>  #define SBI_SHUTDOWN 8
> +#define SBI_FENCE_DMA 9
>
>  #define SBI_CALL(which, arg0, arg1, arg2) ({			\
>  	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
> @@ -42,6 +43,8 @@
>  #define SBI_CALL_0(which) SBI_CALL(which, 0, 0, 0)
>  #define SBI_CALL_1(which, arg0) SBI_CALL(which, arg0, 0, 0)
>  #define SBI_CALL_2(which, arg0, arg1) SBI_CALL(which, arg0, arg1, 0)
> +#define SBI_CALL_3(which, arg0, arg1, arg2) \
> +			SBI_CALL(which, arg0, arg1, arg2)
>
>  static inline void sbi_console_putchar(int ch)
>  {
> @@ -82,6 +85,13 @@ static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
>  	SBI_CALL_1(SBI_REMOTE_FENCE_I, hart_mask);
>  }
>
> +static inline void sbi_fence_dma(unsigned long start,
> +			       unsigned long size,
> +			       unsigned long dir)
> +{
> +	SBI_CALL_3(SBI_FENCE_DMA, start, size, dir);
> +}
> +
>  static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
>  					 unsigned long start,
>  					 unsigned long size)
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index b68aac7..adc563a 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -9,3 +9,4 @@ obj-y += fault.o
>  obj-y += extable.o
>  obj-y += ioremap.o
>  obj-y += cacheflush.o
> +obj-y += dma-mapping.o
> diff --git a/arch/riscv/mm/dma-mapping.c b/arch/riscv/mm/dma-mapping.c
> new file mode 100644
> index 0000000..5e1d179
> --- /dev/null
> +++ b/arch/riscv/mm/dma-mapping.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/dma-mapping.h>
> +
> +static int __init atomic_pool_init(void)
> +{
> +	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
> +}
> +postcore_initcall(atomic_pool_init);
> +
> +void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
> +	memset(page_address(page), 0, size);
> +
> +	sbi_fence_dma(page_to_phys(page), size, DMA_BIDIRECTIONAL);
> +}
> +
> +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> +			      size_t size, enum dma_data_direction dir)
> +{
> +	switch (dir) {
> +	case DMA_TO_DEVICE:
> +	case DMA_FROM_DEVICE:
> +	case DMA_BIDIRECTIONAL:
> +		sbi_fence_dma(paddr, size, dir);
> +		break;
> +	default:
> +		BUG();
> +	}
> +}
> +
> +void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
> +			   size_t size, enum dma_data_direction dir)
> +{
> +	switch (dir) {
> +	case DMA_TO_DEVICE:
> +	case DMA_FROM_DEVICE:
> +	case DMA_BIDIRECTIONAL:
> +		sbi_fence_dma(paddr, size, dir);
> +		break;
> +	default:
> +		BUG();
> +	}
> +}
> diff --git a/arch/riscv/mm/ioremap.c b/arch/riscv/mm/ioremap.c
> index bd2f2db..f6aaf1e 100644
> --- a/arch/riscv/mm/ioremap.c
> +++ b/arch/riscv/mm/ioremap.c
> @@ -73,7 +73,7 @@ static void __iomem *__ioremap_caller(phys_addr_t addr, size_t size,
>   */
>  void __iomem *ioremap(phys_addr_t offset, unsigned long size)
>  {
> -	return __ioremap_caller(offset, size, PAGE_KERNEL,
> +	return __ioremap_caller(offset, size, PAGE_KERNEL_COHERENCY,
>  		__builtin_return_address(0));
>  }
>  EXPORT_SYMBOL(ioremap);
