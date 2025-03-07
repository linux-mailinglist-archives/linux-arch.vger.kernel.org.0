Return-Path: <linux-arch+bounces-10580-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53810A57477
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 23:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471DC189B1F5
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 22:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF94725A33D;
	Fri,  7 Mar 2025 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IpqejOvo"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D81C2580F7;
	Fri,  7 Mar 2025 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384990; cv=none; b=fsmYfXS3OlIl8SDMuZpDejJvdSewpLxiU4ABQ3tVPmneJJDgWYRBcB+cxGuNit9eoyQdYdOD1ivvqTlcLaeAkUm1fRWobY4owHJDSWkMxsdjgE1NiHWM5OHEl0qwsEvqatcCcC/kzWnUxbnhfQ0g4W/4V1N5WbZZMEZz8MDT37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384990; c=relaxed/simple;
	bh=79aHzr8RUR8X0QjS0Nutfo1COTiyDYExxJNO3oOJY7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY7hPYZhDo8MFCoc2WpPBQhUB7gso74JnCixJrJrtfR6+l51R0WA+TmGzVFE42ICWjxTbtfSaDZ6BQABiO6UsM5SSsLgQPECfOx855SIbG7sZy7jZZyzQLFqHReDu19WpSB6tZdIrJBgAHB+sCLDhpYgudQ00Zs4RufMRky+PuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IpqejOvo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F4FE2038F42;
	Fri,  7 Mar 2025 14:03:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F4FE2038F42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741384987;
	bh=6ejp9VKGmkMNi+YMzNEKy938J5ilfGRLZaNcUOciZXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpqejOvogwQq7fkkJFIx5UBw258yMNgVwiwVKJvbpy7zSfNJoFCESKEOdRtEsRVzU
	 KtEBac0X5rQj0SiRXp2qHjP14FGW3zGctOmx//BDA18H70eNtXBrxpaTt9aPiUX8DM
	 nM3PNV8Mzyu/hfO+lGVVs4oJe5vB/dYj7w9l6J10=
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
Subject: [PATCH hyperv-next v5 05/11] arm64: hyperv: Initialize the Virtual Trust Level field
Date: Fri,  7 Mar 2025 14:02:57 -0800
Message-ID: <20250307220304.247725-6-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307220304.247725-1-romank@linux.microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
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
---
 arch/arm64/hyperv/mshyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index c647db56fd6b..a7db03f5413d 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -107,6 +107,7 @@ static int __init hyperv_init(void)
 
 	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
 		hv_get_partition_id();
+	ms_hyperv.vtl = get_vtl();
 
 	ms_hyperv_late_init();
 
-- 
2.43.0


