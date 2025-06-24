Return-Path: <linux-arch+bounces-12444-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1EDAE6BCE
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 17:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8BD5A25AC
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C8274B35;
	Tue, 24 Jun 2025 15:51:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF0226CE2A;
	Tue, 24 Jun 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780310; cv=none; b=Y63VPE0JuZgKWixKCbmRv8Ar7ewcwxzj7jTwRG6VThDDmy4udR05oSjqFq+UC6BDPVek7L13gwc90Dq6FxGHjoXZ/tTfjKCxED9S6zP2d8IZR+tWQ2LJZuVTjpeubi9DPw0Dmg2aGpSmo7DS4k+YO9u3dgsWlqE4ddSEyTDJNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780310; c=relaxed/simple;
	bh=YkcQdLXagqON/LSRMwCM4TBuoRXeFVJOQaCo3I4o3Vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/9r20UF9id+zLhNYGzla5rt30Jt1wHCddpUCC6WDzxlFL3dfGXl3wpIt2NxfWasuy9WdHci2gv88DsI8hZHcVlhN4HH21ZB537frGJPRWrSlUggMNNzYCtr8CPFtS95f7dywlfTQkroej7TO/b9mU0GDtBX2o1o95fDG27pgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRTvB4BR1z6GDsx;
	Tue, 24 Jun 2025 23:51:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EBFF51400E3;
	Tue, 24 Jun 2025 23:51:46 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 17:51:46 +0200
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
Subject: [RFC v2 7/8] acpi: PoC of Cache control via ACPI0019 and _DSM
Date: Tue, 24 Jun 2025 16:48:03 +0100
Message-ID: <20250624154805.66985-8-Jonathan.Cameron@huawei.com>
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

Do not merge. This is the bare outline of what may become an ACPI
code first specification proposal. For that reason it remains an RFC
and is mainly here to show that the framework is flexible enough to
be useful by providing a second driver.

From various discussions, it has become clear that there is some desire not
to end up needing a cache flushing driver for every host that supports the
flush by PA range functionality that is needed for CXL and similar
disagregated memory pools where the host PA mapping to actual memory may
change over time and where various races can occur with prefetchers making
it hard to use CPU instructions to flush all stale data out.

There was once an ARM PSCI specification [1] that defined a firmware
interface to solve this problem.  However that meant dropping into
a more privileged mode, or chatting to an external firmware. That was
overkill for those systems that provide a simple MMIO register interface
for these operations. That specification never made it beyond alpha level.

For the typical class of machine that actually uses these disaggregated
pools, ACPI can potentially provide the same benefits with a great deal more
flexibility.  A _DSM in DSDT via operation regions, may be used to do any of:
1) Make firmware calls
2) Operate a register based state machine.
3) Most other things you might dream of.

This was prototyped against an implementation of the ARM specification
in [1] wrapped up in _DSM magic. That was chosen to give a second
(be it abandoned) example of how this cache control class can be used.

Link: https://developer.arm.com/documentation/den0022/falp1/?lang=en [1]
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cache/Kconfig              |   7 ++
 drivers/cache/Makefile             |   1 +
 drivers/cache/acpi_cache_control.c | 152 +++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 0ed87f25bd69..e4c4ebb01135 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -12,6 +12,13 @@ config CACHE_COHERENCY_SUBSYSTEM
 
 if CACHE_COHERENCY_SUBSYSTEM
 
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
index dfc98273ff09..f770bb1f314f 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_SIFIVE_CCACHE)		+= sifive_ccache.o
 obj-$(CONFIG_STARFIVE_STARLINK_CACHE)	+= starfive_starlink_cache.o
 
 obj-$(CONFIG_CACHE_COHERENCY_SUBSYSTEM)	+= coherency_core.o
+obj-$(CONFIG_ACPI_CACHE_CONTROL)   	+= acpi_cache_control.o
 obj-$(CONFIG_HISI_SOC_HHA)		+= hisi_soc_hha.o
diff --git a/drivers/cache/acpi_cache_control.c b/drivers/cache/acpi_cache_control.c
new file mode 100644
index 000000000000..563afff37df0
--- /dev/null
+++ b/drivers/cache/acpi_cache_control.c
@@ -0,0 +1,152 @@
+
+#include <linux/acpi.h>
+#include <linux/cache_coherency.h>
+#include <asm/cacheflush.h>
+
+struct acpi_cache_control {
+	struct cache_coherency_device ccd;
+	/* Stuff */
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
+	struct acpi_device *acpi_dev =
+		container_of(ccd->parent, struct acpi_device, dev);
+
+	return acpi_cache_control_inval(acpi_dev, invp->addr, invp->size);
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
+	acpi_cc = (struct acpi_cache_control *)
+		cache_coherency_alloc_device(&device->dev, &acpi_cc_ops,
+					     sizeof(*acpi_cc));
+	if (!acpi_cc)
+		return -ENOMEM;
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


