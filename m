Return-Path: <linux-arch+bounces-11371-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7BBA83B0B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 09:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A431B82C20
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A6920C028;
	Thu, 10 Apr 2025 07:21:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A520AF6C;
	Thu, 10 Apr 2025 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269719; cv=none; b=ftLa43k+GLi1A5Hs2EBNm/FrD62Jzvu515dz3EjQDPxOmyk0ejvQNknuLANX5a/dTis39T6AVws+1mIKcC38DRy0d5o9t8pPF4fc4Qv+5ik3xcTDJGaAgFz88lNo9UtRmQ69N0WYiUZFUxp2LOM9mb/H5lWqoxcul+193E2etWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269719; c=relaxed/simple;
	bh=dorXJXTWIWIP6/iW2KT5hpaWe+xzufigP/RnUc3Y5bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+E5m+9xU+0T2jKYhJ2bDqHKJ3dVLULoUR483oSY8RK99pHggATmstprlsh9FI2Squ9lvcfbjcRIlC+1gaXpOArtKPYfOVNBxjP00dFVYJMG9aiEeebMEjYDitSN2laGiieoLD2vIBkna5K9yEJU+07crakpVJh6OxAw2bYIZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD93D68BFE; Thu, 10 Apr 2025 09:21:50 +0200 (CEST)
Date: Thu, 10 Apr 2025 09:21:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Robin Murphy <robin.murphy@arm.com>, aleksander.lobakin@intel.com,
	andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
	catalin.marinas@arm.com, corbet@lwn.net, dakr@kernel.org,
	dan.j.williams@intel.com, dave.hansen@linux.intel.com,
	decui@microsoft.com, gregkh@linuxfoundation.org,
	haiyangz@microsoft.com, hch@lst.de, hpa@zytor.com,
	James.Bottomley@HansenPartnership.com, Jonathan.Cameron@huawei.com,
	kys@microsoft.com, leon@kernel.org, lukas@wunner.de,
	luto@kernel.org, m.szyprowski@samsung.com,
	martin.petersen@oracle.com, mingo@redhat.com, peterz@infradead.org,
	quic_zijuhu@quicinc.com, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, bperkins@microsoft.com,
	sunilmut@microsoft.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH hyperv-next 5/6] arch, drivers: Add device struct
 bitfield to not bounce-buffer
Message-ID: <20250410072150.GA32563@lst.de>
References: <20250409000835.285105-1-romank@linux.microsoft.com> <20250409000835.285105-6-romank@linux.microsoft.com> <0eb87302-fae8-4708-aaf8-d16e836e727f@arm.com> <0ab2849a-5c03-4a8c-891e-3cb89b20b0e4@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ab2849a-5c03-4a8c-891e-3cb89b20b0e4@linux.microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 09, 2025 at 09:44:03AM -0700, Roman Kisel wrote:
> Do you feel this is shoehorned in `struct device`? I couldn't find an
> appropriate private (== opaque pointer) part in the structure to store
> that bit (`struct device_private` wouldn't fit the bill) and looked like
> adding it to the struct itself would do no harm. However, my read of the
> room is that folks see that as dubious :)

We'll need per-device information.  But it is much higher level than a
need bounce buffer flag.


