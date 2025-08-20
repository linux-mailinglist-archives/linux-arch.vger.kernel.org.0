Return-Path: <linux-arch+bounces-13230-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA256B2DA14
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 12:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505BB1C466E0
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226BA2E22B0;
	Wed, 20 Aug 2025 10:31:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679F2DF3EA;
	Wed, 20 Aug 2025 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685890; cv=none; b=CpEhRpj3cv36uDHq2FSgU3O29fZVhmIl5d9f2xXUYhHNGlx0fe8jY/UC0bkOpVXhvV5f+F4TiG22j9nJAAMuCKcfWuocdJjI/asR+kLfNCFlPPfp9xZrvdhxfWB/Upxmsra+dM1e8Z8RKgcDxgwN1tt+5VP+LnH1jtx9sMgP8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685890; c=relaxed/simple;
	bh=xK+fOXlmlAztajndvy0wj5cciB86qpRcBI/ZtoELvOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIw80xAH1H/QvwIeSBBInHfIK18JTD8VWZ3GAie4O80+l+x+v99KSM3clc8cywR7K8RsK/AuLkUYOPPkdYbeoRh1Q9lBzqjTovV3i4fWplxgz0ts93WVhTxAMEBbvhApB9xUjqbCB7hV1mpS9ipJd1pOspVN0ihKvC1AMDt5po0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c6N3f6h0jz6M4m2;
	Wed, 20 Aug 2025 18:29:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 505941402FB;
	Wed, 20 Aug 2025 18:31:26 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Aug 2025 12:31:25 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Will Deacon <will@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
CC: Yicong Yang <yangyicong@huawei.com>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>
Subject: [PATCH v3 3/8] lib: Support ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Date: Wed, 20 Aug 2025 11:29:45 +0100
Message-ID: <20250820102950.175065-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
References: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Yicong Yang <yangyicong@hisilicon.com>

ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION provides the mechanism for
invalidating certain memory regions in a cache-incoherent manner. Currently
this is used by NVDIMM and CXL memory drivers in cases where it is
necessary to flush all data from caches by physical address range.

In some architectures these operations are supported by system components
that may become available only later in boot as they are either present
on a discoverable bus, or via a firmware description of an MMIO interface
(e.g. ACPI DSDT). Provide a framework to handle this case.

Architectures can opt in for this support via
CONFIG_GENERIC_CPU_CACHE_MAINTENANCE

Add a registration framework. Each driver provides an ops structure and
the first op is Write Back and Invalidate by PA Range. The driver may
over invalidate.

An optional completion check operation is also provided. If present
that should be called to ensure that the action has finished.

When multiple agents are present in the system each should register with
this framework and the core code will issue the invalidate to all of them
before checking for completion on each. This is done to avoid need for
filtering in the core code which can become complex when interleave,
potentially across different cache coherency hardware is going on, so it
is easier to tell everyone and let those who don't care do nothing.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3: Squash all the layering from v2 so that the infrastucture is
    always present.
    Suggestions on naming welcome. Note that the hardware I have
    available supports a much richer set of maintenance operations
    than Write Back and Invalidate, so I'd like a name that
    covers all resonable maintenance operations.
    Use an allocation wrapper macro, based on the fwctl one to
    ensure that the first element of the allocated driver structure
    is a struct cache_coherency_device.
    Thanks to all who provided feedback.
---
 include/linux/cache_coherency.h |  57 ++++++++++++++
 lib/Kconfig                     |   3 +
 lib/Makefile                    |   2 +
 lib/cache_maint.c               | 128 ++++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+)

diff --git a/include/linux/cache_coherency.h b/include/linux/cache_coherency.h
new file mode 100644
index 000000000000..cb195b17b6e6
--- /dev/null
+++ b/include/linux/cache_coherency.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cache coherency maintenace operation device drivers
+ *
+ * Copyright Huawei 2025
+ */
+#ifndef _LINUX_CACHE_COHERENCY_H_
+#define _LINUX_CACHE_COHERENCY_H_
+
+#include <linux/list.h>
+#include <linux/types.h>
+
+struct cc_inval_params {
+	phys_addr_t addr;
+	size_t size;
+};
+
+struct cache_coherency_device;
+
+struct coherency_ops {
+	int (*wbinv)(struct cache_coherency_device *ccd, struct cc_inval_params *invp);
+	int (*done)(struct cache_coherency_device *ccd);
+};
+
+struct cache_coherency_device {
+	struct list_head node;
+	const struct coherency_ops *ops;
+};
+
+int cache_coherency_device_register(struct cache_coherency_device *ccd);
+void cache_coherency_device_unregister(struct cache_coherency_device *ccd);
+
+struct cache_coherency_device *
+_cache_coherency_device_alloc(const struct coherency_ops *ops, size_t size);
+/**
+ * cache_coherency_device_alloc - Allocate a cache coherency device
+ * @ops: Cache maintenance operations
+ * @drv_struct: structure that contains the struct cache_coherency_device
+ * @member: Name of the struct cache_coherency_device member in @drv_struct.
+ *
+ * This allocates and initializes the cache_coherency_device embedded in the
+ * drv_struct. Upon success the pointer must be freed via
+ * cache_coherency_device_free().
+ *
+ * Returns a 'drv_struct \*' on success, NULL on error.
+ */
+#define cache_coherency_device_alloc(ops, drv_struct, member)	    \
+	({								    \
+		static_assert(__same_type(struct cache_coherency_device,    \
+					  ((drv_struct *)NULL)->member));   \
+		static_assert(offsetof(drv_struct, member) == 0);	    \
+		(drv_struct *)_cache_coherency_device_alloc(ops,	    \
+			sizeof(drv_struct));				    \
+	})
+void cache_coherency_device_free(struct cache_coherency_device *ccd);
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index c483951b624f..cd8e5844f9bb 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -543,6 +543,9 @@ config MEMREGION
 config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
 	bool
 
