Return-Path: <linux-arch+bounces-10872-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F41FA622D8
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 01:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765E717ECBD
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 00:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0283A14;
	Sat, 15 Mar 2025 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Uz81xrgO"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D351846F;
	Sat, 15 Mar 2025 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997977; cv=none; b=BRGth5eQN4U4EiwP3PfOOgzP+PFvLUSIMWy0+AQdbQbc/KlgRNUnJIb4xxxX0FySVTIsDTCQ2wYAyGzdhHavI8Slf3OEZPSfeetuBhSb9l1ZZI11aJfU0YnNgr8ye527MOXoG4n7amwFgiw0ZNuDr6Sk99mh/nw/1FEpBhcPASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997977; c=relaxed/simple;
	bh=JAPVJXwRAdnTfGOW4xEg4L12PyYxnoNmcs7P4kAbqyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRsknfLoXyO/+l9wH4UqMjXRaPu0wwVgSW9z/OTrqUWUxWtqAZUeddSUdJ+2UpFcWdb/u9BnJLNYLNcDuEpKO/jwO+VIRZo4hDvHcV3dpgn6iBQQi1xtYWuIEldxVAP2d4iFEBrUFW5tbvolhoDXK2qJH200oNgU559d0w1qHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Uz81xrgO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 42809203345B;
	Fri, 14 Mar 2025 17:19:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42809203345B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741997973;
	bh=aql5r+qoxxmeaa5n+o0/Ssl6ac0GgBlAhM7f7Q3glr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uz81xrgO/miBAtyqNCUSuH+fm3WMwxzvu4Vc2poacr5p/Ae/6bkQ3EXgmuENFjJJP
	 6jZdGqez7yKNEwKkpS/iEuYOwpAKEQodmdYZP9DDVddGr4fVmnzgbv37xd8KxGMgpe
	 yGL5PcDmxcU6D9PAte4nmAEp8Ms+c05KH1A4erKk=
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
Subject: [PATCH hyperv-next v6 01/11] arm64: kvm, smccc: Introduce and use API for detecting hypervisor presence
Date: Fri, 14 Mar 2025 17:19:21 -0700
Message-ID: <20250315001931.631210-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315001931.631210-1-romank@linux.microsoft.com>
References: <20250315001931.631210-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM/arm64 uses SMCCC to detect hypervisor presence. That code is
private, and it follows the SMCCC specification. Other existing and
emerging hypervisor guest implementations can and should use that
standard approach as well.

Factor out a common infrastructure that the guests can use, update KVM
to employ the new API. The central notion of the SMCCC method is the
UUID of the hypervisor, and the API follows that.

No functional changes. Validated with a KVM/arm64 guest.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kvm/hypercalls.c        |  5 +--
 drivers/firmware/smccc/kvm_guest.c | 10 ++----
 drivers/firmware/smccc/smccc.c     | 19 +++++++++++
 include/linux/arm-smccc.h          | 55 +++++++++++++++++++++++++++---
 4 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 27ce4cb44904..92b9bc1ea8e8 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -353,10 +353,7 @@ int kvm_smccc_call_handler(struct kvm_vcpu *vcpu)
 			val[0] = gpa;
 		break;
 	case ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID:
-		val[0] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0;
-		val[1] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1;
-		val[2] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2;
-		val[3] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3;
+		UUID_TO_SMCCC_RES(ARM_SMCCC_VENDOR_HYP_UID_KVM, val);
 		break;
 	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
 		val[0] = smccc_feat->vendor_hyp_bmap;
diff --git a/drivers/firmware/smccc/kvm_guest.c b/drivers/firmware/smccc/kvm_guest.c
index f3319be20b36..b5084b309ea0 100644
--- a/drivers/firmware/smccc/kvm_guest.c
+++ b/drivers/firmware/smccc/kvm_guest.c
@@ -14,17 +14,11 @@ static DECLARE_BITMAP(__kvm_arm_hyp_services, ARM_SMCCC_KVM_NUM_FUNCS) __ro_afte
 
 void __init kvm_init_hyp_services(void)
 {
+	uuid_t kvm_uuid = ARM_SMCCC_VENDOR_HYP_UID_KVM;
 	struct arm_smccc_res res;
 	u32 val[4];
 
-	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
-		return;
-
-	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
-	if (res.a0 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0 ||
-	    res.a1 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1 ||
-	    res.a2 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2 ||
-	    res.a3 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3)
+	if (!arm_smccc_hyp_present(&kvm_uuid))
 		return;
 
 	memset(&res, 0, sizeof(res));
diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index a74600d9f2d7..7399f27d58e5 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -67,6 +67,25 @@ s32 arm_smccc_get_soc_id_revision(void)
 }
 EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
 
