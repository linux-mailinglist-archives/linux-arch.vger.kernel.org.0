Return-Path: <linux-arch+bounces-11014-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D6AA6B7D7
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 10:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522903B5D78
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 09:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE2B2222A4;
	Fri, 21 Mar 2025 09:38:33 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5EB221578;
	Fri, 21 Mar 2025 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549913; cv=none; b=AVMblDJI2ABOxmagjgWjWqD1qPI3Rd9x5X75oQMyjtQKTuv4xEndWsmh8T079Qqxs4bjQHN8zuXmDc3ctvmLMnFhp25JRENerV9ATu9KMARD9h5y+Y246WcO22AWHAEW7ksvcT3pehuCDedozR9nKB2K/KvdbSE9aN65sqSlYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549913; c=relaxed/simple;
	bh=6dg2biAD9hbahf/em6rIXS/4r8rvWiaQYmnzlJhQZsM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0t+gX+3pagjH6MulnJSwuDot6R9C9dXuMlsVYZiZQuLyFNWTpq8DWnEWgXRHfgMQwGVRc0iWdimmiZ40Yfyweig3S3iOCu+pqd3OM/GAkGa3+5O74m6oi5exxX+Osl4UdBlCK1FxU9jabeR7VXnRSbYbmzv1sOZ/4Yl0NwiLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZJy1R5Bsvz6L5GL;
	Fri, 21 Mar 2025 17:33:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DB00140517;
	Fri, 21 Mar 2025 17:38:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 10:38:27 +0100
Date: Fri, 21 Mar 2025 09:38:25 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<james.morse@arm.com>, <conor@kernel.org>, Yicong Yang
	<yangyicong@huawei.com>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, <linux-mm@kvack.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 3/6] cache: coherency device class
Message-ID: <20250321093825.00004d6b@huawei.com>
In-Reply-To: <2025032013-venus-request-b026@gregkh>
References: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
	<20250320174118.39173-4-Jonathan.Cameron@huawei.com>
	<2025032013-venus-request-b026@gregkh>
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

On Thu, 20 Mar 2025 14:12:15 -0700
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Mar 20, 2025 at 05:41:15PM +0000, Jonathan Cameron wrote:
> > --- a/drivers/cache/Kconfig
> > +++ b/drivers/cache/Kconfig
> > @@ -1,6 +1,12 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  menu "Cache Drivers"
> >  
> > +config CACHE_COHERENCY_CLASS
> > +	bool "Cache coherency control class"  
> 
> Why can't this be a module?  And why would anyone want to turn it off?

If you don't have the hardware you won't want the infrastructure.
I'll add a note.  If you do have the hardware and don't have memory subsystems
that need to use it (maybe no CXL hardware for instance and that's the only
user on a particular platform).

> 
> > +	help
> > +	  Class to which coherency control drivers register allowing core kernel
> > +	  subsystems to issue invalidations and similar coherency operations.  
> 
> What "core kernel subsystems".

I'll expand on that.  Memory hotplug related stuff (currently CXL and NVDIMM)
but the thing is more general that that.

> 
> > +
> >  config AX45MP_L2_CACHE
> >  	bool "Andes Technology AX45MP L2 Cache controller"
> >  	depends on RISCV  
> 
> Shouldn't all of these now depend on CACHE_COHERENCY_CLASS?

Nope. They are unrelated existing cache related drivers.   The question
to Conor is whether he minds me putting this in the existing directory
and to others on whether it's a good idea.

> 
> > diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
> > index 55c5e851034d..b72b20f4248f 100644
> > --- a/drivers/cache/Makefile
> > +++ b/drivers/cache/Makefile
> > @@ -3,3 +3,5 @@
> >  obj-$(CONFIG_AX45MP_L2_CACHE)		+= ax45mp_cache.o
> >  obj-$(CONFIG_SIFIVE_CCACHE)		+= sifive_ccache.o
> >  obj-$(CONFIG_STARFIVE_STARLINK_CACHE)	+= starfive_starlink_cache.o
> > +
> > +obj-$(CONFIG_CACHE_COHERENCY_CLASS)	+= coherency_core.o  
> 
> Why the blank line?

To separate existing stuff that happens to be cache related from this new
class.  Kind of camping in a directory because seemed silly to have
drivers/cache and drivers/cache_coherency


