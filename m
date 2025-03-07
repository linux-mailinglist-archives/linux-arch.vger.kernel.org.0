Return-Path: <linux-arch+bounces-10579-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FF5A57464
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 23:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A36188A861
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 22:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FBB241663;
	Fri,  7 Mar 2025 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SmeZN7Lb"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C721A257AF6;
	Fri,  7 Mar 2025 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384989; cv=none; b=SGKgGRjUp3Rc0wDFDHkvEJtCCtA+WZrG4/P09QhhLrePEL9rgH/0REjfmk6YuH6K0NT05UYBwQMaCL11tXv/7Bsg9T8FBUgCbAGHaBhQp/uaIqqz9kn9xtmN3U5JFehqEIOANW5FSb7kQLfdvpyPauDlDJlGKD0sAPlmUNVpTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384989; c=relaxed/simple;
	bh=pUXd8a24BWr/If8yKWC7SI3P96wXCDB3S7aofA94o/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tx6IwFch53DdyLKUpFyYHdZIe8ctiwGhJjglCq3TXZjBsbu9qXAEzqzmCGwF7vm0WAS6KqHf70bVaQmV1hS46ObXz85jD0/mDDo15/bCdUCl8T7+b5SwcZ3iUI7mxdBa0cABtTN8GDl+ejwUXf49PlaD+cL3Wp2/O62IwaTtAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SmeZN7Lb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 026C32038F44;
	Fri,  7 Mar 2025 14:03:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 026C32038F44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741384987;
	bh=ldsl4K4YxYUSavHnW6nd3IkU8JgmoFKyXl0ao0TSXR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmeZN7LbQWS0N6QaYxwk545+acqCnJYGcw0dJMBadi3fypUHCE1amK72gGrU1MYZX
	 E1FHukGhW1zZf0kIVEYhnp+FO3IVn3cHMMDIUm6Tp3l2sq9d8oBDr54XeA4n+aoaQq
	 ePdo0N/V5IO2/SPjV8xIan26tyT9HX+jvXTeKfoc=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	krzk+dt@kernel.org,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	mingo@redhat.com,
	oliver.upton@linux.dev,
	rafael@kernel.org,
	robh@kernel.org,
	ssengar@linux.microsoft.com,
	sudeep.holla@arm.com,
	suzuki.poulose@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	yuzenghui@huawei.com,
	devicetree@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v5 04/11] Drivers: hv: Provide arch-neutral implementation of get_vtl()
Date: Fri,  7 Mar 2025 14:02:56 -0800
Message-ID: <20250307220304.247725-5-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307220304.247725-1-romank@linux.microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
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
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/hv_init.c      | 34 ----------------------------------
 drivers/hv/hv_common.c         | 31 +++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  6 ++++++
 include/hyperv/hvgdk_mini.h    |  2 +-
 4 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 9be1446f5bd3..e204cb9d41af 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -390,40 +390,6 @@ static void __init hv_stimer_setup_percpu_clockev(void)
 		old_setup_percpu_clockev();
 }
 
-#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
-static u8 __init get_vtl(void)
-{
-	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
-	struct hv_input_get_vp_registers *input;
-	struct hv_output_get_vp_registers *output;
-	unsigned long flags;
-	u64 ret;
-
-	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-
-	memset(input, 0, struct_size(input, names, 1));
-	input->partition_id = HV_PARTITION_ID_SELF;
-	input->vp_index = HV_VP_INDEX_SELF;
-	input->input_vtl.as_uint8 = 0;
-	input->names[0] = HV_REGISTER_VSM_VP_STATUS;
-
-	ret = hv_do_hypercall(control, input, output);
-	if (hv_result_success(ret)) {
-		ret = output->values[0].reg8 & HV_X64_VTL_MASK;
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
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index ee3083937b4f..10983e854a4d 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -304,6 +304,37 @@ void __init hv_get_partition_id(void)
 		pr_err("Hyper-V: failed to get partition ID: %#x\n",
 		       hv_result(status));
 }
+#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
+u8 __init get_vtl(void)
+{
+	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
+	struct hv_input_get_vp_registers *input;
+	struct hv_output_get_vp_registers *output;
+	unsigned long flags;
+	u64 ret;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	memset(input, 0, struct_size(input, names, 1));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->vp_index = HV_VP_INDEX_SELF;
+	input->input_vtl.as_uint8 = 0;
+	input->names[0] = HV_REGISTER_VSM_VP_STATUS;
+
+	ret = hv_do_hypercall(control, input, output);
+	if (hv_result_success(ret)) {
+		ret = output->values[0].reg8 & HV_VTL_MASK;
+	} else {
+		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
+		BUG();
+	}
+
+	local_irq_restore(flags);
+	return ret;
+}
+#endif
 
 int __init hv_common_init(void)
 {
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 7adc10a4fa3e..bf897c528976 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -320,4 +320,10 @@ static inline enum hv_isolation_type hv_get_isolation_type(void)
 }
 #endif /* CONFIG_HYPERV */
 
+#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
+u8 __init get_vtl(void);
+#else
+static inline u8 get_vtl(void) { return 0; }
+#endif
+
 #endif
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 58895883f636..98aa64e8844c 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1202,7 +1202,7 @@ struct hv_send_ipi {	 /* HV_INPUT_SEND_SYNTHETIC_CLUSTER_IPI */
 	u64 cpu_mask;
 } __packed;
 
-#define	HV_X64_VTL_MASK			GENMASK(3, 0)
+#define	HV_VTL_MASK			GENMASK(3, 0)
 
 /* Hyper-V memory host visibility */
 enum hv_mem_host_visibility {
-- 
2.43.0


