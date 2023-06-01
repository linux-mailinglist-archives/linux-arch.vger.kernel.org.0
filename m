Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5265371A239
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 17:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjFAPQi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjFAPQb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 11:16:31 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB44FB3;
        Thu,  1 Jun 2023 08:16:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53404873a19so506938a12.3;
        Thu, 01 Jun 2023 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632589; x=1688224589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFoufzo+VP+qK3F4DVr4gifzCbQzI56y6GSuWTORtz4=;
        b=j4bndIiPmBOelXmd3XgnLhCi5CCbbvEhNZtboa4HbAluJRA6HVSwiXKIUlcwwGEQPD
         TxMN+lplNB8EEhcVg0sh7XIqCocy1tiAojURjn27MPwoBO08DNrNz3RIpiPiAbJ9L/4n
         2lBFK2asVqMTzp+6ATM9ie/VmaCQfigd9KevmntLZsXgnweGcz230jUgrQxCjqnvQM5i
         z01XWeWFafIl5gBbNZNqobmb3u8ZLkN2nR7olNM8mBfKIR4skxUyRqvnL8Yr3YnLGZSP
         iy7uL8piDjp3hHFn79dyagYdp5pTVdU8BwtfcjmjXnUiN8m3DyutvKexYGhI/RGvQV4W
         x4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632589; x=1688224589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFoufzo+VP+qK3F4DVr4gifzCbQzI56y6GSuWTORtz4=;
        b=dMCSBatGUXctyhSmEJ8Jmq9SRuYJlo6k05/8CiJ+yN7Qio8ojl6rK5pH/Zfa9PJXnv
         sl6rgWYcW/dTTUYetVCJN6FvzIWW9XAj+QVlhALhLrCC06Y6sxVbA5RzHdt81MhJjCgR
         VH5zVV9U+ewhXotFeqA0wELiScaxG67UwsS3qf3gwnLNG2E4/ZRYdmgdF7c++sSnfDTU
         1X5jM4EVdH+/TFUseR+0FhukT/xTPuG+5j8UsRlX6jbEJ44bw6NnZOP9nJn4B98v5la2
         l4lpBXylz129KKBPE/ZuZG58pg1U6L4vc5uaXifQmJ5GVYQNGm3V7iqnEVhD53J6rvrF
         R84Q==
X-Gm-Message-State: AC+VfDwVVh6VgDU53zSsmVRPlDPTIHUgpF5ZPP10dSxgQl7GOfbdZf3o
        3HkrAlerxYvAcyA4HhJvTLp0AcNmZEwa0g==
X-Google-Smtp-Source: ACHHUZ7goeAfIw+yj8bAjDjpsO/UaLtQs7h3k/oV61k8SEgpBwoSLgdr6YL7gSqbVtZ0QYpjiIDC0A==
X-Received: by 2002:a05:6a21:998d:b0:10b:d70d:f96b with SMTP id ve13-20020a056a21998d00b0010bd70df96bmr8574802pzb.3.1685632589154;
        Thu, 01 Jun 2023 08:16:29 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:9:e0c3:5ec1:4a35:2168])
        by smtp.gmail.com with ESMTPSA id f3-20020a635543000000b0051b460fd90fsm3282639pgm.8.2023.06.01.08.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:16:28 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 1/9] x86/hyperv: Add sev-snp enlightened guest static key
Date:   Thu,  1 Jun 2023 11:16:14 -0400
Message-Id: <20230601151624.1757616-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601151624.1757616-1-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
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
 arch/x86/hyperv/ivm.c           | 11 +++++++++++
 arch/x86/include/asm/mshyperv.h |  3 +++
 arch/x86/kernel/cpu/mshyperv.c  |  8 ++++++--
 drivers/hv/hv_common.c          |  6 ++++++
 include/asm-generic/mshyperv.h  | 12 +++++++++---
 5 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index cc92388b7a99..5d3ee3124e00 100644
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
index 49bb4f2bd300..31c476f4e656 100644
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
index c7969e806c64..9186453251f7 100644
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
@@ -473,7 +477,7 @@ static void __init ms_hyperv_init_platform(void)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	if ((hv_get_isolation_type() == HV_ISOLATION_TYPE_VBS) ||
-	    (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP))
+	    ms_hyperv.paravisor_present)
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
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 402a8c1c202d..d444f831d633 100644
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
+			u32 reserved1 : 31;
+		};
+	};
 	union {
 		u32 isolation_config_b;
 		struct {
 			u32 cvm_type : 4;
-			u32 reserved1 : 1;
+			u32 reserved2 : 1;
 			u32 shared_gpa_boundary_active : 1;
 			u32 shared_gpa_boundary_bits : 6;
-			u32 reserved2 : 20;
+			u32 reserved3 : 20;
 		};
 	};
 	u64 shared_gpa_boundary;
-- 
2.25.1

