Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD9672B06B
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jun 2023 07:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjFKFrC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Jun 2023 01:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFKFrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Jun 2023 01:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A557C4;
        Sat, 10 Jun 2023 22:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A6AE60B6B;
        Sun, 11 Jun 2023 05:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C92C433D2;
        Sun, 11 Jun 2023 05:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686462419;
        bh=O9j38rKvMVG5O3ukrTC4yMTzG2KbbH0vhzA1Rh1tk+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jd4eumXtF0wx4g8vSY4RHkxq2YVdv4/UgBqrDp+WZoNxtSnkj/905qyCBvJ7Pl0QW
         vGdBlWEBPSd7EbZ7pwNLf7RKBfzrLJqxTjvjxjAdj2HQtA6bo6tOrPnsGF/C3hcNOG
         MBRrovnRwXNEmgik8zw0drVHfVB0YBXjAcaaj6z00BmIKJyG/NyULDnik0RYt7qAcv
         aAwwUyH6wZA2ieLb6yG1PIEQqCRnF0yUNiWPeYcNhdZM/zJQs5Qj8nHkc4PU3QjjxO
         95kPMCBQpSJ20EaMmfjKhppAmyp1gGsGfOuui/+2u7GRuAequjxj5O7/MUZVyZotEW
         OqBrT1vrCwwrg==
Date:   Sun, 11 Jun 2023 08:46:27 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@lst.de, willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v6 09/19] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <20230611054627.GN52412@kernel.org>
References: <20230609075528.9390-1-bhe@redhat.com>
 <20230609075528.9390-10-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609075528.9390-10-bhe@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 09, 2023 at 03:55:18PM +0800, Baoquan He wrote:
> By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> and iounmap() are all visible and available to arch. Arch needs to
> provide wrapper functions to override the generic versions if there's
> arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> This change will simplify implementation by removing duplicated codes
> with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> functioality as before.
> 
> For openrisc, the current ioremap() and iounmap() are the same as
> generic version. After taking GENERIC_IOREMAP way, the old ioremap()
> and iounmap() can be completely removed.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: openrisc@lists.librecores.org

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> v5->v6:
>   Remove iounmap() because it's the same as the generic version since we
>   have removed the code handling ealry mapping from fixmap pool in
>   patch 3 - Mike
> 
>  arch/openrisc/Kconfig          |  1 +
>  arch/openrisc/include/asm/io.h | 11 ++++----
>  arch/openrisc/mm/ioremap.c     | 49 ----------------------------------
>  3 files changed, 7 insertions(+), 54 deletions(-)
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
> index ee6043a03173..5a6f0f16a5ce 100644
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
> @@ -27,11 +29,10 @@
>  #define PIO_OFFSET		0
>  #define PIO_MASK		0
>  
> -#define ioremap ioremap
> -void __iomem *ioremap(phys_addr_t offset, unsigned long size);
> -
> -#define iounmap iounmap
> -extern void iounmap(volatile void __iomem *addr);
> +/*
> + * I/O memory mapping functions.
> + */
> +#define _PAGE_IOREMAP (pgprot_val(PAGE_KERNEL) | _PAGE_CI)
>  
>  #include <asm-generic/io.h>
>  
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index cdbcc7e73684..91c8259d4b7e 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -22,55 +22,6 @@
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
> -void iounmap(volatile void __iomem *addr)
> -{
> -	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
> -}
> -EXPORT_SYMBOL(iounmap);
> -
>  /**
>   * OK, this one's a bit tricky... ioremap can get called before memory is
>   * initialized (early serial console does this) and will want to alloc a page
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
