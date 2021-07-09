Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C1A3C2314
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jul 2021 13:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhGILqb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jul 2021 07:46:31 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36505 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhGILqb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jul 2021 07:46:31 -0400
Received: by mail-wr1-f51.google.com with SMTP id v5so11776225wrt.3;
        Fri, 09 Jul 2021 04:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqfQYRujiVCbvUET1tYexxAXm4pSzM0r3WLnNjfOptI=;
        b=m1sdojjtR04TNGeKVR/Mj40Ewpq5JpRDH2WZdnTps+lIz/xvlAFgym0IfB2YCr+2oi
         Cv/1Yz0XCnfujRFsXfcO5VfUXDK1sBC50JEl4rZdWejCS2nOUEtoL2Ji+c55AgrSs0bF
         EOqBjddaIrwkyJNJk+EXNv8HFy4D6VSHjO71LOvpgE0nwbXkz1C0r/Dlilg7NeJXU1JE
         Z8IWGxVTZQ56YPnfANI6AopIW9fqz+VLtirepX++pm8OKNzwRwkcBYfvCdnw0eEBsWD2
         0oeT9nfGXMlmOJ4ApYo0zHHazbCwhM0wa6hRRMPmQg2y4rDRLXJIfG5tGimIXqzg/4ty
         o9uA==
X-Gm-Message-State: AOAM5321C4gaFrHtJk+A/majBsHD8YX7UXOzJg7fn3ni707qdzTlEXq5
        apg/yGXdPLRXAc2zk5PkV4eIVm3ADDk=
X-Google-Smtp-Source: ABdhPJzTfUo92LrowcMjqWS+KOE462K/u/SLNsywE9CFgnM+fi00+32FwUU6Cdi+A+onLquTkeMJQQ==
X-Received: by 2002:a5d:4fd2:: with SMTP id h18mr16414039wrw.289.1625831025339;
        Fri, 09 Jul 2021 04:43:45 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z12sm4896849wrs.39.2021.07.09.04.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:43:45 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [RFC v1 2/8] asm-generic/hyperv: add device domain definitions
Date:   Fri,  9 Jul 2021 11:43:33 +0000
Message-Id: <20210709114339.3467637-3-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709114339.3467637-1-wei.liu@kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These definitions are for the IOMMU device domain interfaces exposed by
Microsoft Hyperivsor. We will use them to implement DMA remapping.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 include/asm-generic/hyperv-tlfs.h | 144 ++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index c1d3424f9e00..a39b0e6393f2 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -93,6 +93,13 @@
 #define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
 #define HV_ISOLATION				BIT(22)
 
+/*
+ * Group D features
+ */
+#define HV_DEVICE_DOMAIN_AVAILABLE		BIT(24)
+#define HV_S1_DEVICE_DOMAIN_AVAILABLE		BIT(25)
+
+
 /*
  * TSC page layout.
  */
@@ -179,6 +186,17 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 #define HVCALL_GET_GPA_PAGES_ACCESS_STATES 0x00c9
+#define HVCALL_CREATE_DEVICE_DOMAIN		0x00b1
+#define HVCALL_ATTACH_DEVICE_DOMAIN		0x00b2
+#define HVCALL_MAP_DEVICE_GPA_PAGES		0x00b3
+#define HVCALL_UNMAP_DEVICE_GPA_PAGES		0x00b4
+#define HVCALL_DETACH_DEVICE_DOMAIN		0x00c4
+#define HVCALL_DELETE_DEVICE_DOMAIN		0x00c5
+#define HVCALL_QUERY_DEVICE_DOMAIN		0x00c6
+#define HVCALL_MAP_SPARSE_DEVICE_GPA_PAGES	0x00c7
+#define HVCALL_UNMAP_SPARSE_DEVICE_GPA_PAGES	0x00c8
+#define HVCALL_CONFIGURE_DEVICE_DOMAIN		0x00ce
+#define HVCALL_FLUSH_DEVICE_DOMAIN		0x00d0
 #define HVCALL_MAP_VP_STATE_PAGE			0x00e1
 #define HVCALL_GET_VP_STATE				0x00e3
 #define HVCALL_SET_VP_STATE				0x00e4
@@ -1069,4 +1087,130 @@ union hv_disconnect_port {
 		u32 reserved: 31;
 	};
 } __packed;
+
+/* Device domain types */
+#define HV_DEVICE_DOMAIN_TYPE_S2  0 /* Stage 2 domain */
+#define HV_DEVICE_DOMAIN_TYPE_S1  1 /* Stage 1 domain */
+#define HV_DEVICE_DOMAIN_TYPE_SOC 2 /* SOC domain */
+
+/* ID for stage 2 default domain and NULL domain */
+#define HV_DEVICE_DOMAIN_ID_S2_DEFAULT 0
+#define HV_DEVICE_DOMAIN_ID_S2_NULL    0xFFFFFFFFULL
+
+union hv_device_domain_id {
+	u64 as_uint64;
+	struct {
+		u32 type: 4;
+		u32 reserved: 28;
+		u32 id;
+	};
+} __packed;
+
+union hv_input_vtl {
+	u8 as_uint8;
+	struct {
+		u8 target_vtl: 4;
+		u8 use_target_vtl: 1;
+		u8 reserved_z: 3;
+	};
+} __packed;
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
+	};
+} __packed;
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
+struct hv_input_map_device_gpa_pages {
+	struct hv_input_device_domain device_domain;
+	union hv_input_vtl target_vtl;
+	u8 padding[3];
+	u32 map_flags;
+	u64 target_device_va_base;
+	u64 gpa_page_list[];
+} __packed;
+
+struct hv_input_unmap_device_gpa_pages {
+	struct hv_input_device_domain device_domain;
+	u64 target_device_va_base;
+} __packed;
+
+struct hv_input_query_device_domain {
+	struct hv_input_device_domain device_domain;
+	u64 target_device_va_list[];
+} __packed;
+
+struct hv_device_va_mapping {
+	u64 target_device_va;
+	u64 gpa_page_number;
+} __packed;
+
+struct hv_input_map_sparse_device_gpa_pages {
+	struct hv_input_device_domain device_domain;
+	union hv_input_vtl target_vtl;
+	u32 map_flags;
+	struct hv_device_va_mapping page_list[];
+} __packed;
+
+struct hv_input_unmap_sparse_device_gpa_pages {
+	struct hv_input_device_domain device_domain;
+	u64 target_device_va_list[];
+} __packed;
+
+struct hv_device_domain_settings_x64 {
+	struct {
+		/*
+		 * Enable translations. If not enabled, all transaction bypass
+		 * S1 translations.
+		 */
+		u64 translation_enabled: 1;
+		u64 reserved: 63;
+	} flags;
+	/* Page attribute table */
+	u64 pat;
+	/* Address of translation table */
+	u64 page_table_root;
+} __packed;
+
+struct hv_device_domain_settings {
+	union {
+		struct hv_device_domain_settings_x64 x64;
+		/* ARM TBD */
+	};
+} __packed;
+
+struct hv_input_configure_device_domain {
+	struct hv_input_device_domain device_domain;
+	struct hv_device_domain_settings settings;
+} __packed;
+
 #endif
-- 
2.30.2

