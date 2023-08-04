Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F306770451
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 17:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjHDPXC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjHDPXA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 11:23:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60AF49EC;
        Fri,  4 Aug 2023 08:22:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bb7b8390e8so15855985ad.2;
        Fri, 04 Aug 2023 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691162578; x=1691767378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWip1yjzsAQRFOrEvjB5JNgb3BedXz/Vnpj8L+NzZSc=;
        b=SfKg0TdOwJDkmDL+yjgnKoH8G1QunwUxbpJplWgqhcOMKtaH5NaOAzIW9XTfvmK+qB
         /w3d4bDGZ60v2bJXHaEwCK95a0ex/Eva5Y8BCL75FsdldwLtVWPG8i6kO+0Djve1Z7kc
         5rkr7Sd1Q1pdUb4+hSnDXYuJzOKfJ1OMfdTkbAgMQMpLFjKnbarrPY6PycR7glwc1xu2
         eyc+m2xT9e7agifIWAZK4J2Xo6hssxH06lpue9rN9/8TKRLz+CjjK6SLDa5TshvkYJFG
         Qd2uu8lLKsVjQccVnufquDsbqwBRl9FjIVK1objIATObiLStJUaKTBpgFs+zVSldaosl
         aH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162578; x=1691767378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWip1yjzsAQRFOrEvjB5JNgb3BedXz/Vnpj8L+NzZSc=;
        b=XOZrUxK31C2gAf+4I69gCoeuEYepGcr4tZAWJA/p8CNiOpSp32p+bLg3+ILvqHC+2q
         JrNzKgf9nZN+NoCSle0yWOCzXI5c3h68PGE1iOC3UeSmlrPQ6bChjh+f6g+oq6zQchde
         XzHxUmIXHdNZiIK+/qGANkOWwKgUS2AaisHGcv+r8XWOiPOtYdsiwmrBt5UtABCCmZju
         XLxeoaqauf+0WN+UDV1yS1YnKzaerEyZznQG1cZF+53bhazdu9EoyWsNU6KRUz0MTexs
         X5tqC0f6+5lAbyQEfNStH2CsC6zyaR/uV17LMV0lm8EtPN1c342g5QIS6bg/gs5O2nTb
         Nt4w==
X-Gm-Message-State: AOJu0Yx1PiPH5tgF9MoHSWAGFDyGfKE5S0MbWDlqciF0g/Wdi/ndZdP2
        IIYl2qSNkGOjciH3/Tpjnik=
X-Google-Smtp-Source: AGHT+IHbTpCuO+G5laQqXk51nHZ56NfgEkaOVYifubabOZ10AOLmnnBeoTvBL6oCaPzHR4qUcho1Ig==
X-Received: by 2002:a17:902:a711:b0:1b8:72b2:fd3b with SMTP id w17-20020a170902a71100b001b872b2fd3bmr1608076plq.54.1691162578087;
        Fri, 04 Aug 2023 08:22:58 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:a0bf:7946:90be:721b])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902989500b001aaf2e8b1eesm1891325plp.248.2023.08.04.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:22:57 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V4 1/9] x86/hyperv: Add sev-snp enlightened guest static key
Date:   Fri,  4 Aug 2023 11:22:45 -0400
Message-Id: <20230804152254.686317-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804152254.686317-1-ltykernel@gmail.com>
References: <20230804152254.686317-1-ltykernel@gmail.com>
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

