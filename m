Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6780C388795
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 08:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhESGe2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 02:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhESGe2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 02:34:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C90F8613AA;
        Wed, 19 May 2021 06:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621405988;
        bh=DsjSl6yBWh1YFEOLeF/4l7RPg+W/ybQ288UPZbcSu78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Aj9DWes/2u/h2nTLkEPJsRme4HkRERdMUmQgH3Q6Rp0i0+gBei8u/IRvWGayu9O/h
         YxSwdRWIQEdrK2jrz5p74sJJkN0y0HuZeoTjstQSVsU/G+u2mJ8niYS2ZLjPFBRxn/
         b2dgYNoqvRsD6+/F9T4dSbyvIq4LDNBRU+0Mxigx44yKcBN7X7t+y5McTMnHkP8Pyf
         9h5rKAc/o5Sr2ydfHK/bkmJ9/HSiS7p0/owiyu46UvWPwRNLGAbw+jYn5pIxg5jjQX
         0g8adi6FFyMpdFmezPu1fA0ySeutvYZKzUxUq3288lSEdGKKubIy/xfu0SHEOrmpbt
         Jya6aWciL7jLg==
Received: by mail-lf1-f51.google.com with SMTP id x19so17403512lfa.2;
        Tue, 18 May 2021 23:33:08 -0700 (PDT)
X-Gm-Message-State: AOAM532oHjJ73fT6NBj8F47U9WucH1e7XMoYVACiUAxU706lcgBdH2m3
        NJ3bDRDUSzVCUyxddEcgW1p4iJl5SIH9oIzOVnQ=
X-Google-Smtp-Source: ABdhPJwIFYVRRBikGgC4O2rYg2NsvavLz6Rnauk/tXrxyUlwUwx/kHYxLrjPvZ1W078K0+Y1qEXZd5ppwdDbuJBd+8o=
X-Received: by 2002:a19:f701:: with SMTP id z1mr7103212lfe.557.1621405987051;
 Tue, 18 May 2021 23:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org> <1621400656-25678-4-git-send-email-guoren@kernel.org>
