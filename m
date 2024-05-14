Return-Path: <linux-arch+bounces-4404-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4388C5DBB
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 00:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10FB282965
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 22:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1674B182CA9;
	Tue, 14 May 2024 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rIpAff7U"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8F017F378;
	Tue, 14 May 2024 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726729; cv=none; b=Un5E/8VwI0lPymcpeyYHjDC1vJumC5kG7U//bBm0lqf8IdPgOYdeNyO926NmEaefG+uGQ7xG1vX29qQJJnNN6oc8spKUFQkDWsActU7no4K8UF5E3buJGsNz80aQ8RQpw11gH1w5ubIROt5gX/ZKr10al5tQ6Y+X3J9h73LHhnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726729; c=relaxed/simple;
	bh=aty2NkLBEGJ2qYaz1Gbe0SvAWHyFBA49AT6NoIrguDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=db+bYHSXP1KL4ZsrnnAQxA4inTBEP70vU3LwA4iZAAeq0dWTLPoD7ltEO5LGxVMv7q36tURoNsNhX8P37blYb7QoZpxqfB5geCu+ZZNtGzaghQW3EyPUNOII8n+VNWbOylXardf0j8GDg05h2tW3qzkP78qT8Q684MsysLBYUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rIpAff7U; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F5322095D0D;
	Tue, 14 May 2024 15:45:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F5322095D0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715726721;
	bh=Y0tR2xyoixzhkEx06dVg/oDnKDEQYYiPMVX6g/T4ShY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rIpAff7UkIDHiq6Mq4q1zztwKhl0claML4lN9OOwLOcvFsTwJrZ+RnSGisArmq2OJ
	 OdKFDT5MnLFdxI5NE6hahsMqvHdDhbyO/dvLiJppDgTlFIEO3HXVsmWhCDKHI3kkyY
	 owo+nab6bj4JhWhVbcD6ktPohOr7G8JOHuYmQ1C8=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	lpieralisi@kernel.org,
	mingo@redhat.com,
	mhklinux@outlook.com,
	rafael@kernel.org,
	robh@kernel.org,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v2 3/6] drivers/hv: arch-neutral implementation of get_vtl()
Date: Tue, 14 May 2024 15:43:50 -0700
Message-ID: <20240514224508.212318-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514224508.212318-1-romank@linux.microsoft.com>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To run in the VTL mode, Hyper-V drivers have to know what
VTL the system boots in, and the arm64/hyperv code does not
have the means to compute that.

Refactor the code to hoist the function that detects VTL,
make it arch-neutral to be able to employ it to get the VTL
on arm64.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c          | 34 -----------------------
 arch/x86/include/asm/hyperv-tlfs.h |  7 -----
 drivers/hv/hv_common.c             | 43 ++++++++++++++++++++++++++++++
 include/asm-generic/hyperv-tlfs.h  |  7 +++++
 include/asm-generic/mshyperv.h     |  6 +++++
 5 files changed, 56 insertions(+), 41 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 17a71e92a343..c350fa05ee59 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -413,40 +413,6 @@ static void __init hv_get_partition_id(void)
 	local_irq_restore(flags);
 }
 
-#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
-static u8 __init get_vtl(void)
-{
-	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
-	struct hv_get_vp_registers_input *input;
-	struct hv_get_vp_registers_output *output;
-	unsigned long flags;
-	u64 ret;
-
-	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = (struct hv_get_vp_registers_output *)input;
-
-	memset(input, 0, struct_size(input, element, 1));
-	input->header.partitionid = HV_PARTITION_ID_SELF;
-	input->header.vpindex = HV_VP_INDEX_SELF;
-	input->header.inputvtl = 0;
-	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
-
-	ret = hv_do_hypercall(control, input, output);
-	if (hv_result_success(ret)) {
-		ret = output->as64.low & HV_X64_VTL_MASK;
-	} else {
-		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
-		BUG();
-	}
-
-	local_irq_restore(flags);
-	return ret;
-}
-#else
-static inline u8 get_vtl(void) { return 0; }
-#endif
-
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 3787d26810c1..9ee68eb8e6ff 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -309,13 +309,6 @@ enum hv_isolation_type {
 #define HV_MSR_STIMER0_CONFIG	(HV_X64_MSR_STIMER0_CONFIG)
 #define HV_MSR_STIMER0_COUNT	(HV_X64_MSR_STIMER0_COUNT)
 
-/*
- * Registers are only accessible via HVCALL_GET_VP_REGISTERS hvcall and
- * there is not associated MSR address.
- */
-#define	HV_X64_REGISTER_VSM_VP_STATUS	0x000D0003
-#define	HV_X64_VTL_MASK			GENMASK(3, 0)
-
 /* Hyper-V memory host visibility */
 enum hv_mem_host_visibility {
 	VMBUS_PAGE_NOT_VISIBLE		= 0,
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index dde3f9b6871a..d4cf477a4d0c 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -660,3 +660,46 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 	return HV_STATUS_INVALID_PARAMETER;
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
+
+#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
+u8 __init get_vtl(void)
+{
+	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
+	struct hv_get_vp_registers_input *input;
+	struct hv_get_vp_registers_output *output;
+	unsigned long flags;
+	u64 ret;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = (struct hv_get_vp_registers_output *)input;
+
+	memset(input, 0, struct_size(input, element, 1));
+	input->header.partitionid = HV_PARTITION_ID_SELF;
+	input->header.vpindex = HV_VP_INDEX_SELF;
+	input->header.inputvtl = 0;
+	input->element[0].name0 = HV_REGISTER_VSM_VP_STATUS;
+
+	ret = hv_do_hypercall(control, input, output);
+	if (hv_result_success(ret)) {
+		ret = output->as64.low & HV_VTL_MASK;
+	} else {
+		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
+
+		/*
+		 * This is a dead end, something fundamental is broken.
+		 *
+		 * There is no sensible way of continuing as the Hyper-V drivers
+		 * transitively depend via the vmbus driver on knowing which VTL
+		 * they run in to establish communication with the host. The kernel
+		 * is going to be worse off if continued booting than a panicked one,
+		 * just hung and stuck, producing second-order failures, with neither
+		 * a way to recover nor to provide expected services.
+		 */
+		BUG();
+	}
+
+	local_irq_restore(flags);
+	return ret;
+}
+#endif
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 87e3d49a4e29..682bcda3124f 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -75,6 +75,13 @@
 /* AccessTscInvariantControls privilege */
 #define HV_ACCESS_TSC_INVARIANT			BIT(15)
 
+/*
+ * This synthetic register is only accessible via the HVCALL_GET_VP_REGISTERS
+ * hvcall, and there is no an associated MSR on x86.
+ */
+#define	HV_REGISTER_VSM_VP_STATUS	0x000D0003
+#define	HV_VTL_MASK			GENMASK(3, 0)
+
 /*
  * Group B features.
  */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 99935779682d..ea434186d765 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -301,4 +301,10 @@ static inline enum hv_isolation_type hv_get_isolation_type(void)
 }
 #endif /* CONFIG_HYPERV */
 
+#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
+u8 __init get_vtl(void);
+#else
+static inline u8 get_vtl(void) { return 0; }
+#endif
+
 #endif
-- 
2.45.0


