Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2DB36513E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Apr 2021 06:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhDTETy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Apr 2021 00:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhDTETt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Apr 2021 00:19:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE896C061763
        for <linux-arch@vger.kernel.org>; Mon, 19 Apr 2021 21:18:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k26so19685535wrc.8
        for <linux-arch@vger.kernel.org>; Mon, 19 Apr 2021 21:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjWEZ1zxdmBRj9KcJNahO8i2TB9ZNFWY/gcI2Oi4MqQ=;
        b=zqRNucjDdX3DN0XU/uZOKhk1gQCfti9NkXWNmKs0zxE5Ss4HjHjFIrPYXOBdnMlU7M
         50DnQ/WyK/ILA4Tzs+ycleoOv88GPJNG/8GZCO+qVnRJ/jzjhBnEXiW1J2dIectUdooE
         wRtBpyKG6VuHChMOwuAE0kBzSRbxz5uhe8FjnfeqCnyJQC0RzhZBKxegFxKMZQRCkqzs
         jww90znjCKy9iq575YD2G4aK4RC9tsEY7UOIU8KcDgTDMYiPIu4IF47c+7TThl7Q4NUj
         wwzBcQxCqaMn+zT2EmDf/ZLFJj7qXYAOpbUV/ahGQ8hA0OgV//AZfNJnXeluZOUseLlX
         uwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjWEZ1zxdmBRj9KcJNahO8i2TB9ZNFWY/gcI2Oi4MqQ=;
        b=KAtunL9p0DQwoOFvb92JWKdI6OKzyFwKqYLKzu5gmAWSYruh8DY3OH1lMUx/rIuWF7
         R3SYQX6bbsgwVbt9apnlWpQ5n7I32+23TuN3I72yXpPx06w8wAvv4tXLKHN/HKr5uyRV
         ePt04n+1MYYPadv4uJaZbfRJOhl6r6/nK8iAj8vMhOxmhzmzd9SL/Wv7DhHCcAqSBV8z
         nLi6oo9efBGNu2t1U+gLUg/lYQXySxQ15giu0AWUJubeaQMSeily4HOTscZuYE+ADbKC
         9C5ILQ8TiFdK8NaXiIgGYQCKzk8iPWbobFGrDLyzSXeMMRAI6IVQDUgOnxIUUdIsACq9
         Qv5A==
X-Gm-Message-State: AOAM5339EvQLj0ESJ1XkkEi08ubd6wfz4dpZXPuJJhsQCX1czIz5Puro
        Lj6UNj6nG/7t+fploRt55ow2lQMmkF6utujJn/ED6w==
X-Google-Smtp-Source: ABdhPJywH6zNS+S9+aPYlLnH0UPE/gKZS9rjo3+N55w1r1s4RZCqJ8v1oZokj44lytbNf+NhzRcwKUvE36LHj44/WDs=
X-Received: by 2002:adf:ce12:: with SMTP id p18mr18078880wrn.144.1618892317302;
 Mon, 19 Apr 2021 21:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210417172159.32085-1-alex@ghiti.fr>
