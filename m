Return-Path: <linux-arch+bounces-4403-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3588C8C5DB6
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 00:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CCC282A81
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 22:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF36C182C9A;
	Tue, 14 May 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GhPZZCx2"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B983181D1B;
	Tue, 14 May 2024 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726728; cv=none; b=K1zCeqN4W+xpk3tjTEFFELyuSnB7fAqvy+1IywGYxSXErgvLXQEKOJuIfI+xgZqHtO1CxGKN4BriyhnzBvJO6Sr8/55ai2yQzMozz49Cyu8P1T24QXjVWswo7w9AOMQ5kCrkWTjT3C1vVDsYt35xi55VNHHAAh34ypN3da9LllY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726728; c=relaxed/simple;
	bh=WakItw23tStfr+6wb4ZT4IxnE2d/1msBu5yJn9iUY9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV7QAxZd7nubyFWgX77j59740j0pzRn5Nt9hYGDr3mvkE7w5SM4GkGuxIi1uG9mMvKotK2XRHBVbDeoI3fVHLCyhm4qhdKj/R3G12vxxNTJviEbTO6fVhX+trW3HdDj3JXMhO31MZ+UsyN7a3rZL+0FrGWReavijPdEzESzLwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GhPZZCx2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 242E52095D0C;
	Tue, 14 May 2024 15:45:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 242E52095D0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715726721;
	bh=tNavMrInayINex2Ss/cK7mDsEK6d64ATDiDMkzKu5sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhPZZCx25j1r3g9Qxj5sQshhjQP4zOxyEb0DkzPHh2OgJell4GEYhEhrxd5lQ07VS
	 ZpjZGEU64DQy5pvIJsG9vN0gbPuZ4ol7NCDvJ82AzDG0bpfRcaZFe36AtMWmTQVyUe
	 TYhGMjRt6PKFrKID6RyoMRIpSPezk3XrzaufVW58=
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
Subject: [PATCH v2 2/6] drivers/hv: Enable VTL mode for arm64
Date: Tue, 14 May 2024 15:43:49 -0700
Message-ID: <20240514224508.212318-3-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514224508.212318-1-romank@linux.microsoft.com>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Kconfig dependencies for arm64 guests on Hyper-V require that be ACPI enabled,
and limit VTL mode to x86/x64. To enable VTL mode on arm64 as well, update the
dependencies. Since VTL mode requires DeviceTree instead of ACPI, don’t require
arm64 guests on Hyper-V to have ACPI.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 862c47b191af..a5cd1365e248 100644
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
+	depends on HYPERV
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
2.45.0


