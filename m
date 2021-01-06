Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CDD2EC505
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 21:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbhAFUeu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 15:34:50 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:37429 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbhAFUet (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2021 15:34:49 -0500
Received: by mail-wm1-f42.google.com with SMTP id q75so3727011wme.2;
        Wed, 06 Jan 2021 12:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ib7tyiX0BGEQmayJX1r0is3zXQopkTNEFvw3DWHlEoQ=;
        b=pXaaXgoRO+9Cau9K+XwkLAzB+e7lFTLL2INfT8gvMXFEFSHD12qjJP2uh3N2bNMnwJ
         qLHhcLkN3WxhdH4RVrKR6/CsLb18UlnuHo10LPrw3VzwE0EOrAAJ1PednsREGQ8KJvs+
         DNyew1nvjP7ufu1KjoMD5OmjGLvqHuq16ti2iybXQW4ad35LUePVpSnJhFvJMh6N5MPj
         adYO9r0HUJ92WO/4yNUxailuTczSMx8e+D+6+6pwgMR9pgK4q4XY2It/rkRLp4oV9Dum
         wDRngxLJvdphTpzORqfPsjNr3o1VWl2vrG/wVHGCe5XoQ4Gf8MrshaC7N22OGcBNwFIz
         6clA==
X-Gm-Message-State: AOAM533ayZyquwFp8wTl9BFTCDUGBsADzKVEjly/0miwiyuihZFNrBtW
        8RY22foGJ5RLWO1n/hrKPBxF6tu0yrw=
X-Google-Smtp-Source: ABdhPJyStoZab01oSzE2YLPF2aT6ClEhAJ+jJlHArqbNa89CxeIngzxb9d1K88QZhTvburaknaUMHg==
X-Received: by 2002:a1c:220a:: with SMTP id i10mr5111963wmi.93.1609965247447;
        Wed, 06 Jan 2021 12:34:07 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:34:07 -0800 (PST)
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
Subject: [PATCH v4 14/17] asm-generic/hyperv: import data structures for mapping device interrupts
Date:   Wed,  6 Jan 2021 20:33:47 +0000
Message-Id: <20210106203350.14568-15-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
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
index 42ff1326c6bd..07efe0131fe3 100644
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

