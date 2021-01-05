Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5B52EAA34
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jan 2021 12:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbhAELvg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jan 2021 06:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbhAELvf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jan 2021 06:51:35 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050F5C061796
        for <linux-arch@vger.kernel.org>; Tue,  5 Jan 2021 03:50:54 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o17so71912435lfg.4
        for <linux-arch@vger.kernel.org>; Tue, 05 Jan 2021 03:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GMWcCJQk+Rc106f6w1tIJLqayhhWxkXCtH/PhYMDIiI=;
        b=L3N8vC83TqKzTctV7E2OtqvdyhBreaCwsrCVeTMeMHIp3o8wHSirwAyY+z1QMf5Kot
         jyoi43+zd2SYr2QQp8ASbJnV933WljNMOdRmltzU+Ndf5utJaqn2sBcmbSS1F+ahZ857
         7SQLwE4R77jOBz1HxEWTHuFOY0BlEidUklbFQUpcP7V38t/q/w45Wu7WXos820LA5GWt
         E96qrzRO8yB6mwe8AK+6agZs8HOGr8d4LMjRKdeDtrRRshDGUxvJL00HnRrIH/uvpNZP
         lguIh/lvVc4wOn4ulFhPuVfb/tfqAHddtb4VPjoGwyvVjI00EbhQ2yInvspX1/QUf1dY
         h2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GMWcCJQk+Rc106f6w1tIJLqayhhWxkXCtH/PhYMDIiI=;
        b=EDl4EKhg1Yv4PF5pxEMxI7mxD+HixlrdxmOQ8oh5sNXu1rV+r3zWVL61b/Q2ztrUS5
         c10P0AZpC9muwj6eYjKofpcWD2tJTwKFdP1OODN9BytxzlAGQAnO49xHqgSuKcNSDcSN
         RV1UdEbiqXIBtX+pNX1p2ylKXYWtsnBJ4yvnxqE/CphU92XEqzR7ff0YVqliLsEfa9WZ
         zjPIxRWlVRdTRYVzOId+/v1LMseWZQsKSZiT4/50+tZyCClU/DQiSjUmczNwEQM3bA3q
         j+qGYTDfgruNwlqHYwYS81bTttrSAIFha5W/qElBTy03budJ6LiJo6S9lHwqgSg2iPMU
         fYPQ==
X-Gm-Message-State: AOAM531kuWyGGMyh+AM0eywu7cCoEBb8KBn8d3XgluzpVpJIiBWFaqJN
        vYvTYD0OYPxUOJqBk+oXirlw2tISaKlI/+HojSQycw==
X-Google-Smtp-Source: ABdhPJwIJ4Eri51uGtG/aVqVtz2LvPh0hXyL/E8bZpYX6Ob5yGscIPGvWXzqG3VUE1KwxJiPW4lZiwft1o2i16OsuXw=
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr35256172ljk.83.1609847453386;
 Tue, 05 Jan 2021 03:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20210104195840.1593-1-alex@ghiti.fr> <20210104195840.1593-3-alex@ghiti.fr>
In-Reply-To: <20210104195840.1593-3-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 5 Jan 2021 17:20:42 +0530
Message-ID: <CAAhSdy0WpPg-=+NMGFORfrd+Rgq0kwKu7Z3ioMAEfxj+J+KPjw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/12] riscv: Protect the kernel linear mapping
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

