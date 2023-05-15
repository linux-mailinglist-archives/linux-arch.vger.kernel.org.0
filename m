Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A06370357E
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 18:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbjEOQ73 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 12:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243329AbjEOQ71 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 12:59:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5900176B2;
        Mon, 15 May 2023 09:59:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6436dfa15b3so8796740b3a.1;
        Mon, 15 May 2023 09:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169965; x=1686761965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNbwXFv2h7AZXwLU50k/FuVXLnfww6LY5qbBZ9rC48g=;
        b=Bx6XKr7PQRwhm5jpN36C9grYSGQ9OdU2oCZ8W64cc8SAeHXJNQYoOPhvq/RcaXPupt
         +8PAEa9QcfUk7zWxOnTgAtj8zK3nR5LHu7mphkqVS5prdmwiNkZYRuMhrqCMfCQxD7AZ
         iqU1SZPqIWJ4AxKUjo7QWPM21WYy2gS2ZLBwKEIT/l0P1WzBdt7gFoa8x7wKCrxVOrK+
         w9es0/T9zs4qic05AJJ5a3a2BbBuefsMAw5hwe2SNigdQv9USEgG2mK2uJ0CisHc961J
         EcW7PsP1haRTNonSiyXiMdCXYKSf2cpt+qJj6Z1FiSX+3gOYxPS98ZZ5b/34nErh2tsY
         WapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169965; x=1686761965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNbwXFv2h7AZXwLU50k/FuVXLnfww6LY5qbBZ9rC48g=;
        b=X/USJCPEEhBGbbcA6CcnSv6OaJha2H5u5pxybUEZKJZ2/f6FjtuRn1IPhLfWykzgIJ
         oW7IHljTqJs4yPQOHXKXioQTzvAXS5Vx1PKrgueK9yT3MBHsl/2THyGsEMlLjIlVHby+
         iTBlJgaJJSWwddP3fi2f3F8mgeuvoX43k3odJ+2yiXVVpyOxhZjUmiebrDTVFEiVW2Lt
         mwClw9WY8uD73obJETqnUtKo0ic/XLQHZSbUtsHaPJhHtzgHIAYkcBQzshfOKRytS6SX
         ZEH2zKSO5mf2yRr8fQBi6zbPEzrm3tZd4p4enqHn/fgVLsrbV2YN618+DuenbGXoD6Fa
         g0BA==
X-Gm-Message-State: AC+VfDzfW0P6BMBjA1SjYCexloVwhpOfrLF4ReHOy7ExFD0PWszMdyUU
        0WPvbAbngnjfVd3k6wyMi8A=
X-Google-Smtp-Source: ACHHUZ6qva97b0CQidUd3KeHiuZMmFm2fHZAnT/0nKVQZwaVXkOCFAmDl2j6odNU45FVYogFjBfelA==
X-Received: by 2002:a05:6a20:158a:b0:103:6f15:5b49 with SMTP id h10-20020a056a20158a00b001036f155b49mr23411923pzj.46.1684169964596;
        Mon, 15 May 2023 09:59:24 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:85bb:dfc8:391f:ff73])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b0024df6bbf5d8sm2151pjp.30.2023.05.15.09.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:59:23 -0700 (PDT)
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
Subject: [RFC PATCH V6 01/14] x86/sev: Add a #HV exception handler
Date:   Mon, 15 May 2023 12:59:03 -0400
Message-Id: <20230515165917.1306922-2-ltykernel@gmail.com>
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

Add a #HV exception handler that uses IST stack.

Co-developed-by: Kalra Ashish <ashish.kalra@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V5:
       * Merge Ashish Kalr patch https://github.com/
       ashkalra/linux/commit/6975484094b7cb8d703c45066780dd85043cd040

Change since RFC V2:
       * Remove unnecessary line in the change log.
---
 arch/x86/entry/entry_64.S             | 22 ++++++----
 arch/x86/include/asm/cpu_entry_area.h |  6 +++
 arch/x86/include/asm/idtentry.h       | 40 +++++++++++++++++-
 arch/x86/include/asm/page_64_types.h  |  1 +
 arch/x86/include/asm/trapnr.h         |  1 +
 arch/x86/include/asm/traps.h          |  1 +
 arch/x86/kernel/cpu/common.c          |  1 +
 arch/x86/kernel/dumpstack_64.c        |  9 ++++-
 arch/x86/kernel/idt.c                 |  1 +
 arch/x86/kernel/sev.c                 | 53 ++++++++++++++++++++++++
 arch/x86/kernel/traps.c               | 58 +++++++++++++++++++++++++++
 arch/x86/mm/cpu_entry_area.c          |  2 +
 12 files changed, 183 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index eccc3431e515..653b1f10699b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -496,7 +496,7 @@ SYM_CODE_END(\asmsym)
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 /**
- * idtentry_vc - Macro to generate entry stub for #VC
+ * idtentry_sev - Macro to generate entry stub for #VC
  * @vector:		Vector number
  * @asmsym:		ASM symbol for the entry point
  * @cfunc:		C function to be called
@@ -515,14 +515,18 @@ SYM_CODE_END(\asmsym)
  *
  * The macro is only used for one vector, but it is planned to be extended in
  * the future for the #HV exception.
- */
-.macro idtentry_vc vector asmsym cfunc
+*/
+.macro idtentry_sev vector asmsym cfunc has_error_code:req
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
 	cld
 
