Return-Path: <linux-arch+bounces-5728-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E79A941387
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 15:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278AC1F2507C
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3711A08A0;
	Tue, 30 Jul 2024 13:48:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D52319FA92;
	Tue, 30 Jul 2024 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347314; cv=none; b=XVCB5OrAbqAQFT2SZcZ7uREFTkePNMF9yiQcXIrsdTFv86MFEOS1BIZoWV0kIES9PX9tvMKSc6XofJySy8i2MC81IwZm4l8LMXGuTfnp6c9yXggZnm/7JJo46EHggWImdWjKRaMa2HGS7sEyVs5+ekK9cHyxE2ttImCMR78Dcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347314; c=relaxed/simple;
	bh=U85CGb9iXVNpcxFNKqQSP4h3se4004m4qgotfyoFwbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5btOX4zNOVewQ8N17dTKmSXwhP+ahEJJt9FJ/4w9m/17rQeq1FLeYd5eeiLGa/lfaFjNo+o8JTPKhmZdRapA+UR8Sn5fJCl1xcd8Lw2QbVPOq9Tt0H9LyzlrkrMBI7jp+XcRCLpyPO7Y7E70WNWi1Ah4h3+FiekG389AIM1hiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 668071007;
	Tue, 30 Jul 2024 06:48:56 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F13E83F5A1;
	Tue, 30 Jul 2024 06:48:27 -0700 (PDT)
Message-ID: <dc2a28b6-566c-4c17-9834-874513f1d4f1@arm.com>
Date: Tue, 30 Jul 2024 14:48:21 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 24/37] kvx: Add memory management
To: Christoph Hellwig <hch@infradead.org>, ysionneau@kalrayinc.com
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Clement Leger <clement@clement-leger.fr>,
 Guillaume Thouvenin <thouveng@gmail.com>,
 Jean-Christophe Pince <jcpince@gmail.com>,
 Jules Maselbas <jmaselbas@zdiv.net>, Julien Hascoet
 <jhascoet@kalrayinc.com>, Louis Morhet <lmorhet@kalrayinc.com>,
 =?UTF-8?Q?Marc_Poulhi=C3=A8s?= <dkm@kataplop.net>,
 Marius Gligor <mgligor@kalrayinc.com>,
 Vincent Chardon <vincent.chardon@elsys-design.com>,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-25-ysionneau@kalrayinc.com>
 <Zp5zrkwyagnkoY7F@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Zp5zrkwyagnkoY7F@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/07/2024 3:58 pm, Christoph Hellwig wrote:
>> +#include "../../../drivers/iommu/dma-iommu.h"
> 
> This is not a public header as you can guess from the file path.
> 
>> +	switch (dir) {
>> +	case DMA_TO_DEVICE:
>> +		break;
>> +	case DMA_FROM_DEVICE:
>> +		break;
>> +
>> +	case DMA_BIDIRECTIONAL:
>> +		inval_dcache_range(paddr, size);
> 
> Doing this just for bidirectional is weird unless your architecture
> never does any speculative prefetching.  Other architectures
> include DMA_FROM_DEVICE here.
> 
>> +#ifdef CONFIG_IOMMU_DMA
>> +void arch_teardown_dma_ops(struct device *dev)
>> +{
>> +	dev->dma_ops = NULL;
>> +}
>> +#endif /* CONFIG_IOMMU_DMA*/
> 
> This should not be needed right now.

More than that, per 8b80549f1bc6, it's now actually a latent bug.

>  And will be completley
> useless once we do the direct calls to dma-iommu which we plan
> to do for Linux 6.12.
> 
>> +void arch_setup_dma_ops(struct device *dev, bool coherent)
>> +{
>> +	dev->dma_coherent = coherent;
>> +	if (device_iommu_mapped(dev))
>> +		iommu_setup_dma_ops(dev);
>> +}
> 
> And this seems odd, as iommu_setup_dma_ops is called from the iommu
> code and you shouldn't need it here.

Yeah, this smells like it was based on the old arm64 code, but then 
rebased without reference to the equivalent arm64 changes, hence the 
#include hack. Enabling iommu-dma for an architecture should now be a 
one-liner in drivers/iommu/Kconfig, however I don't see an IOMMU driver 
being added in this series so it's not clear it's actually necessary (yet).

Thanks,
Robin.

