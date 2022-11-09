Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62324623523
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiKIUy6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiKIUyh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:37 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22E3120C;
        Wed,  9 Nov 2022 12:54:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v17so18240629plo.1;
        Wed, 09 Nov 2022 12:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65yOPLfe/DFH9Ui4MHop44XuRa0prooc02CDBjHaLHw=;
        b=K4HHXzTsRTTiNIwK3BimmyIMN6QTIY7ewF5k0k33HH43w+N0NTCgSEu/7+HeVwvfE2
         f/kwX2vZa/2eADx9Qss0DzwvWClXNVDIO3avyLGwZynl3qo1K54lBbB5ROF368Wc6IzI
         Vo/3czsh1drBs/QSmcihySXY2kccL56mHXt/7ZWa3y6ANpwPDbfwo4fMFX8n9ME378Gh
         QKD1TklbQtjl0OloaanhXdzMXH2MHgNOAstFCVJhcCZSHVfgbOALsY0rTyIT+WG5wg9h
         XNB984fZTwnQJFxEioUHwiwTgoIIkcOzDrZCxrV5jtIlC8e+85XN7dxtkHBgdJuTQRqE
         ihgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65yOPLfe/DFH9Ui4MHop44XuRa0prooc02CDBjHaLHw=;
        b=dRhIGmDhpqb1TOPuNHL0iTWrwQXtYTirvffWz3YZ77QExdxBscSzagw7dES5FSa/GX
         yrOf8yBfptJkiXpsCIfshAttyyGqX5cfYOqDn+U2cx+M6KU26+5dxLzMuCVSc1VMvFkW
         6GUmkvSyMRwxYKgEgYpAV+g86oWDQleSVZq4gYM1wt04W2wMGwiH7NvMhpXiS76REz0d
         PxPV8NdmGtCWox44TWR0KnMW5+QSy52AovBeKMJXw2Fmt5JUxtjKSsAUNdsUk19hxD5o
         JhL3hVak1kcMMen/Rd5qhRLjj6NzUwXy2py/cQK81C+lEuEuLTL8U0myepKouGWclFfo
         HqVg==
X-Gm-Message-State: ACrzQf1aR64nN9t6V9yAeUJbAkXppEMclqiMsqwvk3LPXDgfy3kpGqoB
        iXkdOROVLLu+S2nJGf5zdfQ=
X-Google-Smtp-Source: AMsMyM6d/nO03+pJx4ijKqNXJHD6y+zoYs3XLDQoqBZAboaCaV9fMbanBOXNK6JacCzAI7Bh+IBvjQ==
X-Received: by 2002:a17:902:9a43:b0:188:5256:bf42 with SMTP id x3-20020a1709029a4300b001885256bf42mr35799651plv.69.1668027259836;
        Wed, 09 Nov 2022 12:54:19 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:19 -0800 (PST)
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
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH 17/17] x86/sev: Initialize #HV doorbell and handle interrupt requests
Date:   Wed,  9 Nov 2022 15:53:52 -0500
Message-Id: <20221109205353.984745-18-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109205353.984745-1-ltykernel@gmail.com>
References: <20221109205353.984745-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Enable #HV exception to handle interrupt requests from hypervisor.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/entry/entry_64.S          |  18 ++
 arch/x86/include/asm/irqflags.h    |  19 ++
 arch/x86/include/asm/mem_encrypt.h |   2 +
 arch/x86/include/asm/msr-index.h   |   6 +
 arch/x86/include/uapi/asm/svm.h    |   4 +
 arch/x86/kernel/sev.c              | 327 ++++++++++++++++++++++++-----
 arch/x86/kernel/traps.c            |  50 +++++
 7 files changed, 373 insertions(+), 53 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b2059df43c57..fe460cf44ab5 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1058,6 +1058,15 @@ SYM_CODE_END(paranoid_entry)
  * R15 - old SPEC_CTRL
  */
 SYM_CODE_START_LOCAL(paranoid_exit)
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/*
+	 * If a #HV was delivered during execution and interrupts were
+	 * disabled, then check if it can be handled before the iret
+	 * (which may re-enable interrupts).
+	 */
+	mov     %rsp, %rdi
+	call    check_hv_pending
+#endif
 	UNWIND_HINT_REGS
 
 	/*
@@ -1183,6 +1192,15 @@ SYM_CODE_START_LOCAL(error_entry)
 SYM_CODE_END(error_entry)
 
 SYM_CODE_START_LOCAL(error_return)
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/*
+	 * If a #HV was delivered during execution and interrupts were
+	 * disabled, then check if it can be handled before the iret
+	 * (which may re-enable interrupts).
+	 */
+	mov     %rsp, %rdi
+	call    check_hv_pending
+#endif
 	UNWIND_HINT_REGS
 	DEBUG_ENTRY_ASSERT_IRQS_OFF
 	testb	$3, CS(%rsp)
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 7793e52d6237..e0730d8bc0ac 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -14,6 +14,9 @@
 /*
  * Interrupt control:
  */
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+void check_hv_pending(struct pt_regs *regs);
+#endif
 
 /* Declaration required for gcc < 4.9 to prevent -Werror=missing-prototypes */
 extern inline unsigned long native_save_fl(void);