In-Reply-To: <1621400656-25678-4-git-send-email-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 19 May 2021 14:32:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTQX82y5COejF95pG9vqZYqqwJgq1H4JrGjEMrT7Enmew@mail.gmail.com>
Message-ID: <CAJF2gTTQX82y5COejF95pG9vqZYqqwJgq1H4JrGjEMrT7Enmew@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] riscv: Add SYNC_DMA_FOR_CPU/DEVICE for DMA_COHERENT
To:     Guo Ren <guoren@kernel.org>, Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        drew@beagleboard.org, Christoph Hellwig <hch@lst.de>,
        wefu@redhat.com, lazyparser@gmail.com
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 1:05 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> To support DMA device in a non-coherent interconnect SOC system,
> we need the below facilities:
>  - Change a memory region attributes from cacheable to strong.
>    It would be used in DMA descriptors.
>  - Sync the cache with memory before DMA start and after DMA end.
>    It would be used for DMA data transfer buffers.
>
> This patch enables kernel dma/direct.c coherent infrastructure and
> a new sbi_ecall API for dma_sync.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Drew Fustini <drew@beagleboard.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Wei Fu <wefu@redhat.com>
> Cc: Wei Wu <lazyparser@gmail.com>
> ---
>  arch/riscv/Kconfig               |  4 ++++
>  arch/riscv/include/asm/pgtable.h | 13 +++++++++++++
>  arch/riscv/include/asm/sbi.h     | 16 ++++++++++++++++
>  arch/riscv/kernel/sbi.c          | 19 +++++++++++++++++++
>  arch/riscv/mm/Makefile           |  4 ++++
>  arch/riscv/mm/dma-mapping.c      | 41 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 97 insertions(+)
>  create mode 100644 arch/riscv/mm/dma-mapping.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 632fac5..94a736a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -20,6 +20,9 @@ config RISCV
>         select ARCH_HAS_DEBUG_VM_PGTABLE
>         select ARCH_HAS_DEBUG_VIRTUAL if MMU
>         select ARCH_HAS_DEBUG_WX
> +       select ARCH_HAS_DMA_PREP_COHERENT if RISCV_DMA_COHERENT
> +       select ARCH_HAS_SYNC_DMA_FOR_CPU if RISCV_DMA_COHERENT
> +       select ARCH_HAS_SYNC_DMA_FOR_DEVICE if RISCV_DMA_COHERENT
>         select ARCH_HAS_FORTIFY_SOURCE
>         select ARCH_HAS_GCOV_PROFILE_ALL
>         select ARCH_HAS_GIGANTIC_PAGE
> @@ -41,6 +44,7 @@ config RISCV
>         select CLONE_BACKWARDS
>         select CLINT_TIMER if !MMU
>         select COMMON_CLK
> +       select DMA_DIRECT_REMAP if RISCV_DMA_COHERENT
>         select EDAC_SUPPORT
>         select GENERIC_ARCH_TOPOLOGY if SMP
>         select GENERIC_ATOMIC64 if !64BIT
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index f822f22..8994d58 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -465,6 +465,19 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>         return ptep_test_and_clear_young(vma, address, ptep);
>  }
>
> +#ifdef CONFIG_RISCV_DMA_COHERENT
> +#define pgprot_noncached pgprot_noncached
> +static inline pgprot_t pgprot_noncached(pgprot_t _prot)
> +{
> +       unsigned long prot = pgprot_val(_prot);
> +
> +       prot &= ~_PAGE_DMA_MASK;
> +       prot |= _PAGE_DMA_NONCACHE;
> +
> +       return __pgprot(prot);
> +}
> +#endif
> +
>  /*
>   * Encode and decode a swap entry
>   *
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 0d42693..08b4244 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -27,6 +27,7 @@ enum sbi_ext_id {
>         SBI_EXT_IPI = 0x735049,
>         SBI_EXT_RFENCE = 0x52464E43,
>         SBI_EXT_HSM = 0x48534D,
> +       SBI_EXT_DMA = 0xAB150401,
>  };
>
>  enum sbi_ext_base_fid {
> @@ -37,6 +38,7 @@ enum sbi_ext_base_fid {
>         SBI_EXT_BASE_GET_MVENDORID,
>         SBI_EXT_BASE_GET_MARCHID,
>         SBI_EXT_BASE_GET_MIMPID,
> +       SBI_EXT_RFENCE_REMOTE_DMA_SYNC,
Oops ... It's no use. Remove in next version patch.

>  };
>
>  enum sbi_ext_time_fid {
> @@ -63,6 +65,17 @@ enum sbi_ext_hsm_fid {
>         SBI_EXT_HSM_HART_STATUS,
>  };
>
> +enum sbi_ext_dma_fid {
> +       SBI_DMA_SYNC = 0,
> +};
> +
> +enum sbi_dma_sync_data_direction {
> +       SBI_DMA_BIDIRECTIONAL = 0,
> +       SBI_DMA_TO_DEVICE = 1,
> +       SBI_DMA_FROM_DEVICE = 2,
> +       SBI_DMA_NONE = 3,
> +};
> +
>  enum sbi_hsm_hart_status {
>         SBI_HSM_HART_STATUS_STARTED = 0,
>         SBI_HSM_HART_STATUS_STOPPED,
> @@ -128,6 +141,9 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
>                                 unsigned long size,
>                                 unsigned long asid);
>  int sbi_probe_extension(int ext);
> +void sbi_dma_sync(unsigned long start,
> +                 unsigned long size,
> +                 enum sbi_dma_sync_data_direction dir);
>
>  /* Check if current SBI specification version is 0.1 or not */
>  static inline int sbi_spec_is_0_1(void)
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 7402a41..ff8e18b 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -521,6 +521,25 @@ int sbi_probe_extension(int extid)
>  }
>  EXPORT_SYMBOL(sbi_probe_extension);
>
> +void sbi_dma_sync(unsigned long start,
> +                 unsigned long size,
> +                 enum sbi_dma_sync_data_direction dir)
> +{
> +#if 0
> +       sbi_ecall(SBI_EXT_DMA, SBI_DMA_SYNC, start, size, dir,
> +                 0, 0, 0);
> +#else
> +       /* Just for try, it should be in sbi ecall and will be removed before merged */
> +       register unsigned long i asm("a0") = start & ~(L1_CACHE_BYTES - 1);
> +
> +       for (; i < (start + size); i += L1_CACHE_BYTES)
> +               __asm__ __volatile__(".long 0x02b5000b");
> +
> +       __asm__ __volatile__(".long 0x01b0000b");
> +#endif
> +}
> +EXPORT_SYMBOL(sbi_dma_sync);
> +
>  static long __sbi_base_ecall(int fid)
>  {
>         struct sbiret ret;
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 7ebaef1..b67d956 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -14,6 +14,10 @@ obj-$(CONFIG_MMU) += fault.o pageattr.o
>  obj-y += cacheflush.o
>  obj-y += context.o
>
> +ifeq ($(CONFIG_RISCV_DMA_COHERENT), y)
> +obj-y += dma-mapping.o
> +endif
> +
>  ifeq ($(CONFIG_MMU),y)
>  obj-$(CONFIG_SMP) += tlbflush.o
>  endif
> diff --git a/arch/riscv/mm/dma-mapping.c b/arch/riscv/mm/dma-mapping.c
> new file mode 100644
> index 00000000..f5db60b
> --- /dev/null
> +++ b/arch/riscv/mm/dma-mapping.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/dma-map-ops.h>
> +#include <asm/sbi.h>
> +
> +void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
> +       void *ptr = page_address(page);
> +
> +       memset(ptr, 0, size);
> +       sbi_dma_sync(page_to_phys(page), size, SBI_DMA_BIDIRECTIONAL);
> +}
> +
> +void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
> +               enum dma_data_direction dir)
> +{
> +       switch (dir) {
> +       case DMA_TO_DEVICE:
> +       case DMA_FROM_DEVICE:
> +       case DMA_BIDIRECTIONAL:
> +               sbi_dma_sync(paddr, size, dir);
> +               break;
> +       default:
> +               BUG();
> +       }
> +}
> +
> +void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
> +               enum dma_data_direction dir)
> +{
> +       switch (dir) {
> +       case DMA_TO_DEVICE:
> +               return;
> +       case DMA_FROM_DEVICE:
> +       case DMA_BIDIRECTIONAL:
> +               sbi_dma_sync(paddr, size, dir);
> +               break;
> +       default:
> +               BUG();
> +       }
> +}
> --
> 2.7.4
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
