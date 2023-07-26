Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F51F7636B8
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jul 2023 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGZMuF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jul 2023 08:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGZMuE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jul 2023 08:50:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8B1269A;
        Wed, 26 Jul 2023 05:49:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bba54f7eefso6193645ad.1;
        Wed, 26 Jul 2023 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690375743; x=1690980543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5zO22kYApuVh7yTbUSWrRw2xPDNgzGXx9Rkf6A4Dng=;
        b=nmoBxj08P78rTWITwLmR6rtVOxGbFVQOKLFw3YRlJWrbP2vU0/JgbD/icXI+1y1hqv
         hYataTDQLl+2IqhjldoKxykDi7lm99L56WJDiZkm1Vl1q2tWELVFvP/Onzs/GWSJO/uA
         ijCjIzPgBvvE6FYJoJz4KxkvSTCw9ADv5GsrPUkkic/e6B3ZL42g2h6D9y2xCmtSpSG0
         chvxr3qx0NcnaosMt1mOdlPJ2PUJVWYxDYuamnuQ6VWhmMRZpbprN7Ge+dX8S+FQd4ny
         fDkECk3gRH0Z90GVNPwLrBPoDbnED/PZTW4R+aTrzZiT/A5XAx9mkQVElSlbQSxH8u69
         QWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690375743; x=1690980543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5zO22kYApuVh7yTbUSWrRw2xPDNgzGXx9Rkf6A4Dng=;
        b=cHCcvc25m1RqAQ8gPOXyiDbn+MQiXJWED6mMhNGifBv0hHg+of4VBaaQJ7U6RBIVEA
         5ohhTi2hHfH4TzT+AVEUt9U/D5ow4h0vs5pqJSg67XQaZyT3M7HRj9jCXPy2DlGBK7mE
         q3Jw8qfdopZc+MUKggwCDvyQTBGgfk9NPb+YDiLs9/yvNu1amaGeRIXa9EKjZz5b0DgH
         eLa3dZk1btfnWEB3qgb9LM7hu6PmBwYp4UdETRuHaYmHVhrLAlzFq/E/lwGhbJ/kOFUP
         WfuW6/Ci0WFkpw1rMjYHeSVtMfwSwfcVAjncSUqyY4vfxmIPq0Js6hJnzhldLiQsNgTw
         c+Og==
X-Gm-Message-State: ABy/qLYxBGdgUnTIG7e1MHWCMXJ61xpXjSbXnlBEmhM2mDsR3BmHvlvd
        41/cm5Kc0glRuWvQeAMXdjg=
X-Google-Smtp-Source: APBJJlG/3TU6Gbj3j7EauF0TpCQP1E1UTkKXsvWJ+/6V2grTzkYXmRMV+On9r+9dR32B1qte4yYlOQ==
X-Received: by 2002:a17:902:d4c9:b0:1b8:656f:76e7 with SMTP id o9-20020a170902d4c900b001b8656f76e7mr2619038plg.23.1690375743008;
        Wed, 26 Jul 2023 05:49:03 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:3:c61d:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c10100b001bba7aab822sm5951176pli.5.2023.07.26.05.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:49:02 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2] x86/hyperv: Rename hv_isolation_type_snp/en_snp() to isol_type_snp_paravisor/enlightened()
Date:   Wed, 26 Jul 2023 08:49:00 -0400
Message-Id: <20230726124900.300258-1-ltykernel@gmail.com>
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

Change since v1:
       Add "hv_" prefix to isol_type_snp_paravisor/enlightened()
---
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
index b004370d3b01..3df948c69cff 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -52,7 +52,7 @@ static int hyperv_init_ghcb(void)
 	void *ghcb_va;
 	void **ghcb_base;
 
-	if (!hv_isolation_type_snp())
+	if (!hv_isol_type_snp_paravisor())
 		return 0;
 
 	if (!hv_ghcb_pg)
@@ -116,7 +116,7 @@ static int hv_cpu_init(unsigned int cpu)
 			 * is blocked to run in Confidential VM. So only decrypt assist
 			 * page in non-root partition here.
 			 */
-			if (*hvp && hv_isolation_type_en_snp()) {
+			if (*hvp && hv_isol_type_snp_enlightened()) {
 				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
 				memset(*hvp, 0, PAGE_SIZE);
 			}
@@ -453,7 +453,7 @@ void __init hyperv_init(void)
 		goto common_free;
 	}
 
