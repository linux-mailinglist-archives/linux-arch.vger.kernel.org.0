Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB947045AF
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 09:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjEPHAc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 03:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjEPHA0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 03:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200A2D1;
        Tue, 16 May 2023 00:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B5862343;
        Tue, 16 May 2023 07:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBC7C433A4;
        Tue, 16 May 2023 07:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684220422;
        bh=uaWOFEtnJfkEuUvkgldSHMU1qyTBFUzaYt9REtBOs3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YXOsZa+dfbd0JluDvpWuYL/Y6rAf175fM4RRCp4pw4AR+CQNq/1kMluQTqdDOlidy
         hzLAtTHThLN0+DyuFhGthLgJbKWYTxQApdSwYvoTlzSB/raOEG7CGgF/6uWqQEplK8
         ssEOLHE64petJfhUwuCTpLDJUxrl38jPFkJkYb+5JvPdu+oyFpMp9j0uyMxcEHfwNq
         uwNze7H82R9PE/0W4xyMpR7ssVidhfvRrk2CLfR1RWf2qT6X1pdSXM9I8NG1tUgFUj
         CxqBNAIrREKVAAphcUySJo7p9IG00kpRk8837SL+zlh6Fxd8qBINcT6DsDriZGvhk3
         5fVJa3rbyTVwQ==
