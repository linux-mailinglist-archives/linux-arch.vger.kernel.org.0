Return-Path: <linux-arch+bounces-12440-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CCAAE6BC1
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 17:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5973AAE40
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 15:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5E8274B59;
	Tue, 24 Jun 2025 15:49:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E6274B57;
	Tue, 24 Jun 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780185; cv=none; b=MFO+gLJ2b4FKEhGsbsVC/vuqFs+ltynWEOgVbOHVfwMXV0PKVTe65Ls98+afgwuTiGKAE4QDD5kDkB+sDboXzbtcV7CC+ZnARySzDpsQ8K6uIKgfacVZqeMhmBbdQ8YDhjVb2vRZ0zeA1+s6I1ZL9FNNAZXqHwFS4DcG+fhzLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780185; c=relaxed/simple;
	bh=/1fYyArZbMfK6Ejuua4GC/IrXNcwsHK1r7vDYo/NgDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJHbVTi4U4yaTyjrWHnx8+26KDJNXqaO7Rw0GjOaSOSaERirxbgT/pZGLj5WPd4JAELRirVC8757k2qW2BqAcR4rkXGQoQNLMiwHFIlT5SaTuZgEU1jxydy86P1MqEqrG+XHBX97YEGwE0U1+q0kkLQJWlUi6M8qXRCxv5/IG3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRTrm5tC7z6GDr7;
	Tue, 24 Jun 2025 23:48:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 309091400E3;
	Tue, 24 Jun 2025 23:49:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 17:49:40 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <gregkh@linuxfoundation.org>, Will Deacon
	<will@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: Yicong Yang <yangyicong@huawei.com>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, H Peter Anvin
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>
Subject: [PATCH v2 3/8] cache: coherency core registration and instance handling.
Date: Tue, 24 Jun 2025 16:47:59 +0100
Message-ID: <20250624154805.66985-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

Some systems contain devices that are capable of issuing certain cache
invalidation messages to all components in the system. A typical use
is when the memory backing a physical address is being changed, such
as when a region is configured for CXL or a dynamic capacity event
occurs.

These perform a similar action to the WBINVALL instruction on x86 but
may provide finer granularity and/or a richer set of actions.

Add a tiny registration framework to which drivers may register. Each
driver provides an ops structure and the first op is Write Back and
Invalidate by PA Range. The driver may over invalidate.

An optional completion check is also provided. If present that should
be called to ensure that the action has finished.

If multiple agents are present in the system each should register
with this framework and the core code will issue the invalidate to all
of them before checking for completion on each.  This is done
to avoid need for filtering in the core code which can become complex
when interleave, potentially across different cache coherency hardware
is going on, so it is easier to tell everyone and let those who don't
care do nothing.

Currently a mutex is used to protect against add or remove of caching
agents. There are nearby sleeping locks or similar in all the existing
callpaths, so this should be fine.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2: Drop the device class for now.  We can easily bring it back once
    the shape of any user space interface is clearer.

Open question remains on how we establish that all flushing agents
have arrived and registered correctly.
---
 drivers/cache/Kconfig           |   9 +++
 drivers/cache/Makefile          |   2 +
 drivers/cache/coherency_core.c  | 116 ++++++++++++++++++++++++++++++++
 include/linux/cache_coherency.h |  40 +++++++++++
 4 files changed, 167 insertions(+)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index db51386c663a..bedc51bea1d1 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 menu "Cache Drivers"
 
+config CACHE_COHERENCY_SUBSYSTEM
+	bool "Cache coherency control subsystem"
+	depends on ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
+	depends on GENERIC_CPU_CACHE_INVALIDATE_MEMREGION
+	help
+	  Framework to which coherency control drivers register allowing core
+	  kernel subsystems to issue invalidations and similar coherency
+	  operations.
+
 config AX45MP_L2_CACHE
 	bool "Andes Technology AX45MP L2 Cache controller"
 	depends on RISCV
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index 55c5e851034d..b193c3d1a06e 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -3,3 +3,5 @@
 obj-$(CONFIG_AX45MP_L2_CACHE)		+= ax45mp_cache.o
 obj-$(CONFIG_SIFIVE_CCACHE)		+= sifive_ccache.o
 obj-$(CONFIG_STARFIVE_STARLINK_CACHE)	+= starfive_starlink_cache.o