-	if (hv_isolation_type_snp()) {
+	if (hv_isol_type_snp_paravisor()) {
 		/* Negotiate GHCB Version. */
 		if (!hv_ghcb_negotiate_protocol())
 			hv_ghcb_terminate(SEV_TERM_SET_GEN,
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 2eda4e69849d..2548d904e45a 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -591,24 +591,25 @@ bool hv_is_isolation_supported(void)
 	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
 }
 
-DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
+DEFINE_STATIC_KEY_FALSE(isol_type_snp_paravisor);
 
 /*
- * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
+ * hv_isol_type_snp_paravisor - Check system runs in the AMD SEV-SNP based
  * isolation VM.
  */
-bool hv_isolation_type_snp(void)
+bool hv_isol_type_snp_paravisor(void)
 {
-	return static_branch_unlikely(&isolation_type_snp);
+	return static_branch_unlikely(&isol_type_snp_paravisor);
 }
 
-DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
+DEFINE_STATIC_KEY_FALSE(isol_type_snp_enlightened);
+
 /*
- * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
+ * hv_isol_type_snp_enlightened - Check system runs in the AMD SEV-SNP based
  * isolation enlightened VM.
  */
-bool hv_isolation_type_en_snp(void)
+bool hv_isol_type_snp_enlightened(void)
 {
-	return static_branch_unlikely(&isolation_type_en_snp);
+	return static_branch_unlikely(&isol_type_snp_enlightened);
 }
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index c5a3c29fad01..e543a5a1b007 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -25,8 +25,8 @@
 
 union hv_ghcb;
 
-DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
-DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
+DECLARE_STATIC_KEY_FALSE(isol_type_snp_paravisor);
+DECLARE_STATIC_KEY_FALSE(isol_type_snp_enlightened);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -46,7 +46,7 @@ extern void *hv_hypercall_pg;
 
 extern u64 hv_current_partition_id;
 
-extern bool hv_isolation_type_en_snp(void);
+extern bool hv_isol_type_snp_enlightened(void);
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
@@ -268,7 +268,7 @@ static inline void hv_sev_init_mem_and_cpu(void) {}
 static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
 #endif
 
-extern bool hv_isolation_type_snp(void);
+extern bool hv_isol_type_snp_paravisor(void);
 
 static inline bool hv_is_synic_reg(unsigned int reg)
 {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 6ff0b60d30f9..3c61b4b6a5e3 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -66,7 +66,7 @@ u64 hv_get_non_nested_register(unsigned int reg)
 {
 	u64 value;
 
-	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
+	if (hv_is_synic_reg(reg) && hv_isol_type_snp_paravisor())
 		hv_ghcb_msr_read(reg, &value);
 	else
 		rdmsrl(reg, value);
@@ -76,7 +76,7 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_register);
 
 void hv_set_non_nested_register(unsigned int reg, u64 value)
 {
-	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
+	if (hv_is_synic_reg(reg) && hv_isol_type_snp_paravisor()) {
 		hv_ghcb_msr_write(reg, value);
 
 		/* Write proxy bit via wrmsl instruction */
@@ -300,7 +300,7 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
 	 *  enlightened guest.
 	 */
-	if (hv_isolation_type_en_snp())
+	if (hv_isol_type_snp_enlightened())
 		apic->wakeup_secondary_cpu_64 = hv_snp_boot_ap;
 
 	if (!hv_root_partition)
@@ -421,9 +421,9 @@ static void __init ms_hyperv_init_platform(void)
 
 
 		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
-			static_branch_enable(&isolation_type_en_snp);
+			static_branch_enable(&isol_type_snp_enlightened);
 		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
-			static_branch_enable(&isolation_type_snp);
+			static_branch_enable(&isol_type_snp_paravisor);
 		}
 	}
 
@@ -545,7 +545,7 @@ static void __init ms_hyperv_init_platform(void)
 	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
 		mark_tsc_unstable("running on Hyper-V");
 
-	if (hv_isolation_type_en_snp())
+	if (hv_isol_type_snp_enlightened())
 		hv_sev_init_mem_and_cpu();
 
 	hardlockup_detector_disable();
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 02b54f85dc60..f86570f3bc1e 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -484,7 +484,7 @@ void vmbus_set_event(struct vmbus_channel *channel)
 
 	++channel->sig_events;
 
-	if (hv_isolation_type_snp())
+	if (hv_isol_type_snp_paravisor())
 		hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT, &channel->sig_event,
 				NULL, sizeof(channel->sig_event));
 	else
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index ec6e35a0d9bf..3a6e5ecd03d8 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -64,7 +64,7 @@ int hv_post_message(union hv_connection_id connection_id,
 	aligned_msg->payload_size = payload_size;
 	memcpy((void *)aligned_msg->payload, payload, payload_size);
 
-	if (hv_isolation_type_snp())
+	if (hv_isol_type_snp_paravisor())
 		status = hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
 				(void *)aligned_msg, NULL,
 				sizeof(*aligned_msg));
@@ -109,7 +109,7 @@ int hv_synic_alloc(void)
 		 * Synic message and event pages are allocated by paravisor.
 		 * Skip these pages allocation here.
 		 */
-		if (!hv_isolation_type_snp() && !hv_root_partition) {
+		if (!hv_isol_type_snp_paravisor() && !hv_root_partition) {
 			hv_cpu->synic_message_page =
 				(void *)get_zeroed_page(GFP_ATOMIC);
 			if (hv_cpu->synic_message_page == NULL) {
@@ -125,7 +125,7 @@ int hv_synic_alloc(void)
 			}
 		}
 
-		if (hv_isolation_type_en_snp()) {
+		if (hv_isol_type_snp_enlightened()) {
 			ret = set_memory_decrypted((unsigned long)
 				hv_cpu->synic_message_page, 1);
 			if (ret) {
@@ -174,7 +174,7 @@ void hv_synic_free(void)
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		/* It's better to leak the page if the encryption fails. */
-		if (hv_isolation_type_en_snp()) {
+		if (hv_isol_type_snp_enlightened()) {
 			if (hv_cpu->synic_message_page) {
 				ret = set_memory_encrypted((unsigned long)
 					hv_cpu->synic_message_page, 1);
@@ -221,7 +221,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
 	simp.simp_enabled = 1;
 
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (hv_isol_type_snp_paravisor() || hv_root_partition) {
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
@@ -240,7 +240,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 1;
 
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (hv_isol_type_snp_paravisor() || hv_root_partition) {
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
@@ -323,7 +323,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	 * addresses.
 	 */
 	simp.simp_enabled = 0;
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (hv_isol_type_snp_paravisor() || hv_root_partition) {
 		iounmap(hv_cpu->synic_message_page);
 		hv_cpu->synic_message_page = NULL;
 	} else {
@@ -335,7 +335,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 0;
 
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (hv_isol_type_snp_paravisor() || hv_root_partition) {
 		iounmap(hv_cpu->synic_event_page);
 		hv_cpu->synic_event_page = NULL;
 	} else {
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 2d43ba2bc925..e205f85709ad 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -381,7 +381,7 @@ int hv_common_cpu_init(unsigned int cpu)
 			*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
 		}
 
-		if (hv_isolation_type_en_snp()) {
+		if (hv_isol_type_snp_enlightened()) {
 			ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
 			if (ret) {
 				kfree(*inputarg);
@@ -509,17 +509,17 @@ bool __weak hv_is_isolation_supported(void)
 }
 EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
 
-bool __weak hv_isolation_type_snp(void)
+bool __weak hv_isol_type_snp_paravisor(void)
 {
 	return false;
 }
-EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
+EXPORT_SYMBOL_GPL(hv_isol_type_snp_paravisor);
 
-bool __weak hv_isolation_type_en_snp(void)
+bool __weak hv_isol_type_snp_enlightened(void)
 {
 	return false;
 }
-EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
+EXPORT_SYMBOL_GPL(hv_isol_type_snp_enlightened);
 
 void __weak hv_setup_vmbus_handler(void (*handler)(void))
 {
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index f73a044ecaa7..b8f2b48b640f 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -64,7 +64,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
 
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
-extern bool hv_isolation_type_snp(void);
+extern bool hv_isol_type_snp_paravisor(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
@@ -279,7 +279,7 @@ bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
 enum hv_isolation_type hv_get_isolation_type(void);
 bool hv_is_isolation_supported(void);
-bool hv_isolation_type_snp(void);
+bool hv_isol_type_snp_paravisor(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
-- 
2.25.1

