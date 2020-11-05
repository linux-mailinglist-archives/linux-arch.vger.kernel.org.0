Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202962A8433
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 17:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbgKEQ6i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 11:58:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50747 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731804AbgKEQ6h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2020 11:58:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id h2so2293261wmm.0;
        Thu, 05 Nov 2020 08:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FP0dhks/7fReYYF8ITsl8Q3US2axftFmWUvll+C3zPY=;
        b=CzZCgk8/cUqyNR5FAG0eapKUtyuJmLyG7b7uiL8SjKDrMsgfdP/m12P4Idg9BUUQ+S
         8Daew70Z3C+M6KGDYWvUQT8PYlmiDamEOfgR6EyyZmSBu3ZUErf45jMSaLG+N/v/XNv8
         9lP4phIMBftUZe+B6u8uE3ecgaO0xgmgorfIKGTTrikq5qSp00TAWtAMb7l285sKHV0D
         QepXjsJQKISAwoRI8tvDAtzSgbdeslyJ/ZuZGZDiBcddNizOtLtnV/B3UG/W3x0ezmdR
         Ix8SQUvNjkfmbRgLxuyJbImwZcn0IihidJb9UejG99A45rwfUrXG/mAaQgZ53vn2c+g/
         j/Xg==
X-Gm-Message-State: AOAM530aAC23y8xql4xgUrrELWqUR49M9p1oypqeDfZonxkLsjviDYAt
        uI8z6WoKoByfn7KpJwZfC6kKNeaRxw0=
X-Google-Smtp-Source: ABdhPJx3ouaukk4NfeLEXOqv1CQY4dyRh5b1l/nTJRNZSF0B512beVlGBylj/bN6BXeHkqwl97KLnA==
X-Received: by 2002:a1c:4888:: with SMTP id v130mr3655204wma.84.1604595512872;
        Thu, 05 Nov 2020 08:58:32 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z5sm3350729wrw.87.2020.11.05.08.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:58:32 -0800 (PST)
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v2 14/17] asm-generic/hyperv: import data structures for mapping device interrupts
Date:   Thu,  5 Nov 2020 16:58:11 +0000
Message-Id: <20201105165814.29233-15-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105165814.29233-1-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 41b628b9fb15..592c75e51e0f 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -526,6 +526,19 @@ struct hv_partition_assist_pg {
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
index 09223e41172c..dd385c6a71b5 100644
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

