Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA31630B7A
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiKSDtG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiKSDrl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:47:41 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139F7BF817;
        Fri, 18 Nov 2022 19:47:01 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so6349640pjb.0;
        Fri, 18 Nov 2022 19:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrCNSp1R8NV5FdK0kNmKFSIJaMlv9YlqQVpAgSEGk/U=;
        b=qmJOHex8TgtJHTc4EJCANfTxPKFE0DFT5WQlikkpW6/E95emJ3yJ9+AEtYJ4XFdGtK
         iFgiaNoT2c2I9E+J25QtjSP2TvxfmkvQzD5g0OEcXeUS+iP8ivjKh7NV6r2KYnPEouOF
         1G4Yu64TnEF56COKbdtp4R0ye54Mrut3tHOELS/XQDpSWisoKtkPBB8SXuJhO1xJqbE3
         z07+IqnkM8FFqjXz8tIlVol+sYXbJ4VdcGUq2VJzOgONPCznGhfetM5st0l/3ZMHOOxt
         y0OdrE0T6HStGcYgyTeCBljn+f5U9ezXTKsElLr7LuEf/WnNLZlf+kR8cFHHyve6WevH
         1YHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrCNSp1R8NV5FdK0kNmKFSIJaMlv9YlqQVpAgSEGk/U=;
        b=Il3Lml8XgqXYsVnpW3vi2Z0jeOnoSrcGK/tcmUKWV61TcRhbf9w3qstiGVHAgY2Uhb
         fR5BRQ9VoNb6ex78hsqhTS6jpZlIy3vBTUIXQDCUrB3t+i/O/xh0cq+khZaasXYOrm/H
         FVhkp7KJ3PjamAohHuBiFISWm+Yd2y9RR1sAjgPgK70MMCz7+m2NYSp9j37MLI1+Zy3b
         WDmx5TYNHpKIpHlYbo0Xhu+vAjBYPFBiDAZxM785RiKQcGgUQuXdqqZWtSA/ob6P5GCT
         wbbcSQ4/aVwC1oVIKux3GLuONphj4/FMCizmgAfQxjVDWYlgk0nBk6300kfe+Yn+caLx
         w4NA==
X-Gm-Message-State: ANoB5pnTAQIiaXvunK0IiYT01TY0+NKs+XKo35cQUqbgNoFSMSamcqub
        QhqIHZLzCX8i0MQOyxR/eVo=
X-Google-Smtp-Source: AA0mqf5QAQbK9WuXaHspsVhhKfQtAZfD/7+0PUmpk+48x6SP83pquo+unM2BTvhoLowpkBMy2jZwsQ==
X-Received: by 2002:a17:902:a386:b0:189:1076:7dbe with SMTP id x6-20020a170902a38600b0018910767dbemr192864pla.68.1668829620470;
        Fri, 18 Nov 2022 19:47:00 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:47:00 -0800 (PST)
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
Subject: [RFC PATCH V2 16/18] x86/sev: Initialize #HV doorbell and handle interrupt requests
Date:   Fri, 18 Nov 2022 22:46:30 -0500
Message-Id: <20221119034633.1728632-17-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221119034633.1728632-1-ltykernel@gmail.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
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

Co-developed-by: Lendacky Thomas <thomas.lendacky@amd.com>
Co-developed-by: Kalra Ashish <ashish.kalra@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/entry/entry_64.S          |  18 ++
 arch/x86/include/asm/irqflags.h    |  19 ++
 arch/x86/include/asm/mem_encrypt.h |   2 +
 arch/x86/include/asm/msr-index.h   |   6 +
 arch/x86/include/uapi/asm/svm.h    |   4 +
 arch/x86/kernel/sev.c              | 354 ++++++++++++++++++++++++-----
 arch/x86/kernel/traps.c            |  50 ++++
 7 files changed, 400 insertions(+), 53 deletions(-)

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
index b54ee3ba37b0..23cd025f97dc 100644
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
@@ -122,6 +128,183 @@ struct sev_config {
 
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
+	u8 vector;
+
+	while (sev_hv_pending()) {
+		asm volatile("cli" : : : "memory");
+
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
@@ -193,68 +376,35 @@ void noinstr __sev_es_ist_exit(void)
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
@@ -515,6 +665,79 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
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
@@ -1282,6 +1505,11 @@ void setup_ghcb(void)
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
@@ -1355,6 +1583,7 @@ static void __init alloc_runtime_data(int cpu)
 static void __init init_ghcb(int cpu)
 {
 	struct sev_es_runtime_data *data;
+	struct sev_snp_runtime_data *snp_data;
 	int err;
 
 	data = per_cpu(runtime_data, cpu);
@@ -1366,8 +1595,22 @@ static void __init init_ghcb(int cpu)
 
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
@@ -2006,7 +2249,12 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
 
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

