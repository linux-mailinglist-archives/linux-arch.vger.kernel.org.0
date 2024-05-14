Return-Path: <linux-arch+bounces-4405-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F908C5DC0
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 00:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF501F22168
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 22:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB801836D3;
	Tue, 14 May 2024 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SwOwHpg8"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D181182C84;
	Tue, 14 May 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726729; cv=none; b=LaDQzMHw712vGXMPv3GkleZMeyXjyE4SH/w1kC2JWz4sQwwxuHPsdsXOUu9iDRBikZV+pHsAKCYhE9c/zsg0KJrOYrAKKimxEewkC01twQ4faxiABiFLDfZkNYYWQNCXPpY5cKefz1PHwIm6CDGXatkmXXktRWnOwuiGrbSMdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726729; c=relaxed/simple;
	bh=m1EKDirdZpUbxvw3NHD2qWkIJ2cXErTIJKMOLmmOMzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptBPHM5fcJbpYYYdLTvLNrMFG7qK8CnkP22OvpiTYD9sPYyu8kq+RrClA4uMK6TpJ/a1TJCtYbOxR8CTg/BQA1l3V+UtiHK1ah7ci1Ix1LYPEqJ9gzCEWXM3Gg50ey557w99Xsvjj2oaxM1DKZvdV2raeT7EFFLrxlomRBxgwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SwOwHpg8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id BA19E2095D0E;
	Tue, 14 May 2024 15:45:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA19E2095D0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715726721;
	bh=d0mCVW38qQkjcmLn2COs13T+MEUBOqchbANwckpZQ8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwOwHpg8b4yjKsK8r6039KVFLe3cfIcdai0uztt+5O2dRSN62hNU0D8MgYgRr8eqY
	 0ukf2TL8bjBWnJlPjwUXhIEWIA0SrXN02lWSUWkIEWkqTrKpQv1X+aHjTbxtXtLSe7
	 91OvV72T6CiRm9XOOTWXMe6ChBi+2Cv61MUXpT6c=
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
	mhklinux@outlook.com,
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
Cc: ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v2 4/6] arm64/hyperv: Boot in a Virtual Trust Level
Date: Tue, 14 May 2024 15:43:51 -0700
Message-ID: <20240514224508.212318-5-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514224508.212318-1-romank@linux.microsoft.com>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To run in the VTL mode, Hyper-V drivers have to know what
VTL the system boots in, and the arm64/hyperv code does not
update the variable that stores the value.

Update the variable to enable the Hyper-V drivers to boot
in the VTL mode and print the VTL the code runs in.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/arm64/hyperv/Makefile        |  1 +
 arch/arm64/hyperv/hv_vtl.c        | 19 +++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c      |  6 ++++++
 arch/arm64/include/asm/mshyperv.h |  8 ++++++++
 arch/x86/hyperv/hv_vtl.c          |  2 +-
 5 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/hv_vtl.c

diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
index 87c31c001da9..9701a837a6e1 100644
--- a/arch/arm64/hyperv/Makefile
+++ b/arch/arm64/hyperv/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y		:= hv_core.o mshyperv.o
+obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
new file mode 100644
index 000000000000..9b44cc49594c
--- /dev/null
+++ b/arch/arm64/hyperv/hv_vtl.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023, Microsoft, Inc.
+ *
+ * Author : Roman Kisel <romank@linux.microsoft.com>
+ */
+
+#include <asm/mshyperv.h>
+
+void __init hv_vtl_init_platform(void)
+{
+	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
+}
+
+int __init hv_vtl_early_init(void)
+{
+	return 0;
+}
+early_initcall(hv_vtl_early_init);
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 208a3bcb9686..cbde483b167a 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -96,6 +96,12 @@ static int __init hyperv_init(void)
 		return ret;
 	}
 
+	/* Find the VTL */
+	ms_hyperv.vtl = get_vtl();
+	if (ms_hyperv.vtl > 0) /* non default VTL */
+		hv_vtl_early_init();
+
+	hv_vtl_init_platform();
 	ms_hyperv_late_init();
 
 	hyperv_initialized = true;
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index a975e1a689dd..4a8ff6be389c 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -49,6 +49,14 @@ static inline u64 hv_get_msr(unsigned int reg)
 				ARM_SMCCC_OWNER_VENDOR_HYP,	\
 				HV_SMCCC_FUNC_NUMBER)
 
+#ifdef CONFIG_HYPERV_VTL_MODE
+void __init hv_vtl_init_platform(void);
+int __init hv_vtl_early_init(void);
+#else
+static inline void __init hv_vtl_init_platform(void) {}
+static inline int __init hv_vtl_early_init(void) { return 0; }
+#endif
+
 #include <asm-generic/mshyperv.h>
 
 #endif
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 92bd5a55f093..ae3105375a12 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -19,7 +19,7 @@ static struct real_mode_header hv_vtl_real_mode_header;
 
 void __init hv_vtl_init_platform(void)
 {
-	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
+	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
 
 	x86_platform.realmode_reserve = x86_init_noop;
 	x86_platform.realmode_init = x86_init_noop;
-- 
2.45.0


