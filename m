Return-Path: <linux-arch+bounces-13740-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94463B97990
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 23:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4107AEE82
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D3B30EF83;
	Tue, 23 Sep 2025 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Itu1Pohb"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C443F2BEFFB;
	Tue, 23 Sep 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758663983; cv=none; b=WjrLDJaDtZr62l+mNAAB7vGw5LjOhzvMgrRB+3rtjpeTTRApgg3hDHUCwGmbktWXBtekfShH+Bx56lyB9e/dwa8gqYQKnHfwk66TdZ2bgATCyuWu/g/bu5XH+41G5TNyGKRFYJtutUv/3GEl37VHRsahynTlbs5eCjHSl7Fdw48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758663983; c=relaxed/simple;
	bh=9ICHi1pM9HLaL+V4f8WYT9DRofaFIP3+WNyJ5oGj/KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBVQXFPunQ5pM95n0v1pVn0imGgjkOl0Kywjp7+OaFwqfYG9qy35i0oCgE38J81IRdeJLcaicLooqR5y9+wcV6J21mAGFcfDIesLg6cKt6DqDsxwfOlvrFB70E1yoUX9P3gd/mBiAagWJtl2GzoHwAT98Q40NwsnU/vxScN4ijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Itu1Pohb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id A3F3B201A7E9;
	Tue, 23 Sep 2025 14:46:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3F3B201A7E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758663981;
	bh=4FExu4Fssl/B2WMYYzV8pBir3oT3mfzt3nTlCllrVvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Itu1Pohba107/pGa94j7zYrvA7cZEnr8/7/ntzJa1QsotRkQkEB83+yeFw8bEi3TO
	 tkMw/QHiC0bgwHib2xGKcmMfEsaB/uF0q2qifcZje5qCSkGrHCWzSDTQOqbuF3mRag
	 xZ8j42dChYb/kouEUER2H50UHvM/bIHZ3mxaWBVg=
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
Subject: [PATCH v2 2/6] hyperv: Add two new hypercall numbers to guest ABI public header
Date: Tue, 23 Sep 2025 14:46:05 -0700
Message-Id: <20250923214609.4101554-3-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250923214609.4101554-1-mrathor@linux.microsoft.com>
References: <20250923214609.4101554-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for the subsequent crashdump patches, copy two hypercall
numbers to the guest ABI header published by Hyper-V. One to notify
hypervisor of an event that occurs in the root partition, other to ask
hypervisor to disable the hypervisor.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 include/hyperv/hvgdk_mini.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 1be7f6a02304..5441bf47059a 100644
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