+config GENERIC_CPU_CACHE_MAINTENANCE
+	bool
+
 config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index 392ff808c9b9..eed20c50f358 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -130,6 +130,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
+obj-$(CONFIG_GENERIC_CPU_CACHE_MAINTENANCE) += cache_maint.o
+
 lib-y += logic_pio.o
 
 lib-$(CONFIG_INDIRECT_IOMEM) += logic_iomem.o
diff --git a/lib/cache_maint.c b/lib/cache_maint.c
new file mode 100644
index 000000000000..05d9c5e99941
--- /dev/null
+++ b/lib/cache_maint.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic support for Memory System Cache Maintenance operations.
+ *
+ * Coherency maintenance drivers register with this simple framework that will
+ * iterate over each registered instance to first kick off invalidation and
+ * then to wait until it is complete.
+ *
+ * If no implementations are registered yet cpu_cache_has_invalidate_memregion()
+ * will return false. If this runs concurrently with unregistration then a
+ * race exists but this is no worse than the case where the device responsible
+ * for a given memory region has not yet registered.
+ */
+#include <linux/cache_coherency.h>
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/export.h>
+#include <linux/list.h>
+#include <linux/memregion.h>
+#include <linux/module.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+
+static LIST_HEAD(cache_device_list);
+static DECLARE_RWSEM(cache_device_list_lock);
+
+void cache_coherency_device_free(struct cache_coherency_device *ccd)
+{
+	kfree(ccd);
+}
+EXPORT_SYMBOL_GPL(cache_coherency_device_free);
+
+static int cache_inval_one(struct cache_coherency_device *ccd, void *data)
+{
+	if (!ccd->ops)
+		return -EINVAL;
+
+	return ccd->ops->wbinv(ccd, data);
+}
+
+static int cache_inval_done_one(struct cache_coherency_device *ccd)
+{
+	if (!ccd->ops)
+		return -EINVAL;
+
+	if (!ccd->ops->done)
+		return 0;
+
+	return ccd->ops->done(ccd);
+}
+
+static int cache_invalidate_memregion(phys_addr_t addr, size_t size)
+{
+	int ret;
+	struct cache_coherency_device *ccd;
+	struct cc_inval_params params = {
+		.addr = addr,
+		.size = size,
+	};
+
+	guard(rwsem_read)(&cache_device_list_lock);
+	list_for_each_entry(ccd, &cache_device_list, node) {
+		ret = cache_inval_one(ccd, &params);
+		if (ret)
+			return ret;
+	}
+	list_for_each_entry(ccd, &cache_device_list, node) {
+		ret = cache_inval_done_one(ccd);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+struct cache_coherency_device *
+_cache_coherency_device_alloc(const struct coherency_ops *ops, size_t size)
+{
+	struct cache_coherency_device *ccd;
+
+	if (!ops || !ops->wbinv)
+		return NULL;
+
+	ccd = kzalloc(size, GFP_KERNEL);
+	if (!ccd)
+		return NULL;
+
+	ccd->ops = ops;
+	INIT_LIST_HEAD(&ccd->node);
+
+	return ccd;
+}
+EXPORT_SYMBOL_NS_GPL(_cache_coherency_device_alloc, "CACHE_COHERENCY");
+
+int cache_coherency_device_register(struct cache_coherency_device *ccd)
+{
+	guard(rwsem_write)(&cache_device_list_lock);
+	list_add(&ccd->node, &cache_device_list);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cache_coherency_device_register, "CACHE_COHERENCY");
+
+void cache_coherency_device_unregister(struct cache_coherency_device *ccd)
+{
+	guard(rwsem_write)(&cache_device_list_lock);
+	list_del(&ccd->node);
+}
+EXPORT_SYMBOL_NS_GPL(cache_coherency_device_unregister, "CACHE_COHERENCY");
+
+int cpu_cache_invalidate_memregion(phys_addr_t start, size_t len)
+{
+	return cache_invalidate_memregion(start, len);
+}
+EXPORT_SYMBOL_NS_GPL(cpu_cache_invalidate_memregion, "DEVMEM");
+
+/*
+ * Used for optimization / debug purposes only as removal can race
+ *
+ * Machines that do not support invalidation, e.g. VMs, will not
+ * have any devices to register and so this will always return false.
+ */
+bool cpu_cache_has_invalidate_memregion(void)
+{
+	guard(rwsem_read)(&cache_device_list_lock);
+	return !list_empty(&cache_device_list);
+}
+EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, "DEVMEM");
-- 
2.48.1


