Return-Path: <linux-arch+bounces-12912-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F709B10C5D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 15:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CAB1610DA
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E8B2E3B0D;
	Thu, 24 Jul 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQhir9Ah"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1FE2E1734
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365391; cv=none; b=sNvfRzHgA1tx2Ma45abpUpi1i2I2LjHX7CMunlmNGHV6tUvYQEsbbROcN1Oah6Pug9mvTIhlDM0ReBjGplMryP4MM5Zs5TqvHE7nL+bRen0+iDrUn4zirn4GGIh7ncKJ/Eapyh+pUYTjRLKMl6O36G3A+Grklhh5pS8k0j3a5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365391; c=relaxed/simple;
	bh=6Ns4vogZCrsB3rJa9oLf8qL6Hp/YwjVe6Wk7Ylk4d2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUPZ2IHShAC6dytb15JsANE/K9gfFvQo8yA8J3Kmapx16/mc9Qzat9yx/05q43fTcUm/bVVPSMCapB0llxJKKHRTEiCw8f1cWDAJvJ1x3YAvHsshesfPJeN4rWbGYIWHMC0mD2paihdbPR0faCrQZErrQCDAvV7kMKR70eCOCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SQhir9Ah; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso10929005e9.3
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365387; x=1753970187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAxMtA+w51S3PCwT+VkkNqGhee+g4ma13WDPbYgGlss=;
        b=SQhir9Ah5noeTJ/p4o8RkFRRs5QuVtYfriSjddHj5mwIQX3ot1/GCvSDkDEftpzEM3
         uSv4i2zWgnitJ0xbN7pAca74kkMytryLcNTV3s9a5pxoBxF3LYqOkDlOBHK5pvYMtSSt
         LEJBwrJOuKNQiARAMp4IaV0erMR5PqeFE9tsoaYrTL4beHzR8bhOg5sLk7c4OJiP59Va
         klFXay56iHqwNihkKLWNOXqF4RkzlRazlZ0KPa+9pOzaUc/jcU3Rf4tinjI1WndzGeTh
         CRrqNYhVYgd/fBTui6ZedN9Q8X329j0Ug90qXgXjuKmhFXBkEcUgT2mYYZb4/s4X1uZ9
         nadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365387; x=1753970187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAxMtA+w51S3PCwT+VkkNqGhee+g4ma13WDPbYgGlss=;
        b=ENuSLEAe4V6+STZSZb15zQe3OfRGZwunrrDkZeAjX0nVK6MD9ZayJgsh+gfXr5+y6u
         5ez5j0O36etHPFx9tE0HwxZWjNqQRg5KFGuRsQAMbcmeiq89xy68XtogDLLb0d7Pbj3S
         7fQCPIdqTUAB+Ee3LwXDa5HreaJtGQuWpw6AXKTV9uXEAhmYtnXUebhGAJnh1Q/zKSbL
         i4deBIhAogZDnb1G6RqSzAeeXUdCIiwHwLBC5CgmhwrM/BoS0sKGd5PUdEb64CGH2wXo
         z1e242jgmbYHZ/b4b/c1ePInOCPZyFMHgDcYRZRcN1yw/gHFWlgF8ymMM4uuEyluklsU
         si5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvWRA2l43rvsO6olo3Q2j1bFIyZUMonTzzdDqraxK40cB1M98ERsGiRauxyqfqY8q9jCjYnl8un0cW@vger.kernel.org
X-Gm-Message-State: AOJu0YyjPrG8r93UzOYSKaG9Jy6Fvcjrl/Y0ViBFGpcDNOyqkioJXlYQ
	nSZT6HYuO25g3kck7fWEMRTUIe8ynOaxfUdy6oDPZ/HdngRI+WrUesTDQ9c0Ev6Lld0=
