Return-Path: <linux-arch+bounces-13373-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B11DB42F69
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 04:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD51B1BC7A88
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 02:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46411E3DED;
	Thu,  4 Sep 2025 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KbxlR9pr"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB11F5423;
	Thu,  4 Sep 2025 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951833; cv=none; b=J74yfrANF1oaenJ4T+reitGm986+zzrNOtJ3s1f3dUU09T9dDAtc1vp0LkrRNkGCCUhM90EKagkSveP93GK7gnO6CT4Ds+gDP2H8nnktHtxGwlKfqejabgsLPDvefKyvEUHY3J6uQJeVYuq/jkXnQ0Jdc+lwxmHUSPfUvHantHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951833; c=relaxed/simple;
	bh=pFdy17PASDZhtVXKrdmSoRTzFGcWx2sYAD+Bp92OhhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y1sHM89gq+nXV4wboGDAFAjE849usqT+FHNpr1k2mKit3XM3QFYVyTdqxksrUxkekwkr/1ZT5g9+YOw13Kv+OpFlDaXfPkcloMbdSbIC2eGpMABrtF7RryoesWR6qLz/a5PbgFBl9EYxROI9lNLOiXOANSbazpdkFvz82vAINeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KbxlR9pr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id B292F2119CB1;
	Wed,  3 Sep 2025 19:10:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B292F2119CB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756951826;
	bh=DsIytbrsG5t6SIA7EuHmk64j5u61P0pk93fUtVM4SmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbxlR9prgIi4TdeKKGOkPWKndB+nQ7HFXobc7EqWiOsqKjqHRWrwO0YzO5YX30EjK
	 RNBUGgP4aaAu4fAQIsPrXIjvtOqdrTTsQfpCzI6yAdIkvTwGMjEomK0pfaUHU/85FW
	 cVy4eZh4hHTJJSaI5a4ZQzD2BIk2V6CDnh1ZxR2Y=
From: Mukesh Rathor <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de
Subject: [PATCH v0 2/6] Hyper-V: Add two new hypercall numbers to guest ABI public header
Date: Wed,  3 Sep 2025 19:10:13 -0700
Message-Id: <20250904021017.1628993-3-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
References: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for upcoming crashdump patches, this commit copies two new
hypercall numbers to the guest ABI header published by Hyper-V. One to
notify hypervisor of an event that occurs in the root partition, other
to ask hypervisor to disable the hypervisor.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 include/hyperv/hvgdk_mini.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 79b7324e4ef5..b288906c79d0 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -469,6 +469,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
 #define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
 #define HVCALL_RETARGET_INTERRUPT			0x007e
+#define HVCALL_NOTIFY_PARTITION_EVENT                   0x0087
 #define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
 #define HVCALL_REGISTER_INTERCEPT_RESULT		0x0091
 #define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
@@ -492,6 +493,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_GET_VP_CPUID_VALUES			0x00f4
 #define HVCALL_MMIO_READ				0x0106
 #define HVCALL_MMIO_WRITE				0x0107
+#define HVCALL_DISABLE_HYP_EX                           0x010f
 
 /* HV_HYPERCALL_INPUT */
 #define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
-- 
2.36.1.vfs.0.0


