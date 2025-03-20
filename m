Return-Path: <linux-arch+bounces-10989-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAE2A6AC49
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 18:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88686188F92C
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC302253A9;
	Thu, 20 Mar 2025 17:42:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCDC224231;
	Thu, 20 Mar 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492578; cv=none; b=QEGK2Laj7JxF5GaXATbzLLc6Fn9WDFbaPlyEogsGzJUwNYFhO9gRUqlX6jOSvSwaA4webSz6sFb/sHI4GLG3KSn/Vh11Wdh840hx6TUMcAURl+0E0jhuosPZR/DykfC5CAe5e7TteWiwcAz0Ra2Y/cg+xSKL82aAw+NIO8u1kas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492578; c=relaxed/simple;
	bh=E5yd5RFVp2gC9uJp3ZevTlVPOweiUZNt/VR5UAR5F0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPvg6jePnCGW5/It6QiR7gPTI5vn7owGgLcx+UK3dqR6g3RG5clvEbXAyRqUg8jXs0pZCi22j+Rqu/com2N+qCw3oTXywLqCfjw7CFoeGT1Asfgvx7y4kMU4mR/yN0BGafkfzkqhW1jjqbxKAFKIvViWaq4YaN2kYhyh1+deRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZJXpv5y5jz6L4v9;
	Fri, 21 Mar 2025 01:37:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F7A714050A;
	Fri, 21 Mar 2025 01:42:54 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 18:42:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<james.morse@arm.com>, <conor@kernel.org>, Yicong Yang
	<yangyicong@huawei.com>, <linux-acpi@vger.kernel.org>
CC: <linux-arch@vger.kernel.org>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, <linux-mm@kvack.org>,
	<gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 3/6] cache: coherency device class
Date: Thu, 20 Mar 2025 17:41:15 +0000
Message-ID: <20250320174118.39173-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
References: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

Some systems contain devices that are capable of issuing certain cache
invalidation messages to all components in the system.  A typical use
is when the memory backing a physical address is being changed, such
as when a region is configured for CXL or a dynamic capacity event
occurs.

These perform a similar action to the WBINVD instruction on x86 but
may provide finer granularity and/or a richer set of actions.

Add a tiny device class to which drivers may register. Each driver
provides an ops structure and the first op is Write Back and Invalidate
by PA Range. The driver may over invalidate.

An optional completion check is also provided. If present that should
be called to ensure that the action has finished.

If multiple agents are present in the system each should register
with this class and the core code will issue the invalidate to all
of them before checking for completion on each. This is done
to avoid need for filtering in the core code which can become complex
when interleave, potentially across different cache coherency hardware,
is going on, so it is easier to tell everyone and let those who don't
care do nothing.

RFC question:
1. Location.  Conor, do you mind us putting this in drivers/cache?
   I'm more than happy to add a maintainers entry and not make this
   your problem!
2. Need to figure out if all agents have turned up yet?  No idea how
   to ensure this.
3. Is just iterating over devices registered with the class the
   simplest solution?
4. Given we have a nice device class, to which we can add sysfs
   attributes, what info might be useful to userspace? It might
   be useful to indicate how expensive a flush might be for example
   or where in the topology of the system it is being triggered?

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cache/Kconfig           |   6 ++
 drivers/cache/Makefile          |   2 +
 drivers/cache/coherency_core.c  | 130 ++++++++++++++++++++++++++++++++
 include/linux/cache_coherency.h |  60 +++++++++++++++
 4 files changed, 198 insertions(+)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index db51386c663a..45dc4b2935e7 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -1,6 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 menu "Cache Drivers"
 
+config CACHE_COHERENCY_CLASS
+	bool "Cache coherency control class"
+	help
+	  Class to which coherency control drivers register allowing core kernel
+	  subsystems to issue invalidations and similar coherency operations.
+
 config AX45MP_L2_CACHE
 	bool "Andes Technology AX45MP L2 Cache controller"
 	depends on RISCV
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index 55c5e851034d..b72b20f4248f 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -3,3 +3,5 @@
 obj-$(CONFIG_AX45MP_L2_CACHE)		+= ax45mp_cache.o
 obj-$(CONFIG_SIFIVE_CCACHE)		+= sifive_ccache.o
 obj-$(CONFIG_STARFIVE_STARLINK_CACHE)	+= starfive_starlink_cache.o
