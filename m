Return-Path: <linux-arch+bounces-3748-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9978A8449
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 15:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63431F24905
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 13:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCC713FD9A;
	Wed, 17 Apr 2024 13:21:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D713EFEC;
	Wed, 17 Apr 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360109; cv=none; b=NdUAWRs37qMHqeMcKlFiCdD8wGx8+a4VHH9sDKlZCBrJ+urqSOLvvVqmHR+5lsQJWQSJHaSomKSbbLr20QoJNFC0Y29u1auKYLxA3tGKHQW8+1Xe8b6NI5BAJflvuQdoDrf36KHS3LeA6ML5Ay1VSqlKrT+VCYB3GiKPNSEwRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360109; c=relaxed/simple;
	bh=eKBYCEzsU41Xo7w+LoEtv+RyLGHoOc4XkmKqALxnhfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cT7RuC0XC+KTlRZQnipIUCdmNLQV4l1MQRk1xFShSFLgURr8fzi0nboxvhpciKH11hzGVUsPEMPi5Gc5ctbKntuNsIwwEP6TQb+L2j3lXN7aEfa+ML8MhfAyAWef9d6RqjOovIGxfEaI0U84nwxsVIXiwMR0Bt1qHnOHj+nu4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKM2S48bZz6JBLj;
	Wed, 17 Apr 2024 21:19:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C0FD140A08;
	Wed, 17 Apr 2024 21:21:44 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 14:21:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v6 05/16] ACPI: processor: Add acpi_get_processor_handle() helper
Date: Wed, 17 Apr 2024 14:18:58 +0100
Message-ID: <20240417131909.7925-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

If CONFIG_ACPI_PROCESSOR provide a helper to retriever the
acpi_handle for a given CPU allowing access to methods
in DSDT.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v6: New patch
---
 drivers/acpi/acpi_processor.c | 10 ++++++++++
 include/linux/acpi.h          |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 2c164451ab53..7ecb13775d7f 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -35,6 +35,16 @@ EXPORT_PER_CPU_SYMBOL(processors);
 struct acpi_processor_errata errata __read_mostly;
 EXPORT_SYMBOL_GPL(errata);
 
+acpi_handle acpi_get_processor_handle(int cpu)
+{
+	acpi_handle handle = NULL;
+	struct acpi_processor *pr = per_cpu(processors, cpu);;
+
+	if (pr)
+		handle = pr->handle;
+
+	return handle;
+}
 static int acpi_processor_errata_piix4(struct pci_dev *dev)
 {
 	u8 value1 = 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 34829f2c517a..9844a3f9c4e5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -309,6 +309,8 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
 int acpi_unmap_cpu(int cpu);
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
+acpi_handle acpi_get_processor_handle(int cpu);
+
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
 #endif
@@ -1077,6 +1079,11 @@ static inline bool acpi_sleep_state_supported(u8 sleep_state)
 	return false;
 }
 
+static inline acpi_handle acpi_get_processor_handle(int cpu)
+{
+	return NULL;
+}
+
 #endif	/* !CONFIG_ACPI */
 
 extern void arch_post_acpi_subsys_init(void);
-- 
2.39.2


