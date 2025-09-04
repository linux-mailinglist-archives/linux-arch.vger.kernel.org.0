Return-Path: <linux-arch+bounces-13376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E2EB42F6F
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 04:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F0C7B8620
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 02:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53EB2206A6;
	Thu,  4 Sep 2025 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e1fHo+Qe"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD931FBE8B;
	Thu,  4 Sep 2025 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951834; cv=none; b=CniGTGuICd/mMZayVaflWYRLWEOXznJM7unMCkVNVXewntltX46p7X6rdT/xEBArkU4d6m8kfbGo5uZ6GZFNWfsIWRzfAq1BeB0GPBs+40rLC58xJW86TJKMZt9wl8Ammw3HnLRtCmYSun/3bb//O+/DBRoabQdeoi4Dl3S9YAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951834; c=relaxed/simple;
	bh=Ol7uJhjYh+s85Cv1d2j0gwTEgX+bql/iI1d7Y6umSL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ed5jUI7Y32O2ZC+ZrVsjI/OMlNRYMMqij0f44G+fsd/MGfPeCUVTuzVIoWw+iu9ynKJ+9YCVaKOvk6qL6FKi9zw8DzbDoiRwDx+F7HCsSdusEwTKyusPmwh+JvyzOiqn3VgQXPhsKBgQyRsWXGBxGAB9/tOtgOa+d8azpT7XViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e1fHo+Qe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E7322119CB7;
	Wed,  3 Sep 2025 19:10:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E7322119CB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756951827;
	bh=mFe+LYLxgN6atZdZNKTUwgiqqkmg9dWBbCCLyxN5CZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1fHo+QeTCuKM8JG0TEmUWZtzNQ92TkKYubnZYpGN0o5wTOzE7DgSYN61B4HEz8sG
	 cUS1SDfbAP+CmWXy7/EAUCXnUWNPKmSJNiRqIQIdKgGTCHl/y3uW96YfCXYX5EsZh9
	 k+iFFcUR5vSk4BRW/g2bEXCHrQy/cWYGxLDZQZXY=
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
Subject: [PATCH v0 3/6] Hyper-V: Add definitions for hypervisor crash dump support
Date: Wed,  3 Sep 2025 19:10:14 -0700
Message-Id: <20250904021017.1628993-4-mrathor@linux.microsoft.com>
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

This commit adds data structures for hypervisor crash dump support
to the hypervisor host ABI public header file. Details of their usages
can be found in subsequent commits.

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


