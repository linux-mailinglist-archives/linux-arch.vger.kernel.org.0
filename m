Return-Path: <linux-arch+bounces-10530-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D94A50B7C
	for <lists+linux-arch@lfdr.de>; Wed,  5 Mar 2025 20:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C611B1891E34
	for <lists+linux-arch@lfdr.de>; Wed,  5 Mar 2025 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FD6254AEC;
	Wed,  5 Mar 2025 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HlX6kVPC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE924CEEA
	for <linux-arch@vger.kernel.org>; Wed,  5 Mar 2025 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202926; cv=none; b=atcOL7JA5WrxtqVb3KUOfgbrn5eilmpq5mkKWh7MePO3Lo5i0lImuQXsPBzAj81/tavXs6DXqTPN3O2ubXveXJJDobLQYpj51JZi2F5THNsYxNSPTP0Dhlq4VGXHhTrPNc0PuSfi73z0OiDQmCPoypScOM98VBsrVMMuH9Ov/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202926; c=relaxed/simple;
	bh=yags00HimzcK4ADiEl0X3eL1vhGMGirpJlRolnATCxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8wZe6WO9THhvmXKl16qDfY5gF+r2Vd2nkE5I2jaHYqDowWLb8qqH1EVLM4tY8E26FpKrRmqJIq3dzk+d/XTCkYJieYOgwYDAGRaXknTONObbiurDxEvm7lGaro9CLm5MUycL/AC4RAmb/9SnbNChMTmiKHEA2eXnD64IJWu7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HlX6kVPC; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3c9f7b1a6so131369985a.1
        for <linux-arch@vger.kernel.org>; Wed, 05 Mar 2025 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741202924; x=1741807724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTrOJMautZJ74CE8chK1zIyRNkTfUPScJmXz0FQll+Y=;
        b=HlX6kVPCcDWX2J8jzIl6Kp+Bc2+epQmkuUJ99tAWx6cGtWThzWCWCHp+m/fUib/pVs
         joW9oxp998DtgTv35UdPDxS4R3zWy3/tnlp6KqfCBNNkv0vB2c3pfb6/QCoSCR/4ArNC
         ICe5Hn3Ml26/nzOUj58mQsT6Pe+Wiuasn9vSKOmsy8nqIhSq/f2yy7ZVN7Dd6gjPHuEu
         uhz0E9XJIH9fUmiFi4sYjsAAFhHue6x5/Vy/OF+bKVHhaFbfZYkEFn3KY1UGOIwr2FQH
         m9DB8zWuv0CoqtHSQQgIHGdT8m0JSOQUzQAJ+6LgpCDxKd75sn8mCpiXS/WmqYWzwCI2
         kweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202924; x=1741807724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTrOJMautZJ74CE8chK1zIyRNkTfUPScJmXz0FQll+Y=;
        b=lLzZLKrpdUI9wCDpYkpJShZwJ+tesDj1c606+nUt+H+rNOfZ+TIBUE8yKfZAcS1lAz
         b50zO7TR4Q+sUIAtADfu0Vv32sxdntFVPc2Dswr8jMWVa0fqlL2WvBi3ui81nK0F77vd
         4AJqKitL74pMCvq3pPIKE8Q//rlC774BnrLYAe/lpkR2z3Cd/PUEVj6DZ0K5pRMqHh90
         Gt32/MGy1e3cfGKMGyUBfoWACDyvwlmJRcnau3eo0vQh/14F2bhHFooGwtbMLo1fFpya
         Ajb3seoohiPblsOJtrm3W5tWiErjNFc7v0VKUp9yiHM2//CstggVwqjdTphJql+7dNqy
         t9eA==
