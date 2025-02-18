Return-Path: <linux-arch+bounces-10206-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E255FA3ACDA
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 00:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D50175823
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 23:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF471DE4EB;
	Tue, 18 Feb 2025 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gyCO2oxs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018F1A8F6D
	for <linux-arch@vger.kernel.org>; Tue, 18 Feb 2025 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922670; cv=none; b=ejWy+rlE/vV/LKfFT1a+9ZV2z5C4ZjuIwo+PjbJDhH/9LxbXDpTF6/wemnmXn/OPA+LU4BJu078KOvVABhDJu2JTovbV1jtH6NKlxbBoI1sN5TNQFa2M2iS2LrEPwu5oyfqd43OGfD9Yd/bURQFYE03TBXrMmxezhcSp3AE+Dj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922670; c=relaxed/simple;
	bh=iKT5gRHJFTk24cvpT8KmAyPqwcHjrkHc67AQuv3guHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuJuQKIyMUg7ubRAgk+NAhbC41Wia2xi8sZu7Krs6zYoDpiV+QmWW0kX/f3Z14wCgP8hN5VDP8lG2QCWvIbvrtNSJqZECNzrUDl7grmFglEtFgGLY8yYC1Pz+ULyOCImdIjTvHhYkyHExismcZwpESaoqfQSHoV8LWUpZpNslmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gyCO2oxs; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so52903206d6.1
        for <linux-arch@vger.kernel.org>; Tue, 18 Feb 2025 15:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739922668; x=1740527468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKT5gRHJFTk24cvpT8KmAyPqwcHjrkHc67AQuv3guHc=;
        b=gyCO2oxspS7/wo6nKrTP+PvPC3WHPNTT6/JmRriOfZhLiACAnYCQEFSI25NC0zC/bF
         qsqrC37zkhXUI/9OmKKjpIkhjLKCHctLj335ADwtwMIBl1hIncXGBVtv5/nxRpL8ejbX
         LHz+b9Vz/nMApEUQDq9Lc5nBJyHsPBK7k1DyN33LgalFNLN0UL1+RbukmuC4ysEwj0qh
         wgCE/wPcuCDwaNsLdoAk7Eoi6GPSmFhhQDxSHDe5yQpmi9qqG1KNX8rJaDxWtRjwzTh3
         d0tAgD7OX+mSpXFQ6cw+c7BSzWiMhmu1TvZF45FwzBYu7VwPqmD7oEa3C2DbfCbikDIT
         6lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739922668; x=1740527468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKT5gRHJFTk24cvpT8KmAyPqwcHjrkHc67AQuv3guHc=;
        b=dSfcL3miULgwDIY7OMwrKGy1TY2attE3mtXlev7f8Ft/v8idMkqHUqOWydJINo9dCg
         yXpB9AJJbqAmjpWMKt/MtLsaLJ1fgLvWlOiqYMhJlUmGGOSzU/D19redqyLs26y94+zD
         qrPWtNEJ1ps0nBzo3gIlKyEy1E/mib5SvL8MW/EbCYuT4XpdR5Fnv3hxIqeZryQQ6Y9m
         lVJ9H5ej0x5B78XOqhfcjljTAllaloPMxvWACsM6Caxk91qgawE967Xnpfiw8/OpwX/0
         Ox1aqCo41nfvMUeGmcZnPTfADQrmobwQJ6f4idCROKizvfoVL+t/nPoflPQbqWm2A2p0
         MKKA==
X-Forwarded-Encrypted: i=1; AJvYcCUpquxlKwZiZXZ8/ciC9C9yTNHUXICbu/YTWDAbwgGtuUg4WDt22b33E5BlSo6ikSh6FuF2QNmkBaJe@vger.kernel.org
X-Gm-Message-State: AOJu0YwZaFFavG9VdrL3Yv91e85IJqDcVykbeBJJkszqzDvZLotcJ3b4
	IADZqlabdlXkgOKrEwy2tNbmhggZmEHrFe3E2XaHGvCNEgVOeZMrE+PyHPIFjh0=
X-Gm-Gg: ASbGncvKyp2BzGhVXEK2nppTZN3qt1Pbbe7U4FbVQjA7Zlj1qccKXrrAfdg8VHYonUW
	nchapYcjtS2dakIk7Vg/aODpnOCGvYvVqUleX9IDu2ecX4cA1VGoWbVDrzp6pr2HQTf1rIirXYA
	ymcJ6y/LoOcxk2wWUKPEIHMjHJwoI6Ct6IhZqeCm7+qIpn/idFr2r4llNI2A/wYnadSqBIzFuto
	hswA75gESDY1sdR7NaC+Q2MdYU9d6U25ItzD/bPqpkD5szIVpwqUhVFRIhzM4tOG87OXAtukmBs
	swBa7ydIwwvUMTzaCZCL8R23eYVUJAqrKh1h/pPgIP5zSGZde5gSkvsJ1fkrc8NN
X-Google-Smtp-Source: AGHT+IFO1/6l3OUxeVa8mqeoAIRJldW9bBpco9S18W39RUG+1rvPlDolxLvoJK10Ea2Dnll0//ehxQ==
X-Received: by 2002:a05:6214:1d09:b0:6d4:3593:2def with SMTP id 6a1803df08f44-6e66cc8aba1mr253639746d6.5.1739922667835;
        Tue, 18 Feb 2025 15:51:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f325fsm68981726d6.76.2025.02.18.15.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 15:51:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkXMn-0000000020v-3I9I;
	Tue, 18 Feb 2025 19:51:05 -0400
Date: Tue, 18 Feb 2025 19:51:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
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
Subject: Re: [RFC PATCH v2 12/22] iommufd: Allow mapping from guest_memfd
Message-ID: <20250218235105.GK3696814@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-13-aik@amd.com>
 <20250218141634.GI3696814@ziepe.ca>
 <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>

On Wed, Feb 19, 2025 at 10:35:28AM +1100, Alexey Kardashevskiy wrote:

> With in-place conversion, we could map the entire guest once in the HV IOMMU
> and control the Cbit via the guest's IOMMU table (when available). Thanks,

Isn't it more complicated than that? I understood you need to have a
IOPTE boundary in the hypervisor at any point where the guest Cbit
changes - so you can't just dump 1G hypervisor pages to cover the
whole VM, you have to actively resize ioptes?

This was the whole motivation to adding the page size override kernel
command line.

Jason

