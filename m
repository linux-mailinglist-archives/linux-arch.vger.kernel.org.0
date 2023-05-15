Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C6070358C
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 19:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243396AbjEORAB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 13:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243362AbjEOQ7h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 12:59:37 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6C45FCA;
        Mon, 15 May 2023 09:59:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53063897412so5658702a12.0;
        Mon, 15 May 2023 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169968; x=1686761968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5zMqzIM1Yd79e6/EeCYzET5K3g+P8Lp3kx3ilDsSeQ=;
        b=MfOWTFkL6ZCZsDxnxcb3AXR1O20muVNAxfI2x0k+KxTl4KDc/C4z0Mj/sPnOLeChke
         JWvnth9yJj+GRIxrr/vtlJT1czPy4t+Oh/rZ1xcz0GIH36DJzf9Ny6C8wx69DeqSeFQg
         HMt/xSe80tIHDet6DfHukSU2YZ3Bbz4dxn01Pr7xl1qWU/PZ3gYF+I2RfxnrG/X15niK
         EQqU/1DzEcFqEm1VWUGpL2pztV1pBsf8qpC2N/OUbLBKRPeFhwwgvyJlPNFfaKik/K94
         +sKK2Cj4RO3kQcQ7dhN0U0iHYlbBm7VAOXW5RWaWBboUsJyEbUPk6qIe7iEs0aXGDRml
         NNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169968; x=1686761968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5zMqzIM1Yd79e6/EeCYzET5K3g+P8Lp3kx3ilDsSeQ=;
        b=SvZtXsa8Tf7d7e8uvroBFxzur4wVqiNiKY9ttwogehY+KONTzhiez+TMUYTrRZ6D88
         yXGIQHCZJmK2rEktdy/kOSigjDR3nTXmwZiOKitO2wtQJxABxK+rL87yhjZLFV+Ta6Lq
         gmKVnGIyOo7+nhq/Ljy+JbGdEmp2XUH76q0GEH7CBAxyx/Cq8xehU1ty5L8+DW/tt45O
         9q7L/tUxvccc7qWhgvSkGphVfwDXrwBRHW3JMNvw9e2okrC1riW55+I+dMa7DTcrHgiR
         mVYdhuCHFSHeZq7PUq2OoFFt2LLK7e0f9jUE9n8PMzbEpXeoakggXqY58A5RHiHQdOit
         7Yjg==
X-Gm-Message-State: AC+VfDzgJ7GnAQbysVBdllkQxz6K6pfz15PNRfffFvwtPefnH31swM2B
        ndqVuvBFRsrpdiPCVl0t98c=
X-Google-Smtp-Source: ACHHUZ4cz5RJuEbwK/I7LzphkIRWDDgcmJTVyISxzKmbdXs6m3WM6ywqTUUNdjLqBCWPeR3PzQaZ7Q==
X-Received: by 2002:a17:90a:fa5:b0:24d:f992:5286 with SMTP id 34-20020a17090a0fa500b0024df9925286mr23559697pjz.36.1684169968549;
        Mon, 15 May 2023 09:59:28 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:85bb:dfc8:391f:ff73])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b0024df6bbf5d8sm2151pjp.30.2023.05.15.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:59:28 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH V6 03/14] x86/sev: Add AMD sev-snp enlightened guest support on hyperv
Date:   Mon, 15 May 2023 12:59:05 -0400
Message-Id: <20230515165917.1306922-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515165917.1306922-1-ltykernel@gmail.com>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
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

Enable #HV exception to handle interrupt requests from hypervisor.

Co-developed-by: Lendacky Thomas <thomas.lendacky@amd.com>
Co-developed-by: Kalra Ashish <ashish.kalra@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V5:
       * Merge patch "x86/sev: Fix interrupt exit code paths from
        #HV exception" with this commit.

Change since RFC V3:
       * Check NMI event when irq is disabled.
       * Remove redundant variable
