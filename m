Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745F267B1AA
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 12:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjAYLku (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 06:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbjAYLku (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 06:40:50 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD7793D0
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 03:40:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so46888482ejc.4
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 03:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9CONn1V7Ye0B52Z8jaNfjazx4lKqTqS2Pz1n8BRitY=;
        b=glVFMNjSO3M/lJkAc38ryLFpJX/PuxEQkkajt8a8RsWGcjR8b0wC4FIAHEqN+saZRU
         29/3wnp6WOHjMxZgsD3Dsd04QuzB/iBeyDHvgh8hLSt3sJbiVLfq5QQRMViMQjkfnuXy
         7fnNMqWzBhDEGEDuKuz5a2Fc11hnRancjlfkzMpttm3Prl/KmYmN9ZHL9QJHechR44US
         89Uy9V1IgfRLqpZmyiUSpJM6L7lFa6H2esZgfi5Uzm5BVrgpfRHqINY3OBwquk9cBBrL
         lfDD+cmFKD6j8G7diOV21inLVr5BH0fQgv47esxBZaSZv5ODsKGDocUZ5XzvaFAxBi0e
         N9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9CONn1V7Ye0B52Z8jaNfjazx4lKqTqS2Pz1n8BRitY=;
        b=dz4UdJ+B3yHu9if56gIf3n1XfCJVxGg4gvPRJHSVA+g+GOIMlGYAcbr0Gsa2nspkeR
         qSB/Nq15pvUZC/rekov8ED7fSRGq3sNANzK13ZpDFhDvVjTDjJ2AEIGx7hhPBLhDCuEx
         hPJj5ymcBYLYuDzBXLhUozMxxRV8zzTNc4pE13xcXwcE0UqiqeGwJKgdNMpskx9cmlHA
         QF0na5bYGx93+Vngnwx/1XtMO9JKP6xXx23p07QQl7nTNZn8WVHcpDxMoUmgfmW7HYL4
         4enVA3enLM9yU2ifO3a2SDCWLgld0ac6GXqX4MZ7/P42VErhoo7ZnYv3I6HLJO1Dbi3d
         F1mQ==
X-Gm-Message-State: AFqh2koClHemoLuVg2xSeNletsGYFCzgg25vEeInCRI8r3Ixi/Uphh9y
        K44/gHxq61R4MLgb8LiQeajB9w==
X-Google-Smtp-Source: AMrXdXuOtX/o0noIZONw0GP3yL+7WMkkHddkrvvKpIG3R3OivXD5kAxRBtnLfDYjR/dvWr01000UcQ==
X-Received: by 2002:a17:906:6313:b0:7c1:6151:34c0 with SMTP id sk19-20020a170906631300b007c1615134c0mr35279437ejc.6.1674646846419;
        Wed, 25 Jan 2023 03:40:46 -0800 (PST)
Received: from localhost ([93.99.189.36])
        by smtp.gmail.com with ESMTPSA id p7-20020a1709060e8700b0086f4b8f9e42sm2287363ejf.65.2023.01.25.03.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 03:40:45 -0800 (PST)
Date:   Wed, 25 Jan 2023 12:40:44 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 1/2] riscv: Get rid of riscv_pfn_base variable
Message-ID: <20230125114044.qcr2canalvljevcu@orel>
References: <20230125081214.1576313-1-alexghiti@rivosinc.com>
 <20230125081214.1576313-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125081214.1576313-2-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 25, 2023 at 09:12:13AM +0100, Alexandre Ghiti wrote:
> Use directly phys_ram_base instead, riscv_pfn_base is just the pfn of
> the address contained in phys_ram_base.
> 
> Even if there is no functional change intended in this patch, actually
> setting phys_ram_base that early changes the behaviour of
> kernel_mapping_pa_to_va during the early boot: phys_ram_base used to be
> zero before this patch and now it is set to the physical start address of
> the kernel. But it does not break the conversion of a kernel physical
> address into a virtual address since kernel_mapping_pa_to_va should only
> be used on kernel physical addresses, i.e. addresses greater than the
> physical start address of the kernel.

afaict, only CONFIG_XIP_KERNEL kernels use phys_ram_base prior to
setup_bootmem() and, for them, this change only redundantly sets
phys_ram_base to the same thing, so I believe this is a no functional
change patch.

> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/page.h | 3 +--
>  arch/riscv/mm/init.c          | 6 +-----
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 9f432c1b5289..728eee53152a 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -91,8 +91,7 @@ typedef struct page *pgtable_t;
>  #endif
>  
>  #ifdef CONFIG_MMU
> -extern unsigned long riscv_pfn_base;
> -#define ARCH_PFN_OFFSET		(riscv_pfn_base)
> +#define ARCH_PFN_OFFSET		(PFN_DOWN(phys_ram_base))
>  #else
>  #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
>  #endif /* CONFIG_MMU */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 478d6763a01a..225a7d2b65cc 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -271,9 +271,6 @@ static void __init setup_bootmem(void)
>  #ifdef CONFIG_MMU
>  struct pt_alloc_ops pt_ops __initdata;
>  
> -unsigned long riscv_pfn_base __ro_after_init;
> -EXPORT_SYMBOL(riscv_pfn_base);
> -
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
> @@ -285,7 +282,6 @@ static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAG
>  
>  #ifdef CONFIG_XIP_KERNEL
>  #define pt_ops			(*(struct pt_alloc_ops *)XIP_FIXUP(&pt_ops))
> -#define riscv_pfn_base         (*(unsigned long  *)XIP_FIXUP(&riscv_pfn_base))
>  #define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
>  #define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
>  #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
> @@ -985,7 +981,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
>  	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
>  
> -	riscv_pfn_base = PFN_DOWN(kernel_map.phys_addr);
> +	phys_ram_base = kernel_map.phys_addr;

nit: I'd put this in the #else part of the #ifdef CONFIG_XIP_KERNEL above
to have some consistency with that #ifdef arm and also avoid the redundant
assignment of phys_ram_base for CONFIG_XIP_KERNEL.

>  
>  	/*
>  	 * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
> -- 
> 2.37.2
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
