Return-Path: <linux-arch+bounces-12446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB74AE6C4F
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA411885B4E
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 16:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6C192598;
	Tue, 24 Jun 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qW+iT8/r"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A082DDC5;
	Tue, 24 Jun 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781813; cv=none; b=I9cb4nNUo4V497nifNhre7hXIqoO2yxrK4+uu1bwaRskNUAwdeP3cvx+dZiY37RYfsqZmt8YXKAe65ISt9L7k+0qb49OLGA24dt1lM77FcsrhYHoPUlNk2H5kthOUm9A35516FTlW+6FFe172+iOjIlgttZ+decO12ZvMH5eRyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781813; c=relaxed/simple;
	bh=8gl1rLZNofAk2fof2YGBHaM5ebdXQZzyZfIQBIqfrGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp2bFpwBNEEfRtMPrenisBzGQ0PYB5K/63zVaBHX+5lDdGUaPyhJo2HdhEcSgdRifmaC9gsF7VKElkSK9g0UQdkf3wpkq/MhW511tkVIIvHwBKRzLXBI574t7e6yVX8a02m1IPuk83NkHU7LuFPMfDygcZ9B6oA/oJLOS9HzSkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qW+iT8/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7092CC4CEE3;
	Tue, 24 Jun 2025 16:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750781812;
	bh=8gl1rLZNofAk2fof2YGBHaM5ebdXQZzyZfIQBIqfrGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qW+iT8/rsJkuyydGDGHb8KNzu5Fem+I5+k86517u6RHxYUMT3QX+o7hLK8Qaf+v5P
	 Ucpo6f9iuC5p59VlLBER+lJwCjJ+0excGOnQEkIhR4PdLsSdZSLdxvtsIR8ERIGYJk
	 PdyGDvUBZLGO5mE2WaXTxs/YYp+Tz7zl2Mc5LjeM=
Date: Tue, 24 Jun 2025 17:16:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, H Peter Anvin <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/8] generic: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <2025062439-submitter-affection-324b@gregkh>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
 <20250624154805.66985-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624154805.66985-3-Jonathan.Cameron@huawei.com>

On Tue, Jun 24, 2025 at 04:47:58PM +0100, Jonathan Cameron wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION provides the mechanism for
> invalidate certain memory regions in a cache-incoherent manner.
> Currently is used by NVIDMM adn CXL memory. This is mainly done
> by the system component and is implementation define per spec.
> Provides a method for the platforms register their own invalidate
> method and implement ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION.
> 
> Architectures can opt in for this support via
> CONFIG_GENERIC_CPU_CACHE_INVALIDATE_MEMREGION.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/base/Kconfig             |  3 +++
>  drivers/base/Makefile            |  1 +
>  drivers/base/cache.c             | 46 ++++++++++++++++++++++++++++++++
>  include/asm-generic/cacheflush.h | 12 +++++++++
>  4 files changed, 62 insertions(+)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 064eb52ff7e2..cc6df87a0a96 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -181,6 +181,9 @@ config SYS_HYPERVISOR
>  	bool
>  	default n
>  
> +config GENERIC_CPU_CACHE_INVALIDATE_MEMREGION
> +	bool
> +
>  config GENERIC_CPU_DEVICES
>  	bool
>  	default n
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 8074a10183dc..0fbfa4300b98 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
>  obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
>  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
>  obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
> +obj-$(CONFIG_GENERIC_CPU_CACHE_INVALIDATE_MEMREGION) += cache.o
>  obj-$(CONFIG_ACPI) += physical_location.o
>  
>  obj-y			+= test/
> diff --git a/drivers/base/cache.c b/drivers/base/cache.c
> new file mode 100644
> index 000000000000..8d351657bbef
> --- /dev/null
> +++ b/drivers/base/cache.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic support for CPU Cache Invalidate Memregion
> + */
> +
> +#include <linux/spinlock.h>
> +#include <linux/export.h>
> +#include <asm/cacheflush.h>
> +
> +
> +static const struct system_cache_flush_method *scfm_data;
> +DEFINE_SPINLOCK(scfm_lock);

Shouldn't this lock be static?  I don't see it being used outside of
this file, and it's not exported.

thanks,

greg k-h

