Return-Path: <linux-arch+bounces-4407-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89D8C5DC9
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 00:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB1A1C20F40
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 22:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB501836F7;
	Tue, 14 May 2024 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kkK+sB9O"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B93D181D08;
	Tue, 14 May 2024 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726730; cv=none; b=Ico4/m1RTYbgJMjvrlRG7q2Zp8gG+RGFqzoKC+D9GUHKlZnmuY4LRHPBU1pOAVmzHq95Limu26i+cv2Ayi2zvvoX6wub7ZneFP+Vc/tOpDBIEDUBXBkXn9iXgx7ngbhtJKH24+NkblC+IEc/WgPz5FR4CPaBEx/TXIQS3BUpkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726730; c=relaxed/simple;
	bh=LxzjesEa2yrOp7NiBZaeavpLyG8UmGpbdareqGavSSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAHtQP4VRfigbWOysbdqf+CIS3i1J64P7uWuoCzsZ3AbDjJ2aAmBBrdY4R8MQtpm6zGTJRos7XjpFe1StYgorWV0QXxz/IUvhig0ZBFxt44Av5CNISZNbqu+7CAsrtMQZZVL5Ni05bU0SlbY4QKuCcVL3McbKyDbvgaRNDZrCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kkK+sB9O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id CEA242095D0B;
	Tue, 14 May 2024 15:45:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CEA242095D0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715726721;
	bh=gy5I6n1XdVqSkd/zdu3TEf1Kw11JgiudWXaTRTptXPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kkK+sB9Ob6YQYJHnZe+I7bfizHzznTUhZEzNZYosbYY9NSZiLEGrYc+XgvtsCC65p
	 ZeXmurF1PgbwOg9frqVYVBYJNQXp8OPnu+2+qge5d/vDvBkEW9yj3wY/CduAq4tscq
	 5f2yr0cYzCE254biGL/prCEZ2KvXAIOrOSNILTf4=
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
Subject: [PATCH v2 1/6] arm64/hyperv: Support DeviceTree
Date: Tue, 14 May 2024 15:43:48 -0700
Message-ID: <20240514224508.212318-2-romank@linux.microsoft.com>
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

The Virtual Trust Level platforms rely on DeviceTree, and the
arm64/hyperv code supports ACPI only. Update the logic to
support DeviceTree on boot as well as ACPI.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index b1a4de4eee29..208a3bcb9686 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -15,6 +15,9 @@
 #include <linux/errno.h>
 #include <linux/version.h>
 #include <linux/cpuhotplug.h>
+#include <linux/libfdt.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
 #include <asm/mshyperv.h>
 
 static bool hyperv_initialized;
@@ -27,6 +30,29 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 	return 0;
 }
 
+static bool hyperv_detect_fdt(void)
+{
+#ifdef CONFIG_OF
+	const unsigned long hyp_node = of_get_flat_dt_subnode_by_name(
+			of_get_flat_dt_root(), "hypervisor");
+
+	return (hyp_node != -FDT_ERR_NOTFOUND) &&
+			of_flat_dt_is_compatible(hyp_node, "microsoft,hyperv");
+#else
+	return false;
+#endif
+}
+
+static bool hyperv_detect_acpi(void)
+{
+#ifdef CONFIG_ACPI
+	return !acpi_disabled &&
+			!strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8);
+#else
+	return false;
+#endif
+}
+
 static int __init hyperv_init(void)
 {
 	struct hv_get_vp_registers_output	result;
@@ -35,13 +61,11 @@ static int __init hyperv_init(void)
 
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
+	if (!hyperv_detect_fdt() && !hyperv_detect_acpi())
 		return 0;
 
 	/* Setup the guest ID */
-- 
2.45.0


