Return-Path: <linux-arch+bounces-10997-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BA4A6AFB1
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 22:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8949188C65F
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 21:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA01E8337;
	Thu, 20 Mar 2025 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iaMJ49FB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E51E5B7E;
	Thu, 20 Mar 2025 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742505216; cv=none; b=tMUYL740RmojMHkcuC6jiiRm9TUIJzaQS1ms2Q5Mtuq2JvRhv1c6TbQIJe2ns+Op10ATzf8n3MYeFlaeHNjH+Y3eG5JKPi+FkJelR0MWWjgvYacAX2ENaIb/RsOn2z6GCl+gJHA1SE+BH0hVXfsqdxuWmPCkY5PHci201+XNbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742505216; c=relaxed/simple;
	bh=qT3pRQIRt1i35oXtu0ODXFreqqI/+Y7zQS4P0enG44U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFLP9rJN421yN2FCYYVq4Pp2at8LvlIYUekpNWy9/cP77CsMee7b5EOJl9eC1Yqzecjdm3PYc7/pQ1ehiwDpGVGUdtZRnVu/ymzkBDKcDv5PrW16XiFNpKQEL2BzI5JZ8OiAeQNbOJCZ3Zy0O9sVkS4YF5O9t0jWcIJCyo82BQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iaMJ49FB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F231C4CEDD;
	Thu, 20 Mar 2025 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742505215;
	bh=qT3pRQIRt1i35oXtu0ODXFreqqI/+Y7zQS4P0enG44U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iaMJ49FB16G+FlJRuy97OCfjA+ZbWBl3XVzcBMcaKwrB06G5d36541muYB5cmaXHu
	 YMMt/nHuOhUyOpB+eQ4xO2cyWMn+axk3d7aTdXz2tEEpUBygHFk0M9oDEEwHS0uJPd
	 EKgLazyXP8IsrH66Cm5uouuHXXVNfRPzAwLWxRrU=
Date: Thu, 20 Mar 2025 14:12:15 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	james.morse@arm.com, conor@kernel.org,
	Yicong Yang <yangyicong@huawei.com>, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>, linux-mm@kvack.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 3/6] cache: coherency device class
Message-ID: <2025032013-venus-request-b026@gregkh>
References: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
 <20250320174118.39173-4-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320174118.39173-4-Jonathan.Cameron@huawei.com>

On Thu, Mar 20, 2025 at 05:41:15PM +0000, Jonathan Cameron wrote:
> --- a/drivers/cache/Kconfig
> +++ b/drivers/cache/Kconfig
> @@ -1,6 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>  menu "Cache Drivers"
>  
> +config CACHE_COHERENCY_CLASS
> +	bool "Cache coherency control class"

Why can't this be a module?  And why would anyone want to turn it off?

> +	help
> +	  Class to which coherency control drivers register allowing core kernel
> +	  subsystems to issue invalidations and similar coherency operations.

What "core kernel subsystems"?

> +
>  config AX45MP_L2_CACHE
>  	bool "Andes Technology AX45MP L2 Cache controller"
>  	depends on RISCV

Shouldn't all of these now depend on CACHE_COHERENCY_CLASS?

> diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
> index 55c5e851034d..b72b20f4248f 100644
> --- a/drivers/cache/Makefile
> +++ b/drivers/cache/Makefile
> @@ -3,3 +3,5 @@
>  obj-$(CONFIG_AX45MP_L2_CACHE)		+= ax45mp_cache.o
>  obj-$(CONFIG_SIFIVE_CCACHE)		+= sifive_ccache.o
>  obj-$(CONFIG_STARFIVE_STARLINK_CACHE)	+= starfive_starlink_cache.o
> +
> +obj-$(CONFIG_CACHE_COHERENCY_CLASS)	+= coherency_core.o

Why the blank line?

