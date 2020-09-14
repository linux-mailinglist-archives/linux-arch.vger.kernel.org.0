Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F041268A92
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 14:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgINMCr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 08:02:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51932 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgINMCh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 08:02:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id w2so10357497wmi.1;
        Mon, 14 Sep 2020 04:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zVgkc0Vpun48hSHnelT6bR/5tr24X+6uZTMKdzP2+o=;
        b=fFpaHxXIqGC5/Z1fO0pm3f2O5O+9WduzNZaWGKXPizy0dj/YJQJjSrzeQSPfZAoOP0
         etcJKmvic+ViVQHKDVlUEGLU55wik/UEcBjQlq6gsvjZ/NjwSppAlHnfNZnIZddE0Tjp
         mn/QxIh1ky+CNaW7bPLnG1Hfq0zGHZ3x08srdUk0ebqm3JL+ijOr53NeZ3WKtx4/mIsI
         NYP/zDxurxP40hW4A021LM9J5gO8QKtsjMYenMKOGUsweMmd9MciSrRShbXjcd3aVBon
         JrIm2RdmjuPXFdfPAOmz5oC/Ws8hxL3o3ptFHRupcUyBAhDDZVtJiKSLxjNiYyBY8JCO
         y7eA==
X-Gm-Message-State: AOAM530hnlFEmcokpyIHKOnmi8jaRi1gwWVz7YroS97pdaQ/yoxTEtiI
        y0vEIrAjBK0/t0vqdgmtIQqln6UWQjY=
X-Google-Smtp-Source: ABdhPJzyouk8921Wt/uF3ifks/nxa+uwp4vLEQHDfunEuBIKEjOhXqX3/ZZpfvXNX0yoGx+TGReX9g==
X-Received: by 2002:a1c:9654:: with SMTP id y81mr14713888wmd.9.1600084780019;
        Mon, 14 Sep 2020 04:59:40 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c205sm18764809wmd.33.2020.09.14.04.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:59:39 -0700 (PDT)
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH RFC v1 14/18] asm-generic/hyperv: import data structures for mapping device interrupts
Date:   Mon, 14 Sep 2020 11:59:23 +0000
Message-Id: <20200914115928.83184-6-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/include/asm/hyperv-tlfs.h | 13 +++++++++++
 include/asm-generic/hyperv-tlfs.h  | 36 ++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 20d628c1ed50..33210fa9899f 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -559,6 +559,19 @@ struct hv_partition_assist_pg {
 	u32 tlb_lock_count;
 };
 
+enum hv_interrupt_type {
+	HV_X64_INTERRUPT_TYPE_FIXED             = 0x0000,
+	HV_X64_INTERRUPT_TYPE_LOWESTPRIORITY    = 0x0001,
+	HV_X64_INTERRUPT_TYPE_SMI               = 0x0002,
+	HV_X64_INTERRUPT_TYPE_REMOTEREAD        = 0x0003,
+	HV_X64_INTERRUPT_TYPE_NMI               = 0x0004,
+	HV_X64_INTERRUPT_TYPE_INIT              = 0x0005,
+	HV_X64_INTERRUPT_TYPE_SIPI              = 0x0006,
+	HV_X64_INTERRUPT_TYPE_EXTINT            = 0x0007,
+	HV_X64_INTERRUPT_TYPE_LOCALINT0         = 0x0008,
+	HV_X64_INTERRUPT_TYPE_LOCALINT1         = 0x0009,
+	HV_X64_INTERRUPT_TYPE_MAXIMUM           = 0x000A,
+};
 
 #include <asm-generic/hyperv-tlfs.h>
 
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index faf892ce152d..410e2dd09a84 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -152,6 +152,8 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_RETRIEVE_DEBUG_DATA		0x006a
 #define HVCALL_RESET_DEBUG_SESSION		0x006b
 #define HVCALL_ADD_LOGICAL_PROCESSOR		0x0076
+#define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
+#define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
 #define HVCALL_RETARGET_INTERRUPT		0x007e
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
@@ -691,4 +693,38 @@ union hv_device_id {
 	} acpi;
 } __packed;
 
+enum hv_interrupt_trigger_mode {
+	HV_INTERRUPT_TRIGGER_MODE_EDGE = 0,
+	HV_INTERRUPT_TRIGGER_MODE_LEVEL = 1,
+};
+
+struct hv_device_interrupt_descriptor {
+	u32 interrupt_type;
+	u32 trigger_mode;
+	u32 vector_count;
+	u32 reserved;
+	struct hv_device_interrupt_target target;
+} __packed;
+
+struct hv_input_map_device_interrupt {
+	u64 partition_id;
+	u64 device_id;
+	u64 flags;
+	struct hv_interrupt_entry logical_interrupt_entry;
+	struct hv_device_interrupt_descriptor interrupt_descriptor;
+} __packed;
+
+struct hv_output_map_device_interrupt {
+	struct hv_interrupt_entry interrupt_entry;
+} __packed;
+
+struct hv_input_unmap_device_interrupt {
+	u64 partition_id;
+	u64 device_id;
+	struct hv_interrupt_entry interrupt_entry;
+} __packed;
+
+#define HV_SOURCE_SHADOW_NONE               0x0
+#define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
+
 #endif
-- 
2.20.1