On Tue, Jan 5, 2021 at 1:31 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> The kernel is now mapped at the end of the address space and it should
> be accessed through this mapping only: so map the whole kernel in the
> linear mapping as read only.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/include/asm/page.h |  9 ++++++++-
>  arch/riscv/mm/init.c          | 29 +++++++++++++++++++++--------
>  2 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 98188e315e8d..a93e35aaa717 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -102,8 +102,15 @@ extern unsigned long pfn_base;
>  extern unsigned long max_low_pfn;
>  extern unsigned long min_low_pfn;
>  extern unsigned long kernel_virt_addr;
> +extern uintptr_t load_pa, load_sz;
> +
> +#define linear_mapping_pa_to_va(x)     ((void *)((unsigned long)(x) + va_pa_offset))
> +#define kernel_mapping_pa_to_va(x)     \
> +       ((void *)((unsigned long) (x) + va_kernel_pa_offset))
> +#define __pa_to_va_nodebug(x)                          \
> +       ((x >= load_pa && x < load_pa + load_sz) ?      \
> +               kernel_mapping_pa_to_va(x): linear_mapping_pa_to_va(x))

This change should be part of PATCH1

>
> -#define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa_offset))
>  #define linear_mapping_va_to_pa(x)     ((unsigned long)(x) - va_pa_offset)
>  #define kernel_mapping_va_to_pa(x)     \
>         ((unsigned long)(x) - va_kernel_pa_offset)
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 9d06ff0e015a..7b87c14f1d24 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -159,8 +159,6 @@ void __init setup_bootmem(void)
>  {
>         phys_addr_t mem_start = 0;
>         phys_addr_t start, end = 0;
> -       phys_addr_t vmlinux_end = __pa_symbol(&_end);
> -       phys_addr_t vmlinux_start = __pa_symbol(&_start);

This as well.

>         u64 i;
>
>         /* Find the memory region containing the kernel */
> @@ -168,7 +166,7 @@ void __init setup_bootmem(void)
>                 phys_addr_t size = end - start;
>                 if (!mem_start)
>                         mem_start = start;
> -               if (start <= vmlinux_start && vmlinux_end <= end)
> +               if (start <= load_pa && (load_pa + load_sz) <= end)
>                         BUG_ON(size == 0);
>         }
>
> @@ -179,8 +177,13 @@ void __init setup_bootmem(void)
>          */
>         memblock_enforce_memory_limit(mem_start - PAGE_OFFSET);
>
> -       /* Reserve from the start of the kernel to the end of the kernel */
> -       memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
> +       /*
> +        * Reserve from the start of the kernel to the end of the kernel
> +        * and make sure we align the reservation on PMD_SIZE since we will
> +        * map the kernel in the linear mapping as read-only: we do not want
> +        * any allocation to happen between _end and the next pmd aligned page.
> +        */
> +       memblock_reserve(load_pa, (load_sz + PMD_SIZE - 1) & ~(PMD_SIZE - 1));
>
>         max_pfn = PFN_DOWN(memblock_end_of_DRAM());
>         max_low_pfn = max_pfn;
> @@ -438,7 +441,9 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>  #error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
>  #endif
>
> -static uintptr_t load_pa, load_sz;
> +uintptr_t load_pa, load_sz;
> +EXPORT_SYMBOL(load_pa);
> +EXPORT_SYMBOL(load_sz);

I think all changes till here should be in PATCH1.

Only the changes here onwards seems to be as-per PATCH description.

>
>  static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
>  {
> @@ -596,9 +601,17 @@ static void __init setup_vm_final(void)
>
>                 map_size = best_map_size(start, end - start);
>                 for (pa = start; pa < end; pa += map_size) {
> -                       va = (uintptr_t)__va(pa);
> +                       pgprot_t prot = PAGE_KERNEL;
> +
> +                       /* Protect the kernel mapping that lies in the linear mapping */
> +                       if (pa >= __pa(_start) && pa < __pa(_end))
> +                               prot = PAGE_KERNEL_READ;
> +
> +                       /* Make sure we get virtual addresses in the linear mapping */
> +                       va = (uintptr_t)linear_mapping_pa_to_va(pa);
> +
>                         create_pgd_mapping(swapper_pg_dir, va, pa,
> -                                          map_size, PAGE_KERNEL);
> +                                          map_size, prot);
>                 }
>         }
>
> --
> 2.20.1
>

Regards,
Anup
