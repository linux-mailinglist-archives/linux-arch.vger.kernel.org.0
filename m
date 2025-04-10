Return-Path: <linux-arch+bounces-11372-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36CAA83B2E
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 09:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C349E000A
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 07:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BEF20C027;
	Thu, 10 Apr 2025 07:24:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F85205AA5;
	Thu, 10 Apr 2025 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269843; cv=none; b=NhHkaeejZwTYTJeBQtZu27BIdkQEdyVs+DLGqd9LLTh/yAcNXFDwLxQ50BgPvJV2pKnsIaffg33ev6hjZWULSM+OsTjrq8KNSul4EhWHoqj5uvY6dIsy5e2mCpt9C7M4NM031wGrxwkYb6gYLhoBhyOU6oGlapQ4Wl0UxSW1aTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269843; c=relaxed/simple;
	bh=7sEd3Ffa5a1RVgJPuCxl22V8hW6GtHda8gxp+9Ug0ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE9WkfmXjm/rX/uOobNndroCgjJzaZgyyJCACxgntUlaqPN1nI0/XVqI4QWu2iG/qpACuH6/yh3UtItQ3yBLK1KBtEkmLTVwfl7H+m5py+ejPYzwTeE9Us8KpbZWiluzMkvIP4kBrj0MWL1LJp3fjmrH+1c5uyLEc0FvEfS+OKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F56568C4E; Thu, 10 Apr 2025 09:23:54 +0200 (CEST)
Date: Thu, 10 Apr 2025 09:23:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
	Robin Murphy <robin.murphy@arm.com>, aleksander.lobakin@intel.com,
	andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
	catalin.marinas@arm.com, corbet@lwn.net, dakr@kernel.org,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	gregkh@linuxfoundation.org, haiyangz@microsoft.com, hch@lst.de,
	hpa@zytor.com, James.Bottomley@hansenpartnership.com,
	Jonathan.Cameron@huawei.com, kys@microsoft.com, leon@kernel.org,
	lukas@wunner.de, luto@kernel.org, m.szyprowski@samsung.com,
	martin.petersen@oracle.com, mingo@redhat.com, peterz@infradead.org,
	quic_zijuhu@quicinc.com, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, bperkins@microsoft.com,
	sunilmut@microsoft.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH hyperv-next 5/6] arch, drivers: Add device struct
 bitfield to not bounce-buffer
Message-ID: <20250410072354.GB32563@lst.de>
References: <20250409000835.285105-1-romank@linux.microsoft.com> <20250409000835.285105-6-romank@linux.microsoft.com> <0eb87302-fae8-4708-aaf8-d16e836e727f@arm.com> <0ab2849a-5c03-4a8c-891e-3cb89b20b0e4@linux.microsoft.com> <67f703099f124_71fe2949e@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f703099f124_71fe2949e@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 09, 2025 at 04:30:17PM -0700, Dan Williams wrote:
> > Thanks, I should've highlighted that facet most certainly!
> 
> One would hope that no one is building a modern device with trusted I/O
> capability, *and* with a swiotlb addressing dependency. However, I agree
> that a non-shared swiotlb would be needed in such a scenario.

Hope is never a good idea when dealing with hardware :(  PCIe already
requires no addressing limitations, and programming interface specs
like NVMe double down on that.  But at least one big hyperscaler still
managed to build such a device.

Also even if the periphal device is not addressing limited, the root
port or interconnect might still be, we've seen quite a lot of that.