---
 arch/x86/include/asm/idtentry.h    |  12 +-
 arch/x86/include/asm/mem_encrypt.h |   2 +
 arch/x86/include/uapi/asm/svm.h    |   4 +
 arch/x86/kernel/sev.c              | 349 ++++++++++++++++++++++++-----
 arch/x86/kernel/traps.c            |   2 +
 5 files changed, 310 insertions(+), 59 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b0f3501b2767..867073ccf1d1 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -13,6 +13,12 @@
 
 #include <asm/irq_stack.h>
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state);
+#else
+#define irqentry_exit_hv_cond(regs, state)	irqentry_exit(regs, state)
+#endif
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
@@ -201,7 +207,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_irq_on_irqstack_cond(__##func, regs, vector);		\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit_hv_cond(regs, state);				\
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs, u32 vector)
@@ -241,7 +247,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit_hv_cond(regs, state);				\
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs)
@@ -270,7 +276,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	__##func (regs);						\
 	__irq_exit_raw();						\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit_hv_cond(regs, state);				\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index b7126701574c..9299caeca69f 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -50,6 +50,7 @@ void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
 void __init mem_encrypt_free_decrypted_mem(void);
 
 void __init sev_es_init_vc_handling(void);
+void __init sev_snp_init_hv_handling(void);
 
 #define __bss_decrypted __section(".bss..decrypted")
 
@@ -73,6 +74,7 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
+static inline void sev_snp_init_hv_handling(void) { }
 
 static inline int __init
 early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 80e1df482337..828d624a38cf 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -115,6 +115,10 @@
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
+#define SVM_VMGEXIT_HV_DOORBELL_PAGE		0x80000014
+#define SVM_VMGEXIT_GET_PREFERRED_HV_DOORBELL_PAGE	0
+#define SVM_VMGEXIT_SET_HV_DOORBELL_PAGE		1
+#define SVM_VMGEXIT_QUERY_HV_DOORBELL_PAGE		2
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_TERM_REQUEST		0x8000fffe
 #define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index ff5eab48bfe2..400ca555bd48 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -124,6 +124,165 @@ struct sev_config {
 
 static struct sev_config sev_cfg __read_mostly;
 
