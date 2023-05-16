Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D108570457A
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 08:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjEPGtb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 02:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjEPGt3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 02:49:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4373A87;
        Mon, 15 May 2023 23:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A99A63496;
        Tue, 16 May 2023 06:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC85C433EF;
        Tue, 16 May 2023 06:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684219765;
        bh=7v5ge8KRvf/1Bpm8sGEAQfoJXbPpCNh7fVbx82qCVFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5juZCTrIEZknbXJgybsDRYtUNZWvK3sGzxA1kxRz0EBsyaeepD9XlWQcf8p/o+Ad
         a2w0/PpkvDv90Kyh4h/3G4kuricu39bl1+ELp924Q2HMQ3YTLC2a63VqbQpMXNH/JY
         vJctOq4zU+ZikrArw8CfYTBHz2E3sShpVjFlHAh91L/8sQEcf0QIkcDOqNqQTq0QYL
         eTrdzrZyRAnEemF23NOHAAW9RJRTr5Mgp/spT43FbCoStbIGb0vllf7T2/VtVsyqNX
         75TwbTx1ksQI0ke0XdwcjWsJCkU2GJ8K4zPEZPwfqb9/ZPOyLEI5VQKxJ7IEI/7we1
         /ZWBGnvFFhDgg==
Date:   Tue, 16 May 2023 09:49:17 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH v5 RESEND 07/17] arc: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGMnbeQzIv+6HYGe@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-8-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-8-bhe@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:38PM +0800, Baoquan He wrote:
> By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> and iounmap() are all visible and available to arch. Arch needs to
> provide wrapper functions to override the generic versions if there's
> arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> This change will simplify implementation by removing duplicated codes
> with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> functioality as before.
> 
> Here, add wrapper functions ioremap_prot() and iounmap() for arc's
> special operation when ioremap_prot() and iounmap().
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: linux-snps-arc@lists.infradead.org

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/arc/Kconfig          |  1 +
>  arch/arc/include/asm/io.h |  7 +++---
>  arch/arc/mm/ioremap.c     | 49 ++++-----------------------------------
>  3 files changed, 8 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index ab6d701365bb..3a666ee0c0bc 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -26,6 +26,7 @@ config ARC
>  	select GENERIC_PENDING_IRQ if SMP
>  	select GENERIC_SCHED_CLOCK
>  	select GENERIC_SMP_IDLE_THREAD
> +	select GENERIC_IOREMAP
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARC_MMU_V4
> diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
> index 80347382a380..4fdb7350636c 100644
> --- a/arch/arc/include/asm/io.h
> +++ b/arch/arc/include/asm/io.h
> @@ -21,8 +21,9 @@
>  #endif
>  
>  extern void __iomem *ioremap(phys_addr_t paddr, unsigned long size);
> -extern void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
> -				  unsigned long flags);
> +#define ioremap ioremap
> +#define ioremap_prot ioremap_prot
> +#define iounmap iounmap
>  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
>  {
>  	return (void __iomem *)port;
> @@ -32,8 +33,6 @@ static inline void ioport_unmap(void __iomem *addr)
>  {
>  }
>  
> -extern void iounmap(const volatile void __iomem *addr);
> -
>  /*
>   * io{read,write}{16,32}be() macros
>   */
> diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
> index 712c2311daef..b07004d53267 100644
> --- a/arch/arc/mm/ioremap.c
> +++ b/arch/arc/mm/ioremap.c
> @@ -8,7 +8,6 @@
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/mm.h>
> -#include <linux/slab.h>
>  #include <linux/cache.h>
>  
>  static inline bool arc_uncached_addr_space(phys_addr_t paddr)
> @@ -25,13 +24,6 @@ static inline bool arc_uncached_addr_space(phys_addr_t paddr)
>  
>  void __iomem *ioremap(phys_addr_t paddr, unsigned long size)
>  {
> -	phys_addr_t end;
> -
> -	/* Don't allow wraparound or zero size */
> -	end = paddr + size - 1;
> -	if (!size || (end < paddr))
> -		return NULL;
> -
>  	/*
>  	 * If the region is h/w uncached, MMU mapping can be elided as optim
>  	 * The cast to u32 is fine as this region can only be inside 4GB
> @@ -51,55 +43,22 @@ EXPORT_SYMBOL(ioremap);
>   * ARC hardware uncached region, this one still goes thru the MMU as caller
>   * might need finer access control (R/W/X)
>   */
> -void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
> +void __iomem *ioremap_prot(phys_addr_t paddr, size_t size,
>  			   unsigned long flags)
>  {
> -	unsigned int off;
> -	unsigned long vaddr;
> -	struct vm_struct *area;
> -	phys_addr_t end;
>  	pgprot_t prot = __pgprot(flags);
>  
> -	/* Don't allow wraparound, zero size */
> -	end = paddr + size - 1;
> -	if ((!size) || (end < paddr))
> -		return NULL;
> -
> -	/* An early platform driver might end up here */
> -	if (!slab_is_available())
> -		return NULL;
> -
>  	/* force uncached */
> -	prot = pgprot_noncached(prot);
> -
> -	/* Mappings have to be page-aligned */
> -	off = paddr & ~PAGE_MASK;
> -	paddr &= PAGE_MASK_PHYS;
> -	size = PAGE_ALIGN(end + 1) - paddr;
> -
> -	/*
> -	 * Ok, go for it..
> -	 */
> -	area = get_vm_area(size, VM_IOREMAP);
> -	if (!area)
> -		return NULL;
> -	area->phys_addr = paddr;
> -	vaddr = (unsigned long)area->addr;
> -	if (ioremap_page_range(vaddr, vaddr + size, paddr, prot)) {
> -		vunmap((void __force *)vaddr);
> -		return NULL;
> -	}
> -	return (void __iomem *)(off + (char __iomem *)vaddr);
> +	return generic_ioremap_prot(paddr, size, pgprot_noncached(prot));
>  }
>  EXPORT_SYMBOL(ioremap_prot);
>  
> -
> -void iounmap(const volatile void __iomem *addr)
> +void iounmap(volatile void __iomem *addr)
>  {
>  	/* weird double cast to handle phys_addr_t > 32 bits */
>  	if (arc_uncached_addr_space((phys_addr_t)(u32)addr))
>  		return;
>  
> -	vfree((void *)(PAGE_MASK & (unsigned long __force)addr));
> +	generic_iounmap(addr);
>  }
>  EXPORT_SYMBOL(iounmap);
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
