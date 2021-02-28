Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2346E3272BC
	for <lists+linux-arch@lfdr.de>; Sun, 28 Feb 2021 16:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhB1PFD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 10:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhB1PE4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 10:04:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C76C06178A;
        Sun, 28 Feb 2021 07:04:15 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p5so8254303plo.4;
        Sun, 28 Feb 2021 07:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ZSWmKOHM83HX6YUXAHHEFmmzR78z/HL8b/czYSCFjA=;
        b=XlcLoAMIiS6Y7WrYMnFNmy8S77LCbJev2PpdJTJNT9SDb+CWNaoQJ3zxJsYwIMHAwT
         ARcXWnRPrdgeegs5WvCt58b83ZjrRCWOWl0ktE6dQhs63UaYoNuwo4JJVO4T+iHHJ3Ow
         g1yAQPjtaoBRNQM+ZJ79AkSYxcp53g76vHUkpvJu4j11q81Vl/WCT1h108D1SflOINBT
         rBYr/r4bi4CjVTP+nICchmpoNwoA2x2tNNmq2BO+ng7c7JCgo+IXGUuiSXqgDuwSaJtM
         bYoM1UGTgnslJN1VMxzpqDVgeFLEnbkgRa7Y+0ZRgRKPQeLk/8XuWWvQxlMKfh6skGSa
         VJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZSWmKOHM83HX6YUXAHHEFmmzR78z/HL8b/czYSCFjA=;
        b=efj1W1KySLXEIxHgms5zBiqcvj9PO9K3J+5qA+yeBYhdiCzeaswfswR76KgCJS1w0c
         z9/A1NeDg8DNiqfSlplAd5kWsoHhC7c9J92dFDWfudnqggJNyI8WTEg5Eh2QGTe4Fmxb
         M/wEhbsTxVALf+VmHV6+8l5lVD5X6j5sw8XNM7qdll1IfVrGZMwpXzcQmHsxTzRJHkzz
         sLMoMLmOzgobSAOtBBCA0GaG3hlB+lnRrLEyetbGfRcGBttlT2AvxQ4L+PJqQvIITLux
         RDPySe2CY59wMMaZXk4/uLw+Xz2kzZyoO0iNpJN2FEG0QIMA7EpMtj+STpj35jBTlYPP
         dV3A==
X-Gm-Message-State: AOAM53376kYJuXopf/zEnMqeFzaJ8XvuwpdB134fZVmw6jvoQrReAPJL
        cvD0/dy+pJ9OjJGj/t2Alk4=
X-Google-Smtp-Source: ABdhPJxFXHaWDkCJFaR0ABsDFCqk8XOpBPzy2AAY8q2WpiryBcbfyrlr3kV/oG6OezgUExiK+JkYag==
X-Received: by 2002:a17:90b:120f:: with SMTP id gl15mr2093052pjb.77.1614524655059;
        Sun, 28 Feb 2021 07:04:15 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:561f:afde:af07:8820])
        by smtp.gmail.com with ESMTPSA id 142sm8391331pfz.196.2021.02.28.07.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:04:14 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, vkuznets@redhat.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com,
        sunilmut@microsoft.com
Subject: [RFC PATCH 4/12]  HV: Add Write/Read MSR registers via ghcb
Date:   Sun, 28 Feb 2021 10:03:07 -0500
Message-Id: <20210228150315.2552437-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228150315.2552437-1-ltykernel@gmail.com>
References: <20210228150315.2552437-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V provides GHCB protocol to write Synthetic Interrupt
Controller MSR registers and these registers are emulated by
Hypervisor rather than paravisor.

Hyper-V requests to write SINTx MSR registers twice(once via
GHCB and once via wrmsr instruction including the proxy bit 21)
Guest OS ID MSR also needs to be set via GHCB.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/Makefile        |   2 +-
 arch/x86/hyperv/hv_init.c       |  18 +--
 arch/x86/hyperv/ivm.c           | 178 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h |  21 +++-
 arch/x86/kernel/cpu/mshyperv.c  |  46 --------
 drivers/hv/channel.c            |   2 +-
 drivers/hv/hv.c                 | 188 ++++++++++++++++++++++----------
 include/asm-generic/mshyperv.h  |  10 +-
 8 files changed, 343 insertions(+), 122 deletions(-)
 create mode 100644 arch/x86/hyperv/ivm.c

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 48e2c51464e8..5d2de10809ae 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y			:= hv_init.o mmu.o nested.o irqdomain.o
+obj-y			:= hv_init.o mmu.o nested.o irqdomain.o ivm.o
 obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
 
 ifdef CONFIG_X86_64
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 90e65fbf4c58..87b1dd9c84d6 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -475,6 +475,9 @@ void __init hyperv_init(void)
 
 		ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
 		*ghcb_base = ghcb_va;