@@ -35,6 +38,19 @@ extern __always_inline unsigned long native_save_fl(void)
 	return flags;
 }
 
+extern inline void native_restore_fl(unsigned long flags)
+{
+	asm volatile("push %0 ; popf"
+		     : /* no output */
+		     : "g" (flags)
+		     : "memory", "cc");
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	if ((flags & X86_EFLAGS_IF)) {
+		check_hv_pending(NULL);
+	}
+#endif
+}
+
 static __always_inline void native_irq_disable(void)
 {
 	asm volatile("cli": : :"memory");
@@ -43,6 +59,9 @@ static __always_inline void native_irq_disable(void)
 static __always_inline void native_irq_enable(void)
 {
 	asm volatile("sti": : :"memory");
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	check_hv_pending(NULL);
+#endif
 }
 
 static inline __cpuidle void native_safe_halt(void)
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 72ca90552b6a..7264ca5f5b2d 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -50,6 +50,7 @@ void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
 void __init mem_encrypt_free_decrypted_mem(void);
 
 void __init sev_es_init_vc_handling(void);
+void __init sev_snp_init_hv_handling(void);
 
 #define __bss_decrypted __section(".bss..decrypted")
 
@@ -72,6 +73,7 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
+static inline void sev_snp_init_hv_handling(void) { }
 
 static inline int __init
 early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 10ac52705892..6fe25a6e325f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -562,10 +562,16 @@
 #define MSR_AMD64_SEV_ENABLED_BIT	0
 #define MSR_AMD64_SEV_ES_ENABLED_BIT	1
 #define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
+#define MSR_AMD64_SEV_REFLECTVC_ENABLED_BIT		4
+#define MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED_BIT	5
+#define MSR_AMD64_SEV_ALTERNATE_INJECTION_ENABLED_BIT	6
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
 #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
 
+#define MSR_AMD64_SEV_REFLECTVC_ENABLED			BIT_ULL(MSR_AMD64_SEV_REFLECTVC_ENABLED_BIT)
+#define MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED	BIT_ULL(MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED_BIT)
+#define MSR_AMD64_SEV_ALTERNATE_INJECTION_ENABLED	BIT_ULL(MSR_AMD64_SEV_ALTERNATE_INJECTION_ENABLED_BIT)
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
 /* AMD Collaborative Processor Performance Control MSRs */
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index f69c168391aa..85d6882262e7 100644
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
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 63ddb043d16d..65eb9f96d0c4 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -104,6 +104,12 @@ struct sev_es_runtime_data {
 	 * is currently unsupported in SEV-ES guests.
 	 */
 	unsigned long dr7;
+	/*
+	 * SEV-SNP requires that the GHCB must be registered before using it.
+	 * The flag below will indicate whether the GHCB is registered, if its
+	 * not registered then sev_es_get_ghcb() will perform the registration.
+	 */
+	bool ghcb_registered;
 };
 
 struct ghcb_state {
@@ -122,6 +128,156 @@ struct sev_config {
 
 static struct sev_config sev_cfg __read_mostly;
 
+static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state);
+static noinstr void __sev_put_ghcb(struct ghcb_state *state);
+static int vmgexit_hv_doorbell_page(struct ghcb *ghcb, u64 op, u64 pa);
+static void sev_snp_setup_hv_doorbell_page(struct ghcb *ghcb);
+
+struct sev_hv_doorbell_page {
+	union {
+		u16 pending_events;
+		struct {
+			u8 vector;
+			u8 nmi : 1;
+			u8 mc : 1;
+			u8 reserved1 : 5;
+			u8 no_further_signal : 1;
+		};
+	};
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
+	return sev_snp_current_doorbell_page()->vector;
+}
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
+	u8 vector;
+
+	while (sev_hv_pending()) {
+		asm volatile("cli" : : : "memory");
+
+		vector = xchg(&sev_snp_current_doorbell_page()->vector, 0);
+
+		switch (vector) {
+#if IS_ENABLED(CONFIG_HYPERV)
+		case HYPERV_STIMER0_VECTOR:
+			sysvec_hyperv_stimer0(regs);
+			break;
+		case HYPERVISOR_CALLBACK_VECTOR:
+			sysvec_hyperv_callback(regs);
+			break;
+#endif
+#ifdef CONFIG_SMP
+		case RESCHEDULE_VECTOR:
+			sysvec_reschedule_ipi(regs);
+			break;
+		case IRQ_MOVE_CLEANUP_VECTOR:
+			sysvec_irq_move_cleanup(regs);
+			break;
+		case REBOOT_VECTOR:
+			sysvec_reboot(regs);
+			break;
+		case CALL_FUNCTION_SINGLE_VECTOR:
+			sysvec_call_function_single(regs);
+			break;
+		case CALL_FUNCTION_VECTOR:
+			sysvec_call_function(regs);
+			break;
+#endif
+#ifdef CONFIG_X86_LOCAL_APIC
+		case ERROR_APIC_VECTOR:
+			sysvec_error_interrupt(regs);
+			break;
+		case SPURIOUS_APIC_VECTOR:
+			sysvec_spurious_apic_interrupt(regs);
+			break;
+		case LOCAL_TIMER_VECTOR:
+			sysvec_apic_timer_interrupt(regs);
+			break;
+		case X86_PLATFORM_IPI_VECTOR:
+			sysvec_x86_platform_ipi(regs);
+			break;
+#endif
+		case 0x0:
+			break;
+		default:
+			panic("Unexpected vector %d\n", vector);
+			unreachable();
+		}
+
+		asm volatile("sti" : : : "memory");
+	}
+}
+
+void check_hv_pending(struct pt_regs *regs)
+{
+	struct pt_regs local_regs;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	if (regs) {
+		if ((regs->flags & X86_EFLAGS_IF) == 0)
+			return;
+
+		if (!sev_hv_pending())
+			return;
+
+		do_exc_hv(regs);
+	} else {
+		if (sev_hv_pending()) {
+			memset(&local_regs, 0, sizeof(struct pt_regs));
+			regs = &local_regs;
+			asm volatile("movl %%cs, %%eax;" : "=a" (regs->cs));
+			asm volatile("movl %%ss, %%eax;" : "=a" (regs->ss));
+			regs->orig_ax = 0xffffffff;
+			regs->flags = native_save_fl();
+			do_exc_hv(regs);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(check_hv_pending);
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -193,68 +349,35 @@ void noinstr __sev_es_ist_exit(void)
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
 {
-	struct sev_es_runtime_data *data;
+	return sev_status & MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED;
+}
+
+void __init sev_snp_init_hv_handling(void)
+{
+	struct sev_snp_runtime_data *snp_data;
+	struct ghcb_state state;
 	struct ghcb *ghcb;
+	unsigned long flags;
+	int cpu;
+	int err;
 
 	WARN_ON(!irqs_disabled());
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) || !sev_restricted_injection_enabled())
+		return;
 
-	data = this_cpu_read(runtime_data);
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
-
-		state->ghcb = &data->backup_ghcb;
-
-		/* Backup GHCB content */
-		*state->ghcb = *ghcb;
-	} else {
-		state->ghcb = NULL;
-		data->ghcb_active = true;
-	}
+	local_irq_save(flags);
 
-	return ghcb;
-}
+	ghcb = __sev_get_ghcb(&state);
 
-static inline u64 sev_es_rd_ghcb_msr(void)
-{
-	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
-}
+	sev_snp_setup_hv_doorbell_page(ghcb);
 
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
@@ -515,6 +638,79 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
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
+	/* SEV-SNP guest requires that GHCB must be registered before using it. */
+	if (!data->ghcb_registered) {
+		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+			snp_register_ghcb_early(__pa(ghcb));
+			sev_snp_setup_hv_doorbell_page(ghcb);
+		} else {
+			sev_es_wr_ghcb_msr(__pa(ghcb));
+		}
+		data->ghcb_registered = true;
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
+			SVM_VMGEXIT_SET_HV_DOORBELL_PAGE, pa);
+	if (ret != ES_OK)
+		panic("SEV-SNP: failed to set up #HV doorbell page");
+}
+
 static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
