Return-Path: <linux-arch+bounces-10830-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82077A61A7E
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 20:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6D43BEDEF
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 19:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46048205AA6;
	Fri, 14 Mar 2025 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QgsX3nal"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC81420459A;
	Fri, 14 Mar 2025 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980567; cv=none; b=T5Y23mauDpdBL5nH5Bw+EVgmSJ98lbbfBxu6NgMMPde/Z8fGYdVTyX+8eWAwVPW9kIu0OZaSujE2EzlKSzVNFNnDt+sV+KdWeD7zjPCjV8KyXHo6tlHiPzZZdfZdiX4qr4HrewhFAp0iXCmt3aJYprCTEi1ngL1yHYo9Xe/s5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980567; c=relaxed/simple;
	bh=2DgA+WxtMeS5xEPea+yQ2oWUrQWJOpxLAqfjtUxE8zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZifGWoUeQfkZXrKp6fPltu0+f5misOzheCmPWF11TtUoFTV+LDZsPcUuvlZoM+U9w3nviiL9ueFH/e9+SXkXneWEHgH+2cJcUk4lu3MU4kbF2vg+rkS8/u9NI4PRYbUmr4LmL7kIlU9SUZKhK5lLcBwGh7+ZZCJzxzvFJ5hn1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QgsX3nal; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5DAC22033459;
	Fri, 14 Mar 2025 12:29:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5DAC22033459
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741980564;
	bh=kQpDXagoqiBnz1ULF4xuJAkhLPjv+oLVEWalqIw1Byo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QgsX3nal9IDsR2TJGB/RRIgqwXlA1XJAcEFtFir/jWdb0FV+lxfTqCBlPUIFANd3e
	 Vc6uZgDGxORP3rIneNmC1gyNtfyTIg+OL8ArNcTFcoLWqp//OtwVhCq7tPae3e10I1
	 oGTCxEimeV33kN0de0MCS5Snl2CS0w1KGYaSPRZI=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	mhklinux@outlook.com,
	ltykernel@gmail.com,
	stanislav.kinsburskiy@gmail.com,
	linux-acpi@vger.kernel.org,
	eahariha@linux.microsoft.com,
	jeff.johnson@oss.qualcomm.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	apais@linux.microsoft.com,
	gregkh@linuxfoundation.org,
	vkuznets@redhat.com,
	prapal@linux.microsoft.com,
	anrayabh@linux.microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net
Subject: [PATCH v6 03/10] arm64/hyperv: Add some missing functions to arm64
Date: Fri, 14 Mar 2025 12:28:49 -0700
Message-Id: <1741980536-3865-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

These non-nested msr and fast hypercall functions are present in x86,
but they must be available in both architectures for the root partition
driver code.

While at it, remove the redundant 'extern' keywords from the
hv_do_hypercall() variants in asm-generic/mshyperv.h.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/arm64/hyperv/hv_core.c       | 17 +++++++++++++++++
 arch/arm64/include/asm/mshyperv.h | 13 +++++++++++++
 include/asm-generic/mshyperv.h    |  6 ++++--
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index 69004f619c57..e33a9e3c366a 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -53,6 +53,23 @@ u64 hv_do_fast_hypercall8(u16 code, u64 input)
 }
 EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
 
+/*
+ * hv_do_fast_hypercall16 -- Invoke the specified hypercall
+ * with arguments in registers instead of physical memory.
+ * Avoids the overhead of virt_to_phys for simple hypercalls.
+ */
+u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
+{
+	struct arm_smccc_res	res;
+	u64			control;
+
+	control = (u64)code | HV_HYPERCALL_FAST_BIT;
+
+	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input1, input2, &res);
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(hv_do_fast_hypercall16);
+
 /*
  * Set a single VP register to a 64-bit value.
  */
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 2e2f83bafcfb..b721d3134ab6 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -40,6 +40,19 @@ static inline u64 hv_get_msr(unsigned int reg)
 	return hv_get_vpreg(reg);
 }
 
+/*
+ * Nested is not supported on arm64
+ */
+static inline void hv_set_non_nested_msr(unsigned int reg, u64 value)
+{
+	hv_set_msr(reg, value);
+}
+
+static inline u64 hv_get_non_nested_msr(unsigned int reg)
+{
+	return hv_get_msr(reg);
+}
+
 /* SMCCC hypercall parameters */
 #define HV_SMCCC_FUNC_NUMBER	1
 #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c8043efabf5a..c3697bc0598d 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -70,8 +70,10 @@ extern enum hv_partition_type hv_curr_partition_type;
 extern void * __percpu *hyperv_pcpu_input_arg;
 extern void * __percpu *hyperv_pcpu_output_arg;
 
-extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
-extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
+u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
+u64 hv_do_fast_hypercall8(u16 control, u64 input8);
+u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
+
 bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
 
-- 
2.34.1


