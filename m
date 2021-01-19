Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56222FC1D7
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jan 2021 22:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388981AbhASSto (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 13:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392115AbhASSBJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 13:01:09 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35ADC061574;
        Tue, 19 Jan 2021 09:59:07 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v15so16973727wrx.4;
        Tue, 19 Jan 2021 09:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQ5xIPCP4rRNpRCokZFLT5bw0+ex04yhSxDgKJZH+oM=;
        b=u4StBFHaAlbULJrzakePO9QZMwpbtalpXPN1FkFc+dT1uuFLwuLpSWs5lq285E1UoY
         WPrQ4nBwSPPXwEiABSN91nnItVtr5BnbM7MfGO+hRxwBlMPbhh/1qzR+l9DWG2AVDbBQ
         VI9aLJAs6yCamdoiqVxRYZM0I4jwmSZw+115JMFcqBvIoyphoLlqF+sRnGGqB3Ors9+L
         jQl7YNSBDZ/ohjyQiX192sMsUxh6lzqw5KzKFKYVdWEefDeeiP0AmXwoc0ZZQv/9U57+
         eCRm0wVlMTJ1kGODNDGE0ZTs2ELmBc4gmTAmG98I8z6giLKfN3vgmLjDqS2cegO+j670
         LnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQ5xIPCP4rRNpRCokZFLT5bw0+ex04yhSxDgKJZH+oM=;
        b=I1wjIEAZbqD+WW+heSqKX2hC52s813OOzcj/vXlvISlUotaPgFJV4do0GBk6T8M6vx
         OlLNYi7aepOsMPoMoG61Cby51kDXMmbD2CQ8dN5d6A3Zp5B8vOy3iyL3Cj/9vm/a6REt
         bLwoz3vRz+BF78WwmiOM14Dqd7Lwsg6u6qGYDGC03XXpjYM6B9rQIfx9PY1e5vNN1tpR
         /vPrXwzBBO837kIsP8usJIimXrRVNkQ6c7UdRsUh6XJyjQtkTCq3LwXPnajmTu69eo83
         TjeyIhMivHyJf60lCVtK0iHIH6UttDg/0DeBUDc2iRnlAZVDJhg4DdiGgPisG7MaS1Ly
         9h5Q==
X-Gm-Message-State: AOAM532uNcFEhxGy5r44txJd5qi1BPZorohAoxxENPqTJoI6/JtohPfZ
        fGiZm3cqDmTchugGi7Pr395f1oAxcu5XvMY+
X-Google-Smtp-Source: ABdhPJzpzJ68NR3SBT0tLRl5UFbfO0yOJ9l5LzCPK+uU2ajjAtklNVApDq/NIWGJeBUWFtw9wPZYMg==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr5434406wrv.93.1611079146023;
        Tue, 19 Jan 2021 09:59:06 -0800 (PST)
Received: from anparri.mshome.net (host-79-50-177-118.retail.telecomitalia.it. [79.50.177.118])
        by smtp.gmail.com with ESMTPSA id h125sm5899312wmh.16.2021.01.19.09.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 09:59:05 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 1/4] x86/hyperv: Load/save the Isolation Configuration leaf
Date:   Tue, 19 Jan 2021 18:58:38 +0100
Message-Id: <20210119175841.22248-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119175841.22248-1-parri.andrea@gmail.com>
References: <20210119175841.22248-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If bit 22 of Group B Features is set, the guest has access to the
Isolation Configuration CPUID leaf.  On x86, the first four bits
of EAX in this leaf provide the isolation type of the partition;
we entail three isolation types: 'SNP' (hardware-based isolation),
'VBS' (software-based isolation), and 'NONE' (no isolation).

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org
Cc: linux-arch@vger.kernel.org
---
 arch/x86/hyperv/hv_init.c          | 15 +++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h | 15 +++++++++++++++
 arch/x86/kernel/cpu/mshyperv.c     |  9 +++++++++
 include/asm-generic/hyperv-tlfs.h  |  1 +
 include/asm-generic/mshyperv.h     |  5 +++++
 5 files changed, 45 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e04d90af4c27c..dc94e95c57b98 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/types.h>
