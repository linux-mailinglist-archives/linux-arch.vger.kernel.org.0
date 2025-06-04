Return-Path: <linux-arch+bounces-12189-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD12FACD0C2
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC0017425C
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349711CAA4;
	Wed,  4 Jun 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UsAkW9Ni"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5176CA4E;
	Wed,  4 Jun 2025 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997827; cv=none; b=pQebBDwx7bnAjRSay/GYHxrbvvmWqJ3eEFD1mAs38LkyMm+dFANFIUXDpCI7Wsnu6YlnlYJPBbynpZ0kVp2+QPBiYkxR2tOEtkAWipPzAC766E6TkxN0259WqB7F5UBJb8vb9OUeicxirpeAiVI8MrC0kTiG2mBn+RpZPggqEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997827; c=relaxed/simple;
	bh=z06AfXBu3Wnaj3am6I5bQMHfFjjgGU6Io2/r8kFyd2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fe4uCg1t9dkLcx+VZ9fayDX/QAjw/7z8hIvs6WEYx40OoFrpqMTKK2P/iVKLlAHTfRAMjWtw54SHpyCTvh8WsUEdLfElSjHIohJqK0NsdJ1bivIj4ppxl/T+NtScOkusxEb2ZevqNlYDlG6GFfaThLWzThZHj98ADcffi3J3xYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UsAkW9Ni; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 342582116B25;
	Tue,  3 Jun 2025 17:43:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 342582116B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997825;
	bh=8goRauVaYSFozRwRLcm6JZoNqih7m4xmGWRntzKXbqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsAkW9NioV6LBEgDomuRjnAfurpjQs3G5mUAkWGn4umNEd0uSk8TY7RT0XgF8GqTZ
	 HnaLsw4M7vtQLDRJZf9r7KNIqAJ1NVtoO2lB1Ls5qmZvJhuUjFcm8gzMtF9uWtIapp
	 PINmxtR94CBCr9aqgU8GWv521lbQMGp2s2giu8uA=
From: Roman Kisel <romank@linux.microsoft.com>
To: alok.a.tiwari@oracle.com,
	arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v3 03/15] arch: hyperv: Get/set SynIC synth.registers via paravisor
Date: Tue,  3 Jun 2025 17:43:29 -0700
Message-ID: <20250604004341.7194-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604004341.7194-1-romank@linux.microsoft.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
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
via paravisor. No functional changes.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 44 ++++++++++++++++++++++++++++++++++
 drivers/hv/hv_common.c         | 13 ++++++++++
 include/asm-generic/mshyperv.h |  2 ++
 3 files changed, 59 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3e2533954675..83a85d94bcb3 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -89,6 +89,50 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value)
 }
 EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
 
+/*
+ * Attempt to get the SynIC register value from the paravisor.
+ *
+ * Not all paravisors support reading SynIC registers, so this function
+ * may fail. The register for the SynIC of the running CPU is accessed.
+ *
+ * Writes the SynIC register value into the memory pointed by val,
+ * and ~0ULL is on failure.
+ *
+ * Returns -ENODEV if the MSR is not a SynIC register, or another error
+ * code if getting the MSR fails (meaning the paravisor doesn't support
+ * relaying VMBus comminucations).
+ */
+int hv_para_get_synic_register(unsigned int reg, u64 *val)
+{
+	u64 reg_val = ~0ULL;
+	int err = -ENODEV;
+
+	if (hv_is_synic_msr(reg))
+		reg_val = native_read_msr_safe(reg, &err);
+	*val = reg_val;
+
+	return err;
+}
+
+/*
+ * Attempt to set the SynIC register value with the paravisor.
+ *
+ * Not all paravisors support reading SynIC registers, so this function
+ * may fail. The register for the SynIC of the running CPU is accessed.
+ *
+ * Sets the register to the value supplied.
+ *
+ * Returns: -ENODEV if the MSR is not a SynIC register, or another error
+ * code if writing to the MSR fails (meaning the paravisor doesn't support
+ * relaying VMBus comminucations).
+ */
+int hv_para_set_synic_register(unsigned int reg, u64 val)
+{
+	if (!hv_is_synic_msr(reg))
+		return -ENODEV;
+	return wrmsrl_safe(reg, val);
+}
+
 u64 hv_get_msr(unsigned int reg)
 {
 	if (hv_nested)
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 49898d10faff..a179ea482cb1 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -716,6 +716,19 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
 
+int __weak hv_para_get_synic_register(unsigned int reg, u64 *val)
+{
+	*val = ~0ULL;
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(hv_para_get_synic_register);
+
+int __weak hv_para_set_synic_register(unsigned int reg, u64 val)
+{
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(hv_para_set_synic_register);
+
 void hv_identify_partition_type(void)
 {
 	/* Assume guest role */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 9722934a8332..f239b102fc53 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -333,6 +333,8 @@ bool hv_is_isolation_supported(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+int hv_para_get_synic_register(unsigned int reg, u64 *val);
+int hv_para_set_synic_register(unsigned int reg, u64 val);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
-- 
2.43.0


