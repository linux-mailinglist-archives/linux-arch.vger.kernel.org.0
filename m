Return-Path: <linux-arch+bounces-12660-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93390B01B34
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 13:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C4B3B2D3F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 11:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C024928AB03;
	Fri, 11 Jul 2025 11:53:36 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD027EFEA;
	Fri, 11 Jul 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234816; cv=none; b=AXc91Xox1FH4XLD6ZO7/86k261JkAhsEWGZuPBeiQ8Mk8I9cel3iYluBpLifZSX86BBTeNY3OOr/wxL5WIxd9guIrrb+BlQYuXiErr9gnTR9mOXfoMbKl0C+JNYLkXrtB7oKMzMJakZIDvkSyNml6gltCRDAsCbbbpJrD+mBLN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234816; c=relaxed/simple;
	bh=aWad79DjDr0pM3umbI6RcCIVWYm427VfUpk5RGjFDB0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaDJ+8tFSnw2EQS5vFKtv4AZMox3yD4FjtVjDHLb/9Ur8P5xHRFiwiNzvJsVFiGCPxK8YFBXaNmwJLYWyxQqw1brOBKwFNRxqcngX95vq+yNGSyK3ZUswC3UFTmyehAoKWecIe10dBbYmjf9Vd8DS3+loQBXe782FFqvznenJeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdqlT12Ykz6L53x;
	Fri, 11 Jul 2025 19:50:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F3E01400D3;
	Fri, 11 Jul 2025 19:53:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 13:53:30 +0200
Date: Fri, 11 Jul 2025 12:53:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "H. Peter Anvin" <hpa@zytor.com>
CC: <dan.j.williams@intel.com>, Catalin Marinas <catalin.marinas@arm.com>,
	<james.morse@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
	<gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, "Yicong Yang" <yangyicong@huawei.com>,
	<linuxarm@huawei.com>, Yushan Wang <wangyushan12@huawei.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/8] generic: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <20250711125328.00002334@huawei.com>
In-Reply-To: <C8F33767-6C7F-4CDA-8B78-6857AA771AD3@zytor.com>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
	<20250624154805.66985-3-Jonathan.Cameron@huawei.com>
	<686f565121ea5_1d3d100ee@dwillia2-xfh.jf.intel.com.notmuch>
	<C8F33767-6C7F-4CDA-8B78-6857AA771AD3@zytor.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 09 Jul 2025 23:01:50 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On July 9, 2025 10:57:37 PM PDT, dan.j.williams@intel.com wrote:
