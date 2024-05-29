Return-Path: <linux-arch+bounces-4599-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985AE8D381C
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 15:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55140284FB8
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557C19BBA;
	Wed, 29 May 2024 13:43:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9115E18E28;
	Wed, 29 May 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990217; cv=none; b=QTbOnYGD3AM0aWz9b5xU76nqfWlnxsAxjF+oJoRs+tzfMy0hpzK6czL/pP/BMi+PBEh07GeJtPd55oaN4Q2MkJzzJNJf/1P7mXi6KTLpBIMPPS4y/YsfKBFECxqCg1M8a8z4nSxmk37FlH6Q8PdwjFtKltmmqmrbUE7Hzy0lzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990217; c=relaxed/simple;
	bh=ZY3liP69UN7Ja5MApkNeUcus0/69ho7Ta549R0hBqbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkoFa/cSIaJM0wWTBK2vHw+aFmnm4kIZPjBIMsPlPL6HTKjjsnNrSB2o1kPHr4nKoKo4Cg0d8Pv3CN2Wr9/64ely64N8qLLtdGEJdkaqwiE22P+QICkEKAWp0u7ntkyzUl2vdMAPW7cCPcEPhKOXO3/Azv39NSD/jIq4RoYWLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vq9Tg4cqVz6J6qR;
	Wed, 29 May 2024 21:39:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6EA9D140B3C;
	Wed, 29 May 2024 21:43:33 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 14:43:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, <loongarch@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Hanjun Guo <guohanjun@huawei.com>, Gavin
 Shan <gshan@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v10 17/19] arm64: Kconfig: Enable hotplug CPU on arm64 if ACPI_PROCESSOR is enabled.
Date: Wed, 29 May 2024 14:34:44 +0100
Message-ID: <20240529133446.28446-18-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

In order to move arch_register_cpu() to be called via the same path
for initially present CPUs described by ACPI and hotplugged CPUs
ACPI_HOTPLUG_CPU needs to be enabled.

The protection against invalid IDs in acpi_map_cpu() is needed as
at least one production BIOS is in the wild which reports entries
in DSDT (with no _STA method, so assumed enabled and present)
that don't match MADT.

Tested-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/arm64/Kconfig       |  1 +
 arch/arm64/kernel/acpi.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d91259ee7b5..e8f2ef2312db 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -5,6 +5,7 @@ config ARM64
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_GTDT if ACPI
+	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR
 	select ACPI_IORT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if (ACPI && PCI)
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e0e7b93c16cc..9360ba86678b 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -30,6 +30,7 @@
 #include <linux/pgtable.h>
 
 #include <acpi/ghes.h>
+#include <acpi/processor.h>
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
 #include <asm/daifflags.h>
@@ -423,6 +424,27 @@ void arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 	memblock_mark_nomap(addr, size);
 }
 
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 apci_id,
+		 int *pcpu)
+{
+	/* If an error code is passed in this stub can't fix it */
+	if (*pcpu < 0) {
+		pr_warn_once("Unable to map CPU to valid ID\n");
+		return *pcpu;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_map_cpu);
+
+int acpi_unmap_cpu(int cpu)
+{
+	return 0;
+}
+EXPORT_SYMBOL(acpi_unmap_cpu);
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+
 #ifdef CONFIG_ACPI_FFH
 /*
  * Implements ARM64 specific callbacks to support ACPI FFH Operation Region as
-- 
2.39.2


