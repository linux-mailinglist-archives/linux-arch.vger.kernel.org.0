Return-Path: <linux-arch+bounces-12629-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432D4AFFFD7
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 12:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235DE3B5C69
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 10:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659662E0934;
	Thu, 10 Jul 2025 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q53Dg/bF"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F824501E;
	Thu, 10 Jul 2025 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145014; cv=none; b=kvDpCzpPDyUm+UmskiLD9RhhgKZXWZQ0ziawGq1oudGM8GWqso/Sdv8nVcTLlPTgWuhXnYI/ZpzMcAak+Y0WY550GKmEWIPFYPXlE4hxP8xW/1C3E6TRycy43t+PyETE86Bej5ii21VkukecYe1ZUiPYlGy4YXcTDvgdhAtPGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145014; c=relaxed/simple;
	bh=o8El/2R0L0tYY8cKePR2oJVpacZopffryurxXYvCDcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZiXqdVLyjK7WXqRZoOmWwRVm8w6N1wfJguRrAgr4ybGhO8qdMl5d35j3aA87FHYlDdZZLpLOn+IzQaCKRxxIGbqgTm/EnJKyOmWxtwX89AS/tnT7tEARQWy7s22IfpVAsAAQr8WeLn4NruwAr3P2CXSamWieY9nv3TfuXsVfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q53Dg/bF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7pEA1uNTqPvv6+XR/zuY/aMB8/9LJc6Rsl4Iqenx7gQ=; b=Q53Dg/bFa0IOiKKDOS+53JMqLd
	rWu6gVsz2DbYQS7/ZS4GsN7sNLBcFe5gtoDTA70AVg1E6+YN+gLVdwXFrHrG7RJBHNdiLIHL2Hqig
	eJ+2QJCO3siJAdamLStruKmbDre9sLI7jMYWnF5BCA5rSs1oL0ob/BF6Fe8Z63IeS5ED3rgQepKHw
	Rp9hPkGAAcNYMOaycRM3nSDZknPNn/2oJ9rQv0kHpzKQaU4FkLsK9SaAIbtD4844S1AGIiqdNQ/1B
	I/5ta9es7JbfQwyn1KjbLHwNTOA5vk9C05tctaYwRZOGHrIASCwI7FNGr7RW4hxkUIp3aRH6mBZtm
	iTMs9ePg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZowy-00000008aeW-27gb;
	Thu, 10 Jul 2025 10:56:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0B932300125; Thu, 10 Jul 2025 12:56:23 +0200 (CEST)
Date: Thu, 10 Jul 2025 12:56:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: dan.j.williams@intel.com
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org,
	Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 0/8] Cache coherency management subsystem
Message-ID: <20250710105622.GA542000@noisy.programming.kicks-ass.net>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
 <20250625085204.GC1613200@noisy.programming.kicks-ass.net>
 <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com>
 <20250625093152.GZ1613376@noisy.programming.kicks-ass.net>
 <686f4e20c57cd_1d3d100b7@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686f4e20c57cd_1d3d100b7@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Jul 09, 2025 at 10:22:40PM -0700, dan.j.williams@intel.com wrote:

> "Regular?", no. Something is wrong if you are doing this regularly. In
> current CXL systems the expectation is to suffer a WBINVD event once per
> server provisioning event.

Ok, so how about we strictly track this once, and when it happens more
than this once, we error out hard?

> Now, there is a nascent capability called "Dynamic Capacity Devices"
> (DCD) where the CXL configuration is able to change at runtime with
> multiple hosts sharing a pool of memory. Each time the physical memory
> capacity changes, cache management is needed.
> 
> For DCD, I think the negative effects of WBINVD are a *useful* stick to
> move device vendors to stop relying on software to solve this problem.
> They can implement an existing CXL protocol where the device tells CPUs
> and other CXL.cache agents to invalidate the physical address ranges
> that the device owns.
> 
> In other words, if WBINVD makes DCD inviable that is a useful outcome
> because it motivates unburdening Linux long term with this problem.

Per the above, I suggest we not support this feature *AT*ALL* until an
alternative to WBINVD is provided.

> In the near term though, current CXL platforms that do not support
> device-initiated-invalidate still need coarse cache management for that
> original infrequent provisioning events. Folks that want to go further
> and attempt frequent DCD events with WBINVD get to keep all the pieces.

I would strongly prefer those pieces to include WARNs and or worse.

