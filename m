Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7282EC502
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 21:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbhAFUet (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 15:34:49 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:33093 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbhAFUet (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2021 15:34:49 -0500
Received: by mail-wm1-f54.google.com with SMTP id n16so3779956wmc.0;
        Wed, 06 Jan 2021 12:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSy+7CaWmr7dYr0SNSPrl+Q/2IeK6S5L4pZcI30bMis=;
        b=hxlLox3FDttuZPJBeqDJugvcBH9UtvKdWtgCVI9gQvdRaI2LCMxqMnZo1OLO7Orc7S
         RUxxCqpt9fyC7KNWkZ+zUsEx3MqydO9DES+FDxfCG8sLmMV8aouWiGMUckcxM4I/djzB
         kkqYqdzsvJ7J6swzsz8dlZE7XQ/0F3COo12eRL7FsLVQRQg0pK1Pi9Xbpqkg8xa4bZ5A
         bYHbIEBvYyBuNZsDet79d0lIWzmrRls0iWtrDts3go2u7gzuuLHiaHV1FwOY6ok8Bbne
         9SBcD9mRTM7QOBvJMi4xOexf6DOUUPE6hcOBxIAT11ucI9AmIRQX8UzTaS4n317qZNUQ
         g18g==
X-Gm-Message-State: AOAM531fAirvsvZSphKKK15y0pj/sSjAzB8ktVHpqSErPUPC5QAvqdFh
        dim9Ci4Nk6SruXpanBzW54QDNs4KAtg=
X-Google-Smtp-Source: ABdhPJxz+MkMNJccge+P/jCG5u8eZigTqbYVmwgEbqYZZYCGRlJYNjg+XOlLEtdbv1j1LOtcfmtMDg==
X-Received: by 2002:a1c:4c07:: with SMTP id z7mr5164429wmf.142.1609965246630;
        Wed, 06 Jan 2021 12:34:06 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:34:06 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v4 13/17] asm-generic/hyperv: introduce hv_device_id and auxiliary structures
Date:   Wed,  6 Jan 2021 20:33:46 +0000
Message-Id: <20210106203350.14568-14-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We will need to identify the device we want Microsoft Hypervisor to
manipulate.  Introduce the data structures for that purpose.

They will be used in a later patch.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 include/asm-generic/hyperv-tlfs.h | 79 +++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 8423bf53c237..42ff1326c6bd 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -623,4 +623,83 @@ struct hv_set_vp_registers_input {
 	} element[];
 } __packed;
 
+enum hv_device_type {
+	HV_DEVICE_TYPE_LOGICAL = 0,
+	HV_DEVICE_TYPE_PCI = 1,
+	HV_DEVICE_TYPE_IOAPIC = 2,
+	HV_DEVICE_TYPE_ACPI = 3,
+};
+
+typedef u16 hv_pci_rid;
+typedef u16 hv_pci_segment;
+typedef u64 hv_logical_device_id;
+union hv_pci_bdf {
+	u16 as_uint16;
+
+	struct {
+		u8 function:3;
+		u8 device:5;
+		u8 bus;
+	};
+} __packed;
+
+union hv_pci_bus_range {
+	u16 as_uint16;
+
+	struct {
+		u8 subordinate_bus;
+		u8 secondary_bus;
+	};
+} __packed;
+
+union hv_device_id {
+	u64 as_uint64;
+
+	struct {
+		u64 :62;
+		u64 device_type:2;
+	};
+
+	/* HV_DEVICE_TYPE_LOGICAL */
+	struct {
+		u64 id:62;
+		u64 device_type:2;
+	} logical;
+
+	/* HV_DEVICE_TYPE_PCI */
+	struct {
+		union {
+			hv_pci_rid rid;
+			union hv_pci_bdf bdf;
+		};
+
+		hv_pci_segment segment;
+		union hv_pci_bus_range shadow_bus_range;
+
+		u16 phantom_function_bits:2;
+		u16 source_shadow:1;
+
+		u16 rsvdz0:11;
+		u16 device_type:2;
+	} pci;
+
+	/* HV_DEVICE_TYPE_IOAPIC */
+	struct {
+		u8 ioapic_id;
+		u8 rsvdz0;
+		u16 rsvdz1;
+		u16 rsvdz2;
+
+		u16 rsvdz3:14;
+		u16 device_type:2;
+	} ioapic;
+
+	/* HV_DEVICE_TYPE_ACPI */
+	struct {
+		u32 input_mapping_base;
+		u32 input_mapping_count:30;
+		u32 device_type:2;
+	} acpi;
+} __packed;
+
 #endif
-- 
2.20.1

