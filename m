Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C332D73D45C
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jun 2023 23:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjFYVM6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 25 Jun 2023 17:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFYVM5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jun 2023 17:12:57 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6C3CF;
        Sun, 25 Jun 2023 14:12:55 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qDX2R-002qMG-Dg; Sun, 25 Jun 2023 23:12:51 +0200
Received: from dynamic-089-014-168-195.89.14.pool.telefonica.de ([89.14.168.195] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qDX2R-000NkG-5k; Sun, 25 Jun 2023 23:12:51 +0200
Message-ID: <20fdf89dde5eee365ab15d9f4753e3c9fc43d46e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v7 12/19] sh: mm: Convert to GENERIC_IOREMAP
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        nathan@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Date:   Sun, 25 Jun 2023 23:12:50 +0200
In-Reply-To: <20230620131356.25440-13-bhe@redhat.com>
References: <20230620131356.25440-1-bhe@redhat.com>
         <20230620131356.25440-13-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.14.168.195
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Baoquan!

On Tue, 2023-06-20 at 21:13 +0800, Baoquan He wrote:
> By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> and iounmap() are all visible and available to arch. Arch needs to
> provide wrapper functions to override the generic versions if there's
> arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> This change will simplify implementation by removing duplicated codes
                                                                  ^^^^^
Nit-pick: It should be "code", not "codes".

I'll review and test the rest tomorrow. There are quite some changes.

Adrian