@@ -1282,6 +1478,11 @@ void setup_ghcb(void)
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
@@ -1355,6 +1556,7 @@ static void __init alloc_runtime_data(int cpu)
 static void __init init_ghcb(int cpu)
 {
 	struct sev_es_runtime_data *data;
+	struct sev_snp_runtime_data *snp_data;
 	int err;
 
 	data = per_cpu(runtime_data, cpu);
@@ -1366,8 +1568,22 @@ static void __init init_ghcb(int cpu)
 
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
+	data->ghcb_registered = false;
 }
 
 void __init sev_es_init_vc_handling(void)
@@ -2006,7 +2222,12 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
 
 static bool hv_raw_handle_exception(struct pt_regs *regs)
 {
-	return false;
+	/* Clear the no_further_signal bit */
+	sev_snp_current_doorbell_page()->pending_events &= 0x7fff;
+
+	check_hv_pending(regs);
+
+	return true;
 }
 
 static __always_inline bool on_hv_fallback_stack(struct pt_regs *regs)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 178015a820f0..af97e6610fbb 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -898,6 +898,53 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 
 	return regs_ret;
 }
+
+asmlinkage __visible noinstr struct pt_regs *hv_switch_off_ist(struct pt_regs *regs)
+{
+	unsigned long sp, *stack;
+	struct stack_info info;
+	struct pt_regs *regs_ret;
+
+	/*
+	 * A malicious hypervisor can inject 2 HVs in a row, which will corrupt
+	 * the trap frame on our IST stack.  We add a defensive check here to
+	 * catch such behavior.
+	 */
+	BUG_ON(regs->sp >= __this_cpu_ist_bottom_va(HV) && regs->sp < __this_cpu_ist_top_va(HV));
+
+	/*
+	 * In the SYSCALL entry path the RSP value comes from user-space - don't
+	 * trust it and switch to the current kernel stack
+	 */
+	if (ip_within_syscall_gap(regs)) {
+		sp = this_cpu_read(cpu_current_top_of_stack);
+		goto sync;
+	}
+
+	/*
+	 * From here on the RSP value is trusted. Now check whether entry
+	 * happened from a safe stack. Not safe are the entry or unknown stacks,
+	 * use the fall-back stack instead in this case.
+	 */
+	sp    = regs->sp;
+	stack = (unsigned long *)sp;
+
+	if (!get_stack_info_noinstr(stack, current, &info) || info.type == STACK_TYPE_ENTRY ||
+	    info.type > STACK_TYPE_EXCEPTION_LAST)
+		sp = __this_cpu_ist_top_va(HV2);
+sync:
+	/*
+	 * Found a safe stack - switch to it as if the entry didn't happen via
+	 * IST stack. The code below only copies pt_regs, the real switch happens
+	 * in assembly code.
+	 */
+	sp = ALIGN_DOWN(sp, 8) - sizeof(*regs_ret);
+
+	regs_ret = (struct pt_regs *)sp;
+	*regs_ret = *regs;
+
+	return regs_ret;
+}
 #endif
 
 asmlinkage __visible noinstr struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs)
@@ -1457,4 +1504,7 @@ void __init trap_init(void)
 	/* Setup traps as cpu_init() might #GP */
 	idt_setup_traps();
 	cpu_init();
+
+	/* Init #HV doorbell pages when running as an SEV-SNP guest */
+	sev_snp_init_hv_handling();
 }
-- 
2.25.1