X-Forwarded-Encrypted: i=1; AJvYcCUeyQHJzzSzTa+4L+CHm8hsZdbNb7c1wKXJQUsIncheA5fRoZjGEnBPaOvZpDJ9HdsMcBJWsiQYBZwp@vger.kernel.org
X-Gm-Message-State: AOJu0YysNW4pFyC1VOcxvZ7F3HcliqV7j/RQaO79EdR5Oc36zI7FwHL7
	QAi8PBdXeTOuCbHEBh2oSOqVJP6fuqLwMv1HG5c5lS+TWYyiBWgh5CTyAUe0UbE=
X-Gm-Gg: ASbGncs3PpBoeH0mGIVGeMPXWGcRA+s1INFLdAPKqMk8BjrFOFVkWk5w5DMbTfkRx3U
	0VRxLK/jwV8Yaa3PmLokuQOCXbnqLzyTs8nKPG+h7qz83bgTXATkxV3S46lsAFYsVm824rlF3fD
	ifxPQ+6y+XkFSX5PuFkXhxU1Vw24NN5i3f0uIPlyjx41TLAZnU5whecH5mxCHSjNp0kMJ1NMyoj
	4Lc2DaWL/EBdpMdSJ33kxtkpuQnwXJtsjHzZwEXJ3kJvAUbPCr3Dp6UkdK90nc67TuzfcBQ7hq9
	2Kd5lb4O7UU02thm46F+HHfLZyCy5fM0OnC6WDX/aWZG8r5ccXI2KmLTTv00uOCBSXU22u4njb+
	7DEeeR78B4c01G2+pTw==
X-Google-Smtp-Source: AGHT+IEHx2UVGeNJCjdCHNzkys/fqlsDci1nQ/1m9GKN7AMZGI83uk7z1IQe+K7jbrNiF4r725P/BQ==
X-Received: by 2002:a05:620a:6285:b0:7c0:b350:820 with SMTP id af79cd13be357-7c3e39b1392mr81853985a.5.1741202923780;
        Wed, 05 Mar 2025 11:28:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c9f640cbsm324838085a.108.2025.03.05.11.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:28:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpuQ6-00000001VBp-37wk;
	Wed, 05 Mar 2025 15:28:42 -0400
Date: Wed, 5 Mar 2025 15:28:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
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
	Zhi Wang <zhiw@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250305192842.GE354403@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
 <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>
 <20250301003711.GR5011@ziepe.ca>
 <Z8U+/0IYyn7XX3ao@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8U+/0IYyn7XX3ao@yilunxu-OptiPlex-7050>

On Mon, Mar 03, 2025 at 01:32:47PM +0800, Xu Yilun wrote:
> All these settings cannot really take function until guest verifies them
> and does TDISP start. Guest verification does not (should not) need host
> awareness.
> 
> Our solution is, separate the secure DMA setting and secure device setting
> in different components, iommufd & vfio.
> 
> Guest require bind:
>   - ioctl(iommufd, IOMMU_VIOMMU_ALLOC, {.type = IOMMU_VIOMMU_TYPE_KVM_VALID,
> 					.kvm_fd = kvm_fd,
> 					.out_viommu_id = &viommu_id});
>   - ioctl(iommufd, IOMMU_HWPT_ALLOC, {.flag = IOMMU_HWPT_ALLOC_TRUSTED,
> 				      .pt_id = viommu_id,
> 				      .out_hwpt_id = &hwpt_id});
>   - ioctl(vfio_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, {.pt_id = hwpt_id})
>     - do secure DMA setting in Intel iommu driver.
> 
>   - ioctl(vfio_fd, VFIO_DEVICE_TSM_BIND, ...)
>     - do bind in Intel TSM driver.

Except what do command do you issue to the secure world for TSM_BIND
and what are it's argument? Again you can't include the vBDF or vIOMMU
ID here.

vfio also can't validate that the hwpt is in the right state when it
executes this function.

You could also issue the TSM bind against the idev on the iommufd
side..

Part of my problem here is I don't see anyone who seems to have read
all three specs and is trying to mush them together. Everyone is
focused on their own spec. I know there are subtle differences :\

Jason

