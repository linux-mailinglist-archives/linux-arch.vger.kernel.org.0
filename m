Return-Path: <linux-arch+bounces-14294-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41840C00AA6
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 13:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31023B134E
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165F2287254;
	Thu, 23 Oct 2025 11:13:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A32DF155;
	Thu, 23 Oct 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218033; cv=none; b=cdqw1sQEKlUKgXW5fuua9z6/DT2qnVNvpxffc5lxpP3P5hgTXQW/b9ag14Nnaof8dG0X+JA77SV7qc3Tv3hfFKobBma+lbYkCiaDCKj52PnJYYc9CBz9vbBXN/VodvB+SQO2myc0WWlyyXUHu4XIMR3rEE4G9ulnX0+GghPFbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218033; c=relaxed/simple;
	bh=RSGx3UFC5kY1J2z8l+llr/jmNvjTgYfOe7TCc6etFAo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTvxm0FLtwrUFRW54oz1AoHe7LT9QUYfgReVUnXuxMlyOvfv1taUD1NWlfIP29bcgLsOiRbkRFNdxzvN0aMfBF3W+5w0lqKqwaC1x1rOLx4G716uHq2olPnNtKKUR7Vjh1YeMG5dPNyC13bUtwQJOIg+2NHpI4mcmlVxl9XMzjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4csjx65rM2z6M4gf;
	Thu, 23 Oct 2025 19:10:02 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 42B8B140279;
	Thu, 23 Oct 2025 19:13:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 12:13:43 +0100
Date: Thu, 23 Oct 2025 12:13:41 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <james.morse@arm.com>, Will Deacon
	<will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	<linuxarm@huawei.com>, Yushan Wang <wangyushan12@huawei.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	<x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, "Dave Jiang"
	<dave.jiang@intel.com>
Subject: Re: [PATCH v4 3/6] lib: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <20251023121341.0000765c@huawei.com>
In-Reply-To: <20251022-tried-alright-752fa98ff086@spud>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
	<20251022113349.1711388-4-Jonathan.Cameron@huawei.com>
	<20251022-tried-alright-752fa98ff086@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 22 Oct 2025 22:11:12 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Oct 22, 2025 at 12:33:46PM +0100, Jonathan Cameron wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> > 
> > ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION provides the mechanism for
> > invalidating certain memory regions in a cache-incoherent manner. Currently
> > this is used by NVDIMM and CXL memory drivers in cases where it is
> > necessary to flush all data from caches by physical address range.
> > 
> > In some architectures these operations are supported by system components
> > that may become available only later in boot as they are either present
> > on a discoverable bus, or via a firmware description of an MMIO interface
> > (e.g. ACPI DSDT). Provide a framework to handle this case.
> > 
> > Architectures can opt in for this support via
> > CONFIG_GENERIC_CPU_CACHE_MAINTENANCE
> > 
> > Add a registration framework. Each driver provides an ops structure and
> > the first op is Write Back and Invalidate by PA Range. The driver may
> > over invalidate.
> > 
> > An optional completion check operation is also provided. If present
> > that should be called to ensure that the action has finished.
> > 
> > When multiple agents are present in the system each should register with
> > this framework and the core code will issue the invalidate to all of them
> > before checking for completion on each. This is done to avoid need for
> > filtering in the core code which can become complex when interleave,
> > potentially across different cache coherency hardware is going on, so it
> > is easier to tell everyone and let those who don't care do nothing.
> > 
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> I'm fine with this stuff. I do wonder though, have you actually
> encountered systems with the multiple "agents" or is that something
> theoretical?

Yes to multiple agents. There are a multiple instances in the HiSi platform.
The multiple heterogeneous agents case is more theoretical today.  Similar
components for other purposes are heterogeneous so I'd be surprised if it
doesn't surface at some point. Our initial internal driver for the
hisi_hha wrapped up the multiple instances in a fake front end, but it
meant we ended up with multiple levels of registration and it was just
simpler to relax assumption that they were all handled by one driver.

Jonathan



