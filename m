Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2DE1A88
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390023AbfJWMd0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 08:33:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49091 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389735AbfJWMbk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 08:31:40 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNFnc-000179-B8; Wed, 23 Oct 2019 14:31:36 +0200
Message-Id: <20191023123117.976831752@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 23 Oct 2019 14:27:09 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [patch V2 04/17] x86/entry: Make DEBUG_ENTRY_ASSERT_IRQS_OFF
 available for 32bit
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move the interrupt state verification debug macro to common code and fixup
the irqflags and paravirt components so it can be used in 32bit code later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/calling.h        |   12 ++++++++++++
 arch/x86/entry/entry_64.S       |   12 ------------
 arch/x86/include/asm/irqflags.h |    8 ++++++--
 arch/x86/include/asm/paravirt.h |    9 +++++----
 4 files changed, 23 insertions(+), 18 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -366,3 +366,15 @@ For 32-bit we have the following convent
 #else
 #define GET_CR2_INTO(reg) _ASM_MOV %cr2, reg
 #endif
+
+.macro DEBUG_ENTRY_ASSERT_IRQS_OFF
+#ifdef CONFIG_DEBUG_ENTRY
+	push %_ASM_AX
+	SAVE_FLAGS(CLBR_EAX)
+	test $X86_EFLAGS_IF, %_ASM_AX
+	jz .Lokay_\@
+	ud2
+.Lokay_\@:
+	pop %_ASM_AX
+#endif
+.endm
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -387,18 +387,6 @@ ENTRY(spurious_entries_start)
     .endr
 END(spurious_entries_start)
 
-.macro DEBUG_ENTRY_ASSERT_IRQS_OFF
-#ifdef CONFIG_DEBUG_ENTRY
-	pushq %rax
-	SAVE_FLAGS(CLBR_RAX)
-	testl $X86_EFLAGS_IF, %eax
-	jz .Lokay_\@
-	ud2
-.Lokay_\@:
-	popq %rax
-#endif
-.endm
-
 /*
  * Enters the IRQ stack if we're not already using it.  NMI-safe.  Clobbers
  * flags and puts old RSP into old_rsp, and leaves all other GPRs alone.
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -126,11 +126,15 @@ static inline notrace unsigned long arch
 #define ENABLE_INTERRUPTS(x)	sti
 #define DISABLE_INTERRUPTS(x)	cli
 
-#ifdef CONFIG_X86_64
 #ifdef CONFIG_DEBUG_ENTRY
-#define SAVE_FLAGS(x)		pushfq; popq %rax
+# ifdef CONFIG_X86_64
+#  define SAVE_FLAGS(x)		pushfq; popq %rax
+# else
+#  define SAVE_FLAGS(x)		pushfl; popl %eax
+# endif
 #endif
 
+#ifdef CONFIG_X86_64
 #define SWAPGS	swapgs
 /*
  * Currently paravirt can't handle swapgs nicely when we
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -904,6 +904,11 @@ extern void default_banner(void);
 		  ANNOTATE_RETPOLINE_SAFE;				\
 		  jmp PARA_INDIRECT(pv_ops+PV_CPU_usergs_sysret64);)
 
+#endif /* CONFIG_PARAVIRT_XXL */
+#endif	/* CONFIG_X86_64 */
+
+#ifdef CONFIG_PARAVIRT_XXL
+
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
 	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),			    \
@@ -912,10 +917,6 @@ extern void default_banner(void);
 		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);	    \
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 #endif
-#endif /* CONFIG_PARAVIRT_XXL */
-#endif	/* CONFIG_X86_64 */
-
-#ifdef CONFIG_PARAVIRT_XXL
 
 #define GET_CR2_INTO_AX							\
 	PARA_SITE(PARA_PATCH(PV_MMU_read_cr2),				\


