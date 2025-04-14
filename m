Return-Path: <linux-arch+bounces-11396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73524A88F51
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 00:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8163017AA2E
	for <lists+linux-arch@lfdr.de>; Mon, 14 Apr 2025 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376A20012B;
	Mon, 14 Apr 2025 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QyTTM/5q"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9C1F4612;
	Mon, 14 Apr 2025 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744670839; cv=none; b=Kf9VPMJ0N3Bv86UNH7rPcKCaTgYAkaWrQI/qIX1l6Ij7FfVARx6YqIoDeynOeoxtqkgBOs7Eos9VSiuT2S80Xu/+MqPcc5Z+7ewhDTr/uCKDPY0olOUPLNHkCgiQvnWJgi2WSknoXF8e6n0/D7PbevWJVNStLfzc2pp4Ye9hLm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744670839; c=relaxed/simple;
	bh=c+/j/2pboRhj9Sr9Wq7w4Fvl1hw1Q8cVfjYg/TpnhbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGx+1Bs35Mok9BktHRSbcJyvh3ebG8s3zelRkZMhijMExgF2Z45Ya7/7xRLaq12xhp/EK8IIPmEBoFIfwoTCsfS/m9t8SCGrBumdrt61IVBhiEVkgFFGtZe9TALSVQrQLgVqXc4nW00zqMvD2D/KrRPviijTD9rkkDbZqhQVKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QyTTM/5q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2CF3D210C432;
	Mon, 14 Apr 2025 15:47:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2CF3D210C432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744670837;
	bh=vzZkIFRMD2hQLh9+VvUPueZXLrCeW93f5raMLcL3650=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QyTTM/5qZBzDtsTacZnj7FmSTNxoQeBAH+Np8Jn4ipweWDspLjOdKgg33R2x7We61
	 YVk1HzbS5LzdvN+t4I1PzvjJKkVE1Dhh9BVtcYTq4GSrWn8DzN+6oI4aaeKMpQK1Am
	 4MRsLDysJIU63hY/S3MFq2UkuomqAZEHvJ2nhm6g=
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
Subject: [PATCH hyperv-next v8 06/11] arm64, x86: hyperv: Report the VTL the system boots in
Date: Mon, 14 Apr 2025 15:47:08 -0700
Message-ID: <20250414224713.1866095-7-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414224713.1866095-1-romank@linux.microsoft.com>
References: <20250414224713.1866095-1-romank@linux.microsoft.com>
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
index 43f422a7ef34..4fdc26ade1d7 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -118,6 +118,8 @@ static int __init hyperv_init(void)
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


