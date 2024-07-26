Return-Path: <linux-arch+bounces-5647-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8804393DAE8
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 00:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49954283785
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 22:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B0914F9FD;
	Fri, 26 Jul 2024 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ooH+d9b/"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC714A0AE;
	Fri, 26 Jul 2024 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034770; cv=none; b=QBkWpZCG3On1aAmT4vRCf1pQwnuzLcwn1vyjv3QLPZ12ZwDyIerExQzT0ZRqXm+AcHLpW8vdokWN0xPJyF0M26YEfK7GnWMXB8iuGW5wihFIANvyA0Vse4qSiYNU9fB4aq7fr3KjOQUNgSUOYpyhonRkjRg6xlA19DCzEC9Q69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034770; c=relaxed/simple;
	bh=HFBoWSD8uQoZuJWa7FvNTiQLxRg6hK3Qpe4FaW2NSH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+GT5Df+RxE/0OBBScxluFOibS/dafxFliq5GkNDyjxnMwy6z3BWi86pSCS+6vwQHcxnShnfMwHO0BsEQalCDNlT7j+1YCfWtA6ACzn+D3BGuqiYPxNxAOjwDdarD1DRyoBrMsMVm2TdjImO1dDV8Nji9tlicVJ0Bzl4m8DnLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ooH+d9b/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2ABEC20B7177;
	Fri, 26 Jul 2024 15:59:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2ABEC20B7177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722034768;
	bh=WFxhd+9RO4zGcRAHUQgDgONPVosLPQEEwR7xsvUdJIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ooH+d9b/veU9GXEUGc1iFPvDL8E0ekXCc57TFGFw0fK31DgQKrUK1o7HmfnsmfYR7
	 kP//lNqDHHiUgdttFp2PWPsdhVSKaByiDO7b54XFkwFXZZ2x5SJFhHNcZALkVH1efF
	 C4z1JtgXGDyzfqEeQzxZOv+39xhSCGNZ6RsZxvK8=
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
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v3 1/7] arm64: hyperv: Use SMC to detect hypervisor presence
Date: Fri, 26 Jul 2024 15:59:04 -0700
Message-Id: <20240726225910.1912537-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726225910.1912537-1-romank@linux.microsoft.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
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

Hoist the ACPI detection logic into a separate function,
use the new SMC added recently to Hyper-V to use in the
non-ACPI case.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c      | 36 ++++++++++++++++++++++++++-----
 arch/arm64/include/asm/mshyperv.h |  5 +++++
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index b1a4de4eee29..341f98312667 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -27,6 +27,34 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
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
+static bool hyperv_detect_via_smc(void)
+{
+	struct arm_smccc_res res = {};
+
+	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
+		return false;
+	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
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
@@ -35,13 +63,11 @@ static int __init hyperv_init(void)
 
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
+	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smc())
 		return 0;
 
 	/* Setup the guest ID */
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index a975e1a689dd..a7a3586f7cb1 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -51,4 +51,9 @@ static inline u64 hv_get_msr(unsigned int reg)
 
 #include <asm-generic/mshyperv.h>
 
+#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x7948734d
+#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1	0x56726570
+#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2	0
+#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3	0
+
 #endif
-- 
2.34.1


