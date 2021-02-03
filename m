Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34CF30DDB0
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 16:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhBCPKg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 10:10:36 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36912 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbhBCPFh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 10:05:37 -0500
Received: by mail-wm1-f53.google.com with SMTP id m1so5564558wml.2;
        Wed, 03 Feb 2021 07:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9imJaBQg9i2jLFehccOJRNFwoMJ2DilK12pGNeBjZQ=;
        b=WhsuVR4kh0ylTWAHKirfDI7OBbxePN6etVbI4K3+Gfz9WJ+mRkRX1a6wpnBf6Ub+RD
         kT4s4znOM1t0DuQFr+pFwmE2wDPZNniRfgbe0uR8MR4LColC796IASX4L++ro7/nWRhF
         2qipjERTDJwbG6G/6hQ1uuHHQXZcebyjRBQk4/8QKq4SEYOsxivYRL1y1ANK/pYPq4or
         QMItBTU/WZgyyr65dgZSQNCF1e4GupxNFQLQTXDoPTBVDW/g626QmwXQcoD59sOUXAbu
         dIqLHQRq65sIWf914itFYThst9W1fgBVq4a+7uD4FsoHvuWqcGGI6wRe9zbhnN6+zrSO
         lcQQ==
X-Gm-Message-State: AOAM533olJ5PpuMOrqoDjwvtN8IjmNfOTMPSeCRJygtaRcq9RMlYTB9L
        fzKlwp2ihrCGuNm0MyIHN/4iTbgqtm4=
X-Google-Smtp-Source: ABdhPJxWJ0+1jAHLglCaSsHlkFjiC1W0DWDjRvpl8t5IiJtY1F/fjOGLrC56n+DFn6/bfr0+IISlHw==
X-Received: by 2002:a1c:65d5:: with SMTP id z204mr3252092wmb.184.1612364694174;
        Wed, 03 Feb 2021 07:04:54 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm4051704wro.46.2021.02.03.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:04:53 -0800 (PST)
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v6 14/16] asm-generic/hyperv: import data structures for mapping device interrupts
Date:   Wed,  3 Feb 2021 15:04:33 +0000
Message-Id: <20210203150435.27941-15-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203150435.27941-1-wei.liu@kernel.org>
References: <20210203150435.27941-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 13 +++++++++++
 include/asm-generic/hyperv-tlfs.h  | 36 ++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 204010350604..ab7d6cde548d 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -533,6 +533,19 @@ struct hv_partition_assist_pg {
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
index ce53c0db28ae..a2eaed1b79e5 100644
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
@@ -702,4 +704,38 @@ union hv_device_id {
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

