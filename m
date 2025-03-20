Return-Path: <linux-arch+bounces-10990-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C47A6AC4B
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 18:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEA3188F6F9
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A352253A4;
	Thu, 20 Mar 2025 17:43:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897F1494BB;
	Thu, 20 Mar 2025 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492609; cv=none; b=jidnk38KUuEmGrPqwz4K0D1kH+ACiJ8XNBLCkD1X47Icx0MURsT+9mlGXJdfq7YKKzP8u0ZSUdQSPYJdwpJThEuJVaz9dI/6IpZzkTOx21NAZieoU3MScaQBwfvNc81lIYKAjh8ANoyuHY1thwiCFErGaJahZQeTHLH0fs+BDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492609; c=relaxed/simple;
	bh=Wnv6007JJ4oe/TcMxI2IqKPunpao+J+diV0lAkYwqf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeI3OyGmo/RyyOUWknbvwYW5l8hByXOMASSba/m4zGN9WuT/iOFJBHwH9Azk69ST6bUMCGm4BMjqkfHSNnnfpniexi+0OvzWO6GYovIWDbT5rRrTYUXDV5AXXeMBgmxRZFK4BK6gpr7FghflYpaQg9i732dsVSMSOnSnACjbpvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZJXsl1VN3z6K9M7;
	Fri, 21 Mar 2025 01:40:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ABEA714050D;
	Fri, 21 Mar 2025 01:43:25 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 18:43:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<james.morse@arm.com>, <conor@kernel.org>, Yicong Yang
	<yangyicong@huawei.com>, <linux-acpi@vger.kernel.org>
CC: <linux-arch@vger.kernel.org>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, <linux-mm@kvack.org>,
	<gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 4/6] cache: Support cache maintenance for HiSilicon SoC Hydra Home Agent
Date: Thu, 20 Mar 2025 17:41:16 +0000
Message-ID: <20250320174118.39173-5-Jonathan.Cameron@huawei.com>
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

From: Yicong Yang <yangyicong@hisilicon.com>

Hydra Home Agent is a device used for maintain cache coherency, add
support of cache maintenance operations for it.

Same as HiSilicon L3 cache and L3 cache PMU, memory resource of HHA
conflicts with that of HHA PMU.  Same workaround is implemented here to
workaround resource conflict check.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Co-developed-by: Yushan Wang <wangyushan12@huawei.com>
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cache/Kconfig        |  12 +++
 drivers/cache/Makefile       |   1 +
 drivers/cache/hisi_soc_hha.c | 193 +++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 45dc4b2935e7..6dab014bc581 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -6,6 +6,18 @@ config CACHE_COHERENCY_CLASS
 	help
 	  Class to which coherency control drivers register allowing core kernel
 	  subsystems to issue invalidations and similar coherency operations.
+if CACHE_COHERENCY_CLASS
+
+config HISI_SOC_HHA
+	tristate "HiSilicon Hydra Home Agent (HHA) device driver"
+	depends on ARM64 && ACPI || COMPILE_TEST
+	help
+	  The Hydra Home Agent (HHA) is responsible of cache coherency
+	  on SoC. This drivers provides cache maintenance functions of HHA.
+
+	  This driver can be built as a module. If so, the module will be
+	  called hisi_soc_hha.
+endif
 
 config AX45MP_L2_CACHE
 	bool "Andes Technology AX45MP L2 Cache controller"
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index b72b20f4248f..48b319984b45 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_SIFIVE_CCACHE)		+= sifive_ccache.o
 obj-$(CONFIG_STARFIVE_STARLINK_CACHE)	+= starfive_starlink_cache.o
 
 obj-$(CONFIG_CACHE_COHERENCY_CLASS)	+= coherency_core.o
