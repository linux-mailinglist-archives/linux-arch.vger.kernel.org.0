Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F7A704590
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 08:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjEPGve (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 02:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjEPGvc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 02:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCDB469E;
        Mon, 15 May 2023 23:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 134A061FC5;
        Tue, 16 May 2023 06:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EEBC433EF;
        Tue, 16 May 2023 06:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684219859;
        bh=6Eaba1tYS8F2upbZM0WOM8A9kKwNYGFfbZSTGo3G8Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlsIFNrcAThE+0HymG4wSsavx8Mh/N2D5jY0hq3HKRbOWkQchd4y92JRocOqinfwh
         M/HRBW0dBRf3OR53P8opoVdeEqDqa6gT20rIRgOFmkdQCDbTrNGSm5nPuJHNtsTGPs
         jkV+ozKwlOJrWhuYQVK2cCNZj3V2pHz/8HS6d5cfN7Je2EeKVwr2X1OUaiNT5xfUnD
         bz09dpO5blch+nd8XqFWDvKNhuEoNpVoh45k08uXQWYeUKzaniMdOmjdhRHPA72LYn
         L2M6LzUjhUsv4QT45OAseO63USa1EY+m3u12Met+Twj+ZQB2Ebg9vHl9H5DLSlzc+w
         yZ2ph5fQQPQaA==
Date:   Tue, 16 May 2023 09:50:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 10/17] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGMnyk4l6Id1flpN@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-11-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-11-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:41PM +0800, Baoquan He wrote:
> By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> and iounmap() are all visible and available to arch. Arch needs to
> provide wrapper functions to override the generic versions if there's
> arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> This change will simplify implementation by removing duplicated codes
> with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> functioality as before.
> 
> Here, add wrapper functions ioremap_prot() and iounmap() for s390's
> special operation when ioremap() and iounmap().
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/s390/Kconfig          |  1 +
>  arch/s390/include/asm/io.h | 21 ++++++++------
>  arch/s390/pci/pci.c        | 57 +++++++-------------------------------
>  3 files changed, 23 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index db20c1589a98..f33923fa8c99 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -142,6 +142,7 @@ config S390
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_TIME_VSYSCALL
>  	select GENERIC_VDSO_TIME_NS
> +	select GENERIC_IOREMAP if PCI
>  	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_JUMP_LABEL
> diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
> index e3882b012bfa..4453ad7c11ac 100644
> --- a/arch/s390/include/asm/io.h
> +++ b/arch/s390/include/asm/io.h
> @@ -22,11 +22,18 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
>  
>  #define IO_SPACE_LIMIT 0
>  
> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
> -void __iomem *ioremap(phys_addr_t addr, size_t size);
> -void __iomem *ioremap_wc(phys_addr_t addr, size_t size);
> -void __iomem *ioremap_wt(phys_addr_t addr, size_t size);
> -void iounmap(volatile void __iomem *addr);
> +/*
> + * I/O memory mapping functions.
> + */
> +#define ioremap_prot ioremap_prot
> +#define iounmap iounmap
> +
> +#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL)
> +
> +#define ioremap_wc(addr, size)  \
> +	ioremap_prot((addr), (size), pgprot_val(pgprot_writecombine(PAGE_KERNEL)))
> +#define ioremap_wt(addr, size)  \
> +	ioremap_prot((addr), (size), pgprot_val(pgprot_writethrough(PAGE_KERNEL)))
>  
>  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
>  {
> @@ -51,10 +58,6 @@ static inline void ioport_unmap(void __iomem *p)
>  #define pci_iomap_wc pci_iomap_wc
>  #define pci_iomap_wc_range pci_iomap_wc_range
>  
> -#define ioremap ioremap
> -#define ioremap_wt ioremap_wt
> -#define ioremap_wc ioremap_wc
> -
>  #define memcpy_fromio(dst, src, count)	zpci_memcpy_fromio(dst, src, count)
>  #define memcpy_toio(dst, src, count)	zpci_memcpy_toio(dst, src, count)
>  #define memset_io(dst, val, count)	zpci_memset_io(dst, val, count)
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index afc3f33788da..d34d5813d006 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -244,62 +244,25 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
>         zpci_memcpy_toio(to, from, count);
>  }
>  
> -static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   unsigned long prot)
>  {
> -	unsigned long offset, vaddr;
> -	struct vm_struct *area;
> -	phys_addr_t last_addr;
> -
> -	last_addr = addr + size - 1;
> -	if (!size || last_addr < addr)
> -		return NULL;
> -
> +	/*
> +	 * When PCI MIO instructions are unavailable the "physical" address
> +	 * encodes a hint for accessing the PCI memory space it represents.
> +	 * Just pass it unchanged such that ioread/iowrite can decode it.
> +	 */
>  	if (!static_branch_unlikely(&have_mio))
> -		return (void __iomem *) addr;
> +		return (void __iomem *)phys_addr;
>  
> -	offset = addr & ~PAGE_MASK;
> -	addr &= PAGE_MASK;
> -	size = PAGE_ALIGN(size + offset);
> -	area = get_vm_area(size, VM_IOREMAP);
> -	if (!area)
> -		return NULL;
> -
> -	vaddr = (unsigned long) area->addr;
> -	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
> -		free_vm_area(area);
> -		return NULL;
> -	}
> -	return (void __iomem *) ((unsigned long) area->addr + offset);
> -}
> -
> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
> -{
> -	return __ioremap(addr, size, __pgprot(prot));
> +	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
>  }
>  EXPORT_SYMBOL(ioremap_prot);
>  
> -void __iomem *ioremap(phys_addr_t addr, size_t size)
> -{
> -	return __ioremap(addr, size, PAGE_KERNEL);
> -}
> -EXPORT_SYMBOL(ioremap);
> -
> -void __iomem *ioremap_wc(phys_addr_t addr, size_t size)
> -{
> -	return __ioremap(addr, size, pgprot_writecombine(PAGE_KERNEL));
> -}
> -EXPORT_SYMBOL(ioremap_wc);
> -
> -void __iomem *ioremap_wt(phys_addr_t addr, size_t size)
> -{
> -	return __ioremap(addr, size, pgprot_writethrough(PAGE_KERNEL));
> -}
> -EXPORT_SYMBOL(ioremap_wt);
> -
>  void iounmap(volatile void __iomem *addr)
>  {
>  	if (static_branch_likely(&have_mio))
> -		vunmap((__force void *) ((unsigned long) addr & PAGE_MASK));
> +		generic_iounmap(addr);
>  }
>  EXPORT_SYMBOL(iounmap);
>  
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
