Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3E62351E
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiKIUyv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiKIUyU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:20 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1910F2BC8;
        Wed,  9 Nov 2022 12:54:19 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p12so12726867plq.4;
        Wed, 09 Nov 2022 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3ui10Pv987LOIJnXt9IMElhmcFERFnmwtjj/3DP9Vs=;
        b=cGZl10FbTRyEJiocNwyGxLyZYbjG/pr7b0v2WBuOTBNbML7GRrT6cCSv0ITuPo7CXU
         WRVWw+Q3WasXF7D9LHkFeKTl9TyHFX+bWHLAXw7j4yuBKMET3z8iPJ/V2JIbCFsjUdAk
         /tn/7uni27TlixQKi/kjmctzK6+vkBCrMC2lKktsy0kD1IAE7/R5b0EGQ4J5UCfnH+Kv
         n8D2FaGJokn3FyZ6tnA29OLMZDVTdUwqnkotXpQQiwC/ZbFZcr5RbJ2nmpPlZ3QGgzvP
         nlIBp6USVd42GK5JoZy/gVFAnRKyuB+z7u0oMwTh6Y5pVvfS+K36rn/R299L8r0ZzoUw
         7gRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3ui10Pv987LOIJnXt9IMElhmcFERFnmwtjj/3DP9Vs=;
        b=t9IETTKr8SxDtW85FWu/jAgYkG6ccuZbgtrB/MfYMT3TmOh0DNHg5b7tJ86xdiitCh
         rTBwwONZDr9HugpbxW2VP3fYA9tZWLOvC4BKeh2M0vReATlpxS2at569zgRV9t67CrpJ
         JpxWD47LSGxL7GXpIV8mo+2d/PbC053nMkPAOcwjCiHg1GTN93BeRutg2PzssZFZHDX6
         ly//+rew/TpQU5LdUcfd0jOiyjGhAmHse6nl97NhdAjYLezoISY/Pi8Ji0Qp83x8PsMI
         ziXsC1rAeiGhUc0hOQ6+Sa14kBSyyIg+ooB/F1ldhjTG2PA0HgqS0tLeFV3eiR4YBzj3
         CJFw==
X-Gm-Message-State: ANoB5pk3+epLy9gk3O+dh7LLERHVpRtxhTk5BFFv91Azf/HGIdc3BQ5V
        2rEvx+6cGB1lKUA1vDobJ1o=
X-Google-Smtp-Source: AA0mqf47zUsIHcK4N+Pv8uFjEaPpDd6j/uxySGyP4P7b4W6Kn9C0c+qeFbOF8SLVKUcgkeAFklMiQA==
X-Received: by 2002:a17:902:708b:b0:188:853f:4dcd with SMTP id z11-20020a170902708b00b00188853f4dcdmr14835557plk.53.1668027258491;
        Wed, 09 Nov 2022 12:54:18 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:17 -0800 (PST)
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
Subject: [RFC PATCH 16/17] x86/sev: Add a #HV exception handler
Date:   Wed,  9 Nov 2022 15:53:51 -0500
Message-Id: <20221109205353.984745-17-ltykernel@gmail.com>
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

Add a #HV exception handler that uses IST stack.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/entry/entry_64.S             | 58 ++++++++++++++++++++++++++
 arch/x86/include/asm/cpu_entry_area.h |  6 +++
 arch/x86/include/asm/idtentry.h       | 39 +++++++++++++++++-
 arch/x86/include/asm/page_64_types.h  |  1 +
 arch/x86/include/asm/trapnr.h         |  1 +
 arch/x86/include/asm/traps.h          |  1 +
 arch/x86/kernel/cpu/common.c          |  1 +
 arch/x86/kernel/dumpstack_64.c        |  9 +++-
 arch/x86/kernel/idt.c                 |  1 +
 arch/x86/kernel/sev.c                 | 59 +++++++++++++++++++++++++++
 arch/x86/mm/cpu_entry_area.c          |  2 +
 11 files changed, 175 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9953d966d124..b2059df43c57 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -560,6 +560,64 @@ SYM_CODE_START(\asmsym)
 .Lfrom_usermode_switch_stack_\@:
 	idtentry_body user_\cfunc, has_error_code=1
 