+bool arm_smccc_hyp_present(const uuid_t *hyp_uuid)
+{
+	struct arm_smccc_res res = {};
+
+	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
+		return false;
+	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
+	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
+		return false;
+
+	return ({
+		const uuid_t uuid = SMCCC_RES_TO_UUID(res.a0, res.a1, res.a2, res.a3);
+		const bool present = uuid_equal(&uuid, hyp_uuid);
+
+		present;
+	});
+}
+EXPORT_SYMBOL_GPL(arm_smccc_hyp_present);
+
 static int __init smccc_devices_init(void)
 {
 	struct platform_device *pdev;
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 67f6fdf2e7cd..726f18221f1c 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -7,6 +7,11 @@
 
 #include <linux/args.h>
 #include <linux/init.h>
+
+#ifndef __ASSEMBLER__
+#include <linux/uuid.h>
+#endif
+
 #include <uapi/linux/const.h>
 
 /*
@@ -107,10 +112,10 @@
 			   ARM_SMCCC_FUNC_QUERY_CALL_UID)
 
 /* KVM UID value: 28b46fb6-2ec5-11e9-a9ca-4b564d003a74 */
-#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0	0xb66fb428U
-#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1	0xe911c52eU
-#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2	0x564bcaa9U
-#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3	0x743a004dU
+#define ARM_SMCCC_VENDOR_HYP_UID_KVM UUID_INIT(\
+	0xb66fb428, 0xc52e, 0xe911, \
+	0xa9, 0xca, 0x4b, 0x56, \
+	0x4d, 0x00, 0x3a, 0x74)
 
 /* KVM "vendor specific" services */
 #define ARM_SMCCC_KVM_FUNC_FEATURES		0
@@ -333,6 +338,48 @@ s32 arm_smccc_get_soc_id_version(void);
  */
 s32 arm_smccc_get_soc_id_revision(void);
 
+#ifndef __ASSEMBLER__
+
+/**
+ * arm_smccc_hyp_present(const uuid_t *hyp_uuid)
+ *
+ * Returns `true` if the hypervisor advertises its presence via SMCCC.
+ *
+ * When the function returns `false`, the caller shall not assume that
+ * there is no hypervisor running. Instead, the caller must fall back to
+ * other approaches if any are available.
+ */
+bool arm_smccc_hyp_present(const uuid_t *hyp_uuid);
+
+#define SMCCC_RES_TO_UUID(r0, r1, r2, r3) \
+	UUID_INIT( \
+		cpu_to_le32(lower_32_bits(r0)), \
+		cpu_to_le32(lower_32_bits(r1)) & 0xffff, \
+		cpu_to_le32(lower_32_bits(r1)) >> 16, \
+		cpu_to_le32(lower_32_bits(r2)) & 0xff, \
+		(cpu_to_le32(lower_32_bits(r2)) >> 8) & 0xff, \
+		(cpu_to_le32(lower_32_bits(r2)) >> 16) & 0xff, \
+		(cpu_to_le32(lower_32_bits(r2)) >> 24) & 0xff, \
+		cpu_to_le32(lower_32_bits(r3)) & 0xff, \
+		(cpu_to_le32(lower_32_bits(r3)) >> 8) & 0xff, \
+		(cpu_to_le32(lower_32_bits(r3)) >> 16) & 0xff, \
+		(cpu_to_le32(lower_32_bits(r3)) >> 24) & 0xff \
+	)
+
+#define UUID_TO_SMCCC_RES(uuid_init, regs) do { \
+		const uuid_t uuid = uuid_init; \
+		(regs)[0] = le32_to_cpu((u32)uuid.b[0] | (uuid.b[1] << 8) | \
+						((uuid.b[2]) << 16) | ((uuid.b[3]) << 24)); \
+		(regs)[1] = le32_to_cpu((u32)uuid.b[4] | (uuid.b[5] << 8) | \
+						((uuid.b[6]) << 16) | ((uuid.b[7]) << 24)); \
+		(regs)[2] = le32_to_cpu((u32)uuid.b[8] | (uuid.b[9] << 8) | \
+						((uuid.b[10]) << 16) | ((uuid.b[11]) << 24)); \
+		(regs)[3] = le32_to_cpu((u32)uuid.b[12] | (uuid.b[13] << 8) | \
+						((uuid.b[14]) << 16) | ((uuid.b[15]) << 24)); \
+	} while (0)
+
+#endif /* !__ASSEMBLER__ */
+
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
-- 
2.43.0