+#include <linux/bitfield.h>
 #include <asm/apic.h>
 #include <asm/desc.h>
 #include <asm/hypervisor.h>
@@ -528,3 +529,17 @@ bool hv_is_hibernation_supported(void)
 	return acpi_sleep_state_supported(ACPI_STATE_S4);
 }
 EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
+
+enum hv_isolation_type hv_get_isolation_type(void)
+{
+	if (!(ms_hyperv.hypercalls_features & HV_ISOLATION))
+		return HV_ISOLATION_TYPE_NONE;
+	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
+}
+EXPORT_SYMBOL_GPL(hv_get_isolation_type);
+
+bool hv_is_isolation_supported(void)
+{
+	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
+}
+EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 6bf42aed387e3..6aed936e5e962 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -22,6 +22,7 @@
 #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
 #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
 #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
+#define HYPERV_CPUID_ISOLATION_CONFIG		0x4000000C
 
 #define HYPERV_CPUID_VIRT_STACK_INTERFACE	0x40000081
 #define HYPERV_VS_INTERFACE_EAX_SIGNATURE	0x31235356  /* "VS#1" */
@@ -122,6 +123,20 @@
 #define HV_X64_NESTED_GUEST_MAPPING_FLUSH		BIT(18)
 #define HV_X64_NESTED_MSR_BITMAP			BIT(19)
 
+/* HYPERV_CPUID_ISOLATION_CONFIG.EAX bits. */
+#define HV_PARAVISOR_PRESENT				BIT(0)
+
+/* HYPERV_CPUID_ISOLATION_CONFIG.EBX bits. */
+#define HV_ISOLATION_TYPE				GENMASK(3, 0)
+#define HV_SHARED_GPA_BOUNDARY_ACTIVE			BIT(5)
+#define HV_SHARED_GPA_BOUNDARY_BITS			GENMASK(11, 6)
+
+enum hv_isolation_type {
+	HV_ISOLATION_TYPE_NONE	= 0,
+	HV_ISOLATION_TYPE_VBS	= 1,
+	HV_ISOLATION_TYPE_SNP	= 2
+};
+
 /* Hyper-V specific model specific registers (MSRs) */
 
 /* MSR used to identify the guest OS. */
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f628e3dc150f3..0d4aaf6694d01 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -225,6 +225,7 @@ static void __init ms_hyperv_init_platform(void)
 	 * Extract the features and hints
 	 */
 	ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
+	ms_hyperv.hypercalls_features = cpuid_ebx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
 
@@ -259,6 +260,14 @@ static void __init ms_hyperv_init_platform(void)
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
 	}
 
+	if (ms_hyperv.hypercalls_features & HV_ISOLATION) {
+		ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
+		ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
+
+		pr_info("Hyper-V: Isolation Config: GroupA 0x%x, GroupB 0x%x\n",
+			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
+	}
+
 	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
 		ms_hyperv.nested_features =
 			cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index e73a11850055c..20d3cd9502043 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -89,6 +89,7 @@
 #define HV_ACCESS_STATS				BIT(8)
 #define HV_DEBUGGING				BIT(11)
 #define HV_CPU_POWER_MANAGEMENT			BIT(12)
+#define HV_ISOLATION				BIT(22)
 
 
 /*
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c57799684170c..c7f75b36f88ba 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -27,11 +27,14 @@
 
 struct ms_hyperv_info {
 	u32 features;
+	u32 hypercalls_features;
 	u32 misc_features;
 	u32 hints;
 	u32 nested_features;
 	u32 max_vp_index;
 	u32 max_lp_index;
+	u32 isolation_config_a;
+	u32 isolation_config_b;
 };
 extern struct ms_hyperv_info ms_hyperv;
 
@@ -169,6 +172,8 @@ void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
 void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
+enum hv_isolation_type hv_get_isolation_type(void);
+bool hv_is_isolation_supported(void);
 void hyperv_cleanup(void);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
-- 
2.25.1

