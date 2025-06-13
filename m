Return-Path: <linux-arch+bounces-12345-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DB2AD939A
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 19:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FAE3A7269
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E47223DC1;
	Fri, 13 Jun 2025 17:14:42 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8778F5E;
	Fri, 13 Jun 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834882; cv=none; b=vBVIVgRBhHeMnuzp4xFGiCuV1TycAizAtCg2Acxr+L2ojN5Icp5zFHsxcP/6uP20VQ8ItTr78WwLG7nuLAx/+cs99HBMfMG2u4Z2ifmwu7CPq+rs0vqEXhsWFouWtsME3siyr0zxzEUXFnnhLi5xc5ikVYvJ7VU50pi2iU4XxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834882; c=relaxed/simple;
	bh=qu+qSuW1vVQPvFQiNyNWumlLgRt91hsgnA+dNwyAfIw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXenOGzOZkF68CCJoRM/Rq7LldoORhaZ2P5/4MZvkXgjYDeX3/MWMm3SPHY/iztzxy0jBqwV8sgPCpU/dUmW2PQtUY+kPTkqkoPc02etCMX/hbl/Gj2n2Djq0PpBVpyV5wR93gNIfzuJmMWgY8a52cTJdJVBgNJSHESqneLBzHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJmDQ068yz6L4wf;
	Sat, 14 Jun 2025 01:12:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C596214033C;
	Sat, 14 Jun 2025 01:14:36 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Jun
 2025 19:14:36 +0200
Date: Fri, 13 Jun 2025 18:14:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, <yangyicong@hisilicon.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<james.morse@arm.com>, <conor@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, <linux-mm@kvack.org>,
	<gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, "Dan Williams"
	<dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 2/6] arm64: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <20250613181434.00004e7e@huawei.com>
In-Reply-To: <64ae0e68-b025-4a33-9389-5393ee887fb4@huawei.com>
References: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
	<20250320174118.39173-3-Jonathan.Cameron@huawei.com>
	<Z-bo7AQ1h6VQr65V@arm.com>
	<64ae0e68-b025-4a33-9389-5393ee887fb4@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 29 Mar 2025 15:14:14 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> On 2025/3/29 2:22, Catalin Marinas wrote:
> > On Thu, Mar 20, 2025 at 05:41:14PM +0000, Jonathan Cameron wrote:  
> >> +struct system_cache_flush_method {
> >> +	int (*invalidate_memregion)(int res_desc,
> >> +				    phys_addr_t start, size_t len);
> >> +};  
> > [...]  
> >> +int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len)
> >> +{
> >> +	guard(spinlock_irqsave)(&scfm_lock);
> >> +	if (!scfm_data)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	return scfm_data->invalidate_memregion(res_desc, start, len);
> >> +}  
> > 
> > WBINVD on x86 deals with the CPU caches as well. Even the API naming in
> > Linux implies CPU caches. IIUC, devices registering to the above on Arm
> > SoCs can only deal with system caches. Is it sufficient?
> >   
> 
> The device driver who register this method should handle this. If the
> hardware support maintaining the coherency among the system, for example
> on system cache invalidation the hardware is also able to invalidate the
> involved cachelines on all the subordinate caches (L1/L2/etc, by back
> invalidate snoop or other ways), then software don't need to invalidate
> the non-system cache explicitly. Otherwise the driver need to explicitly
> invalidate the non-system cache explicitly in their
> scfm_data::invalidate_memregion() method. Here in the generally code we
> simply don't know the capability of the hardware.

Coming to this a little late.  It would definitely be helpful to understand
whether other hardware implementations where this is relevant (e.g. CXL
capable systems) do require explicit flushes of the caches nearer the
CPU and any dance that they need in that case to ensure no race conditions
leave stale lines.

The PSCI spec (that never was) did allow for reporting that it was necessary
to stop all traffic prior to flushes, but that is crazy to support and
someone built the wrong system if they need to do that under even
vaguely normal software flows.

Jonathan
 
> 
> Thanks.
> 


