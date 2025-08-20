Return-Path: <linux-arch+bounces-13234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92056B2DA24
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 12:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E651F7B166C
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47DB2E285B;
	Wed, 20 Aug 2025 10:33:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383420322;
	Wed, 20 Aug 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686015; cv=none; b=PItdAEeJ8kdgrZqBiyFiVbhqvmas3HbqpBVaczKVpsDXoDYv4lB9fnKcOoFAzZHctynwV0Ru1K/zSpP4SyMyYtGR3OTk0EBhJNBlqENW+0Vb7H6l0Mv0Ty4CdMt3QWEukqVPT5SxjnA+vxhqQXdrd4xtfSmATqSHiKFwpuWEnlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686015; c=relaxed/simple;
	bh=R7MgG5KMn5K8UDww7jLFbMnDWwHzBWHWd52chucGTjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgLYVwcjCE0c8kikJQaUYYl6nRZeZMYRyDrxIvNYM8O9BxG4Ie+HB1lXYA6mz0Rce9msfPrqAlbIyjcDfraU6kftU4O5io7WVQZ5F4zfmAYjHvu3h9tphsdB+vBaIYOE6rAIZoS2a/5GY97q5o+DxqR1Nfcp6LqK10FEdeG0Hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c6N8G6023z6L5TV;
	Wed, 20 Aug 2025 18:33:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CC8821402F4;
	Wed, 20 Aug 2025 18:33:31 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Aug 2025 12:33:30 +0200
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
Subject: [PATCH v3 7/8] acpi: PoC of Cache control via ACPI0019 and _DSM
Date: Wed, 20 Aug 2025 11:29:49 +0100
Message-ID: <20250820102950.175065-8-Jonathan.Cameron@huawei.com>
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

Do not merge. This is the bare outline of what may become an ACPI code
first specification proposal. For that reason it remains an RFC and is
mainly here to show that the framework is flexible enough to be useful
by providing a second driver.

From various discussions, it has become clear that there is some desire not
to end up needing a cache flushing driver for every host that supports the
flush by PA range functionality that is needed for CXL and similar
disagregated memory pools where the host PA mapping to actual memory may
change over time and where various races can occur with prefetchers making
it hard to use CPU instructions to flush all stale data out.

There was once an ARM PSCI specification [1] that defined a firmware
interface to solve this problem. However that meant dropping into a more
privileged mode, or chatting to an external firmware. That was overkill for
those systems that provide a simple MMIO register interface for these
operations (which seems to be the common case). That specification never
made it beyond alpha level.

For the typical class of machine that actually uses these disaggregated
pools, ACPI can potentially provide the same benefits with a great deal
more flexibility. A _DSM in DSDT via operation regions, may be used to do
any of:
1) Make firmware calls
2) Operate a register based state machine.
3) Most other things you might dream of.

This was prototyped against an implementation of the ARM specification in
[1] wrapped up in _DSM magic. That was chosen to give a second (be it
abandoned) example of how this cache control class can be used.

Link: https://developer.arm.com/documentation/den0022/falp1/?lang=en [1]
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cache/Kconfig              |   7 ++
 drivers/cache/Makefile             |   1 +
 drivers/cache/acpi_cache_control.c | 153 +++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 4551b28e14dd..158d3819004e 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -3,6 +3,13 @@ menu "Cache Drivers"
 
 if GENERIC_CPU_CACHE_MAINTENANCE
 
+config ACPI_CACHE_CONTROL
+       tristate "ACPI cache maintenance"
+       depends on ARM64 && ACPI
+       help
+         ACPI0019 device ID in DSDT identifies an interface that may be used
+	 to carry out certain forms of cache flush operation.
+
 config HISI_SOC_HHA
 	tristate "HiSilicon Hydra Home Agent (HHA) device driver"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index b3362b15d6c1..94c41b018cd5 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -4,4 +4,5 @@ obj-$(CONFIG_AX45MP_L2_CACHE)		+= ax45mp_cache.o
 obj-$(CONFIG_SIFIVE_CCACHE)		+= sifive_ccache.o
 obj-$(CONFIG_STARFIVE_STARLINK_CACHE)	+= starfive_starlink_cache.o
 
+obj-$(CONFIG_ACPI_CACHE_CONTROL)   	+= acpi_cache_control.o
 obj-$(CONFIG_HISI_SOC_HHA)		+= hisi_soc_hha.o
