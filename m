Return-Path: <linux-arch+bounces-15074-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C22DC86208
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8127B354D5E
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 17:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5532E6AA;
	Tue, 25 Nov 2025 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="nIgDYdj2"
X-Original-To: linux-arch@vger.kernel.org
Received: from sender3-of-o54.zoho.com (sender3-of-o54.zoho.com [136.143.184.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C623332AAAB;
	Tue, 25 Nov 2025 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090168; cv=pass; b=kuaOskiLel31zKAVD/q7vHfn+0WdwTLrnqFkQaXovLeoMOdsW/SPvekQTy6MMuluGHZcpLBbhKeEpx5me9B/TdNCrvLB9Dwwkbb3KO/4imvI5ypCtp3k6gbnhjJMzL8AGJyjHZPW8xtMna5Jfwn5AMK7AvUKV4vy7qhKfkq2qqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090168; c=relaxed/simple;
	bh=JT6UrMRRjuuWYMKEE431PAKBecqbiT6bSH6fs9ZXwuQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=adwVkJQCrAIQ5JNynXVAu8MlM7VFcLHIDzdUrsof2MGbhFIzCcxL/ri1rbKeScLjtUX9Sr5weG31gIv3LB2hmY2Ay1l79xRPyxX62MXjNjX6jIl82hQosRpPAO53uMfe8TppE1t9lzNoxb47fIVGSu/mLLPP+BdnKW91YLXWoM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=nIgDYdj2; arc=pass smtp.client-ip=136.143.184.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1764090117; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=brjEjmCljmQHQjaqGseBvjhrAdmgYR0JW+VWIzmFbj7ej9Lf6SMJcRNgVpDgcrjy6T7Ogo2aLhMZjYa5dEFXnoIBcu/owVMBnErOwHEls6icrs7xfTiaPGAjLc3AN0i58LmJPchtmywZQWPkDNRp3OW/87uZFIZlO+Mu+00U09s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764090117; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=HBwSR2rtuqv+NAM5OYtNOv2Wezl+99eQ+pwqmjOxO1Y=; 
	b=icX1bJa2yU+XpJtDhzLGB9mSD63PZR2xKz6iNFsyC2TqhcA0G8z0ZhAaoolJ3biccOZLtw05D1ql6vHy3+DU4+Mgv23REDDdn/URRhJaOHB4IEd6fqxuLDyiaieq5MhBUoe2kq3JBFmCgyOa/i+CSkHP+gmvZqUfb7BjNl1RZ94=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764090117;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=HBwSR2rtuqv+NAM5OYtNOv2Wezl+99eQ+pwqmjOxO1Y=;
	b=nIgDYdj2N3/IpkoVx5vS+TtkYsQ2tgL3dUgTBKumVVJODLT5POaOriBZTHwBNdXL
	6w5qpDplWJdzjWhrMKnvKEBAi6SGJx0vekehb0bYgMKBMMLmH5MU1uBWwj1bBomJBvI
	ihlO8J4EMFDaUW2BQYh9GnQXoV0wSOlOpVKda47U=
Received: by mx.zohomail.com with SMTPS id 1764090116327797.2261256804017;
	Tue, 25 Nov 2025 09:01:56 -0800 (PST)
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
Subject: [PATCH 1/3] arm64: hyperv: move hyperv detection earlier in boot
Date: Tue, 25 Nov 2025 17:01:22 +0000
Message-Id: <20251125170124.2443340-2-anirudh@anirudhrb.com>
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

Move hyperv detection earlier in the boot. The goal is to detect hyperv
and the type of partition we're running in before the GICv3 setup.

This will be used in the subsequent patches to allocate an SGI for use
by the hyperv subsystem.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 arch/arm64/hyperv/mshyperv.c      | 18 ++++++++++++++----
 arch/arm64/include/asm/mshyperv.h |  2 ++
 arch/arm64/kernel/setup.c         |  6 ++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 4fdc26ade1d7..cc443a5d6c71 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -17,6 +17,7 @@
 #include <linux/cpuhotplug.h>
 #include <asm/mshyperv.h>
 
+static bool hyperv_detected;
 static bool hyperv_initialized;
 
 int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
@@ -70,20 +71,21 @@ static bool __init hyperv_detect_via_smccc(void)
 	return arm_smccc_hypervisor_has_uuid(&hyperv_uuid);
 }
 
-static int __init hyperv_init(void)
+void __init hyperv_early_init(void)
 {
 	struct hv_get_vp_registers_output	result;
 	u64	guest_id;
-	int	ret;
 
 	/*
 	 * Allow for a kernel built with CONFIG_HYPERV to be running in
 	 * a non-Hyper-V environment.
 	 *
-	 * In such cases, do nothing and return success.
+	 * In such cases, do nothing and return.
 	 */
 	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
-		return 0;
+		return;
+
+	hyperv_detected = true;
 
 	/* Setup the guest ID */
 	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
@@ -103,6 +105,14 @@ static int __init hyperv_init(void)
 		ms_hyperv.misc_features);
 
 	hv_identify_partition_type();
+}
+
+static int __init hyperv_init(void)
+{
+	int	ret;
+
+	if (!hyperv_detected)
+		return 0;
 
 	ret = hv_common_init();
 	if (ret)
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index b721d3134ab6..58fde70c2e39 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -53,6 +53,8 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
 	return hv_get_msr(reg);
 }
 
+void hyperv_early_init(void);
+
 /* SMCCC hypercall parameters */
 #define HV_SMCCC_FUNC_NUMBER	1
 #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 23c05dc7a8f2..eccf5f19da6b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -54,6 +54,7 @@
 #include <asm/efi.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/mmu_context.h>
+#include <asm/mshyperv.h>
 
 static int num_standard_resources;
 static struct resource *standard_resources;
@@ -354,6 +355,11 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	else
 		psci_acpi_init();
 
+	/*
+	 * This must come after psci init since Hyper-V detection uses SMCCC
+	 */
+	hyperv_early_init();
+
 	arm64_rsi_init();
 
 	init_bootcpu_ops();
-- 
2.34.1