+static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state);
+static noinstr void __sev_put_ghcb(struct ghcb_state *state);
+static int vmgexit_hv_doorbell_page(struct ghcb *ghcb, u64 op, u64 pa);
+static void sev_snp_setup_hv_doorbell_page(struct ghcb *ghcb);
+
+union hv_pending_events {
+	u16 events;
+	struct {
+		u8 vector;
+		u8 nmi : 1;
+		u8 mc : 1;
+		u8 reserved1 : 5;
+		u8 no_further_signal : 1;
+	};
+};
+
+struct sev_hv_doorbell_page {
+	union hv_pending_events pending_events;
+	u8 no_eoi_required;
+	u8 reserved2[61];
+	u8 padding[4032];
+};
+
+struct sev_snp_runtime_data {
+	struct sev_hv_doorbell_page hv_doorbell_page;
+	/*
+	 * Indication that we are currently handling #HV events.
+	 */
+	bool hv_handling_events;
+};
+
+static DEFINE_PER_CPU(struct sev_snp_runtime_data*, snp_runtime_data);
+
+static inline u64 sev_es_rd_ghcb_msr(void)
+{
+	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
+}
+
+static __always_inline void sev_es_wr_ghcb_msr(u64 val)
+{
+	u32 low, high;
+
+	low  = (u32)(val);
+	high = (u32)(val >> 32);
+
+	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
+}
+
+struct sev_hv_doorbell_page *sev_snp_current_doorbell_page(void)
+{
+	return &this_cpu_read(snp_runtime_data)->hv_doorbell_page;
+}
+
+static u8 sev_hv_pending(void)
+{
+	return sev_snp_current_doorbell_page()->pending_events.events;
+}
+
+#define sev_hv_pending_nmi	\
+		sev_snp_current_doorbell_page()->pending_events.nmi
+
+static void hv_doorbell_apic_eoi_write(u32 reg, u32 val)
+{
+	if (xchg(&sev_snp_current_doorbell_page()->no_eoi_required, 0) & 0x1)
+		return;
+
+	BUG_ON(reg != APIC_EOI);
+	apic->write(reg, val);
+}
+
+static void do_exc_hv(struct pt_regs *regs)
+{
+	union hv_pending_events pending_events;
+
+	/* Avoid nested entry. */
+	if (this_cpu_read(snp_runtime_data)->hv_handling_events)
+		return;
+
+	this_cpu_read(snp_runtime_data)->hv_handling_events = true;
+
+	while (sev_hv_pending()) {
+		pending_events.events = xchg(
+			&sev_snp_current_doorbell_page()->pending_events.events,
+			0);
+
+		if (pending_events.nmi)
+			exc_nmi(regs);
+
+#ifdef CONFIG_X86_MCE
+		if (pending_events.mc)
+			exc_machine_check(regs);
+#endif
+
+		if (!pending_events.vector)
+			goto out;
+
+		if (pending_events.vector < FIRST_EXTERNAL_VECTOR) {
+			/* Exception vectors */
+			WARN(1, "exception shouldn't happen\n");
+		} else if (pending_events.vector == FIRST_EXTERNAL_VECTOR) {
+			sysvec_irq_move_cleanup(regs);
+		} else if (pending_events.vector == IA32_SYSCALL_VECTOR) {
+			WARN(1, "syscall shouldn't happen\n");
+		} else if (pending_events.vector >= FIRST_SYSTEM_VECTOR) {
+			switch (pending_events.vector) {
+#if IS_ENABLED(CONFIG_HYPERV)
+			case HYPERV_STIMER0_VECTOR:
+				sysvec_hyperv_stimer0(regs);
+				break;
+			case HYPERVISOR_CALLBACK_VECTOR:
+				sysvec_hyperv_callback(regs);
+				break;
+#endif
+#ifdef CONFIG_SMP
+			case RESCHEDULE_VECTOR:
+				sysvec_reschedule_ipi(regs);
+				break;
+			case IRQ_MOVE_CLEANUP_VECTOR:
+				sysvec_irq_move_cleanup(regs);
+				break;
+			case REBOOT_VECTOR:
+				sysvec_reboot(regs);
+				break;
+			case CALL_FUNCTION_SINGLE_VECTOR:
+				sysvec_call_function_single(regs);
+				break;
+			case CALL_FUNCTION_VECTOR:
+				sysvec_call_function(regs);
+				break;
+#endif
+#ifdef CONFIG_X86_LOCAL_APIC
+			case ERROR_APIC_VECTOR:
+				sysvec_error_interrupt(regs);
+				break;
+			case SPURIOUS_APIC_VECTOR:
+				sysvec_spurious_apic_interrupt(regs);
+				break;
+			case LOCAL_TIMER_VECTOR:
+				sysvec_apic_timer_interrupt(regs);
+				break;
+			case X86_PLATFORM_IPI_VECTOR:
+				sysvec_x86_platform_ipi(regs);
+				break;
+#endif
+			case 0x0:
+				break;
+			default:
+				panic("Unexpected vector %d\n", vector);
+				unreachable();
+			}
+		} else {
+			common_interrupt(regs, pending_events.vector);
+		}
+	}
+
+out:
+	this_cpu_read(snp_runtime_data)->hv_handling_events = false;
+}
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -181,18 +340,19 @@ void noinstr __sev_es_ist_enter(struct pt_regs *regs)
 	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
 }
 
-static void do_exc_hv(struct pt_regs *regs)
-{
-	/* Handle #HV exception. */
-}
-
 void check_hv_pending(struct pt_regs *regs)
 {
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
 
-	if ((regs->flags & X86_EFLAGS_IF) == 0)
+	/* Handle NMI when irq is disabled. */
+	if ((regs->flags & X86_EFLAGS_IF) == 0) {
+		if (sev_hv_pending_nmi) {
+			exc_nmi(regs);
+			sev_hv_pending_nmi = 0;
+		}
 		return;
+	}
 
 	do_exc_hv(regs);
 }
