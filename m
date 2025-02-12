Return-Path: <linux-arch+bounces-10123-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301EA31B5C
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 02:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B276D16727A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 01:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E11BD9E3;
	Wed, 12 Feb 2025 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MEeS3/i8"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C046384D2B;
	Wed, 12 Feb 2025 01:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324607; cv=none; b=pEihhSse5o84bQUk3hU5FRsNIPtYRetXsylC0qGV3E+ULGVoYk4rX0KNFH4fw96MgBVXA0QdE6kSL3aVvH5NklcHJFMMVJFH+eOJcvlg8nPu1pKMG3YbNJRi4ZVrT0ITWmodpyHylXpbCsotnxogOX2N5ueCxmntHaezmIlWnZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324607; c=relaxed/simple;
	bh=u7k2PTzKvmgUe6AXDwrvtgcjqmkTcLF241lU0TwiVgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aydY22wQiM61fclAW5690tH9FFNAMXbFwpzrjbgdoRt6Ui1OyM5Ko70TegtU4W98Kyvo1ohSDb6wo75/qGASryESewzT7Z2iGdx1sQNlxWUzWgk4dzs0zjjEBlTcZ9HkQowDYvZRHBm/wZ5yr2VW0q/KbIYqGTxrZJAUwhqv8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MEeS3/i8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id A454C2107ABA;
	Tue, 11 Feb 2025 17:43:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A454C2107ABA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739324605;
	bh=2I6sV8b2/c15kNZjhJjV/Tkl7+cbi052r8A5hiFhBws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEeS3/i8Slytok4DNZzLy0QLbRZ61+qF1K3tmbmGtwvs6TsmsPyhTNC63itaCGE62
	 /Bagk8yLXg//tYTlpxii6J6CqEtGkFuy8o2kFW9oSf7blLxIBnWgoodp5MewORRMHK
	 XXS4PGf5xtqLu2TL59Kv8x909orxwlBkp60KfxLM=
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
	krzk+dt@kernel.org,
	kw@linux.com,
	kys@microsoft.com,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	mingo@redhat.com,
	robh@kernel.org,
	ssengar@linux.microsoft.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v4 3/6] Drivers: hv: Provide arch-neutral implementation of get_vtl()
Date: Tue, 11 Feb 2025 17:43:18 -0800
Message-ID: <20250212014321.1108840-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212014321.1108840-1-romank@linux.microsoft.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
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
 arch/x86/hyperv/hv_init.c      | 34 ----------------------------------
 drivers/hv/hv_common.c         | 32 ++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  6 ++++++
 include/hyperv/hvgdk_mini.h    |  2 +-
 4 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 173005e6a95d..383bca1a3ae2 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -411,40 +411,6 @@ static void __init hv_get_partition_id(void)
 	local_irq_restore(flags);
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
index af5d1dc451f6..70f754710170 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -283,6 +283,38 @@ static inline bool hv_output_page_exists(void)
 	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
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
+
 int __init hv_common_init(void)
 {
 	int i;
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index a7bbe504e4f3..bb36856c3467 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -314,4 +314,10 @@ static inline enum hv_isolation_type hv_get_isolation_type(void)
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
index 155615175965..0f8443595732 100644
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


