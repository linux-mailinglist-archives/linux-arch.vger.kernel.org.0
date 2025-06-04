Return-Path: <linux-arch+bounces-12190-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663FBACD0C5
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B383A731E
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA56D33062;
	Wed,  4 Jun 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Vbl2GwRG"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28328B665;
	Wed,  4 Jun 2025 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997827; cv=none; b=gd01X0S+zfiubkXhllpgz4HYO5xAh8BXu+Umc9AN0KfIXWnCYEi4AdcAUyxGc/kRPGHgkr8VQc7u9lcldatx9hLzPZG4rOX35MHXrmiLVf8VS4hlIWQwNb9StbaYAakreiuBT0pNJCxE0eIjZwXmVPK3TFBiEPZO0bPY5Ldwc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997827; c=relaxed/simple;
	bh=QY1MsUIE3B8H/obojmZnsFa1h4TAkdls1yVtcOG+Fjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHczObiFaNr5gW5YIaMhTrIjhdX6TJm/e37vQYB3JQh2f4tMAp2+BvF7kSSYMdv3Il5wxWQAcsSRDoWkMM9CqwqGtzLci59+1QaRf2nknNUow4yZ1cl+wdAgAxyjwoVIHnUodEZdWoYU0+ijsH4wQbFSQrDrBB8k6alIvpgEZ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Vbl2GwRG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6FF392116B50;
	Tue,  3 Jun 2025 17:43:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6FF392116B50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997825;
	bh=Edyue9zLDGHoqfApU478/BzTldR4EqRL+7s8Di7ovLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vbl2GwRGS3QQm42V3GjndlJkVgH36cJWNuWHb+T/iZswUm8ez2xQpsKiMbQAzUyQz
	 uAsruhCS5q2NzZsq+qAp2TeX0XjfEN48PWXPMqK/ct+wRDt+SU7HWCVw+Ft/R6S+qn
	 0M8Tp+DKNjg6oqbeVB6vZNx3u4xrkajnB2m0joHA=
From: Roman Kisel <romank@linux.microsoft.com>
To: alok.a.tiwari@oracle.com,
	arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v3 04/15] arch/x86: mshyperv: Trap on access for some synthetic MSRs
Date: Tue,  3 Jun 2025 17:43:30 -0700
Message-ID: <20250604004341.7194-5-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604004341.7194-1-romank@linux.microsoft.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To set up and run the confidential VMBus, the guest needs the paravisor
to intercept access to some synthetic MSRs. In the non-confidential case,
the guest continues using the vendor-specific guest-host communication
protocol.

Update the hv_set_non_nested_msr() function to trap access to some
synthetic MSRs.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 83a85d94bcb3..db6f3e3db012 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -28,6 +28,7 @@
 #include <asm/apic.h>
 #include <asm/timer.h>
 #include <asm/reboot.h>
+#include <asm/msr.h>
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
@@ -77,14 +78,28 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
 
 void hv_set_non_nested_msr(unsigned int reg, u64 value)
 {
+	if (reg == HV_X64_MSR_EOM && vmbus_is_confidential()) {
+		/* Reach out to the paravisor. */
+		native_wrmsrl(reg, value);
+		return;
+	}
+
 	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
+		/* The hypervisor will get the intercept. */
 		hv_ivm_msr_write(reg, value);
 
-		/* Write proxy bit via wrmsl instruction */
-		if (hv_is_sint_msr(reg))
-			wrmsrl(reg, value | 1 << 20);
+		if (hv_is_sint_msr(reg)) {
+			/*
+			 * Write proxy bit in the case of non-confidential VMBus.
+			 * Using wrmsl instruction so the following goes to the paravisor.
+			 */
+			u32 proxy = vmbus_is_confidential() ? 0 : 1;
+
+			value |= (proxy << 20);
+			native_wrmsrl(reg, value);
+		}
 	} else {
-		wrmsrl(reg, value);
+		native_wrmsrl(reg, value);
 	}
 }
 EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
-- 
2.43.0


