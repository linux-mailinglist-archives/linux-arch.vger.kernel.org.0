Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26867F3300
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2019 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbfKGP3M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Nov 2019 10:29:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44827 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388761AbfKGP3L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Nov 2019 10:29:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id az9so861246plb.11
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 07:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=celw7kLC34qqwTTfh++uCkQEjOgc/6nwF8dFF2fJRcA=;
        b=noW+GrgCtBbtWmvRliYdOAuMA0YUG7D+eX91HjAU5IDNU+EBOcrbt42dkubqBTxW4S
         WQ8n2ZfnbmfCL4+eE6s1MnG4kJG52VZJ91QbzuQNFIi/COPg+DrUHbZ8+Jcgjj/Q48Re
         QNX4NY1E7vtLM68r6rfozcc3RNzkIItLOE7o9jhPPrBLVYCbQcAaXYdiCcQx1PUOZm7u
         oSAbYZ4+XOAXy2q29Df881Gyse5LGoGTyAaPv6aJ5raeRYhtrrpUAm1qesZ/YD4XWer0
         OQ5NPy7zRFp9dt0jb2kjIPuYcQwfIBFil4fTrnHBnYJ1ukrYml+utoouUC2biDI7it8K
         q8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=celw7kLC34qqwTTfh++uCkQEjOgc/6nwF8dFF2fJRcA=;
        b=WEMmx44LiMq3Ewm+TOUGpIFeIgfA50pln1jaIyD/XR8RXc3g8wkVDGuH9s3DDmOYFY
         9NvKx5M6xafBhP8KodHhccgUL3BZyEQpWt4mf/DRiz+xL/bd8zqO8/RyA5WcM7AwEodl
         xk5YQ6yfqtRRhxOLEWlt0hVkMcgMxaDjjr0Df2rfMrSreAnRe12Dh6FQbn3ZBkTKUHbM
         qhWhhSn9qVRhA98UOzlhHx0jMEkvdSpAWHmWBFb3vwVqaDRCARuZUYg7A65UjKXnpMA0
         Qp1nODYbsGXHda3j+Mfepf1nrGadEDIm+8wdhqP6ziadpxodief445cCPK0OveDwlZk9
         FTTg==
X-Gm-Message-State: APjAAAUGMwgNloaf8Utg6dpAcDdW5VBtE4/Ty2qClSNFfvE9gkoQYO/7
        OEvUStBgZgq/6H7KZRdD550nSg==
X-Google-Smtp-Source: APXvYqxwW3UXdXBa6cGLkWhsyLfBz9Kw3ES1wGdovuqY/c7cBz2zbKIbrHc7CxUnNtedCkwAnHzZJw==
X-Received: by 2002:a17:90a:174a:: with SMTP id 10mr5875131pjm.104.1573140550559;
        Thu, 07 Nov 2019 07:29:10 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r10sm2405827pgn.68.2019.11.07.07.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 07:29:10 -0800 (PST)
Date:   Thu, 07 Nov 2019 07:29:10 -0800 (PST)
X-Google-Original-Date: Wed, 06 Nov 2019 10:45:31 PST (-0800)
Subject:     Re: [PATCH 17/21] lib: provide a simple generic ioremap implementation
In-Reply-To: <20191029064834.23438-18-hch@lst.de>
CC:     Arnd Bergmann <arnd@arndb.de>, guoren@kernel.org, monstr@monstr.eu,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-e96b8613-e384-4e94-90f8-d1cf78c5627a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 28 Oct 2019 23:48:30 PDT (-0700), Christoph Hellwig wrote:
> A lot of architectures reuse the same simple ioremap implementation, so
> start lifting the most simple variant to lib/ioremap.c.  It provides
> ioremap_prot and iounmap, plus a default ioremap that uses prot_noncached,
> although that can be overridden by asm/io.h.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/asm-generic/io.h | 20 ++++++++++++++++----
>  lib/Kconfig              |  3 +++
>  lib/ioremap.c            | 39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 4 deletions(-)
>
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 4e45e1cb6560..4a661fdd1937 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -923,9 +923,10 @@ static inline void *phys_to_virt(unsigned long address)
>   * DOC: ioremap() and ioremap_*() variants
>   *
>   * Architectures with an MMU are expected to provide ioremap() and iounmap()
> - * themselves.  For NOMMU architectures we provide a default nop-op
> - * implementation that expect that the physical address used for MMIO are
> - * already marked as uncached, and can be used as kernel virtual addresses.
> + * themselves or rely on GENERIC_IOREMAP.  For NOMMU architectures we provide
> + * a default nop-op implementation that expect that the physical address used
> + * for MMIO are already marked as uncached, and can be used as kernel virtual
> + * addresses.
>   *
>   * ioremap_wc() and ioremap_wt() can provide more relaxed caching attributes
>   * for specific drivers if the architecture choses to implement them.  If they
> @@ -946,7 +947,18 @@ static inline void iounmap(void __iomem *addr)
>  {
>  }
>  #endif
> -#endif /* CONFIG_MMU */
> +#elif defined(CONFIG_GENERIC_IOREMAP)
> +#include <asm/pgtable.h>
> +
> +void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
> +void iounmap(volatile void __iomem *addr);
> +
> +static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
> +{
> +	/* _PAGE_IOREMAP needs to be supplied by the architecture */
> +	return ioremap_prot(addr, size, _PAGE_IOREMAP);
> +}
> +#endif /* !CONFIG_MMU || CONFIG_GENERIC_IOREMAP */
>
>  #ifndef ioremap_nocache
>  #define ioremap_nocache ioremap
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 183f92a297ca..afc78aaf2b25 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -638,6 +638,9 @@ config STRING_SELFTEST
>
>  endmenu
>
> +config GENERIC_IOREMAP
> +	bool
> +
>  config GENERIC_LIB_ASHLDI3
>  	bool
>
> diff --git a/lib/ioremap.c b/lib/ioremap.c
> index 0a2ffadc6d71..3f0e18543de8 100644
> --- a/lib/ioremap.c
> +++ b/lib/ioremap.c
> @@ -231,3 +231,42 @@ int ioremap_page_range(unsigned long addr,
>
>  	return err;
>  }
> +
> +#ifdef CONFIG_GENERIC_IOREMAP
> +void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
> +{
> +	unsigned long offset, vaddr;
> +	phys_addr_t last_addr;
> +	struct vm_struct *area;
> +
> +	/* Disallow wrap-around or zero size */
> +	last_addr = addr + size - 1;
> +	if (!size || last_addr < addr)
> +		return NULL;
> +
> +	/* Page-align mappings */
> +	offset = addr & (~PAGE_MASK);
> +	addr -= offset;
> +	size = PAGE_ALIGN(size + offset);
> +
> +	area = get_vm_area_caller(size, VM_IOREMAP,
> +			__builtin_return_address(0));
> +	if (!area)
> +		return NULL;
> +	vaddr = (unsigned long)area->addr;
> +
> +	if (ioremap_page_range(vaddr, vaddr + size, addr, __pgprot(prot))) {
> +		free_vm_area(area);
> +		return NULL;
> +	}
> +
> +	return (void __iomem *)(vaddr + offset);
> +}
> +EXPORT_SYMBOL(ioremap_prot);
> +
> +void iounmap(volatile void __iomem *addr)
> +{
> +	vunmap((void *)((unsigned long)addr & PAGE_MASK));
> +}
> +EXPORT_SYMBOL(iounmap);
> +#endif /* CONFIG_GENERIC_IOREMAP */

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>

Thanks!  This should let us get rid of arch/riscv/mm/ioremap.c.
