Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C93B2EAA73
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jan 2021 13:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbhAEMHQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jan 2021 07:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbhAEMHP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jan 2021 07:07:15 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C7C061794
        for <linux-arch@vger.kernel.org>; Tue,  5 Jan 2021 04:06:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d13so35901130wrc.13
        for <linux-arch@vger.kernel.org>; Tue, 05 Jan 2021 04:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGKjJEiSSy2izG4ujkGcD0moiRRni/L2Q0MG/wluNhc=;
        b=mtV8E91wND1aKNfDji9QLYJPBQMWC8mHS1I4adE/gfWGyS6lubB7mDXao3j2RV8Gmu
         uvYlNcWrA9nXdzJsCVF3yIA5OIQ7xTm3zkjLJEsotudU5JnoWOVITaPrlrGq82UcKjTk
         SfuYEppZJ5ULuLdMAJN9HJZydDXSWYqNIVljiT911GOBsYlN6+r3kLua9KF6YQQ5TNd5
         EiqCuJ7lj7GlkpGGr+YxlDZgMgYBCDn3+kQmmPMEA1COtJGyh3o4GoSX50Cpk3fWNeIN
         vUK5NHkPWGI6ZLGwtDcGIvRktep2OxxEdLXK+aAgJeaBrAtZdI9msB7it8mYfk2uz9vE
         bsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGKjJEiSSy2izG4ujkGcD0moiRRni/L2Q0MG/wluNhc=;
        b=kkC5CsDn0byPknpXaS3OSU9DPuqiAvL58+Wuhy/tknxcUodl5kx4aM4YTNV8rBuBNU
         gUxd5YAkDV1ddhUKzTwEP3mvJjF0thc9BGNBd3ebqJnvFTtsiIAv1Q0wjnRThzEKNLhC
         ILgVOlfbCjgr4iEDMGV6JGQiqR1UBm/tn3vzVbBsakrCFu5U7dH9XOtv0yn+eyiXONRo
         FU4RFWr0G76PRDdelnA2Bhen88NyFIXaPGmVS/diyTB//h0oxumyiETqKPCw4N3CgWfD
         vSUGTyZ2V7qSr8fnsaqMLuSuc+c0wrLdZtDT53SO/ahoevcHGNbvH0SbGVd74EbAnTAY
         J24g==
X-Gm-Message-State: AOAM533CqTt7MrogqPey2WHYIg6F/NLTveSaPQvWLJ0soPti67xpY/fC
        MPLM4JyQWz28G8ShRJq9tkLgVJIiisP46rJXXI5Q8w==
X-Google-Smtp-Source: ABdhPJzFWenLt+B+f1yF1feYSMrXNb+Mp6Ub9dRfYe/spk0aF2jGgTIUeiE6CfQ/l7BuWWVxGTeJ+rIJPBN3zlzSg3g=
X-Received: by 2002:adf:c18d:: with SMTP id x13mr83182459wre.128.1609848406611;
 Tue, 05 Jan 2021 04:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20210104195840.1593-1-alex@ghiti.fr> <20210104195840.1593-5-alex@ghiti.fr>
In-Reply-To: <20210104195840.1593-5-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 5 Jan 2021 17:36:35 +0530
Message-ID: <CAAhSdy0Diu3nD+QswUUr7Ox+FdZGRedivJ6gNU2dYUCaOx8KjA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/12] riscv: Allow to dynamically define VA_BITS
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 5, 2021 at 1:33 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> With 4-level page table folding at runtime, we don't know at compile time
> the size of the virtual address space so we must set VA_BITS dynamically
> so that sparsemem reserves the right amount of memory for struct pages.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/Kconfig                 | 10 ----------
>  arch/riscv/include/asm/pgtable.h   | 11 +++++++++--
>  arch/riscv/include/asm/sparsemem.h |  6 +++++-
>  3 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 44377fd7860e..2979a44103be 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -122,16 +122,6 @@ config ZONE_DMA32
>         bool
>         default y if 64BIT
>
> -config VA_BITS
> -       int
> -       default 32 if 32BIT
> -       default 39 if 64BIT
> -
> -config PA_BITS
> -       int
> -       default 34 if 32BIT
> -       default 56 if 64BIT
> -
>  config PAGE_OFFSET
>         hex
>         default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 102b728ca146..c7973bfd65bc 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -43,8 +43,14 @@
>   * struct pages to map half the virtual address space. Then
>   * position vmemmap directly below the VMALLOC region.
>   */
> +#ifdef CONFIG_64BIT
> +#define VA_BITS                39
> +#else
> +#define VA_BITS                32
> +#endif
> +
>  #define VMEMMAP_SHIFT \
> -       (CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> +       (VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
>  #define VMEMMAP_SIZE   BIT(VMEMMAP_SHIFT)
>  #define VMEMMAP_END    (VMALLOC_START - 1)
>  #define VMEMMAP_START  (VMALLOC_START - VMEMMAP_SIZE)
> @@ -83,6 +89,7 @@
>  #endif /* CONFIG_64BIT */
>
>  #ifdef CONFIG_MMU
> +
>  /* Number of entries in the page global directory */
>  #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
>  /* Number of entries in the page table */
> @@ -453,7 +460,7 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>   * and give the kernel the other (upper) half.
>   */
>  #ifdef CONFIG_64BIT
> -#define KERN_VIRT_START        (-(BIT(CONFIG_VA_BITS)) + TASK_SIZE)
> +#define KERN_VIRT_START        (-(BIT(VA_BITS)) + TASK_SIZE)
>  #else
>  #define KERN_VIRT_START        FIXADDR_START
>  #endif
> diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
> index 45a7018a8118..63acaecc3374 100644
> --- a/arch/riscv/include/asm/sparsemem.h
> +++ b/arch/riscv/include/asm/sparsemem.h
> @@ -4,7 +4,11 @@
>  #define _ASM_RISCV_SPARSEMEM_H
>
>  #ifdef CONFIG_SPARSEMEM
> -#define MAX_PHYSMEM_BITS       CONFIG_PA_BITS
> +#ifdef CONFIG_64BIT
> +#define MAX_PHYSMEM_BITS       56
> +#else
> +#define MAX_PHYSMEM_BITS       34
> +#endif /* CONFIG_64BIT */
>  #define SECTION_SIZE_BITS      27
>  #endif /* CONFIG_SPARSEMEM */
>
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
