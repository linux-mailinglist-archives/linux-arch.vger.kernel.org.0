Return-Path: <linux-arch+bounces-10403-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D92A46F24
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1206F3AE6FE
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97826DCE2;
	Wed, 26 Feb 2025 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s6pP91LC"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E8725DAF2;
	Wed, 26 Feb 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611344; cv=none; b=kjtB2CJgUH7O+5cOT8/5p1Yk/k/hecCVZVXSmXhwa7O7YZnyUcTFIS8Pfw4O4p3wduUMMtt9HXYoyrbqyCcJlmauOaIflDfQFThP/eSOYCnlgLADYe4Dv1j+aEITCyg35OEki+PBQjfDtMqZjOxU78hAgMI+wbFNO7ScvdoRPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611344; c=relaxed/simple;
	bh=yskLp/RgLbVA0wN4tUVY/jLv3HYRsfDs9J8O7Rmk0bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p2sh8PEdzFPkIFdDEWEwZXEZyrqoT1fAXRLS0hrLSYLkEyXzvv84H1ItzGeecdn5CtRORtgL2JzbgnnO4c75IZ8M/AouBHv9mZvpBiJh/nqvu6gU91YhNvg7PD10ziSwOVDAvIl01mvrRdYf0tKHEMPFyMZEX0CiRb3aIVQJKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s6pP91LC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2F71C210EAC6;
	Wed, 26 Feb 2025 15:08:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F71C210EAC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740611339;
	bh=dX/iJYTkA0XwCK7YEqZooviM5NNKs8hNc+nR73ij2r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6pP91LC/LLt4Zos509aAzMpzYWj0UmXWJ9I2LWsMt0jLxEe2jeFVevg40Zn0SAVO
	 fB9TJdo7QZlpcZ3WZJRGcVEH7/80MR2VwN6UQYHw5bX6HtHTqNl6s80QF7Obi9JtEy
	 /mwI/o03MprioEi7N0me2peh9ZLX7/fmeodRyxLU=
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
Subject: [PATCH v5 06/10] Drivers/hv: Export some functions for use by root partition module
Date: Wed, 26 Feb 2025 15:08:00 -0800
Message-Id: <1740611284-27506-7-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

get_hypervisor_version, hv_call_deposit_pages, hv_call_create_vp,
hv_call_deposit_pages, and hv_call_create_vp are all needed in module
with CONFIG_MSHV_ROOT=m.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c   | 1 +
 arch/x86/kernel/cpu/mshyperv.c | 1 +
 drivers/hv/hv_common.c         | 1 +
 drivers/hv/hv_proc.c           | 3 ++-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 2265ea5ce5ad..4e27cc29c79e 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -26,6 +26,7 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
 
 static int __init hyperv_init(void)
 {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 2c29dfd6de19..0116d0e96ef9 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -420,6 +420,7 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
 
 static void __init ms_hyperv_init_platform(void)
 {
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index ce20818688fe..252fd66ad4db 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -717,6 +717,7 @@ int hv_result_to_errno(u64 status)
 	}
 	return -EIO;
 }
+EXPORT_SYMBOL_GPL(hv_result_to_errno);
 
 void hv_identify_partition_type(void)
 {
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 8fc30f509fa7..20c8cee81e2b 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -108,6 +108,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	kfree(counts);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
 
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 {
@@ -194,4 +195,4 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 
 	return ret;
 }
-
+EXPORT_SYMBOL_GPL(hv_call_create_vp);
-- 
2.34.1