X-Gm-Gg: ASbGncv/r0Yv/pHVDlc1oqM/y1kHIcibuIFs6CpM8/68SpwsBF3fhW1+XLoK5PYRgbI
	FLwSu9fWBIJbWgKWbEFnXPGTZMfKOPYobi9k70Nr3PH3/CB5AqqTRjGwpGN4HbZWxt5ohiTYhwc
	qbEqfVbkdMC682UAVCLzfeax+zVFAtvjXpFaHzUbZtCLvVOMUKPxrCcxDbrfYjcKT0fu2vTB4Pq
	zUKQzPJ0Hmqm+KIQ6ZcdunZ1eLTlrX+t0ahGjal8eusFeuIsxfEnip7xIWSgqRZwCbGftW6C/kT
	9Dq3HglHQH0ABDuKtOS5aCgKDYArw+yYXBJU0apuPKfSju1tEFnreldvRZhIqPeh7a6IbrLjQJt
	YWjO7ZMS7B+sVAtlJ1QUwHPfyB/2t8x7ZZf2BExcJawwSseMKaiWkTbhf/a2X02OolF6Ye2kIMm
	l2FfwDP+YkKcNl
X-Google-Smtp-Source: AGHT+IExCYO6BdC37olS+pAbSHh4fE6RM/f8mJb61ZeZpT0dRv6iCU18YgCf/SbYinZayjVuWPfYqw==
X-Received: by 2002:a05:6000:2586:b0:3a6:e6c3:6d95 with SMTP id ffacd0b85a97d-3b768f2681fmr5379673f8f.41.1753365386507;
        Thu, 24 Jul 2025 06:56:26 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:26 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 05/29] kmemdump: introduce qcom-minidump backend driver
Date: Thu, 24 Jul 2025 16:54:48 +0300
Message-ID: <20250724135512.518487-6-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm Minidump is a backend driver for kmemdump.
Regions are being registered into the shared memory on Qualcomm platforms
and into the table of contents.
Further, the firmware can read the table of contents and dump the memory
accordingly.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 MAINTAINERS                   |   5 +
 drivers/debug/Kconfig         |  12 ++
 drivers/debug/Makefile        |   1 +
 drivers/debug/qcom_minidump.c | 353 ++++++++++++++++++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 drivers/debug/qcom_minidump.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b43a43b61e19..68797717175c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13625,6 +13625,11 @@ F:	drivers/debug/kmemdump.c
 F:	drivers/debug/kmemdump_coreimage.c
 F:	include/linux/kmemdump.h
 
+KMEMDUMP QCOM MINIDUMP BACKEND DRIVER
+M:	Eugen Hristev <eugen.hristev@linaro.org>
+S:	Maintained
+F:	drivers/debug/qcom_minidump.c
+
 KMEMLEAK
 M:	Catalin Marinas <catalin.marinas@arm.com>
 S:	Maintained
diff --git a/drivers/debug/Kconfig b/drivers/debug/Kconfig
index 903e3e2805b7..d34ceaf99bd8 100644
--- a/drivers/debug/Kconfig
+++ b/drivers/debug/Kconfig
@@ -27,4 +27,16 @@ config KMEMDUMP_COREIMAGE
 	  for debug tools are being registered.
 	  The coredump file can then be loaded into GDB or crash  tool and
 	  further inspected.
+
+config KMEMDUMP_QCOM_MINIDUMP_BACKEND
+	tristate "Qualcomm Minidump kmemdump backend driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on KMEMDUMP
+	help
+	  Say y here to enable the Qualcomm Minidump kmemdump backend
+	  driver.
+	  With this backend, the registered regions are being linked
+	  into the minidump table of contents. Further on, the firmware
+	  will be able to read the table of contents and extract the
+	  memory regions on case-by-case basis.
 endmenu
diff --git a/drivers/debug/Makefile b/drivers/debug/Makefile
index 2b67673393a6..7f70b84049cb 100644
--- a/drivers/debug/Makefile
+++ b/drivers/debug/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_KMEMDUMP) += kmemdump.o
 obj-$(CONFIG_KMEMDUMP_COREIMAGE) += kmemdump_coreimage.o
