Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89B4303C4B
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 12:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405323AbhAZL6p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 06:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405174AbhAZL5y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2021 06:57:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98D7C061756;
        Tue, 26 Jan 2021 03:57:10 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h9so5904785wrr.9;
        Tue, 26 Jan 2021 03:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQ5xIPCP4rRNpRCokZFLT5bw0+ex04yhSxDgKJZH+oM=;
        b=ce8aX/fQJdRNC5IJWZsKG8S476Xe6QO5w7i9U17iVUFZo5KlipR0YgT4DFpX6oO45c
         5G5OaSQc7qzQUZ1Ghd0UonGKh6xIRN/0LLZqrnZdH2/WWJF4S/7d3g29XooQsYjyb7N2
         vk5tLMl4OSGoKbP/d9PVKVtaREv0JkYgoZJ1h9/ZLXxRPD5szUajUvHdcwnoUBTnGPWD
         /nZbncEoDUPHzatP7QLFzi674SPvXZi8VSnA2ej6lLR0KgY28snRavpePSJvABoQ6Del
         NLcUv0A0CV92iw8/CkxMgMDxH6xOYT8pjEEZcvAUoE0V3TXJrClXmhP52Mhbxtene4HN
         yVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQ5xIPCP4rRNpRCokZFLT5bw0+ex04yhSxDgKJZH+oM=;
        b=B/EUu8EGA4s4URgVVC9NM8OvFijRCaitExtW3XiLUG0oMB6nFxg6YjLqosp8Qvq001
         vxU4Am+pN6tP85rqi79vHntzhNxeZvpZHYpNPfeNw7Mrl24JknU9Hc9knYKMcfqajqGw
         dBUSecaLaLsai0VyY7JKKhVa9TPFi+HqERuVxmWR0Ukop63VP5SVNy0hM1Rf78cvQeGI
         H8Y+YxknG90/0KChtrZmEB2bkFxKLO0k2c/DORuJq0vo+ZdnkCV125vN4kO8Mn6lPU2p
         oKGDWHK25X++sx/jqhH8hGf2xDf3x9+sRG6y6mYvMi78KArmGcBxnnKQywLAWztloiyI
         J/8w==
X-Gm-Message-State: AOAM530hOozrRzTuF8nyuSBamCCB1cvFnh6cou2MB8CAjlRbQYE+gXGc
        h0RNkWV55bzP6f8lVcU4ZZjd8xDIqAW4je0j
X-Google-Smtp-Source: ABdhPJznCKPbL+Zn700dBBuMsuAKwJ2HxBry5NxXGpIVNDMAWF+qD7HjBWgruZNEvRe4HENOcYyE7A==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr5691666wrw.150.1611662229165;
        Tue, 26 Jan 2021 03:57:09 -0800 (PST)
Received: from anparri.mshome.net (host-95-238-70-33.retail.telecomitalia.it. [95.238.70.33])
        by smtp.gmail.com with ESMTPSA id z185sm3330283wmb.0.2021.01.26.03.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 03:57:08 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 1/4] x86/hyperv: Load/save the Isolation Configuration leaf
Date:   Tue, 26 Jan 2021 12:56:38 +0100
Message-Id: <20210126115641.2527-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126115641.2527-1-parri.andrea@gmail.com>
References: <20210126115641.2527-1-parri.andrea@gmail.com>
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

