Return-Path: <linux-arch+bounces-13367-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B245B426D7
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 18:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02DE188D862
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85952E9EAC;
	Wed,  3 Sep 2025 16:25:09 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C252D2389;
	Wed,  3 Sep 2025 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916709; cv=none; b=L37CoaAiYSIN2aNr4WUWKWWggyqORKytDQVFdBjPn9zxnjIS55Z0lYiB86apeaeQWzV2gqxHjFsvCW63A2dUW51qFLajBnUMbJ1IV2R9jbeGbYR1MC2I9+O9bDusVv2C11gVYYPvTef3R2s/MUpnauBus3Je9T0u9D4DsZGU3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916709; c=relaxed/simple;
	bh=cgpUpMcs0TZ+BTiy4jhYZlsUuXa74ohmhvxC655ADM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBkQIbwf2rTaWL0bLNsn2+GFUvXKh/gZ3XjFKWS8/EK1Re3yRd+cIEaRADWPO7gZNJdMS+3lw4aCCaylFvN6AYlga3C4auB2s8ulTFb5LwhX3oMGzz2zSxFC56fCkpb9o9Q8vaa9QIf1bWtVmhT5gdA8+zANJPm/OTcAQnM9u90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23600C4CEE7;
	Wed,  3 Sep 2025 16:25:04 +0000 (UTC)
Date: Wed, 3 Sep 2025 17:25:02 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: james.morse@arm.com, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 3/8] lib: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <aLhr3v4z_YIYaq9Z@arm.com>
References: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
 <20250820102950.175065-4-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820102950.175065-4-Jonathan.Cameron@huawei.com>

On Wed, Aug 20, 2025 at 11:29:45AM +0100, Jonathan Cameron wrote:
> diff --git a/lib/Kconfig b/lib/Kconfig
> index c483951b624f..cd8e5844f9bb 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -543,6 +543,9 @@ config MEMREGION
>  config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>  	bool
>  
> +config GENERIC_CPU_CACHE_MAINTENANCE
> +	bool

Nit: you could select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION here since
the interface is now provided by the generic implementation.

-- 
Catalin

