Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28D65AD9F
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jan 2023 08:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjABHNQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Jan 2023 02:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjABHNM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jan 2023 02:13:12 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01A9625C3;
        Sun,  1 Jan 2023 23:13:11 -0800 (PST)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 86C3020FB6CC;
        Sun,  1 Jan 2023 23:13:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86C3020FB6CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1672643590;
        bh=gm0tJXQ/jfaWeFhURQC0+QSvpptcC3iL8+Y2LUdbQRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9kJYNDkllkBgad2RMpU8L4vn1rKEtb3d89UBRuWzPuyhKPBaF1CssPch+FucTMus
         sNlgI/bbcDtZ69E8NKxsKOiP87Z40S7z5xAKFe6W0uHJ9LYlxM3nh0Krvjps4zA1xN
         bPJHHypIzF7jcT4d/Ex47MQTdYGLQ+VXzvHT9lWY=
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
Subject: [PATCH v10 2/5] Drivers: hv: Setup synic registers in case of nested root partition
Date:   Mon,  2 Jan 2023 07:12:52 +0000
Message-Id: <cb951fb1ad6814996fc54f4a255c5841a20a151f.1672639707.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1672639707.git.jinankjain@linux.microsoft.com>
References: <cover.1672639707.git.jinankjain@linux.microsoft.com>
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
 arch/x86/include/asm/hyperv-tlfs.h | 11 +++++
 arch/x86/include/asm/mshyperv.h    | 30 +++-----------
 arch/x86/kernel/cpu/mshyperv.c     | 65 ++++++++++++++++++++++++++++++
 drivers/hv/hv.c                    | 18 +++++----
 4 files changed, 93 insertions(+), 31 deletions(-)

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
index 61f0c206bff0..c38e4c66a3ac 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -198,30 +198,10 @@ static inline bool hv_is_synic_reg(unsigned int reg)
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
+u64 hv_get_non_nested_register(unsigned int reg);
+void hv_set_non_nested_register(unsigned int reg, u64 value);
 
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
@@ -241,6 +221,8 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
 }
 static inline void hv_set_register(unsigned int reg, u64 value) { }
 static inline u64 hv_get_register(unsigned int reg) { return 0; }
+static inline void hv_set_non_nested_register(unsigned int reg, u64 value) { }
+static inline u64 hv_get_non_nested_register(unsigned int reg) { return 0; }
 static inline int hv_set_mem_host_visibility(unsigned long addr, int numpages,
 					     bool visible)
 {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f9b78d4829e3..938fc82edf05 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -41,7 +41,72 @@ bool hv_root_partition;
 bool hv_nested;
 struct ms_hyperv_info ms_hyperv;
 
+static inline unsigned int hv_get_nested_reg(unsigned int reg)
+{
+	switch (reg) {
+	case HV_REGISTER_SIMP:
+		return HV_REGISTER_NESTED_SIMP;
+	case HV_REGISTER_SIEFP:
+		return HV_REGISTER_NESTED_SIEFP;
+	case HV_REGISTER_SVERSION:
+		return HV_REGISTER_NESTED_SVERSION;
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
 #if IS_ENABLED(CONFIG_HYPERV)
+u64 hv_get_non_nested_register(unsigned int reg)
+{
+	u64 value;
+
+	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
+		hv_ghcb_msr_read(reg, &value);
+	else
+		rdmsrl(reg, value);
+	return value;
+}
+EXPORT_SYMBOL_GPL(hv_get_non_nested_register);
+
+void hv_set_non_nested_register(unsigned int reg, u64 value)
+{
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
+EXPORT_SYMBOL_GPL(hv_set_non_nested_register);
+
+u64 hv_get_register(unsigned int reg)
+{
+	if (hv_nested)
+		reg = hv_get_nested_reg(reg);
+
+	return hv_get_non_nested_register(reg);
+}
+EXPORT_SYMBOL_GPL(hv_get_register);
+
+void hv_set_register(unsigned int reg, u64 value)
+{
+	if (hv_nested)
+		reg = hv_get_nested_reg(reg);
+
+	hv_set_non_nested_register(reg, value);
+}
+EXPORT_SYMBOL_GPL(hv_set_register);
+
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 4d6480d57546..8b0dd8e5244d 100644
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
@@ -216,7 +216,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
 	simp.simp_enabled = 1;
 
-	if (hv_isolation_type_snp()) {
+	if (hv_isolation_type_snp() || hv_root_partition) {
 		hv_cpu->synic_message_page
 			= memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
 				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
@@ -233,7 +233,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 1;
 
-	if (hv_isolation_type_snp()) {
+	if (hv_isolation_type_snp() || hv_root_partition) {
 		hv_cpu->synic_event_page =
 			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
 				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
@@ -315,20 +315,24 @@ void hv_synic_disable_regs(unsigned int cpu)
 	 * addresses.
 	 */
 	simp.simp_enabled = 0;
-	if (hv_isolation_type_snp())
+	if (hv_isolation_type_snp() || hv_root_partition) {
 		memunmap(hv_cpu->synic_message_page);
-	else
+		hv_cpu->synic_message_page = NULL;
+	} else {
 		simp.base_simp_gpa = 0;
+	}
 
 	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
 
 	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 0;
 
-	if (hv_isolation_type_snp())
+	if (hv_isolation_type_snp() || hv_root_partition) {
 		memunmap(hv_cpu->synic_event_page);
-	else
+		hv_cpu->synic_event_page = NULL;
+	} else {
 		siefp.base_siefp_gpa = 0;
+	}
 
 	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
 
-- 
2.25.1