+obj-$(CONFIG_HISI_SOC_HHA)		+= hisi_soc_hha.o
diff --git a/drivers/cache/hisi_soc_hha.c b/drivers/cache/hisi_soc_hha.c
new file mode 100644
index 000000000000..c2af06e5839e
--- /dev/null
+++ b/drivers/cache/hisi_soc_hha.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for HiSilicon Hydra Home Agent (HHA).
+ *
+ * Copyright (c) 2024 HiSilicon Technologies Co., Ltd.
+ * Author: Yicong Yang <yangyicong@hisilicon.com>
+ *         Yushan Wang <wangyushan12@huawei.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/bitfield.h>
+#include <linux/cacheflush.h>
+#include <linux/cache_coherency.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/memregion.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#define HISI_HHA_CTRL		0x5004
+#define   HISI_HHA_CTRL_EN	BIT(0)
+#define   HISI_HHA_CTRL_RANGE	BIT(1)
+#define   HISI_HHA_CTRL_TYPE	GENMASK(3, 2)
+#define HISI_HHA_START_L	0x5008
+#define HISI_HHA_START_H	0x500c
+#define HISI_HHA_LEN_L		0x5010
+#define HISI_HHA_LEN_H		0x5014
+
+/* The maintain operation performs in a 128 Byte granularity */
+#define HISI_HHA_MAINT_ALIGN	128
+
+#define HISI_HHA_POLL_GAP_US		10
+#define HISI_HHA_POLL_TIMEOUT_US	50000
+
+struct hisi_soc_hha {
+	struct cache_coherency_device ccd;
+	/* Locks HHA instance to forbid overlapping access. */
+	spinlock_t lock;
+	void __iomem *base;
+};
+
+static bool hisi_hha_cache_maintain_wait_finished(struct hisi_soc_hha *soc_hha)
+{
+	u32 val;
+
+	return !readl_poll_timeout_atomic(soc_hha->base + HISI_HHA_CTRL, val,
+					  !(val & HISI_HHA_CTRL_EN),
+					  HISI_HHA_POLL_GAP_US,
+					  HISI_HHA_POLL_TIMEOUT_US);
+}
+
+static int hisi_hha_cache_do_maintain(struct hisi_soc_hha *soc_hha,
+				      phys_addr_t addr, size_t size)
+{
+	int ret = 0;
+	u32 reg;
+
+	if (!size || !IS_ALIGNED(size, HISI_HHA_MAINT_ALIGN))
+		return -EINVAL;
+
+	/*
+	 * Hardware will maintain in a range of
+	 * [addr, addr + size + HISI_HHA_MAINT_ALIGN]
+	 */
+	size -= HISI_HHA_MAINT_ALIGN;
+
+	guard(spinlock)(&soc_hha->lock);
+
+	if (!hisi_hha_cache_maintain_wait_finished(soc_hha))
+		return -EBUSY;
+
+	writel(lower_32_bits(addr), soc_hha->base + HISI_HHA_START_L);
+	writel(upper_32_bits(addr), soc_hha->base + HISI_HHA_START_H);
+	writel(lower_32_bits(size), soc_hha->base + HISI_HHA_LEN_L);
+	writel(upper_32_bits(size), soc_hha->base + HISI_HHA_LEN_H);
+
+	reg = FIELD_PREP(HISI_HHA_CTRL_TYPE, 1); /* Clean Invalid */
+	reg |= HISI_HHA_CTRL_RANGE | HISI_HHA_CTRL_EN;
+	writel(reg, soc_hha->base + HISI_HHA_CTRL);
+
+	return ret;
+}
+
+static int hisi_hha_cache_poll_maintain_done(struct hisi_soc_hha *soc_hha,
+					     phys_addr_t addr, size_t size)
+{
+	guard(spinlock)(&soc_hha->lock);
+
+	if (!hisi_hha_cache_maintain_wait_finished(soc_hha))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int hisi_soc_hha_wbinv(struct cache_coherency_device *ccd, struct cc_inval_params *invp)
+{
+	struct hisi_soc_hha *hha = container_of(ccd, struct hisi_soc_hha, ccd);
+
+	return hisi_hha_cache_do_maintain(hha, invp->addr, invp->size);
+}
+
+static int hisi_soc_hha_done(struct cache_coherency_device *ccd)
+{
+	struct hisi_soc_hha *hha = container_of(ccd, struct hisi_soc_hha, ccd);
+
+	return hisi_hha_cache_poll_maintain_done(hha, 0, 0);
+}
+
+static const struct coherency_ops hha_ops = {
+	.wbinv = hisi_soc_hha_wbinv,
+	.done = hisi_soc_hha_done,
+};
+
+DEFINE_FREE(hisi_soc_hha, struct hisi_soc_hha *, if (_T) cache_coherency_device_put(&_T->ccd))
+static int hisi_soc_hha_probe(struct platform_device *pdev)
+{
+	struct resource *mem;
+	int ret;
+
+	struct hisi_soc_hha *soc_hha __free(hisi_soc_hha) =
+		cache_coherency_alloc_device(&pdev->dev, &hha_ops,
+					     struct hisi_soc_hha, ccd);
+	if (!soc_hha)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, soc_hha);
+
+	spin_lock_init(&soc_hha->lock);
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -ENODEV;
+
+	/*
+	 * HHA cache driver share the same register region with HHA uncore PMU
+	 * driver in hardware's perspective, none of them should reserve the
+	 * resource to itself only.  Here exclusive access verification is
+	 * avoided by calling devm_ioremap instead of devm_ioremap_resource to
+	 * allow both drivers to exist at the same time.
+	 */
+	soc_hha->base = ioremap(mem->start, resource_size(mem));
+	if (IS_ERR_OR_NULL(soc_hha->base)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(soc_hha->base),
+				     "failed to remap io memory");
+	}
+
+	ret = cache_coherency_device_register(&soc_hha->ccd);
+	if (ret) {
+		iounmap(soc_hha->base);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, no_free_ptr(soc_hha));
+	return 0;
+}
+
+static void hisi_soc_hha_remove(struct platform_device *pdev)
+{
+	struct hisi_soc_hha *soc_hha = platform_get_drvdata(pdev);
+
+	cache_coherency_device_unregister(&soc_hha->ccd);
+	iounmap(soc_hha->base);
+	cache_coherency_device_put(&soc_hha->ccd);
+}
+
+static const struct acpi_device_id hisi_soc_hha_ids[] = {
+	{ "HISI0511", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, hisi_soc_hha_ids);
+
+static struct platform_driver hisi_soc_hha_driver = {
+	.driver = {
+		.name = "hisi_soc_hha",
+		.acpi_match_table = hisi_soc_hha_ids,
+	},
+	.probe = hisi_soc_hha_probe,
+	.remove = hisi_soc_hha_remove,
+};
+
+module_platform_driver(hisi_soc_hha_driver);
+
+MODULE_IMPORT_NS("CACHE_COHERENCY");
+MODULE_DESCRIPTION("Hisilicon Hydra Home Agent driver supporting cache maintenance");
+MODULE_AUTHOR("Yicong Yang <yangyicong@hisilicon.com>");
+MODULE_AUTHOR("Yushan Wang <wangyushan12@huawei.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


