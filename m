Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5F70459C
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 08:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjEPGxU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 02:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjEPGxO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 02:53:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7100CA;
        Mon, 15 May 2023 23:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3C6763490;
        Tue, 16 May 2023 06:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F0DC433D2;
        Tue, 16 May 2023 06:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684219967;
        bh=C0maaaVYK0mlVYQIVRRneqJu0UHwybB7kjeIlSX8s+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktUM9ZWmnUySfqn0dRbUi1RPkXZM7EWikWs/v1GpYveJR1uPzQzk0+/FfcfDBpqXC
         p3yM2yFo2r+0z6dhJPXt6O82UVUkhnq+BPUR39J0obtuJsU2hIh9OONWzRZDQqXWRM
         Kry9gKuwN/e6DjXnVp0oyrkxXzjqeS0B2pMuFfL6ROrU6RoBKezlU9UD2AlnBVGn41
         G0m6RgzFPv4jREJgAAwgL1pdG9liUN1PJlsyRmeE5lMf68eJaLyfZLm03tCww17mix
         dZPm8SQQC/JwPC/3mdw9tpeiWXl6wcY6muzoQtgLvKxSlMyIV5MNNn4H+tEPz3HMEP
         WyWH5G+ixYUxw==
Date:   Tue, 16 May 2023 09:52:39 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 13/17] parisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGMoN/FiwWnvjAjS@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-14-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-14-bhe@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:44PM +0800, Baoquan He wrote:
> By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> and iounmap() are all visible and available to arch. Arch needs to
> provide wrapper functions to override the generic versions if there's
> arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> This change will simplify implementation by removing duplicated codes
> with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> functioality as before.
> 
> Here, add wrapper function ioremap_prot() for parisc's special operation
> when iounmap().
> 
> Meanwhile, add macro ARCH_HAS_IOREMAP_WC since the added ioremap_wc()
> will conflict with the one in include/asm-generic/iomap.h, then an
> compiling error is seen:

Looks like this paragraph is outdated, as an earlier patch in the series
removes use of ARCH_HAS_IOREMAP_WC?
 
> ./include/asm-generic/iomap.h:97: warning: "ioremap_wc" redefined
>    97 | #define ioremap_wc ioremap
> 
> And benefit from the commit 437b6b35362b ("parisc: Use the generic
> IO helpers"), those macros don't need be added any more.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Helge Deller <deller@gmx.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: linux-parisc@vger.kernel.org
> ---
>  arch/parisc/Kconfig          |  1 +
>  arch/parisc/include/asm/io.h | 15 ++++++---
>  arch/parisc/mm/ioremap.c     | 62 +++---------------------------------
>  3 files changed, 15 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 466a25525364..be6ab4530390 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -36,6 +36,7 @@ config PARISC
>  	select GENERIC_ATOMIC64 if !64BIT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_PCI_IOMAP
> +	select GENERIC_IOREMAP
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_ARCH_TOPOLOGY if SMP
> diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
> index c05e781be2f5..366537042465 100644
> --- a/arch/parisc/include/asm/io.h
> +++ b/arch/parisc/include/asm/io.h
> @@ -125,12 +125,17 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
>  /*
>   * The standard PCI ioremap interfaces
>   */
> -void __iomem *ioremap(unsigned long offset, unsigned long size);
> -#define ioremap_wc			ioremap
> -#define ioremap_uc			ioremap
> -#define pci_iounmap			pci_iounmap
> +#define ioremap_prot ioremap_prot
> +
> +#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | \
> +		       _PAGE_ACCESSED | _PAGE_NO_CACHE)
>  
> -extern void iounmap(const volatile void __iomem *addr);
> +#define ioremap_wc(addr, size)  \
> +	ioremap_prot((addr), (size), _PAGE_IOREMAP)
> +#define ioremap_uc(addr, size)  \
> +	ioremap_prot((addr), (size), _PAGE_IOREMAP)
> +
> +#define pci_iounmap			pci_iounmap
>  
>  void memset_io(volatile void __iomem *addr, unsigned char val, int count);
>  void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
> diff --git a/arch/parisc/mm/ioremap.c b/arch/parisc/mm/ioremap.c
> index 345ff0b66499..fd996472dfe7 100644
> --- a/arch/parisc/mm/ioremap.c
> +++ b/arch/parisc/mm/ioremap.c
> @@ -13,25 +13,9 @@
>  #include <linux/io.h>
>  #include <linux/mm.h>
>  
> -/*
> - * Generic mapping function (not visible outside):
> - */
> -
> -/*
> - * Remap an arbitrary physical address space into the kernel virtual
> - * address space.
> - *
> - * NOTE! We need to allow non-page-aligned mappings too: we will obviously
> - * have to convert them into an offset in a page-aligned mapping, but the
> - * caller shouldn't need to know that small detail.
> - */
> -void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   unsigned long prot)
>  {
> -	void __iomem *addr;
> -	struct vm_struct *area;
> -	unsigned long offset, last_addr;
> -	pgprot_t pgprot;
> -
>  #ifdef CONFIG_EISA
>  	unsigned long end = phys_addr + size - 1;
>  	/* Support EISA addresses */
> @@ -40,11 +24,6 @@ void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
>  		phys_addr |= F_EXTEND(0xfc000000);
>  #endif
>  
> -	/* Don't allow wraparound or zero size */
> -	last_addr = phys_addr + size - 1;
> -	if (!size || last_addr < phys_addr)
> -		return NULL;
> -
>  	/*
>  	 * Don't allow anybody to remap normal RAM that we're using..
>  	 */
> @@ -62,39 +41,6 @@ void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
>  		}
>  	}
>  
> -	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY |
> -			  _PAGE_ACCESSED | _PAGE_NO_CACHE);
> -
> -	/*
> -	 * Mappings have to be page-aligned
> -	 */
> -	offset = phys_addr & ~PAGE_MASK;
> -	phys_addr &= PAGE_MASK;
> -	size = PAGE_ALIGN(last_addr + 1) - phys_addr;
> -
> -	/*
> -	 * Ok, go for it..
> -	 */
> -	area = get_vm_area(size, VM_IOREMAP);
> -	if (!area)
> -		return NULL;
> -
> -	addr = (void __iomem *) area->addr;
> -	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
> -			       phys_addr, pgprot)) {
> -		vunmap(addr);
> -		return NULL;
> -	}
> -
> -	return (void __iomem *) (offset + (char __iomem *)addr);
> -}
> -EXPORT_SYMBOL(ioremap);
> -
> -void iounmap(const volatile void __iomem *io_addr)
> -{
> -	unsigned long addr = (unsigned long)io_addr & PAGE_MASK;
> -
> -	if (is_vmalloc_addr((void *)addr))
> -		vunmap((void *)addr);
> +	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
>  }
> -EXPORT_SYMBOL(iounmap);
> +EXPORT_SYMBOL(ioremap_prot);
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
