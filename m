Return-Path: <linux-arch+bounces-11343-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8BDA819AE
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 02:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEF24A5907
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 00:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBA81F956;
	Wed,  9 Apr 2025 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iDjCyAcd"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FBB258A;
	Wed,  9 Apr 2025 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157327; cv=none; b=r6kc5AJOI0ch2yIzU+k32+ZYBvf7V89nbpRmtmlJUyesGqj9kIufCgezKp8ILLB6Le3l6d7E9nTcsqec8JozvUpJ5VM6EKxToIK4xUuMRm3K0n1bQUw7Q3Jjfz1DiYL6jHbyWT69O6i0Xg8gW0bdgyaNXDwOYrIy520YPCsU0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157327; c=relaxed/simple;
	bh=TzegTHBmX8xpxC1koWbRZZ7J4AlrlbwynYjvHGR+LTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEj6/BB6qOslQClsJJUtVmoza/JtSEe633DUNO1IYOkNAtCZp+keRIe6Rlyf/2RVCU2AxvudIaUwaJG+piZpjFj7CXMk/l/WWFCEDQtitV7Z3h1deWbnrjzx4WKUvCbAE2qGDg1zrEi2SS+b+MAvIADMhkdkQuRZe/KkJ2rI4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iDjCyAcd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id DB55B2113E9A;
	Tue,  8 Apr 2025 17:08:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB55B2113E9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744157319;
	bh=Sg3mxreQaraq/1ciAx/jhCP/Bmu4VLiaIgfdf0GaDc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDjCyAcdNbtLj7uwkih4ucfZviBCOPhMRJni3A2gBEGdAzqiBG9+Z045qKKz4haZo
	 M+wg8LJ1F/RcW9TIpph1TemnfMJKPAVhHFbRUPRWMeSznV+HOQqS5bCe10gHFqiNLq
	 kWbG3kEoYK/oYBnSVN3185sYekG5BnB01Osmt+sg=
From: Roman Kisel <romank@linux.microsoft.com>
To: aleksander.lobakin@intel.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	bp@alien8.de,
	catalin.marinas@arm.com,
	corbet@lwn.net,
	dakr@kernel.org,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	haiyangz@microsoft.com,
	hch@lst.de,
	hpa@zytor.com,
	James.Bottomley@HansenPartnership.com,
	Jonathan.Cameron@huawei.com,
	kys@microsoft.com,
	leon@kernel.org,
	lukas@wunner.de,
	luto@kernel.org,
	m.szyprowski@samsung.com,
	martin.petersen@oracle.com,
	mingo@redhat.com,
	peterz@infradead.org,
	quic_zijuhu@quicinc.com,
	robin.murphy@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next 3/6] arch: hyperv: Get/set SynIC synth.registers via paravisor
Date: Tue,  8 Apr 2025 17:08:32 -0700
Message-ID: <20250409000835.285105-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409000835.285105-1-romank@linux.microsoft.com>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
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
index 4e27cc29c79e..1647a57a3379 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -91,3 +91,22 @@ bool hv_is_hyperv_initialized(void)
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
index 07aadf0e839f..5650a16cc5e8 100644
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


