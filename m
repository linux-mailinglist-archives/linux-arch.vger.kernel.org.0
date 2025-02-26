Return-Path: <linux-arch+bounces-10395-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779C1A46F09
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5077A75CD
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82CD25D204;
	Wed, 26 Feb 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="prsKrfTW"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B84238D45;
	Wed, 26 Feb 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611340; cv=none; b=RG/xv5ZyQFmekJlnBGNcZbZ6RgOf6hgY4pvt596kdkB+Q5yD4jGu9KKXiCPYry2vBQKbsSIZGsebkqgb/zYrarD5Lw50tvuEFkv9TS+KSsw/fw3azqgy7VpVe9N/NaoMSPm3eiHT2by9k/5Vex4ARvRZWMAN+n15u9cvy+Yln1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611340; c=relaxed/simple;
	bh=nPweVsLl7uIAYWjG+7vG9M1PuFnyS6nDv4NajuCdpkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ki4cjfg+Vbi2zGUSqZRbQkk7g8WfbZn7LG890xe0urWK1SZK8kdd4pW22yvxqn2EC8KfzIkn8YNGvoqn5je6DuIXTkxABGA1Rp+cCbS45xATVe/30kg9X3nw69SUVJhR0gP5OajZ9iZuB+9dCnc0/XDDi0RbefyABxCCZaNWhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=prsKrfTW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id B0CEC210EAC5;
	Wed, 26 Feb 2025 15:08:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0CEC210EAC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740611338;
	bh=mdPAe0pP9QMjExtffSosvKieXECF/E8lF8sABw0TiKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=prsKrfTW7xMSKGkMq0JEyI47ylrRB0iXXkgVITEgofJU7UnQ4YKUX7ub9f77xioyB
	 3CyOtt1dTxF8lopX4jxKWJPhRG80QRZubcdPlfHbqSyleEOfyNiuhKnHOUhveoVIs/
	 zbBcH0pyBGhjpGrYrY/QXGuLG1uvz1AQYa6Pi8Y4=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
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
	Tianyu.Lan@microsoft.com,
	stanislav.kinsburskiy@gmail.com,
	gregkh@linuxfoundation.org,
	vkuznets@redhat.com,
	prapal@linux.microsoft.com,
	muislam@microsoft.com,
	anrayabh@linux.microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net
Subject: [PATCH v5 02/10] x86/mshyperv: Add support for extended Hyper-V features
Date: Wed, 26 Feb 2025 15:07:56 -0800
Message-Id: <1740611284-27506-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
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
---
 arch/x86/kernel/cpu/mshyperv.c | 6 ++++--
 include/asm-generic/mshyperv.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4f01f424ea5b..2c29dfd6de19 100644
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
+	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, ext 0x%x, hints 0x%x, misc 0x%x\n",
+		ms_hyperv.features, ms_hyperv.priv_high,
+		ms_hyperv.ext_features, ms_hyperv.hints,
 		ms_hyperv.misc_features);
 
 	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index dc4729dba9ef..c020d5d0ec2a 100644
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


