Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4DB761CEF
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 17:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjGYPIe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 11:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGYPIb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 11:08:31 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E413D1BFA;
        Tue, 25 Jul 2023 08:08:29 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-557790487feso3979142a12.0;
        Tue, 25 Jul 2023 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690297709; x=1690902509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A5OgM9etxUxFgb7BTFPkiqJUQluCx/GIh5RjpmFfT6A=;
        b=XhnNnPOV0DXXFUCxWetz8MN0t2zARGKofboU+xjcjOjWOkUGvgI10wvCaeajkSJ4LT
         by8Ma5zDt7H1NcMqW9VSK0hYkin9nbSSF/kICkaCITpwlVW6+u5cMEyVG0RP1Cb4HC3O
         YWe4J1XXMmtM3nPQVa5IowyA/6wzV4NeUhtPNXwQutBg6lHxVQUOSuNKYlletk8Izuet
         SuBT4d6wWnG1ditCNwZexRGRqGph+ZnC35jkoRgFwKiDLPUJYWeA7rE8vJ8FQrAEWmjy
         9eMUkIFOmrzVB/ysTxzRv2h5JVr8Pz72+2ITsOr7iUQeEY5zGKq0gKo2xMijZ1PNoJYL
         CjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690297709; x=1690902509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5OgM9etxUxFgb7BTFPkiqJUQluCx/GIh5RjpmFfT6A=;
        b=gUPqmCkBf14vRJWoslgNYAPvsSFnh6D30F4YQyvoMYCv8Nvo5oWA+Iq+3JlieoCeNT
         QwH5fyZNPerhM2cvnJAU+KFEfKXr4gsRF9lAcZyb2svSDzP7oWnd8iGAo9c5EIA/rQ3l
         QY79LTiZJXI18/FQUokZoRAV9EfIs1ZIi3DEhFETHzysdP8890I3XhupbZTHT3e01o2c
         FFyzZMRo17VWbBrm0fgzAsXtk6TGHLaN6657/KdOZSidHap9yHHR3pLHZIDPKhApUA7R
         OEt1d+bLcqsu+e/FQ9AIJb3f5vtH+NlzKROv/LdoBK2QqaFMjhaiQHKO64NGA8Xd85dE
         POHw==
X-Gm-Message-State: ABy/qLak3qpyIF3960wixRquzXTlFgApw3eBSfQ0pefmNvlNDd8qnBjz
        PUrZ4ajLHPNC5c8LdFUl82o=
X-Google-Smtp-Source: APBJJlGHabjNhnWubbmwT+53hTnCOqVu3bYCuzhOG9wKCddoWkB+Mj6V674Gkv1HLW72wXwR6ORe+w==
X-Received: by 2002:a17:90a:d98f:b0:268:2f2:cc89 with SMTP id d15-20020a17090ad98f00b0026802f2cc89mr8840324pjv.4.1690297708537;
        Tue, 25 Jul 2023 08:08:28 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:1:c61f:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id mr24-20020a17090b239800b00267fe43f518sm4868080pjb.23.2023.07.25.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:08:28 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de,
        kirill.shutemov@linux.intel.com, rppt@kernel.org, nikunj@amd.com,
        thomas.lendacky@amd.com, liam.merwick@oracle.com,
        alexandr.lobakin@intel.com, michael.roth@amd.com,
        tiala@microsoft.com, pasha.tatashin@soleen.com,
        peterz@infradead.org, jpoimboe@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
Subject: [PATCH] x86/hyperv: Rename hv_isolation_type_snp/en_snp() to isol_type_snp_paravisor/enlightened()
Date:   Tue, 25 Jul 2023 11:08:25 -0400
Message-Id: <20230725150825.283891-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Rename hv_isolation_type_snp and hv_isolation_type_en_snp()
to make them much intuitiver.

Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
This patch is based on the patchset "x86/hyperv: Add AMD sev-snp
enlightened guest support on hyperv" https://lore.kernel.org/lkml/
20230718032304.136888-3-ltykernel@gmail.com/T/.

 arch/x86/hyperv/hv_init.c       |  6 +++---
 arch/x86/hyperv/ivm.c           | 17 +++++++++--------
 arch/x86/include/asm/mshyperv.h |  8 ++++----
 arch/x86/kernel/cpu/mshyperv.c  | 12 ++++++------
 drivers/hv/connection.c         |  2 +-
 drivers/hv/hv.c                 | 16 ++++++++--------
 drivers/hv/hv_common.c          | 10 +++++-----
 include/asm-generic/mshyperv.h  |  4 ++--
 8 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b004370d3b01..49054dc30604 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -52,7 +52,7 @@ static int hyperv_init_ghcb(void)
 	void *ghcb_va;
 	void **ghcb_base;
 
