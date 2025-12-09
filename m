Return-Path: <linux-arch+bounces-15312-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCCCCAEEC2
	for <lists+linux-arch@lfdr.de>; Tue, 09 Dec 2025 06:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5D56302D2B6
	for <lists+linux-arch@lfdr.de>; Tue,  9 Dec 2025 05:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E7D2C2364;
	Tue,  9 Dec 2025 05:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d0x6js15"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC3C2D2388;
	Tue,  9 Dec 2025 05:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765257112; cv=none; b=kXjgs3z4mjJdJBKftp6YRSpyQnN3ZDt3A/DVpIyg3lWOR9kz6xwAZgvJC+8oZ4zieig3aw0Hz5gecd1WMBpsDgOt2lWZsKnFg2W+R4EVNYtdSZmwKQhyEv53ahUJ9xE0Oq1EuqIaW0wr0JLT4PJY+cTQKq66AoDxDcddwFSGkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765257112; c=relaxed/simple;
	bh=uZ8FQkbuP89JtXvhpoK2W8cWEh971YnxUtfH6onDaCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhnPjVy07zHCtCZTGw70UavgdnUiZQ23dHILVMtYLtXwm4ELpGfBfnDpGjdv2NNh45DScfrNphCoFHfU3hXgG2REh1eGpxFYuLE/GMNgn0HL0bVDtH63lUN6u+ZtTdzkNmxfqS2PAa3Ap0S2/7UMhO3gVN+d3Nl0JZv1nc7dd0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d0x6js15; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id 473AC2015683;
	Mon,  8 Dec 2025 21:11:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 473AC2015683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765257110;
	bh=+fjEPwwpqVi0fhjnBnuNHGftSR6V5/vEADJlaXLDSuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0x6js15MsRA31ZawMH/Pw56iJebVrKE14dWIK4rE0H2wLUjUyCvd/CoY/AjPOl9W
	 An/dwv/Bhtj2XXwtPQHLMWQWt7cLRbOFgaT3cKyN8ff0/5pTkWHoto2nWRyYWHn4TR
	 p0gUjbiVaxFDScUr88qYPD8f43LA8bpW2hadDV0s=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	easwar.hariharan@linux.microsoft.com,
	jacob.pan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	peterz@infradead.org,
	linux-arch@vger.kernel.org
Subject: [RFC v1 3/5] hyperv: Introduce new hypercall interfaces used by Hyper-V guest IOMMU
Date: Tue,  9 Dec 2025 13:11:26 +0800
Message-ID: <20251209051128.76913-4-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Hyper-V guest IOMMU is a para-virtualized IOMMU based on hypercalls.
Introduce the hypercalls used by the child partition to interact with
this facility.

These hypercalls fall into below categories:
- Detection and capability: HVCALL_GET_IOMMU_CAPABILITIES is used to
  detect the existence and capabilities of the guest IOMMU.

- Device management: HVCALL_GET_LOGICAL_DEVICE_PROPERTY is used to
  check whether an endpoint device is managed by the guest IOMMU.

- Domain management: A set of hypercalls is provided to handle the
  creation, configuration, and deletion of guest domains, as well as
  the attachment/detachment of endpoint devices to/from those domains.

- IOTLB flushing: HVCALL_FLUSH_DEVICE_DOMAIN is used to ask Hyper-V
  for a domain-selective IOTLB flush(which in its handler may flush
  the device TLB as well). Page-selective IOTLB flushes will be offered
  by new hypercalls in future patches.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Co-developed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
 include/hyperv/hvgdk_mini.h |   8 +++
 include/hyperv/hvhdk_mini.h | 123 ++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 77abddfc750e..e5b302bbfe14 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -478,10 +478,16 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_GET_VP_INDEX_FROM_APIC_ID			0x009a
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
+#define HVCALL_CREATE_DEVICE_DOMAIN			0x00b1
+#define HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2
 #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
 #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
 #define HVCALL_DISPATCH_VP				0x00c2
+#define HVCALL_DETACH_DEVICE_DOMAIN			0x00c4
+#define HVCALL_DELETE_DEVICE_DOMAIN			0x00c5
 #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
+#define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
+#define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
 #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
 #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
 #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
@@ -492,6 +498,8 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_GET_VP_CPUID_VALUES			0x00f4
 #define HVCALL_MMIO_READ				0x0106
 #define HVCALL_MMIO_WRITE				0x0107
