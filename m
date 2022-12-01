Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861DA63EEC4
	for <lists+linux-arch@lfdr.de>; Thu,  1 Dec 2022 12:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiLALFB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Dec 2022 06:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiLALEJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Dec 2022 06:04:09 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BB275C0C5;
        Thu,  1 Dec 2022 03:03:57 -0800 (PST)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 589DD20B83CB;
        Thu,  1 Dec 2022 03:03:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 589DD20B83CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669892637;
        bh=0+KAr3P31K1yqWvx8AGnhGsn4fOeV9YS2a/eXiz7wcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDYrzKlW4YL2Fie6AkQZkIMiNTPfIKBiFUoK+nEYaLksUDK+PXtue+ByyVqhIovIa
         Pese7jM7yQolBBKioItSoEKlclMdXS5o6yJMXOG8Pl/PlGi2ZxI+Mb8Q4l0F3BD8ag
         eqamzDZWE+Rh362Tdai1yF9JXWldbKaOGpDSAlv4=
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
Subject: [PATCH v7 2/5] Drivers: hv: Setup synic registers in case of nested root partition
Date:   Thu,  1 Dec 2022 11:03:36 +0000
Message-Id: <dae50574584d821dda19399cb3535089e1465b6a.1669788587.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669788587.git.jinankjain@linux.microsoft.com>
References: <cover.1669788587.git.jinankjain@linux.microsoft.com>
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
 arch/x86/include/asm/hyperv-tlfs.h | 11 ++++
 arch/x86/include/asm/mshyperv.h    | 30 ++-------
 arch/x86/kernel/cpu/mshyperv.c     | 69 +++++++++++++++++++++
 drivers/hv/hv.c                    | 99 ++++++++++++++++++++++--------
 include/asm-generic/mshyperv.h     |  5 +-
 5 files changed, 165 insertions(+), 49 deletions(-)

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
index 61f0c206bff0..3197d49c888c 100644
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
+u64 hv_get_nested_register(unsigned int reg);
+void hv_set_nested_register(unsigned int reg, u64 value);
 
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
@@ -241,6 +221,8 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
 }
 static inline void hv_set_register(unsigned int reg, u64 value) { }
 static inline u64 hv_get_register(unsigned int reg) { return 0; }
