Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE23617D6D
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 14:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiKCNF4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiKCNFQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 09:05:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80F73186CE;
        Thu,  3 Nov 2022 06:04:22 -0700 (PDT)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3196B205DA31;
        Thu,  3 Nov 2022 06:04:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3196B205DA31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667480662;
        bh=1XFrn6tG+npSpwC5Fwga/EnPrm38noeKd85Wn2Esosk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k97Gect/eMWgpedcbZb7OQNMzenVH/EuFb7Zn2QfW64o+isSvJlhx3p/xN88jXNSE
         sPxD1RBnaKW0aalFOC+1n0RlefCHjWEy16M0BTuMRpFTEkvPOqJE/+IjY4KHtWi979
         zP6np+CucZbtLJ5vpcwVuxV0eAMA/7tEGzu17pu4=
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
Subject: [PATCH v3 2/5] Drivers: hv: Setup synic registers in case of nested root partition
Date:   Thu,  3 Nov 2022 13:04:04 +0000
Message-Id: <d8e549f443468f98ea701b27ffe47e4073d6d65d.1667480257.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667480257.git.jinankjain@linux.microsoft.com>
References: <cover.1667480257.git.jinankjain@linux.microsoft.com>
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
 arch/x86/include/asm/hyperv-tlfs.h | 11 +++++++++++
 arch/x86/include/asm/mshyperv.h    | 24 ++++++++++++++++++++++++
 drivers/hv/hv.c                    | 18 +++++++++++++-----
 3 files changed, 48 insertions(+), 5 deletions(-)

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
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 3c39923e5969..b0f16d06a0c5 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -200,10 +200,31 @@ static inline bool hv_is_synic_reg(unsigned int reg)
 	return false;
 }
 
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
 static inline u64 hv_get_register(unsigned int reg)
 {
 	u64 value;
 
+	if (hv_nested)
+		reg = hv_get_nested_reg(reg);
+
 	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
 		hv_ghcb_msr_read(reg, &value);
 	else
@@ -213,6 +234,9 @@ static inline u64 hv_get_register(unsigned int reg)
 
 static inline void hv_set_register(unsigned int reg, u64 value)
 {
+	if (hv_nested)
+		reg = hv_get_nested_reg(reg);
+
 	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
 		hv_ghcb_msr_write(reg, value);
 
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

