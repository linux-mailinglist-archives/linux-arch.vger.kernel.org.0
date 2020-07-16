Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3A5222C41
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 21:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgGPTvH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 15:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgGPTu6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 15:50:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6034BC08C5C0;
        Thu, 16 Jul 2020 12:50:58 -0700 (PDT)
Message-Id: <20200716185425.198080509@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594929057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+01HYjN82B7X1zjGIPOd0Udv26XprPXO1fOLOOWkUwo=;
        b=qxwl67rGF65/8LpO2yQMYsuxcjnpUIKwp5Z9V+k2X422hUmOfzwpjqMivirp2hxsxKINCn
        E6gL8K9v+nwdSgH1Jl1RRoLfAyH7qCkDXeFwe4zeBP4LrsTVhLYZaulH0QV/zNuqeMZS+J
        G1/JnCLaNZyEnR6XIggP8J/CS4GCk2aKudmNVUoXqTKGFMvFz9spgW2kN1ZVJuRSpkCdFW
        pdx9aHdCrHsTScyM+oKUBTsI4CsXoEdkB+HtizJRjCPgMcgnf7UUJR6emlX2XWr0MG16Jf
        IqTW5mJviAo9EC6IPBf6DyPdF6FmODq6D/RVdjs5pO/aNHzLMdM67rjMCa5k4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594929057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+01HYjN82B7X1zjGIPOd0Udv26XprPXO1fOLOOWkUwo=;
        b=e6UtrLMDT0xDjU4UI6NodhXXUo01vylAcJW7xLjbV5cUufGN6+kv8tRG1d3YmM+/9lndt9
        EYKdiwj4qrRGsxBQ==
