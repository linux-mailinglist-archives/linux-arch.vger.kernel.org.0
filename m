Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAEB704583
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 08:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjEPGuB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 02:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjEPGtt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 02:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003A149E2;
        Mon, 15 May 2023 23:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D39F63490;
        Tue, 16 May 2023 06:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E44C4339B;
        Tue, 16 May 2023 06:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684219780;
        bh=d2xPxL7hJLLCcdGa/Dam38E/r5WEtsNgznbXdjNHj68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TI/Bn+ONKSePa8TKHiys+pUWNGrGmYo9caF9YdS/nRRGoqyXGZyXeNDzuZ/1ZvMdV
         D4GqCgfqiVF+RtiOio4cKExq9JzEMAxF8o+LVhViv3urHEbjL9Xm4TI0Qu1C89MNQT
         N7gbutob0TgQBwjJ1RYur9/+o2HCUYS6f/pWer72TSG1OoHqCkLH5tPsFbDXszyG5G
         0rikMvbtqF3E1c/cuLiOgIzBsXOgR9Usj8zMWLc1mCfBHD4uNBjXBaKakpumyR0Utn
         6YrJMfplyVHBr+xusx1oJaeBSZy8u8h1e4vAGBiTGhUoWKsTbyDwBYw4Pu+KPZJAla
         /iduDoT9ZW/ZQ==
Date:   Tue, 16 May 2023 09:49:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 08/17] ia64: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGMnfR0NqqcbqP4O@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-9-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-9-bhe@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:39PM +0800, Baoquan He wrote:
> By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> and iounmap() are all visible and available to arch. Arch needs to
> provide wrapper functions to override the generic versions if there's
> arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> This change will simplify implementation by removing duplicated codes
> with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> functioality as before.
> 
> Here, add wrapper functions ioremap_prot() and iounmap() for ia64's
> special operation when ioremap() and iounmap().
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: linux-ia64@vger.kernel.org

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/ia64/Kconfig          |  1 +
>  arch/ia64/include/asm/io.h | 13 +++++-------
>  arch/ia64/mm/ioremap.c     | 41 ++++++--------------------------------
>  3 files changed, 12 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 21fa63ce5ffc..4f970b6d8032 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -46,6 +46,7 @@ config IA64
>  	select GENERIC_IRQ_LEGACY
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	select GENERIC_IOMAP
> +	select GENERIC_IOREMAP
>  	select GENERIC_SMP_IDLE_THREAD
>  	select ARCH_TASK_STRUCT_ON_STACK
>  	select ARCH_TASK_STRUCT_ALLOCATOR
> diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
> index 83a492c8d298..eedc0afa8cad 100644
> --- a/arch/ia64/include/asm/io.h
> +++ b/arch/ia64/include/asm/io.h
> @@ -243,15 +243,12 @@ static inline void outsl(unsigned long port, const void *src,
>  
>  # ifdef __KERNEL__
>  
> -extern void __iomem * ioremap(unsigned long offset, unsigned long size);
> +#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL)
> +
>  extern void __iomem * ioremap_uc(unsigned long offset, unsigned long size);
> -extern void iounmap (volatile void __iomem *addr);
> -static inline void __iomem * ioremap_cache (unsigned long phys_addr, unsigned long size)
> -{
> -	return ioremap(phys_addr, size);
> -}
> -#define ioremap ioremap
> -#define ioremap_cache ioremap_cache
> +
> +#define ioremap_prot ioremap_prot
> +#define ioremap_cache ioremap
>  #define ioremap_uc ioremap_uc
>  #define iounmap iounmap
>  
> diff --git a/arch/ia64/mm/ioremap.c b/arch/ia64/mm/ioremap.c
> index 92b81bc91397..711b6abc822e 100644
> --- a/arch/ia64/mm/ioremap.c
> +++ b/arch/ia64/mm/ioremap.c
> @@ -29,13 +29,9 @@ early_ioremap (unsigned long phys_addr, unsigned long size)
>  	return __ioremap_uc(phys_addr);
>  }
>  
> -void __iomem *
> -ioremap (unsigned long phys_addr, unsigned long size)
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   unsigned long flags)
>  {
> -	void __iomem *addr;
> -	struct vm_struct *area;
> -	unsigned long offset;
> -	pgprot_t prot;
>  	u64 attr;
>  	unsigned long gran_base, gran_size;
>  	unsigned long page_base;
> @@ -68,36 +64,12 @@ ioremap (unsigned long phys_addr, unsigned long size)
>  	 */
>  	page_base = phys_addr & PAGE_MASK;
>  	size = PAGE_ALIGN(phys_addr + size) - page_base;
> -	if (efi_mem_attribute(page_base, size) & EFI_MEMORY_WB) {
> -		prot = PAGE_KERNEL;
> -
> -		/*
> -		 * Mappings have to be page-aligned
> -		 */
> -		offset = phys_addr & ~PAGE_MASK;
> -		phys_addr &= PAGE_MASK;
> -
> -		/*
> -		 * Ok, go for it..
> -		 */
> -		area = get_vm_area(size, VM_IOREMAP);
> -		if (!area)
> -			return NULL;
> -
> -		area->phys_addr = phys_addr;
> -		addr = (void __iomem *) area->addr;
> -		if (ioremap_page_range((unsigned long) addr,
> -				(unsigned long) addr + size, phys_addr, prot)) {
> -			vunmap((void __force *) addr);
> -			return NULL;
> -		}
> -
> -		return (void __iomem *) (offset + (char __iomem *)addr);
> -	}
> +	if (efi_mem_attribute(page_base, size) & EFI_MEMORY_WB)
> +		return generic_ioremap_prot(phys_addr, size, __pgprot(flags));
>  
>  	return __ioremap_uc(phys_addr);
>  }
> -EXPORT_SYMBOL(ioremap);
> +EXPORT_SYMBOL(ioremap_prot);
>  
>  void __iomem *
>  ioremap_uc(unsigned long phys_addr, unsigned long size)
> @@ -114,8 +86,7 @@ early_iounmap (volatile void __iomem *addr, unsigned long size)
>  {
>  }
>  
> -void
> -iounmap (volatile void __iomem *addr)
> +void iounmap(volatile void __iomem *addr)
>  {
>  	if (REGION_NUMBER(addr) == RGN_GATE)
>  		vunmap((void *) ((unsigned long) addr & PAGE_MASK));
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
