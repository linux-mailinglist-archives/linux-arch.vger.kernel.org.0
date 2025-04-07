Return-Path: <linux-arch+bounces-11303-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20978A7EEB8
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 22:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7855C1887647
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409FA222593;
	Mon,  7 Apr 2025 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aaVsjqU9"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CCA21C16B;
	Mon,  7 Apr 2025 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056827; cv=none; b=PoEXdZ35vxIdQu658HW+aNznt10dkaz44b/vsS8YKJY1H+CTuL1nRfOl4YIqxlzQqn2RxKFs42jeLUl92OO2HSyhpXRkBj4OXOTxlNHGNPWp8p6MagDTLGmXIswMwOxcnSry4smmMkxS/2HBPHf0+nNoj92X00vQQRIFDmfvbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056827; c=relaxed/simple;
	bh=qMdX+OYxCd+405CKynjk8lSsHu591NwkBTr5jpSPm0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDyMBu7LWyv+lPPUu3b+BxZmLVd+OsHeinNYfusDcA+oW6wAJls3Liy3/yaWgDel9K3Q3TtTnBmjSrWJdzmXgjimC7sh/oA2V/1AEDUpOIuGK+HfEJHZBAFMz7NyC7m/DPqHUszk+o//1z1AO9Hetg/qV0pV+wLvU8mGofweNjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aaVsjqU9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id ED98D2113E82;
	Mon,  7 Apr 2025 13:13:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED98D2113E82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744056819;
	bh=NYi43WhtS1hVthbgtuaLVNWnlw3+yXhxoNWNK/Qb6Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaVsjqU9dmtMWzUyDcmyTjmN7jCae92gA6AqQxK6XrrDpWIE09QWVB/H5VXZAVPKX
	 vrKQ+jyyw7tpEYZe9h+RpILNTblaZL99UI6OWsQmqgh6dM+HEXK5rv51wnSKvHGn68
	 v9cqM85ifB622sNaNqycYo6n9gdDYyeWWOLdj0Vk=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	dan.carpenter@linaro.org,
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
	rafael.j.wysocki@intel.com,
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
Subject: [PATCH hyperv-next v7 02/11] arm64: hyperv: Use SMCCC to detect hypervisor presence
Date: Mon,  7 Apr 2025 13:13:27 -0700
Message-ID: <20250407201336.66913-3-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407201336.66913-1-romank@linux.microsoft.com>
References: <20250407201336.66913-1-romank@linux.microsoft.com>
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
 arch/arm64/hyperv/mshyperv.c | 50 ++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 4e27cc29c79e..21458b6338aa 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -28,6 +28,48 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 }
 EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
 
+#ifdef CONFIG_ACPI
+
+static bool __init hyperv_detect_via_acpi(void)
+{
+	if (acpi_disabled)
+		return false;
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
+}
+
+#else
+
+static bool __init hyperv_detect_via_acpi(void)
+{
+	return false;
+}
+
+#endif
+
+static bool __init hyperv_detect_via_smccc(void)
+{
+	uuid_t hyperv_uuid = UUID_INIT(
+		0x58ba324d, 0x6447, 0x24cd,
+		0x75, 0x6c, 0xef, 0x8e,
+		0x24, 0x70, 0x59, 0x16);
+
+	return arm_smccc_hypervisor_has_uuid(&hyperv_uuid);
+}
+
 static int __init hyperv_init(void)
 {
 	struct hv_get_vp_registers_output	result;
@@ -36,13 +78,11 @@ static int __init hyperv_init(void)
 
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


