Return-Path: <linux-arch+bounces-14256-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663C9BFBAA4
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 13:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BB63A51F8
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7480B32D445;
	Wed, 22 Oct 2025 11:37:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694DA330B31;
	Wed, 22 Oct 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133024; cv=none; b=tzT5ndPVsBiGL5wvt0hT5AP3cLkj9hbSaxnluJLOLB4ieUyy2M20ckqdrffA8XALGjkOjNE3sF+JR5ZPbU7vDvRi45oI8gVwT6pQj5sdM8U/bUCJnOSZ2jVXrM4ggINQYELEqP43W4/VcXxPXr24YwYb1Wx9OrKp1csiRWXl+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133024; c=relaxed/simple;
	bh=eUP2JWcYH2Xfc3mBBq1TvqsFsfHr53x3783/xHOO4+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSy7uSLNh8KYb4kcbMw0pRG0gk8IOldlKNrzAufLfiRyOww3ytaOKq7+sz3+1dXF3f9Z413sO5FWwj2pt+Y+G7kUkjCRW0GKc8DB1o0ihLCNKyp3phTRYrqpggX2hs0P1DvGvSEKbi4HzqTbu/RTs7uNTbPNiCOS5XDi2JRRSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cs6W0016lz6GDMq;
	Wed, 22 Oct 2025 19:33:48 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 769971402FC;
	Wed, 22 Oct 2025 19:37:00 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 12:36:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <james.morse@arm.com>, Will Deacon <will@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v4 6/6] cache: Support cache maintenance for HiSilicon SoC Hydra Home Agent
Date: Wed, 22 Oct 2025 12:33:49 +0100
Message-ID: <20251022113349.1711388-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

From: Yushan Wang <wangyushan12@huawei.com>

Hydra Home Agent is a device used to maintain cache coherency, add support
of explicit cache maintenance operations for it.

Memory resource of HHA conflicts with that of HHA PMU. A workaround is
implemented here by replacing devm_ioremap_resource() to devm_ioremap() to
workaround the resource conflict check.

Co-developed-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v4: Update for naming changes around device / instance.
    Switch to kref put based freeing via helper.
---
 drivers/cache/Kconfig        |  15 +++
 drivers/cache/Makefile       |   2 +
 drivers/cache/hisi_soc_hha.c | 191 +++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index db51386c663a..4551b28e14dd 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -1,6 +1,21 @@
 # SPDX-License-Identifier: GPL-2.0
 menu "Cache Drivers"
 
+if GENERIC_CPU_CACHE_MAINTENANCE
+
+config HISI_SOC_HHA
+	tristate "HiSilicon Hydra Home Agent (HHA) device driver"
+	depends on (ARM64 && ACPI) || COMPILE_TEST
+	help
+	  The Hydra Home Agent (HHA) is responsible for cache coherency
+	  on the SoC. This drivers enables the cache maintenance functions of
+	  the HHA.
+
+	  This driver can be built as a module. If so, the module will be
+	  called hisi_soc_hha.
+
+endif
+
 config AX45MP_L2_CACHE
 	bool "Andes Technology AX45MP L2 Cache controller"
 	depends on RISCV
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index 55c5e851034d..b3362b15d6c1 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -3,3 +3,5 @@
 obj-$(CONFIG_AX45MP_L2_CACHE)		+= ax45mp_cache.o
 obj-$(CONFIG_SIFIVE_CCACHE)		+= sifive_ccache.o
 obj-$(CONFIG_STARFIVE_STARLINK_CACHE)	+= starfive_starlink_cache.o
