Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0033273F2A6
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjF0D2w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjF0D2S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:28:18 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A3D2106;
        Mon, 26 Jun 2023 20:22:54 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b74faaac3bso1294473a34.1;
        Mon, 26 Jun 2023 20:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687836173; x=1690428173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE11yTMAExZ2ZoYVCcn2Tq5He2Vs69778pFMKMEukgk=;
        b=L/IebApgWhFXHgPqF3us42fzqDADcFJR4vXUnyhDeL+wsoamYd/aEpG2bPbCG1XevS
         fraPdupxXbgIchbLfBM00pEIOjfm84OFptvDPRrLcSJtNOatnAJqnXKWF213wICpwa4F
         XD9mK4KbsvwY3v5nthP1o84FxOS9aS9vt/mIZaxDDcsMWhm4GBxUmYrWm/3TW97zQ6/M
         lA06WcxUQtIseHh/WjUjwvtE6iXBWs5w0oTPHCQXLlRIwmVdp984G+RUxhEZQgBc2qus
         qSlCmdCmLr7ZV5tDFgQU0EERQXKBW4O6Ss+agZJ36A7vObM6IPd4NwmYv6yrGNDUp5bN
         M1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687836173; x=1690428173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PE11yTMAExZ2ZoYVCcn2Tq5He2Vs69778pFMKMEukgk=;
        b=fWR/nWxqQI6DY3iTxh1NiaJB9hKA3jKOnhkDdG9igoCLMwm/jLSf9vHXBfWMkOa/KW
         0fANLvKHIF7h6lxkiqYiT8QFiv7TDvx1NiWFW+6/Yt+2N6FLnaQiWo20zf83jQzkBt1p
         svoWgJ/HocaYgzHLxe4abkAWQCTqjZLSlqeTTiSz5psOfSR8q0g4zJYKHw93Pn3X0+hU
         tdqGW+b1HflGomLWKCZW+Q8C3YOPsrEBMZ59vlZ2ZfheTScA/hRsN10kNIpVo+21yrIr
         u0SnynbI1gpHyJHFeF8GHyDWF4YfcccXYel2K1hQXM9iH7b2sFHS5D94OwOBIPPOUClV
         bhzw==
X-Gm-Message-State: AC+VfDwBWTjACfReW83vG6ycY3WKlGOZA/Kt1C181fV6R6/56jn6slHu
        7VeeCA2GzdEghxcxTYhJnZo=
X-Google-Smtp-Source: ACHHUZ79+MrhScxTTNGAmqrE/xOgycwWaeRWadcQYj3WROzVjuuQ9Yk4HBBqB4EzDr8QBu1G/sBHuA==
X-Received: by 2002:a05:6808:2022:b0:3a1:b47d:9296 with SMTP id q34-20020a056808202200b003a1b47d9296mr13366617oiw.17.1687836173245;
        Mon, 26 Jun 2023 20:22:53 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id mm12-20020a17090b358c00b0025ec54be16asm618756pjb.2.2023.06.26.20.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:22:52 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 1/9] x86/hyperv: Add sev-snp enlightened guest static key
Date:   Mon, 26 Jun 2023 23:22:39 -0400
Message-Id: <20230627032248.2170007-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627032248.2170007-1-ltykernel@gmail.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
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
 arch/x86/kernel/cpu/mshyperv.c  |  9 +++++++--
 drivers/hv/hv_common.c          |  6 ++++++
 include/asm-generic/mshyperv.h  | 12 +++++++++---
 5 files changed, 36 insertions(+), 5 deletions(-)

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