+
+obj-$(CONFIG_CACHE_COHERENCY_SUBSYSTEM)	+= coherency_core.o
diff --git a/drivers/cache/coherency_core.c b/drivers/cache/coherency_core.c
new file mode 100644
index 000000000000..25a9792dd16e
--- /dev/null
+++ b/drivers/cache/coherency_core.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Class to manage OS controlled coherency agents within the system.
+ * Specifically to enable operations such as write back and invalidate.
+ *
+ * Copyright: Huawei 2025
+ */
+
+#include <linux/cache_coherency.h>
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <asm/cacheflush.h>
+static LIST_HEAD(cache_device_list);
+static DEFINE_MUTEX(cache_device_list_lock);
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
+static int cache_inval_done_one(struct cache_coherency_device *ccd, void *data)
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
+static int cache_invalidate_memregion(int res_desc,
+				      phys_addr_t addr, size_t size)
+{
+	int ret;
+	struct cache_coherency_device *ccd;
+	struct cc_inval_params params = {
+		.addr = addr,
+		.size = size,
+	};
+	guard(mutex)(&cache_device_list_lock);
+	list_for_each_entry(ccd, &cache_device_list, node) {
+		ret = cache_inval_one(ccd, &params);
+		if (ret)
+			return ret;
+	}
+	list_for_each_entry(ccd, &cache_device_list, node) {
+		ret = cache_inval_done_one(ccd, &params);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static const struct system_cache_flush_method cache_flush_method = {
+	.invalidate_memregion = cache_invalidate_memregion,
+};
+
+struct cache_coherency_device *
+cache_coherency_alloc_device(struct device *parent,
+			const struct coherency_ops *ops, size_t size)
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
+	ccd->parent = parent;
+	ccd->ops = ops;
+	INIT_LIST_HEAD(&ccd->node);
+
+	return_ptr(ccd);
+}
+EXPORT_SYMBOL_NS_GPL(cache_coherency_alloc_device, "CACHE_COHERENCY");
+
+int cache_coherency_device_register(struct cache_coherency_device *ccd)
+{
+	guard(mutex)(&cache_device_list_lock);
+	list_add(&ccd->node, &cache_device_list);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cache_coherency_device_register, "CACHE_COHERENCY");
+
+void cache_coherency_device_unregister(struct cache_coherency_device *ccd)
+{
+	guard(mutex)(&cache_device_list_lock);
+	list_del(&ccd->node);
+}
+EXPORT_SYMBOL_NS_GPL(cache_coherency_device_unregister, "CACHE_COHERENCY");
+
+static int __init cache_coherency_init(void)
+{
+	generic_set_sys_cache_flush_method(&cache_flush_method);
+
+	return 0;
+}
+subsys_initcall(cache_coherency_init);
diff --git a/include/linux/cache_coherency.h b/include/linux/cache_coherency.h
new file mode 100644
index 000000000000..2e90e513821a
--- /dev/null
+++ b/include/linux/cache_coherency.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cache coherency device drivers
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
+struct device;
+struct cache_coherency_device {
+	struct list_head node;
+	struct device *parent;
+	const struct coherency_ops *ops;
+};
+
+int cache_coherency_device_register(struct cache_coherency_device *ccd);
+void cache_coherency_device_unregister(struct cache_coherency_device *ccd);
+
+struct cache_coherency_device *
+cache_coherency_alloc_device(struct device *parent,
+			      const struct coherency_ops *ops, size_t size);
+void cache_coherency_device_free(struct cache_coherency_device *ccd);
+
+#endif
-- 
2.48.1


