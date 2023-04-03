Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70AD6D4F79
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjDCRqM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjDCRoz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830613AA5;
        Mon,  3 Apr 2023 10:44:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso14457383pjf.0;
        Mon, 03 Apr 2023 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU2XDrJ3Un64sfFrjwv6qJG+nmpNESwNtX/Lvqu0+x0=;
        b=HHXLp6dko+hnaG/fOsuc38cmcR/JtFt3AG0R7K7tX8m72mduc7B0Rwcwqp2ulhio4f
         iio5NceLXdTltX/lA7k0Hu44bioSOX8l0zUUcT+z81d/tsxQ/st6gUreFTU4AwXd+UEp
         SqFR/OwOL/r6d7e/zuUWKHXDyk/KNW3YAMpnTP/RN3dSgtblQC1QfHDT0uXzdReMR4Ov
         BN/ULdQ/J/jRH1JBDlty6AnMw3LcbLG8ZuFhud6wdtYo2rthpBA45nToi5iFHRBJ+dex
         v3Zh3hW2XBGkvKQ9tKoCZHRJAtopVbY3zWuwgaRWygr8MyRATsC5yXWq76w/CA93B97U
         v7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LU2XDrJ3Un64sfFrjwv6qJG+nmpNESwNtX/Lvqu0+x0=;
        b=r2UNDsFz4jax/GkJoB8UJXuXicRDx4Nc7Ue/riBmpvgVJ0OPBOtjTiz1F3lod7T1MD
         yqVcFA3fWGzCRwCzqYA+XPOdNoIO09J8c/INB77h/kxzIz4yU7q1xQ0NhldMTpEFRsqc
         /IYDfvZVj0wzirnEppezWFZacsBCZt2J6tD9se0sSU/DhnYW5qLAfSYgdtxs2XCEStto
         qGQNmuYTG53c5bbD6vm9BLWCGUBrWzmaI8do25W4CmiOXsVBvZqQbCs3U0KFVB56b+s2
         wRDQsnu5RmJMa48qmWYfbqh3lFlFz90aqzGFAfMKa5qKREX5VZDg8rF6VgIp9rlEIFWP
         2iLA==
X-Gm-Message-State: AAQBX9eLXER/VU2Ta5f/gmEIf3G6+74yAqPM4SYhmoz7+LHRCJFhOcKh
        IizPZD96cx2ZUK3nE8YDuow=
X-Google-Smtp-Source: AKy350b1AygEIDPp0c+Uz33dG3LsrRD/5DPPJWUS32lZluaja4f86BReIhNKGFwxESQ3GeiLkRM4+g==
X-Received: by 2002:a17:902:ecc4:b0:1a1:d949:a52d with SMTP id a4-20020a170902ecc400b001a1d949a52dmr46465677plh.65.1680543868585;
        Mon, 03 Apr 2023 10:44:28 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:28 -0700 (PDT)
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
Subject: [RFC PATCH V4 14/17] x86/hyperv/sev: Add AMD sev-snp enlightened guest support on hyperv
Date:   Mon,  3 Apr 2023 13:44:02 -0400
Message-Id: <20230403174406.4180472-15-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403174406.4180472-1-ltykernel@gmail.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Change since RFC V3:
       * Check NMI event when irq is disabled.
       * Remove redundant variable
---
 arch/x86/include/asm/mem_encrypt.h |   2 +
 arch/x86/include/uapi/asm/svm.h    |   4 +
 arch/x86/kernel/sev.c              | 314 ++++++++++++++++++++++++-----
 arch/x86/kernel/traps.c            |   2 +
 4 files changed, 266 insertions(+), 56 deletions(-)

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
index 6445f5356c45..7fcb3b548215 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -122,6 +122,152 @@ struct sev_config {
 
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
+			return;
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
+}
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -179,18 +325,19 @@ void noinstr __sev_es_ist_enter(struct pt_regs *regs)
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
@@ -231,68 +378,35 @@ void noinstr __sev_es_ist_exit(void)
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
@@ -553,6 +667,69 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
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
@@ -1281,6 +1458,7 @@ static void snp_register_per_cpu_ghcb(void)
 	ghcb = &data->ghcb_page;
 
 	snp_register_ghcb_early(__pa(ghcb));
+	sev_snp_setup_hv_doorbell_page(ghcb);
 }
 
 void setup_ghcb(void)
@@ -1320,6 +1498,11 @@ void setup_ghcb(void)
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
@@ -1393,6 +1576,7 @@ static void __init alloc_runtime_data(int cpu)
 static void __init init_ghcb(int cpu)
 {
 	struct sev_es_runtime_data *data;
+	struct sev_snp_runtime_data *snp_data;
 	int err;
 
 	data = per_cpu(runtime_data, cpu);
@@ -1404,6 +1588,19 @@ static void __init init_ghcb(int cpu)
 
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
@@ -2044,7 +2241,12 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
 
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
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d29debec8134..1aa6cab2394b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1503,5 +1503,7 @@ void __init trap_init(void)
 	cpu_init_exception_handling();
 	/* Setup traps as cpu_init() might #GP */
 	idt_setup_traps();
+	sev_snp_init_hv_handling();
+
 	cpu_init();
 }
-- 
2.25.1

