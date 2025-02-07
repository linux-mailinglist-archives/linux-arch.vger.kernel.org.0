Return-Path: <linux-arch+bounces-10053-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 434AFA2CC3A
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 20:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB791694EA
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 19:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE231B4153;
	Fri,  7 Feb 2025 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BxmqxAmg"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384541A01D4;
	Fri,  7 Feb 2025 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738955025; cv=none; b=QQuWJ++FqDvwYOqKPiDQSWSsonPCfD5Qf14eLyuQANlYma/7kIIIq1/u26go+DEeLzmSRfx9BJa/+5lpqOJQqiyO37MpPopfZqROdkjdvQe7VrscmUjZFsgkjt3KUYGK6CvnwZjVzfGHtSf/VBhGyMUPVfkOknTIFwX9up7y5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738955025; c=relaxed/simple;
	bh=281Ofx0qKmDeO7mxIlnIUy6vYKZYgz2LBvyQBkjpPTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=b3SAoZoz3VV/ZJn75jSEthr2GI0xBIh+MnBxBgYyHlVG96NwiIdA2b3B7ATe8IAOXnBxsqfBUjYjTIkmnvkW4XEJu/ExAcEfXdIy3m2a31o+SGNa004U7IP0GvPQ5iE2d8F+pWO1AnO1vRBhmuCKR5Tz0YRQa6z06LWAjl17M5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BxmqxAmg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 40F6E2107306;
	Fri,  7 Feb 2025 11:03:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 40F6E2107306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738955017;
	bh=QjmYEBpw4pgF8uT3VONgUY7vC1qroMcePTtvtHC0fK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxmqxAmgLi6cEdpdjAePwMNP95z9f5DlN/7vpwCnLxFos7A4p4oDMeksvkUKaEblC
	 i4k4cDhmHdiFplQJrg4wF2J8FDVF0atW/A57+2A+9xnNhKqKfbr6+mzIUr2Rj0NItB
	 HDaeyZ+cCeexbt8chAHn9Mg02BngnvzKboB4LfLE=
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
Subject: [PATCH v3 1/2] hyperv: Move hv_current_partition_id to arch-generic code
Date: Fri,  7 Feb 2025 11:03:21 -0800
Message-Id: <1738955002-20821-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738955002-20821-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1738955002-20821-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Move hv_current_partition_id and hv_get_partition_id() to hv_common.c,
and call hv_get_partition_id() on arm64 in hyperv_init(). These aren't
specific to x86_64 and will be needed by common code.

Set hv_current_partition_id to HV_PARTITION_ID_SELF by default.

Rename struct hv_get_partition_id to hv_output_get_partition_id, to
make it distinct from the function hv_get_partition_id(), and match
the original Hyper-V struct name.

Remove the BUG()s. Failing to get the id need not crash the machine.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c    |  3 +++
 arch/x86/hyperv/hv_init.c       | 25 +------------------------
 arch/x86/include/asm/mshyperv.h |  2 --
 drivers/hv/hv_common.c          | 22 ++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |  2 ++
 include/hyperv/hvgdk_mini.h     |  2 +-
 6 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index fc49949b7df6..29fcfd595f48 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -72,6 +72,9 @@ static int __init hyperv_init(void)
 		return ret;
 	}
 
+	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
+		hv_get_partition_id();
+
 	ms_hyperv_late_init();
 
 	hyperv_initialized = true;
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 173005e6a95d..9be1446f5bd3 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -34,9 +34,6 @@
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
 
-u64 hv_current_partition_id = ~0ull;
-EXPORT_SYMBOL_GPL(hv_current_partition_id);
-
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 
@@ -393,24 +390,6 @@ static void __init hv_stimer_setup_percpu_clockev(void)
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
@@ -605,11 +584,9 @@ void __init hyperv_init(void)
 
 	register_syscore_ops(&hv_syscore_ops);
 
-	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
+	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
 		hv_get_partition_id();
 
-	BUG_ON(hv_root_partition && hv_current_partition_id == ~0ull);
-
 #ifdef CONFIG_PCI_MSI
 	/*
 	 * If we're running as root, we want to create our own PCI MSI domain.
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f91ab1e75f9f..8d3ada3e8d0d 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -43,8 +43,6 @@ extern bool hyperv_paravisor_present;
 
 extern void *hv_hypercall_pg;
 
-extern u64 hv_current_partition_id;
-
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
 bool hv_isolation_type_snp(void);
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index af5d1dc451f6..cb3ea49020ef 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -31,6 +31,9 @@
 #include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
 
+u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
+EXPORT_SYMBOL_GPL(hv_current_partition_id);
+
 /*
  * hv_root_partition, ms_hyperv and hv_nested are defined here with other
  * Hyper-V specific globals so they are shared across all architectures and are
@@ -283,6 +286,25 @@ static inline bool hv_output_page_exists(void)
 	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
 }
 
+void __init hv_get_partition_id(void)
+{
+	struct hv_output_get_partition_id *output;
+	unsigned long flags;
+	u64 status, pt_id;
+
+	local_irq_save(flags);
+	output = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
+	pt_id = output->partition_id;
+	local_irq_restore(flags);
+
+	if (hv_result_success(status))
+		hv_current_partition_id = pt_id;
+	else
+		pr_err("Hyper-V: failed to get partition ID: %#lx\n",
+		       hv_result(status));
+}
+
 int __init hv_common_init(void)
 {
 	int i;
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index a7bbe504e4f3..febeddf6cd8a 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -58,6 +58,7 @@ struct ms_hyperv_info {
 };
 extern struct ms_hyperv_info ms_hyperv;
 extern bool hv_nested;
+extern u64 hv_current_partition_id;
 
 extern void * __percpu *hyperv_pcpu_input_arg;
 extern void * __percpu *hyperv_pcpu_output_arg;
@@ -207,6 +208,7 @@ extern u64 (*hv_read_reference_counter)(void);
 #define VP_INVAL	U32_MAX
 
 int __init hv_common_init(void);
+void __init hv_get_partition_id(void);
 void __init hv_common_free(void);
 void __init ms_hyperv_late_init(void);
 int hv_common_cpu_init(unsigned int cpu);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 155615175965..58895883f636 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -182,7 +182,7 @@ struct hv_tsc_emulation_control {	 /* HV_TSC_INVARIANT_CONTROL */
 
 #endif /* CONFIG_X86 */
 
-struct hv_get_partition_id {	 /* HV_OUTPUT_GET_PARTITION_ID */
+struct hv_output_get_partition_id {
 	u64 partition_id;
 } __packed;
 
-- 
2.34.1


