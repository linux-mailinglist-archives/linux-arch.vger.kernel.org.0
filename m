Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAE12C2DF7
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 18:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbgKXRIV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 12:08:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38998 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390740AbgKXRIJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2020 12:08:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id s13so3620782wmh.4;
        Tue, 24 Nov 2020 09:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSy+7CaWmr7dYr0SNSPrl+Q/2IeK6S5L4pZcI30bMis=;
        b=C1MmvGnIyNVLNIg2BxuDwDHGl5SFPWNhbWmxI/bOUFp4++Rt9O+A1fdD6ShaYsFhh6
         72vp+wv4Qq831p1RRWGYGdcNo4lIiq61TY3XcdQh+YNXRZlmSb5eASZjilTD7+KOEdNN
         zUnoA3fQIduJDX4WiniBGuIIcuxLAPdWUSWrt0PsZrTnIvS/4nOpxM6AKIHXL4011YOD
         jxpDp/l3aNk2TVgszKESHIc0NiLQWFEXWn83bD9aTNrWCOur52Pe+JkLT94RJyWPmeO/
         FG1Uld8sE3lI691jUFZfsdcDuRUA6pRg3X462uh4S7IbdrDUzirq4FK7avInQ1ZEnnl6
         1g6w==
X-Gm-Message-State: AOAM532sgSWMvswS7i93yNMETSMNCLie9/liB2mkRvvKjwVboUvQdwBW
        odgeSJxHhQ2RX7HT5MuKK+R8sCAbecY=
X-Google-Smtp-Source: ABdhPJx3Eg+8d06wrLvmyagpiwC8Rplun4TrB/OqQ9EUt4ZcPblI4BQKby/Mag6aWyanryxr1I79XA==
X-Received: by 2002:a1c:1dc1:: with SMTP id d184mr5555065wmd.169.1606237682996;
        Tue, 24 Nov 2020 09:08:02 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v20sm6419874wmh.44.2020.11.24.09.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:08:02 -0800 (PST)
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
Subject: [PATCH v3 13/17] asm-generic/hyperv: introduce hv_device_id and auxiliary structures
Date:   Tue, 24 Nov 2020 17:07:40 +0000
Message-Id: <20201124170744.112180-14-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124170744.112180-1-wei.liu@kernel.org>
References: <20201124170744.112180-1-wei.liu@kernel.org>
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

