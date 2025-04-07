Return-Path: <linux-arch+bounces-11305-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95706A7EF13
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 22:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C2E176EF8
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8D2224895;
	Mon,  7 Apr 2025 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jv+hsY5r"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E221D5AF;
	Mon,  7 Apr 2025 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056828; cv=none; b=Qg+Kl4yNVoorkIbZkgLbWcaEteggsOd3WRiwiVPhgTnTZ+B1fPEPkDYG8KyqnjE7wbYeuLAqAtI1J2HIGGPXo1x1J1Wb2erarJi4N+xeYaiYV7qvQ4rk/P6O6/+n+utK3LwXh2z1/XzoeDV76QaFS/rPwXQfTqi7kVOK2kS/nD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056828; c=relaxed/simple;
	bh=6WQ2aD2sgTfdKZjwPZ+hD/NPNV9/A1v/KGTHEZLcaMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L668GquMyIJBTZ6CGKyr6fvQkwhSE3MHY5e576V3hBL7amTbbQO9R+3ZxAYflfExjTh3nouy4pRNw36OJtJJS04debxvkXUvSxTdCesX3xMwCNn/Dh5T6WhrDc+NcBslm0IuohLij/RBfE7oBKvPyZ6R2ojLthfTgRSoU6iao9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jv+hsY5r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2A98D2113E86;
	Mon,  7 Apr 2025 13:13:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A98D2113E86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744056820;
	bh=hiV1KAvAfB/N2ESs9iUxrXckjGXm4ld7nwAWfxyz8q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jv+hsY5rcsuD3c8v7I9L8hyRA+KW8phHovPPV231YPrJhSwID6IgM0NnjjLOQ2k21
	 +2NBNPisglIQLZtOdV5tDYFu7oyz5AuqCgKthFyjdiRtms5R8Yu+cLvPYwYW9X+je9
	 qQZjXIR7grzS8alMmKOU3Gsqk68RSRbCCKxRQG4o=
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
Subject: [PATCH hyperv-next v7 05/11] arm64: hyperv: Initialize the Virtual Trust Level field
Date: Mon,  7 Apr 2025 13:13:30 -0700
Message-ID: <20250407201336.66913-6-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407201336.66913-1-romank@linux.microsoft.com>
References: <20250407201336.66913-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various parts of the hyperv code need to know what VTL
the kernel runs at, most notably VMBus needs that to
establish communication with the host.

Initialize the Virtual Trust Level field to enable
booting in the Virtual Trust Level.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/arm64/hyperv/mshyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 21458b6338aa..43f422a7ef34 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -117,6 +117,7 @@ static int __init hyperv_init(void)
 
 	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
 		hv_get_partition_id();
+	ms_hyperv.vtl = get_vtl();
 
 	ms_hyperv_late_init();
 
-- 
2.43.0


