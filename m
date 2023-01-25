Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7338367B579
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 16:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjAYPKr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 10:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjAYPKq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 10:10:46 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747734AA51
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 07:10:44 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hw16so48391849ejc.10
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 07:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OjbBxTdJk3reRJFtL0M8qFZw9fGX7o1etLLav+BYBgY=;
        b=NjgXtbsqsDpeERLpFUQZQyM1EMfHXL0hR9T1WYLEOGkyn00FlnWDhLr994ux6q/Xel
         oDH7E4H97sIf3uTCCsDCAvSWP8I43AOFy1wi2Q9U658wSHuy742+XHAI2p3tfphik24D
         uoK6x/MyjVZj+2tHVIwFvpumz2fpJLsd1MvE8oURNNe8oOm9OkanyU9C/RgjN7b+wXge
         SSqk4tQnIoHxoReiyepZGoelIj7/jYuJJ58YButSxytFOiIX/wqM8E6TxSN2dZJSOlr0
         Q1llBpBGyThZJgoXQYp2mFTaJ3ninGNlDfobQpSM3qnuWtVOh+4hR2U0Uk4mvmfMnEO0
         PN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjbBxTdJk3reRJFtL0M8qFZw9fGX7o1etLLav+BYBgY=;
        b=7A5JlIrurLCVLY0j7W9rQ+K1LawSurLpB4k5JKWHXRHh5k4aNB55J2Z4/5vHecvDji
         kyg0tPmQO5u4im3XbOY0TPUwS+/QWXZ5UG0w7pUMAmrmw6XdXUvp3KrzI40qTs8be61E
         BvVViVU+nQTbJHvWmzMg4bsT/VGsCe1jtnT2MKWxeYKRVJCn5Itr7yEy/Z/iQmkDgHzD
         khmD1UDNlhW+krxGFibXT3maAsTFQ/uv1y1Y2PR4FIpE1vd2YwNAICoHJg/Bmio+VJT/
         AGugHteYSD8f0szZTdJ46tRm/OvWSQTTdSqAExx0M+EZy7gwh0cdShv38PxUrMhtjc8P
         AioA==
X-Gm-Message-State: AFqh2kr0Ca7EunGy+orqrDZv6B39jOgVmVeNFFUcA8CHteaXz6SegkkI
        yreRu1LAKQOLWm/w1sm0m14BUQ==
X-Google-Smtp-Source: AMrXdXt1E3zD2jA53VSsDpotH7EglY+dl3pOAVonyQWBopf5sOe3wg7K422kHNZjKAac053fQabMPQ==
X-Received: by 2002:a17:907:7da0:b0:86d:67b0:6292 with SMTP id oz32-20020a1709077da000b0086d67b06292mr48842476ejc.73.1674659442931;
        Wed, 25 Jan 2023 07:10:42 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id xa16-20020a170907b9d000b008784a4d0864sm92843ejc.172.2023.01.25.07.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 07:10:42 -0800 (PST)
Date:   Wed, 25 Jan 2023 16:10:41 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] riscv: Use PUD/P4D/PGD pages for the linear mapping
Message-ID: <20230125151041.ijhjqswqiwmrzljd@orel>
References: <20230123112803.817534-1-alexghiti@rivosinc.com>
 <20230123142554.f22ajf6upfk2ybxk@orel>
 <20230125104102.2thvourt3lx2p36a@orel>
 <CAHVXubjUCmk6xGTCPzMujYqKUwE0bhQBqd8A+=yq7ijQZtBObg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVXubjUCmk6xGTCPzMujYqKUwE0bhQBqd8A+=yq7ijQZtBObg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 25, 2023 at 01:12:49PM +0100, Alexandre Ghiti wrote:
