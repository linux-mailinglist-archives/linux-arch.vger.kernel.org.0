Return-Path: <linux-arch+bounces-11363-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BC5A82BF1
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 18:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3784A1B632A4
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 16:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5401C57B2;
	Wed,  9 Apr 2025 16:03:20 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51A11DE891;
	Wed,  9 Apr 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214599; cv=none; b=AkrugaXGCA9k4xbJYlTG2uL4h4GijofzaTaDubvVK4MY5HYONh7023E4NKd0Cz8X1n8PXX1enU4P+i1U+38m2R7VKwga0nvwTQiWF8NJ7X6oV4oeUEfs/iH8Vi/T7H+5/8+lzZXTG2YvNJ9OX6Te2MMJR5W6Y0tczXLeka5h+eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214599; c=relaxed/simple;
	bh=sxYP4nb4nfqQSxWXYMoiaKdALpRkbmawtaHGeWOAi7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgEkl3A4rTro2WxGIV+w5eI1BUVXFwROA3ZxQgw71+tA4SHunW5oHqMvwwTbbokThVEb71KHwy8gnkpdVAqftFDthSIshdYwhH0Ut74QkfKZKRSEZEIJMSgDO7pjd6bXjFCehkUNy9dVBSm2gqeqejK3lSW7ft9oxJy9R2CrNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52CC115A1;
	Wed,  9 Apr 2025 09:03:15 -0700 (PDT)
Received: from [10.57.72.20] (unknown [10.57.72.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A4F93F59E;
	Wed,  9 Apr 2025 09:03:07 -0700 (PDT)
Message-ID: <0eb87302-fae8-4708-aaf8-d16e836e727f@arm.com>
Date: Wed, 9 Apr 2025 17:03:05 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next 5/6] arch, drivers: Add device struct bitfield
 to not bounce-buffer
To: Roman Kisel <romank@linux.microsoft.com>, aleksander.lobakin@intel.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
 catalin.marinas@arm.com, corbet@lwn.net, dakr@kernel.org,
 dan.j.williams@intel.com, dave.hansen@linux.intel.com, decui@microsoft.com,
 gregkh@linuxfoundation.org, haiyangz@microsoft.com, hch@lst.de,
 hpa@zytor.com, James.Bottomley@HansenPartnership.com,
 Jonathan.Cameron@huawei.com, kys@microsoft.com, leon@kernel.org,
 lukas@wunner.de, luto@kernel.org, m.szyprowski@samsung.com,
 martin.petersen@oracle.com, mingo@redhat.com, peterz@infradead.org,
 quic_zijuhu@quicinc.com, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com, Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
 <20250409000835.285105-6-romank@linux.microsoft.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250409000835.285105-6-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-04-09 1:08 am, Roman Kisel wrote:
> Bounce-buffering makes the system spend more time copying
> I/O data. When the I/O transaction take place between
> a confidential and a non-confidential endpoints, there is
> no other way around.
> 
> Introduce a device bitfield to indicate that the device
> doesn't need to perform bounce buffering. The capable
> device may employ it to save on copying data around.

It's not so much about bounce buffering, it's more fundamentally about 
whether the device is trusted and able to access private memory at all 
or not. And performance is hardly the biggest concern either - if you do 
trust a device to operate on confidential data in private memory, then 
surely it is crucial to actively *prevent* that data ever getting into 
shared SWIOTLB pages where anyone else could also get at it. At worst 
that means CoCo VMs might need an *additional* non-shared SWIOTLB to 
support trusted devices with addressing limitations (and/or 
"swiotlb=force" debugging, potentially).

Also whatever we do for this really wants to tie in with the nascent 
TDISP stuff as well, since we definitely don't want to end up with more 
than one notion of whether a device is in a trusted/locked/private/etc. 
vs. unlocked/shared/etc. state with respect to DMA (or indeed anything 
else if we can avoid it).

Thanks,
Robin.

> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>   arch/x86/mm/mem_encrypt.c  | 3 +++
>   include/linux/device.h     | 8 ++++++++
>   include/linux/dma-direct.h | 3 +++
>   include/linux/swiotlb.h    | 3 +++
>   4 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 95bae74fdab2..6349a02a1da3 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -19,6 +19,9 @@
>   /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>   bool force_dma_unencrypted(struct device *dev)
>   {
> +	if (dev->use_priv_pages_for_io)
> +		return false;
> +
>   	/*
>   	 * For SEV, all DMA must be to unencrypted addresses.
>   	 */
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 80a5b3268986..4aa4a6fd9580 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -725,6 +725,8 @@ struct device_physical_location {
>    * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
>    * @dma_iommu: Device is using default IOMMU implementation for DMA and
>    *		doesn't rely on dma_ops structure.
> + * @use_priv_pages_for_io: Device is using private pages for I/O, no need to
> + *		bounce-buffer.
>    *
>    * At the lowest level, every device in a Linux system is represented by an
>    * instance of struct device. The device structure contains the information
> @@ -843,6 +845,7 @@ struct device {
>   #ifdef CONFIG_IOMMU_DMA
>   	bool			dma_iommu:1;
>   #endif
> +	bool			use_priv_pages_for_io:1;
>   };
>   
>   /**
> @@ -1079,6 +1082,11 @@ static inline bool dev_removable_is_valid(struct device *dev)
>   	return dev->removable != DEVICE_REMOVABLE_NOT_SUPPORTED;
>   }
>   
> +static inline bool dev_priv_pages_for_io(struct device *dev)
> +{
> +	return dev->use_priv_pages_for_io;
> +}
> +
>   /*
>    * High level routines for use by the bus drivers
>    */
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index d7e30d4f7503..b096369f847e 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -94,6 +94,9 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
>    */
>   static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>   {
> +	if (dev_priv_pages_for_io(dev))
> +		return phys_to_dma_unencrypted(dev, paddr);
> +
>   	return __sme_set(phys_to_dma_unencrypted(dev, paddr));
>   }
>   
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..35ee10641b42 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -173,6 +173,9 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
>   {
>   	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>   
> +	if (dev_priv_pages_for_io(dev))
> +		return false;
> +
>   	return mem && mem->force_bounce;
>   }
>   


