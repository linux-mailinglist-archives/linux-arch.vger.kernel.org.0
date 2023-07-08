Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A03F74BA93
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jul 2023 02:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGHAdb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jul 2023 20:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjGHAda (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2023 20:33:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3051BF5;
        Fri,  7 Jul 2023 17:33:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-314417861b9so2598264f8f.0;
        Fri, 07 Jul 2023 17:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688776407; x=1691368407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=blTNE5LO7YyFeZT8Qi4VxrAELo4nV45IRw/nlx7k0yw=;
        b=gqDiZ4Yu/zOVBSWjvqSKCXSdeLUwpGl5K4w1TULo5zJy3gfFpxOC6IzriDWVaMIVcS
         tBK+rcV6Mhhs2RS3cT6w188IQJfjEShq2kw3o1aYi43lNNz7LhdCWLqpYbvMorY1weF1
         cxK9oy9MVoqD+bwZLE4R+TdlmFbfb/F5VPfzwpSEqRj1lwiSGWcLYChH+zvjnYc/V8vO
         b3TUpaKljoJ9zFH/MKevxpFx0IXRrXC/1AJl3xf05KgckuJNXVfeQP3Ych73TFtszGKB
         4wgekWWBdR1IhDeE3+EQahXmibXegxBIeTaWeOaaOshWKrg7KT4CkhSD9gzV7lsG1TDk
         GZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688776407; x=1691368407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blTNE5LO7YyFeZT8Qi4VxrAELo4nV45IRw/nlx7k0yw=;
        b=EXb6NYt9sf/uhSyaS8dnPoI9qWF59l3643WQKyhhpA6zO5WSMRUcv/8P+0j0Wv8Ufm
         O/gFUAuRLdND17pVuHB49g403l8wPrK0CM/k4xUYfi6JNCuc+W0psHll37QhnBx6cW+U
         xfZVbHbU9jh1hRQSk5jaRJqvMIAvSj5SOKYErnD5iQzNC+rH/PknbvTjMtHVN0IzaLSD
         8fi4wA2CHczDBSvnnb6LtksARqZOBBaxrNAYhJRtnw3Hiu0pSR25YS+Djp+bZWWyCA7E
         h70A3zWCHA1oHaq26G+dnihZ9eeTsRLmIlBUGdnItmJbAMw6bsHATx3jZNsluC/AF21d
         U+YA==
X-Gm-Message-State: ABy/qLZSflin5HbjrrZVctROpItEmutwKjabm1pJemBhvycdoVss2IfN
        g41toLMY/wgiCqzPP/uTN3iw8HXbD4BaX+Gb
X-Google-Smtp-Source: APBJJlFbxGp9ywXlUDVJkA+GQPoOU92fZ9LH17UbGO+iSwV9v1HefzM3DaG83y3UzMhuKGrCVgDe8g==
X-Received: by 2002:a5d:6d49:0:b0:313:f61c:42b2 with SMTP id k9-20020a5d6d49000000b00313f61c42b2mr5143685wri.69.1688776407259;
        Fri, 07 Jul 2023 17:33:27 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d4ed0000000b0031411e46af3sm5613028wrv.97.2023.07.07.17.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:33:26 -0700 (PDT)
Date:   Sat, 8 Jul 2023 01:33:26 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, hch@lst.de,
        christophe.leroy@csgroup.eu, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v7 09/19] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZKiu1hjMPHRTYBLy@antec>
References: <20230620131356.25440-1-bhe@redhat.com>
 <20230620131356.25440-10-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620131356.25440-10-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 20, 2023 at 09:13:46PM +0800, Baoquan He wrote:
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
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: openrisc@lists.librecores.org
> ---
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

Hello,

Thanks for the patch, I was able to test this booting openrisc and running a few
glibc tests and see no issues.  Also the code cleanup looks good to me.

Acked-by: Stafford Horne <shorne@gmail.com>

>  /**
>   * OK, this one's a bit tricky... ioremap can get called before memory is
>   * initialized (early serial console does this) and will want to alloc a page
> -- 
> 2.34.1
> 
