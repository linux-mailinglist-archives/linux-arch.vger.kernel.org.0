Return-Path: <linux-arch+bounces-12458-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA5AE8AE3
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 19:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9940C4A1B50
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14820273D74;
	Wed, 25 Jun 2025 16:46:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D52E610B;
	Wed, 25 Jun 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870005; cv=none; b=D4QmXPoMrBRaFUj85dcauXB7qJ1gTTUiJlqZiSFZTCUNOUE/vOjPCykagwNwPhPWldWJCh5+YsQ8Dd1NWdQrsDxNQM8AW3W8pZQ3bjsF9CAnmwsKCcKWvh4ZfzA7Icb393DurnOLuTb1u9pY7npvCL/zg9v7RHM5iOEYWxDm9o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870005; c=relaxed/simple;
	bh=ko+3Y1n1A4cWcIARuacFagXbEWucMOHF+AFJwwiTTP4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wx6THB6IGZU+/SbNJ+wdiqLvm1Zf+PLtsC0dPzef3lhA/g1TR3gcSl0M+AZaOSU/nltFwioJV+ecavQLOGNKU6Umubpfw6pWu07P2GCkMB1EGMC5ZUISnPWhpvuVFyyX5Tlx0fV9FgAMZxsvO1OOvokI7MUrfPoESutaNtKsnO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bS74s1KL9z67M9n;
	Thu, 26 Jun 2025 00:46:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D74631402EC;
	Thu, 26 Jun 2025 00:46:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Jun
 2025 18:46:39 +0200
Date: Wed, 25 Jun 2025 17:46:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <gregkh@linuxfoundation.org>, Will Deacon
	<will@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, <linuxarm@huawei.com>
CC: Yicong Yang <yangyicong@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, H Peter Anvin
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>
Subject: Re: [PATCH v2 2/8] generic: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <20250625174637.0000732b@huawei.com>
In-Reply-To: <20250624154805.66985-3-Jonathan.Cameron@huawei.com>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
	<20250624154805.66985-3-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 16:47:58 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

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

I got carried away dropping some unused headers. This needs

linux/memregion.h


> +#include <linux/export.h>
> +#include <asm/cacheflush.h>
> +

So that the following have 'previous' prototypes.

> +int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len)
> +{
> +	guard(spinlock_irqsave)(&scfm_lock);
> +	if (!scfm_data)
> +		return -EOPNOTSUPP;
> +
> +	return scfm_data->invalidate_memregion(res_desc, start, len);
> +}
> +EXPORT_SYMBOL_NS_GPL(cpu_cache_invalidate_memregion, "DEVMEM");
> +
> +bool cpu_cache_has_invalidate_memregion(void)
> +{
> +	guard(spinlock_irqsave)(&scfm_lock);
> +	return !!scfm_data;
> +}
> +EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, "DEVMEM");

