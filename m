Return-Path: <linux-arch+bounces-13902-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F05BBBB845C
	for <lists+linux-arch@lfdr.de>; Sat, 04 Oct 2025 00:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C69BB4E2AB9
	for <lists+linux-arch@lfdr.de>; Fri,  3 Oct 2025 22:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAE7277C9A;
	Fri,  3 Oct 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CY/y5MZT"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76377269B0D;
	Fri,  3 Oct 2025 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530443; cv=none; b=JQ6/+gEHlaWVYWKAPW7eOKY6JyneCNseY+JqzVSAmc5oHADrCrQK70B7up+LnqRdesVOgckmaC05yO9RLxUX616qJNuh/lO6CLKiPZpiNtAwRRBMxN1TzsBE4v9x9bYsir9EXvXl35uGTiXtsWMzieYqyzFVkioC5+YUcsUnWLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530443; c=relaxed/simple;
	bh=xVElnd3V/ymyu1N/Rt/2oKiDXH68oMwhNyFjCVAIZzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5dBk7lfBfbt4omRsZg0B/35UVe1nPYXttY00/fwErMaqoDLuIxdEwfUHKDuF6e33RYCTOArH/MFTuyRyqP5MMjMbcY0F0mS2jfEqufImAHSP7eFU8gFar6EMLm8Crnfz8myp+jOqBB2HDu8nwQhLZtjZRyFo8YUXmZ1yzreDRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CY/y5MZT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E4A16211C273;
	Fri,  3 Oct 2025 15:27:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4A16211C273
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759530435;
	bh=j5zGyiGsUlHWBg6rMNx71IR0uGVAcVwN+RhBfbUB3DQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CY/y5MZT6OPj8KsdoHwtiBbyiH02pLvsxAJ6xoYibVM3QJkOGvs+o6dXqHDiqCU6I
	 BQqqrSxBrB35VTgh2It3N4+l4jMVfszDnvmeBm7RFpMMIbM8GH2Bpm+n2LrzTCPS3V
	 qkvYrI6KGPD4lRFHwFFV3nJPhBZOpIbYlY4kIJPA=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mikelley@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com,
	romank@linux.microsoft.com
Subject: [PATCH hyperv-next v6 03/17] arch/x86: mshyperv: Discover Confidential VMBus availability
Date: Fri,  3 Oct 2025 15:26:56 -0700
Message-ID: <20251003222710.6257-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003222710.6257-1-romank@linux.microsoft.com>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Confidential VMBus requires enabling paravisor SynIC, and
the x86_64 guest has to inspect the Virtualization Stack (VS)
CPUID leaf to see if Confidential VMBus is available. If it is,
the guest shall enable the paravisor SynIC.

Read the relevant data from the VS CPUID leaf. Refactor the
code to avoid repeating CPUID and add flags to the struct
ms_hyperv_info. For ARM64, the flag for Confidential VMBus
is not set which provides the desired behaviour for now as
it is not available on ARM64 just yet. Once ARM64 CCA guests
are supported, this flag will be set unconditionally when
running such a guest.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 28 +++++++++++++++-------------
 include/asm-generic/mshyperv.h |  2 ++
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 25773af116bc..57163c7a000f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -434,7 +434,7 @@ EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
 
 static void __init ms_hyperv_init_platform(void)
 {
-	int hv_max_functions_eax;
+	int hv_max_functions_eax, eax;
 
 #ifdef CONFIG_PARAVIRT
 	pv_info.name = "Hyper-V";
@@ -469,6 +469,19 @@ static void __init ms_hyperv_init_platform(void)
 		pr_info("Hyper-V: running on a nested hypervisor\n");
 	}
 
+	/*
+	 * There is no check against the max function for HYPERV_CPUID_VIRT_STACK_* CPUID
+	 * leaves as the hypervisor doesn't handle them. Even a nested root partition (L2
+	 * root) will not get them because the nested (L1) hypervisor filters them out.
+	 * These are handled through intercept processing by the Windows Hyper-V stack
+	 * or the paravisor.
+	 */
+	eax = cpuid_eax(HYPERV_CPUID_VIRT_STACK_PROPERTIES);
+	ms_hyperv.confidential_vmbus_available =
+		eax & HYPERV_VS_PROPERTIES_EAX_CONFIDENTIAL_VMBUS_AVAILABLE;
+	ms_hyperv.msi_ext_dest_id =
+		eax & HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE;
+
 	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_platform.calibrate_tsc = hv_get_tsc_khz;
@@ -668,21 +681,10 @@ static bool __init ms_hyperv_x2apic_available(void)
  * pci-hyperv host bridge.
  *
  * Note: for a Hyper-V root partition, this will always return false.
- * The hypervisor doesn't expose these HYPERV_CPUID_VIRT_STACK_* cpuids by
- * default, they are implemented as intercepts by the Windows Hyper-V stack.
- * Even a nested root partition (L2 root) will not get them because the
- * nested (L1) hypervisor filters them out.
  */
 static bool __init ms_hyperv_msi_ext_dest_id(void)
 {
-	u32 eax;
-
-	eax = cpuid_eax(HYPERV_CPUID_VIRT_STACK_INTERFACE);
-	if (eax != HYPERV_VS_INTERFACE_EAX_SIGNATURE)
-		return false;
-
-	eax = cpuid_eax(HYPERV_CPUID_VIRT_STACK_PROPERTIES);
-	return eax & HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE;
+	return ms_hyperv.msi_ext_dest_id;
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 64ba6bc807d9..9049a9617324 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -62,6 +62,8 @@ struct ms_hyperv_info {
 		};
 	};
 	u64 shared_gpa_boundary;
+	bool msi_ext_dest_id;
+	bool confidential_vmbus_available;
 };
 extern struct ms_hyperv_info ms_hyperv;
 extern bool hv_nested;
-- 
2.43.0