+static inline void hv_set_nested_register(unsigned int reg, u64 value) { }
+static inline u64 hv_get_nested_register(unsigned int reg) { return 0; }
 static inline int hv_set_mem_host_visibility(unsigned long addr, int numpages,
 					     bool visible)
 {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f9b78d4829e3..f2f6e10301a8 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -41,7 +41,76 @@ bool hv_root_partition;
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
 #if IS_ENABLED(CONFIG_HYPERV)
+static u64 _hv_get_register(unsigned int reg, bool nested)
+{
+	u64 value;
+
+	if (nested)
+		reg = hv_get_nested_reg(reg);
+
+	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
+		hv_ghcb_msr_read(reg, &value);
+	else
+		rdmsrl(reg, value);
+	return value;
+}
+
+static void _hv_set_register(unsigned int reg, u64 value, bool nested)
+{
+	if (nested)
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
+u64 hv_get_register(unsigned int reg)
+{
+	return _hv_get_register(reg, false);
+}
+
+void hv_set_register(unsigned int reg, u64 value)
+{
+	_hv_set_register(reg, value, false);
+}
+
+u64 hv_get_nested_register(unsigned int reg)
+{
+	return _hv_get_register(reg, true);
+}
+
+void hv_set_nested_register(unsigned int reg, u64 value)
+{
+	_hv_set_register(reg, value, true);
+}
+
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 4d6480d57546..0ed052f2423e 100644
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
 
@@ -213,10 +221,12 @@ void hv_synic_enable_regs(unsigned int cpu)
 	union hv_synic_scontrol sctrl;
 
 	/* Setup the Synic's message page */
-	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
+	simp.as_uint64 = hv_nested ? hv_get_nested_register(HV_REGISTER_SIMP) :
+				     hv_get_register(HV_REGISTER_SIMP);
+
 	simp.simp_enabled = 1;
 
-	if (hv_isolation_type_snp()) {
+	if (hv_isolation_type_snp() || hv_root_partition) {
 		hv_cpu->synic_message_page
 			= memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
 				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
@@ -227,13 +237,18 @@ void hv_synic_enable_regs(unsigned int cpu)
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
-	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+	if (hv_nested)
+		hv_set_nested_register(HV_REGISTER_SIMP, simp.as_uint64);
+	else
+		hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
 
 	/* Setup the Synic's event page */
-	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	siefp.as_uint64 = hv_nested ?
+				  hv_get_nested_register(HV_REGISTER_SIEFP) :
+				  hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 1;
 
-	if (hv_isolation_type_snp()) {
+	if (hv_isolation_type_snp() || hv_root_partition) {
 		hv_cpu->synic_event_page =
 			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
 				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
@@ -245,13 +260,19 @@ void hv_synic_enable_regs(unsigned int cpu)
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
-	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	if (hv_nested)
+		hv_set_nested_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	else
+		hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
 
 	/* Setup the shared SINT. */
 	if (vmbus_irq != -1)
 		enable_percpu_irq(vmbus_irq, 0);
-	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
-					VMBUS_MESSAGE_SINT);
+	shared_sint.as_uint64 =
+		hv_nested ?
+			hv_get_nested_register(HV_REGISTER_SINT0 +
+					       VMBUS_MESSAGE_SINT) :
+			hv_get_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT);
 
 	shared_sint.vector = vmbus_interrupt;
 	shared_sint.masked = false;
@@ -266,14 +287,22 @@ void hv_synic_enable_regs(unsigned int cpu)
 #else
 	shared_sint.auto_eoi = 0;
 #endif
-	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
+	if (hv_nested)
+		hv_set_nested_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
+				       shared_sint.as_uint64);
+	else
+		hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
 				shared_sint.as_uint64);
-
 	/* Enable the global synic bit */
-	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
+	sctrl.as_uint64 = hv_nested ?
+				  hv_get_nested_register(HV_REGISTER_SCONTROL) :
+				  hv_get_register(HV_REGISTER_SCONTROL);
 	sctrl.enable = 1;
 
-	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+	if (hv_nested)
+		hv_set_nested_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+	else
+		hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
 }
 
 int hv_synic_init(unsigned int cpu)
@@ -297,17 +326,25 @@ void hv_synic_disable_regs(unsigned int cpu)
 	union hv_synic_siefp siefp;
 	union hv_synic_scontrol sctrl;
 
-	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
-					VMBUS_MESSAGE_SINT);
+	shared_sint.as_uint64 =
+		hv_nested ?
+			hv_get_nested_register(HV_REGISTER_SINT0 +
+					       VMBUS_MESSAGE_SINT) :
+			hv_get_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT);
 
 	shared_sint.masked = 1;
 
 	/* Need to correctly cleanup in the case of SMP!!! */
 	/* Disable the interrupt */
-	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
+	if (hv_nested)
+		hv_set_nested_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
+				       shared_sint.as_uint64);
+	else
+		hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
 				shared_sint.as_uint64);
 
-	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
+	simp.as_uint64 = hv_nested ? hv_get_nested_register(HV_REGISTER_SIMP) :
+				     hv_get_register(HV_REGISTER_SIMP);
 	/*
 	 * In Isolation VM, sim and sief pages are allocated by
 	 * paravisor. These pages also will be used by kdump
@@ -320,9 +357,14 @@ void hv_synic_disable_regs(unsigned int cpu)
 	else
 		simp.base_simp_gpa = 0;
 
-	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+	if (hv_nested)
+		hv_set_nested_register(HV_REGISTER_SIMP, simp.as_uint64);
+	else
+		hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
 
-	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	siefp.as_uint64 = hv_nested ?
+				  hv_get_nested_register(HV_REGISTER_SIEFP) :
+				  hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 0;
 
 	if (hv_isolation_type_snp())
@@ -330,12 +372,21 @@ void hv_synic_disable_regs(unsigned int cpu)
 	else
 		siefp.base_siefp_gpa = 0;
 
-	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	if (hv_nested)
+		hv_set_nested_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	else
+		hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
 
 	/* Disable the global synic bit */
-	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
+	sctrl.as_uint64 = hv_nested ?
+				  hv_get_nested_register(HV_REGISTER_SCONTROL) :
+				  hv_get_register(HV_REGISTER_SCONTROL);
 	sctrl.enable = 0;
-	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+
+	if (hv_nested)
+		hv_set_nested_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+	else
+		hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
 
 	if (vmbus_irq != -1)
 		disable_percpu_irq(vmbus_irq);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index f131027830c3..db0b5be1e087 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -147,7 +147,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 		 * possibly deliver another msg from the
 		 * hypervisor
 		 */
-		hv_set_register(HV_REGISTER_EOM, 0);
+		if (hv_nested)
+			hv_set_nested_register(HV_REGISTER_EOM, 0);
+		else
+			hv_set_register(HV_REGISTER_EOM, 0);
 	}
 }
 
-- 
2.25.1