+#define HVCALL_GET_IOMMU_CAPABILITIES			0x0125
+#define HVCALL_GET_LOGICAL_DEVICE_PROPERTY		0x0127
 
 /* HV_HYPERCALL_INPUT */
 #define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 858f6a3925b3..ba6b91746b13 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -400,4 +400,127 @@ union hv_device_id {		/* HV_DEVICE_ID */
 	} acpi;
 } __packed;
 
+/* Device domain types */
+#define HV_DEVICE_DOMAIN_TYPE_S1	1 /* Stage 1 domain */
+
+/* ID for default domain and NULL domain */
+#define HV_DEVICE_DOMAIN_ID_DEFAULT 0
+#define HV_DEVICE_DOMAIN_ID_NULL    0xFFFFFFFFULL
+
+union hv_device_domain_id {
+	u64 as_uint64;
+	struct {
+		u32 type: 4;
+		u32 reserved: 28;
+		u32 id;
+	} __packed;
+};
+
+struct hv_input_device_domain {
+	u64 partition_id;
+	union hv_input_vtl owner_vtl;
+	u8 padding[7];
+	union hv_device_domain_id domain_id;
+} __packed;
+
+union hv_create_device_domain_flags {
+	u32 as_uint32;
+	struct {
+		u32 forward_progress_required: 1;
+		u32 inherit_owning_vtl: 1;
+		u32 reserved: 30;
+	} __packed;
+};
+
+struct hv_input_create_device_domain {
+	struct hv_input_device_domain device_domain;
+	union hv_create_device_domain_flags create_device_domain_flags;
+} __packed;
+
+struct hv_input_delete_device_domain {
+	struct hv_input_device_domain device_domain;
+} __packed;
+
+struct hv_input_attach_device_domain {
+	struct hv_input_device_domain device_domain;
+	union hv_device_id device_id;
+} __packed;
+
+struct hv_input_detach_device_domain {
+	u64 partition_id;
+	union hv_device_id device_id;
+} __packed;
+
+struct hv_device_domain_settings {
+	struct {
+		/*
+		 * Enable translations. If not enabled, all transaction bypass
+		 * S1 translations.
+		 */
+		u64 translation_enabled: 1;
+		u64 blocked: 1;
+		/*
+		 * First stage address translation paging mode:
+		 * 0: 4-level paging (default)
+		 * 1: 5-level paging
+		 */
+		u64 first_stage_paging_mode: 1;
+		u64 reserved: 61;
+	} flags;
+
+	/* Address of translation table */
+	u64 page_table_root;
+} __packed;
+
+struct hv_input_configure_device_domain {
+	struct hv_input_device_domain device_domain;
+	struct hv_device_domain_settings settings;
+} __packed;
+
+struct hv_input_get_iommu_capabilities {
+	u64 partition_id;
+	u64 reserved;
+} __packed;
+
+struct hv_output_get_iommu_capabilities {
+	u32 size;
+	u16 reserved;
+	u8  max_iova_width;
+	u8  max_pasid_width;
+
+#define HV_IOMMU_CAP_PRESENT (1ULL << 0)
+#define HV_IOMMU_CAP_S2 (1ULL << 1)
+#define HV_IOMMU_CAP_S1 (1ULL << 2)
+#define HV_IOMMU_CAP_S1_5LVL (1ULL << 3)
+#define HV_IOMMU_CAP_PASID (1ULL << 4)
+#define HV_IOMMU_CAP_ATS (1ULL << 5)
+#define HV_IOMMU_CAP_PRI (1ULL << 6)
+
+	u64 iommu_cap;
+	u64 pgsize_bitmap;
+} __packed;
+
+enum hv_logical_device_property_code {
+	HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU = 10,
+};
+
+struct hv_input_get_logical_device_property {
+	u64 partition_id;
+	u64 logical_device_id;
+	enum hv_logical_device_property_code code;
+	u32 reserved;
+} __packed;
+
+struct hv_output_get_logical_device_property {
+#define HV_DEVICE_IOMMU_ENABLED (1ULL << 0)
+	u64 device_iommu;
+	u64 reserved;
+} __packed;
+
+struct hv_input_flush_device_domain {
+	struct hv_input_device_domain device_domain;
+	u32 flags;
+	u32 reserved;
+} __packed;
+
 #endif /* _HV_HVHDK_MINI_H */
-- 
2.49.0