> diff --git a/drivers/cache/coherency_core.c b/drivers/cache/coherency_core.c
> new file mode 100644
> index 000000000000..52cb4ceae00c
> --- /dev/null
> +++ b/drivers/cache/coherency_core.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Class to manage OS controlled coherency agents within the system.
> + * Specifically to enable operations such as write back and invalidate.
> + *
> + * Copyright: Huawei 2025
> + * Some elements based on fwctl class as an example of a modern
> + * lightweight class.
> + */
> +
> +#include <linux/cache_coherency.h>
> +#include <linux/container_of.h>
> +#include <linux/idr.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include <asm/cacheflush.h>
> +
> +static DEFINE_IDA(cache_coherency_ida);
> +
> +static void cache_coherency_device_release(struct device *device)
> +{
> +	struct cache_coherency_device *ccd =
> +		container_of(device, struct cache_coherency_device, dev);
> +
> +	ida_free(&cache_coherency_ida, ccd->id);
> +}
> +
> +static struct class cache_coherency_class = {
> +	.name = "cache_coherency",
> +	.dev_release = cache_coherency_device_release,
> +};
> +
> +static int cache_inval_one(struct device *dev, void *data)
> +{
> +	struct cache_coherency_device *ccd =
> +		container_of(dev, struct cache_coherency_device, dev);
> +
> +	if (!ccd->ops)
> +		return -EINVAL;
> +
> +	return ccd->ops->wbinv(ccd, data);
> +}
> +
> +static int cache_inval_done_one(struct device *dev, void *data)
> +{
> +	struct cache_coherency_device *ccd =
> +		container_of(dev, struct cache_coherency_device, dev);
> +	if (!ccd->ops)
> +		return -EINVAL;
> +
> +	return ccd->ops->done(ccd);
> +}
> +
> +static int cache_invalidate_memregion(int res_desc,
> +				      phys_addr_t addr, size_t size)
> +{
> +	int ret;
> +	struct cc_inval_params params = {
> +		.addr = addr,
> +		.size = size,
> +	};
> +
> +	ret = class_for_each_device(&cache_coherency_class, NULL, &params,
> +				    cache_inval_one);
> +	if (ret)
> +		return ret;
> +
> +	return class_for_each_device(&cache_coherency_class, NULL, NULL,
> +				     cache_inval_done_one);
> +}
> +
> +static const struct system_cache_flush_method cache_flush_method = {
> +	.invalidate_memregion = cache_invalidate_memregion,
> +};
> +
> +struct cache_coherency_device *
> +_cache_coherency_alloc_device(struct device *parent,
> +			      const struct coherency_ops *ops, size_t size)
> +{
> +
> +	if (!ops || !ops->wbinv)
> +		return NULL;
> +
> +	struct cache_coherency_device *ccd __free(kfree) = kzalloc(size, GFP_KERNEL);
> +
> +	if (!ccd)
> +		return NULL;
> +
> +	ccd->dev.class = &cache_coherency_class;
> +	ccd->dev.parent = parent;
> +	ccd->ops = ops;
> +	ccd->id = ida_alloc(&cache_coherency_ida, GFP_KERNEL);
> +
> +	if (dev_set_name(&ccd->dev, "cache_coherency%d", ccd->id))
> +		return NULL;
> +
> + 	device_initialize(&ccd->dev);
> +
> +	return_ptr(ccd);
> +}
> +EXPORT_SYMBOL_NS_GPL(_cache_coherency_alloc_device, "CACHE_COHERENCY");
> +
> +int cache_coherency_device_register(struct cache_coherency_device *ccd)
> +{
> +	return device_add(&ccd->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cache_coherency_device_register, "CACHE_COHERENCY");
> +
> +void cache_coherency_device_unregister(struct cache_coherency_device *ccd)
> +{
> +	device_del(&ccd->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cache_coherency_device_unregister, "CACHE_COHERENCY");
> +
> +static int __init cache_coherency_init(void)
> +{
> +	int ret;
> +
> +	ret = class_register(&cache_coherency_class);
> +	if (ret)
> +		return ret;
> +
> +	//TODO: generalize
> +	arm64_set_sys_cache_flush_method(&cache_flush_method);

I'm guessing this will blow up the build on non-x86 builds :)

> +struct cache_coherency_device {
> +	struct device dev;
> +	const struct coherency_ops *ops;
> +	int id;
> +};

Classes are normally for user/kernel apis, what is this going to be used
for?  I don't see any new user/kernel apis happening, so why do you need
a struct device to be created?

thanks,

greg k-h