-	if (!hv_isolation_type_snp())
+	if (!isol_type_snp_paravisor())
 		return 0;
 
 	if (!hv_ghcb_pg)
@@ -116,7 +116,7 @@ static int hv_cpu_init(unsigned int cpu)
 			 * is blocked to run in Confidential VM. So only decrypt assist
 			 * page in non-root partition here.
 			 */
-			if (*hvp && hv_isolation_type_en_snp()) {
+			if (*hvp && isol_type_snp_enlightened()) {
 				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
 				memset(*hvp, 0, PAGE_SIZE);
 			}
@@ -453,7 +453,7 @@ void __init hyperv_init(void)
 		goto common_free;
 	}
 
-	if (hv_isolation_type_snp()) {
+	if (isol_type_snp_paravisor()) {
 		/* Negotiate GHCB Version. */
 		if (!hv_ghcb_negotiate_protocol())
 			hv_ghcb_terminate(SEV_TERM_SET_GEN,
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 2eda4e69849d..2911c2525ed5 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -591,24 +591,25 @@ bool hv_is_isolation_supported(void)
 	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
 }
 
-DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
+DEFINE_STATIC_KEY_FALSE(isol_type_snp_paravisor_flag);
 
 /*
- * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
+ * isol_type_snp_paravisor - Check system runs in the AMD SEV-SNP based
  * isolation VM.
  */
-bool hv_isolation_type_snp(void)
+bool isol_type_snp_paravisor(void)
 {
-	return static_branch_unlikely(&isolation_type_snp);
+	return static_branch_unlikely(&isol_type_snp_paravisor_flag);
 }
 
-DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
+DEFINE_STATIC_KEY_FALSE(isol_type_snp_enlightened_flag);
+
 /*
- * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
+ * isol_type_snp_enlightened - Check system runs in the AMD SEV-SNP based
  * isolation enlightened VM.
  */
-bool hv_isolation_type_en_snp(void)
+bool isol_type_snp_enlightened(void)
 {
-	return static_branch_unlikely(&isolation_type_en_snp);
+	return static_branch_unlikely(&isol_type_snp_enlightened_flag);
 }
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index c5a3c29fad01..51eb239d71dd 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -25,8 +25,8 @@
 
 union hv_ghcb;
 
-DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
-DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
+DECLARE_STATIC_KEY_FALSE(isol_type_snp_paravisor_flag);
+DECLARE_STATIC_KEY_FALSE(isol_type_snp_enlightened_flag);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -46,7 +46,7 @@ extern void *hv_hypercall_pg;
 
 extern u64 hv_current_partition_id;
 
-extern bool hv_isolation_type_en_snp(void);
+extern bool isol_type_snp_enlightened(void);
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
@@ -268,7 +268,7 @@ static inline void hv_sev_init_mem_and_cpu(void) {}
 static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
 #endif
 
-extern bool hv_isolation_type_snp(void);
+extern bool isol_type_snp_paravisor(void);
 
 static inline bool hv_is_synic_reg(unsigned int reg)
 {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 6ff0b60d30f9..d9dcee48099c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -66,7 +66,7 @@ u64 hv_get_non_nested_register(unsigned int reg)
 {
 	u64 value;
 
-	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
+	if (hv_is_synic_reg(reg) && isol_type_snp_paravisor())
 		hv_ghcb_msr_read(reg, &value);
 	else
 		rdmsrl(reg, value);
@@ -76,7 +76,7 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_register);
 
 void hv_set_non_nested_register(unsigned int reg, u64 value)
 {
-	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
+	if (hv_is_synic_reg(reg) && isol_type_snp_paravisor()) {
 		hv_ghcb_msr_write(reg, value);
 
 		/* Write proxy bit via wrmsl instruction */
@@ -300,7 +300,7 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
 	 *  enlightened guest.
 	 */
-	if (hv_isolation_type_en_snp())
+	if (isol_type_snp_enlightened())
 		apic->wakeup_secondary_cpu_64 = hv_snp_boot_ap;
 
 	if (!hv_root_partition)
@@ -421,9 +421,9 @@ static void __init ms_hyperv_init_platform(void)
 
 
 		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
-			static_branch_enable(&isolation_type_en_snp);
+			static_branch_enable(&isol_type_snp_enlightened_flag);
 		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
-			static_branch_enable(&isolation_type_snp);
+			static_branch_enable(&isol_type_snp_paravisor_flag);
 		}
 	}
 
@@ -545,7 +545,7 @@ static void __init ms_hyperv_init_platform(void)
 	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
 		mark_tsc_unstable("running on Hyper-V");
 
-	if (hv_isolation_type_en_snp())
+	if (isol_type_snp_enlightened())
 		hv_sev_init_mem_and_cpu();
 
 	hardlockup_detector_disable();
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 02b54f85dc60..8659d18a55fe 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -484,7 +484,7 @@ void vmbus_set_event(struct vmbus_channel *channel)
 
 	++channel->sig_events;
 
-	if (hv_isolation_type_snp())
+	if (isol_type_snp_paravisor())
 		hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT, &channel->sig_event,
 				NULL, sizeof(channel->sig_event));
 	else
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index ec6e35a0d9bf..7651d79205da 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -64,7 +64,7 @@ int hv_post_message(union hv_connection_id connection_id,
 	aligned_msg->payload_size = payload_size;
 	memcpy((void *)aligned_msg->payload, payload, payload_size);
 
-	if (hv_isolation_type_snp())
+	if (isol_type_snp_paravisor())
 		status = hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
 				(void *)aligned_msg, NULL,
 				sizeof(*aligned_msg));
@@ -109,7 +109,7 @@ int hv_synic_alloc(void)
 		 * Synic message and event pages are allocated by paravisor.
 		 * Skip these pages allocation here.
 		 */
-		if (!hv_isolation_type_snp() && !hv_root_partition) {
+		if (!isol_type_snp_paravisor() && !hv_root_partition) {
 			hv_cpu->synic_message_page =
 				(void *)get_zeroed_page(GFP_ATOMIC);
 			if (hv_cpu->synic_message_page == NULL) {
@@ -125,7 +125,7 @@ int hv_synic_alloc(void)
 			}
 		}
 
-		if (hv_isolation_type_en_snp()) {
+		if (isol_type_snp_enlightened()) {
 			ret = set_memory_decrypted((unsigned long)
 				hv_cpu->synic_message_page, 1);
 			if (ret) {
@@ -174,7 +174,7 @@ void hv_synic_free(void)
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		/* It's better to leak the page if the encryption fails. */
-		if (hv_isolation_type_en_snp()) {
+		if (isol_type_snp_enlightened()) {
 			if (hv_cpu->synic_message_page) {
 				ret = set_memory_encrypted((unsigned long)
 					hv_cpu->synic_message_page, 1);
@@ -221,7 +221,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
 	simp.simp_enabled = 1;
 
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (isol_type_snp_paravisor() || hv_root_partition) {
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
@@ -240,7 +240,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 1;
 
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (isol_type_snp_paravisor() || hv_root_partition) {
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
@@ -323,7 +323,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	 * addresses.
 	 */
 	simp.simp_enabled = 0;
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (isol_type_snp_paravisor() || hv_root_partition) {
 		iounmap(hv_cpu->synic_message_page);
 		hv_cpu->synic_message_page = NULL;
 	} else {
@@ -335,7 +335,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 0;
 
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (isol_type_snp_paravisor() || hv_root_partition) {
 		iounmap(hv_cpu->synic_event_page);
 		hv_cpu->synic_event_page = NULL;
 	} else {
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 2d43ba2bc925..527e91409ef7 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -381,7 +381,7 @@ int hv_common_cpu_init(unsigned int cpu)
 			*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
 		}
 
-		if (hv_isolation_type_en_snp()) {
+		if (isol_type_snp_enlightened()) {
 			ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
 			if (ret) {
 				kfree(*inputarg);
@@ -509,17 +509,17 @@ bool __weak hv_is_isolation_supported(void)
 }
 EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
 
-bool __weak hv_isolation_type_snp(void)
+bool __weak isol_type_snp_paravisor(void)
 {
 	return false;
 }
-EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
+EXPORT_SYMBOL_GPL(isol_type_snp_paravisor);
 
-bool __weak hv_isolation_type_en_snp(void)
+bool __weak isol_type_snp_enlightened(void)
 {
 	return false;
 }
-EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
+EXPORT_SYMBOL_GPL(isol_type_snp_enlightened);
 
 void __weak hv_setup_vmbus_handler(void (*handler)(void))
 {
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index f73a044ecaa7..d60a9306c0cc 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -64,7 +64,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
 
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
-extern bool hv_isolation_type_snp(void);
+extern bool isol_type_snp_paravisor(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
@@ -279,7 +279,7 @@ bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
 enum hv_isolation_type hv_get_isolation_type(void);
 bool hv_is_isolation_supported(void);
-bool hv_isolation_type_snp(void);
+bool isol_type_snp_paravisor(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
-- 
2.25.1

