Return-Path: <linux-arch+bounces-10965-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F068A696B5
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 18:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D82A883973
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364F81F5844;
	Wed, 19 Mar 2025 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nV/VpToK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1421F4164
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406062; cv=none; b=j+Bri4RRMMC7qeuvBf0bXAC0zts1zpZF2FNdj6TMfn0d+u3Fu+BNgCOO2R4GtSfGC1aVBsqhuCswsPnEMecJb0POOw1ysDO/axjW4B7PpLs0aOIfE4YnGksEB3HPOxZJaYk6RZgJhn8NGeoJborY7oVvUs8PhopYzdhGYg5tJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406062; c=relaxed/simple;
	bh=Uup4ij0e3QxR7P+2AXE6ojI6gZ035al5TOyCCZJD8FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYbyoeCmcFgrcqmNVGS10k7LMYVWz3pJNfbN1QNoXgoyh7uHPGoXf0aRFdSBpb5MJhFnLaYIgWrqcxFHPL7uzqJ0Nrv/gKPOsyxo5sanPdKp1ep5nEe/ehryfQYnX/Vc1vH1RQf9tvuXLM6UQ9ZC5j1UVyfKVkgrzYi2bJvCQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nV/VpToK; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c24ae82de4so807411385a.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742406059; x=1743010859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=leCUW9KEkZQcVeVok9ACFyeDj4RZoftXqhcJPMWCJYU=;
        b=nV/VpToKK1Aoc35hYasv8EBUTMZK3YWljurPD2RE8K95jFcoCmONYbBpbib1QPyFbd
         zSv/Fnk+PNhWJ/yPZHfQrWxfNZCut2KGrxd3hZas9X5TZ7EXb7a/dokHKpxOytAT4pQ9
         gfeyNgK4YiJtjD06hxgzxo38t1AVC0Vdkwe+i1EL1u+f4qzlchDtmyVqmWb5xb9CtAnf
         CMt/PYJWppWD+Yuqh6qT9h2143TT+qM7QypYtCpfyJf8bTECAWu3m0vRYjgL+whCaBCP
         +g+MkRpdKaz0uAvhepSHNFG2+jIm5/kc50U3IlZji0KHpX/QBJGLS8rOlfY0KbgUMJAR
         wnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742406059; x=1743010859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leCUW9KEkZQcVeVok9ACFyeDj4RZoftXqhcJPMWCJYU=;
        b=KWtnWOIMFxqjVwNk8aJ7ljFx4oyxTGcDDP3mYuUlvJTOJfI3xq966NrZu2irMvJyZy
         W8F7/Tsam75XzzrPHXDbXDz0+OUEuszIIGxGHCnoXHQH1sEzUsH8p/A6z6tW+KuyFlQ5
         rcWfNtsdcgqXaeHaJo+wtwDUp7TN7PQEPsk2M94xvL84p44+1Hc/yFt6wUgTcbnDXaOg
         VfwIuCMOBOi2ZRs0mdiRSfFl4VBu7jv1O1YcTVI1cMJ+AovDdvzm9YOPG2CJ58HxS2sH
         c+PVO01UojZxXitT6Jc4YXiUWsJ7aZpaPqmVrn/88oDSyP5ZBNM/cVOdSTDkvdJwoTu5
         suxA==
X-Forwarded-Encrypted: i=1; AJvYcCX9jaL8a6yz/c80CYLKLjlcXw1cgnQes1J2DQAzjml/W9E6uFbSSNXa20Qwvu2XVwUNJ/r08NmYG0Zh@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4i8PL73kGygfuQrG259Kc5tcM1u7UF0/vsvzz6DfvXC77iok
	0YaaWrzC6Bqc791PvcDHRlQ9OHiafBI2/snYM5y+Qc0mQJxmrF64JM2GlRagy0c=
X-Gm-Gg: ASbGncsTlLYuPfBr9gC3dOTA7PW7M0EA4deC2v28a7A74q2qbRaHRnbELvlpVehWpfQ
	gyGjl+8WJj9JyX3ELRk+O425qeDapYap8Nzs/CMdR7T+6K6sa/2HDyI3EWLCHQL7ApPeltM4eN0
	a9OeD6mXBK9SInBVIdd2fytWtTABE3BCfmgcamBZ0ww7UybfAfuQJaa1GYyVdEJhTntTIdS3nae
	hYWtwru5QunLAlfkgRf3phS1WQo7CN3sZZNetB5UzuSQKpjUIIAM0mdyFImwjBdGOJP/USZmtcH
	EXlUtFRbIiyF/v+fDfyhKUwoWw3o2Ss0yC1eYoX7CH9RtcdlD+rfbVt1sUK7BzXJXKYZxXh70nr
	xr34S/d7fROLm1gdY07D8J3tZKrMD
X-Google-Smtp-Source: AGHT+IFoJAQ9bGba/Z0yZg+D8yG6xp2ytZSUuDU+bbhNp9w3ofz/kSX0XQcOY4VVJjVXQ+26hrcvHQ==
X-Received: by 2002:a05:620a:57b:b0:7c5:6ba5:dd65 with SMTP id af79cd13be357-7c5a84a3654mr479964285a.55.1742406059344;
        Wed, 19 Mar 2025 10:40:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4dd2bsm884915085a.14.2025.03.19.10.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:40:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuxPW-00000000WcK-0irF;
	Wed, 19 Mar 2025 14:40:58 -0300
Date: Wed, 19 Mar 2025 14:40:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Michael Roth <michael.roth@amd.com>, x86@kernel.org,
	kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
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
Subject: Re: [RFC PATCH v2 12/22] iommufd: Allow mapping from guest_memfd
Message-ID: <20250319174058.GF10600@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-13-aik@amd.com>
 <20250218141634.GI3696814@ziepe.ca>
 <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>
 <20250218235105.GK3696814@ziepe.ca>
 <06b850ab-5321-4134-9b24-a83aaab704bf@amd.com>
 <20250219133516.GL3696814@ziepe.ca>
 <20250219202324.uq2kq27kmpmptbwx@amd.com>
 <20250219203708.GO3696814@ziepe.ca>
 <604c0d0e-048f-402a-893a-62e1ce8d24ba@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <604c0d0e-048f-402a-893a-62e1ce8d24ba@amd.com>

On Thu, Mar 13, 2025 at 03:51:13PM +1100, Alexey Kardashevskiy wrote:

> About this atomical restructure - I looked at yours iommu-pt branch on
> github but  __cut_mapping()->pt_table_install64() only atomically swaps the
> PDE but it does not do IOMMU TLB invalidate, have I missed it? 

That branch doesn't have the invalidation wired in, there is another
branch that has invalidation but not cut yet.. It is a journey

> And if it did so, that would not be atomic but it won't matter as
> long as we do not destroy the old PDE before invalidating IOMMU TLB,
> is this the idea? Thanks,

When splitting the change in the PDE->PTE doesn't change the
translation in effect.

So if the IOTLB has cached the PDE, the SW will update it to an array
of PTEs of same address, any concurrent DMA will continue to hit the
same address, then when we invalidate the IOTLB the PDE will get
dropped from cache and the next DMA will load PTEs.

When I say atomic I mean from the perspective of the DMA initator
there is no visible alteration. Perhaps I should say hitless.

Jason

