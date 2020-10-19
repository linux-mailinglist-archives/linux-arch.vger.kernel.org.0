Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36D729211F
	for <lists+linux-arch@lfdr.de>; Mon, 19 Oct 2020 04:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgJSCZK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Oct 2020 22:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgJSCZK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Oct 2020 22:25:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2036EC0613CE
        for <linux-arch@vger.kernel.org>; Sun, 18 Oct 2020 19:25:10 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p11so4218433pld.5
        for <linux-arch@vger.kernel.org>; Sun, 18 Oct 2020 19:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oycxUIbLy+GIbZrwsw2OQtaFMAps2/oYqPAOhn7npOA=;
        b=nyHrX6Bz4WwkqbqiR/vRLgDN5Nf2qD+eCq/9RPg69Z+QDLI3x3zRHiK2coez0exlv6
         zdHELzx/XATemLh2Q2AzRWCPBzw+46geJ9K+P99PzY2InT4dguRLN6KrFiXrxnkqU4WX
         8yRXFTLV4qkK4Kp1C3xTjMApVgGns6nZYWGsAcMNY6vQIphSydfEX6Ea/dnPK/F9Cur6
         P8CTuTWQ1iWdEkEM0vREzQmH6Z0VEWL746fqxnWZzcNK70UX857l0NwM1ZTpjirWYqzM
         rZROGJ2BE0TI+r/g8IA/2sfI59Uxeuw6+qBVrNvTzkXgb8DMDsVh8DIq4sdg2SHPo6FN
         i7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oycxUIbLy+GIbZrwsw2OQtaFMAps2/oYqPAOhn7npOA=;
        b=NDkkTWQEvJrYym5ZRsKA65i2lslRHbo4YmupgSOx7uND0bMYbDm+CEHdZ7NTW17a6v
         alXNCQdYZEV9/DGBaLdcTwoOjlCwzpszb40pd/eaDI4FMdbMWf7m8qL/CmJnKWDDIJYD
         ngHyhCzSM3LlWUYR79ffjQPw6IgdTaRbUp3mqrJwfZFpUR1cPrBs1iD9wnfiGUccwp/l
         FQFQ12gy5muaH5JpQtGAJxmllE6KlkpijwZXryLF8i46TEDVKfKm9m5KGZdxkY5gJLm+
         AzsbG3EUIqqbjgLZuCwi02q1BvzredkQM/jl+7aV5qcZpSWbLXITysGZURZGSd9VESXk
         EX8Q==
X-Gm-Message-State: AOAM532ONGJCEu53X9B+QE6BgbOVZMtvRuU0b9+Gaj1byG3wLZvrZNJ3
        NYtkXbWl6k/oXezqXwzOx4cbXQ==
X-Google-Smtp-Source: ABdhPJxPKX080BiV5v4tnkaa4400x4k3rK1j5sWpdbJiqRkeH+/9Uq3FM5Vb9dMKmDOh5ZtI6PGX5A==
X-Received: by 2002:a17:902:bb8c:b029:d2:2503:e458 with SMTP id m12-20020a170902bb8cb02900d22503e458mr14936892pls.18.1603074309433;
        Sun, 18 Oct 2020 19:25:09 -0700 (PDT)
Received: from [192.168.10.88] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with UTF8SMTPSA id fh19sm6948594pjb.38.2020.10.18.19.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 19:25:08 -0700 (PDT)
Subject: Re: [PATCH 8/9] dma-mapping: move large parts of <linux/dma-direct.h>
 to kernel/dma
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     linux-arch@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20200930085548.920261-1-hch@lst.de>
 <20200930085548.920261-9-hch@lst.de>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <afaf49d9-5465-4b1a-dac1-91688ba4abbf@ozlabs.ru>
Date:   Mon, 19 Oct 2020 13:25:02 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20200930085548.920261-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 30/09/2020 18:55, Christoph Hellwig wrote:
> Most of the dma_direct symbols should only be used by direct.c and
> mapping.c, so move them to kernel/dma.  In fact more of dma-direct.h
> should eventually move, but that will require more coordination with
> other subsystems.

Because of this change, 
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200713062348.100552-1-aik@ozlabs.ru/ 
does not work anymore.

Should I send a patch moving 
dma_direct_map_sg/dma_direct_map_page/+unmap back to include/ or there 
is a better idea? thanks,


> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-direct.h | 106 ---------------------------------
>   kernel/dma/direct.c        |   2 +-
>   kernel/dma/direct.h        | 119 +++++++++++++++++++++++++++++++++++++
>   kernel/dma/mapping.c       |   2 +-
>   4 files changed, 121 insertions(+), 108 deletions(-)
>   create mode 100644 kernel/dma/direct.h
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 38ed3b55034d50..a2d6640c42c04e 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -120,114 +120,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>   void dma_direct_free_pages(struct device *dev, size_t size,
>   		struct page *page, dma_addr_t dma_addr,
>   		enum dma_data_direction dir);
> -int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		unsigned long attrs);
> -bool dma_direct_can_mmap(struct device *dev);
> -int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		unsigned long attrs);
>   int dma_direct_supported(struct device *dev, u64 mask);
> -bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
> -int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
> -		enum dma_data_direction dir, unsigned long attrs);
>   dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs);
> -size_t dma_direct_max_mapping_size(struct device *dev);
>   
> -#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> -    defined(CONFIG_SWIOTLB)
> -void dma_direct_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
> -		int nents, enum dma_data_direction dir);
> -#else
> -static inline void dma_direct_sync_sg_for_device(struct device *dev,
> -		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
> -{
> -}
> -#endif
> -
> -#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> -    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
> -    defined(CONFIG_SWIOTLB)
> -void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> -		int nents, enum dma_data_direction dir, unsigned long attrs);
> -void dma_direct_sync_sg_for_cpu(struct device *dev,
> -		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
> -#else
> -static inline void dma_direct_unmap_sg(struct device *dev,
> -		struct scatterlist *sgl, int nents, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -}
> -static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
> -		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
> -{
> -}
> -#endif
> -
> -static inline void dma_direct_sync_single_for_device(struct device *dev,
> -		dma_addr_t addr, size_t size, enum dma_data_direction dir)
> -{
> -	phys_addr_t paddr = dma_to_phys(dev, addr);
> -
> -	if (unlikely(is_swiotlb_buffer(paddr)))
> -		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
> -
> -	if (!dev_is_dma_coherent(dev))
> -		arch_sync_dma_for_device(paddr, size, dir);
> -}
> -
> -static inline void dma_direct_sync_single_for_cpu(struct device *dev,
> -		dma_addr_t addr, size_t size, enum dma_data_direction dir)
> -{
> -	phys_addr_t paddr = dma_to_phys(dev, addr);
> -
> -	if (!dev_is_dma_coherent(dev)) {
> -		arch_sync_dma_for_cpu(paddr, size, dir);
> -		arch_sync_dma_for_cpu_all();
> -	}
> -
> -	if (unlikely(is_swiotlb_buffer(paddr)))
> -		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
> -
> -	if (dir == DMA_FROM_DEVICE)
> -		arch_dma_mark_clean(paddr, size);
> -}
> -
> -static inline dma_addr_t dma_direct_map_page(struct device *dev,
> -		struct page *page, unsigned long offset, size_t size,
> -		enum dma_data_direction dir, unsigned long attrs)
> -{
> -	phys_addr_t phys = page_to_phys(page) + offset;
> -	dma_addr_t dma_addr = phys_to_dma(dev, phys);
> -
> -	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
> -		return swiotlb_map(dev, phys, size, dir, attrs);
> -
> -	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> -		if (swiotlb_force != SWIOTLB_NO_FORCE)
> -			return swiotlb_map(dev, phys, size, dir, attrs);
> -
> -		dev_WARN_ONCE(dev, 1,
> -			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
> -			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
> -		return DMA_MAPPING_ERROR;
> -	}
> -
> -	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -		arch_sync_dma_for_device(phys, size, dir);
> -	return dma_addr;
> -}
> -
> -static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	phys_addr_t phys = dma_to_phys(dev, addr);
> -
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
> -
> -	if (unlikely(is_swiotlb_buffer(phys)))
> -		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
> -}
>   #endif /* _LINUX_DMA_DIRECT_H */
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 87697c86f0b82a..bf9f77623022bb 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -7,13 +7,13 @@
>   #include <linux/memblock.h> /* for max_pfn */
>   #include <linux/export.h>
>   #include <linux/mm.h>
> -#include <linux/dma-direct.h>
>   #include <linux/dma-map-ops.h>
>   #include <linux/scatterlist.h>
>   #include <linux/pfn.h>
>   #include <linux/vmalloc.h>
>   #include <linux/set_memory.h>
>   #include <linux/slab.h>
> +#include "direct.h"
>   
>   /*
>    * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use it
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> new file mode 100644
> index 00000000000000..b9861557873768
> --- /dev/null
> +++ b/kernel/dma/direct.h
> @@ -0,0 +1,119 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 Christoph Hellwig.
> + *
> + * DMA operations that map physical memory directly without using an IOMMU.
> + */
> +#ifndef _KERNEL_DMA_DIRECT_H
> +#define _KERNEL_DMA_DIRECT_H
> +
> +#include <linux/dma-direct.h>
> +
> +int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
> +		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +		unsigned long attrs);
> +bool dma_direct_can_mmap(struct device *dev);
> +int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
> +		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +		unsigned long attrs);
> +bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
> +int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
> +		enum dma_data_direction dir, unsigned long attrs);
> +size_t dma_direct_max_mapping_size(struct device *dev);
> +
> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> +    defined(CONFIG_SWIOTLB)
> +void dma_direct_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
> +		int nents, enum dma_data_direction dir);
> +#else
> +static inline void dma_direct_sync_sg_for_device(struct device *dev,
> +		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
> +{
> +}
> +#endif
> +
> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
> +    defined(CONFIG_SWIOTLB)
> +void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> +		int nents, enum dma_data_direction dir, unsigned long attrs);
> +void dma_direct_sync_sg_for_cpu(struct device *dev,
> +		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
> +#else
> +static inline void dma_direct_unmap_sg(struct device *dev,
> +		struct scatterlist *sgl, int nents, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +}
> +static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
> +		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
> +{
> +}
> +#endif
> +
> +static inline void dma_direct_sync_single_for_device(struct device *dev,
> +		dma_addr_t addr, size_t size, enum dma_data_direction dir)
> +{
> +	phys_addr_t paddr = dma_to_phys(dev, addr);
> +
> +	if (unlikely(is_swiotlb_buffer(paddr)))
> +		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
> +
> +	if (!dev_is_dma_coherent(dev))
> +		arch_sync_dma_for_device(paddr, size, dir);
> +}
> +
> +static inline void dma_direct_sync_single_for_cpu(struct device *dev,
> +		dma_addr_t addr, size_t size, enum dma_data_direction dir)
> +{
> +	phys_addr_t paddr = dma_to_phys(dev, addr);
> +
> +	if (!dev_is_dma_coherent(dev)) {
> +		arch_sync_dma_for_cpu(paddr, size, dir);
> +		arch_sync_dma_for_cpu_all();
> +	}
> +
> +	if (unlikely(is_swiotlb_buffer(paddr)))
> +		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
> +
> +	if (dir == DMA_FROM_DEVICE)
> +		arch_dma_mark_clean(paddr, size);
> +}
> +
> +static inline dma_addr_t dma_direct_map_page(struct device *dev,
> +		struct page *page, unsigned long offset, size_t size,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	phys_addr_t phys = page_to_phys(page) + offset;
> +	dma_addr_t dma_addr = phys_to_dma(dev, phys);
> +
> +	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
> +		return swiotlb_map(dev, phys, size, dir, attrs);
> +
> +	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> +		if (swiotlb_force != SWIOTLB_NO_FORCE)
> +			return swiotlb_map(dev, phys, size, dir, attrs);
> +
> +		dev_WARN_ONCE(dev, 1,
> +			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
> +			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
> +		return DMA_MAPPING_ERROR;
> +	}
> +
> +	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		arch_sync_dma_for_device(phys, size, dir);
> +	return dma_addr;
> +}
> +
> +static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	phys_addr_t phys = dma_to_phys(dev, addr);
> +
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
> +
> +	if (unlikely(is_swiotlb_buffer(phys)))
> +		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
> +}
> +#endif /* _KERNEL_DMA_DIRECT_H */
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 335ba183e0956a..51bb8fa8eb8948 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -7,7 +7,6 @@
>    */
>   #include <linux/memblock.h> /* for max_pfn */
>   #include <linux/acpi.h>
> -#include <linux/dma-direct.h>
>   #include <linux/dma-map-ops.h>
>   #include <linux/export.h>
>   #include <linux/gfp.h>
> @@ -15,6 +14,7 @@
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
>   #include "debug.h"
> +#include "direct.h"
>   
>   /*
>    * Managed DMA API
> 

-- 
Alexey