In-Reply-To: <20210417172159.32085-1-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 20 Apr 2021 09:48:26 +0530
Message-ID: <CAAhSdy23jRTp3VoBpnH8B79eSSmuw8qMEYrXyh-02ccWT3O5QQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix 32b kernel caused by 64b kernel mapping moving
 outside linear mapping
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-doc@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 17, 2021 at 10:52 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Fix multiple leftovers when moving the kernel mapping outside the linear
> mapping for 64b kernel that left the 32b kernel unusable.
>
> Fixes: 4b67f48da707 ("riscv: Move kernel mapping outside of linear mapping")
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Quite a few #ifdef but I don't see any better way at the moment. Maybe we can
clean this later. Otherwise looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/page.h    |  9 +++++++++
>  arch/riscv/include/asm/pgtable.h | 16 ++++++++++++----
>  arch/riscv/mm/init.c             | 25 ++++++++++++++++++++++++-
>  3 files changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 22cfb2be60dc..f64b61296c0c 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -90,15 +90,20 @@ typedef struct page *pgtable_t;
>
>  #ifdef CONFIG_MMU
>  extern unsigned long va_pa_offset;
> +#ifdef CONFIG_64BIT
>  extern unsigned long va_kernel_pa_offset;
> +#endif
>  extern unsigned long pfn_base;
>  #define ARCH_PFN_OFFSET                (pfn_base)
>  #else
>  #define va_pa_offset           0
> +#ifdef CONFIG_64BIT
>  #define va_kernel_pa_offset    0
> +#endif
>  #define ARCH_PFN_OFFSET                (PAGE_OFFSET >> PAGE_SHIFT)
>  #endif /* CONFIG_MMU */
>
> +#ifdef CONFIG_64BIT
>  extern unsigned long kernel_virt_addr;
>
>  #define linear_mapping_pa_to_va(x)     ((void *)((unsigned long)(x) + va_pa_offset))
> @@ -112,6 +117,10 @@ extern unsigned long kernel_virt_addr;
>         (_x < kernel_virt_addr) ?                                               \
>                 linear_mapping_va_to_pa(_x) : kernel_mapping_va_to_pa(_x);      \
>         })
> +#else
> +#define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa_offset))
> +#define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
> +#endif
>
>  #ifdef CONFIG_DEBUG_VIRTUAL
>  extern phys_addr_t __virt_to_phys(unsigned long x);
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 80e63a93e903..5afda75cc2c3 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -16,19 +16,27 @@
>  #else
>
>  #define ADDRESS_SPACE_END      (UL(-1))
> -/*
> - * Leave 2GB for kernel and BPF at the end of the address space
> - */
> +
> +#ifdef CONFIG_64BIT
> +/* Leave 2GB for kernel and BPF at the end of the address space */
>  #define KERNEL_LINK_ADDR       (ADDRESS_SPACE_END - SZ_2G + 1)
> +#else
> +#define KERNEL_LINK_ADDR       PAGE_OFFSET
> +#endif
>
>  #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
>  #define VMALLOC_END      (PAGE_OFFSET - 1)
>  #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
>
> -/* KASLR should leave at least 128MB for BPF after the kernel */
>  #define BPF_JIT_REGION_SIZE    (SZ_128M)
> +#ifdef CONFIG_64BIT
> +/* KASLR should leave at least 128MB for BPF after the kernel */
>  #define BPF_JIT_REGION_START   PFN_ALIGN((unsigned long)&_end)
>  #define BPF_JIT_REGION_END     (BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
> +#else
> +#define BPF_JIT_REGION_START   (PAGE_OFFSET - BPF_JIT_REGION_SIZE)
> +#define BPF_JIT_REGION_END     (VMALLOC_END)
> +#endif
>
>  /* Modules always live before the kernel */
>  #ifdef CONFIG_64BIT
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 093f3a96ecfc..dc9b988e0778 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -91,8 +91,10 @@ static void print_vm_layout(void)
>                   (unsigned long)VMALLOC_END);
>         print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
>                   (unsigned long)high_memory);
> +#ifdef CONFIG_64BIT
>         print_mlm("kernel", (unsigned long)KERNEL_LINK_ADDR,
>                   (unsigned long)ADDRESS_SPACE_END);
> +#endif
>  }
>  #else
>  static void print_vm_layout(void) { }
> @@ -165,9 +167,11 @@ static struct pt_alloc_ops pt_ops;
>  /* Offset between linear mapping virtual address and kernel load address */
>  unsigned long va_pa_offset;
>  EXPORT_SYMBOL(va_pa_offset);
> +#ifdef CONFIG_64BIT
>  /* Offset between kernel mapping virtual address and kernel load address */
>  unsigned long va_kernel_pa_offset;
>  EXPORT_SYMBOL(va_kernel_pa_offset);
> +#endif
>  unsigned long pfn_base;
>  EXPORT_SYMBOL(pfn_base);
>
> @@ -410,7 +414,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         load_sz = (uintptr_t)(&_end) - load_pa;
>
>         va_pa_offset = PAGE_OFFSET - load_pa;
> +#ifdef CONFIG_64BIT
>         va_kernel_pa_offset = kernel_virt_addr - load_pa;
> +#endif
>
>         pfn_base = PFN_DOWN(load_pa);
>
> @@ -469,12 +475,16 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>                            pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
>         dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
>  #else /* CONFIG_BUILTIN_DTB */
> +#ifdef CONFIG_64BIT
>         /*
>          * __va can't be used since it would return a linear mapping address
>          * whereas dtb_early_va will be used before setup_vm_final installs
>          * the linear mapping.
>          */
>         dtb_early_va = kernel_mapping_pa_to_va(dtb_pa);
> +#else
> +       dtb_early_va = __va(dtb_pa);
> +#endif /* CONFIG_64BIT */
>  #endif /* CONFIG_BUILTIN_DTB */
>  #else
>  #ifndef CONFIG_BUILTIN_DTB
> @@ -486,7 +496,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>                            pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
>         dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
>  #else /* CONFIG_BUILTIN_DTB */
> +#ifdef CONFIG_64BIT
>         dtb_early_va = kernel_mapping_pa_to_va(dtb_pa);
> +#else
> +       dtb_early_va = __va(dtb_pa);
> +#endif /* CONFIG_64BIT */
>  #endif /* CONFIG_BUILTIN_DTB */
>  #endif
>         dtb_early_pa = dtb_pa;
> @@ -571,12 +585,21 @@ static void __init setup_vm_final(void)
>                 for (pa = start; pa < end; pa += map_size) {
>                         va = (uintptr_t)__va(pa);
>                         create_pgd_mapping(swapper_pg_dir, va, pa,
> -                                          map_size, PAGE_KERNEL);
> +                                          map_size,
> +#ifdef CONFIG_64BIT
> +                                          PAGE_KERNEL
> +#else
> +                                          PAGE_KERNEL_EXEC
> +#endif
> +                                       );
> +
>                 }
>         }
>
> +#ifdef CONFIG_64BIT
>         /* Map the kernel */
>         create_kernel_page_table(swapper_pg_dir, PMD_SIZE);
> +#endif
>
>         /* Clear fixmap PTE and PMD mappings */
>         clear_fixmap(FIX_PTE);
> --
> 2.20.1
>
