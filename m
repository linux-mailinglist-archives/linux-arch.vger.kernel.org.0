Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62E530DDB7
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 16:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhBCPLX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 10:11:23 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:35546 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhBCPFf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 10:05:35 -0500
Received: by mail-wm1-f46.google.com with SMTP id e15so5575793wme.0;
        Wed, 03 Feb 2021 07:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vWdqmFfS0d8zGytC5GGkmmWa/BJhoeSPmEXN8TYcu8=;
        b=Na06uTVw++tkU5ksqomgLbkhk/r0FMqgeG7TJv/aHUMheSyfpqpD0SDsRFSH98IR6b
         RyRyq/LNxkn/9gMzrtGVFlCL2jyd+PeQG8YGm45/XgZoRkVykKPUD/uVJ3nNSuKcWYxi
         5ee/1NWuxQlS1leRqBawM9NFYWo+FAVtVqXY9iM7Aq6Em2+iwsr8PR3JFcPa7HiRsKeQ
         1uPSHxbsDd9boEvxJ4xfqxJh3Lgs7uWv8eS0YMtwT/uUiiZTz1ij3Rd6gCFpRfUPjUV4
         N+U2q2dDtZnz2VjtOaVW61Yl4yDHEvKubINJv+jkNFwIcRdTs5oA2TwwQu/uoLIV3SjO
         CJLw==
X-Gm-Message-State: AOAM533YxctyA+F64N4Q/xiperWXfivn93FoYonzhkgzAXozJdKvVLC5
        XgZnP3a+ujw3OSLP3tPa7ClUBWzhdYQ=
X-Google-Smtp-Source: ABdhPJyUHjpD71vLBbSFfg7bclE1SJC5TWyDMnwxZTTU+avOiXX5q2Sj63vOB2JawOkZ1/CGpVHAsg==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr3188398wmi.177.1612364693262;
        Wed, 03 Feb 2021 07:04:53 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm4051704wro.46.2021.02.03.07.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:04:52 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v6 13/16] asm-generic/hyperv: introduce hv_device_id and auxiliary structures
Date:   Wed,  3 Feb 2021 15:04:32 +0000
Message-Id: <20210203150435.27941-14-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203150435.27941-1-wei.liu@kernel.org>
References: <20210203150435.27941-1-wei.liu@kernel.org>
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
v6:
1. Add reserved0 as field name.
---
 include/asm-generic/hyperv-tlfs.h | 79 +++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 94c7d77bbf68..ce53c0db28ae 100644
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
+		u64 reserved0:62;
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

