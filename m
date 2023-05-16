Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C00704595
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 08:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjEPGwZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 02:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjEPGwX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 02:52:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DAF49D1;
        Mon, 15 May 2023 23:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E2B163490;
        Tue, 16 May 2023 06:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195B3C433D2;
        Tue, 16 May 2023 06:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684219920;
        bh=R3vXaZLbmwcNixKntNH8wMD/qVIT6iG5KEJlYUscwd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1pIQm1xEhZ4DphBAmAifSRaIxZkxwGEglk+5s7b7+Lg4FJdWrTc+EzV6vgWA47SI
         +oElJdTih4GDghmXvZ17lmgRiUoNTz0h3Ce/h0e6st9pphshvWbJD/Cku2ortprxqW
         qpr7gwX85/WAKORaWXd3irGyU9GSuqRvh8pa1jEnKldUz3KfB1I//SP92FH1gS+tVj
         DtjNhDka+f0H+i83Ul0Y8zf/fqxkpOq+LfYxZNLE5A7c8zQzior91cWvTmolAeE6A8
         iSl2kZCW7Mi8DTqFLzs0eegl3wHCE7Isjs4ARp0yuRZ4lyNP5X+p4b2anmTv+QGzkC
         /y8B+If194LpQ==
Date:   Tue, 16 May 2023 09:51:53 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v5 RESEND 12/17] xtensa: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGMoCUTxk/tew9sA@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-13-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-13-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:43PM +0800, Baoquan He wrote:
> By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> and iounmap() are all visible and available to arch. Arch needs to
> provide wrapper functions to override the generic versions if there's
> arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> This change will simplify implementation by removing duplicated codes
> with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> functioality as before.
> 
> Here, add wrapper functions ioremap_prot(), ioremap() and iounmap() for
> xtensa's special operation when ioremap() and iounmap().
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/xtensa/Kconfig          |  1 +
>  arch/xtensa/include/asm/io.h | 32 ++++++++------------
>  arch/xtensa/mm/ioremap.c     | 58 +++++++++---------------------------
>  3 files changed, 27 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 3c6e5471f025..474cbbff3e6c 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -29,6 +29,7 @@ config XTENSA
>  	select GENERIC_LIB_UCMPDI2
>  	select GENERIC_PCI_IOMAP
>  	select GENERIC_SCHED_CLOCK
> +	select GENERIC_IOREMAP if MMU
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
>  	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
> diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
> index a5b707e1c0f4..934e58399c8c 100644
> --- a/arch/xtensa/include/asm/io.h
> +++ b/arch/xtensa/include/asm/io.h
> @@ -16,6 +16,7 @@
>  #include <asm/vectors.h>
>  #include <linux/bug.h>
>  #include <linux/kernel.h>
> +#include <linux/pgtable.h>
>  
>  #include <linux/types.h>
>  
> @@ -24,22 +25,24 @@
>  #define PCI_IOBASE		((void __iomem *)XCHAL_KIO_BYPASS_VADDR)
>  
>  #ifdef CONFIG_MMU
> -
> -void __iomem *xtensa_ioremap_nocache(unsigned long addr, unsigned long size);
> -void __iomem *xtensa_ioremap_cache(unsigned long addr, unsigned long size);
> -void xtensa_iounmap(volatile void __iomem *addr);
> -
>  /*
> - * Return the virtual address for the specified bus memory.
> + * I/O memory mapping functions.
>   */
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   unsigned long prot);
> +#define ioremap_prot ioremap_prot
> +#define iounmap iounmap
> +
>  static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
>  {
>  	if (offset >= XCHAL_KIO_PADDR
>  	    && offset - XCHAL_KIO_PADDR < XCHAL_KIO_SIZE)
>  		return (void*)(offset-XCHAL_KIO_PADDR+XCHAL_KIO_BYPASS_VADDR);
>  	else
> -		return xtensa_ioremap_nocache(offset, size);
> +		return ioremap_prot(offset, size,
> +			pgprot_val(pgprot_noncached(PAGE_KERNEL)));
>  }
> +#define ioremap ioremap
>  
>  static inline void __iomem *ioremap_cache(unsigned long offset,
>  		unsigned long size)
> @@ -48,21 +51,10 @@ static inline void __iomem *ioremap_cache(unsigned long offset,
>  	    && offset - XCHAL_KIO_PADDR < XCHAL_KIO_SIZE)
>  		return (void*)(offset-XCHAL_KIO_PADDR+XCHAL_KIO_CACHED_VADDR);
>  	else
> -		return xtensa_ioremap_cache(offset, size);
> -}
> -#define ioremap_cache ioremap_cache
> +		return ioremap_prot(offset, size, pgprot_val(PAGE_KERNEL));
>  
> -static inline void iounmap(volatile void __iomem *addr)
> -{
> -	unsigned long va = (unsigned long) addr;
> -
> -	if (!(va >= XCHAL_KIO_CACHED_VADDR &&
> -	      va - XCHAL_KIO_CACHED_VADDR < XCHAL_KIO_SIZE) &&
> -	    !(va >= XCHAL_KIO_BYPASS_VADDR &&
> -	      va - XCHAL_KIO_BYPASS_VADDR < XCHAL_KIO_SIZE))
> -		xtensa_iounmap(addr);
>  }
> -
> +#define ioremap_cache ioremap_cache
>  #endif /* CONFIG_MMU */
>  
>  #include <asm-generic/io.h>
> diff --git a/arch/xtensa/mm/ioremap.c b/arch/xtensa/mm/ioremap.c
> index a400188c16b9..8ca660b7ab49 100644
> --- a/arch/xtensa/mm/ioremap.c
> +++ b/arch/xtensa/mm/ioremap.c
> @@ -6,60 +6,30 @@
>   */
>  
>  #include <linux/io.h>
> -#include <linux/vmalloc.h>
>  #include <linux/pgtable.h>
>  #include <asm/cacheflush.h>
>  #include <asm/io.h>
>  
> -static void __iomem *xtensa_ioremap(unsigned long paddr, unsigned long size,
> -				    pgprot_t prot)
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   unsigned long prot)
>  {
> -	unsigned long offset = paddr & ~PAGE_MASK;
> -	unsigned long pfn = __phys_to_pfn(paddr);
> -	struct vm_struct *area;
> -	unsigned long vaddr;
> -	int err;
> -
> -	paddr &= PAGE_MASK;
> -
> +	unsigned long pfn = __phys_to_pfn((phys_addr));
>  	WARN_ON(pfn_valid(pfn));
>  
> -	size = PAGE_ALIGN(offset + size);
> -
> -	area = get_vm_area(size, VM_IOREMAP);
> -	if (!area)
> -		return NULL;
> -
> -	vaddr = (unsigned long)area->addr;
> -	area->phys_addr = paddr;
> -
> -	err = ioremap_page_range(vaddr, vaddr + size, paddr, prot);
> -
> -	if (err) {
> -		vunmap((void *)vaddr);
> -		return NULL;
> -	}
> -
> -	flush_cache_vmap(vaddr, vaddr + size);
> -	return (void __iomem *)(offset + vaddr);
> -}
> -
> -void __iomem *xtensa_ioremap_nocache(unsigned long addr, unsigned long size)
> -{
> -	return xtensa_ioremap(addr, size, pgprot_noncached(PAGE_KERNEL));
> +	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
>  }
> -EXPORT_SYMBOL(xtensa_ioremap_nocache);
> +EXPORT_SYMBOL(ioremap_prot);
>  
> -void __iomem *xtensa_ioremap_cache(unsigned long addr, unsigned long size)
> +void iounmap(volatile void __iomem *addr)
>  {
> -	return xtensa_ioremap(addr, size, PAGE_KERNEL);
> -}
> -EXPORT_SYMBOL(xtensa_ioremap_cache);
> +	unsigned long va = (unsigned long) addr;
>  
> -void xtensa_iounmap(volatile void __iomem *io_addr)
> -{
> -	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
> +	if ((va >= XCHAL_KIO_CACHED_VADDR &&
> +	      va - XCHAL_KIO_CACHED_VADDR < XCHAL_KIO_SIZE) ||
> +	    (va >= XCHAL_KIO_BYPASS_VADDR &&
> +	      va - XCHAL_KIO_BYPASS_VADDR < XCHAL_KIO_SIZE))
> +		return;
>  
> -	vunmap(addr);
> +	generic_iounmap(addr);
>  }
> -EXPORT_SYMBOL(xtensa_iounmap);
> +EXPORT_SYMBOL(iounmap);
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
