Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFD7268A91
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 14:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgINMCp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 08:02:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44247 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgINMCh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 08:02:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id s12so18381958wrw.11;
        Mon, 14 Sep 2020 04:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2EMorFYrbloyZ3vBTHgOEOIyWrtL7EoKHtqjNRb01I=;
        b=H2+Sw7QsMIOU9B5vQlHrmNA3jtYUx/b3hIn5Vm6fRGLKXkeWMZwnWk3gA5WmAyeBT2
         RVXv0hzWVVXEgb4E8T0WSQigEcO6jO4iLup4N37YfuAiA/BX1pog0sMJx4NV3xU6t2Ui
         npPu6pqC5OgZJ3kZMuqnPDN1xSqjv3EYnx47ADlK951oOKZSWddcovX2RaZv+zywbjLy
         A8qo7N0Tqvtfa9Ry1peB3q6NfG28YRoQmtwYaHqnk7thkqXbNOCId+g7LJHj5G5NxZT+
         ynLcsdOIaRNUyyV17FfGSawJ09IbJsBo7m6SEYalZFt6t5kcpHy0AxzWaBBEqIzn4mmV
         lYDw==
X-Gm-Message-State: AOAM532skSG22+UMBYGk+Bgi5d6p8CNPHYoQmqVVAH1I249RYXe9jsNT
        RdCpk7JSrxqP9o6+H79wWdIri1BAIwA=
X-Google-Smtp-Source: ABdhPJxO9hw1Wwb7xPWmOwlTO90CDRLUa0mPW7CxAKdL2u8XJEE5dFmtvCNRlyXzV1EMv/w7tYiLtA==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr15516895wrp.396.1600084779262;
        Mon, 14 Sep 2020 04:59:39 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c205sm18764809wmd.33.2020.09.14.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:59:38 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH RFC v1 13/18] asm-generic/hyperv: introduce hv_device_id and auxiliary structures
Date:   Mon, 14 Sep 2020 11:59:22 +0000
Message-Id: <20200914115928.83184-5-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
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
index 83945ada5a50..faf892ce152d 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -612,4 +612,83 @@ struct hv_set_vp_registers_input {
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
+	// HV_DEVICE_TYPE_LOGICAL
+	struct {
+		u64 id:62;
+		u64 device_type:2;
+	} logical;
+
+	// HV_DEVICE_TYPE_PCI
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
+	// HV_DEVICE_TYPE_IOAPIC
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
+	// HV_DEVICE_TYPE_ACPI
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