+	.if \vector == X86_TRAP_HV
+		pushq	$-1			/* ORIG_RAX: no syscall */
+	.endif
+
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
 	 * a normal entry.
@@ -545,7 +549,12 @@ SYM_CODE_START(\asmsym)
 	 * stack.
 	 */
 	movq	%rsp, %rdi		/* pt_regs pointer */
-	call	vc_switch_off_ist
+	.if \vector == X86_TRAP_VC
+		call	vc_switch_off_ist
+	.else
+		call	hv_switch_off_ist	
+	.endif
+
 	movq	%rax, %rsp		/* Switch to new stack */
 
 	ENCODE_FRAME_POINTER
@@ -568,10 +577,7 @@ SYM_CODE_START(\asmsym)
 
 	/* Switch to the regular task stack */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_body user_\cfunc, has_error_code=1
-
-_ASM_NOKPROBE(\asmsym)
-SYM_CODE_END(\asmsym)
+	idtentry_body user_\cfunc, \has_error_code
 .endm
 #endif
 
diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 462fc34f1317..2186ed601b4a 100644
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
index b241af4ce9b4..b0f3501b2767 100644
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
+	__visible noinstr void kernel_##func(struct pt_regs *regs);	\
+	__visible noinstr void   user_##func(struct pt_regs *regs)
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
+	DEFINE_IDTENTRY_RAW(kernel_##func)
+
+/**
+ * DEFINE_IDTENTRY_HV_USER - Emit code for HV injection handler
+ *			     when raised from user mode
+ * @func:	Function name of the entry point
+ *
+ * Maps to DEFINE_IDTENTRY_RAW
+ */
+#define DEFINE_IDTENTRY_HV_USER(func)					\
+	DEFINE_IDTENTRY_RAW(user_##func)
+
 #else	/* CONFIG_X86_64 */
 
 /**
@@ -463,8 +496,10 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	DECLARE_IDTENTRY(vector, func)
 
 # define DECLARE_IDTENTRY_VC(vector, func)				\
-	idtentry_vc vector asm_##func func
+	idtentry_sev vector asm_##func func has_error_code=1
 
+# define DECLARE_IDTENTRY_HV(vector, func)				\
+	idtentry_sev vector asm_##func func has_error_code=0
 #else
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
@@ -618,9 +653,10 @@ DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_DF,	xenpv_exc_double_fault);
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
index 8cd4126d8253..5bc44bcf6e48 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2172,6 +2172,7 @@ static inline void tss_setup_ist(struct tss_struct *tss)
 	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
 	/* Only mapped when SEV-ES is active */
 	tss->x86_tss.ist[IST_INDEX_VC] = __this_cpu_ist_top_va(VC);
+	tss->x86_tss.ist[IST_INDEX_HV] = __this_cpu_ist_top_va(HV);
 }
 
 #else /* CONFIG_X86_64 */
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index f05339fee778..6d8f8864810c 100644
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
index b031244d6d2d..e25445de0957 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2006,6 +2006,59 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
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
+	irq_state = irqentry_enter(regs);
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
+	irqentry_exit(regs, irq_state);
+}
+
 bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 {
 	unsigned long exit_code = regs->orig_ax;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d317dc3d06a3..5dca05d0fa38 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -905,6 +905,64 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 
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
+	 * In the SYSCALL entry path the RSP value comes from user-space - don't
+	 * trust it and switch to the current kernel stack
+	 */
+	if (ip_within_syscall_gap(regs)) {
+		sp = this_cpu_read(pcpu_hot.top_of_stack);
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
+	/*
+	 * We support nested #HV exceptions once the IST stack is
+	 * switched out. The HV can always inject an #HV, but as per
+	 * GHCB specs, the HV will not inject another #HV, if
+	 * PendingEvent.NoFurtherSignal is set and we only clear this
+	 * after switching out the IST stack and handling the current
+	 * #HV. But there is still a window before the IST stack is
+	 * switched out, where a malicious HV can inject nested #HV.
+	 * The code below checks the interrupted stack to check if
+	 * it is the IST stack, and if so panic as this is
+	 * not supported and this nested #HV would have corrupted
+	 * the iret frame of the previous #HV on the IST stack.
+	 */
+	if (get_stack_info_noinstr(stack, current, &info) &&
+	    (info.type == (STACK_TYPE_EXCEPTION + ESTACK_HV) ||
+	     info.type == (STACK_TYPE_EXCEPTION + ESTACK_HV2)))
+		panic("Nested #HV exception, HV IST corrupted, stack type = %d\n", info.type);
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
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index e91500a80963..97554fa0ff30 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -160,6 +160,8 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
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