@@ -233,68 +393,35 @@ void noinstr __sev_es_ist_exit(void)
 	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
 }
 
-/*
- * Nothing shall interrupt this code path while holding the per-CPU
- * GHCB. The backup GHCB is only for NMIs interrupting this path.
- *
- * Callers must disable local interrupts around it.
- */
-static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
+static bool sev_restricted_injection_enabled(void)
+{
+	return sev_status & MSR_AMD64_SNP_RESTRICTED_INJ;
+}
+
+void __init sev_snp_init_hv_handling(void)
 {
 	struct sev_es_runtime_data *data;
+	struct ghcb_state state;
 	struct ghcb *ghcb;
+	unsigned long flags;
 
 	WARN_ON(!irqs_disabled());
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) || !sev_restricted_injection_enabled())
+		return;
 
 	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
-
-	if (unlikely(data->ghcb_active)) {
-		/* GHCB is already in use - save its contents */
-
-		if (unlikely(data->backup_ghcb_active)) {
-			/*
-			 * Backup-GHCB is also already in use. There is no way
-			 * to continue here so just kill the machine. To make
-			 * panic() work, mark GHCBs inactive so that messages
-			 * can be printed out.
-			 */
-			data->ghcb_active        = false;
-			data->backup_ghcb_active = false;
-
-			instrumentation_begin();
-			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
-			instrumentation_end();
-		}
-
-		/* Mark backup_ghcb active before writing to it */
-		data->backup_ghcb_active = true;
 
-		state->ghcb = &data->backup_ghcb;
+	local_irq_save(flags);
 
-		/* Backup GHCB content */
-		*state->ghcb = *ghcb;
-	} else {
-		state->ghcb = NULL;
-		data->ghcb_active = true;
-	}
+	ghcb = __sev_get_ghcb(&state);
 
-	return ghcb;
-}
+	sev_snp_setup_hv_doorbell_page(ghcb);
 
-static inline u64 sev_es_rd_ghcb_msr(void)
-{
-	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
-}
-
-static __always_inline void sev_es_wr_ghcb_msr(u64 val)
-{
-	u32 low, high;
+	__sev_put_ghcb(&state);
 
-	low  = (u32)(val);
-	high = (u32)(val >> 32);
+	apic_set_eoi_write(hv_doorbell_apic_eoi_write);
 
-	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
+	local_irq_restore(flags);
 }
 
 static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
@@ -555,6 +682,69 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
+/*
+ * Nothing shall interrupt this code path while holding the per-CPU
+ * GHCB. The backup GHCB is only for NMIs interrupting this path.
+ *
+ * Callers must disable local interrupts around it.
+ */
+static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	WARN_ON(!irqs_disabled());
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	if (unlikely(data->ghcb_active)) {
+		/* GHCB is already in use - save its contents */
+
+		if (unlikely(data->backup_ghcb_active)) {
+			/*
+			 * Backup-GHCB is also already in use. There is no way
+			 * to continue here so just kill the machine. To make
+			 * panic() work, mark GHCBs inactive so that messages
+			 * can be printed out.
+			 */
+			data->ghcb_active        = false;
+			data->backup_ghcb_active = false;
+
+			instrumentation_begin();
+			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
+			instrumentation_end();
+		}
+
+		/* Mark backup_ghcb active before writing to it */
+		data->backup_ghcb_active = true;
+
+		state->ghcb = &data->backup_ghcb;
+
+		/* Backup GHCB content */
+		*state->ghcb = *ghcb;
+	} else {
+		state->ghcb = NULL;
+		data->ghcb_active = true;
+	}
+
+	return ghcb;
+}
+
+static void sev_snp_setup_hv_doorbell_page(struct ghcb *ghcb)
+{
+	u64 pa;
+	enum es_result ret;
+
+	pa = __pa(sev_snp_current_doorbell_page());
+	vc_ghcb_invalidate(ghcb);
+	ret = vmgexit_hv_doorbell_page(ghcb,
+				       SVM_VMGEXIT_SET_HV_DOORBELL_PAGE,
+				       pa);
+	if (ret != ES_OK)
+		panic("SEV-SNP: failed to set up #HV doorbell page");
+}
+
 static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
