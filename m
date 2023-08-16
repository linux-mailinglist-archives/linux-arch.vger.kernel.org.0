Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DEE77E5CB
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbjHPP7g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344501AbjHPP7P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 11:59:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A1B2711;
        Wed, 16 Aug 2023 08:58:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdc243d62bso31031335ad.3;
        Wed, 16 Aug 2023 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692201535; x=1692806335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OiDRKOFgpns5hcMj/5h29PmrGKgZp4X/9SUFpx9MBE=;
        b=SdqsGneBj3G1xPoWgDrAnZsMLGIJcGkhd0mTMNej6blVFuqGqAf1YMjQZ5J1Zta4hr
         RjRpVGUta1l2pWshLaxG1R6WxN4rXxyHrMP31LVs0uUYrgFIhAsV/hCy2rMYOWFcZn46
         oaCuRVyfkJZcqfaVrski3DVBS8PA8kWqAaniYxKS9ijLXj9cRerCDT9za4uSF/Fca8Ur
         g1oObQQX2D0hQARnh5xChYDCepfaUUv8hMrLFUNWtdY2V1bdh97qeA6w30x/bkZDRrUc
         LzIlwnDMhasI8KobGMFW3e2BZyrJOJ6RROQowk2AE26mfi9yVOaJ8ZvHwqLDoucjxbzy
         L97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692201535; x=1692806335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OiDRKOFgpns5hcMj/5h29PmrGKgZp4X/9SUFpx9MBE=;
        b=A9xOmAIPELv/A14Q9TEChPFqqhoZMEsB6zv/2wymzg26mWnEx8zHdMXRCBLpEe7s/I
         2vU2cJZwVQ2GAFd+irJuzkNVH+pYf3ko1hdjZtTXDlPBzkoLwBUKDPjmRaqLXoPSEvp0
         JWBN0lwIi5B56fVdX8aJOItW9iBqAaOs+PHosCp/KtVEQbyXRLb59t9n2Cjq/7YBVOW3
         IQfy4YQReLdfAKejYKxFMoDhqEmC+1zZpV9RURjDkfPJNmP8Y5pfkSF3bKHWMbbYRpdw
         0JMIxN+a/8qsroHYpIsKzDJe1SAlO2RSef8HfNH5V59MzQlSyDhFT5zwdlW+QeJflGDc
         GXzw==
X-Gm-Message-State: AOJu0YyJwUO1aZDhOdN8Pq8fwiprkKJBDlxSO3l96qERzZ4pLORfyhNx
        LEutdNSgGE4afPZdsvg01ec=
X-Google-Smtp-Source: AGHT+IGAEgApPQ+eN/CGqM/GObThdVRZoRaNbYAsVB4MNpIbAOfo2/VbqKxriRw/Uw/n9T4Iriqnmg==
X-Received: by 2002:a17:902:eccf:b0:1be:c879:6e71 with SMTP id a15-20020a170902eccf00b001bec8796e71mr2298635plh.63.1692201535104;
        Wed, 16 Aug 2023 08:58:55 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:e588:8d80:9ae5:5adc])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001bc930d4517sm13366973plw.42.2023.08.16.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:58:54 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v6 1/8] x86/hyperv: Add sev-snp enlightened guest static key
Date:   Wed, 16 Aug 2023 11:58:42 -0400
Message-Id: <20230816155850.1216996-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816155850.1216996-1-ltykernel@gmail.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Introduce static key isolation_type_en_snp for enlightened
sev-snp guest check.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/ivm.c           | 11 +++++++++++
 arch/x86/include/asm/mshyperv.h |  2 ++
 arch/x86/kernel/cpu/mshyperv.c  |  9 +++++++--
 drivers/hv/hv_common.c          |  6 ++++++
 include/asm-generic/mshyperv.h  | 13 ++++++++++---
 5 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 14f46ad2ca64..b2b5cb19fac9 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -413,3 +413,14 @@ bool hv_isolation_type_snp(void)
 {
 	return static_branch_unlikely(&isolation_type_snp);
 }
+
+DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
+/*
+ * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
+ * isolation enlightened VM.
+ */
+bool hv_isolation_type_en_snp(void)
+{
+	return static_branch_unlikely(&isolation_type_en_snp);
+}
+
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 88d9ef98e087..9f11f0495950 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -26,6 +26,7 @@
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
+DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -239,6 +240,7 @@ static inline void hv_vtom_init(void) {}
 #endif
 
 extern bool hv_isolation_type_snp(void);
+extern bool hv_isolation_type_en_snp(void);
 
 static inline bool hv_is_synic_reg(unsigned int reg)
 {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c7969e806c64..5398fb2f4d39 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -402,8 +402,12 @@ static void __init ms_hyperv_init_platform(void)
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
 
-		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
+
+		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+			static_branch_enable(&isolation_type_en_snp);
+		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
 			static_branch_enable(&isolation_type_snp);
+		}
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
@@ -473,7 +477,8 @@ static void __init ms_hyperv_init_platform(void)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	if ((hv_get_isolation_type() == HV_ISOLATION_TYPE_VBS) ||
-	    (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP))
+	    ((hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) &&
+	    ms_hyperv.paravisor_present))
 		hv_vtom_init();
 	/*
 	 * Setup the hook to get control post apic initialization.
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 542a1d53b303..4b4aa53c34c2 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -502,6 +502,12 @@ bool __weak hv_isolation_type_snp(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
 
+bool __weak hv_isolation_type_en_snp(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
+
 void __weak hv_setup_vmbus_handler(void (*handler)(void))
 {
 }
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 402a8c1c202d..580c766958de 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -36,15 +36,21 @@ struct ms_hyperv_info {
 	u32 nested_features;
 	u32 max_vp_index;
 	u32 max_lp_index;
-	u32 isolation_config_a;
+	union {
+		u32 isolation_config_a;
+		struct {
+			u32 paravisor_present : 1;
+			u32 reserved_a1 : 31;
+		};
+	};
 	union {
 		u32 isolation_config_b;
 		struct {
 			u32 cvm_type : 4;
-			u32 reserved1 : 1;
+			u32 reserved_b1 : 1;
 			u32 shared_gpa_boundary_active : 1;
 			u32 shared_gpa_boundary_bits : 6;
-			u32 reserved2 : 20;
+			u32 reserved_b2 : 20;
 		};
 	};
 	u64 shared_gpa_boundary;
@@ -58,6 +64,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 extern bool hv_isolation_type_snp(void);
+extern bool hv_isolation_type_en_snp(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
-- 
2.25.1

