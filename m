Return-Path: <linux-arch+bounces-11300-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5202A7E70F
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 18:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE891663E1
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C891FDA83;
	Mon,  7 Apr 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C1e9a7Rl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268D20E03A
	for <linux-arch@vger.kernel.org>; Mon,  7 Apr 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044013; cv=none; b=cE2v1RWXzxLEyCjHJCoKbUEMBUZMfOuP62B4UzsKz8MgynPfcNoiDO69FTnjmPra7zeZ32qIJxp+rS+ZDwNhOtOIP6xr5shZq4tNvTeWvegUCpUVvEeh5nwiS+xizBGm3EyVlN6yHbYzk+jcirTuXDY8Xst2itvw8PQJ4ihAL1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044013; c=relaxed/simple;
	bh=xekbj8Um5XwrEOGdzENZPa2iQeQhDeMvkZT0NVb5BK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFQZveSpZQSa3lo2GNFCanl9OYxBIxYo/HRmvFpmat4DxTy+HC0FD69j/1oRB70JL5Mm7suPPh2Jak3jIuDbGy4NLeeAcq9VJs4W5VR+RxOZizMFtc8WOBvXAGCwtgeJ3Q9WOcqgZdKPik8wCMhqmbnUXZ6Eni87Xb5/00B02FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C1e9a7Rl; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c592764e24so501352285a.0
        for <linux-arch@vger.kernel.org>; Mon, 07 Apr 2025 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744044011; x=1744648811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVaiHAMacLy0yHf6meYzZ4WkOGggIQHdshTAyck4dh4=;
        b=C1e9a7RlDnHM1HSLQZ5q8CNKgVYLTqgByhvy9WMxUJRN581QJO0J+rvZli6pcgyuMe
         5x/L9DLnre5qvLPL5k5U9nmgJHaHr8q9l1/zwNTnFpGVRYulzqA8D4D/OXVoMOxkDgdz
         vNsIxXM2KegZvo48VvlijiqqbTA7Dfhy/dkzRA6yp2EAAnp6x16CF3JkwqsD44nLtG3o
         FsxD2OY/lGWRmlsYbVwcbPTKuAhsUyE10NIZ40gkK8l4dwIjH+fcSTybgCImC74fgk57
         rGIff4B4Vn0IHEYEv+B4NXhPIYkaPyW0kTvRsSciPf4oXRWlj0J7czCO8jjf45rgRLKh
         9wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744044011; x=1744648811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVaiHAMacLy0yHf6meYzZ4WkOGggIQHdshTAyck4dh4=;
        b=ep18WqlkkULpmq+4OM3ryHv0rj+/hwBgZgw2VuvrAXXysdCcviN6L6UJfgW8cyXJrP
         cHgPDHF2XNLOvea+4DwsZfSXSoYx6AbAX4XYy7nL1uy6tMhuTz6GpgOZ7ZD8vlAX2x7U
         aUHNSx3WU5mjTsk90zfBcU38SfI3/5+65rWgGIhvkIqH6Y800kPOew5ZIYXq/6K0unP2
         n8BZLKiKuoWnYS0XSFTzprsU8LEo9mRH8b3OOJwHrrc30g6U6AMtFaP9SATNtL0DAvcx
         f0JsGUDfuzAmfdIMT82rjPO3BjFCYpBB2qyR97JvqtFd4FJhXVxLOcbrVojqjBzeNGoU
         wmFw==
X-Forwarded-Encrypted: i=1; AJvYcCXRTG0TN3wt7XBOOfD8XfLk5eTqZv3yMBAB+SaFNl3JBpNqpDGro/homcDnlsnrTl5LVx9UJB6j1vdo@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCfEdW/C4Y+khUqRZxux1qH0b4W2zh1f4O1Jrl1xZ444KfGdP
	s2Hgmtum3wuNql5Vw/US27n5elGWO64zc0NFLHea+GMq39Papwwdd+yjMQG5HKE=
X-Gm-Gg: ASbGnctlmdZs1TP6RGGq+bFHpu6qeEPnB++d5+z9oLSYxZDDOlC+d85Vb+rWKuJ+fzg
	0xUML+EBFpU8FUUAHFon5AZsinBXwJd2/dIyVGczUo9kSDtw3lJ3wx5UoR+RDTRndi6OhPxiA6h
	LKWlhF2AWD2lSyd4fC1Tc/c+hsoTUmBg85SE5EhY4iJLtsW7lKDaOZs9woYKVU8ImqBtz34mPtv
	8W1TpavlVsKup/M89OF26Jjc6p9DNeayfAjrKXPGbjhR49xV3LXWXgycuX4bz9k7r72v127Qv/r
	9s32YGhKlif/JJ667WySd0ortHZqw7p1J3sZuLbj54N+kkW98jy4wk201rhvuIsi8VzYmyFT4Db
	n3Kql64tW4mOBYH/VtJqXEXI=
X-Google-Smtp-Source: AGHT+IEFf/klcawRT/DLAKNVY/s1kWSMw+u/XuSys5u9G30IOfriJNNXl5A9JC2j6VoZritBscM43A==
X-Received: by 2002:a05:620a:25c8:b0:7c0:ad47:db3d with SMTP id af79cd13be357-7c7940ba2a0mr22422685a.21.1744044010744;
        Mon, 07 Apr 2025 09:40:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e96e870sm618914485a.60.2025.04.07.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:40:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u1pW5-00000007DRV-3Cjz;
	Mon, 07 Apr 2025 13:40:09 -0300
Date: Mon, 7 Apr 2025 13:40:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
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
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250407164009.GC1562048@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <yq5av7rt7mix.fsf@kernel.org>
 <20250401160340.GK186258@ziepe.ca>
 <yq5a4iz019oy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a4iz019oy.fsf@kernel.org>

On Mon, Apr 07, 2025 at 05:10:29PM +0530, Aneesh Kumar K.V wrote:
> I was trying to prototype this using kvmtool and I have run into some
> issues. First i needed the below change for vIOMMU alloc to work
> 
> modified   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4405,6 +4405,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
>  	if (FIELD_GET(IDR3_RIL, reg))
>  		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
> +	if (FIELD_GET(IDR3_FWB, reg))
> +		smmu->features |= ARM_SMMU_FEAT_S2FWB;
>  
>  	/* IDR5 */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);

Oh wow, I don't know what happened there that the IDR3 got dropped
maybe a rebase mistake? It was in earlier versions of the patch at
least :\ Please send a formal patch!!

> Also current code don't allow a Stage 1 bypass, Stage2 translation when
> allocating HWPT.
>
> arm_vsmmu_alloc_domain_nested -> arm_smmu_validate_vste -> 
> 
> 	cfg = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(arg->ste[0]));
> 	if (cfg != STRTAB_STE_0_CFG_ABORT && cfg != STRTAB_STE_0_CFG_BYPASS &&
> 	    cfg != STRTAB_STE_0_CFG_S1_TRANS)
> 		return -EIO;
> 
> This only allow a abort or bypass or stage1 translate/stage2 bypass config

The above is for the vSTE, the cfg is not copied as is to the host
STE. See how arm_smmu_make_nested_domain_ste() transforms it.

STRTAB_STE_0_CFG_ABORT blocks all DMA
STRTAB_STE_0_CFG_BYPASS "bypass" for the VM is S2 translation only
STRTAB_STE_0_CFG_S1_TRANS "s1 only" for the VM is S1 & S1 translation

> Also if we don't need stage1 table, what will
> iommufd_viommu_alloc_hwpt_nested() return?

A wrapper around whatever STE configuration that userspace requested
logically linked to the viommu.

Jason

