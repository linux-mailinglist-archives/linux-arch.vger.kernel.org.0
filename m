Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4532FD0E1
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 14:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388769AbhATM60 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 07:58:26 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:45207 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbhATMNK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 07:13:10 -0500
Received: by mail-ej1-f48.google.com with SMTP id ke15so25518785ejc.12;
        Wed, 20 Jan 2021 04:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSy+7CaWmr7dYr0SNSPrl+Q/2IeK6S5L4pZcI30bMis=;
        b=FUQCQvWxqgQWQYx8f9yWPxMUXtfJTGZmug1dUrElIHVknht9U/I3LqLytqhvtUiFPf
         1wk6QRz66lBdg11GLkgEmQ1ZC21mr85nKqY1T8/SvUdbrMNK1pvONyL6/pA9uw2WwiZc
         EMY5GBrwi8Qr7znq+RxdevvN+5DZRbz8aH1veWtyOuVPUM60lUr+TKJhXRTyLqOrDK8v
         +AvNDqSWKM0Rt0hBzH8yA+Cm1KJ66OJ7n/DL64j/1RAkfLvZGlCizPDVEIx359gizLKh
         9kYxYJl4IfNBXkGugfPl67RFCM4H4mCbnUWZqEwZAnKN0XvrmNmDC3WjLavelt3tralS
         zKTA==
X-Gm-Message-State: AOAM5303S0JT/69xjRXZNJPPgbPJVxh8fUJ8gnknxPj9AWvxvqwhbmr0
        gbiO83wsqQ5FKbxN+KrgB0PO8uB2K8E=
X-Google-Smtp-Source: ABdhPJw5vOkhmDj9Q+Ge0U4oH6WN1q0Res6scwIRD9dAZ10+vSr1rePaXgFDbWJizW6o0ZK2YR/7HQ==
X-Received: by 2002:a5d:6983:: with SMTP id g3mr9082864wru.168.1611144076449;
        Wed, 20 Jan 2021 04:01:16 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x17sm3747671wro.40.2021.01.20.04.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:01:16 -0800 (PST)
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
Subject: [PATCH v5 13/16] asm-generic/hyperv: introduce hv_device_id and auxiliary structures
Date:   Wed, 20 Jan 2021 12:00:55 +0000
Message-Id: <20210120120058.29138-14-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120120058.29138-1-wei.liu@kernel.org>
References: <20210120120058.29138-1-wei.liu@kernel.org>
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