diff --git a/drivers/cache/acpi_cache_control.c b/drivers/cache/acpi_cache_control.c
new file mode 100644
index 000000000000..8da7fc2e189e
--- /dev/null
+++ b/drivers/cache/acpi_cache_control.c
@@ -0,0 +1,153 @@
+
+#include <linux/acpi.h>
+#include <linux/cache_coherency.h>
+#include <asm/cacheflush.h>
+
+struct acpi_cache_control {
+	struct cache_coherency_device ccd;
+	struct acpi_device *acpi_dev;
+};
+
+static const guid_t testguid =
+	GUID_INIT(0x61FDC7D5, 0x1468, 0x4807,
+		0xB5, 0x65, 0x51, 0x5B, 0xF6, 0xB7, 0x53, 0x19);
+
+static int acpi_cache_control_query(struct acpi_device *device)
+{
+	union acpi_object *out_obj;
+
+	out_obj = acpi_evaluate_dsm(device->handle, &testguid, 1, 1, NULL);//&in_obj);
+	if (out_obj->package.count < 4) {
+		printk("Only partial capabilities received\n");
+		return -EINVAL;
+	}
+	for (int i = 0; i < out_obj->package.count; i++)
+		if (out_obj->package.elements[i].type != 1) {
+			printk("Element %d not integer\n", i);
+			return -EINVAL;
+		}
+	switch (out_obj->package.elements[0].integer.value) {
+	case 0:
+		printk("Supports range\n");
+		break;
+	case 1:
+		printk("Full flush only\n");
+		break;
+	default:
+		printk("unknown op type %llx\n",
+			out_obj->package.elements[0].integer.value);
+		break;
+	}
+
+	printk("Latency is %lld msecs\n",
+		out_obj->package.elements[1].integer.value);
+	printk("Min delay between calls is %lld msecs\n",
+		out_obj->package.elements[2].integer.value);
+
+	if (out_obj->package.elements[3].integer.value & BIT(0))
+		printk("CLEAN_INVALIDATE\n");
+	if (out_obj->package.elements[3].integer.value & BIT(1))
+		printk("CLEAN\n");
+	if (out_obj->package.elements[3].integer.value & BIT(2))
+		printk("INVALIDATE\n");
+	ACPI_FREE(out_obj);
+	return 0;
+}
+
+static int acpi_cache_control_inval(struct acpi_device *device, u64 base, u64 size)
+{
+	union acpi_object *out_obj;
+	union acpi_object in_array[] = {
+		[0].integer = { ACPI_TYPE_INTEGER, base },
+		[1].integer = { ACPI_TYPE_INTEGER, size },
+		[2].integer = { ACPI_TYPE_INTEGER, 0 }, // Clean invalidate
+	};
+	union acpi_object in_obj = {
+		.package = {
+			.type = ACPI_TYPE_PACKAGE,
+			.count = ARRAY_SIZE(in_array),
+			.elements = in_array,
+		},
+	};
+
+	out_obj = acpi_evaluate_dsm(device->handle, &testguid, 1, 2, &in_obj);
+	ACPI_FREE(out_obj);
+	return 0;
+}
+
+static int acpi_cc_wbinv(struct cache_coherency_device *ccd,
+			 struct cc_inval_params *invp)
+{
+	struct acpi_cache_control *acpi_cc =
+		container_of(ccd, struct acpi_cache_control, ccd);
+
+	return acpi_cache_control_inval(acpi_cc->acpi_dev, invp->addr, invp->size);
+}
+
+static int acpi_cc_done(struct cache_coherency_device *ccd)
+{
+	/* Todo */
+	return 0;
+}
+
+static const struct coherency_ops acpi_cc_ops = {
+	.wbinv = acpi_cc_wbinv,
+	.done = acpi_cc_done,
+};
+
+static int acpi_cache_control_add(struct acpi_device *device)
+{
+	struct acpi_cache_control *acpi_cc;
+	int ret;
+
+	ret = acpi_cache_control_query(device);
+	if (ret)
+		return ret;
+
+	acpi_cc = cache_coherency_device_alloc(&acpi_cc_ops,
+					       struct acpi_cache_control, ccd);
+	if (!acpi_cc)
+		return -ENOMEM;
+
+	acpi_cc->acpi_dev = device;
+
+	ret = cache_coherency_device_register(&acpi_cc->ccd);
+	if (ret) {
+		cache_coherency_device_free(&acpi_cc->ccd);
+		return ret;
+	}
+
+	dev_set_drvdata(&device->dev, acpi_cc);
+	return 0;
+}
+
+static void acpi_cache_control_del(struct acpi_device *device)
+{
+	struct acpi_cache_control *acpi_cc = dev_get_drvdata(&device->dev);
+
+	cache_coherency_device_unregister(&acpi_cc->ccd);
+	cache_coherency_device_free(&acpi_cc->ccd);
+}
+
+static const struct acpi_device_id acpi_cache_control_ids[] = {
+	{ "ACPI0019" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(acpi, acpi_cache_control_ids);
+
+static struct acpi_driver acpi_cache_control_driver = {
+	.name = "acpi_cache_control",
+	.ids = acpi_cache_control_ids,
+	.ops = {
+		.add = acpi_cache_control_add,
+		.remove = acpi_cache_control_del,
+	},
+};
+
+module_acpi_driver(acpi_cache_control_driver);
+
+MODULE_IMPORT_NS("CACHE_COHERENCY");
+MODULE_AUTHOR("Jonathan Cameron <Jonathan.Cameron@huawei.com>");
+MODULE_DESCRIPTION("HACKS HACKS HACKS");
+MODULE_LICENSE("GPL");
-- 
2.48.1


