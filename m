Return-Path: <linux-arch+bounces-10827-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599ABA61A76
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 20:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3447AC6D2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 19:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DBC204F8A;
	Fri, 14 Mar 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hF2Rs62I"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28071FF1AF;
	Fri, 14 Mar 2025 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980566; cv=none; b=PxYxDvMZteADwTmLE5PpgqIlwxEaHnX/cB51hrE8cld5Z/z73BGaJSbIMhorYlWMidJRg8BsCkGqJwmE/uryEMvbgF1HOpZTUd+KTrtOSjwjl7fOxWF01OA127WEtm4hmu12f8ZHC7QWDcuijDujVp+MokEQFJVn1LEChPH+TsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980566; c=relaxed/simple;
	bh=xB8z8s/FLR7dj/y8/AoU0F+w/kxSVGa9ajdx4JskRRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=N5SaHJAQ7zdOiNuZWMFlPmcxfYI6FokHqRT2NzjZSSbqHmsTLSsKEpfx6uxFJu4mYSIkLM1SqDJjrWhhg5TwMka+wdJykQtZgeyvYl3r1vcLSn8HnDDL4nuk4kOsRJOeGNSNvaxjhXUvTJnxUWik7NZKwOXj9kmVH/y6VuXTGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hF2Rs62I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2C4F82033457;
	Fri, 14 Mar 2025 12:29:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C4F82033457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741980564;
	bh=g87Yc4YJdBAnwCUZKSsKpodpokZkAet25OkUYeeBX+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hF2Rs62InylvP8rtjh/0ZN2Za3ug4zYjoggrSRhQ76on39C8v5TNVqXoUJ58hRCcZ
	 m4nJ6WeuWWtgOoJC2CSCny1S9+FM7nkWUCqBX0E4AMuZhMIEm4dSiYxEPaBcBTx9OD
	 oXqSqN7esrWKlvwJHqlewqO9GKBVmTFstXQbQnWE=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	mhklinux@outlook.com,
	ltykernel@gmail.com,
	stanislav.kinsburskiy@gmail.com,
	linux-acpi@vger.kernel.org,
	eahariha@linux.microsoft.com,
	jeff.johnson@oss.qualcomm.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	apais@linux.microsoft.com,
	gregkh@linuxfoundation.org,
	vkuznets@redhat.com,
	prapal@linux.microsoft.com,
	anrayabh@linux.microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net
Subject: [PATCH v6 02/10] x86/mshyperv: Add support for extended Hyper-V features
Date: Fri, 14 Mar 2025 12:28:48 -0700
Message-Id: <1741980536-3865-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Extend the "ms_hyperv_info" structure to include a new field,
"ext_features", for capturing extended Hyper-V features.
Update the "ms_hyperv_init_platform" function to retrieve these features
using the cpuid instruction and include them in the informational output.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 6 ++++--
 include/asm-generic/mshyperv.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4f01f424ea5b..fd285b18d6b4 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -434,13 +434,15 @@ static void __init ms_hyperv_init_platform(void)
 	 */
 	ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
 	ms_hyperv.priv_high = cpuid_ebx(HYPERV_CPUID_FEATURES);
+	ms_hyperv.ext_features = cpuid_ecx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
 
 	hv_max_functions_eax = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
 
-	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
-		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
+	pr_info("Hyper-V: privilege flags low %#x, high %#x, ext %#x, hints %#x, misc %#x\n",
+		ms_hyperv.features, ms_hyperv.priv_high,
+		ms_hyperv.ext_features, ms_hyperv.hints,
 		ms_hyperv.misc_features);
 
 	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 250c65236919..c8043efabf5a 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -36,6 +36,7 @@ enum hv_partition_type {
 struct ms_hyperv_info {
 	u32 features;
 	u32 priv_high;
+	u32 ext_features;
 	u32 misc_features;
 	u32 hints;
 	u32 nested_features;
-- 
2.34.1