+_ASM_NOKPROBE(\asmsym)
+SYM_CODE_END(\asmsym)
+.endm
+/*
+ * idtentry_hv - Macro to generate entry stub for #HV
+ * @vector:		Vector number
+ * @asmsym:		ASM symbol for the entry point
+ * @cfunc:		C function to be called
+ *
+ * The macro emits code to set up the kernel context for #HV. The #HV handler
+ * runs on an IST stack and needs to be able to support nested #HV exceptions.
+ *
+ * To make this work the #HV entry code tries its best to pretend it doesn't use
+ * an IST stack by switching to the task stack if coming from user-space (which
+ * includes early SYSCALL entry path) or back to the stack in the IRET frame if
+ * entered from kernel-mode.
+ *
+ * If entered from kernel-mode the return stack is validated first, and if it is
+ * not safe to use (e.g. because it points to the entry stack) the #HV handler
+ * will switch to a fall-back stack (HV2) and call a special handler function.
+ *
+ * The macro is only used for one vector, but it is planned to be extended in
+ * the future for the #HV exception.
+ */
+.macro idtentry_hv vector asmsym cfunc
+SYM_CODE_START(\asmsym)
+	UNWIND_HINT_IRET_REGS
+	ASM_CLAC
+	pushq	$-1			/* ORIG_RAX: no syscall to restart */
+
+	testb	$3, CS-ORIG_RAX(%rsp)
+	jnz	.Lfrom_usermode_switch_stack_\@
+
+	call	paranoid_entry
+
+	UNWIND_HINT_REGS
+
+	/*
+	 * Switch off the IST stack to make it free for nested exceptions.
+	 */
+	movq	%rsp, %rdi		/* pt_regs pointer */
+	call	hv_switch_off_ist
+	movq	%rax, %rsp		/* Switch to new stack */
+
+	UNWIND_HINT_REGS
+
+	/* Update pt_regs */
+	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
+	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
+
+	movq	%rsp, %rdi		/* pt_regs pointer */
+	call	kernel_\cfunc
+
+	jmp	paranoid_exit
+
+.Lfrom_usermode_switch_stack_\@:
+	idtentry_body user_\cfunc, has_error_code=1
+
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
 .endm
diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 75efc4c6f076..f173a16cfc59 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -30,6 +30,10 @@
 	char	VC_stack[optional_stack_size];			\
 	char	VC2_stack_guard[guardsize];			\
 	char	VC2_stack[optional_stack_size];			\
+	char	HV_stack_guard[guardsize];			\
+	char	HV_stack[optional_stack_size];			\
+	char	HV2_stack_guard[guardsize];			\
+	char	HV2_stack[optional_stack_size];			\
 	char	IST_top_guard[guardsize];			\
 
 /* The exception stacks' physical storage. No guard pages required */
@@ -52,6 +56,8 @@ enum exception_stack_ordering {
 	ESTACK_MCE,
 	ESTACK_VC,
 	ESTACK_VC2,
+	ESTACK_HV,
+	ESTACK_HV2,
 	N_EXCEPTION_STACKS
 };
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 72184b0b2219..ed68acd6f723 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -317,6 +317,19 @@ static __always_inline void __##func(struct pt_regs *regs)
 	__visible noinstr void kernel_##func(struct pt_regs *regs, unsigned long error_code);	\
 	__visible noinstr void   user_##func(struct pt_regs *regs, unsigned long error_code)
 
