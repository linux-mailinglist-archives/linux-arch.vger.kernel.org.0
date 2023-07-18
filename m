Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C15757225
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 05:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGRDXN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jul 2023 23:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGRDXN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jul 2023 23:23:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961F910D1;
        Mon, 17 Jul 2023 20:23:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-262fa79e97fso2527285a91.2;
        Mon, 17 Jul 2023 20:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689650591; x=1692242591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OH2nJxZTXPnwyWDhRKyI4KLZM7zBv8h2VCX3NFTe4M=;
        b=WicSNvr2SEHT5wggpdXQuAdZEuqxZHgUCz6kyls3VFj+KAT7nn/VLRqIacMxHjclhg
         9NI/u3peLuNPwgXIyI1aH0MbjKPrar9AMA2AIq7j9w7WXjY/ojt2iVyl/+Db0m0X3vtm
         Sm12160J7woPrs9gC6sZ0yAVty5iRk+kW07t30YJf4EMy4hPU55x4rqInXjvP5psTu+Q
         R7PM6S6DfDGBbt1xDmQKuZCs243Ma0kqYfwGx7OdhO3LIifxrOED9wVrAIaz/nKdasd1
         AvJpp/MCx5IarqXrWWpWuwETbbKgBkL7ix/Q3EncxqBOTXYyPoTk1GxPid1IO+WdZh5m
         nFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689650591; x=1692242591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OH2nJxZTXPnwyWDhRKyI4KLZM7zBv8h2VCX3NFTe4M=;
        b=d0Ii05NgVl6bf04m2xPLdUsfz0ag/YZnUKMvvg+vtXj44F9qFpdQYsDJUYVGcO1zbk
         /j3BtXjGzwpqK+/xyTShypVx/qNRdqLc4B+OEZmtitF2HDdPbVv4ChSWTtlXySiAoB/U
         4hciRoZt806uBDJ30cTm49QnnAKrO6+unx+B1NCXqDuoL745TTPqhx08AdSuTHb9uIbC
         3Mn84ll/R1F1ty9H0/P8g0wWUphKXLQsvdufKb65/XoBv6C13lwvaunhyhGf2o2ylaeu
         tW9eiUQ6JtEwkbVFVAWe8qLWjzQX7J7utoQdoe8mtxyqmJLNWzrkNgoekPCcWj5voDmO
         aTDA==
X-Gm-Message-State: ABy/qLaOxnl73JJI8dwpLztNnc7yiLnv3zGadAx4BKcOjIjq0DvOe0Hw
        BwUKUlDr1NuMNL0dolIlhe4=
X-Google-Smtp-Source: APBJJlGCA75xP+iIH6fNSxSODjnZe09v5MkNqSyfXojH/Y5/E6+JYaowBHJUxpTqzQhPoAjFee7ikg==
X-Received: by 2002:a17:90a:4144:b0:262:d6e9:208b with SMTP id m4-20020a17090a414400b00262d6e9208bmr9895592pjg.4.1689650590986;
        Mon, 17 Jul 2023 20:23:10 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id s92-20020a17090a2f6500b00263f41a655esm504040pjd.43.2023.07.17.20.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:23:10 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V3 1/9] x86/hyperv: Add sev-snp enlightened guest static key
Date:   Mon, 17 Jul 2023 23:22:55 -0400
Message-Id: <20230718032304.136888-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718032304.136888-1-ltykernel@gmail.com>
References: <20230718032304.136888-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 arch/x86/kernel/cpu/mshyperv.c  |  9 +++++++--
 drivers/hv/hv_common.c          |  6 ++++++
 include/asm-generic/mshyperv.h  | 12 +++++++++---
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
index 88d9ef98e087..2fa38e9f6207 100644
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
index 402a8c1c202d..6b5c41f90398 100644
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
-- 
2.25.1

