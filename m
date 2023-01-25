Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2CD67B1C9
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 12:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbjAYLme (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 06:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjAYLmd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 06:42:33 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144D893D0
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 03:42:32 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vw16so46844104ejc.12
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 03:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb9Oe6DEHWdCQQYVcOtMZ2MjkkZkpWGuiKIz3jI1NM4=;
        b=Bp5taALzRj/z8A7o3iQYgUlm5ie/gGXq5SzVcVWU6y2E+wFJzN+FEVIHbU2XEAoNxA
         Xifb5d2YPLGKbFl4qlZGxATisWRUvXq8A1PDX7F8r+WcGNgWKSn4fwWC2eHqNTDS2cHT
         PoqH3aG4lNpqi+01iEHxsvKkL8+wwivgpKWrHulobQekjQY26UcsgkxCNtQuRRK4jqMT
         P+RSa0+nolQ96LcOhnljN45KHME118Yi4J2OGAfHvdkK9sISnCxnhgDYRu/uis13YVfg
         5mA84xvs8S7Q6CLVSd2O+xm45ME9cGzljYpFeH7tml1KXkQ/3+1cUOMeKoE2oBXOvUfF
         3rAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rb9Oe6DEHWdCQQYVcOtMZ2MjkkZkpWGuiKIz3jI1NM4=;
        b=MjNA7Eet7wATmmTAkLMYWMIVURAhiWNysDB8s0v3FBGgIrTYpf6xuA7uDiDneIkyNJ
         Wbv3t4QdDJu+DjVDtZfHC44u51l6YFDulYnb6N0Stf+lGD4FxSNXDTy9P65VHc7lLTkk
         BMJO1ukY8uyUW3Xu1sGuBHpJOHMbY0haszwvE89NcPus5Pv8VcaANDmd7cmzT5e/yJOr
         aszCb0uXruKCVLpcxG5CgZbJaZR2drWCfCIsGnxTEpViwoDwXcnInwRFCGumopsD7iHj
         Z27larUHHu5FDB+k1XNtWasRCpqXv+tjTJXgpJ/2VrO8sU0l2/rcwtEBHPuXOf7wBx86
         kVIg==
X-Gm-Message-State: AFqh2krExqQVLp174b8fDoJr1xFP0mg6pgn+mpvxG2GTnTWbglmTTDEl
        k11k6S4JFsrOHZlqRezISPX7gA==
X-Google-Smtp-Source: AMrXdXtpJfltjmTKG5FvaSxJQQ/9yyoUW+A7W9jjuB4Cf82I/efReOVIEM3FHzlq3aw9QEKsjg1bTw==
X-Received: by 2002:a17:906:644f:b0:877:6549:bb6 with SMTP id l15-20020a170906644f00b0087765490bb6mr26421007ejn.58.1674646950591;
        Wed, 25 Jan 2023 03:42:30 -0800 (PST)
Received: from localhost ([93.99.189.36])
        by smtp.gmail.com with ESMTPSA id za10-20020a170906878a00b0084d36fd208esm2322316ejb.18.2023.01.25.03.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 03:42:30 -0800 (PST)
Date:   Wed, 25 Jan 2023 12:42:29 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/2] riscv: Use PUD/P4D/PGD pages for the linear
 mapping
Message-ID: <20230125114229.hrhsyw4aegrnmoau@orel>
References: <20230125081214.1576313-1-alexghiti@rivosinc.com>
 <20230125081214.1576313-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125081214.1576313-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 25, 2023 at 09:12:14AM +0100, Alexandre Ghiti wrote:
