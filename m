Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD21676AA9
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjAVCqQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjAVCqP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:46:15 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0C01DBB6;
        Sat, 21 Jan 2023 18:46:13 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 207so6565101pfv.5;
        Sat, 21 Jan 2023 18:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnMOwh1aaG72cY9v6pTmJyXRUzMRdcZVVSSO8Ajg0yo=;
        b=FQ3sW+3iS7GYYQEkCf5a/r3NDEp3gPy7T8saFKhEb2tXnD+h994YomEHYGYXawDzrL
         nXJ9hicOApE0AJJppKLg0GuyC1ymhvtoQSPKQQyX82hpYYMqNGfq7mE4WEu69ShLJw2F
         0hK8mhDtw10qMaHU+KYvdhUr2kcA4MSvZPll03ZpptoNGLbGy8lSZh0HwTSvPqJzj4dF
         +BgpWYihPncFDGhUeobzc3NQrBUp+q5beBHuRicbQlKXlk12qd2/WluLo8CNKNrZphH2
         ZUXl19NMMc2hCnHTNN1lB2IHTg8usgpeka0yt788gpRgd9m+5Fec4RBXkr9kfFmu6kz1
         2omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnMOwh1aaG72cY9v6pTmJyXRUzMRdcZVVSSO8Ajg0yo=;
        b=zc2UlSCeYgklmeXkxJ7XhafP24PpvzwssxrRzawfFP1V4pIwDYOzTPR1bU95I9n7cm
         CggB3uE25MPdofBar64bitxKKf7MUnom/pfEDmj1Qw3wBLt/M/B5szLamgZvZxNC5Leu
         g9guoWmGTPXViAE37PcMVWUixPFwOZSXPGr+FcIFkFbNldp2FFcaGCpcALOA6yvI7QYt
         Nz3YM3W3jH8BBVk8wmiSn6lL2pnk4b1qWksDPil1x7SyLIVTj77urmtyqEHiCcVJJvyV
         EGuCxRLvtAjOGa/kd3HVk37TIeq8VUf7x6ykkfKGitU4DehFql2XK3Wj3mJ1tc6rxCEY
         FUdQ==
X-Gm-Message-State: AFqh2kohZ93jhGI3Y+AtG1Ga3FCncZyYXqzcAtv7V41hFvSwj3QrWZAz
        d0I7V6VCNg3Ext5PQkBLCo0=
X-Google-Smtp-Source: AMrXdXt5B+SQx0uDJ6a6sa7NLc7FmMWqUKla0LOC4gIATGo3yNnCZNwXzVdegW5IM9lXwjvzBBlFoA==
X-Received: by 2002:a62:384e:0:b0:58b:c66e:1ca8 with SMTP id f75-20020a62384e000000b0058bc66e1ca8mr20006146pfa.11.1674355573052;
        Sat, 21 Jan 2023 18:46:13 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:12 -0800 (PST)
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
Subject: [RFC PATCH V3 01/16] x86/hyperv: Add sev-snp enlightened guest specific config
Date:   Sat, 21 Jan 2023 21:45:51 -0500
Message-Id: <20230122024607.788454-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230122024607.788454-1-ltykernel@gmail.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
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
 arch/x86/hyperv/ivm.c           | 10 ++++++++++
 arch/x86/include/asm/mshyperv.h |  3 +++
 arch/x86/kernel/cpu/mshyperv.c  | 16 +++++++++++++++-
 drivers/hv/hv_common.c          |  6 ++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index abca9431d068..8c5dd8e4eb1e 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -386,6 +386,16 @@ bool hv_is_isolation_supported(void)
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
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 010768d40155..285df71150e4 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -14,6 +14,7 @@
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
+DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -28,6 +29,8 @@ extern void *hv_hypercall_pg;
 
 extern u64 hv_current_partition_id;
 
+extern bool hv_isolation_type_en_snp(void);
+
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 8f83ceec45dc..ace5901ba0fc 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -273,6 +273,18 @@ static void __init ms_hyperv_init_platform(void)
 
 	hv_max_functions_eax = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
 
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
 	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
 		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
 		ms_hyperv.misc_features);
@@ -331,7 +343,9 @@ static void __init ms_hyperv_init_platform(void)
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
 
-		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
+		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+			static_branch_enable(&isolation_type_en_snp);
+		else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
 			static_branch_enable(&isolation_type_snp);
 	}
 
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 566735f35c28..f788c64de0bd 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -268,6 +268,12 @@ bool __weak hv_isolation_type_snp(void)
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

