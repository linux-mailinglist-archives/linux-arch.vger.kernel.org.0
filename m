Return-Path: <linux-arch+bounces-10874-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959F4A622DF
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 01:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F60019C456D
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 00:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E152145A0B;
	Sat, 15 Mar 2025 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K4ToaNaF"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091896FC3;
	Sat, 15 Mar 2025 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997978; cv=none; b=a+0lqArddim1h4+ZMF+y1vqZRHAchQ8+eri+tyRAasRCc9Nt6R1l5nI3Gnk/VdxkhnEM+usKWcsJC4vPynFAtYmp8cxk3+kuOfRCiQkRAXsY96rvJf7i/xcBIn3LahLMJMn55uhJzWbvQSpmcCx14tUB+tcshPXR8oAOftBMyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997978; c=relaxed/simple;
	bh=g/2uZiUyWa0cPWg+UTEOSSCeEUcj8RSAQPmZB3sx49k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlOVWTMYXFEGqicuvWjRviOYLZnNDrwGqigR3ZwQaKjKmkDvQyX1f/Ohj2Wn2bt8ydvTlIpRT72nBQf8n8tFGzRsGMMVmFHQtl7YUAxaoHqKhbBavfsNSm24a7N3KCpx8iNUri4H7gP5fDQEnVx+SE5f9VK/O5jU58I5vNP6O04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K4ToaNaF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D2F82038F38;
	Fri, 14 Mar 2025 17:19:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D2F82038F38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741997975;
	bh=Xd84y/Dt5kGdwOHOv/ySZ7avVCs31VnToN8B2fxVlBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4ToaNaFpr0/1wcbNtPZbQaGBstjklj6nutG57i5Nh1TAFAOO9cx7IxYaN6CQUNkL
	 6G3BryTp8ULqqG8RZbO7mXzsWVcwlBtd0qbaKwdjo3tRnw/NN0B1ID19EEoVdpftjV
	 drW6A7Dih+jvHMo+BY5DjCNYYtfNUOKbLAfU6EvU=
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
Subject: [PATCH hyperv-next v6 06/11] arm64, x86: hyperv: Report the VTL the system boots in
Date: Fri, 14 Mar 2025 17:19:26 -0700
Message-ID: <20250315001931.631210-7-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315001931.631210-1-romank@linux.microsoft.com>
References: <20250315001931.631210-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hyperv guest code might run in various Virtual Trust Levels.

Report the level when the kernel boots in the non-default (0)
one.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c | 2 ++
 arch/x86/hyperv/hv_vtl.c     | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index f251a08ada5b..ecbd2f5c955e 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -110,6 +110,8 @@ static int __init hyperv_init(void)
 	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
 		hv_get_partition_id();
 	ms_hyperv.vtl = get_vtl();
+	if (ms_hyperv.vtl > 0) /* non default VTL */
+		pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
 
 	ms_hyperv_late_init();
 
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 582fe820e29c..038c896fdd60 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -55,7 +55,12 @@ static void  __noreturn hv_vtl_restart(char __maybe_unused *cmd)
 
 void __init hv_vtl_init_platform(void)
 {
-	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
+	/*
+	 * This function is a no-op if the VTL mode is not enabled.
+	 * If it is, this function runs if and only the kernel boots in
+	 * VTL2 which the x86 hv initialization path makes sure of.
+	 */
+	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
 
 	x86_platform.realmode_reserve = x86_init_noop;
 	x86_platform.realmode_init = x86_init_noop;
-- 
2.43.0


