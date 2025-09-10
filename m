Return-Path: <linux-arch+bounces-13463-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC3B50999
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 02:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A417AED92
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0236F41C72;
	Wed, 10 Sep 2025 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cj3NLBP2"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879CE1C695;
	Wed, 10 Sep 2025 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463033; cv=none; b=SezsBcBsTejjXB48sXh92qss/ZGaVCm9yxivuGHYe1nT/mP1QN7A6F+VsIhJfF/v/F5gxbaUbPZ5Qz1jZCNhD27aRb/w80HmsESOL5sia8SE10zSOd4k7bhfF2VvPq+oAvXYEh/TWU4oMTjRby50mV9eyPrVGGHfWAst5a2lUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463033; c=relaxed/simple;
	bh=5eTrATxYIcI4LN1XzvmKQCvDUsrtvj7AMDGTNpshG/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d6J1+BKMXjcXBSL+8XKDBhl6aNL0PjnMlU8Pcv+EV21JzBbRv7fUAiCjnEqZiKtLcKiIYnwE2LoCegfS9I9fIzzi0uq8C1YV6QuKYCBhBDcs1k8W2o54S+jKmE31mtYjgVhJimes7XWDk0WTj7dCPWwqljWkqBdFNBmT5dxdCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cj3NLBP2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 38B352018E54;
	Tue,  9 Sep 2025 17:10:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 38B352018E54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757463031;
	bh=Ch6yGympBY4h67vBABULtNBpmjBx7+W0FhU+25BVoSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cj3NLBP2/mjYXOfRRjPjo1mzggDL+NaqP0C40sXaH71EdL2DkZ8qq3NhK4HLAFByJ
	 m2/vZJvaXe1lj1efNPTVALEt0DofrD2r+xP5M8JCA96R9D0px7deTIakmMVxcI2+Kx
	 teQQJ38c53WYYO6cMojsD0TzbOAMyE+0t84YSXho=
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
Subject: [PATCH v1 3/6] hyperv: Add definitions for hypervisor crash dump support
Date: Tue,  9 Sep 2025 17:10:06 -0700
Message-Id: <20250910001009.2651481-4-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add data structures for hypervisor crash dump support to the hypervisor
host ABI header file. Details of their usages are in subsequent commits.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 include/hyperv/hvhdk_mini.h | 55 +++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 858f6a3925b3..ad9a8048fb4e 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -116,6 +116,17 @@ enum hv_system_property {
 	/* Add more values when needed */
 	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE = 15,
 	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY = 21,
+	HV_SYSTEM_PROPERTY_CRASHDUMPAREA = 47,
+};
+
+#define HV_PFN_RANGE_PGBITS 24  /* HV_SPA_PAGE_RANGE_ADDITIONAL_PAGES_BITS */
+union hv_pfn_range {            /* HV_SPA_PAGE_RANGE */
+	u64 as_uint64;
+	struct {
+		/* 39:0: base pfn.  63:40: additional pages */
+		u64 base_pfn : 64 - HV_PFN_RANGE_PGBITS;
+		u64 add_pfns : HV_PFN_RANGE_PGBITS;
+	} __packed;
 };
 
 enum hv_dynamic_processor_feature_property {
@@ -142,6 +153,8 @@ struct hv_output_get_system_property {
 #if IS_ENABLED(CONFIG_X86)
 		u64 hv_processor_feature_value;
 #endif
+		union hv_pfn_range hv_cda_info; /* CrashdumpAreaAddress */
+		u64 hv_tramp_pa;                /* CrashdumpTrampolineAddress */
 	};
 } __packed;
 
@@ -234,6 +247,48 @@ union hv_gpa_page_access_state {
 	u8 as_uint8;
 } __packed;
 
+enum hv_crashdump_action {
+	HV_CRASHDUMP_NONE = 0,
+	HV_CRASHDUMP_SUSPEND_ALL_VPS,
+	HV_CRASHDUMP_PREPARE_FOR_STATE_SAVE,
+	HV_CRASHDUMP_STATE_SAVED,
+	HV_CRASHDUMP_ENTRY,
+};
+
+struct hv_partition_event_root_crashdump_input {
+	u32 crashdump_action; /* enum hv_crashdump_action */
+} __packed;
+
+struct hv_input_disable_hyp_ex {   /* HV_X64_INPUT_DISABLE_HYPERVISOR_EX */
+	u64 rip;
+	u64 arg;
+} __packed;
+
+struct hv_crashdump_area {	   /* HV_CRASHDUMP_AREA */
+	u32 version;
+	union {
+		u32 flags_as_uint32;
+		struct {
+			u32 cda_valid : 1;
+			u32 cda_unused : 31;
+		} __packed;
+	};
+	/* more unused fields */
+} __packed;
+
+union hv_partition_event_input {
+	struct hv_partition_event_root_crashdump_input crashdump_input;
+};
+
+enum hv_partition_event {
+	HV_PARTITION_EVENT_ROOT_CRASHDUMP = 2,
+};
+
+struct hv_input_notify_partition_event {
+	u32 event;      /* enum hv_partition_event */
+	union hv_partition_event_input input;
+} __packed;
+
 struct hv_lp_startup_status {
 	u64 hv_status;
 	u64 substatus1;
-- 
2.36.1.vfs.0.0