+
+obj-$(CONFIG_CACHE_COHERENCY_CLASS)	+= coherency_core.o
diff --git a/drivers/cache/coherency_core.c b/drivers/cache/coherency_core.c
new file mode 100644
index 000000000000..52cb4ceae00c
--- /dev/null
+++ b/drivers/cache/coherency_core.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Class to manage OS controlled coherency agents within the system.
+ * Specifically to enable operations such as write back and invalidate.
+ *
+ * Copyright: Huawei 2025
+ * Some elements based on fwctl class as an example of a modern
+ * lightweight class.
+ */
+
+#include <linux/cache_coherency.h>
+#include <linux/container_of.h>
+#include <linux/idr.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <asm/cacheflush.h>
+
+static DEFINE_IDA(cache_coherency_ida);
+
+static void cache_coherency_device_release(struct device *device)
+{
+	struct cache_coherency_device *ccd =
+		container_of(device, struct cache_coherency_device, dev);
+
+	ida_free(&cache_coherency_ida, ccd->id);
+}
+
+static struct class cache_coherency_class = {
+	.name = "cache_coherency",
+	.dev_release = cache_coherency_device_release,
+};
+
+static int cache_inval_one(struct device *dev, void *data)
+{
+	struct cache_coherency_device *ccd =
+		container_of(dev, struct cache_coherency_device, dev);
+
+	if (!ccd->ops)
+		return -EINVAL;
+
+	return ccd->ops->wbinv(ccd, data);
+}
+
+static int cache_inval_done_one(struct device *dev, void *data)
+{
+	struct cache_coherency_device *ccd =
+		container_of(dev, struct cache_coherency_device, dev);
+	if (!ccd->ops)
+		return -EINVAL;
+
+	return ccd->ops->done(ccd);
+}
+
+static int cache_invalidate_memregion(int res_desc,
+				      phys_addr_t addr, size_t size)
+{
+	int ret;
+	struct cc_inval_params params = {
+		.addr = addr,
+		.size = size,
+	};
+
+	ret = class_for_each_device(&cache_coherency_class, NULL, &params,
+				    cache_inval_one);
+	if (ret)
+		return ret;
+
+	return class_for_each_device(&cache_coherency_class, NULL, NULL,
+				     cache_inval_done_one);
+}
+
+static const struct system_cache_flush_method cache_flush_method = {
+	.invalidate_memregion = cache_invalidate_memregion,
+};
+
+struct cache_coherency_device *
+_cache_coherency_alloc_device(struct device *parent,
+			      const struct coherency_ops *ops, size_t size)
+{
+
+	if (!ops || !ops->wbinv)
+		return NULL;
+
+	struct cache_coherency_device *ccd __free(kfree) = kzalloc(size, GFP_KERNEL);
+
+	if (!ccd)
+		return NULL;
+
+	ccd->dev.class = &cache_coherency_class;
+	ccd->dev.parent = parent;
+	ccd->ops = ops;
+	ccd->id = ida_alloc(&cache_coherency_ida, GFP_KERNEL);
+
+	if (dev_set_name(&ccd->dev, "cache_coherency%d", ccd->id))
+		return NULL;
+
+ 	device_initialize(&ccd->dev);
+
+	return_ptr(ccd);
+}
+EXPORT_SYMBOL_NS_GPL(_cache_coherency_alloc_device, "CACHE_COHERENCY");
+
+int cache_coherency_device_register(struct cache_coherency_device *ccd)
+{
+	return device_add(&ccd->dev);
+}
+EXPORT_SYMBOL_NS_GPL(cache_coherency_device_register, "CACHE_COHERENCY");
+
+void cache_coherency_device_unregister(struct cache_coherency_device *ccd)
+{
+	device_del(&ccd->dev);
+}
+EXPORT_SYMBOL_NS_GPL(cache_coherency_device_unregister, "CACHE_COHERENCY");
+
+static int __init cache_coherency_init(void)
+{
+	int ret;
+
+	ret = class_register(&cache_coherency_class);
+	if (ret)
+		return ret;
+
+	//TODO: generalize
+	arm64_set_sys_cache_flush_method(&cache_flush_method);
+
+	return 0;
+}
+subsys_initcall(cache_coherency_init);
diff --git a/include/linux/cache_coherency.h b/include/linux/cache_coherency.h
new file mode 100644
index 000000000000..d49be27ad4f1
--- /dev/null
+++ b/include/linux/cache_coherency.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cache coherency device drivers
+ *
+ * Copyright Huawei 2025
+ */
+#ifndef _LINUX_CACHE_COHERENCY_H_
+#define _LINUX_CACHE_COHERENCY_H_
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+
+struct cache_coherency_device;
+struct cc_inval_params {
+	phys_addr_t addr;
+	size_t size;
+};
+struct coherency_ops {
+	int (*wbinv)(struct cache_coherency_device *ccd, struct cc_inval_params *invp);
+	int (*done)(struct cache_coherency_device *ccd);
+};
+
+struct cache_coherency_device {
+	struct device dev;
+	const struct coherency_ops *ops;
+	int id;
+};
+
+int cache_coherency_device_register(struct cache_coherency_device *ccd);
+void cache_coherency_device_unregister(struct cache_coherency_device *ccd);
+
+struct cache_coherency_device *
+_cache_coherency_alloc_device(struct device *parent,
+			      const struct coherency_ops *ops, size_t size);
+
+#define cache_coherency_alloc_device(parent, ops, drv_struct, member)		\
+	({									\
+		static_assert(__same_type(struct cache_coherency_device,	\
+					  ((drv_struct *)NULL)->member));	\
+		static_assert(offsetof(drv_struct, member) == 0);		\
+		(drv_struct *)_cache_coherency_alloc_device(parent, ops,	\
+							sizeof(drv_struct));	\
+	})
+
+static inline struct cache_coherency_device *
+	cache_coherency_device_get(struct cache_coherency_device *ccd)
+{
+	get_device(&ccd->dev);
+	return ccd;
+}
+
+static inline void cache_coherency_device_put(struct cache_coherency_device *ccd)
+{
+	put_device(&ccd->dev);
+}
+
+DEFINE_FREE(cache_coherency_device, struct cache_coherency_device *,
+	    if (_T) cache_coherency_device_put(_T));
+
+#endif
-- 
2.43.0


