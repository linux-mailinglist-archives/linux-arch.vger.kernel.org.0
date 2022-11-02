Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB140616437
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 15:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiKBOAk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 10:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiKBOAh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 10:00:37 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05FB8DF9D;
        Wed,  2 Nov 2022 07:00:32 -0700 (PDT)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 05DCE205DA26;
        Wed,  2 Nov 2022 07:00:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05DCE205DA26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667397631;
        bh=4/+ExXsC1haU+bI0bHrq9yooOCa5AAvNAd0MIvdOGEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1AVgHWspNSa60xR9ZhNH4xXrePrjy6xiI69x6bJFJP+TL/xHDy2FpvK5mVf16ljA
         aiPagMU1Q+bGXOkm0fvnDmt+pA03SNVQtFJdwVrQdWUjfBjq24m9wbxz20SOK9qCkc
         53CXtVC4FwyYHDjtjxl3ms/lPcrcr2nKHYoVScc4=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 2/6] hv: Setup synic registers in case of nested root partition
Date:   Wed,  2 Nov 2022 14:00:13 +0000
Message-Id: <78973f0cfed8a19fced95875c0142a08386e66ed.1667394408.git.jinankjain@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667394408.git.jinankjain@microsoft.com>
References: <cover.1667394408.git.jinankjain@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Child partitions are free to allocate SynIC message and event page but in
case of root partition it must use the pages allocated by Microsoft
Hypervisor (MSHV). Base address for these pages can be found using
synthetic MSRs exposed by MSHV. There is a slight difference in those MSRs
for nested vs non-nested root partition.

Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 11 ++++++
 drivers/hv/hv.c                    | 55 ++++++++++++++++++------------
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index d9a611565859..0319091e2019 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -225,6 +225,17 @@ enum hv_isolation_type {
 #define HV_REGISTER_SINT14			0x4000009E
 #define HV_REGISTER_SINT15			0x4000009F
 
+/*
+ * Define synthetic interrupt controller model specific registers for
+ * nested hypervisor.
+ */
+#define HV_REGISTER_NESTED_SCONTROL            0x40001080
+#define HV_REGISTER_NESTED_SVERSION            0x40001081
+#define HV_REGISTER_NESTED_SIEFP               0x40001082
+#define HV_REGISTER_NESTED_SIMP                0x40001083
+#define HV_REGISTER_NESTED_EOM                 0x40001084
+#define HV_REGISTER_NESTED_SINT0               0x40001090
+
 /*
  * Synthetic Timer MSRs. Four timers per vcpu.
  */
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 4d6480d57546..92ee910561c4 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -25,6 +25,11 @@
 /* The one and only */
 struct hv_context hv_context;
 
+#define REG_SIMP (hv_nested ? HV_REGISTER_NESTED_SIMP : HV_REGISTER_SIMP)
+#define REG_SIEFP (hv_nested ? HV_REGISTER_NESTED_SIEFP : HV_REGISTER_SIEFP)
+#define REG_SCTRL (hv_nested ? HV_REGISTER_NESTED_SCONTROL : HV_REGISTER_SCONTROL)
+#define REG_SINT0 (hv_nested ? HV_REGISTER_NESTED_SINT0 : HV_REGISTER_SINT0)
+
 /*
  * hv_init - Main initialization routine.
  *
@@ -147,7 +152,7 @@ int hv_synic_alloc(void)
 		 * Synic message and event pages are allocated by paravisor.
 		 * Skip these pages allocation here.
 		 */
-		if (!hv_isolation_type_snp()) {
+		if (!hv_isolation_type_snp() && !hv_root_partition) {
 			hv_cpu->synic_message_page =
 				(void *)get_zeroed_page(GFP_ATOMIC);
 			if (hv_cpu->synic_message_page == NULL) {
@@ -188,8 +193,16 @@ void hv_synic_free(void)
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		free_page((unsigned long)hv_cpu->synic_event_page);
-		free_page((unsigned long)hv_cpu->synic_message_page);
+		if (hv_root_partition) {
+			if (hv_cpu->synic_event_page != NULL)
+				memunmap(hv_cpu->synic_event_page);
+
+			if (hv_cpu->synic_message_page != NULL)
+				memunmap(hv_cpu->synic_message_page);
+		} else {
+			free_page((unsigned long)hv_cpu->synic_event_page);
+			free_page((unsigned long)hv_cpu->synic_message_page);
+		}
 		free_page((unsigned long)hv_cpu->post_msg_page);
 	}
 
@@ -213,10 +226,10 @@ void hv_synic_enable_regs(unsigned int cpu)
 	union hv_synic_scontrol sctrl;
 
 	/* Setup the Synic's message page */
-	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
+	simp.as_uint64 = hv_get_register(REG_SIMP);
 	simp.simp_enabled = 1;
 
-	if (hv_isolation_type_snp()) {
+	if (hv_isolation_type_snp() || hv_root_partition) {
 		hv_cpu->synic_message_page
 			= memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
 				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
@@ -227,13 +240,13 @@ void hv_synic_enable_regs(unsigned int cpu)
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
-	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+	hv_set_register(REG_SIMP, simp.as_uint64);
 
 	/* Setup the Synic's event page */
-	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	siefp.as_uint64 = hv_get_register(REG_SIEFP);
 	siefp.siefp_enabled = 1;
 
-	if (hv_isolation_type_snp()) {
+	if (hv_isolation_type_snp() || hv_root_partition) {
 		hv_cpu->synic_event_page =
 			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
 				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
@@ -245,12 +258,12 @@ void hv_synic_enable_regs(unsigned int cpu)
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
-	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	hv_set_register(REG_SIEFP, siefp.as_uint64);
 
 	/* Setup the shared SINT. */
 	if (vmbus_irq != -1)
 		enable_percpu_irq(vmbus_irq, 0);
-	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
+	shared_sint.as_uint64 = hv_get_register(REG_SINT0 +
 					VMBUS_MESSAGE_SINT);
 
 	shared_sint.vector = vmbus_interrupt;
@@ -266,14 +279,14 @@ void hv_synic_enable_regs(unsigned int cpu)
 #else
 	shared_sint.auto_eoi = 0;
 #endif
-	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
+	hv_set_register(REG_SINT0 + VMBUS_MESSAGE_SINT,
 				shared_sint.as_uint64);
 
 	/* Enable the global synic bit */
-	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
+	sctrl.as_uint64 = hv_get_register(REG_SCTRL);
 	sctrl.enable = 1;
 
-	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+	hv_set_register(REG_SCTRL, sctrl.as_uint64);
 }
 
 int hv_synic_init(unsigned int cpu)
@@ -297,17 +310,17 @@ void hv_synic_disable_regs(unsigned int cpu)
 	union hv_synic_siefp siefp;
 	union hv_synic_scontrol sctrl;
 
-	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
+	shared_sint.as_uint64 = hv_get_register(REG_SINT0 +
 					VMBUS_MESSAGE_SINT);
 
 	shared_sint.masked = 1;
 
 	/* Need to correctly cleanup in the case of SMP!!! */
 	/* Disable the interrupt */
-	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
+	hv_set_register(REG_SINT0 + VMBUS_MESSAGE_SINT,
 				shared_sint.as_uint64);
 
-	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
+	simp.as_uint64 = hv_get_register(REG_SIMP);
 	/*
 	 * In Isolation VM, sim and sief pages are allocated by
 	 * paravisor. These pages also will be used by kdump
@@ -320,9 +333,9 @@ void hv_synic_disable_regs(unsigned int cpu)
 	else
 		simp.base_simp_gpa = 0;
 
-	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+	hv_set_register(REG_SIMP, simp.as_uint64);
 
-	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	siefp.as_uint64 = hv_get_register(REG_SIEFP);
 	siefp.siefp_enabled = 0;
 
 	if (hv_isolation_type_snp())
@@ -330,12 +343,12 @@ void hv_synic_disable_regs(unsigned int cpu)
 	else
 		siefp.base_siefp_gpa = 0;
 
-	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	hv_set_register(REG_SIEFP, siefp.as_uint64);
 
 	/* Disable the global synic bit */
-	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
+	sctrl.as_uint64 = hv_get_register(REG_SCTRL);
 	sctrl.enable = 0;
-	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+	hv_set_register(REG_SCTRL, sctrl.as_uint64);
 
 	if (vmbus_irq != -1)
 		disable_percpu_irq(vmbus_irq);
-- 
2.25.1

