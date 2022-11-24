Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D130163722C
	for <lists+linux-arch@lfdr.de>; Thu, 24 Nov 2022 07:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKXGCi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Nov 2022 01:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKXGC2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2022 01:02:28 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE8B41B7AC;
        Wed, 23 Nov 2022 22:02:26 -0800 (PST)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 36DF620B83DC;
        Wed, 23 Nov 2022 22:02:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36DF620B83DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669269746;
        bh=MKWLvVLStOT5MYIHkjm5sdDjs9fAGhyWlNuXLqeegL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hpp+FZzdQcpe8GfsWFVdHWfJeDO3wDWJ9nud+FedvkalAyxCkqUe6wFkZvb123eYJ
         Fe2pLzw/FL7FBz5nMQMayhcnp23Dgq1txt6DGF6f4sIIL/5VXxnbT5M69WP3txe9aG
         x1Gu3zRD3F+0TaF9E2Mhl+SJsdPS11+ZYfCgb/Uw=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
To:     jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
Subject: [PATCH v6 2/5] Drivers: hv: Setup synic registers in case of nested root partition
Date:   Thu, 24 Nov 2022 06:02:07 +0000
Message-Id: <bf78acdc273fa730faf6eff49dd67a32c2242d84.1669269377.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669269377.git.jinankjain@linux.microsoft.com>
References: <cover.1669269377.git.jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/x86/include/asm/hyperv-tlfs.h | 11 +++++++
 arch/x86/include/asm/mshyperv.h    | 26 ++--------------
 arch/x86/kernel/cpu/mshyperv.c     | 49 ++++++++++++++++++++++++++++++
 drivers/hv/hv.c                    | 18 ++++++++---
 4 files changed, 75 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 58c03d18c235..b5019becb618 100644
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
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 61f0c206bff0..326d699b30d5 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -198,30 +198,8 @@ static inline bool hv_is_synic_reg(unsigned int reg)
 	return false;
 }
 
-static inline u64 hv_get_register(unsigned int reg)
-{
-	u64 value;
-
-	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
-		hv_ghcb_msr_read(reg, &value);
-	else
-		rdmsrl(reg, value);
-	return value;
-}
-
-static inline void hv_set_register(unsigned int reg, u64 value)
-{
-	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
-		hv_ghcb_msr_write(reg, value);
-
-		/* Write proxy bit via wrmsl instruction */
-		if (reg >= HV_REGISTER_SINT0 &&
-		    reg <= HV_REGISTER_SINT15)
-			wrmsrl(reg, value | 1 << 20);
-	} else {
-		wrmsrl(reg, value);
-	}
-}
+u64 hv_get_register(unsigned int reg);
+void hv_set_register(unsigned int reg, u64 value);
 
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 9a4204139490..97d8ce744e47 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -41,6 +41,55 @@ bool hv_root_partition;
 bool hv_nested;
 struct ms_hyperv_info ms_hyperv;
 
+static inline unsigned int hv_get_nested_reg(unsigned int reg)
+{
+	switch (reg) {
+	case HV_REGISTER_SIMP:
+		return HV_REGISTER_NESTED_SIMP;
+	case HV_REGISTER_NESTED_SIEFP:
+		return HV_REGISTER_SIEFP;
+	case HV_REGISTER_SCONTROL:
+		return HV_REGISTER_NESTED_SCONTROL;
+	case HV_REGISTER_SINT0:
+		return HV_REGISTER_NESTED_SINT0;
+	case HV_REGISTER_EOM:
+		return HV_REGISTER_NESTED_EOM;
+	default:
+		return reg;
+	}
+}
+
+u64 hv_get_register(unsigned int reg)
+{
+	u64 value;
+
+	if (hv_nested)
+		reg = hv_get_nested_reg(reg);
+
+	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
+		hv_ghcb_msr_read(reg, &value);
+	else
+		rdmsrl(reg, value);
+	return value;
+}
+
+void hv_set_register(unsigned int reg, u64 value)
+{
+	if (hv_nested)
+		reg = hv_get_nested_reg(reg);
+
+	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
+		hv_ghcb_msr_write(reg, value);
+
+		/* Write proxy bit via wrmsl instruction */
+		if (reg >= HV_REGISTER_SINT0 &&
+		    reg <= HV_REGISTER_SINT15)
+			wrmsrl(reg, value | 1 << 20);
+	} else {
+		wrmsrl(reg, value);
+	}
+}
+
 #if IS_ENABLED(CONFIG_HYPERV)
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 4d6480d57546..9e1eb50cc76f 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -147,7 +147,7 @@ int hv_synic_alloc(void)
 		 * Synic message and event pages are allocated by paravisor.
 		 * Skip these pages allocation here.
 		 */
-		if (!hv_isolation_type_snp()) {
+		if (!hv_isolation_type_snp() && !hv_root_partition) {
 			hv_cpu->synic_message_page =
 				(void *)get_zeroed_page(GFP_ATOMIC);
 			if (hv_cpu->synic_message_page == NULL) {
@@ -188,8 +188,16 @@ void hv_synic_free(void)
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
 
@@ -216,7 +224,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
 	simp.simp_enabled = 1;
 
-	if (hv_isolation_type_snp()) {
+	if (hv_isolation_type_snp() || hv_root_partition) {
 		hv_cpu->synic_message_page
 			= memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
 				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
@@ -233,7 +241,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 1;
 
-	if (hv_isolation_type_snp()) {
+	if (hv_isolation_type_snp() || hv_root_partition) {
 		hv_cpu->synic_event_page =
 			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
 				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
-- 
2.25.1

