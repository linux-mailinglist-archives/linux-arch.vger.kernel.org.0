Return-Path: <linux-arch+bounces-15075-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CCAC8621A
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 18:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F8D534B6E3
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62745330B0F;
	Tue, 25 Nov 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="pQBOaXdm"
X-Original-To: linux-arch@vger.kernel.org
Received: from sender3-of-o54.zoho.com (sender3-of-o54.zoho.com [136.143.184.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3551132FA26;
	Tue, 25 Nov 2025 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090193; cv=pass; b=uKejbqcO7knSYbzyBpUkLtqlG7fBoVW9Tz616G56cC7SykHQ9r3Q1IP382oo6hPwdGF+gDtutFvukegit1TevEF1op9EaCV7F1Im6OrhvhxdbrYCOBGPiri6jMQMuVae9wRXN2zJSd0W21kkhWSSuP2n0WGJ3WGmo+DyhMhN3RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090193; c=relaxed/simple;
	bh=IruZLbD2a1eLr4esYe0wURG6ywyCHedTjtHHI2IbBFI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXdTKZGeoP8FYgaaKqtp16De/BZJ1YMubBeEs+Km/i5EO1dbdGp5C2f5WEBhkE/+zpl1AGD6Z8OdzcHSZcbE9kvdMMLbsyKC+GzEwYwCmSoPooDExe0XBufaWKE92tKZHZ7iHPA91xayu2wUiR16eACVx7Vy0cVOD0mjqG5uebw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=pQBOaXdm; arc=pass smtp.client-ip=136.143.184.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1764090134; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AAgZQGjboB16/tlOlTY++OsytzK0X+Ld1GUEPDOnKljwFneW3tGDGHX+NmslxWM0iVWTUexbbOXQi8bmNJCeKSHJYTo3FlAUYuWa4YMUvOF2Y4ODJN2trfaY2BS9UxCnSzjynH5M9SyR/SsJUTVXWWLDwbXMybfdqFobNBL0s5M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764090134; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=zRvB6v+MXrdzNewovZSAJ0NRrR/TWvRUYxO9+Eb0rO0=; 
	b=EatH8Y2VNVpiO6Sukb6TcHrapbAfmmgTJNM7PBKnzJb+viT3ixnlA35HBUE7FB3D1q2rPLZ18crKEo6xNAC57bc1h4fq4LiBqoCFjNS3WIOLkV0lErvMhb2a6m6QJ3iix+k4/q+LoleT15Gk9fFPrJz8b3zBcagtL9Sod+z0Swk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764090134;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=zRvB6v+MXrdzNewovZSAJ0NRrR/TWvRUYxO9+Eb0rO0=;
	b=pQBOaXdm0J2xMnLUZUh1Pu5yg4jimJ5y7CcGcBrb4KKstUg4i5s16WEO5lphZGPB
	hTImG560e+CR94vezuUABcsZOYSXxHabjTIBpt8h1Skb0hF6YynEtRFYwUnRPvL/nxN
	S3Z9oQ5bHf8h4xxy3WXdgU3rhv11jj+0uQOzP1jk=
Received: by mx.zohomail.com with SMTPS id 1764090131749161.7619654954118;
	Tue, 25 Nov 2025 09:02:11 -0800 (PST)
From: Anirudh Raybharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	tglx@linutronix.de,
	Arnd Bergmann <arnd@arndb.de>,
	akpm@linux-foundation.org,
	anirudh@anirudhrb.com,
	agordeev@linux.ibm.com,
	guoweikang.kernel@gmail.com,
	osandov@fb.com,
	bsz@amazon.de,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 2/3] irqchip/gic-v3: allocate one SGI for MSHV
Date: Tue, 25 Nov 2025 17:01:23 +0000
Message-Id: <20251125170124.2443340-3-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251125170124.2443340-1-anirudh@anirudhrb.com>
References: <20251125170124.2443340-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Anirudh Rayabharam <anirudh@anirudhrb.com>

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Currently SGIs are allocated only for the smp subsystem. The MSHV
(Microsoft Hypervisor aka Hyper-V) code also needs an SGI that can be
programmed into the SYNIC to receive intercepts from the hypervisor. The
hypervisor would then assert this SGI whenever there is a guest
VMEXIT.

Allocate one SGI for MSHV use in addition to the SGIs allocated for
IPIs. When running under MSHV, the full SGI range can be used i.e. no
need to reserve SGIs 8-15 for the secure firmware.

Since this SGI is needed only when running as a parent partition (i.e.
we can create guest partitions), check for it before allocating an SGI.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 arch/arm64/hyperv/mshyperv.c      | 13 +++++++++++++
 arch/arm64/include/asm/mshyperv.h |  8 ++++++++
 drivers/irqchip/irq-gic-v3.c      | 29 ++++++++++++++++++++++++++---
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index cc443a5d6c71..99690ae9b53f 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -20,6 +20,8 @@
 static bool hyperv_detected;
 static bool hyperv_initialized;
 
+static int mshv_intercept_irq;
+
 int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 {
 	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
@@ -137,6 +139,17 @@ static int __init hyperv_init(void)
 	return 0;
 }
 
+void __init mshv_set_intercept_irq(int irq)
+{
+	mshv_intercept_irq = irq;
+}
+
+int mshv_get_intercept_irq(void)
+{
+	return mshv_intercept_irq;
+}
+EXPORT_SYMBOL_GPL(mshv_get_intercept_irq);
+
 early_initcall(hyperv_init);
 
 bool hv_is_hyperv_initialized(void)
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 58fde70c2e39..f3f6e82a9cb6 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -55,6 +55,14 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
 
 void hyperv_early_init(void);
 
+#if IS_ENABLED(CONFIG_MSHV_ROOT)
+void mshv_set_intercept_irq(int irq);
+#else
+static inline void mshv_set_intercept_irq(int irq) {}
+#endif
+
+int mshv_get_intercept_irq(void);
+
 /* SMCCC hypercall parameters */
 #define HV_SMCCC_FUNC_NUMBER	1
 #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 3de351e66ee8..56013dd0564c 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -35,6 +35,7 @@
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
 #include <asm/virt.h>
+#include <asm/mshyperv.h>
 
 #include "irq-gic-common.h"
 
@@ -1456,8 +1457,24 @@ static void __init gic_smp_init(void)
 		.fwnode		= gic_data.fwnode,
 		.param_count	= 1,
 	};
