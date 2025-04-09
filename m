Return-Path: <linux-arch+bounces-11350-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52F0A822D2
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 12:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3F84C0F6B
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 10:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A425DAEE;
	Wed,  9 Apr 2025 10:53:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351B450FE;
	Wed,  9 Apr 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196018; cv=none; b=goiDkuuNusYrUGuucpUYULcuC75OqZcIiJm3tgMA3pDRQ5tB+cYH/1pFw8BuA/SbsYXHHPxgHKGIE0y2fMGgwpZeyTnqyuSquNGEJ1INHEyUdCDotgXwHEJeB0iaeh1qjTzJ64SzvU2kP+sZ0+KZ9UsbAk9Tj8dvsRk+cRHKL+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196018; c=relaxed/simple;
	bh=JwKagc0gMx2mFyAxYVIcZCLeZoivLsN5xHo8YX1/wkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0zv06pSNFpEaIeQw9F66etMnRj98//sk2apJmZvqgK2AHrM/Dq0xchbrgt45WL/365hFCGiIFiEYXVs6SyAVYjRNCGAbtjrw/wYd8S+HzC4ej01OVb65nHyRVG+CkMP19iqAZ3aHjIppVzNR7dw82B1fz/mgUrUOLPGqA0aW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3B5168BFE; Wed,  9 Apr 2025 12:53:32 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:53:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: aleksander.lobakin@intel.com, andriy.shevchenko@linux.intel.com,
	arnd@arndb.de, bp@alien8.de, catalin.marinas@arm.com,
	corbet@lwn.net, dakr@kernel.org, dan.j.williams@intel.com,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	gregkh@linuxfoundation.org, haiyangz@microsoft.com, hch@lst.de,
	hpa@zytor.com, James.Bottomley@HansenPartnership.com,
	Jonathan.Cameron@huawei.com, kys@microsoft.com, leon@kernel.org,
	lukas@wunner.de, luto@kernel.org, m.szyprowski@samsung.com,
	martin.petersen@oracle.com, mingo@redhat.com, peterz@infradead.org,
	quic_zijuhu@quicinc.com, robin.murphy@arm.com, tglx@linutronix.de,
	wei.liu@kernel.org, will@kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next 6/6] drivers: SCSI: Do not bounce-bufffer
 for the confidential VMBus
Message-ID: <20250409105332.GB5721@lst.de>
References: <20250409000835.285105-1-romank@linux.microsoft.com> <20250409000835.285105-7-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409000835.285105-7-romank@linux.microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 08, 2025 at 05:08:35PM -0700, Roman Kisel wrote:
> The device bit that indicates that the device is capable of I/O
> with private pages lets avoid excessive copying in the Hyper-V
> SCSI driver.
> 
> Set that bit equal to the confidential external memory one to
> not bounce buffer

Drivers have absolutely no business telling this.  The need for bounce
buffering or not is a platform/IOMMU decision and not one specific to
a certain device or driver.


