Return-Path: <linux-arch+bounces-14436-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C2EC24C26
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 12:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390B71889E70
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 11:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10823338599;
	Fri, 31 Oct 2025 11:20:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F0E230BCB;
	Fri, 31 Oct 2025 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909637; cv=none; b=IkTQsirQR8m+povmOQcpqxyn8RcblxUsoZYXfOnW42BuB9PksGw+yvbiQALVz1IEX+eGeViYyGWJ3U+iee/uvuUJUnANyUnpZkVcSihPDr5RHQLm1ONpoCKbR1Ib3duQFhfHsjSCxoBKA2iywL/sTzLbDJNoMMTylFQZtD5Wxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909637; c=relaxed/simple;
	bh=7aZKUwiWvOng5eZa4Ym2Mpd0GaiW3RDr4LLthazBqb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRdBf+4Z5v4Qr7eGZBcahXPprBXErWcZTMc0vFn0gxJFV+ft0lRac/Gz8v8zJavLbmp/deWuYwuSlwr+A5VW/WQwE5wY3hEJn5kReUdiD7Rin7xspoilNv/SOHvkVwUSuf9XEBb06FvBsvwGUSltpRJqFrg8cm39o/9Ua9Fj04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cydlN4qSQz67Pyr;
	Fri, 31 Oct 2025 19:18:40 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CA5C140427;
	Fri, 31 Oct 2025 19:20:33 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 31 Oct 2025 11:20:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Drew Fustini
	<fustini@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: <james.morse@arm.com>, Will Deacon <will@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v5 6/6] cache: Support cache maintenance for HiSilicon SoC Hydra Home Agent
Date: Fri, 31 Oct 2025 11:17:09 +0000
Message-ID: <20251031111709.1783347-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251031111709.1783347-1-Jonathan.Cameron@huawei.com>
References: <20251031111709.1783347-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

From: Yushan Wang <wangyushan12@huawei.com>

Hydra Home Agent is a device used to maintain cache coherency. Add support
for explicit cache maintenance operations using it. A system has multiple
of these agents. Whilst only one agent is responsible for a given cache
line, interleave means that for a range operation, responsibility for the
cache lines making up the range will typically be spread across multiple
instances.

Co-developed-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: Drop stale comment on devm_ioremap_resource() as it is no longer used.
    Also drop mention from patch description (Conor)

    Add some overview comments to top of driver and improve comment on
    searching for a cacheline to be explicit about what happens if it is
    not found (as not in scope for device, or happens not to be in any
    caches). (Conor)
    Also update the commit message to make it clear there are always
    multiple instances of this unit in a system (Conor)

v4: Update for naming changes around device / instance.
    Switch to kref put based freeing via helper.
---
 drivers/cache/Kconfig        |  15 +++
 drivers/cache/Makefile       |   2 +
 drivers/cache/hisi_soc_hha.c | 194 +++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)

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
index 000000000000..25ff0f5ae79b
--- /dev/null
+++ b/drivers/cache/hisi_soc_hha.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for HiSilicon Hydra Home Agent (HHA).
+ *
+ * Copyright (c) 2025 HiSilicon Technologies Co., Ltd.
+ * Author: Yicong Yang <yangyicong@hisilicon.com>
+ *         Yushan Wang <wangyushan12@huawei.com>
+ *
+ * A system typically contains multiple HHAs. Each is responsible for a subset
+ * of the physical addresses in the system, but interleave can make the mapping
+ * from a particular cache line to a responsible HHA complex. As such no
+ * filtering is done in the driver, with the hardware being responsible for
+ * responding with success for even if it was not responsible for any addresses
+ * in the range on which the operation was requested.
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
+	 * last byte included, and perform maintenance in 128 byte granules
+	 * on those cachelines which contain the addresses. If a given instance
+	 * is either not responsible for a cacheline or that cacheline is not
+	 * currently present then the search will fail, no operation will be
+	 * necessary and the device will report success.
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