+
+		/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
+		hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
 	}
 
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
@@ -561,6 +564,7 @@ void hyperv_cleanup(void)
 
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
+	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
 
 	/*
 	 * Reset hypercall page reference before reset the page,
@@ -668,17 +672,3 @@ bool hv_is_hibernation_supported(void)
 	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
 }
 EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
-
-enum hv_isolation_type hv_get_isolation_type(void)
-{
-	if (!(ms_hyperv.features_b & HV_ISOLATION))
-		return HV_ISOLATION_TYPE_NONE;
-	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
-}
-EXPORT_SYMBOL_GPL(hv_get_isolation_type);
-
-bool hv_is_isolation_supported(void)
-{
-	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
-}
-EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
new file mode 100644
index 000000000000..4332bf7aaf9b
--- /dev/null
+++ b/arch/x86/hyperv/ivm.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hyper-V Isolation VM interface with paravisor and hypervisor
+ *
+ * Author:
+ *  Tianyu Lan <Tianyu.Lan@microsoft.com>
+ */
+#include <linux/types.h>
+#include <linux/bitfield.h>
+#include <asm/io.h>
+#include <asm/svm.h>
+#include <asm/sev-es.h>
+#include <asm/mshyperv.h>
+
+union hv_ghcb {
+	struct ghcb ghcb;
+} __packed __aligned(PAGE_SIZE);
+
+void hv_ghcb_msr_write(u64 msr, u64 value)
+{
+	union hv_ghcb *hv_ghcb;
+	void **ghcb_base;
+	unsigned long flags;
+
+	if (!ms_hyperv.ghcb_base)
+		return;
+
+	local_irq_save(flags);
+	ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
+	hv_ghcb = (union hv_ghcb *)*ghcb_base;
+	if (!hv_ghcb) {
+		local_irq_restore(flags);
+		return;
+	}
+
+	memset(hv_ghcb, 0x00, HV_HYP_PAGE_SIZE);
+
+	hv_ghcb->ghcb.protocol_version = 1;
+	hv_ghcb->ghcb.ghcb_usage = 0;
+
+	ghcb_set_sw_exit_code(&hv_ghcb->ghcb, SVM_EXIT_MSR);
+	ghcb_set_rcx(&hv_ghcb->ghcb, msr);
+	ghcb_set_rax(&hv_ghcb->ghcb, lower_32_bits(value));
+	ghcb_set_rdx(&hv_ghcb->ghcb, value >> 32);
+	ghcb_set_sw_exit_info_1(&hv_ghcb->ghcb, 1);
+	ghcb_set_sw_exit_info_2(&hv_ghcb->ghcb, 0);
+
+	VMGEXIT();
+
+	if ((hv_ghcb->ghcb.save.sw_exit_info_1 & 0xffffffff) == 1)
+		pr_warn("Fail to write msr via ghcb.\n.");
+
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(hv_ghcb_msr_write);
+
+void hv_ghcb_msr_read(u64 msr, u64 *value)
+{
+	union hv_ghcb *hv_ghcb;
+	void **ghcb_base;
+	unsigned long flags;
+
+	if (!ms_hyperv.ghcb_base)
+		return;
+
+	local_irq_save(flags);
+	ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
+	hv_ghcb = (union hv_ghcb *)*ghcb_base;
+	if (!hv_ghcb) {
+		local_irq_restore(flags);
+		return;
+	}
+
+	memset(hv_ghcb, 0x00, PAGE_SIZE);
+	hv_ghcb->ghcb.protocol_version = 1;
+	hv_ghcb->ghcb.ghcb_usage = 0;
+
+	ghcb_set_sw_exit_code(&hv_ghcb->ghcb, SVM_EXIT_MSR);
+	ghcb_set_rcx(&hv_ghcb->ghcb, msr);
+	ghcb_set_sw_exit_info_1(&hv_ghcb->ghcb, 0);
+	ghcb_set_sw_exit_info_2(&hv_ghcb->ghcb, 0);
+
+	VMGEXIT();
+
+	if ((hv_ghcb->ghcb.save.sw_exit_info_1 & 0xffffffff) == 1)
+		pr_warn("Fail to write msr via ghcb.\n.");
+	else
+		*value = (u64)lower_32_bits(hv_ghcb->ghcb.save.rax)
+			| ((u64)lower_32_bits(hv_ghcb->ghcb.save.rdx) << 32);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(hv_ghcb_msr_read);
+
+void hv_sint_rdmsrl_ghcb(u64 msr, u64 *value)
+{
+	hv_ghcb_msr_read(msr, value);
+}
+EXPORT_SYMBOL_GPL(hv_sint_rdmsrl_ghcb);
+
+void hv_sint_wrmsrl_ghcb(u64 msr, u64 value)
+{
+	hv_ghcb_msr_write(msr, value);
+
+	/* Write proxy bit vua wrmsrl instruction. */
+	if (msr >= HV_X64_MSR_SINT0 && msr <= HV_X64_MSR_SINT15)
+		wrmsrl(msr, value | 1 << 20);
+}
+EXPORT_SYMBOL_GPL(hv_sint_wrmsrl_ghcb);
+
+inline void hv_signal_eom_ghcb(void)
+{
+	hv_sint_wrmsrl_ghcb(HV_X64_MSR_EOM, 0);
+}
+EXPORT_SYMBOL_GPL(hv_signal_eom_ghcb);
+
+enum hv_isolation_type hv_get_isolation_type(void)
+{
+	if (!(ms_hyperv.features_b & HV_ISOLATION))
+		return HV_ISOLATION_TYPE_NONE;
+	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
+}
+EXPORT_SYMBOL_GPL(hv_get_isolation_type);
+
+bool hv_is_isolation_supported(void)
+{
+	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
+}
+EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
+
+bool hv_isolation_type_snp(void)
+{
+	return hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP;
+}
+EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
+
+int hv_mark_gpa_visibility(u16 count, const u64 pfn[], u32 visibility)
+{
+	struct hv_input_modify_sparse_gpa_page_host_visibility **input_pcpu;
+	struct hv_input_modify_sparse_gpa_page_host_visibility *input;
+	u16 pages_processed;
+	u64 hv_status;
+	unsigned long flags;
+
+	/* no-op if partition isolation is not enabled */
+	if (!hv_is_isolation_supported())
+		return 0;
+
+	if (count > HV_MAX_MODIFY_GPA_REP_COUNT) {
+		pr_err("Hyper-V: GPA count:%d exceeds supported:%lu\n", count,
+			HV_MAX_MODIFY_GPA_REP_COUNT);
+		return -EINVAL;
+	}
+
+	local_irq_save(flags);
+	input_pcpu = (struct hv_input_modify_sparse_gpa_page_host_visibility **)
+			this_cpu_ptr(hyperv_pcpu_input_arg);
+	input = *input_pcpu;
+	if (unlikely(!input)) {
+		local_irq_restore(flags);
+		return -1;
+	}
+
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->host_visibility = visibility;
+	input->reserved0 = 0;
+	input->reserved1 = 0;
+	memcpy((void *)input->gpa_page_list, pfn, count * sizeof(*pfn));
+	hv_status = hv_do_rep_hypercall(
+			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
+			0, input, &pages_processed);
+	local_irq_restore(flags);
+
+	if (!(hv_status & HV_HYPERCALL_RESULT_MASK))
+		return 0;
+
+	return -EFAULT;
+}
+EXPORT_SYMBOL(hv_mark_gpa_visibility);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 1e8275d35c1f..f624d72b99d3 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -269,6 +269,25 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 int hv_set_mem_host_visibility(void *kbuffer, u32 size, u32 visibility);
 int hv_mark_gpa_visibility(u16 count, const u64 pfn[], u32 visibility);
+void hv_sint_wrmsrl_ghcb(u64 msr, u64 value);
+void hv_sint_rdmsrl_ghcb(u64 msr, u64 *value);
+void hv_signal_eom_ghcb(void);
+void hv_ghcb_msr_write(u64 msr, u64 value);
+void hv_ghcb_msr_read(u64 msr, u64 *value);
+
+#define hv_get_synint_state_ghcb(int_num, val)			\
+	hv_sint_rdmsrl_ghcb(HV_X64_MSR_SINT0 + int_num, val)
+#define hv_set_synint_state_ghcb(int_num, val) \
+	hv_sint_wrmsrl_ghcb(HV_X64_MSR_SINT0 + int_num, val)
+
+#define hv_get_simp_ghcb(val) hv_sint_rdmsrl_ghcb(HV_X64_MSR_SIMP, val)
+#define hv_set_simp_ghcb(val) hv_sint_wrmsrl_ghcb(HV_X64_MSR_SIMP, val)
+
+#define hv_get_siefp_ghcb(val) hv_sint_rdmsrl_ghcb(HV_X64_MSR_SIEFP, val)
+#define hv_set_siefp_ghcb(val) hv_sint_wrmsrl_ghcb(HV_X64_MSR_SIEFP, val)
+
+#define hv_get_synic_state_ghcb(val) hv_sint_rdmsrl_ghcb(HV_X64_MSR_SCONTROL, val)
+#define hv_set_synic_state_ghcb(val) hv_sint_wrmsrl_ghcb(HV_X64_MSR_SCONTROL, val)
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
@@ -287,9 +306,9 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
 {
 	return -1;
 }
+static inline void hv_signal_eom_ghcb(void) { };
 #endif /* CONFIG_HYPERV */
 
-
 #include <asm-generic/mshyperv.h>
 
 #endif
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index d6c363456cbf..aeafd4017c89 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -37,8 +37,6 @@
 bool hv_root_partition;
 EXPORT_SYMBOL_GPL(hv_root_partition);
 
-#define HV_PARTITION_ID_SELF ((u64)-1)
-
 struct ms_hyperv_info ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
 
@@ -481,47 +479,3 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
 };
-
-int hv_mark_gpa_visibility(u16 count, const u64 pfn[], u32 visibility)
-{
-	struct hv_input_modify_sparse_gpa_page_host_visibility **input_pcpu;
-	struct hv_input_modify_sparse_gpa_page_host_visibility *input;
-	u16 pages_processed;
-	u64 hv_status;
-	unsigned long flags;
-
-	/* no-op if partition isolation is not enabled */
-	if (!hv_is_isolation_supported())
-		return 0;
-
-	if (count > HV_MAX_MODIFY_GPA_REP_COUNT) {
-		pr_err("Hyper-V: GPA count:%d exceeds supported:%lu\n", count,
-			HV_MAX_MODIFY_GPA_REP_COUNT);
-		return -EINVAL;
-	}
-
-	local_irq_save(flags);
-	input_pcpu = (struct hv_input_modify_sparse_gpa_page_host_visibility **)
-			this_cpu_ptr(hyperv_pcpu_input_arg);
-	input = *input_pcpu;
-	if (unlikely(!input)) {
-		local_irq_restore(flags);
-		return -1;
-	}
-
-	input->partition_id = HV_PARTITION_ID_SELF;
-	input->host_visibility = visibility;
-	input->reserved0 = 0;
-	input->reserved1 = 0;
-	memcpy((void *)input->gpa_page_list, pfn, count * sizeof(*pfn));
-	hv_status = hv_do_rep_hypercall(
-			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
-			0, input, &pages_processed);
-	local_irq_restore(flags);
-
-	if (!(hv_status & HV_HYPERCALL_RESULT_MASK))
-		return 0;
-
-	return -EFAULT;
-}
-EXPORT_SYMBOL(hv_mark_gpa_visibility);
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 204e6f3598a5..f31b669a1ddf 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -247,7 +247,7 @@ int hv_set_mem_host_visibility(void *kbuffer, u32 size, u32 visibility)
 	u64 *pfn_array;
 	int ret = 0;
 
-	if (!hv_isolation_type_snp())
+	if (!hv_is_isolation_supported())
 		return 0;
 
 	pfn_array = vzalloc(HV_HYP_PAGE_SIZE);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index f202ac7f4b3d..28e28ccc2081 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -99,17 +99,24 @@ int hv_synic_alloc(void)
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
 
-		hv_cpu->synic_message_page =
-			(void *)get_zeroed_page(GFP_ATOMIC);
-		if (hv_cpu->synic_message_page == NULL) {
-			pr_err("Unable to allocate SYNIC message page\n");
-			goto err;
-		}
+		/*
+		 * Synic message and event pages are allocated by paravisor.
+		 * Skip these pages allocation here.
+		 */
+		if (!hv_isolation_type_snp()) {
+			hv_cpu->synic_message_page =
+				(void *)get_zeroed_page(GFP_ATOMIC);
+			if (hv_cpu->synic_message_page == NULL) {
+				pr_err("Unable to allocate SYNIC message page\n");
+				goto err;
+			}
 
-		hv_cpu->synic_event_page = (void *)get_zeroed_page(GFP_ATOMIC);
-		if (hv_cpu->synic_event_page == NULL) {
-			pr_err("Unable to allocate SYNIC event page\n");
-			goto err;
+			hv_cpu->synic_event_page =
+				(void *)get_zeroed_page(GFP_ATOMIC);
+			if (hv_cpu->synic_event_page == NULL) {
+				pr_err("Unable to allocate SYNIC event page\n");
+				goto err;
+			}
 		}
 
 		hv_cpu->post_msg_page = (void *)get_zeroed_page(GFP_ATOMIC);
@@ -136,10 +143,17 @@ void hv_synic_free(void)
 	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
+		free_page((unsigned long)hv_cpu->post_msg_page);
+
+		/*
+		 * Synic message and event pages are allocated by paravisor.
+		 * Skip free these pages here.
+		 */
+		if (hv_isolation_type_snp())
+			continue;
 
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
-		free_page((unsigned long)hv_cpu->post_msg_page);
 	}
 
 	kfree(hv_context.hv_numa_map);
@@ -161,35 +175,72 @@ void hv_synic_enable_regs(unsigned int cpu)
 	union hv_synic_sint shared_sint;
 	union hv_synic_scontrol sctrl;
 
-	/* Setup the Synic's message page */
-	hv_get_simp(simp.as_uint64);
-	simp.simp_enabled = 1;
-	simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
-		>> HV_HYP_PAGE_SHIFT;
-
-	hv_set_simp(simp.as_uint64);
-
-	/* Setup the Synic's event page */
-	hv_get_siefp(siefp.as_uint64);
-	siefp.siefp_enabled = 1;
-	siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
-		>> HV_HYP_PAGE_SHIFT;
-
-	hv_set_siefp(siefp.as_uint64);
-
-	/* Setup the shared SINT. */
-	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
-
-	shared_sint.vector = hv_get_vector();
-	shared_sint.masked = false;
-	shared_sint.auto_eoi = hv_recommend_using_aeoi();
-	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
-
-	/* Enable the global synic bit */
-	hv_get_synic_state(sctrl.as_uint64);
-	sctrl.enable = 1;
-
-	hv_set_synic_state(sctrl.as_uint64);
+	/*
+	 * Setup Synic pages for CVM. Synic message and event page
+	 * are allocated by paravisor in the SNP CVM.
+	 */
+	if (hv_isolation_type_snp()) {
+		/* Setup the Synic's message. */
+		hv_get_simp_ghcb(&simp.as_uint64);
+		simp.simp_enabled = 1;
+		hv_cpu->synic_message_page
+			= ioremap_cache(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
+					PAGE_SIZE);
+		if (!hv_cpu->synic_message_page)
+			pr_warn("Fail to map syinc message page.\n");
+
+		hv_set_simp_ghcb(simp.as_uint64);
+
+		/* Setup the Synic's event page */
+		hv_get_siefp_ghcb(&siefp.as_uint64);
+		siefp.siefp_enabled = 1;
+		hv_cpu->synic_event_page = ioremap_cache(
+			 siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT, PAGE_SIZE);
+		if (!hv_cpu->synic_event_page)
+			pr_warn("Fail to map syinc event page.\n");
+		hv_set_siefp_ghcb(siefp.as_uint64);
+
+		/* Setup the shared SINT. */
+		hv_get_synint_state_ghcb(VMBUS_MESSAGE_SINT,
+					 &shared_sint.as_uint64);
+		shared_sint.vector = hv_get_vector();
+		shared_sint.masked = false;
+		shared_sint.auto_eoi = hv_recommend_using_aeoi();
+		hv_set_synint_state_ghcb(VMBUS_MESSAGE_SINT,
+					 shared_sint.as_uint64);
+
+		/* Enable the global synic bit */
+		hv_get_synic_state_ghcb(&sctrl.as_uint64);
+		sctrl.enable = 1;
+		hv_set_synic_state_ghcb(sctrl.as_uint64);
+	} else {
+		/* Setup the Synic's message. */
+		hv_get_simp(simp.as_uint64);
+		simp.simp_enabled = 1;
+		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
+			>> HV_HYP_PAGE_SHIFT;
+		hv_set_simp(simp.as_uint64);
+
+		/* Setup the Synic's event page */
+		hv_get_siefp(siefp.as_uint64);
+		siefp.siefp_enabled = 1;
+		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
+			>> HV_HYP_PAGE_SHIFT;
+		hv_set_siefp(siefp.as_uint64);
+
+		/* Setup the shared SINT. */
+		hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+
+		shared_sint.vector = hv_get_vector();
+		shared_sint.masked = false;
+		shared_sint.auto_eoi = hv_recommend_using_aeoi();
+		hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+
+		/* Enable the global synic bit */
+		hv_get_synic_state(sctrl.as_uint64);
+		sctrl.enable = 1;
+		hv_set_synic_state(sctrl.as_uint64);
+	}
 }
 
 int hv_synic_init(unsigned int cpu)