+
+/**
+ * DECLARE_IDTENTRY_HV - Declare functions for the HV entry point
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Maps to DECLARE_IDTENTRY_RAW, but declares also the user C handler.
+ */
+#define DECLARE_IDTENTRY_HV(vector, func)				\
+	DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func);			\
+	__visible noinstr void kernel_##func(struct pt_regs *regs, unsigned long error_code);	\
+	__visible noinstr void   user_##func(struct pt_regs *regs, unsigned long error_code)
+
 /**
  * DEFINE_IDTENTRY_IST - Emit code for IST entry points
  * @func:	Function name of the entry point
@@ -376,6 +389,26 @@ static __always_inline void __##func(struct pt_regs *regs)
 #define DEFINE_IDTENTRY_VC_USER(func)				\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(user_##func)
 
+/**
+ * DEFINE_IDTENTRY_HV_KERNEL - Emit code for HV injection handler
+ *			       when raised from kernel mode
+ * @func:	Function name of the entry point
+ *
+ * Maps to DEFINE_IDTENTRY_RAW
+ */
+#define DEFINE_IDTENTRY_HV_KERNEL(func)					\
+	DEFINE_IDTENTRY_RAW_ERRORCODE(kernel_##func)
+
+/**
+ * DEFINE_IDTENTRY_HV_USER - Emit code for HV injection handler
+ *			     when raised from user mode
+ * @func:	Function name of the entry point
+ *
+ * Maps to DEFINE_IDTENTRY_RAW
+ */
+#define DEFINE_IDTENTRY_HV_USER(func)					\
+	DEFINE_IDTENTRY_RAW_ERRORCODE(user_##func)
+
 #else	/* CONFIG_X86_64 */
 
 /**
@@ -465,6 +498,9 @@ __visible noinstr void func(struct pt_regs *regs,			\
 # define DECLARE_IDTENTRY_VC(vector, func)				\
 	idtentry_vc vector asm_##func func
 
+# define DECLARE_IDTENTRY_HV(vector, func)				\
+	idtentry_hv vector asm_##func func
+
 #else
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
@@ -622,9 +658,10 @@ DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_DF,	xenpv_exc_double_fault);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP,	exc_control_protection);
 #endif
 
-/* #VC */
+/* #VC & #HV */
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 DECLARE_IDTENTRY_VC(X86_TRAP_VC,	exc_vmm_communication);
+DECLARE_IDTENTRY_HV(X86_TRAP_HV,	exc_hv_injection);
 #endif
 
 #ifdef CONFIG_XEN_PV
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index e9e2c3ba5923..0bd7dab676c5 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -29,6 +29,7 @@
 #define	IST_INDEX_DB		2
 #define	IST_INDEX_MCE		3
 #define	IST_INDEX_VC		4
+#define	IST_INDEX_HV		5
 
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
diff --git a/arch/x86/include/asm/trapnr.h b/arch/x86/include/asm/trapnr.h
index f5d2325aa0b7..c6583631cecb 100644
--- a/arch/x86/include/asm/trapnr.h
+++ b/arch/x86/include/asm/trapnr.h
@@ -26,6 +26,7 @@
 #define X86_TRAP_XF		19	/* SIMD Floating-Point Exception */
 #define X86_TRAP_VE		20	/* Virtualization Exception */
 #define X86_TRAP_CP		21	/* Control Protection Exception */
+#define X86_TRAP_HV		28	/* HV injected exception in SNP restricted mode */
 #define X86_TRAP_VC		29	/* VMM Communication Exception */
 #define X86_TRAP_IRET		32	/* IRET Exception */
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 47ecfff2c83d..6795d3e517d6 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -16,6 +16,7 @@ asmlinkage __visible notrace
 struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs);
 void __init trap_init(void);
 asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
+asmlinkage __visible noinstr struct pt_regs *hv_switch_off_ist(struct pt_regs *eregs);
 #endif
 
 extern bool ibt_selftest(void);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f239098..87afa3a4c8b1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2165,6 +2165,7 @@ static inline void tss_setup_ist(struct tss_struct *tss)
 	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
 	/* Only mapped when SEV-ES is active */
 	tss->x86_tss.ist[IST_INDEX_VC] = __this_cpu_ist_top_va(VC);
+	tss->x86_tss.ist[IST_INDEX_HV] = __this_cpu_ist_top_va(HV);
 }
 
 #else /* CONFIG_X86_64 */
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 6c5defd6569a..23aa5912c87a 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -26,11 +26,14 @@ static const char * const exception_stack_names[] = {
 		[ ESTACK_MCE	]	= "#MC",
 		[ ESTACK_VC	]	= "#VC",
 		[ ESTACK_VC2	]	= "#VC2",
+		[ ESTACK_HV	]	= "#HV",
+		[ ESTACK_HV2	]	= "#HV2",
+		
 };
 
 const char *stack_type_name(enum stack_type type)
 {
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 8);
 
 	if (type == STACK_TYPE_TASK)
 		return "TASK";
