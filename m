Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F124830AB72
	for <lists+linux-arch@lfdr.de>; Mon,  1 Feb 2021 16:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBAPcy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 10:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhBAOtR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Feb 2021 09:49:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB73C06174A;
        Mon,  1 Feb 2021 06:48:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v15so16898755wrx.4;
        Mon, 01 Feb 2021 06:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbWBbNu7/Yt79pMx5iXE2do7XeNiz3bUeF//Cx/2194=;
        b=mOrf6KIG/gSKkNkyxFg2xIIXM/MGoagfoV3LfjP++oYEpa5u94PR512Z5FilpTUzQY
         aaWfuD7S75x4blcJc7gpLCPC5zdwlHpDQFOLa+3cXlBTWo2ofkxDKtMu6AuAQ3r3+vqZ
         EkoSPGaLqiA2znjxCw8yRgN/BPtviXblrscon3kGNzHeWxyydwZN8cfvz3oey5uW1Jrg
         OaGjN1mGpxKwXXrnj95ZMts44FF92apTqM22t7TFk54+S/RNZKtsygYmqcdD2TzNUE2U
         nRaJ3U3m8nj10NBpXZIMYszyQTh8RHyASURNYiiQJ1VEDH832UJS6ytxkgWTOUj8TtUY
         d7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbWBbNu7/Yt79pMx5iXE2do7XeNiz3bUeF//Cx/2194=;
        b=QKOme3T4mvHFve/iNa14IU9YBYZhP2WJaEikhlF2r7nk192QVpF3v4ZfIi9jCRo30s
         29cFQPfj9CCWADvxIROFFfDcjd1JsfrXO70sweY1yMjU7Qv77+w9ZUGjHMVXRwElXztz
         +fGP6EdicSWUq0JUhN4TGHXkBOxzKJoYjAX5tIA/p/0vgKmGQxhGX8wA/xaPKFhLAP/4
         gCaiqJtt0QUbrOYu81p3/PLPYeSndZGBCqyt6l8LERX+upoPa7wB58sk2gFJsgpCznn/
         rN+nV6WfoikEEZkl0tnYUlFVfGUkmYuFqJ+eObC/pfGFquv5jlPao7jPio3GLBGmNOmt
         +Clw==
X-Gm-Message-State: AOAM5316NyTJwNKcsH1rRzc6shcOpXvl19Sjzkwbh0EjPi5aU3ApUXUW
        zx7o4kTSYmYghHa0MPI+e+tHC9dHpgF8qNGl
X-Google-Smtp-Source: ABdhPJwvptqUw9TZZE7UgPiFEeiOi/q3oNtIvnAo7+2pZgjelM2n7CUmXsZcemRc8/aYzhZHmopXpg==
X-Received: by 2002:adf:fe04:: with SMTP id n4mr19140921wrr.115.1612190914208;
        Mon, 01 Feb 2021 06:48:34 -0800 (PST)
Received: from anparri.mshome.net (host-95-238-70-33.retail.telecomitalia.it. [95.238.70.33])
        by smtp.gmail.com with ESMTPSA id c11sm26106591wrs.28.2021.02.01.06.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:48:33 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 hyperv-next 1/4] x86/hyperv: Load/save the Isolation Configuration leaf
Date:   Mon,  1 Feb 2021 15:48:11 +0100
Message-Id: <20210201144814.2701-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201144814.2701-1-parri.andrea@gmail.com>
References: <20210201144814.2701-1-parri.andrea@gmail.com>
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
index e04d90af4c27c..ccdfc6868cfc8 100644
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
+	if (!(ms_hyperv.features_b & HV_ISOLATION))
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
index f628e3dc150f3..ea7bd8dff171c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -225,6 +225,7 @@ static void __init ms_hyperv_init_platform(void)
 	 * Extract the features and hints
 	 */
 	ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
+	ms_hyperv.features_b = cpuid_ebx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
 
@@ -259,6 +260,14 @@ static void __init ms_hyperv_init_platform(void)
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
 	}
 
+	if (ms_hyperv.features_b & HV_ISOLATION) {
+		ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
+		ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
+
+		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
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
index c57799684170c..dff58a3db5d5c 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -27,11 +27,14 @@
 
 struct ms_hyperv_info {
 	u32 features;
+	u32 features_b;
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