> During the early page table creation, we used to set the mapping for
> PAGE_OFFSET to the kernel load address: but the kernel load address is
> always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
> pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
> PAGE_OFFSET is).
> 
> But actually we don't have to establish this mapping (ie set va_pa_offset)
> that early in the boot process because:
> 
> - first, setup_vm installs a temporary kernel mapping and among other
>   things, discovers the system memory,
> - then, setup_vm_final creates the final kernel mapping and takes
>   advantage of the discovered system memory to create the linear
>   mapping.
> 
> During the first phase, we don't know the start of the system memory and
> then until the second phase is finished, we can't use the linear mapping at
> all and phys_to_virt/virt_to_phys translations must not be used because it
> would result in a different translation from the 'real' one once the final
> mapping is installed.
> 
> So here we simply delay the initialization of va_pa_offset to after the
> system memory discovery. But to make sure noone uses the linear mapping
> before, we add some guard in the DEBUG_VIRTUAL config.
> 
> Finally we can use PUD/P4D/PGD hugepages when possible, which will result
> in a better TLB utilization.
> 
> Note that we rely on the firmware to protect itself using PMP.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Acked-by: Rob Herring <robh@kernel.org> # DT bits
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/page.h | 16 ++++++++++++++++
>  arch/riscv/mm/init.c          | 24 ++++++++++++++++++------
>  arch/riscv/mm/physaddr.c      | 16 ++++++++++++++++
>  drivers/of/fdt.c              | 11 ++++++-----
>  4 files changed, 56 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 728eee53152a..bd7b9dda1e4f 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -90,6 +90,14 @@ typedef struct page *pgtable_t;
>  #define PTE_FMT "%08lx"
>  #endif
>  
> +#ifdef CONFIG_64BIT
> +/*
> + * We override this value as its generic definition uses __pa too early in
> + * the boot process (before kernel_map.va_pa_offset is set).
> + */
> +#define MIN_MEMBLOCK_ADDR      0
> +#endif
> +
>  #ifdef CONFIG_MMU
>  #define ARCH_PFN_OFFSET		(PFN_DOWN(phys_ram_base))
>  #else
> @@ -121,7 +129,11 @@ extern phys_addr_t phys_ram_base;
>  #define is_linear_mapping(x)	\
>  	((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
>  
> +#ifndef CONFIG_DEBUG_VIRTUAL
>  #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
> +#else
> +void *linear_mapping_pa_to_va(unsigned long x);
> +#endif
>  #define kernel_mapping_pa_to_va(y)	({					\
>  	unsigned long _y = (unsigned long)(y);					\
>  	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?			\
> @@ -130,7 +142,11 @@ extern phys_addr_t phys_ram_base;
>  	})
>  #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
>  
> +#ifndef CONFIG_DEBUG_VIRTUAL
>  #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - kernel_map.va_pa_offset)
> +#else
> +phys_addr_t linear_mapping_va_to_pa(unsigned long x);
> +#endif
>  #define kernel_mapping_va_to_pa(y) ({						\
>  	unsigned long _y = (unsigned long)(y);					\
>  	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ? \
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 225a7d2b65cc..9dfc0afdb114 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -213,6 +213,13 @@ static void __init setup_bootmem(void)
>  	phys_ram_end = memblock_end_of_DRAM();
>  	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
>  		phys_ram_base = memblock_start_of_DRAM();
> +
> +	/*
> +	 * Any use of __va/__pa before this point is wrong as we did not know the
> +	 * start of DRAM before.
> +	 */
> +	kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
> +
>  	/*
>  	 * memblock allocator is not aware of the fact that last 4K bytes of
>  	 * the addressable memory can not be mapped because of IS_ERR_VALUE
> @@ -667,9 +674,16 @@ void __init create_pgd_mapping(pgd_t *pgdp,
>  
>  static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>  {
> -	/* Upgrade to PMD_SIZE mappings whenever possible */
> -	base &= PMD_SIZE - 1;
> -	if (!base && size >= PMD_SIZE)
> +	if (!(base & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
> +		return PGDIR_SIZE;
> +
> +	if (!(base & (P4D_SIZE - 1)) && size >= P4D_SIZE)
> +		return P4D_SIZE;
> +
> +	if (!(base & (PUD_SIZE - 1)) && size >= PUD_SIZE)
> +		return PUD_SIZE;
> +
> +	if (!(base & (PMD_SIZE - 1)) && size >= PMD_SIZE)
>  		return PMD_SIZE;
>  
>  	return PAGE_SIZE;
> @@ -978,11 +992,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	set_satp_mode();
>  #endif
>  
> -	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
> +	kernel_map.va_pa_offset = 0UL;
>  	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
>  
> -	phys_ram_base = kernel_map.phys_addr;
> -
>  	/*
>  	 * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
>  	 * kernel, whereas for 64-bit kernel, the end of the virtual address
> diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
> index 9b18bda74154..18706f457da7 100644
> --- a/arch/riscv/mm/physaddr.c
> +++ b/arch/riscv/mm/physaddr.c
> @@ -33,3 +33,19 @@ phys_addr_t __phys_addr_symbol(unsigned long x)
>  	return __va_to_pa_nodebug(x);
>  }
>  EXPORT_SYMBOL(__phys_addr_symbol);
> +
> +phys_addr_t linear_mapping_va_to_pa(unsigned long x)
> +{
> +	BUG_ON(!kernel_map.va_pa_offset);
> +
> +	return ((unsigned long)(x) - kernel_map.va_pa_offset);
> +}
> +EXPORT_SYMBOL(linear_mapping_va_to_pa);
> +
> +void *linear_mapping_pa_to_va(unsigned long x)
> +{
> +	BUG_ON(!kernel_map.va_pa_offset);
> +
> +	return ((void *)((unsigned long)(x) + kernel_map.va_pa_offset));

I missed pointing out this superfluous () in this function and the one
above it in my first review, but it's just a nit anyway.

Thanks,
drew
