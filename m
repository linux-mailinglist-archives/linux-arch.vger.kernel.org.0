Return-Path: <linux-arch+bounces-9293-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134859E7B9C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 23:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E528416BCED
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 22:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA01EF090;
	Fri,  6 Dec 2024 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="REA7xsYY"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D605E22C6DC;
	Fri,  6 Dec 2024 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523739; cv=none; b=gfQRMQYnyKCwDNV984lMMJ2Pwqn5gwv8vjeFo7OVAEW2T/JOOriJSEN6OjKgQndCVJeZDlVo+vthsTFjy7+IWzdQpm2EbHoe3+7yxZJQtxRQrv62O35EnP/G4dt6ElkzJhSRRO8lOVTA0+OM4u4BQD5WaZnGD8u8xIJVHzcQbG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523739; c=relaxed/simple;
	bh=xUmbyKLvkGB4VPSmMjoluR8Mm89ECKjpxvLaTWBfTcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=d3aTLUtjHuRiRO5k3dQoZWI1tPjFHzCXJqzEgvIv1G8zecO8Bolusgcx5QK03k3q/UBnKp/9DlU4ZBoDIcVlSFxOL4yHMIJgxf0DKmp8Y4MVNszDTKcNDvbZ68rFqP7Q/zWuZ+xcOnwlW0fqn6IEeDCG0J3CHVHnptrKtkc3V5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=REA7xsYY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B4EA20ACD99;
	Fri,  6 Dec 2024 14:22:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B4EA20ACD99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733523737;
	bh=zsSiUfsZewJqYJI/h0zpl0Mh++LhbcoDiROgPlX5NJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REA7xsYYwqr9vixfJU9WmxCH9z4BusWtpGeeRdy7mvsMagzauApyIP5p7RXzSr4Lo
	 GpMr9/uuGKONGk+OhB0kIK4asAD5nQbKWHx6iMciJybaHapya1t4jNL/ns4uPhPlK7
	 UI3kTzx8xcuf4Nso/fmbVNchwbUwu1hxkqfW13T4=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
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
Subject: [PATCH 1/2] hyperv: Move hv_current_partition_id to arch-generic code
Date: Fri,  6 Dec 2024 14:21:46 -0800
Message-Id: <1733523707-15954-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

From: Nuno Das Neves <nudasnev@microsoft.com>

Make hv_current_partition_id available in both x86_64 and arm64.
This feature isn't specific to x86_64 and will be needed by common
code.

While at it, replace the BUG()s with WARN()s. Failing to get the id
need not crash the machine (although it is a very bad sign).

Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c    |  3 +++
 arch/x86/hyperv/hv_init.c       | 25 +------------------------
 arch/x86/include/asm/mshyperv.h |  2 --
 drivers/hv/hv_common.c          | 23 +++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |  2 ++
 5 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index b1a4de4eee29..5050e748d266 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -19,6 +19,9 @@
 
 static bool hyperv_initialized;
 
+u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
+EXPORT_SYMBOL_GPL(hv_current_partition_id);
+
 int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 {
 	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 95eada2994e1..950f5ccdb9d9 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -35,7 +35,7 @@
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
 
-u64 hv_current_partition_id = ~0ull;
+u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
 EXPORT_SYMBOL_GPL(hv_current_partition_id);
 
 void *hv_hypercall_pg;
@@ -394,24 +394,6 @@ static void __init hv_stimer_setup_percpu_clockev(void)
 		old_setup_percpu_clockev();
 }
 
-static void __init hv_get_partition_id(void)
-{
-	struct hv_get_partition_id *output_page;
-	u64 status;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
-	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
-	if (!hv_result_success(status)) {
-		/* No point in proceeding if this failed */
-		pr_err("Failed to get partition ID: %lld\n", status);
-		BUG();
-	}
-	hv_current_partition_id = output_page->partition_id;
-	local_irq_restore(flags);
-}
-
 #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
 static u8 __init get_vtl(void)
 {
@@ -606,11 +588,6 @@ void __init hyperv_init(void)
 
 	register_syscore_ops(&hv_syscore_ops);
 
-	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
-		hv_get_partition_id();
-
-	BUG_ON(hv_root_partition && hv_current_partition_id == ~0ull);
-
 #ifdef CONFIG_PCI_MSI
 	/*
 	 * If we're running as root, we want to create our own PCI MSI domain.
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 5f0bc6a6d025..9eeca2a6d047 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -44,8 +44,6 @@ extern bool hyperv_paravisor_present;
 
 extern void *hv_hypercall_pg;
 
-extern u64 hv_current_partition_id;
-
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
 bool hv_isolation_type_snp(void);
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 7a35c82976e0..819bcfd2b149 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -278,11 +278,34 @@ static void hv_kmsg_dump_register(void)
 	}
 }
 
+static void __init hv_get_partition_id(void)
+{
+	struct hv_get_partition_id *output_page;
+	u64 status;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
+	if (!hv_result_success(status)) {
+		local_irq_restore(flags);
+		WARN(true, "Failed to get partition ID: %lld\n", status);
+		return;
+	}
+	hv_current_partition_id = output_page->partition_id;
+	local_irq_restore(flags);
+}
+
 int __init hv_common_init(void)
 {
 	int i;
 	union hv_hypervisor_version_info version;
 
+	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
+		hv_get_partition_id();
+
+	WARN_ON(hv_root_partition && hv_current_partition_id == HV_PARTITION_ID_SELF);
+
 	/* Get information about the Hyper-V host version */
 	if (!hv_get_hypervisor_version(&version))
 		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 8fe7aaab2599..8c4ff6e9aae7 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -60,6 +60,8 @@ struct ms_hyperv_info {
 extern struct ms_hyperv_info ms_hyperv;
 extern bool hv_nested;
 
+extern u64 hv_current_partition_id;
+
 extern void * __percpu *hyperv_pcpu_input_arg;
 extern void * __percpu *hyperv_pcpu_output_arg;
 
-- 
2.34.1


