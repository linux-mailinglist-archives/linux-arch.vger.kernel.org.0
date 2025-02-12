Return-Path: <linux-arch+bounces-10121-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9734A31B51
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 02:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58DA3A6D96
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 01:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D3813B787;
	Wed, 12 Feb 2025 01:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HBSEQ717"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B10970830;
	Wed, 12 Feb 2025 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324606; cv=none; b=LH9F5yYjWTEacyqKEK97AQ9AlrZsoOL2wK+wAElv9RgzZjnas/pDvg3zYdvgNSgtVOrDw5MtKNjUxwuFZbYMtn7xJvoyfhtkx6Q5HFdzMiwNU5XTzzDAXaT1UX/9wNnbomAdowSGoPLPJpi/lQzTVktMDushZYT+A/8mc4sppSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324606; c=relaxed/simple;
	bh=DXxR4o7FdA/wM/d2xFuE/K8y5g6RoVwgzCVwcakdFzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGgajz1j9/aO25YMsM0KsXGyj4twgPEkeR9eDRBTns08BlHK9nGDSMhUtKuCABkD14xQ2cBMkAwVA6ph1dr1Ekc8vaOjzD3JwON2z/27erb95XeMo1LktS3+YOY87Uk12AzPgVrBcwcQAHouOtGIV5jIPNuDoTz4ZySEMrdmP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HBSEQ717; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7E4B22107AB7;
	Tue, 11 Feb 2025 17:43:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E4B22107AB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739324603;
	bh=ke8cvJN/HfyiHGq5dWCetxLWOqUXILvWweb02I4ZK1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBSEQ717Slt2XikuFXsv6EVMcSlkRpZmNGfZWorh0dzembs4fchjiNu946G6p0Pos
	 NJEHBGxXxmJHGILF4w9YBh9Bc/mqdVs1wG8zfhiioyX0nYfyP+l2xWCwM3AF3DMOAd
	 rIM8Kt2aVsfaBgHnF1RPL5yBOSEdHukKmafKctNA=
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
Subject: [PATCH hyperv-next v4 1/6] arm64: hyperv: Use SMCCC to detect hypervisor presence
Date: Tue, 11 Feb 2025 17:43:16 -0800
Message-ID: <20250212014321.1108840-2-romank@linux.microsoft.com>
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

The arm64 Hyper-V startup path relies on ACPI to detect
running under a Hyper-V compatible hypervisor. That
doesn't work on non-ACPI systems.

Hoist the ACPI detection logic into a separate function. Then
use the vendor-specific hypervisor service call (implemented
recently in Hyper-V) via SMCCC in the non-ACPI case.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c      | 43 +++++++++++++++++++++++++++----
 arch/arm64/include/asm/mshyperv.h |  5 ++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index fc49949b7df6..fe6185bf3bf2 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -27,6 +27,36 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 	return 0;
 }
 
+static bool hyperv_detect_via_acpi(void)
+{
+	if (acpi_disabled)
+		return false;
+#if IS_ENABLED(CONFIG_ACPI)
+	/* Hypervisor ID is only available in ACPI v6+. */
+	if (acpi_gbl_FADT.header.revision < 6)
+		return false;
+	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) == 0;
+#else
+	return false;
+#endif
+}
+
+static bool hyperv_detect_via_smccc(void)
+{
+	struct arm_smccc_res res = {};
+
+	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
+		return false;
+	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
+	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
+		return false;
+
+	return res.a0 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0 &&
+		res.a1 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1 &&
+		res.a2 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2 &&
+		res.a3 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3;
+}
+
 static int __init hyperv_init(void)
 {
 	struct hv_get_vp_registers_output	result;
@@ -35,13 +65,11 @@ static int __init hyperv_init(void)
 
 	/*
 	 * Allow for a kernel built with CONFIG_HYPERV to be running in
-	 * a non-Hyper-V environment, including on DT instead of ACPI.
+	 * a non-Hyper-V environment.
+	 *
 	 * In such cases, do nothing and return success.
 	 */
-	if (acpi_disabled)
-		return 0;
-
-	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
+	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
 		return 0;
 
 	/* Setup the guest ID */
@@ -72,6 +100,11 @@ static int __init hyperv_init(void)
 		return ret;
 	}
 
+	ms_hyperv.vtl = get_vtl();
+	/* Report if non-default VTL */
+	if (ms_hyperv.vtl > 0)
+		pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
+
 	ms_hyperv_late_init();
 
 	hyperv_initialized = true;
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 2e2f83bafcfb..a6d7eb9e167b 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -50,4 +50,9 @@ static inline u64 hv_get_msr(unsigned int reg)
 
 #include <asm-generic/mshyperv.h>
 
+#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x4d32ba58U
+#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1	0xcd244764U
+#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2	0x8eef6c75U
+#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3	0x16597024U
+
 #endif
-- 
2.43.0