> >Jonathan Cameron wrote:  
> >> From: Yicong Yang <yangyicong@hisilicon.com>
> >> 
> >> ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION provides the mechanism for
> >> invalidate certain memory regions in a cache-incoherent manner.
> >> Currently is used by NVIDMM adn CXL memory. This is mainly done
> >> by the system component and is implementation define per spec.
> >> Provides a method for the platforms register their own invalidate
> >> method and implement ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION.  
> >
> >Please run spell-check on changelogs.
> >  
> >> 
> >> Architectures can opt in for this support via
> >> CONFIG_GENERIC_CPU_CACHE_INVALIDATE_MEMREGION.
> >> 
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> ---
> >>  drivers/base/Kconfig             |  3 +++
> >>  drivers/base/Makefile            |  1 +
> >>  drivers/base/cache.c             | 46 ++++++++++++++++++++++++++++++++  
> >
> >I do not understand what any of this has to do with drivers/base/.
> >
> >See existing cache management memcpy infrastructure in lib/Kconfig.
> >  
> >>  include/asm-generic/cacheflush.h | 12 +++++++++
> >>  4 files changed, 62 insertions(+)
> >> 
> >> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> >> index 064eb52ff7e2..cc6df87a0a96 100644
> >> --- a/drivers/base/Kconfig
> >> +++ b/drivers/base/Kconfig
> >> @@ -181,6 +181,9 @@ config SYS_HYPERVISOR
> >>  	bool
> >>  	default n
> >>  
> >> +config GENERIC_CPU_CACHE_INVALIDATE_MEMREGION
> >> +	bool
> >> +
> >>  config GENERIC_CPU_DEVICES
> >>  	bool
> >>  	default n
> >> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> >> index 8074a10183dc..0fbfa4300b98 100644
> >> --- a/drivers/base/Makefile
> >> +++ b/drivers/base/Makefile
> >> @@ -26,6 +26,7 @@ obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
> >>  obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
> >>  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
> >>  obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
> >> +obj-$(CONFIG_GENERIC_CPU_CACHE_INVALIDATE_MEMREGION) += cache.o
> >>  obj-$(CONFIG_ACPI) += physical_location.o
> >>  
> >>  obj-y			+= test/
> >> diff --git a/drivers/base/cache.c b/drivers/base/cache.c
> >> new file mode 100644
> >> index 000000000000..8d351657bbef
> >> --- /dev/null
> >> +++ b/drivers/base/cache.c
> >> @@ -0,0 +1,46 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Generic support for CPU Cache Invalidate Memregion
> >> + */
> >> +
> >> +#include <linux/spinlock.h>
> >> +#include <linux/export.h>
> >> +#include <asm/cacheflush.h>
> >> +
> >> +
> >> +static const struct system_cache_flush_method *scfm_data;
> >> +DEFINE_SPINLOCK(scfm_lock);
> >> +
> >> +void generic_set_sys_cache_flush_method(const struct system_cache_flush_method *method)
> >> +{
> >> +	guard(spinlock_irqsave)(&scfm_lock);
> >> +	if (scfm_data || !method || !method->invalidate_memregion)
> >> +		return;
> >> +
> >> +	scfm_data = method;  
> >
> >The lock looks unnecessary here, this is just atomic_cmpxchg().
> >  
> >> +}
> >> +EXPORT_SYMBOL_GPL(generic_set_sys_cache_flush_method);
> >> +
> >> +void generic_clr_sys_cache_flush_method(const struct system_cache_flush_method *method)
> >> +{
> >> +	guard(spinlock_irqsave)(&scfm_lock);
> >> +	if (scfm_data && scfm_data == method)
> >> +		scfm_data = NULL;  
> >
> >Same here, but really what is missing is a description of the locking
> >requirements of cpu_cache_invalidate_memregion().
> >
> >  
> >> +}
> >> +
> >> +int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len)
> >> +{
> >> +	guard(spinlock_irqsave)(&scfm_lock);
> >> +	if (!scfm_data)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	return scfm_data->invalidate_memregion(res_desc, start, len);  
> >
> >Is it really the case that you need to disable interrupts during cache
> >operations? For potentially flushing 10s to 100s of gigabytes, is it
> >really the case that all archs can support holding interrupts off for
> >that event?
> >
> >A read lock (rcu or rwsem) seems sufficient to maintain registration
> >until the invalidate operation completes.
> >
> >If an arch does need to disable interrupts while it manages caches that
> >does not feel like something that should be enforced for everyone at
> >this top-level entry point.
> >  
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cpu_cache_invalidate_memregion, "DEVMEM");
> >> +
> >> +bool cpu_cache_has_invalidate_memregion(void)
> >> +{
> >> +	guard(spinlock_irqsave)(&scfm_lock);
> >> +	return !!scfm_data;  
> >
> >Lock seems pointless here.
> >
> >More concerning is this diverges from the original intent of this
> >function which was to disable physical address space manipulation from
> >virtual environments.
> >
> >Now, different archs may have reason to diverge here but the fact that
> >the API requirements are non-obvious points at a minimum to missing
> >documentation if not missing cross-arch consensus.
> >  
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, "DEVMEM");
> >> diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
> >> index 7ee8a179d103..87e64295561e 100644
> >> --- a/include/asm-generic/cacheflush.h
> >> +++ b/include/asm-generic/cacheflush.h
> >> @@ -124,4 +124,16 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
> >>  	} while (0)
> >>  #endif
> >>  
> >> +#ifdef CONFIG_GENERIC_CPU_CACHE_INVALIDATE_MEMREGION
> >> +
> >> +struct system_cache_flush_method {
> >> +	int (*invalidate_memregion)(int res_desc,
> >> +				    phys_addr_t start, size_t len);
> >> +};  
> >
> >The whole point of ARCH_HAS facilities is to resolve symbols like this
> >at compile time. Why does this need a indirect function call at all?  
> 
> Yes, blocking interrupts is much like the problem with WBINVD.
> 
> More or less, once user space is running, this isn't acceptable.
It's a bug that I missed in dragging this from a very different implementation.

Will fix for v3.

J
> 


