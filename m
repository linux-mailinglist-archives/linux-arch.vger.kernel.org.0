Return-Path: <linux-arch+bounces-5650-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C062393DAF8
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 00:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3F31F23D97
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 22:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302DA154C10;
	Fri, 26 Jul 2024 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HrFS4gQA"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1DC14EC5D;
	Fri, 26 Jul 2024 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034771; cv=none; b=KCTETsts28xHshTZL8XD7FkH5xUNuZr/sVIZxcrZnU1ruxt/5P1ck4xxy/ekBCu3I+qNpRL5i7JPr2L+6v2AnT3mWDYx9X3kPLfQ1U17UmQjhx/Xd7x15tXfqNtU4QnGJkE29AcxT1BmRuVL+KlofZiDcB0cAfBs3qPgCGfnX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034771; c=relaxed/simple;
	bh=rJcS3Jq98v2NWlttjuSO/XP10kOr038BA/9t0EitINY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjlTfOdwnUNdbmrZGj1bk5eF7nVtZm2lAAyrCjnH5z9K7Y0tNiD1jOvHPvaIOFCt93DRcZAsMauo8Op/25RRxVpw6E6MiNqNr8EzHL8h20MlTOVG+rLWV26MnO2cDSxwsXuOh42dOzjymlJzeMYhtRWHGAWIyRCm3vDDLDRzATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HrFS4gQA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2BD6420B712C;
	Fri, 26 Jul 2024 15:59:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BD6420B712C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722034769;
	bh=tmxjj8vso9v/ojCxB2Cygc/rP9hc2qP1BIOw38tT1zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrFS4gQA63f9ZtXluPQS6xKLvJ9iGcheKqe8qXFGmxALOaJxtC3mt7lByp/kfPsWG
	 CorAVbwGjB2BghmnQvGHqY48CpEoYMi2x1oIf9LwIn3qH8lFQpxWB1QsjcsCDHwm89
	 wjRy4XLGbPrRbKVDtla62/DUxosA9UgmY8vwKAxE=
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
Subject: [PATCH v3 4/7] arm64: hyperv: Boot in a Virtual Trust Level
Date: Fri, 26 Jul 2024 15:59:07 -0700
Message-Id: <20240726225910.1912537-5-romank@linux.microsoft.com>
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

To run in the VTL mode, Hyper-V drivers have to know what
VTL the system boots in, and the arm64/hyperv code does not
update the variable that stores the value.

Update the variable to enable the Hyper-V drivers to boot
in the VTL mode and print the VTL the code runs in.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/arm64/hyperv/Makefile        |  1 +
 arch/arm64/hyperv/hv_vtl.c        | 13 +++++++++++++
 arch/arm64/hyperv/mshyperv.c      |  4 ++++
 arch/arm64/include/asm/mshyperv.h |  7 +++++++
 4 files changed, 25 insertions(+)
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
index 000000000000..38642b7b6be0
--- /dev/null
+++ b/arch/arm64/hyperv/hv_vtl.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Microsoft, Inc.
+ *
+ * Author : Roman Kisel <romank@linux.microsoft.com>
+ */
+
+#include <asm/mshyperv.h>
+
+void __init hv_vtl_init_platform(void)
+{
+	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
+}
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 341f98312667..8fd04d6e4800 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -98,6 +98,10 @@ static int __init hyperv_init(void)
 		return ret;
 	}
 
+	/* Find the VTL */
+	ms_hyperv.vtl = get_vtl();
+	hv_vtl_init_platform();
+
 	ms_hyperv_late_init();
 
 	hyperv_initialized = true;
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index a7a3586f7cb1..63d6bb6998fc 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -49,6 +49,13 @@ static inline u64 hv_get_msr(unsigned int reg)
 				ARM_SMCCC_OWNER_VENDOR_HYP,	\
 				HV_SMCCC_FUNC_NUMBER)
 
+#ifdef CONFIG_HYPERV_VTL_MODE
+void __init hv_vtl_init_platform(void);
+int __init hv_vtl_early_init(void);
+#else
+static inline void __init hv_vtl_init_platform(void) {}
+#endif
+
 #include <asm-generic/mshyperv.h>
 
 #define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x7948734d
-- 
2.34.1