@@ -89,6 +92,8 @@ struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
 	EPAGERANGE(MCE),
 	EPAGERANGE(VC),
 	EPAGERANGE(VC2),
+	EPAGERANGE(HV),
+	EPAGERANGE(HV2),
 };
 
 static __always_inline bool in_exception_stack(unsigned long *stack, struct stack_info *info)
@@ -98,7 +103,7 @@ static __always_inline bool in_exception_stack(unsigned long *stack, struct stac
 	struct pt_regs *regs;
 	unsigned int k;
 
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 8);
 
 	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
 	/*
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index a58c6bc1cd68..48c0a7e1dbcb 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -113,6 +113,7 @@ static const __initconst struct idt_data def_idts[] = {
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	ISTG(X86_TRAP_VC,		asm_exc_vmm_communication, IST_INDEX_VC),
+	ISTG(X86_TRAP_HV,		asm_exc_hv_injection, IST_INDEX_HV),
 #endif
 
 	SYSG(X86_TRAP_OF,		asm_exc_overflow),
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a428c62330d3..63ddb043d16d 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2004,6 +2004,65 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
 	irqentry_exit_to_user_mode(regs);
 }
 
+static bool hv_raw_handle_exception(struct pt_regs *regs)
+{
+	return false;
+}
+
+static __always_inline bool on_hv_fallback_stack(struct pt_regs *regs)
+{
+	unsigned long sp = (unsigned long)regs;
+
+	return (sp >= __this_cpu_ist_bottom_va(HV2) && sp < __this_cpu_ist_top_va(HV2));
+}
+
+DEFINE_IDTENTRY_HV_USER(exc_hv_injection)
+{
+	irqentry_enter_from_user_mode(regs);
+	instrumentation_begin();
+
+	if (!hv_raw_handle_exception(regs)) {
+		/*
+		 * Do not kill the machine if user-space triggered the
+		 * exception. Send SIGBUS instead and let user-space deal
+		 * with it.
+		 */
+		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
+	}
+
+	instrumentation_end();
+	irqentry_exit_to_user_mode(regs);
+}
+
+DEFINE_IDTENTRY_HV_KERNEL(exc_hv_injection)
+{
+	irqentry_state_t irq_state;
+
+	if (unlikely(on_hv_fallback_stack(regs))) {
+	        instrumentation_begin();
+	        panic("Can't handle #HV exception from unsupported context\n");
+	        instrumentation_end();
+	}
+
+	irq_state = irqentry_nmi_enter(regs);
+	instrumentation_begin();
+
+	if (!hv_raw_handle_exception(regs)) {
+		pr_emerg("PANIC: Unhandled #HV exception in kernel space\n");
+	
+		/* Show some debug info */
+		show_regs(regs);
+	
+		/* Ask hypervisor to sev_es_terminate */
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+	
+		panic("Returned from Terminate-Request to Hypervisor\n");
+	}
+
+	instrumentation_end();
+	irqentry_nmi_exit(regs, irq_state);
+}
+
 bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 {
 	unsigned long exit_code = regs->orig_ax;
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 6c2f1b76a0b6..608905dc6704 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -115,6 +115,8 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
 			cea_map_stack(VC);
 			cea_map_stack(VC2);
+			cea_map_stack(HV);
+			cea_map_stack(HV2);			
 		}
 	}
 }
-- 
2.25.1

