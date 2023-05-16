Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB428704587
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 08:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjEPGug (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 02:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjEPGud (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 02:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2724C07;
        Mon, 15 May 2023 23:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5C58615FB;
        Tue, 16 May 2023 06:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2BEC433D2;
        Tue, 16 May 2023 06:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684219805;
        bh=7VX2LsKv3PQ0dpUkb9e7oVnaxcn5EXXzhXtXcfTUrdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnB3eh+W1j0NQcaox7doiPd13Fc8F/IiUM4j8VdhBZm20oiEAt6LpIIe9ZXPuuy07
         PpHqPmDqTNuewxCeTKCCrlt8tYZ3F4XKvzogI5hmHVwUE8nXYIMOxQ2QmaSXv4wJBP
         e6tE9Ek/N9ysGgCw4kg26JzP5Q8pT9eMEHEjQcknfCTO03Fy70W5Kz7Z578cqYO3JQ
         LursPVYyRZoQgXFWlwWDxOYsOUNxXGcBFVUuDPgcFbrtmUZ7RSFJ+DLFZHupMO/xJx
         xuWaXCHbvnzFewOzyOSLUPYGHKZ/AeecJHJAnBP53Eik0w6Sn6LFCSnuCJG8DulNny
         9ajILl0m5k9oA==
Date:   Tue, 16 May 2023 09:49:57 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v5 RESEND 09/17] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGMnlZK1/pZIBCud@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-10-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-10-bhe@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Mon, May 15, 2023 at 05:08:40PM +0800, Baoquan He wrote:
> By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> and iounmap() are all visible and available to arch. Arch needs to
> provide wrapper functions to override the generic versions if there's
> arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> This change will simplify implementation by removing duplicated codes
> with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> functioality as before.
> 
> Here, add wrapper function iounmap() for openrisc's special operation
> when iounmap().
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: openrisc@lists.librecores.org
> ---
>  arch/openrisc/Kconfig          |  1 +
>  arch/openrisc/include/asm/io.h | 11 +++++---
>  arch/openrisc/mm/ioremap.c     | 46 +---------------------------------
>  3 files changed, 9 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index c7f282f60f64..fd9bb76a610b 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -21,6 +21,7 @@ config OPENRISC
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_PCI_IOMAP
> +	select GENERIC_IOREMAP
>  	select GENERIC_CPU_DEVICES
>  	select HAVE_PCI
>  	select HAVE_UID16
> diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
> index ee6043a03173..e640960c26c2 100644
> --- a/arch/openrisc/include/asm/io.h
> +++ b/arch/openrisc/include/asm/io.h
> @@ -15,6 +15,8 @@
>  #define __ASM_OPENRISC_IO_H
>  
>  #include <linux/types.h>
> +#include <asm/pgalloc.h>
> +#include <asm/pgtable.h>
>  
>  /*
>   * PCI: We do not use IO ports in OpenRISC
> @@ -27,11 +29,12 @@
>  #define PIO_OFFSET		0
>  #define PIO_MASK		0
>  
> -#define ioremap ioremap
> -void __iomem *ioremap(phys_addr_t offset, unsigned long size);
> -
> +/*
> + * I/O memory mapping functions.
> + */
>  #define iounmap iounmap
> -extern void iounmap(volatile void __iomem *addr);
> +
> +#define _PAGE_IOREMAP (pgprot_val(PAGE_KERNEL) | _PAGE_CI)
>  
>  #include <asm-generic/io.h>
>  
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index 90b59bc53c8c..9f9941df7d4c 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -22,49 +22,6 @@
>  
>  extern int mem_init_done;
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
> -void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
> -{
> -	phys_addr_t p;
> -	unsigned long v;
> -	unsigned long offset, last_addr;
> -	struct vm_struct *area = NULL;
> -
> -	/* Don't allow wraparound or zero size */
> -	last_addr = addr + size - 1;
> -	if (!size || last_addr < addr)
> -		return NULL;
> -
> -	/*
> -	 * Mappings have to be page-aligned
> -	 */
> -	offset = addr & ~PAGE_MASK;
> -	p = addr & PAGE_MASK;
> -	size = PAGE_ALIGN(last_addr + 1) - p;
> -
> -	area = get_vm_area(size, VM_IOREMAP);
> -	if (!area)
> -		return NULL;
> -	v = (unsigned long)area->addr;
> -
> -	if (ioremap_page_range(v, v + size, p,
> -			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
> -		vfree(area->addr);
> -		return NULL;
> -	}
> -
> -	return (void __iomem *)(offset + (char *)v);
> -}
> -EXPORT_SYMBOL(ioremap);
> -
>  void iounmap(volatile void __iomem *addr)
>  {
>  	/* If the page is from the fixmap pool then we just clear out

The page cannot be from fixmap pool since we removed fixmap support from
ioremap in an earlier patch.
I believe that patch should also remove special casing of fixmap in
iounmap() and then openrisc does not need to override any of ioremap
methods.

> @@ -88,9 +45,8 @@ void iounmap(volatile void __iomem *addr)
>  		return;
>  	}
>  
> -	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
> +	generic_iounmap(addr);
>  }
> -EXPORT_SYMBOL(iounmap);
>  
>  /**
>   * OK, this one's a bit tricky... ioremap can get called before memory is
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