> 
> > diff --git a/drivers/cache/coherency_core.c b/drivers/cache/coherency_core.c
> > new file mode 100644
> > index 000000000000..52cb4ceae00c
> > --- /dev/null
> > +++ b/drivers/cache/coherency_core.c
> > @@ -0,0 +1,130 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Class to manage OS controlled coherency agents within the system.
> > + * Specifically to enable operations such as write back and invalidate.
> > + *
> > + * Copyright: Huawei 2025
> > + * Some elements based on fwctl class as an example of a modern
> > + * lightweight class.
> > + */
> > +
> > +#include <linux/cache_coherency.h>
> > +#include <linux/container_of.h>
> > +#include <linux/idr.h>
> > +#include <linux/fs.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +
> > +#include <asm/cacheflush.h>
> > +
> > +static DEFINE_IDA(cache_coherency_ida);
> > +
> > +static void cache_coherency_device_release(struct device *device)
> > +{
> > +	struct cache_coherency_device *ccd =
> > +		container_of(device, struct cache_coherency_device, dev);
> > +
> > +	ida_free(&cache_coherency_ida, ccd->id);
> > +}
> > +
> > +static struct class cache_coherency_class = {
> > +	.name = "cache_coherency",
> > +	.dev_release = cache_coherency_device_release,
> > +};
> > +
> > +static int cache_inval_one(struct device *dev, void *data)
> > +{
> > +	struct cache_coherency_device *ccd =
> > +		container_of(dev, struct cache_coherency_device, dev);
> > +
> > +	if (!ccd->ops)
> > +		return -EINVAL;
> > +
> > +	return ccd->ops->wbinv(ccd, data);
> > +}
> > +
> > +static int cache_inval_done_one(struct device *dev, void *data)
> > +{
> > +	struct cache_coherency_device *ccd =
> > +		container_of(dev, struct cache_coherency_device, dev);
> > +	if (!ccd->ops)
> > +		return -EINVAL;
> > +
> > +	return ccd->ops->done(ccd);
> > +}
> > +
> > +static int cache_invalidate_memregion(int res_desc,
> > +				      phys_addr_t addr, size_t size)
> > +{
> > +	int ret;
> > +	struct cc_inval_params params = {
> > +		.addr = addr,
> > +		.size = size,
> > +	};
> > +
> > +	ret = class_for_each_device(&cache_coherency_class, NULL, &params,
> > +				    cache_inval_one);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return class_for_each_device(&cache_coherency_class, NULL, NULL,
> > +				     cache_inval_done_one);
> > +}
> > +
> > +static const struct system_cache_flush_method cache_flush_method = {
> > +	.invalidate_memregion = cache_invalidate_memregion,
> > +};
> > +
> > +struct cache_coherency_device *
> > +_cache_coherency_alloc_device(struct device *parent,
> > +			      const struct coherency_ops *ops, size_t size)
> > +{
> > +
> > +	if (!ops || !ops->wbinv)
> > +		return NULL;
> > +
> > +	struct cache_coherency_device *ccd __free(kfree) = kzalloc(size, GFP_KERNEL);
> > +
> > +	if (!ccd)
> > +		return NULL;
> > +
> > +	ccd->dev.class = &cache_coherency_class;
> > +	ccd->dev.parent = parent;
> > +	ccd->ops = ops;
> > +	ccd->id = ida_alloc(&cache_coherency_ida, GFP_KERNEL);
> > +
> > +	if (dev_set_name(&ccd->dev, "cache_coherency%d", ccd->id))
> > +		return NULL;
> > +
> > + 	device_initialize(&ccd->dev);
> > +
> > +	return_ptr(ccd);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(_cache_coherency_alloc_device, "CACHE_COHERENCY");
> > +
> > +int cache_coherency_device_register(struct cache_coherency_device *ccd)
> > +{
> > +	return device_add(&ccd->dev);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cache_coherency_device_register, "CACHE_COHERENCY");
> > +
> > +void cache_coherency_device_unregister(struct cache_coherency_device *ccd)
> > +{
> > +	device_del(&ccd->dev);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cache_coherency_device_unregister, "CACHE_COHERENCY");
> > +
> > +static int __init cache_coherency_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = class_register(&cache_coherency_class);
> > +	if (ret)
> > +		return ret;
> > +
> > +	//TODO: generalize
> > +	arm64_set_sys_cache_flush_method(&cache_flush_method);  
> 
> I'm guessing this will blow up the build on non-x86 builds :)

Yup. That's a TODO That needs fixing.

> 
> > +struct cache_coherency_device {
> > +	struct device dev;
> > +	const struct coherency_ops *ops;
> > +	int id;
> > +};  
> 
> Classes are normally for user/kernel apis, what is this going to be used
> for?  I don't see any new user/kernel apis happening, so why do you need
> a struct device to be created?

I'm kind of expecting to grow some userspace ABI around a few things but
indeed there isn't any yet.  Stuff that has been suggested is:
* Descriptive stuff useful for performance estimation.
* Cache locking - as kind of the opposite of flushes.
* Maybe more direct user interfaces to control it (I'm wary of that though).

Mostly thought, the idea was  avoid rolling my own similar registration
infrastructure for this case.  Absolutely can do a subsystem without
a class if that seems to be the way to go. It'll be a little more complex
though.

Thanks,

Jonathan

> 
> thanks,
> 
> greg k-h
> 


