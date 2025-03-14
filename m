Return-Path: <linux-arch+bounces-10833-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445D0A61A8B
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 20:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E5F3BEFE4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 19:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446BA205E17;
	Fri, 14 Mar 2025 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aLaEpu1K"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB26204F8D;
	Fri, 14 Mar 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980568; cv=none; b=tSUybnTDnA5RVsJN6fvD63YWEzp7Hq8r7y/sn+DyG8dzzGFlJuDYm9iu/RO903VfBXClCFAJGcrBWkSgWhp2/J320+jG5xIQeLnLUCZrs5HCEPR+tbxQ9jfF1oXptaeqcQLmOYKi6r9p1dsY13CuI/GtSmAblsO0XbVYkEM1keo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980568; c=relaxed/simple;
	bh=9ELoYCmPg37+v4OVYibLG9eqq18VqnUCq6jYL667hqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Sz63ikTDCUiUdttEAO5SYJUqbzm/wxFjVt8lM8XnUaZis5/2WEv7gYbxiY23yaNPcvWdYPurOC6UXukNAITSkyA5DGLjykwFv3CnqFAafyA9eMY0sryNKOll4mAGFWnwqJ7dZUHIo+jDuei5s14eQ9+endo0WSJTiDIK88Htuw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aLaEpu1K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id B3883203345E;
	Fri, 14 Mar 2025 12:29:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3883203345E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741980564;
	bh=/JqI9TbPHCy3il1UNWg2awM1y5je68lG4yjIK0wb1VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aLaEpu1KaR49m6Bi5ihb4qI3/4BH/nmolTozffk/qhMB4YggqJXDq2mMENSi5ZF9S
	 qqJYF+R4RPki6TRa0UXlbXPgKgThH7nNS+wWpsQ2OSB9z2pURh5fGl+oNqiwf3OKJB
	 rJy7L2KNYG1zCrRFLhzQbvaN5HkFWVsGjPou/Nck=
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
Subject: [PATCH v6 06/10] Drivers: hv: Export some functions for use by root partition module
Date: Fri, 14 Mar 2025 12:28:52 -0700
Message-Id: <1741980536-3865-7-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

hv_get_hypervisor_version(), hv_call_deposit_pages(), and
hv_call_create_vp(), are all needed in-module with CONFIG_MSHV_ROOT=m.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Stanislav Kinsburskii <skinsburskii@microsoft.linux.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c   | 1 +
 arch/x86/kernel/cpu/mshyperv.c | 1 +
 drivers/hv/hv_proc.c           | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

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
index fd285b18d6b4..fcd0e066d9bd 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -420,6 +420,7 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
 
 static void __init ms_hyperv_init_platform(void)
 {
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 605999f10e17..7d7ecb6f6137 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -107,6 +107,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	kfree(counts);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
 
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 {
@@ -191,4 +192,4 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 
 	return ret;
 }
-
+EXPORT_SYMBOL_GPL(hv_call_create_vp);
-- 
2.34.1