@@ -1283,6 +1473,7 @@ static void snp_register_per_cpu_ghcb(void)
 	ghcb = &data->ghcb_page;
 
 	snp_register_ghcb_early(__pa(ghcb));
+	sev_snp_setup_hv_doorbell_page(ghcb);
 }
 
 void setup_ghcb(void)
@@ -1322,6 +1513,11 @@ void setup_ghcb(void)
 		snp_register_ghcb_early(__pa(&boot_ghcb_page));
 }
 
+int vmgexit_hv_doorbell_page(struct ghcb *ghcb, u64 op, u64 pa)
+{
+	return sev_es_ghcb_hv_call(ghcb, NULL, SVM_VMGEXIT_HV_DOORBELL_PAGE, op, pa);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static void sev_es_ap_hlt_loop(void)
 {
@@ -1395,6 +1591,7 @@ static void __init alloc_runtime_data(int cpu)
 static void __init init_ghcb(int cpu)
 {
 	struct sev_es_runtime_data *data;
+	struct sev_snp_runtime_data *snp_data;
 	int err;
 
 	data = per_cpu(runtime_data, cpu);
@@ -1406,6 +1603,19 @@ static void __init init_ghcb(int cpu)
 
 	memset(&data->ghcb_page, 0, sizeof(data->ghcb_page));
 
+	snp_data = memblock_alloc(sizeof(*snp_data), PAGE_SIZE);
+	if (!snp_data)
+		panic("Can't allocate SEV-SNP runtime data");
+
+	err = early_set_memory_decrypted((unsigned long)&snp_data->hv_doorbell_page,
+					 sizeof(snp_data->hv_doorbell_page));
+	if (err)
+		panic("Can't map #HV doorbell pages unencrypted");
+
+	memset(&snp_data->hv_doorbell_page, 0, sizeof(snp_data->hv_doorbell_page));
+
+	per_cpu(snp_runtime_data, cpu) = snp_data;
+
 	data->ghcb_active = false;
 	data->backup_ghcb_active = false;
 }
@@ -2046,7 +2256,12 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
 
 static bool hv_raw_handle_exception(struct pt_regs *regs)
 {
-	return false;
+	/* Clear the no_further_signal bit */
+	sev_snp_current_doorbell_page()->pending_events.events &= 0x7fff;
+
+	check_hv_pending(regs);
+
+	return true;
 }
 
 static __always_inline bool on_hv_fallback_stack(struct pt_regs *regs)
@@ -2360,3 +2575,25 @@ static int __init snp_init_platform_device(void)
 	return 0;
 }
 device_initcall(snp_init_platform_device);
+
+noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state)
+{
+	/*
+	 * Check whether this returns to user mode, if so and if
+	 * we are currently executing the #HV handler then we don't
+	 * want to follow the irqentry_exit_to_user_mode path as
+	 * that can potentially cause the #HV handler to be
+	 * preempted and rescheduled on another CPU. Rescheduled #HV
+	 * handler on another cpu will cause interrupts to be handled
+	 * on a different cpu than the injected one, causing
+	 * invalid EOIs and missed/lost guest interrupts and
+	 * corresponding hangs and/or per-cpu IRQs handled on
+	 * non-intended cpu.
+	 */
+	if (user_mode(regs) &&
+	    this_cpu_read(snp_runtime_data)->hv_handling_events)
+		return;
+
+	/* follow normal interrupt return/exit path */
+	irqentry_exit(regs, state);
+}
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 5dca05d0fa38..4f0f8dd2a5cb 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1521,5 +1521,7 @@ void __init trap_init(void)
 	cpu_init_exception_handling();
 	/* Setup traps as cpu_init() might #GP */
 	idt_setup_traps();
+	sev_snp_init_hv_handling();
+
 	cpu_init();
 }
-- 
2.25.1

