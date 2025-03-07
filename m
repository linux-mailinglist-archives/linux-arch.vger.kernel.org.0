Return-Path: <linux-arch+bounces-10577-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF8A57456
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 23:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6DF1899C4D
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 22:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6592258CDF;
	Fri,  7 Mar 2025 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="In1feEoe"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE531A5B88;
	Fri,  7 Mar 2025 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384988; cv=none; b=RMR5iWKRUWqsHZ6SiWZFo393nF2d+1crzHuoU2Nyo5LWUFYA9y7eYgYnOCo3i+9rxLDVGNNXzIgGVqW1yx5mJyIk2J4rk6XITkAhfz0OS2cODfVpiUpxuVfk8OTP2WIttcczTo79YRhxZ11/8NnI0U69EHzG2T6nEUELMvxc/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384988; c=relaxed/simple;
	bh=DXZcwdqZ7+Um99Yu8bVX4q33teL2kYIRtuPMN8W1wxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KT7g8RNAoPRIq+F9f5w/KFGM9hUCE72wVosBCpNtH3cvA394nYw5C+v81ou8yD1q/+zDmAcb2IyWZA7G8PNlWJHTdBvbvZQfalR3TnFpLziV0h9aj5/HyidSt+4al+wjwxLw+tnEkqeERcEBfPTDUDvP9QS3tPn6GGJ6Wxwn6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=In1feEoe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 437382038F41;
	Fri,  7 Mar 2025 14:03:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 437382038F41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741384986;
	bh=x2+6YzGCH9kvF8OEuWUHwwZtKWajMltLjCzPTk0Dvcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=In1feEoej6g5R7YwZKrifZ7XSySTtbdcPhNwaBQT5494/M+viSKmvOWWNrrNvQ/Oz
	 xNuxOm3d0XjQT+vyIU0IFIgfV3vHUxLsfWAki95awHyrPmpsE30jQoPkJE117JU+C7
	 ii1Hw0jDB8CvmyB6mMfoA6GPskf6aNzT23flev+Q=
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
Subject: [PATCH hyperv-next v5 02/11] arm64: hyperv: Use SMCCC to detect hypervisor presence
Date: Fri,  7 Mar 2025 14:02:54 -0800
Message-ID: <20250307220304.247725-3-romank@linux.microsoft.com>
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

The arm64 Hyper-V startup path relies on ACPI to detect
running under a Hyper-V compatible hypervisor. That
doesn't work on non-ACPI systems.

Hoist the ACPI detection logic into a separate function. Then
use the vendor-specific hypervisor service call (implemented
recently in Hyper-V) via SMCCC in the non-ACPI case.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c | 43 +++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 29fcfd595f48..c647db56fd6b 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -27,6 +27,41 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 	return 0;
 }
 
+static bool __init hyperv_detect_via_acpi(void)
+{
+	if (acpi_disabled)
+		return false;
+#if IS_ENABLED(CONFIG_ACPI)
+	/*
+	 * Hypervisor ID is only available in ACPI v6+, and the
+	 * structure layout was extended in v6 to accommodate that
+	 * new field.
+	 *
+	 * At the very minimum, this check makes sure not to read
+	 * past the FADT structure.
+	 *
+	 * It is also needed to catch running in some unknown
+	 * non-Hyper-V environment that has ACPI 5.x or less.
+	 * In such a case, it can't be Hyper-V.
+	 */
+	if (acpi_gbl_FADT.header.revision < 6)
+		return false;
+	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) == 0;
+#else
+	return false;
+#endif
+}
+
+static bool __init hyperv_detect_via_smccc(void)
+{
+	uuid_t hyperv_uuid = UUID_INIT(
+		0x4d32ba58, 0x4764, 0xcd24,
+		0x75, 0x6c, 0xef, 0x8e,
+		0x24, 0x70, 0x59, 0x16);
+
+	return arm_smccc_hyp_present(&hyperv_uuid);
+}
+
 static int __init hyperv_init(void)
 {
 	struct hv_get_vp_registers_output	result;
@@ -35,13 +70,11 @@ static int __init hyperv_init(void)
 
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
-- 
2.43.0


