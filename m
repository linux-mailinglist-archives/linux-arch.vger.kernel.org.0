Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B88623506
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiKIUyT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiKIUyB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0665F21E19;
        Wed,  9 Nov 2022 12:54:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c2so18202254plz.11;
        Wed, 09 Nov 2022 12:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTm6TpUl+FGxnM+t+ZkzqsU9392mhy5cn6Qp9D3tMP0=;
        b=h1+vZPkZbQ/bjL443HD0aVzrIGtccqjKO6PVha/5F0zFnMdOm1OgoEp4f+cwnqHC2j
         ovkS9396b3D+nPDkAN3qyxuMJHoe6LZN1zHTx63ThFbjpkHxlbrb+9a2gAl9LMWYJox6
         TP2+k7Ou2tgqWNpu650zEXwrld5il4A/IlGDZqV+FB1WFfB0fz+tsLwaiiWSSBfD5T37
         OrTwS40CuOS5eiFa5P0RXZm92uO/NIjYoKBI92h3FebGEw5a2eZvgi+g/K4F4vKdJ+iB
         tT/t9dfAjfx4RfjppAuK3PU4krHvtxL/P04L06ZP7z7ya6199sYKujR6tbirl7G0Ugrw
         /iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTm6TpUl+FGxnM+t+ZkzqsU9392mhy5cn6Qp9D3tMP0=;
        b=YL9Yc4la97QG5LfbvATTC3fnSJzos2ARghJ/YBYfQCEOuuGVGwb08rat7OYuS/cJFy
         9TwgTEXDSWr/qb42qK7UbELdd5WPBjuFWTHZbRNIPEOTuGgxRvS3gHYef0MwbNv0bEB2
         VPy7fJuTsOH2feXBq45m70FKM0jHUJzcVfjnUMFMND7w+sKgH8uGmWj5tPl/iENGMi3C
         ktiYki9ST4B2mhSFYz+UiURGW9oog5DpQtRTaGJ74WiYL6JCqnX1OwRwSWeSeYjMAmx7
         axa570VYqzhq1FfuTFovzgeMeXh//GsI3zPkyQAnsbg3857RUjxiAxT8asyftm4cR5xb
         wzew==
X-Gm-Message-State: ACrzQf1YhoHmDwJaKyjtxliCT6OMZMVLPoM8aT8tFqMcKqybS19DTcjw
        Ow3/M36s8YQ+KnAv7sc2TeM=
X-Google-Smtp-Source: AMsMyM4UC7oTJE3Y9yPIYz6NxmO599TVXb4CKkWnUYLrzNdQLA1vzS6hWhEwUskFvfQVINEGEUyaNw==
X-Received: by 2002:a17:90a:6e4c:b0:213:2058:f456 with SMTP id s12-20020a17090a6e4c00b002132058f456mr64822073pjm.186.1668027240442;
        Wed, 09 Nov 2022 12:54:00 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:53:59 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH 03/17] x86/hyperv: Add sev-snp enlightened guest specific config
Date:   Wed,  9 Nov 2022 15:53:38 -0500
Message-Id: <20221109205353.984745-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109205353.984745-1-ltykernel@gmail.com>
References: <20221109205353.984745-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Introduce static key isolation_type_en_snp for enlightened
guest check and add some specific options in ms_hyperv_init_
platform().

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/ivm.c           | 12 +++++++++++-
 arch/x86/include/asm/mshyperv.h |  2 ++
 arch/x86/kernel/cpu/mshyperv.c  | 29 ++++++++++++++++++++++++-----
 drivers/hv/hv_common.c          |  7 +++++++
 4 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 1dbcbd9da74d..e9c30dad3419 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -259,10 +259,20 @@ bool hv_is_isolation_supported(void)
 }
 
 DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
+DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
+
+/*
+ * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
+ * isolation enlightened VM.
+ */
+bool hv_isolation_type_en_snp(void)
+{
+	return static_branch_unlikely(&isolation_type_en_snp);
+}
 
 /*
  * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
- * isolation VM.
+ * isolation VM with vTOM support.
  */
 bool hv_isolation_type_snp(void)
 {
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 61f0c206bff0..9b8c3f638845 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -14,6 +14,7 @@
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
+DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -32,6 +33,7 @@ extern u64 hv_current_partition_id;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
+extern bool hv_isolation_type_en_snp(void);
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 831613959a92..2ea4f21c6172 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -273,6 +273,21 @@ static void __init ms_hyperv_init_platform(void)
 	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
 
+	/*
+	 * Add custom configuration for SEV-SNP Enlightened guest
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+		ms_hyperv.features |= HV_ACCESS_FREQUENCY_MSRS;
+		ms_hyperv.misc_features |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
+		ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
+		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
+		ms_hyperv.hints |= HV_X64_APIC_ACCESS_RECOMMENDED;
+		ms_hyperv.hints |= HV_X64_CLUSTER_IPI_RECOMMENDED;
+	}
+
+	pr_info("Hyper-V: enlightment features 0x%x, hints 0x%x, misc 0x%x\n",
+		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
+
 	hv_max_functions_eax = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
 
 	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
@@ -328,18 +343,22 @@ static void __init ms_hyperv_init_platform(void)
 		ms_hyperv.shared_gpa_boundary =
 			BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
 
-		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
-			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
-
-		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
+		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+			static_branch_enable(&isolation_type_en_snp);
+		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
 			static_branch_enable(&isolation_type_snp);
 #ifdef CONFIG_SWIOTLB
 			swiotlb_unencrypted_base = ms_hyperv.shared_gpa_boundary;
 #endif
 		}
+
+		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
+			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
+
 		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
 		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
+			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE
+			    && !cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 				cc_set_vendor(CC_VENDOR_HYPERV);
 		}
 	}
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index ae68298c0dca..2c6602571c47 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -268,6 +268,13 @@ bool __weak hv_isolation_type_snp(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
 
+bool __weak hv_isolation_type_en_snp(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
+
+
 void __weak hv_setup_vmbus_handler(void (*handler)(void))
 {
 }
-- 
2.25.1

