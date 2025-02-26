Return-Path: <linux-arch+bounces-10377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA46A4606F
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 14:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CE5179EC5
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 13:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BAB21A421;
	Wed, 26 Feb 2025 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gmth0zxt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC9421C19A
	for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2025 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575526; cv=none; b=BR4qlAbOJZp01m1tAmNLsqyMMBFDq/QtbkVAa89+LE5VEP7RjvJsDXESQsYlkgYUClDxV8XT5LPfk4fWQVSERuqqZQi2s7ZxGsUDjzqRxPyYwVlbLd4VW3eZy5ZAgL+49kRavRtRfSuqPO/uYGyJGJbADbi9uSDWk+uRnLtw1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575526; c=relaxed/simple;
	bh=UcN+Yc8/BXf/BDVbG/QiIbLhSfNGYB+VDmHOpxILJEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKrkVN+UWjyv1fM5r98sIYRG+wowCsoR5c2fdT9Q0ALi7I83MYmJPtOM63goIP1z/6QrVqnZkX/YmLhYuA6bGsWmy8NLqtkzEvTAfOfWPsbh6tYRvols2pZUA2n+BCqmuf7ciMCaHvTrbSiMpwi9h7kanok0mMviVI0Ad9xtZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gmth0zxt; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-471eb0e3536so106012371cf.3
        for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2025 05:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740575524; x=1741180324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m6Xk4LHq+vuxMrWb9QEhIjcrWUMHuvgAEq1BuTfNkWI=;
        b=gmth0zxtEmjcsNxhBouoEvOu6qEY7rYm3pbfVqVxZNY4Ii5Y7msKJbC1NsvZynHU5R
         Pj8JH1hsT/VZ2W77VKd3PwwUxgWVNV/ip6dmtM4btdxUBO3oIxNTQYrQcaZ9RQ85KLc2
         ekFyj+uNmcQnZu1aTxpm36sszGsbpiDSaWzqFYDeT7VD++qMH8/w9/dkASEjWY8vR0s8
         UWGf52ZsR1ROQS6uqAfFwSnR0OdudCeR0Gb06DOGGTrrLWZJvA8QZ2hMSnY0Dou/yEAZ
         MKOSXAI6ZxkjfOxw2RoK2mO/BwnFfQiepLvqACzK3aUibTLaW3EZarLFBvvn7sqhaX+z
         s1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740575524; x=1741180324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6Xk4LHq+vuxMrWb9QEhIjcrWUMHuvgAEq1BuTfNkWI=;
        b=YeOJ8vQDSTNTu8eBz/Rbz8fFYYdzWW5X0EWmE6T3bCJJ5JDQShDUelxmwMhcg+GQy7
         q40wAEM8CHrGovwvGdZ3BstRub8Ji7pYeo6fbbtPGK4RxEGl5uaFAoq6R3Lc9LkksJ/9
         YufEaJ8SjxknmSs5yjHbI9SZWk7mFV58GevjGIbGn1TWV7AP92jQv+YEc6ruZbJv0dfv
         +fNnbQFMJ76Jp8VtEmB4hHGbIJ4PcuGbVs6y4ujAeaYaDoc+8p58fS58zGwC3M0nu+ND
         kmQ+2/poBsoQzwnosQnxEB26ieWO80Z0r/PP5ZZ/1vFp1PZtu76z8HYDn0w04G8g5pET
         GLVA==
X-Forwarded-Encrypted: i=1; AJvYcCVO7kFlYuYoy8/9KB9TrAYn85F2Af7koH6kEOEVggy+9k3+N7Z0qZc6ysZzof9zRoWYaqyDGaQgVkb6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4z7/Xoj3SHISp518PCPxbJ4Oq0sFPUfc2EwwoC4H+6/T/WRm
	dBOjnfcnmEmpgwcevMM3E9HiKMTF5KOfUG+7izt175hRlm8FKG7Do8vwOe/N6+k=
X-Gm-Gg: ASbGnctte31gBw67bpJ2HHjVJPx8kCsOGXOtDT+QAGqykQXcz2frt+MDWhP6ipA97yO
	7LRna6xiLClAvVX/rdgS7RMRNxzeBS/KEl6e/IpncfBh2Y2vtly30I4LLq1fIZiHW6JYye6+EY4
	Mm6h+4FHHhn/vy4vJYTiNXcmh0qcUbhDbn2DG5dZ+gBkcVpuOMOe6UTkGjYPpNUBBh8tWD1cKDe
	nqdU5A5k8KOABEJdu5gI1EkRJL+LEFhNkoch8Ac5cEkoIkIhPAiF8PTr0neBnm5Mwcp2TZv1cm2
	TeM4dNdR/YSKEF+9k4Y5uXt4ObLLGYrYW1bIL4jd649Rj5xCbvUxrKU7hAWYR856takJy0WIW1o
	=
X-Google-Smtp-Source: AGHT+IEEfwlXAvWZ2xNGVxvzUGP6nDfT13h++oyNBWTrRPp0M1zvh40QuIYqQQDMaC1/myckxEJxtw==
X-Received: by 2002:a05:622a:13ce:b0:471:f619:db45 with SMTP id d75a77b69052e-4737725caa7mr88331981cf.42.1740575523795;
        Wed, 26 Feb 2025 05:12:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e21fcdsm23423041cf.39.2025.02.26.05.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:12:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tnHCk-000000007O6-0KPx;
	Wed, 26 Feb 2025 09:12:02 -0400
Date: Wed, 26 Feb 2025 09:12:02 -0400
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
Message-ID: <20250226131202.GH5011@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>

On Wed, Feb 26, 2025 at 06:49:18PM +0800, Xu Yilun wrote:

> E.g. I don't think VFIO driver would expect its MMIO access suddenly
> failed without knowing what happened.

What do people expect to happen here anyhow? Do you still intend to
mmap any of the MMIO into the hypervisor? No, right? It is all locked
down?

So perhaps the answer is that the VFIO side has to put the device into
CC mode which disables MMAP/etc, then the viommu/vdevice iommufd
object can control it.

> Back to your concern, I don't think it is a problem. From your patch,
> vIOMMU doesn't know the guest BDFn by nature, it is just the user
> stores the id in vdevice via iommufd_vdevice_alloc_ioctl(). A proper
> VFIO API could also do this work.

We don't want duplication though. If the viommu/vdevice/vbdf are owned
and lifecycle controlled by iommufd then the operations against them
must go through iommufd and through it's locking regime.
> 
> The implementation is basically no difference from:
> 
> +       vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> +                                              IOMMUFD_OBJ_VDEVICE),
> 
> The real concern is the device owner, VFIO, should initiate the bind.

There is a big different, the above has correct locking, the other
does not :)

Jason

