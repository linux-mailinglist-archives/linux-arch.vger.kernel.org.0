Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCBAD3F04
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfJKLxB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:53:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:33364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727919AbfJKLvR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DFE8DB488;
        Fri, 11 Oct 2019 11:51:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v9 05/28] x86/asm: Annotate local pseudo-functions
Date:   Fri, 11 Oct 2019 13:50:45 +0200
Message-Id: <20191011115108.12392-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the newly added SYM_CODE_START_LOCAL* to annotate starts of all
pseudo-functions (those ending END until now) which do not have ".globl"
annotation. This is needed to balance END for tools that generate
debuginfo. Note that ENDs are switched to SYM_CODE_END too so that
everybody can see the pairing.

C-like functions (which handle frame ptr etc.) are not annotated here,
hence SYM_CODE_* macros are used here, not SYM_FUNC_*.  Note that 32bit
early_idt_handler_common already had ENDPROC -- switch that to
SYM_CODE_END for the same reason as above (and to be the same as 64bit).

While early_idt_handler_common is LOCAL, it is not named starting ".L"
as it happens to appear in call traces.

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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: <x86@kernel.org>
---

Notes:
    [v3] annotate more functions
    [v4] describe the alignments changes

 arch/x86/entry/entry_64.S    | 3 ++-
 arch/x86/kernel/head_32.S    | 4 ++--
 arch/x86/kernel/head_64.S    | 4 ++--
 arch/x86/kernel/verify_cpu.S | 4 ++--
 arch/x86/lib/getuser.S       | 6 ++++--
 arch/x86/lib/putuser.S       | 3 ++-
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 86cbb22208c8..db43526cecfa 100644
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
index 7feb953e10d2..aec1fdb80221 100644
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
index f00d7c0c1c86..5b42552d929f 100644
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
index a024c4f7ba56..641f0fe1e5b4 100644
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
index 9578eb88fc87..f9f59eb85635 100644
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
index 126dd6a9ec9b..a9391d772c81 100644
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
-- 
2.23.0