> On Wed, Jan 25, 2023 at 11:41 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Mon, Jan 23, 2023 at 03:25:54PM +0100, Andrew Jones wrote:
> > > On Mon, Jan 23, 2023 at 12:28:02PM +0100, Alexandre Ghiti wrote:
> > > > During the early page table creation, we used to set the mapping for
> > > > PAGE_OFFSET to the kernel load address: but the kernel load address is
> > > > always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
> > > > pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
> > > > PAGE_OFFSET is).
> > > >
> > > > But actually we don't have to establish this mapping (ie set va_pa_offset)
> > > > that early in the boot process because:
> > > >
> > > > - first, setup_vm installs a temporary kernel mapping and among other
> > > >   things, discovers the system memory,
> > > > - then, setup_vm_final creates the final kernel mapping and takes
> > > >   advantage of the discovered system memory to create the linear
> > > >   mapping.
> > > >
> > > > During the first phase, we don't know the start of the system memory and
> > > > then until the second phase is finished, we can't use the linear mapping at
> > > > all and phys_to_virt/virt_to_phys translations must not be used because it
> > > > would result in a different translation from the 'real' one once the final
> > > > mapping is installed.
> > > >
> > > > So here we simply delay the initialization of va_pa_offset to after the
> > > > system memory discovery. But to make sure noone uses the linear mapping
> > > > before, we add some guard in the DEBUG_VIRTUAL config.
> > > >
> > > > Finally we can use PUD/P4D/PGD hugepages when possible, which will result
> > > > in a better TLB utilization.
> > > >
> > > > Note that we rely on the firmware to protect itself using PMP.
> > > >
> > > > Acked-by: Rob Herring <robh@kernel.org> # DT bits
> > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > ---
> > > >
> > > > v4:
> > > > - Rebase on top of v6.2-rc3, as noted by Conor
> > > > - Add Acked-by Rob
> > > >
> > > > v3:
> > > > - Change the comment about initrd_start VA conversion so that it fits
> > > >   ARM64 and RISCV64 (and others in the future if needed), as suggested
> > > >   by Rob
> > > >
> > > > v2:
> > > > - Add a comment on why RISCV64 does not need to set initrd_start/end that
> > > >   early in the boot process, as asked by Rob
> > > >
> > > >  arch/riscv/include/asm/page.h | 16 ++++++++++++++++
> > > >  arch/riscv/mm/init.c          | 25 +++++++++++++++++++------
> > > >  arch/riscv/mm/physaddr.c      | 16 ++++++++++++++++
> > > >  drivers/of/fdt.c              | 11 ++++++-----
> > > >  4 files changed, 57 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > > > index 9f432c1b5289..7fe84c89e572 100644
> > > > --- a/arch/riscv/include/asm/page.h
> > > > +++ b/arch/riscv/include/asm/page.h
> > > > @@ -90,6 +90,14 @@ typedef struct page *pgtable_t;
> > > >  #define PTE_FMT "%08lx"
> > > >  #endif
> > > >
> > > > +#ifdef CONFIG_64BIT
> > > > +/*
> > > > + * We override this value as its generic definition uses __pa too early in
> > > > + * the boot process (before kernel_map.va_pa_offset is set).
> > > > + */
> > > > +#define MIN_MEMBLOCK_ADDR      0
> > > > +#endif
> > > > +
> > > >  #ifdef CONFIG_MMU
> > > >  extern unsigned long riscv_pfn_base;
> > > >  #define ARCH_PFN_OFFSET            (riscv_pfn_base)
> > > > @@ -122,7 +130,11 @@ extern phys_addr_t phys_ram_base;
> > > >  #define is_linear_mapping(x)       \
> > > >     ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
> > > >
> > > > +#ifndef CONFIG_DEBUG_VIRTUAL
> > > >  #define linear_mapping_pa_to_va(x) ((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
> > > > +#else
> > > > +void *linear_mapping_pa_to_va(unsigned long x);
> > > > +#endif
> > > >  #define kernel_mapping_pa_to_va(y) ({                                      \
> > > >     unsigned long _y = (unsigned long)(y);                                  \
> > > >     (IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?                 \
> > > > @@ -131,7 +143,11 @@ extern phys_addr_t phys_ram_base;
> > > >     })
> > > >  #define __pa_to_va_nodebug(x)              linear_mapping_pa_to_va(x)
> > > >
> > > > +#ifndef CONFIG_DEBUG_VIRTUAL
> > > >  #define linear_mapping_va_to_pa(x) ((unsigned long)(x) - kernel_map.va_pa_offset)
> > > > +#else
> > > > +phys_addr_t linear_mapping_va_to_pa(unsigned long x);
> > > > +#endif
> > > >  #define kernel_mapping_va_to_pa(y) ({                                              \
> > > >     unsigned long _y = (unsigned long)(y);                                  \
> > > >     (IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ? \
> > > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > > index 478d6763a01a..cc892ba9f787 100644
> > > > --- a/arch/riscv/mm/init.c
> > > > +++ b/arch/riscv/mm/init.c
> > > > @@ -213,6 +213,14 @@ static void __init setup_bootmem(void)
> > > >     phys_ram_end = memblock_end_of_DRAM();
> > > >     if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> > > >             phys_ram_base = memblock_start_of_DRAM();
> > > > +
> > > > +   /*
> > > > +    * Any use of __va/__pa before this point is wrong as we did not know the
> > > > +    * start of DRAM before.
> > > > +    */
> > > > +   kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
> > > > +   riscv_pfn_base = PFN_DOWN(phys_ram_base);
> > > > +
> > > >     /*
> > > >      * memblock allocator is not aware of the fact that last 4K bytes of
> > > >      * the addressable memory can not be mapped because of IS_ERR_VALUE
> > > > @@ -671,9 +679,16 @@ void __init create_pgd_mapping(pgd_t *pgdp,
> > > >
> > > >  static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
> > > >  {
> > > > -   /* Upgrade to PMD_SIZE mappings whenever possible */
> > > > -   base &= PMD_SIZE - 1;
> > > > -   if (!base && size >= PMD_SIZE)
> > > > +   if (!(base & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
> > > > +           return PGDIR_SIZE;
> > > > +
> > > > +   if (!(base & (P4D_SIZE - 1)) && size >= P4D_SIZE)
> > > > +           return P4D_SIZE;
> > > > +
> > > > +   if (!(base & (PUD_SIZE - 1)) && size >= PUD_SIZE)
> > > > +           return PUD_SIZE;
> > > > +
> > > > +   if (!(base & (PMD_SIZE - 1)) && size >= PMD_SIZE)
> > > >             return PMD_SIZE;
> > > >
> > > >     return PAGE_SIZE;
> > > > @@ -982,11 +997,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> > > >     set_satp_mode();
> > > >  #endif
> > > >
> > > > -   kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
> > > > +   kernel_map.va_pa_offset = 0UL;
> > > >     kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
> > > >
> > > > -   riscv_pfn_base = PFN_DOWN(kernel_map.phys_addr);
> > > > -
> > > >     /*
> > > >      * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
> > > >      * kernel, whereas for 64-bit kernel, the end of the virtual address
> > > > diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
> > > > index 9b18bda74154..18706f457da7 100644
> > > > --- a/arch/riscv/mm/physaddr.c
> > > > +++ b/arch/riscv/mm/physaddr.c
> > > > @@ -33,3 +33,19 @@ phys_addr_t __phys_addr_symbol(unsigned long x)
> > > >     return __va_to_pa_nodebug(x);
> > > >  }
> > > >  EXPORT_SYMBOL(__phys_addr_symbol);
> > > > +
> > > > +phys_addr_t linear_mapping_va_to_pa(unsigned long x)
> > > > +{
> > > > +   BUG_ON(!kernel_map.va_pa_offset);
> > > > +
> > > > +   return ((unsigned long)(x) - kernel_map.va_pa_offset);
> > > > +}
> > > > +EXPORT_SYMBOL(linear_mapping_va_to_pa);
> > > > +
> > > > +void *linear_mapping_pa_to_va(unsigned long x)
> > > > +{
> > > > +   BUG_ON(!kernel_map.va_pa_offset);
> > > > +
> > > > +   return ((void *)((unsigned long)(x) + kernel_map.va_pa_offset));
> > > > +}
> > > > +EXPORT_SYMBOL(linear_mapping_pa_to_va);
> > > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > > index f08b25195ae7..58107bd56f8f 100644
> > > > --- a/drivers/of/fdt.c
> > > > +++ b/drivers/of/fdt.c
> > > > @@ -891,12 +891,13 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
> > > >  static void __early_init_dt_declare_initrd(unsigned long start,
> > > >                                        unsigned long end)
> > > >  {
> > > > -   /* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
> > > > -    * enabled since __va() is called too early. ARM64 does make use
> > > > -    * of phys_initrd_start/phys_initrd_size so we can skip this
> > > > -    * conversion.
> > > > +   /*
> > > > +    * __va() is not yet available this early on some platforms. In that
> > > > +    * case, the platform uses phys_initrd_start/phys_initrd_size instead
> > > > +    * and does the VA conversion itself.
> > > >      */
> > > > -   if (!IS_ENABLED(CONFIG_ARM64)) {
> > > > +   if (!IS_ENABLED(CONFIG_ARM64) &&
> > > > +       !(IS_ENABLED(CONFIG_RISCV) && IS_ENABLED(CONFIG_64BIT))) {
> > >
> > > There are now two architectures, so maybe it's time for a new config
> > > symbol which would be selected by arm64 and riscv64 and then used here,
> > > e.g.
> > >
> > >   if (!IS_ENABLED(CONFIG_NO_EARLY_LINEAR_MAP)) {
> >
> > I see v5 left this as it was. Any comment on this suggestion?
> 
> Introducing a config for this only use case sounds excessive to me,
> but I'll let Rob decide what he wants to see here.

To me, the suggestion is less about trying to tidy up DT code and more
about bringing this comment about arm64 and riscv64 not being able to
use the linear map as early as other architectures up out of the
depths of DT code. Seeing an architecture select something like
NO_EARLY_LINEAR_MAP, which has a paragraph explaining what that
means, may help avoid other early uses of __va() which may or may
not fail quickly and cleanly with a BUG.

Thanks,
drew