Date:   Tue, 16 May 2023 10:00:13 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 RESEND 15/17] powerpc: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGMp/dltHeJiRKBn@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-16-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-16-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:46PM +0800, Baoquan He wrote:
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> and iounmap() are all visible and available to arch. Arch needs to
> provide wrapper functions to override the generic versions if there's
> arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> This change will simplify implementation by removing duplicated codes
> with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> functioality as before.
> 
> Here, add wrapper functions ioremap_prot() and iounmap() for powerpc's
> special operation when ioremap() and iounmap().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/powerpc/Kconfig          |  1 +
>  arch/powerpc/include/asm/io.h |  8 +++-----
>  arch/powerpc/mm/ioremap.c     | 26 +-------------------------
>  arch/powerpc/mm/ioremap_32.c  | 19 +++++++++----------
>  arch/powerpc/mm/ioremap_64.c  | 12 ++----------
>  5 files changed, 16 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 539d1f03ff42..e0a88ebcd026 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -194,6 +194,7 @@ config PPC
>  	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
>  	select GENERIC_EARLY_IOREMAP
>  	select GENERIC_GETTIMEOFDAY
> +	select GENERIC_IOREMAP
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_IRQ_SHOW_LEVEL
>  	select GENERIC_PCI_IOMAP		if PCI
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index 67a3fb6de498..0732b743e099 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -889,8 +889,8 @@ static inline void iosync(void)
>   *
>   */
>  extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
> -extern void __iomem *ioremap_prot(phys_addr_t address, unsigned long size,
> -				  unsigned long flags);
> +#define ioremap ioremap
> +#define ioremap_prot ioremap_prot
>  extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long size);
>  #define ioremap_wc ioremap_wc
>  
> @@ -904,14 +904,12 @@ void __iomem *ioremap_coherent(phys_addr_t address, unsigned long size);
>  #define ioremap_cache(addr, size) \
>  	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
>  
> -extern void iounmap(volatile void __iomem *addr);
> +#define iounmap iounmap
>  
>  void __iomem *ioremap_phb(phys_addr_t paddr, unsigned long size);
>  
>  int early_ioremap_range(unsigned long ea, phys_addr_t pa,
>  			unsigned long size, pgprot_t prot);
> -void __iomem *do_ioremap(phys_addr_t pa, phys_addr_t offset, unsigned long size,
> -			 pgprot_t prot, void *caller);
>  
>  extern void __iomem *__ioremap_caller(phys_addr_t, unsigned long size,
>  				      pgprot_t prot, void *caller);
> diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
> index 4f12504fb405..705e8e8ffde4 100644
> --- a/arch/powerpc/mm/ioremap.c
> +++ b/arch/powerpc/mm/ioremap.c
> @@ -41,7 +41,7 @@ void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
>  	return __ioremap_caller(addr, size, prot, caller);
>  }
>  
> -void __iomem *ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
> +void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long flags)
>  {
>  	pte_t pte = __pte(flags);
>  	void *caller = __builtin_return_address(0);
> @@ -74,27 +74,3 @@ int early_ioremap_range(unsigned long ea, phys_addr_t pa,
>  
>  	return 0;
>  }
> -
> -void __iomem *do_ioremap(phys_addr_t pa, phys_addr_t offset, unsigned long size,
> -			 pgprot_t prot, void *caller)
> -{
> -	struct vm_struct *area;
> -	int ret;
> -	unsigned long va;
> -
> -	area = __get_vm_area_caller(size, VM_IOREMAP, IOREMAP_START, IOREMAP_END, caller);
> -	if (area == NULL)
> -		return NULL;
> -
> -	area->phys_addr = pa;
> -	va = (unsigned long)area->addr;
> -
> -	ret = ioremap_page_range(va, va + size, pa, prot);
> -	if (!ret)
> -		return (void __iomem *)area->addr + offset;
> -
> -	vunmap_range(va, va + size);
> -	free_vm_area(area);
> -
> -	return NULL;
> -}
> diff --git a/arch/powerpc/mm/ioremap_32.c b/arch/powerpc/mm/ioremap_32.c
> index 9d13143b8be4..ca5bc6be3e6f 100644
> --- a/arch/powerpc/mm/ioremap_32.c
> +++ b/arch/powerpc/mm/ioremap_32.c
> @@ -21,6 +21,13 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
>  	phys_addr_t p, offset;
>  	int err;
>  
> +	/*
> +	 * If the address lies within the first 16 MB, assume it's in ISA
> +	 * memory space
> +	 */
> +	if (addr < SZ_16M)
> +		addr += _ISA_MEM_BASE;
> +
>  	/*
>  	 * Choose an address to map it to.
>  	 * Once the vmalloc system is running, we use it.
> @@ -31,13 +38,6 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
>  	offset = addr & ~PAGE_MASK;
>  	size = PAGE_ALIGN(addr + size) - p;
>  
> -	/*
> -	 * If the address lies within the first 16 MB, assume it's in ISA
> -	 * memory space
> -	 */
> -	if (p < 16 * 1024 * 1024)
> -		p += _ISA_MEM_BASE;
> -
>  #ifndef CONFIG_CRASH_DUMP
>  	/*
>  	 * Don't allow anybody to remap normal RAM that we're using.
> @@ -63,7 +63,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
>  		return (void __iomem *)v + offset;
>  
>  	if (slab_is_available())
> -		return do_ioremap(p, offset, size, prot, caller);
> +		return generic_ioremap_prot(addr, size, prot);
>  
>  	/*
>  	 * Should check if it is a candidate for a BAT mapping
> @@ -87,7 +87,6 @@ void iounmap(volatile void __iomem *addr)
>  	if (v_block_mapped((unsigned long)addr))
>  		return;
>  
> -	if (addr > high_memory && (unsigned long)addr < ioremap_bot)
> -		vunmap((void *)(PAGE_MASK & (unsigned long)addr));
> +	generic_iounmap(addr);
>  }
>  EXPORT_SYMBOL(iounmap);
> diff --git a/arch/powerpc/mm/ioremap_64.c b/arch/powerpc/mm/ioremap_64.c
> index 3acece00b33e..d24e5f166723 100644
> --- a/arch/powerpc/mm/ioremap_64.c
> +++ b/arch/powerpc/mm/ioremap_64.c
> @@ -29,7 +29,7 @@ void __iomem *__ioremap_caller(phys_addr_t addr, unsigned long size,
>  		return NULL;
>  
>  	if (slab_is_available())
> -		return do_ioremap(paligned, offset, size, prot, caller);
> +		return generic_ioremap_prot(addr, size, prot);
>  
>  	pr_warn("ioremap() called early from %pS. Use early_ioremap() instead\n", caller);
>  
> @@ -49,17 +49,9 @@ void __iomem *__ioremap_caller(phys_addr_t addr, unsigned long size,
>   */
>  void iounmap(volatile void __iomem *token)
>  {
> -	void *addr;
> -
>  	if (!slab_is_available())
>  		return;
>  
> -	addr = (void *)((unsigned long __force)PCI_FIX_ADDR(token) & PAGE_MASK);
> -
> -	if ((unsigned long)addr < ioremap_bot) {
> -		pr_warn("Attempt to iounmap early bolted mapping at 0x%p\n", addr);
> -		return;
> -	}
> -	vunmap(addr);
> +	generic_iounmap(PCI_FIX_ADDR(token));
>  }
>  EXPORT_SYMBOL(iounmap);
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