+obj-$(CONFIG_KMEMDUMP_QCOM_MINIDUMP_BACKEND) += qcom_minidump.o
diff --git a/drivers/debug/qcom_minidump.c b/drivers/debug/qcom_minidump.c
new file mode 100644
index 000000000000..49b0b6ef193b
--- /dev/null
+++ b/drivers/debug/qcom_minidump.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Minidump backend driver for Kmemdump
+ * Copyright (C) 2016,2024-2025 Linaro Ltd
+ * Copyright (C) 2015 Sony Mobile Communications Inc
+ * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/kmemdump.h>
+#include <linux/container_of.h>
+
+/*
+ * In some of the Old Qualcomm devices, boot firmware statically allocates 300
+ * as total number of supported region (including all co-processors) in
+ * minidump table out of which linux was using 201. In future, this limitation
+ * from boot firmware might get removed by allocating the region dynamically.
+ * So, keep it compatible with older devices, we can keep the current limit for
+ * Linux to 201.
+ */
+#define MAX_NUM_REGIONS		201
+
+#define MAX_NUM_SUBSYSTEMS	10
+#define MAX_REGION_NAME_LENGTH	16
+#define SBL_MINIDUMP_SMEM_ID	602
+#define MINIDUMP_REGION_VALID	('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MINIDUMP_SS_ENCR_DONE	('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MINIDUMP_SS_ENABLED	('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
+
+#define MINIDUMP_SS_ENCR_NOTREQ	(0 << 24 | 0 << 16 | 'N' << 8 | 'R' << 0)
+
+#define MINIDUMP_SUBSYSTEM_APSS	0
+
+const char *kmemdump_id_to_md_string[] = {
+	"",
+	"ELF",
+	"vmcoreinfo",
+	"config",
+	"memsect",
+	"totalram",
+	"cpu_possible",
+	"cpu_present",
+	"cpu_online",
+	"cpu_active",
+	"jiffies",
+	"linux_banner",
+	"nr_threads",
+	"nr_irqs",
+	"tainted_mask",
+	"taint_flags",
+	"mem_section",
+	"node_data",
+	"node_states",
+	"__per_cpu_offset",
+	"nr_swapfiles",
+	"init_uts_ns",
+	"printk_rb_static",
+	"printk_rb_dynamic",
+	"prb",
+	"prb_descs",
+	"prb_infos",
+	"prb_data",
+	"runqueues",
+	"high_memory",
+	"init_mm",
+	"init_mm_pgd",
+};
+
+/**
+ * struct minidump_region - Minidump region
+ * @name		: Name of the region to be dumped
+ * @seq_num:		: Use to differentiate regions with same name.
+ * @valid		: This entry to be dumped (if set to 1)
+ * @address		: Physical address of region to be dumped
+ * @size		: Size of the region
+ */
+struct minidump_region {
+	char	name[MAX_REGION_NAME_LENGTH];
+	__le32	seq_num;
+	__le32	valid;
+	__le64	address;
+	__le64	size;
+};
+
+/**
+ * struct minidump_subsystem - Subsystem's SMEM Table of content
+ * @status : Subsystem toc init status
+ * @enabled : if set to 1, this region would be copied during coredump
+ * @encryption_status: Encryption status for this subsystem
+ * @encryption_required : Decides to encrypt the subsystem regions or not
+ * @region_count : Number of regions added in this subsystem toc
+ * @regions_baseptr : regions base pointer of the subsystem
+ */
+struct minidump_subsystem {
+	__le32	status;
+	__le32	enabled;
+	__le32	encryption_status;
+	__le32	encryption_required;
+	__le32	region_count;
+	__le64	regions_baseptr;
+};
+
+/**
+ * struct minidump_global_toc - Global Table of Content
+ * @status : Global Minidump init status
+ * @revision : Minidump revision
+ * @enabled : Minidump enable status
+ * @subsystems : Array of subsystems toc
+ */
+struct minidump_global_toc {
+	__le32				status;
+	__le32				revision;
+	__le32				enabled;
+	struct minidump_subsystem	subsystems[MAX_NUM_SUBSYSTEMS];
+};
+
+#define MINIDUMP_MAX_NAME_LENGTH	12
+/**
+ * struct qcom_minidump_region - Minidump region information
+ *
+ * @name:	Minidump region name
+ * @virt_addr:  Virtual address of the entry.
+ * @phys_addr:	Physical address of the entry to dump.
+ * @size:	Number of bytes to dump from @address location,
+ *		and it should be 4 byte aligned.
+ * @id:		Region id.
+ */
+struct qcom_minidump_region {
+	char		name[MINIDUMP_MAX_NAME_LENGTH];
+	void		*virt_addr;
+	phys_addr_t	phys_addr;
+	size_t		size;
+	unsigned int	id;
+};
+
+/**
+ * struct minidump - Minidump driver data information
+ *
+ * @dev:	Minidump device struct.
+ * @toc:	Minidump table of contents subsystem.
+ * @regions:	Minidump regions array.
+ * @md_be:	Minidump backend.
+ */
+struct minidump {
+	struct device			*dev;
+	struct minidump_subsystem	*toc;
+	struct minidump_region		*regions;
+	struct kmemdump_backend		md_be;
+};
+
+static struct minidump *md;
+
+#define be_to_minidump(be) container_of(be, struct minidump, md_be)
+
+/**
+ * qcom_apss_md_table_init() - Initialize the minidump table
+ * @md: minidump data
+ * @mdss_toc: minidump subsystem table of contents
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+static int qcom_apss_md_table_init(struct minidump *md,
+				   struct minidump_subsystem *mdss_toc)
+{
+	md->toc = mdss_toc;
+	md->regions = devm_kcalloc(md->dev, MAX_NUM_REGIONS,
+				   sizeof(*md->regions), GFP_KERNEL);
+	if (!md->regions)
+		return -ENOMEM;
+
+	md->toc->regions_baseptr = cpu_to_le64(virt_to_phys(md->regions));
+	md->toc->enabled = cpu_to_le32(MINIDUMP_SS_ENABLED);
+	md->toc->status = cpu_to_le32(1);
+	md->toc->region_count = cpu_to_le32(0);
+
+	/* Tell bootloader not to encrypt the regions of this subsystem */
+	md->toc->encryption_status = cpu_to_le32(MINIDUMP_SS_ENCR_DONE);
+	md->toc->encryption_required = cpu_to_le32(MINIDUMP_SS_ENCR_NOTREQ);
+
+	return 0;
+}
+
+/**
+ * qcom_md_get_region_index() - Lookup minidump region by kmemdump id
+ * @md: minidump data
+ * @id: minidump region id
+ *
+ * Return: On success, it returns the internal region index, on failure,
+ *	returns	negative error value
+ */
+static int qcom_md_get_region_index(struct minidump *md, int id)
+{
+	unsigned int count = le32_to_cpu(md->toc->region_count);
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (md->regions[i].seq_num == id)
+			return i;
+
+	return -ENOENT;
+}
+
+/**
+ * register_md_region() - Register a new minidump region
+ * @be: kmemdump backend, this should be the minidump backend
+ * @id: unique id to identify the region
+ * @vaddr: virtual memory address of the region start
+ * @size: size of the region
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+static int register_md_region(const struct kmemdump_backend *be,
+			      enum kmemdump_uid id, void *vaddr, size_t size)
+{
+	struct minidump *md = be_to_minidump(be);
+	struct minidump_region *mdr;
+	unsigned int num_region, region_cnt;
+	const char *name = "unknown";
+
+	if (!vaddr || !size)
+		return -EINVAL;
+
+	if (id < ARRAY_SIZE(kmemdump_id_to_md_string))
+		name = kmemdump_id_to_md_string[id];
+
+	if (qcom_md_get_region_index(md, id) >= 0) {
+		dev_dbg(md->dev, "%s:%d region is already registered\n",
+			name, id);
+		return -EEXIST;
+	}
+
+	/* Check if there is a room for a new entry */
+	num_region = le32_to_cpu(md->toc->region_count);
+	if (num_region >= MAX_NUM_REGIONS) {
+		dev_err(md->dev, "maximum region limit %u reached\n",
+			num_region);
+		return -ENOSPC;
+	}
+
+	region_cnt = le32_to_cpu(md->toc->region_count);
+	mdr = &md->regions[region_cnt];
+	scnprintf(mdr->name, MAX_REGION_NAME_LENGTH, "K%.8s", name);
+	mdr->seq_num = id;
+	mdr->address = cpu_to_le64(__pa(vaddr));
+	mdr->size = cpu_to_le64(ALIGN(size, 4));
+	mdr->valid = cpu_to_le32(MINIDUMP_REGION_VALID);
+	region_cnt++;
+	md->toc->region_count = cpu_to_le32(region_cnt);
+
+	return 0;
+}
+
+/**
+ * unregister_md_region() - Unregister a previously registered minidump region
+ * @be: pointer to backend
+ * @id: unique id to identify the region
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+static int unregister_md_region(const struct kmemdump_backend *be,
+				unsigned int id)
+{
+	struct minidump *md = be_to_minidump(be);
+	struct minidump_region *mdr;
+	unsigned int region_cnt;
+	unsigned int idx;
+
+	idx = qcom_md_get_region_index(md, id);
+	if (idx < 0) {
+		dev_err(md->dev, "%d region is not present\n", id);
+		return idx;
+	}
+
+	mdr = &md->regions[0];
+	region_cnt = le32_to_cpu(md->toc->region_count);
+	/*
+	 * Left shift all the regions exist after this removed region
+	 * index by 1 to fill the gap and zero out the last region
+	 * present at the end.
+	 */
+	memmove(&mdr[idx], &mdr[idx + 1], (region_cnt - idx - 1) * sizeof(*mdr));
+	memset(&mdr[region_cnt - 1], 0, sizeof(*mdr));
+	region_cnt--;
+	md->toc->region_count = cpu_to_le32(region_cnt);
+
+	return 0;
+}
+
+static int qcom_md_probe(struct platform_device *pdev)
+{
+	struct minidump_global_toc *mdgtoc;
+	size_t size;
+	int ret;
+
+	md = kzalloc(sizeof(*md), GFP_KERNEL);
+	if (!md)
+		return -ENOMEM;
+
+	md->dev = &pdev->dev;
+
+	strscpy(md->md_be.name, "qcom_minidump");
+	md->md_be.register_region = register_md_region;
+	md->md_be.unregister_region = unregister_md_region;
+
+	mdgtoc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, &size);
+	if (IS_ERR(mdgtoc)) {
+		ret = PTR_ERR(mdgtoc);
+		dev_err(md->dev, "Couldn't find minidump smem item %d\n", ret);
+		goto qcom_md_probe_fail;
+	}
+
+	if (size < sizeof(*mdgtoc) || !mdgtoc->status) {
+		dev_err(md->dev, "minidump table is not initialized %d\n", ret);
+		ret = -ENAVAIL;
+		goto qcom_md_probe_fail;
+	}
+
+	ret = qcom_apss_md_table_init(md, &mdgtoc->subsystems[MINIDUMP_SUBSYSTEM_APSS]);
+	if (ret)
+		goto qcom_md_probe_fail;
+
+	return kmemdump_register_backend(&md->md_be);
+
+qcom_md_probe_fail:
+	kfree(md);
+	return ret;
+}
+
+static void qcom_md_remove(struct platform_device *pdev)
+{
+	kfree(md);
+	kmemdump_unregister_backend(&md->md_be);
+}
+
+static struct platform_driver qcom_md_driver = {
+	.probe = qcom_md_probe,
+	.remove = qcom_md_remove,
+	.driver  = {
+		.name = "qcom-minidump",
+	},
+};
+
+module_platform_driver(qcom_md_driver);
+
+MODULE_AUTHOR("Eugen Hristev <eugen.hristev@linaro.org>");
+MODULE_AUTHOR("Mukesh Ojha <quic_mojha@quicinc.com>");
+MODULE_DESCRIPTION("Qualcomm kmemdump minidump backend driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