+	/* Register all 8 non-secure SGIs */
+	const int NR_SMP_SGIS = 8;
+	int nr_sgis = NR_SMP_SGIS;
 	int base_sgi;
 
+	/*
+	 * Allocate one more SGI for use by Hyper-V. This is only needed when
+	 * Linux is running in a parent partition. Hyper-V will use this interrupt
+	 * to notify the parent partition of intercepts.
+	 *
+	 * When running on Hyper-V, it is okay to use SGIs 8-15. They're not reserved
+	 * for secure firmware.
+	 */
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (hv_parent_partition())
+		nr_sgis += 1;
+#endif
+
 	cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
 				  "irqchip/arm/gicv3:checkrdist",
 				  gic_check_rdist, NULL);
@@ -1466,12 +1483,18 @@ static void __init gic_smp_init(void)
 				  "irqchip/arm/gicv3:starting",
 				  gic_starting_cpu, NULL);
 
-	/* Register all 8 non-secure SGIs */
-	base_sgi = irq_domain_alloc_irqs(gic_data.domain, 8, NUMA_NO_NODE, &sgi_fwspec);
+	base_sgi = irq_domain_alloc_irqs(gic_data.domain, nr_sgis, NUMA_NO_NODE, &sgi_fwspec);
 	if (WARN_ON(base_sgi <= 0))
 		return;
 
-	set_smp_ipi_range(base_sgi, 8);
+	set_smp_ipi_range(base_sgi, NR_SMP_SGIS);
+
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (hv_parent_partition()) {
+		base_sgi += NR_SMP_SGIS;
+		mshv_set_intercept_irq(base_sgi);
+	}
+#endif
 }
 
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
-- 
2.34.1


