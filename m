Return-Path: <linux-arch+bounces-10578-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88E9A5745C
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 23:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8C716DFA0
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 22:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA00259C83;
	Fri,  7 Mar 2025 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a7kCOSpt"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA991FFC44;
	Fri,  7 Mar 2025 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384988; cv=none; b=iy3Q/vYYtb+qiz68HWEwsC88xAoZSPtpbAb4FP2TyZS+G4tqnSLvh/Bbilei5doAPu8xw4tDuWAt5fxWDTFo1eMIV9bUv2Rr6Izyx5qNgYcsV8PbyahfkKBPL63sG3C5fyr7KOqRtdqvdk0xI5QedYwVKDr1RBV8geFhckaHPcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384988; c=relaxed/simple;
	bh=Dy4q8sx6By2sWdcQEJovDtHh2Z+NA9yy6Du4RqtUgcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M30dKc+xvAc+7UfwvBJB6z93D0+YBMlBcaa2Wgg46Ao3ubjm1n57DOw3Q4mS/xv+4qXcQvMMiWJw3hfOTPASDA+dSI94F5I/PVZjx/xeoSWpXWmYDAdfo7EuteKxrvhtLKzhNNcBnECL3PjmTg+0d+QVWXUpQ0n0dRrgGHzsbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a7kCOSpt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9CBAB2038F43;
	Fri,  7 Mar 2025 14:03:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CBAB2038F43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741384986;
	bh=LpTpRt4zyFlRJYD8tPLZbpAYbMwzKTWzeKLZA5iBaMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7kCOSptSaA3b1ke3hYkm1YaReZW6KqfsuH8JemiqDUPwWDR8tIBFOuUslpthcXvR
	 mgplFjyvk4oTCp95w+o/GwAaaR4hEGRpKv4x96tjymfJsSAhw0ANPfMCvl/WVvtpJn
	 4ZRMgYfTn2fRDyXs5ycChpFhL1poolLT7jbZMoMc=
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
Subject: [PATCH hyperv-next v5 03/11] Drivers: hv: Enable VTL mode for arm64
Date: Fri,  7 Mar 2025 14:02:55 -0800
Message-ID: <20250307220304.247725-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307220304.247725-1-romank@linux.microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Kconfig dependencies for arm64 guests on Hyper-V require that be
ACPI enabled, and limit VTL mode to x86/x64. To enable VTL mode
on arm64 as well, update the dependencies. Since VTL mode requires
DeviceTree instead of ACPI, don’t require arm64 guests on Hyper-V
to have ACPI unconditionally.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 862c47b191af..c37b1a44e580 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -5,18 +5,20 @@ menu "Microsoft Hyper-V guest support"
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
 	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
-		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
+		|| (ARM64 && !CPU_BIG_ENDIAN)
+	depends on (ACPI || HYPERV_VTL_MODE)
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
-	select OF_EARLY_FLATTREE if OF
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
 
 config HYPERV_VTL_MODE
 	bool "Enable Linux to boot in VTL context"
-	depends on X86_64 && HYPERV
+	depends on (X86_64 || ARM64)
 	depends on SMP
+	select OF_EARLY_FLATTREE
+	select OF
 	default n
 	help
 	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
@@ -31,7 +33,7 @@ config HYPERV_VTL_MODE
 
 	  Select this option to build a Linux kernel to run at a VTL other than
 	  the normal VTL0, which currently is only VTL2.  This option
-	  initializes the x86 platform for VTL2, and adds the ability to boot
+	  initializes the kernel to run in VTL2, and adds the ability to boot
 	  secondary CPUs directly into 64-bit context as required for VTLs other
 	  than 0.  A kernel built with this option must run at VTL2, and will
 	  not run as a normal guest.
-- 
2.43.0


