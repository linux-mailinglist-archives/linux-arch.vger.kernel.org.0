Return-Path: <linux-arch+bounces-9865-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07885A19C8F
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 02:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EF8188EF2E
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 01:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6233596E;
	Thu, 23 Jan 2025 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JxC0+PgQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C42335C0;
	Thu, 23 Jan 2025 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596860; cv=none; b=iwnSQhlIkffoTXvpCfBjgVsG2jkA4+GDDMZAljQszndlK1XSDRbHxWpuued3JaSYp8yDTXJAVfOYxU8X4ap9vm39ubMQZh9jR1EhWcFw57pHhBjwhvzvA0UCZ0NS7lZj6Q2ouphFJMKyrRBXPEvPcyIASlAy+PvgZcDqIKJRpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596860; c=relaxed/simple;
	bh=VRMUCX4mtMHNpggA8n+cpy27OhEvJ/bAb37lZNSudX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NCADGPwj1Ef8iVxw90i2aSivVIFenq2udKAuB9Ast9EKpt5kwAoeMBbiLLI5udqH0oplwxNENrr1opjwrFABF0j+P78CWPBUb371kSS5NWO2ftzPAurmRtK8FxHjP+PN5meAPotsmRE6VwtK0/RFioWtZIpB2aUoN8Y5EDZJ/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JxC0+PgQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id BBB51204608E;
	Wed, 22 Jan 2025 17:47:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBB51204608E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737596857;
	bh=6NfCLWYjzohmjwKMnEJxLhyvdS+DcJjcJ204KGwB6cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxC0+PgQbFLyu5BN4cHStsTyVZgdXYCKoz+x4NJDXbrf/07eOHZ4FaTeqgPOJkLSN
	 wP1yP7WVhbnjB2JCapFBmbjrrwAagiyH1BwSLg4kBoCubZj1XCRmdqZD8FT+/TYykm
	 bNlYZ56H3KVOk6KVOZkek3MPc9LJGN+2yDCPXKUc=
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
Subject: [PATCH v2 1/2] hyperv: Move hv_current_partition_id to arch-generic code
Date: Wed, 22 Jan 2025 17:47:30 -0800
Message-Id: <1737596851-29555-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737596851-29555-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1737596851-29555-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

From: Nuno Das Neves <nudasnev@microsoft.com>

Move hv_current_partition_id and hv_get_partition_id() to hv_common.c.
These aren't specific to x86_64 and will be needed by common code.

Set hv_current_partition_id to HV_PARTITION_ID_SELF by default.

Use a stack variable for the output of the hypercall. This allows moving
the call of hv_get_partition_id() to hv_common_init() before the percpu
pages are initialized.

Remove the BUG()s. Failing to get the id need not crash the machine.

Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       | 26 --------------------------
 arch/x86/include/asm/mshyperv.h |  2 --
 drivers/hv/hv_common.c          | 23 +++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |  1 +
 4 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 173005e6a95d..6b9f6f9f704d 100644
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
@@ -605,11 +584,6 @@ void __init hyperv_init(void)
 
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
index af5d1dc451f6..1da19b64ef16 100644
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
@@ -283,6 +286,23 @@ static inline bool hv_output_page_exists(void)
 	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
 }
 
+static void __init hv_get_partition_id(void)
+{
+	/*
+	 * Note in this case the output can be on the stack because it is just
+	 * a single u64 and hence won't cross a page boundary.
+	 */
+	struct hv_get_partition_id output;
+	u64 status;
+
+	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
+	if (!hv_result_success(status)) {
+		pr_err("Hyper-V: failed to get partition ID: %#lx\n", status);
+		return;
+	}
+	hv_current_partition_id = output.partition_id;
+}
+
 int __init hv_common_init(void)
 {
 	int i;
@@ -298,6 +318,9 @@ int __init hv_common_init(void)
 	if (hv_is_isolation_supported())
 		sysctl_record_panic_msg = 0;
 
+	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
+		hv_get_partition_id();
+
 	/*
 	 * Hyper-V expects to get crash register data or kmsg when
 	 * crash enlightment is available and system crashes. Set
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index a7bbe504e4f3..98100466e0b2 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -58,6 +58,7 @@ struct ms_hyperv_info {
 };
 extern struct ms_hyperv_info ms_hyperv;
 extern bool hv_nested;
+extern u64 hv_current_partition_id;
 
 extern void * __percpu *hyperv_pcpu_input_arg;
 extern void * __percpu *hyperv_pcpu_output_arg;
-- 
2.34.1