> with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> functioality as before.
> 
> Here, add wrapper functions ioremap_prot() and iounmap() for SuperH's
> special operation when ioremap() and iounmap().
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> ---
>  arch/sh/Kconfig          |  1 +
>  arch/sh/include/asm/io.h | 40 +++++--------------------
>  arch/sh/mm/ioremap.c     | 65 +++++++---------------------------------
>  3 files changed, 20 insertions(+), 86 deletions(-)
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 9652d367fc37..f326985e46e0 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -28,6 +28,7 @@ config SUPERH
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GUP_GET_PXX_LOW_HIGH if X2TLB
>  	select HAS_IOPORT if HAS_IOPORT_MAP
> +	select GENERIC_IOREMAP if MMU
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_SECCOMP_FILTER
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index 270e7952950c..b3a26b405c8d 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -266,40 +266,16 @@ unsigned long long poke_real_address_q(unsigned long long addr,
>  #endif
>  
>  #ifdef CONFIG_MMU
> -void iounmap(void __iomem *addr);
> -void __iomem *__ioremap_caller(phys_addr_t offset, unsigned long size,
> -			       pgprot_t prot, void *caller);
> -
> -static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
> -{
> -	return __ioremap_caller(offset, size, PAGE_KERNEL_NOCACHE,
> -			__builtin_return_address(0));
> -}
> -
> -static inline void __iomem *
> -ioremap_cache(phys_addr_t offset, unsigned long size)
> -{
> -	return __ioremap_caller(offset, size, PAGE_KERNEL,
> -			__builtin_return_address(0));
> -}
> -#define ioremap_cache ioremap_cache
> -
> -#ifdef CONFIG_HAVE_IOREMAP_PROT
> -static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
> -		unsigned long flags)
> -{
> -	return __ioremap_caller(offset, size, __pgprot(flags),
> -			__builtin_return_address(0));
> -}
> -#endif /* CONFIG_HAVE_IOREMAP_PROT */
> +/*
> + * I/O memory mapping functions.
> + */
> +#define ioremap_prot ioremap_prot
> +#define iounmap iounmap
>  
> -#else /* CONFIG_MMU */
> -static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
> -{
> -	return (void __iomem *)(unsigned long)offset;
> -}
> +#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL_NOCACHE)
>  
> -static inline void iounmap(volatile void __iomem *addr) { }
> +#define ioremap_cache(addr, size)  \
> +	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
>  #endif /* CONFIG_MMU */
>  
>  #define ioremap_uc	ioremap
> diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
> index 21342581144d..c33b3daa4ad1 100644
> --- a/arch/sh/mm/ioremap.c
> +++ b/arch/sh/mm/ioremap.c
> @@ -72,22 +72,11 @@ __ioremap_29bit(phys_addr_t offset, unsigned long size, pgprot_t prot)
>  #define __ioremap_29bit(offset, size, prot)		NULL
>  #endif /* CONFIG_29BIT */
>  
> -/*
> - * Remap an arbitrary physical address space into the kernel virtual
> - * address space. Needed when the kernel wants to access high addresses
> - * directly.
> - *
> - * NOTE! We need to allow non-page-aligned mappings too: we will obviously
> - * have to convert them into an offset in a page-aligned mapping, but the
> - * caller shouldn't need to know that small detail.
> - */
> -void __iomem * __ref
> -__ioremap_caller(phys_addr_t phys_addr, unsigned long size,
> -		 pgprot_t pgprot, void *caller)
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   unsigned long prot)
>  {
> -	struct vm_struct *area;
> -	unsigned long offset, last_addr, addr, orig_addr;
>  	void __iomem *mapped;
> +	pgprot_t pgprot = __pgprot(prot);
>  
>  	mapped = __ioremap_trapped(phys_addr, size);
>  	if (mapped)
> @@ -97,11 +86,6 @@ __ioremap_caller(phys_addr_t phys_addr, unsigned long size,
>  	if (mapped)
>  		return mapped;
>  
> -	/* Don't allow wraparound or zero size */
> -	last_addr = phys_addr + size - 1;
> -	if (!size || last_addr < phys_addr)
> -		return NULL;
> -
>  	/*
>  	 * If we can't yet use the regular approach, go the fixmap route.
>  	 */
> @@ -112,34 +96,14 @@ __ioremap_caller(phys_addr_t phys_addr, unsigned long size,
>  	 * First try to remap through the PMB.
>  	 * PMB entries are all pre-faulted.
>  	 */
> -	mapped = pmb_remap_caller(phys_addr, size, pgprot, caller);
> +	mapped = pmb_remap_caller(phys_addr, size, pgprot,
> +			__builtin_return_address(0));
>  	if (mapped && !IS_ERR(mapped))
>  		return mapped;
>  
> -	/*
> -	 * Mappings have to be page-aligned
> -	 */
> -	offset = phys_addr & ~PAGE_MASK;
> -	phys_addr &= PAGE_MASK;
> -	size = PAGE_ALIGN(last_addr+1) - phys_addr;
> -
> -	/*
> -	 * Ok, go for it..
> -	 */
> -	area = get_vm_area_caller(size, VM_IOREMAP, caller);
> -	if (!area)
> -		return NULL;
> -	area->phys_addr = phys_addr;
> -	orig_addr = addr = (unsigned long)area->addr;
> -
> -	if (ioremap_page_range(addr, addr + size, phys_addr, pgprot)) {
> -		vunmap((void *)orig_addr);
> -		return NULL;
> -	}
> -
> -	return (void __iomem *)(offset + (char *)orig_addr);
> +	return generic_ioremap_prot(phys_addr, size, pgprot);
>  }
> -EXPORT_SYMBOL(__ioremap_caller);
> +EXPORT_SYMBOL(ioremap_prot);
>  
>  /*
>   * Simple checks for non-translatable mappings.
> @@ -158,10 +122,9 @@ static inline int iomapping_nontranslatable(unsigned long offset)
>  	return 0;
>  }
>  
> -void iounmap(void __iomem *addr)
> +void iounmap(volatile void __iomem *addr)
>  {
>  	unsigned long vaddr = (unsigned long __force)addr;
> -	struct vm_struct *p;
>  
>  	/*
>  	 * Nothing to do if there is no translatable mapping.
> @@ -172,21 +135,15 @@ void iounmap(void __iomem *addr)
>  	/*
>  	 * There's no VMA if it's from an early fixed mapping.
>  	 */
> -	if (iounmap_fixed(addr) == 0)
> +	if (iounmap_fixed((void __iomem *)addr) == 0)
>  		return;
>  
>  	/*
>  	 * If the PMB handled it, there's nothing else to do.
>  	 */
> -	if (pmb_unmap(addr) == 0)
> +	if (pmb_unmap((void __iomem *)addr) == 0)
>  		return;
>  
> -	p = remove_vm_area((void *)(vaddr & PAGE_MASK));
> -	if (!p) {
> -		printk(KERN_ERR "%s: bad address %p\n", __func__, addr);
> -		return;
> -	}
> -
> -	kfree(p);
> +	generic_iounmap(addr);
>  }
>  EXPORT_SYMBOL(iounmap);

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
