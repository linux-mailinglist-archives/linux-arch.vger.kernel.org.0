Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7246CDCB3F
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443049AbfJRQbU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:31:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57850 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443034AbfJRQbT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:31:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV9H-00030o-OB; Fri, 18 Oct 2019 18:30:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 681941C04D3;
        Fri, 18 Oct 2019 18:30:33 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:33 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Annotate local pseudo-functions
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Lutomirski <luto@kernel.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Enrico Weigelt <info@metux.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, linux-arch@vger.kernel.org,
        Maran Wilson <maran.wilson@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191011115108.12392-6-jslaby@suse.cz>
References: <20191011115108.12392-6-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141623321.29376.16783773687549572689.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     ef77e6880be8fa3033544109e29417c8710fd3f2
Gitweb:        https://git.kernel.org/tip/ef77e6880be8fa3033544109e29417c8710fd3f2
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:45 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 10:04:04 +02:00

x86/asm: Annotate local pseudo-functions

Use the newly added SYM_CODE_START_LOCAL* to annotate beginnings of
all pseudo-functions (those ending with END until now) which do not
have ".globl" annotation. This is needed to balance END for tools that
generate debuginfo. Note that ENDs are switched to SYM_CODE_END too so
that everybody can see the pairing.

C-like functions (which handle frame ptr etc.) are not annotated here,
hence SYM_CODE_* macros are used here, not SYM_FUNC_*. Note that the
32bit version of early_idt_handler_common already had ENDPROC -- switch
that to SYM_CODE_END for the same reason as above (and to be the same as
64bit).

While early_idt_handler_common is LOCAL, it's name is not prepended with
".L" as it happens to appear in call traces.

bad_get_user*, and bad_put_user are now aligned, as they are separate
functions. They do not mind to be aligned -- no need to be compact
there.

early_idt_handler_common is aligned now too, as it is after
early_idt_handler_array, so as well no need to be compact there.

verify_cpu is self-standing and included in other .S files, so align it
too.

The others have alignment preserved to what it used to be (using the
_NOALIGN variant of macros).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Enrico Weigelt <info@metux.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: linux-arch@vger.kernel.org
Cc: Maran Wilson <maran.wilson@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191011115108.12392-6-jslaby@suse.cz
---
 arch/x86/entry/entry_64.S    | 3 ++-
 arch/x86/kernel/head_32.S    | 4 ++--
 arch/x86/kernel/head_64.S    | 4 ++--
 arch/x86/kernel/verify_cpu.S | 4 ++--
 arch/x86/lib/getuser.S       | 6 ++++--
 arch/x86/lib/putuser.S       | 3 ++-
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 86cbb22..db43526 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1061,7 +1061,7 @@ EXPORT_SYMBOL(native_load_gs_index)
 	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
 	.section .fixup, "ax"
 	/* running with kernelgs */
-.Lbad_gs:
+SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
 	SWAPGS					/* switch back to user gs */
 .macro ZAP_GS
 	/* This can't be a string because the preprocessor needs to see it. */
@@ -1072,6 +1072,7 @@ EXPORT_SYMBOL(native_load_gs_index)
 	xorl	%eax, %eax
 	movl	%eax, %gs
 	jmp	2b
+SYM_CODE_END(.Lbad_gs)
 	.previous
 
 /* Call softirq on interrupt stack. Interrupts are off. */
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 7feb953..aec1fdb 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -409,7 +409,7 @@ ENTRY(early_idt_handler_array)
 	.endr
 ENDPROC(early_idt_handler_array)
 	
-early_idt_handler_common:
+SYM_CODE_START_LOCAL(early_idt_handler_common)
 	/*
 	 * The stack is the hardware frame, an error code or zero, and the
 	 * vector number.
@@ -460,7 +460,7 @@ early_idt_handler_common:
 	decl	%ss:early_recursion_flag
 	addl	$4, %esp	/* pop pt_regs->orig_ax */
 	iret
-ENDPROC(early_idt_handler_common)
+SYM_CODE_END(early_idt_handler_common)
 
 /* This is the default interrupt "handler" :-) */
 ENTRY(early_ignore_irq)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index f00d7c0..5b42552 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -291,7 +291,7 @@ ENTRY(early_idt_handler_array)
 	UNWIND_HINT_IRET_REGS offset=16
 END(early_idt_handler_array)
 
-early_idt_handler_common:
+SYM_CODE_START_LOCAL(early_idt_handler_common)
 	/*
 	 * The stack is the hardware frame, an error code or zero, and the
 	 * vector number.
@@ -333,7 +333,7 @@ early_idt_handler_common:
 20:
 	decl early_recursion_flag(%rip)
 	jmp restore_regs_and_return_to_kernel
-END(early_idt_handler_common)
+SYM_CODE_END(early_idt_handler_common)
 
 #define NEXT_PAGE(name) \
 	.balign	PAGE_SIZE; \
diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
index a024c4f..641f0fe 100644
--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -31,7 +31,7 @@
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
 
-ENTRY(verify_cpu)
+SYM_FUNC_START_LOCAL(verify_cpu)
 	pushf				# Save caller passed flags
 	push	$0			# Kill any dangerous flags
 	popf
@@ -137,4 +137,4 @@ ENTRY(verify_cpu)
 	popf				# Restore caller passed flags
 	xorl %eax, %eax
 	ret
-ENDPROC(verify_cpu)
+SYM_FUNC_END(verify_cpu)
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 9578eb8..f9f59eb 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -115,21 +115,23 @@ ENDPROC(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
 
 
-.Lbad_get_user_clac:
+SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
 	ASM_CLAC
 bad_get_user:
 	xor %edx,%edx
 	mov $(-EFAULT),%_ASM_AX
 	ret
+SYM_CODE_END(.Lbad_get_user_clac)
 
 #ifdef CONFIG_X86_32
-.Lbad_get_user_8_clac:
+SYM_CODE_START_LOCAL(.Lbad_get_user_8_clac)
 	ASM_CLAC
 bad_get_user_8:
 	xor %edx,%edx
 	xor %ecx,%ecx
 	mov $(-EFAULT),%_ASM_AX
 	ret
+SYM_CODE_END(.Lbad_get_user_8_clac)
 #endif
 
 	_ASM_EXTABLE_UA(1b, .Lbad_get_user_clac)
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 126dd6a..a9391d7 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -91,11 +91,12 @@ ENTRY(__put_user_8)
 ENDPROC(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
-.Lbad_put_user_clac:
+SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
 	ASM_CLAC
 .Lbad_put_user:
 	movl $-EFAULT,%eax
 	RET
+SYM_CODE_END(.Lbad_put_user_clac)
 
 	_ASM_EXTABLE_UA(1b, .Lbad_put_user_clac)
 	_ASM_EXTABLE_UA(2b, .Lbad_put_user_clac)