Date:   Thu, 16 Jul 2020 20:22:20 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [patch V3 12/13] x86/entry: Cleanup idtentry_enter/exit
References: <20200716182208.180916541@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove the temporary defines and fixup all references.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c         |    6 +++---
 arch/x86/include/asm/idtentry.h |   33 ++++++++++++++-------------------
 arch/x86/kernel/kvm.c           |    6 +++---
 arch/x86/kernel/traps.c         |    6 +++---
 arch/x86/mm/fault.c             |    6 +++---
 5 files changed, 26 insertions(+), 31 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -248,9 +248,9 @@ static void __xen_pv_evtchn_do_upcall(vo
 {
 	struct pt_regs *old_regs;
 	bool inhcall;
-	idtentry_state_t state;
+	irqentry_state_t state;
 
-	state = idtentry_enter(regs);
+	state = irqentry_enter(regs);
 	old_regs = set_irq_regs(regs);
 
 	instrumentation_begin();
@@ -266,7 +266,7 @@ static void __xen_pv_evtchn_do_upcall(vo
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
-		idtentry_exit(regs, state);
+		irqentry_exit(regs, state);
 	}
 }
 #endif /* CONFIG_XEN_PV */
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,11 +11,6 @@
 
 #include <asm/irq_stack.h>
 
-/* Temporary defines */
-typedef irqentry_state_t idtentry_state_t;
-#define idtentry_enter irqentry_enter
-#define idtentry_exit irqentry_exit
-
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
@@ -45,8 +40,8 @@ typedef irqentry_state_t idtentry_state_
  * The macro is written so it acts as function definition. Append the
  * body with a pair of curly brackets.
  *
- * idtentry_enter() contains common code which has to be invoked before
- * arbitrary code in the body. idtentry_exit() contains common code
+ * irqentry_enter() contains common code which has to be invoked before
+ * arbitrary code in the body. irqentry_exit() contains common code
  * which has to run before returning to the low level assembly code.
  */
 #define DEFINE_IDTENTRY(func)						\
@@ -54,12 +49,12 @@ static __always_inline void __##func(str
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	idtentry_state_t state = idtentry_enter(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	__##func (regs);						\
 	instrumentation_end();						\
-	idtentry_exit(regs, state);					\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
@@ -101,12 +96,12 @@ static __always_inline void __##func(str
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	idtentry_state_t state = idtentry_enter(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	__##func (regs, error_code);					\
 	instrumentation_end();						\
-	idtentry_exit(regs, state);					\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs,		\
@@ -161,7 +156,7 @@ static __always_inline void __##func(str
  * body with a pair of curly brackets.
  *
  * Contrary to DEFINE_IDTENTRY_ERRORCODE() this does not invoke the
- * idtentry_enter/exit() helpers before and after the body invocation. This
+ * irqentry_enter/exit() helpers before and after the body invocation. This
  * needs to be done in the body itself if applicable. Use if extra work
  * is required before the enter/exit() helpers are invoked.
  */
@@ -197,7 +192,7 @@ static __always_inline void __##func(str
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	idtentry_state_t state = idtentry_enter(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
@@ -205,7 +200,7 @@ static __always_inline void __##func(str
 	__##func (regs, (u8)error_code);				\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
-	idtentry_exit(regs, state);					\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector)
@@ -229,7 +224,7 @@ static __always_inline void __##func(str
  * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
  * @func:	Function name of the entry point
  *
- * idtentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
+ * irqentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
  * function body. KVM L1D flush request is set.
  *
  * Runs the function on the interrupt stack if the entry hit kernel mode
@@ -239,7 +234,7 @@ static void __##func(struct pt_regs *reg
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	idtentry_state_t state = idtentry_enter(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
@@ -247,7 +242,7 @@ static void __##func(struct pt_regs *reg
 	run_on_irqstack_cond(__##func, regs, regs);			\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
-	idtentry_exit(regs, state);					\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs)
@@ -268,7 +263,7 @@ static __always_inline void __##func(str
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	idtentry_state_t state = idtentry_enter(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	__irq_enter_raw();						\
@@ -276,7 +271,7 @@ static __always_inline void __##func(str
 	__##func (regs);						\
 	__irq_exit_raw();						\
 	instrumentation_end();						\
-	idtentry_exit(regs, state);					\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -233,7 +233,7 @@ EXPORT_SYMBOL_GPL(kvm_read_and_reset_apf
 noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
 	u32 reason = kvm_read_and_reset_apf_flags();
-	idtentry_state_t state;
+	irqentry_state_t state;
 
 	switch (reason) {
 	case KVM_PV_REASON_PAGE_NOT_PRESENT:
@@ -243,7 +243,7 @@ noinstr bool __kvm_handle_async_pf(struc
 		return false;
 	}
 
-	state = idtentry_enter(regs);
+	state = irqentry_enter(regs);
 	instrumentation_begin();
 
 	/*
@@ -264,7 +264,7 @@ noinstr bool __kvm_handle_async_pf(struc
 	}
 
 	instrumentation_end();
-	idtentry_exit(regs, state);
+	irqentry_exit(regs, state);
 	return true;
 }
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -245,7 +245,7 @@ static noinstr bool handle_bug(struct pt
 
 DEFINE_IDTENTRY_RAW(exc_invalid_op)
 {
-	idtentry_state_t state;
+	irqentry_state_t state;
 
 	/*
 	 * We use UD2 as a short encoding for 'CALL __WARN', as such
@@ -255,11 +255,11 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 	if (!user_mode(regs) && handle_bug(regs))
 		return;
 
-	state = idtentry_enter(regs);
+	state = irqentry_enter(regs);
 	instrumentation_begin();
 	handle_invalid_op(regs);
 	instrumentation_end();
-	idtentry_exit(regs, state);
+	irqentry_exit(regs, state);
 }
 
 DEFINE_IDTENTRY(exc_coproc_segment_overrun)
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1377,7 +1377,7 @@ handle_page_fault(struct pt_regs *regs,
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
 	unsigned long address = read_cr2();
-	idtentry_state_t state;
+	irqentry_state_t state;
 
 	prefetchw(&current->mm->mmap_lock);
 
@@ -1412,11 +1412,11 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_f
 	 * code reenabled RCU to avoid subsequent wreckage which helps
 	 * debugability.
 	 */
-	state = idtentry_enter(regs);
+	state = irqentry_enter(regs);
 
 	instrumentation_begin();
 	handle_page_fault(regs, error_code, address);
 	instrumentation_end();
 
-	idtentry_exit(regs, state);
+	irqentry_exit(regs, state);
 }

