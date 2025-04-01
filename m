Return-Path: <linux-arch+bounces-11199-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926DA78015
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 18:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB467A1833
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B905211282;
	Tue,  1 Apr 2025 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y7Xl1amt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24420D4F7
	for <linux-arch@vger.kernel.org>; Tue,  1 Apr 2025 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743523985; cv=none; b=uvGnCCR2V7fVzon2H4bGXoLV2ly6yf3pz+vVnF3ByBr2FSe2kJ2Hl1LuWVzNlO7wazuAqK73Wa6R1eSXks037AV9thSaFdUwqb9orEKZTbTebVDrY0daoPJHYg4KmrssqPTR8oVrm5j289oFJTZNgM8warTVI2nKAS1QZIaH/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743523985; c=relaxed/simple;
	bh=jsPocqxTm3Tk/n85dNMIT20KutkK5Grt6C4lCnIAUO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SArtGiZbs70xRjGX2a4XRkgQpmd1AFBZ6FA5VXKVnJH1fd62NL79WXVfJSiiiF+BJEAnNo3VK2/fs/zE0OPn3EP10V6m4EFUBfAb/TE6AAtFt2BlQpF6QbHUPrKTgqMqKI6exgOV6AVQxne1s7NSPbooeBl0tsKkgWptsydKClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y7Xl1amt; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ecf99dd567so66466206d6.0
        for <linux-arch@vger.kernel.org>; Tue, 01 Apr 2025 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743523983; x=1744128783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=poENEUfmFrThnex6gEytUaMxRROeOKxTbEdDijAo1Do=;
        b=Y7Xl1amtUC61ZevW35HaOxAgeWtIjaZFt2JHpauZsWeOvffFluaio7WwWxqkpsUeKb
         TrhvjiuNr4aBJYenVVYUUBsJsjz11Jaege/MZioUQ3fFvINCccT2NQ0W+8xasVAe9ss+
         MfsAT+bf2SlQJ2Satmnz0gWcpwgU6lZcURTxVVGzEctImitwPIlb/xhI95/ZxhW86Gj7
         Ew2HqZwEDRW2qz95Cj/ALdj+PPGOxHSmdgNJH+jE3G8Heobge3A6FKPo2sfmfZPbnSlI
         oINHMAkkNQZG+IINQ/EU+o5k5Gf9vakQUMf2W56vwOHV5BmECgcGXbbvDzuls1zF4z3M
         RnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743523983; x=1744128783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poENEUfmFrThnex6gEytUaMxRROeOKxTbEdDijAo1Do=;
        b=fD5OEq4Wd9Qd9nUzYRIcGE6NV9Jvoy8fLnYHoBO6tWYMga0hpsQ+0JMB52KtCK7jCp
         +grG5CpmjZJbKFXOBPzoIeIlvZ+JkCzg9p6t7688P8Ft3DWHcab/9rERwHHMNX1q+UDq
         eM5WXDFi61Ehx2TciD0dbGoOxgPi+NPHH5epMxwcsvrebyIL+W6l3yjoP7gnBwg/n5sd
         824jyKAhxZ7v8gAw/IE/hA/FvCu/g1jzgLfkDPox7pllWNt7F7+9r6PlYdwp24tpzehr
         XvF23quTnN/3sEDoRA7tOkgxPv+GhpbM0N+dAFdPDBmbHO3zCWz816Knbuqrl12liRwn
         h5rw==
X-Forwarded-Encrypted: i=1; AJvYcCWCZKt1OYnUXxlNnpBzw2ClFq3auDKmtN1iz5uyhDV1asccjEQHvoPYSvfLnvJJQLpx8WgCl/RLn20T@vger.kernel.org
X-Gm-Message-State: AOJu0YzaMjeC3oZue4KSWP+4+UyEYSjnaYeYIDjc9WXvm4wa0mwcTXsI
	kDxfu4k7biSJlSSON+4im8bKcpmRwsf6fuPUfiY7R7m5VsQXvgRKncUyt+UDl14=
X-Gm-Gg: ASbGnct7xojHJ2dhC6stqbSAi+S5Y2Y2dV+lPxAWDIwLitF+An2v1Yh/2iRM9dx/bya
	Z7bHalj2dydNVUUYEN2jTFIWxiorZkIA24He9QUtmMwMlTHsDuYd2ZJgY3HfZn/ZA18N+2476yV
	1OP35ILW32TzrZrPSX55ky10jdHhMYw2/RozLfvrQ8rQbbgEdoOxg7X0NFxNTNP3E6wTj1Qub3u
	KZcD9ewrbk+sMEVOLPqLSkVknLnVkFrc5mEUrUBts755otAuLqG7y0xRyfPM+EsQlG5B7hmN8B6
	ed+Bjuem4GrfXZ4iPm6roA8DXENCv8Id83dGq5rMJhpjd2s32BoibnNX2xPG2LQla7He5ylzH/l
	LVv6hjlOkGzWV91d0DGpbBGQ=
X-Google-Smtp-Source: AGHT+IFgqnXSN6fOa8wvReuysgLZpbCK1HhkdqcE+Mm2zYjIPC+dt/OEL3eUy9xyw3HgFZ9lLvi7Ow==
X-Received: by 2002:a05:6214:226c:b0:6e8:f905:aff0 with SMTP id 6a1803df08f44-6eed62a0be1mr227091686d6.35.1743523980713;
        Tue, 01 Apr 2025 09:13:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec97718e1sm63039286d6.70.2025.04.01.09.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:13:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tzeEV-00000001MLv-35Gu;
	Tue, 01 Apr 2025 13:12:59 -0300
Date: Tue, 1 Apr 2025 13:12:59 -0300
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
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250401161259.GM186258@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-15-aik@amd.com>

On Tue, Feb 18, 2025 at 10:10:01PM +1100, Alexey Kardashevskiy wrote:
> When a TDISP-capable device is passed through, it is configured as
> a shared device to begin with. Later on when a VM probes the device,
> detects its TDISP capability (reported via the PCIe ExtCap bit
> called "TEE-IO"), performs the device attestation and transitions it
> to a secure state when the device can run encrypted DMA and respond
> to encrypted MMIO accesses.
> 
> Since KVM is out of the TCB, secure enablement is done in the secure
> firmware. The API requires PCI host/guest BDFns, a KVM id hence such
> calls are routed via IOMMUFD, primarily because allowing secure DMA
> is the major performance bottleneck and it is a function of IOMMU.
> 
> Add TDI bind to do the initial binding of a passed through PCI
> function to a VM. Add a forwarder for TIO GUEST REQUEST. These two
> call into the TSM which forwards the calls to the PSP.

Can you list here what the basic flow of iommufd calls is to create a
CC VM, with no vIOMMU, and a CC capable vPCI device?

I'd like the other arches to review this list and see how their arches
fit

Thanks
Jason

