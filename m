Return-Path: <linux-arch+bounces-11887-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32200AB2C38
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 01:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59893177AE3
	for <lists+linux-arch@lfdr.de>; Sun, 11 May 2025 23:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1263E265607;
	Sun, 11 May 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PzCW1yrl"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DCD2620E8;
	Sun, 11 May 2025 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747004889; cv=none; b=cu39GmSKNr6zdyFO7/F2c1z6OxgRv4WRLDlHHxh/+K2meFZiKBCtkLm2rb3/A5IaWesOFp12qGsIsQ2EyLJy58BPCBObNVgnEZXIfUsB5YxQR4569+ij48gONN5bMAQvqsRq96o78bbDONVtGFwpVH1FIZgDgTaxzkQzSdaQuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747004889; c=relaxed/simple;
	bh=MQn24UdbbevAqrHXHYeV/oktCjUW7qO5pLk5OfEPdFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1K4JHlRipIXEk4nYaZMZZ4M+IrrG7/q9XccVTdC8M/DznJf1HHUNQkuFznJcNdXfhmzzbnGm+e0Ip9olml8jMEcgi8oZjeaNzCRQHx7AdVVDWeyXIScFWZuS02p/sZQpEXa2lJENpN8M5Hb1x841CgwzITTKBgxqDvdR5GyMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PzCW1yrl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3456B211D8B9;
	Sun, 11 May 2025 16:08:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3456B211D8B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747004881;
	bh=NlBiHNDCBFA2gIOS3joGMIV+HKwt3xvTaKZNTMqyrfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PzCW1yrlgSBWFcf9ZDvqROWW59RHvobznCPyYkUchsjAvDfhkhzJGxAXr4Ut5FNta
	 hGYnBkdDFxoWMdj8sfCOT5Mh2sQcamvpWCT/kyTAR+ttg5+dSqTXccbQwg2wUFkOh0
	 Z8DRv91cnRv0udrfZhUoJj42V8oOQhiRjRTWEVGo=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	catalin.marinas@arm.com,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v2 3/4] arch: hyperv: Get/set SynIC synth.registers via paravisor
Date: Sun, 11 May 2025 16:07:57 -0700
Message-ID: <20250511230758.160674-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511230758.160674-1-romank@linux.microsoft.com>
References: <20250511230758.160674-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The confidential VMBus is built on the guest talking to the
paravisor only.

Provide functions that allow manipulating the SynIC registers
via paravisor.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c      | 19 +++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h |  3 +++
 arch/x86/include/asm/mshyperv.h   |  3 +++
 arch/x86/kernel/cpu/mshyperv.c    | 28 ++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 4fdc26ade1d7..8778b6831062 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -134,3 +134,22 @@ bool hv_is_hyperv_initialized(void)
 	return hyperv_initialized;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+/*
+ * Not supported yet.
+ */
+u64 hv_pv_get_synic_register(unsigned int reg, int *err)
+{
+	*err = -ENODEV;
+	return !0ULL;
+}
+EXPORT_SYMBOL_GPL(hv_pv_get_synic_register);
+
+/*
+ * Not supported yet.
+ */
+int hv_pv_set_synic_register(unsigned int reg, u64 val)
+{
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(hv_pv_set_synic_register);
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index b721d3134ab6..bce37a58dff0 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -53,6 +53,9 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
 	return hv_get_msr(reg);
 }
 
+u64 hv_pv_get_synic_register(unsigned int reg, int *err);
+int hv_pv_set_synic_register(unsigned int reg, u64 val);
+
 /* SMCCC hypercall parameters */
 #define HV_SMCCC_FUNC_NUMBER	1
 #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index bab5ccfc60a7..0a4b01c1f094 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -307,6 +307,9 @@ static __always_inline u64 hv_raw_get_msr(unsigned int reg)
 	return __rdmsr(reg);
 }
 
+u64 hv_pv_get_synic_register(unsigned int reg, int *err);
+int hv_pv_set_synic_register(unsigned int reg, u64 val);
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3e2533954675..4f6e3d02f730 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -89,6 +89,34 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value)
 }
 EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
 
+/*
+ * Not every paravisor supports getting SynIC registers, and
+ * this function may fail. The caller has to make sure that this function
+ * runs on the CPU of interest.
+ */
+u64 hv_pv_get_synic_register(unsigned int reg, int *err)
+{
+	if (!hv_is_synic_msr(reg)) {
+		*err = -ENODEV;
+		return !0ULL;
+	}
+	return native_read_msr_safe(reg, err);
+}
+EXPORT_SYMBOL_GPL(hv_pv_get_synic_register);
+
+/*
+ * Not every paravisor supports setting SynIC registers, and
+ * this function may fail. The caller has to make sure that this function
+ * runs on the CPU of interest.
+ */
+int hv_pv_set_synic_register(unsigned int reg, u64 val)
+{
+	if (!hv_is_synic_msr(reg))
+		return -ENODEV;
+	return wrmsrl_safe(reg, val);
+}
+EXPORT_SYMBOL_GPL(hv_pv_set_synic_register);
+
 u64 hv_get_msr(unsigned int reg)
 {
 	if (hv_nested)
-- 
2.43.0


