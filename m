Return-Path: <linux-arch+bounces-11669-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D28BA9FBA0
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 23:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38AF07AFCCB
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 21:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BF520C00C;
	Mon, 28 Apr 2025 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UfH3SmNt"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E708E1F3BA9;
	Mon, 28 Apr 2025 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745874466; cv=none; b=eu20hqDLug/447R/nuepzfQ/7598N29IVPbTei9f3pFV27kba3ZX3F8bzMecKB59qhgxP+WOBlqveZGAgopWRrjmpootvrjIivIMfkmAXSB1yrLrtYs/DejyNPPd0wkpGIMU0P4fZOePXmMFdH24dnfZVJ/PnNIsYVOaRCVB7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745874466; c=relaxed/simple;
	bh=8b1j4GyUqPu96FKtad2xZJrEuwU+g5/eYVLx8InT7K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqeNCVnI1ZnMRQUtd5yFAEG+6lsK56Un8VKmJwmx/de778Ld1pkuGs6ySkW2iBxDFCSh7viVLqskk+Mdn6AYjaciKmQb6ROF8lBunTPV9KxASW/rnIfk4P3jUHdDkTeStxqv932TBUiHRRkcoJvNR1FSVkG7B7BYDyWeYFZJmHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UfH3SmNt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 43291211AD1D;
	Mon, 28 Apr 2025 14:07:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43291211AD1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745874464;
	bh=+mIShGqCb4KmaZyQ3UOkWoGFmZpX84YmamhC0BZ3g/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfH3SmNtDSoX65xGXoHGpQc0ENxrD62FYVCBNJwnEVdcjqxdMrLUispHP90q0RC0P
	 wxpFr7hgfVgO2u0Vla2yNzJ5Qf+DY2MoUNmOxpV7W+Qst1k3KVTi3cKvX8PbTCbimJ
	 6qYSXfOZE5ApffVsaEpSKiKEpD0tELIx7hMQeXEk=
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
	linux-hyperv@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v9 01/11] arm64: kvm, smccc: Introduce and use API for getting hypervisor UUID
Date: Mon, 28 Apr 2025 14:07:32 -0700
Message-ID: <20250428210742.435282-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428210742.435282-1-romank@linux.microsoft.com>
References: <20250428210742.435282-1-romank@linux.microsoft.com>
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
UUID of the hypervisor, and the new API follows that.

No functional changes. Validated with a KVM/arm64 guest.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/arm64/kvm/hypercalls.c        | 10 +++--
 drivers/firmware/smccc/kvm_guest.c | 10 +----
 drivers/firmware/smccc/smccc.c     | 17 ++++++++
 include/linux/arm-smccc.h          | 64 ++++++++++++++++++++++++++++--
 4 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 27ce4cb44904..e641cb2b47d7 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -268,6 +268,7 @@ int kvm_smccc_call_handler(struct kvm_vcpu *vcpu)
 	u32 feature;
 	u8 action;
 	gpa_t gpa;
+	uuid_t uuid;
 
 	action = kvm_smccc_get_action(vcpu, func_id);
 	switch (action) {
@@ -353,10 +354,11 @@ int kvm_smccc_call_handler(struct kvm_vcpu *vcpu)
 			val[0] = gpa;
 		break;
 	case ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID:
-		val[0] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0;
-		val[1] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1;
-		val[2] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2;
-		val[3] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3;
+		uuid = ARM_SMCCC_VENDOR_HYP_UID_KVM;
+		val[0] = smccc_uuid_to_reg(&uuid, 0);
+		val[1] = smccc_uuid_to_reg(&uuid, 1);
+		val[2] = smccc_uuid_to_reg(&uuid, 2);
+		val[3] = smccc_uuid_to_reg(&uuid, 3);
 		break;
 	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
 		val[0] = smccc_feat->vendor_hyp_bmap;
diff --git a/drivers/firmware/smccc/kvm_guest.c b/drivers/firmware/smccc/kvm_guest.c
index f3319be20b36..87f910887d61 100644
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
+	if (!arm_smccc_hypervisor_has_uuid(&kvm_uuid))
 		return;
 
 	memset(&res, 0, sizeof(res));
diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index a74600d9f2d7..cd65b434dc6e 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -67,6 +67,23 @@ s32 arm_smccc_get_soc_id_revision(void)
 }
 EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
 
+bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
+{
+	struct arm_smccc_res res = {};
+	uuid_t uuid;
+
+	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
+		return false;
+
+	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
+	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
+		return false;
+
+	uuid = smccc_res_to_uuid(res.a0, res.a1, res.a2, res.a3);
+	return uuid_equal(&uuid, hyp_uuid);
+}
+EXPORT_SYMBOL_GPL(arm_smccc_hypervisor_has_uuid);
+
 static int __init smccc_devices_init(void)
 {
 	struct platform_device *pdev;
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 67f6fdf2e7cd..d01fa54103a1 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -7,6 +7,11 @@
 
 #include <linux/args.h>
 #include <linux/init.h>
+
+#ifndef __ASSEMBLY__
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
@@ -333,6 +338,57 @@ s32 arm_smccc_get_soc_id_version(void);
  */
 s32 arm_smccc_get_soc_id_revision(void);
 
+#ifndef __ASSEMBLY__
+
+/*
+ * Returns whether a specific hypervisor UUID is advertised for the
+ * Vendor Specific Hypervisor Service range.
+ */
+bool arm_smccc_hypervisor_has_uuid(const uuid_t *uuid);
+
+static inline uuid_t smccc_res_to_uuid(u32 r0, u32 r1, u32 r2, u32 r3)
+{
+	uuid_t uuid = {
+		.b = {
+			[0]  = (r0 >> 0)  & 0xff,
+			[1]  = (r0 >> 8)  & 0xff,
+			[2]  = (r0 >> 16) & 0xff,
+			[3]  = (r0 >> 24) & 0xff,
+
+			[4]  = (r1 >> 0)  & 0xff,
+			[5]  = (r1 >> 8)  & 0xff,
+			[6]  = (r1 >> 16) & 0xff,
+			[7]  = (r1 >> 24) & 0xff,
+
+			[8]  = (r2 >> 0)  & 0xff,
+			[9]  = (r2 >> 8)  & 0xff,
+			[10] = (r2 >> 16) & 0xff,
+			[11] = (r2 >> 24) & 0xff,
+
+			[12] = (r3 >> 0)  & 0xff,
+			[13] = (r3 >> 8)  & 0xff,
+			[14] = (r3 >> 16) & 0xff,
+			[15] = (r3 >> 24) & 0xff,
+		},
+	};
+
+	return uuid;
+}
+
+static inline u32 smccc_uuid_to_reg(const uuid_t *uuid, int reg)
+{
+	u32 val = 0;
+
+	val |= (u32)(uuid->b[4 * reg + 0] << 0);
+	val |= (u32)(uuid->b[4 * reg + 1] << 8);
+	val |= (u32)(uuid->b[4 * reg + 2] << 16);
+	val |= (u32)(uuid->b[4 * reg + 3] << 24);
+
+	return val;
+}
+
+#endif /* !__ASSEMBLY__ */
+
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
-- 
2.43.0


