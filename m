Return-Path: <linux-arch+bounces-9864-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA2A19C8D
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 02:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16D8188EE9E
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04283595A;
	Thu, 23 Jan 2025 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V3/7FBqm"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C9E347B4;
	Thu, 23 Jan 2025 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596859; cv=none; b=uApiYgCIYQsksIO15eeGZvYS3R2xDHwMKPvGGIs4EjXBDQI4AVBEIPdP8N7B8RhqJFp27JIdSwicRIq/WnUU5TYidINEhMGMwXi4afVRuPsJ+5hv+V7aZf6nsrqD1z/ftXogqp74ooGX8SJIlKAw+Lq1M95VoOdAV6zyXu2xi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596859; c=relaxed/simple;
	bh=sNuySxk/jrsvuYgnbG7KDag3yMX0f3CD7x1EoWSzELY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WUbT0FXfgNi2hAqUqLaRRSKWuKt46QaF30U7v0MZ7sJSs+FWIBZq3tNij6uRgYxTshwO7c5PShSc1Pxaf1QNu4BuWRj5kv2QDC4uKkMDJSmKHT/FFAzOqFcVVy3qLISDynAAM/18nkuRdGPpBJTK4CwJFDyHCFEaVWPD7emG7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V3/7FBqm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D679620460AC;
	Wed, 22 Jan 2025 17:47:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D679620460AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737596857;
	bh=jUd3nYHBFUMb5NuBBIgO9Gi+R58pJN5c8SjZrFanpMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3/7FBqmxqfGobbLVAeLoghaH9VxsrO+Kvpa7PITW9slxtZln5yPSpaZKW2eqBNm5
	 Umi5mw6/eq8JpeD8G6yvFfqU1xfQYk4edFPwALUwQZwQdr78WRNlTSB8mt09J9yxtE
	 qhJ90JY7ea0Xx3A0KbOtZya4D9LXbZ9E1k4PbwnE=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	wei.liu@kernel.org,
	mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: [PATCH v2 2/2] hyperv: Move arch/x86/hyperv/hv_proc.c to drivers/hv
Date: Wed, 22 Jan 2025 17:47:31 -0800
Message-Id: <1737596851-29555-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737596851-29555-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1737596851-29555-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

These helpers are not specific to x86_64 and will be needed by common code.
Remove some unnecessary #includes.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/hyperv/Makefile                  | 2 +-
 arch/x86/include/asm/mshyperv.h           | 4 ----
 drivers/hv/Makefile                       | 2 +-
 {arch/x86/hyperv => drivers/hv}/hv_proc.c | 4 ----
 include/asm-generic/mshyperv.h            | 4 ++++
 5 files changed, 6 insertions(+), 10 deletions(-)
 rename {arch/x86/hyperv => drivers/hv}/hv_proc.c (98%)

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 3a1548054b48..d55f494f471d 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y			:= hv_init.o mmu.o nested.o irqdomain.o ivm.o
-obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
+obj-$(CONFIG_X86_64)	+= hv_apic.o
 obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
 
 ifdef CONFIG_X86_64
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 8d3ada3e8d0d..7dfca93ef048 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -56,10 +56,6 @@ u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 #define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
 #define HV_AP_SEGMENT_LIMIT		0xffffffff
 
-int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
-int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
-int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
-
 /*
  * If the hypercall involves no input or output parameters, the hypervisor
  * ignores the corresponding GPA pointer.
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index b992c0ed182b..9afcabb3fbd2 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -13,4 +13,4 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 
 # Code that must be built-in
-obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
+obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o hv_proc.o
diff --git a/arch/x86/hyperv/hv_proc.c b/drivers/hv/hv_proc.c
similarity index 98%
rename from arch/x86/hyperv/hv_proc.c
rename to drivers/hv/hv_proc.c
index ac4c834d4435..3e410489f480 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -6,11 +6,7 @@
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
 #include <linux/minmax.h>
-#include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
-#include <asm/apic.h>
-
-#include <asm/trace/hyperv.h>
 
 /*
  * See struct hv_deposit_memory. The first u64 is partition ID, the rest
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 98100466e0b2..faf5d27a76b1 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -217,6 +217,10 @@ void *hv_alloc_hyperv_page(void);
 void *hv_alloc_hyperv_zeroed_page(void);
 void hv_free_hyperv_page(void *addr);
 
+int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
+int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
+int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
+
 /**
  * hv_cpu_number_to_vp_number() - Map CPU to VP.
  * @cpu_number: CPU number in Linux terms
-- 
2.34.1