+
+obj-$(CONFIG_HISI_SOC_HHA)		+= hisi_soc_hha.o
diff --git a/drivers/cache/hisi_soc_hha.c b/drivers/cache/hisi_soc_hha.c
new file mode 100644
index 000000000000..bf403f711c6b
--- /dev/null
+++ b/drivers/cache/hisi_soc_hha.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for HiSilicon Hydra Home Agent (HHA).
+ *
+ * Copyright (c) 2025 HiSilicon Technologies Co., Ltd.
+ * Author: Yicong Yang <yangyicong@hisilicon.com>
+ *         Yushan Wang <wangyushan12@huawei.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cache_coherency.h>
+#include <linux/dev_printk.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/memregion.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
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
+	/* Must be first element */
+	struct cache_coherency_ops_inst cci;
+	/* Locks HHA instance to forbid overlapping access. */
+	struct mutex lock;
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
+static int hisi_soc_hha_wbinv(struct cache_coherency_ops_inst *cci,
+			struct cc_inval_params *invp)
+{
+	struct hisi_soc_hha *soc_hha =
+		container_of(cci, struct hisi_soc_hha, cci);
+	phys_addr_t top, addr = invp->addr;
+	size_t size = invp->size;
+	u32 reg;
+
+	if (!size)
+		return -EINVAL;
+
+	addr = ALIGN_DOWN(addr, HISI_HHA_MAINT_ALIGN);
+	top = ALIGN(addr + size, HISI_HHA_MAINT_ALIGN);
+	size = top - addr;
+
+	guard(mutex)(&soc_hha->lock);
+
+	if (!hisi_hha_cache_maintain_wait_finished(soc_hha))
+		return -EBUSY;
+
+	/*
+	 * Hardware will search for addresses ranging [addr, addr + size - 1],
+	 * last byte included, and perform maintain in 128 byte granule
+	 * on those cachelines which contain the addresses.
+	 */
+	size -= 1;
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
+	return 0;
+}
+
+static int hisi_soc_hha_done(struct cache_coherency_ops_inst *cci)
+{
+	struct hisi_soc_hha *soc_hha =
+		container_of(cci, struct hisi_soc_hha, cci);
+
+	guard(mutex)(&soc_hha->lock);
+	if (!hisi_hha_cache_maintain_wait_finished(soc_hha))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static const struct cache_coherency_ops hha_ops = {
+	.wbinv = hisi_soc_hha_wbinv,
+	.done = hisi_soc_hha_done,
+};
+
+static int hisi_soc_hha_probe(struct platform_device *pdev)
+{
+	struct hisi_soc_hha *soc_hha;
+	struct resource *mem;
+	int ret;
+
+	soc_hha = cache_coherency_ops_instance_alloc(&hha_ops,
+						     struct hisi_soc_hha, cci);
+	if (!soc_hha)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, soc_hha);
+
+	mutex_init(&soc_hha->lock);
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		ret = -ENOMEM;
+		goto err_free_cci;
+	}
+
+	/*
+	 * HHA cache driver share the same register region with HHA uncore PMU
+	 * driver in hardware's perspective, none of them should reserve the
+	 * resource to itself only.  Here exclusive access verification is
+	 * avoided by calling devm_ioremap instead of devm_ioremap_resource to
+	 * allow both drivers to exist at the same time.
+	 */
+	soc_hha->base = ioremap(mem->start, resource_size(mem));
+	if (!soc_hha->base) {
+		ret = dev_err_probe(&pdev->dev, -ENOMEM,
+				    "failed to remap io memory");
+		goto err_free_cci;
+	}
+
+	ret = cache_coherency_ops_instance_register(&soc_hha->cci);
+	if (ret)
+		goto err_iounmap;
+
+	return 0;
+
+err_iounmap:
+	iounmap(soc_hha->base);
+err_free_cci:
+	cache_coherency_ops_instance_put(&soc_hha->cci);
+	return ret;
+}
+
+static void hisi_soc_hha_remove(struct platform_device *pdev)
+{
+	struct hisi_soc_hha *soc_hha = platform_get_drvdata(pdev);
+
+	cache_coherency_ops_instance_unregister(&soc_hha->cci);
+	iounmap(soc_hha->base);
+	cache_coherency_ops_instance_put(&soc_hha->cci);
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
+MODULE_DESCRIPTION("HiSilicon Hydra Home Agent driver supporting cache maintenance");
+MODULE_AUTHOR("Yicong Yang <yangyicong@hisilicon.com>");
+MODULE_AUTHOR("Yushan Wang <wangyushan12@huawei.com>");
+MODULE_LICENSE("GPL");
-- 
2.48.1