@@ -211,30 +262,53 @@ void hv_synic_disable_regs(unsigned int cpu)
 	union hv_synic_siefp siefp;
 	union hv_synic_scontrol sctrl;
 
-	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+	if (hv_isolation_type_snp()) {
+		hv_get_synint_state_ghcb(VMBUS_MESSAGE_SINT,
+					 &shared_sint.as_uint64);
+		shared_sint.masked = 1;
+		hv_set_synint_state_ghcb(VMBUS_MESSAGE_SINT,
+					 shared_sint.as_uint64);
+
+		hv_get_simp_ghcb(&simp.as_uint64);
+		simp.simp_enabled = 0;
+		simp.base_simp_gpa = 0;
+		hv_set_simp_ghcb(simp.as_uint64);
+
+		hv_get_siefp_ghcb(&siefp.as_uint64);
+		siefp.siefp_enabled = 0;
+		siefp.base_siefp_gpa = 0;
+		hv_set_siefp_ghcb(siefp.as_uint64);
 
-	shared_sint.masked = 1;
+		/* Disable the global synic bit */
+		hv_get_synic_state_ghcb(&sctrl.as_uint64);
+		sctrl.enable = 0;
+		hv_set_synic_state_ghcb(sctrl.as_uint64);
+	} else {
+		hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
-	/* Need to correctly cleanup in the case of SMP!!! */
-	/* Disable the interrupt */
-	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+		shared_sint.masked = 1;
 
-	hv_get_simp(simp.as_uint64);
-	simp.simp_enabled = 0;
-	simp.base_simp_gpa = 0;
+		/* Need to correctly cleanup in the case of SMP!!! */
+		/* Disable the interrupt */
+		hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
-	hv_set_simp(simp.as_uint64);
+		hv_get_simp(simp.as_uint64);
+		simp.simp_enabled = 0;
+		simp.base_simp_gpa = 0;
 
-	hv_get_siefp(siefp.as_uint64);
-	siefp.siefp_enabled = 0;
-	siefp.base_siefp_gpa = 0;
+		hv_set_simp(simp.as_uint64);
 
-	hv_set_siefp(siefp.as_uint64);
+		hv_get_siefp(siefp.as_uint64);
+		siefp.siefp_enabled = 0;
+		siefp.base_siefp_gpa = 0;
 
-	/* Disable the global synic bit */
-	hv_get_synic_state(sctrl.as_uint64);
-	sctrl.enable = 0;
-	hv_set_synic_state(sctrl.as_uint64);
+		hv_set_siefp(siefp.as_uint64);
+
+		/* Disable the global synic bit */
+		hv_get_synic_state(sctrl.as_uint64);
+		sctrl.enable = 0;
+		hv_set_synic_state(sctrl.as_uint64);
+	}
 }
 
 int hv_synic_cleanup(unsigned int cpu)
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index ad0e33776668..6727f4073b5a 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -23,6 +23,7 @@
 #include <linux/bitops.h>
 #include <linux/cpumask.h>
 #include <asm/ptrace.h>
+#include <asm/mshyperv.h>
 #include <asm/hyperv-tlfs.h>
 
 struct ms_hyperv_info {
@@ -52,7 +53,7 @@ extern struct ms_hyperv_info ms_hyperv;
 
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
-
+extern bool hv_isolation_type_snp(void);
 
 /* Generate the guest OS identifier as described in the Hyper-V TLFS */
 static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
@@ -100,7 +101,11 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 		 * possibly deliver another msg from the
 		 * hypervisor
 		 */
-		hv_signal_eom();
+		if (hv_isolation_type_snp() &&
+		    old_msg_type != HVMSG_TIMER_EXPIRED)
+			hv_signal_eom_ghcb();
+		else
+			hv_signal_eom();
 	}
 }
 
@@ -186,6 +191,7 @@ bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
 enum hv_isolation_type hv_get_isolation_type(void);
 bool hv_is_isolation_supported(void);
+bool hv_isolation_type_snp(void);
 void hyperv_cleanup(void);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
-- 
2.25.1

