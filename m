Return-Path: <linux-arch+bounces-15315-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB5CAEEE7
	for <lists+linux-arch@lfdr.de>; Tue, 09 Dec 2025 06:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 807143009096
	for <lists+linux-arch@lfdr.de>; Tue,  9 Dec 2025 05:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955819F40B;
	Tue,  9 Dec 2025 05:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dD6UYubF"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94413B8D47;
	Tue,  9 Dec 2025 05:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765257721; cv=none; b=utN8mD9xFW17xnfOfh3bdQQxByk1PlZb0XaqM/dU9rW+/72vNHg1v2LYlSWVfObbVCF9ON0dyPMoBOscMmiLu0gYf9lUoMx0My9Ly3PCfhV9RiBnsApZHBJkBLYGpK0+SqqN8qNCn+bmNJ5LUdCYu3kkQFefeaUNQKy4S4zPyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765257721; c=relaxed/simple;
	bh=Y1ISChCvN4rGF4eHQAR4mbEjh9zxxcl/le19l+rizto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lB9u2BAlTeDCnQ70qi78qqUXFxUoSePtOOboyKEuOGSm/9C9C6yXP2t4zKj28f6KGvZFT7l7MwA7D1qFCfBU+ZwK7xPvO1GszfeSVqrN6taNlnjWld1YgKOFgIMd6ztVa3Q7Zp2M2jBc5kgaKj4KTsqT083JuYfNzCJ/GzTcLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dD6UYubF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=YchsnvWsC4ACnO5+lr7kbAnSRYpvYY5UhD+2GuaQTdk=; b=dD6UYubFJHxnLtUn8tIrYxkw1r
	wEdVJq9UHEp+Ch/s9Y7VGi3Sh//EQloN1yd4t40Hec6cFIcTzcHp7uS19al+qdJuarrKCugZ7+TWI
	JgKLCxZijvh9HdrwtTNWFfQNWyoWd5kMn8/Jv8w4xOQlhjJ3EbG0zKoFZXcntO6TMYKFuTwJXmmkG
	UcT5IxJvOSAA4tTcMryD4cjoGgZWe/6pTEAxW5GeJaWc9UY5+fnf4vru/8irhx3bq9nkBBhnh2czZ
	yYfLMPjlE5xzfu7fmvQOmsUDEfySOVVMb5db3aGT65byqRIFrayRVJXWY3bM5fYnFM//WUMRDAcU8
	NOpn+cPw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSqAg-0000000Dq2a-0MQz;
	Tue, 09 Dec 2025 05:21:58 +0000
Message-ID: <827c75e4-8e6c-4e98-9a1a-80ddba0de61a@infradead.org>
Date: Mon, 8 Dec 2025 21:21:55 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 1/5] PCI: hv: Create and export hv_build_logical_dev_id()
To: Yu Zhang <zhangyu1@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 easwar.hariharan@linux.microsoft.com, jacob.pan@linux.microsoft.com,
 nunodasneves@linux.microsoft.com, mrathor@linux.microsoft.com,
 mhklinux@outlook.com, peterz@infradead.org, linux-arch@vger.kernel.org
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-2-zhangyu1@linux.microsoft.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251209051128.76913-2-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 12/8/25 9:11 PM, Yu Zhang wrote:
> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> 
> Hyper-V uses a logical device ID to identify a PCI endpoint device for
> child partitions. This ID will also be required for future hypercalls
> used by the Hyper-V IOMMU driver.
> 
> Refactor the logic for building this logical device ID into a standalone
> helper function and export the interface for wider use.
> 
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 28 ++++++++++++++++++++--------
>  include/asm-generic/mshyperv.h      |  2 ++
>  2 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 146b43981b27..4b82e06b5d93 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -598,15 +598,31 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>  
>  #define hv_msi_prepare		pci_msi_prepare
>  
> +/**
> + * Build a "Device Logical ID" out of this PCI bus's instance GUID and the
> + * function number of the device.
> + */

Don't use kernel-doc notation "/**" unless you are using kernel-doc comments.
You could just convert it to a kernel-doc style comment...

> +u64 hv_build_logical_dev_id(struct pci_dev *pdev)
> +{

thanks.
-- 
~Randy


