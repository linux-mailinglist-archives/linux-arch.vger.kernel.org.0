Return-Path: <linux-arch+bounces-11302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A15A7EEBB
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 22:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85058188BEF6
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC69222597;
	Mon,  7 Apr 2025 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VnoktXpm"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC222173C;
	Mon,  7 Apr 2025 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056826; cv=none; b=sFC35jTyUEXSxenwt6bGskRFuL6uD97tdlwZk+yh73TzvrN6h4qSBmMXPChuSm/wuOiOhkAwH9dvvxqYNTCSy8JanDBKGwd8niLWkEh+1phwD5nBY4NWxiA9MzjoMBEdbBBzCLTPeQyMkHE4dxagtvlHniUUbaBOHX2VELKzin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056826; c=relaxed/simple;
	bh=blBgF6pm9yLEWrad2z6wwWi3KNdwj0wZn7wmKXkBG4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfpXbtIQYIZ6Jcqnz9XkE6FnWafWA6dFOTFnYapwe7Mf5rPbbrKRZFMwYHtQtsQKtu7yTKyTV6e96EEBCaH5/QoEsqhGkmYHyixM5sHTQrSvqnO6LgwbZr3swp55xuQnEuTGidqaKQ/DXAJrODQdvnWNYEeoOc/+tgODOgOepaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VnoktXpm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 59D362113E7E;
	Mon,  7 Apr 2025 13:13:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59D362113E7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744056819;
	bh=dEqY+MizYE3Tuj7oGWh4pKfuLIDZLrhKXP4HN0AHPSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnoktXpmnCMA6P5J4u68sf8Wczp2hON3IjXx+lXkEFEApagIgyBzbnM12H5dZjUBT
	 scAUJf3fGyIEb6Tm8OiFENslVdk3qZJd6D/0iVAj4EaRZuvT9PV50QeRqbZtnxOa2F
	 Lu6UimG790RR1nkD6FlO0Ad5pYtwMgMbhnv9cBsI=
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
Subject: [PATCH hyperv-next v7 03/11] Drivers: hv: Enable VTL mode for arm64
Date: Mon,  7 Apr 2025 13:13:28 -0700
Message-ID: <20250407201336.66913-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407201336.66913-1-romank@linux.microsoft.com>
References: <20250407201336.66913-1-romank@linux.microsoft.com>
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
 drivers/hv/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 6c1416167bd2..eefa0b559b73 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
 	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
-		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
+		|| (ARM64 && !CPU_BIG_ENDIAN)
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
@@ -15,7 +15,7 @@ config HYPERV
 
 config HYPERV_VTL_MODE
 	bool "Enable Linux to boot in VTL context"
-	depends on X86_64 && HYPERV
+	depends on (X86_64 || ARM64) && HYPERV
 	depends on SMP
 	default n
 	help
@@ -31,7 +31,7 @@ config HYPERV_VTL_MODE
 
 	  Select this option to build a Linux kernel to run at a VTL other than
 	  the normal VTL0, which currently is only VTL2.  This option
-	  initializes the x86 platform for VTL2, and adds the ability to boot
+	  initializes the kernel to run in VTL2, and adds the ability to boot
 	  secondary CPUs directly into 64-bit context as required for VTLs other
 	  than 0.  A kernel built with this option must run at VTL2, and will
 	  not run as a normal guest.
-- 
2.43.0


