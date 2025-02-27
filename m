Return-Path: <linux-arch+bounces-10428-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62150A48468
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 17:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D404918951CB
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D2D19F10A;
	Thu, 27 Feb 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YDmBIf3V"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0ED19C57C;
	Thu, 27 Feb 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672166; cv=none; b=kotlZfeUl12C+/ivOk3dnUamD3vZyH/eiKu7ZFvT21iYHP/QydUuVV5mPLpcCBeKLTDVkiqI7CPCvaD9ZVZV/V/8xSSHUoRwrUE2VdTcLihTH+aRX1D6pexHLF38KDStkaLE8PE2Y/yQKHI5w2Ts15fL6ALf3e3YTaeJ4GfP1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672166; c=relaxed/simple;
	bh=RFl2o37WVKCpXjjZioydmxS1a7oCxw26tEAC3SJ6bFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuksfX4ygY6Xf98QM5EWF3fj2I82E6qbtP/UfUgacnPYfAc2Fj9+H080WRwsR/TVWx7wJXfWL+ClSkq7UCELsRBDdY60k3bE+4lrx0mCiud3gVetL82Xamt24ZaxvaA4UyVvpI2ouO/XhumQkQ22UEJMzroVL80e9S6r0PJOgBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YDmBIf3V; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ECDEB40E0202;
	Thu, 27 Feb 2025 16:02:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7vNDSrtYzXsR; Thu, 27 Feb 2025 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740672156; bh=FUZpHDr4StgHr+/B0BvhYI7K2GkGl5sit6N8LUylnSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDmBIf3VPJ/AzvjLAt7ulTJSyvWP3TrND3nM3FTp8uM3qLAs2bIl8ejzn5OaWXpxa
	 YLDt4O4V8ilXogR6DZlzQKbkRCy5OvqRms/DgGRubj3SCIXG+NDrtGjmAdztORJ76o
	 jnTo3q7a3j+1YsPyAWh396spuDhLMoraz8hICqSiVxpXv//tdyscstmlX4K5ElCyUC
	 Fo5wXtgzT2Gcogpirx0i6zn+JJ4OVUFCh+xs/ssOG1WmVNaSLEyCw+ukiO7C9BYR/U
	 k0RNsQy8gzN9FuFb9ogOTLp6XlVDnYTAqTdxD6i2Rcvl7S+ElZ8fnXQpvdHwc8Yuz6
	 7OhoP5y0nN6SNR4qzLOQgoZO/8da+r6rH02HIj334MvqkfPbIq33QogIrhpX2J2pI+
	 cBQ0wMg/l3zy6OmK+3fUYri3TpAqGzhksTsprK5NoYgEKfoSzQb2DAa6yjc8sxHN8a
	 i0cftrHa8BLifDvDIFfSqikRd/4i1DFBqgVM0WmR/Pas6XyYIFd53elX0/WnlrxgPt
	 jy4H+dAXmy2cJyuCkHjAEfafgAmmJvYCKPqnqd7MjlGbzPJYMcyZ7HqaBsH3YbiCFg
	 U2PuqxLAkp49Qig8WQuZKqfCLnpFVRLIBRCJK9s8dsnrR/9Qu7ad1uB5gu1MISGABz
	 Juk4iWe2stm872WWu6WazSDw=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B97E40E0200;
	Thu, 27 Feb 2025 16:02:01 +0000 (UTC)
Date: Thu, 27 Feb 2025 17:01:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 20/22] sev-guest: Stop changing encrypted page
 state for TDISP devices
Message-ID: <20250227160155.GCZ8CMcz5sQnKotIME@fat_crate.local>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-21-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-21-aik@amd.com>

On Tue, Feb 18, 2025 at 10:10:07PM +1100, Alexey Kardashevskiy wrote:
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index d7e30d4f7503..3bd533d2e65d 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -94,6 +94,14 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
>   */
>  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
> +#if defined(CONFIG_TSM_GUEST) || defined(CONFIG_TSM_GUEST_MODULE)
> +	if (dev->tdi_enabled) {
> +		dev_warn_once(dev, "(TIO) Disable SME");
> +		if (!dev->tdi_validated)
> +			dev_warn(dev, "TDI is not validated, DMA @%llx will fail", paddr);
> +		return phys_to_dma_unencrypted(dev, paddr);
> +	}
> +#endif
>  	return __sme_set(phys_to_dma_unencrypted(dev, paddr));
>  }
>  
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..67bea31fa42a 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -173,6 +173,14 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
>  {
>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>  
> +#if defined(CONFIG_TSM_GUEST) || defined(CONFIG_TSM_GUEST_MODULE)
> +	if (dev->tdi_enabled) {
> +		dev_warn_once(dev, "(TIO) Disable SWIOTLB");
> +		if (!dev->tdi_validated)
> +			dev_warn(dev, "TDI is not validated");
> +		return false;
> +	}
> +#endif
>  	return mem && mem->force_bounce;
>  }
>  
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 95bae74fdab2..c9c99154bec9 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -19,6 +19,12 @@
>  /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>  bool force_dma_unencrypted(struct device *dev)
>  {
> +#if defined(CONFIG_TSM_GUEST) || defined(CONFIG_TSM_GUEST_MODULE)
> +	if (dev->tdi_enabled) {
> +		dev_warn_once(dev, "(TIO) Disable decryption");
> +		return false;
> +	}
> +#endif

Duplicated code with ugly ifdeffery. Perhaps do a helper which you call
everywhere instead?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

