Return-Path: <linux-arch+bounces-11349-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E68A822CB
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 12:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF87880328
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763AB25DCEB;
	Wed,  9 Apr 2025 10:52:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F31325DB19;
	Wed,  9 Apr 2025 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195958; cv=none; b=AO3RHSJxUsEQGfI7dkn/18tnxS9Wah1sCtyZ8Jg71J1Z3zkp89gYj4bx8GO2VflxCN92PcYYTgx1evt4kUHtcW6bmruHS1gvAv9jm8YGkIuKNU9OEzCfV2qUzl5rc1/s8GCjOPvyOE9kWrOJSHUz+7hqvJ1P1G2xN+y0mYkZpmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195958; c=relaxed/simple;
	bh=BR1EHKueh15kzSkRRwBqvUZ0N+7m1RLuau+j4r5Clws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=et0e13CcZmN2/oTyXuMUvXdH5pk3SE8nMCsUKNrYj+4vtcrCQG87SQYMyfedeGdDbsIYMP5ZaPeYPB3uYzj81YigJkHQZSFDUWtwo7TAfUyT2rAvJEQ6AxgqbEJGdTkYd7WhDZdhHADba1dpb+W3RhoByx2V9GW/ty2xZMqlTXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 689A368AA6; Wed,  9 Apr 2025 12:52:29 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:52:29 +0200
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
Subject: Re: [PATCH hyperv-next 5/6] arch, drivers: Add device struct
 bitfield to not bounce-buffer
Message-ID: <20250409105229.GA5721@lst.de>
References: <20250409000835.285105-1-romank@linux.microsoft.com> <20250409000835.285105-6-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409000835.285105-6-romank@linux.microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 08, 2025 at 05:08:34PM -0700, Roman Kisel wrote:
> Bounce-buffering makes the system spend more time copying
> I/O data. When the I/O transaction take place between
> a confidential and a non-confidential endpoints, there is
> no other way around.
> 
> Introduce a device bitfield to indicate that the device
> doesn't need to perform bounce buffering. The capable
> device may employ it to save on copying data around.

I have no idea what this is supposed to mean, you need to explain it
much better.


