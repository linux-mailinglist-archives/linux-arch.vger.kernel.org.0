Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13265703593
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 19:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbjEORAE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 13:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243313AbjEOQ7r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 12:59:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC37DB3;
        Mon, 15 May 2023 09:59:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53063897412so5658778a12.0;
        Mon, 15 May 2023 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169972; x=1686761972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Udm3eUyVQh3+nWxooTJ9GWCwKBxGdrkWeoFcDQJr1CA=;
        b=j/gJTub3WT+Foh2oK+Hko0G9Khx0/+vYADnKziVUjccvf5NxD6O7P1qKdcEzO8w7RC
         IzaoSdmSz0Yyz8IEaWXbsodswJrWCpGIa6etcSJQj0QHTqIz7dZEP7ula9eJFLg6fBOC
         +yzxGTNMWwfF+fo6pHz2AusZ9Y1QS4XO704ZXGU3aSTpRRNWsjfPnc4Uqp25QZmiy0Y+
         mSUnanOlh8TQHuh5PzD2vSRD1wqcwvsxo/7X3F6UbuqZUfcT86+MfXbrwKD6VfLvz/cH
         HQaX6X8e2FZ4OpRLFFGu/2TmUv/XLXRF6AaACVjS521OpKl0SYS8N29KCoi2yvQAJXA5
         o92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169972; x=1686761972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Udm3eUyVQh3+nWxooTJ9GWCwKBxGdrkWeoFcDQJr1CA=;
        b=ex1dmTCYHg0LTNB0p68ZrOheNW4amj6F3bwVtUI0Tzi/ggQiu6/aT9Dzku1he4VD+e
         h1l8Mqxhq1vre7/bcYJyid+SVCqoUzM7Qq1n22zX3p7Ico+LWa0vNue9lKnVbHFkGOjm
         09fsDcCGbGCaSoKZASKP03qrCai5h+pR7m1zQK4VYq6OKMfLqATixtEoyN6XTLc7BXUF
         pze1AuCNB3MnDqaIRfwAhgueFlab5Hfo/75I5fmQKLHpewDBWtxwtmzsNPDKcVsmcmZ5
         zsXyxvERGPJ/VHnhF5rtXeJH4kecXIVkC9WCfmnyDjq2GDh8i59c9wbRtdr53X1gpB0S
         NyXA==
X-Gm-Message-State: AC+VfDxFsLii2wUiWxneA72w+Obycu7IqzslrhiUzWfJIkq54T318Avv
        pfAa9V2PxwQi1MQhg/LfHOc=
X-Google-Smtp-Source: ACHHUZ4g2M85AFC6YrmyN2QnhkZ5GDP+O4YYm0papKhHRwH45XKLuqqcN7oTtSkUSHJHhRR5GjOqTQ==
X-Received: by 2002:a17:90b:1d0d:b0:24d:ea7f:9ea2 with SMTP id on13-20020a17090b1d0d00b0024dea7f9ea2mr35127191pjb.15.1684169972086;
        Mon, 15 May 2023 09:59:32 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:85bb:dfc8:391f:ff73])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b0024df6bbf5d8sm2151pjp.30.2023.05.15.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:59:31 -0700 (PDT)
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
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH V6 05/14] x86/hyperv: Add sev-snp enlightened guest static key
Date:   Mon, 15 May 2023 12:59:07 -0400
Message-Id: <20230515165917.1306922-6-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515165917.1306922-1-ltykernel@gmail.com>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Introduce static key isolation_type_en_snp for enlightened
sev-snp guest check.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC-v3:
	* Remove some Hyper-V specific config setting
---
 arch/x86/hyperv/ivm.c           | 11 +++++++++++
 arch/x86/include/asm/mshyperv.h |  3 +++
 arch/x86/kernel/cpu/mshyperv.c  |  9 +++++++--
 drivers/hv/hv_common.c          |  6 ++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 127d5b7b63de..368b2731950e 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -409,3 +409,14 @@ bool hv_isolation_type_snp(void)
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
index b445e252aa83..97d117ec95c4 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -26,6 +26,7 @@
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
+DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -45,6 +46,8 @@ extern void *hv_hypercall_pg;
 
 extern u64 hv_current_partition_id;
 
+extern bool hv_isolation_type_en_snp(void);
+
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c7969e806c64..63a2bfbfe701 100644
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
+	    (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP
+	     && !cc_platform_has(CC_ATTR_GUEST_SEV_SNP)))
 		hv_vtom_init();
 	/*
 	 * Setup the hook to get control post apic initialization.
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 64f9ceca887b..179bc5f5bf52 100644
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
-- 
2.25.1

