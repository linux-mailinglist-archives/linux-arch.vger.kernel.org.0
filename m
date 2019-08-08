Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E5C8602A
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 12:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389610AbfHHKkF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 06:40:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:47422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403845AbfHHKjJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 06:39:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09946B077;
        Thu,  8 Aug 2019 10:39:08 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v8 17/28] x86/asm: use SYM_INNER_LABEL instead of GLOBAL
Date:   Thu,  8 Aug 2019 12:38:43 +0200
Message-Id: <20190808103854.6192-18-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

GLOBAL had several meanings and is going away. In this patch, convert
all the inner function labels marked with GLOBAL to use SYM_INNER_LABEL
instead.

Note that retint_user needs not be global, perhaps since commit
2ec67971facc ("x86/entry/64/compat: Remove most of the fast system call
machinery"), where entry_64_compat's caller was removed. So mark the
label as LOCAL.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/entry/entry_64.S                |  8 ++++----
 arch/x86/entry/entry_64_compat.S         |  4 ++--
 arch/x86/entry/vdso/vdso32/system_call.S |  2 +-
 arch/x86/kernel/ftrace_32.S              |  2 +-
 arch/x86/kernel/ftrace_64.S              | 16 ++++++++--------
 arch/x86/realmode/rm/reboot.S            |  2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 6c382ccbdeb5..50c19edbf639 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -162,7 +162,7 @@ ENTRY(entry_SYSCALL_64)
 	pushq	%r11					/* pt_regs->flags */
 	pushq	$__USER_CS				/* pt_regs->cs */
 	pushq	%rcx					/* pt_regs->ip */
-GLOBAL(entry_SYSCALL_64_after_hwframe)
+SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	pushq	%rax					/* pt_regs->orig_ax */
 
 	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
@@ -614,12 +614,12 @@ ret_from_intr:
 	jz	retint_kernel
 
 	/* Interrupt came from user space */
-GLOBAL(retint_user)
+SYM_INNER_LABEL(retint_user, SYM_L_LOCAL)
 	mov	%rsp,%rdi
 	call	prepare_exit_to_usermode
 	TRACE_IRQS_IRETQ
 
-GLOBAL(swapgs_restore_regs_and_return_to_usermode)
+SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
 	/* Assert that pt_regs indicates user mode. */
 	testb	$3, CS(%rsp)
@@ -677,7 +677,7 @@ retint_kernel:
 	 */
 	TRACE_IRQS_IRETQ
 
-GLOBAL(restore_regs_and_return_to_kernel)
+SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
 	/* Assert that pt_regs indicates kernel mode. */
 	testb	$3, CS(%rsp)
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 39913770a44d..5c7e71669239 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -146,7 +146,7 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	$X86_EFLAGS_FIXED
 	popfq
 	jmp	.Lsysenter_flags_fixed
-GLOBAL(__end_entry_SYSENTER_compat)
+SYM_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
 ENDPROC(entry_SYSENTER_compat)
 
 /*
@@ -215,7 +215,7 @@ ENTRY(entry_SYSCALL_compat)
 	pushq	%r11			/* pt_regs->flags */
 	pushq	$__USER32_CS		/* pt_regs->cs */
 	pushq	%rcx			/* pt_regs->ip */
-GLOBAL(entry_SYSCALL_compat_after_hwframe)
+SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	movl	%eax, %eax		/* discard orig_ax high bits */
 	pushq	%rax			/* pt_regs->orig_ax */
 	pushq	%rdi			/* pt_regs->di */
diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index 263d7433dea8..de1fff7188aa 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -62,7 +62,7 @@ __kernel_vsyscall:
 
 	/* Enter using int $0x80 */
 	int	$0x80
-GLOBAL(int80_landing_pad)
+SYM_INNER_LABEL(int80_landing_pad, SYM_L_GLOBAL)
 
 	/*
 	 * Restore EDX and ECX in case they were clobbered.  EBP is not
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 073aab525d80..e0061dc976e1 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -138,7 +138,7 @@ ENTRY(ftrace_regs_caller)
 	movl	function_trace_op, %ecx	# 3rd argument: ftrace_pos
 	pushl	%esp			# 4th argument: pt_regs
 
-GLOBAL(ftrace_regs_call)
+SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	call	ftrace_stub
 
 	addl	$4, %esp		# skip 4th argument
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 809d54397dba..3afaaf555637 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -140,14 +140,14 @@ ENTRY(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
 	save_mcount_regs
 
-GLOBAL(ftrace_caller_op_ptr)
+SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
 	/* regs go into 4th parameter (but make it NULL) */
 	movq $0, %rcx
 
-GLOBAL(ftrace_call)
+SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	call ftrace_stub
 
 	restore_mcount_regs
@@ -157,10 +157,10 @@ GLOBAL(ftrace_call)
 	 * think twice before adding any new code or changing the
 	 * layout here.
 	 */
-GLOBAL(ftrace_epilogue)
+SYM_INNER_LABEL(ftrace_epilogue, SYM_L_GLOBAL)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-GLOBAL(ftrace_graph_call)
+SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
 	jmp ftrace_stub
 #endif
 
@@ -180,7 +180,7 @@ ENTRY(ftrace_regs_caller)
 	save_mcount_regs 8
 	/* save_mcount_regs fills in first two parameters */
 
-GLOBAL(ftrace_regs_caller_op_ptr)
+SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
@@ -209,7 +209,7 @@ GLOBAL(ftrace_regs_caller_op_ptr)
 	/* regs go into 4th parameter */
 	leaq (%rsp), %rcx
 
-GLOBAL(ftrace_regs_call)
+SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	call ftrace_stub
 
 	/* Copy flags back to SS, to restore them */
@@ -239,7 +239,7 @@ GLOBAL(ftrace_regs_call)
 	 * The trampoline will add the code to jump
 	 * to the return.
 	 */
-GLOBAL(ftrace_regs_caller_end)
+SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 
 	jmp ftrace_epilogue
 
@@ -261,7 +261,7 @@ fgraph_trace:
 	jnz ftrace_graph_caller
 #endif
 
-GLOBAL(ftrace_stub)
+SYM_INNER_LABEL(ftrace_stub, SYM_L_GLOBAL)
 	retq
 
 trace:
diff --git a/arch/x86/realmode/rm/reboot.S b/arch/x86/realmode/rm/reboot.S
index cd2f97b9623b..f91425a01f8f 100644
--- a/arch/x86/realmode/rm/reboot.S
+++ b/arch/x86/realmode/rm/reboot.S
@@ -33,7 +33,7 @@ ENTRY(machine_real_restart_asm)
 	movl	%eax, %cr0
 	ljmpl	$__KERNEL32_CS, $pa_machine_real_restart_paging_off
 
-GLOBAL(machine_real_restart_paging_off)
+SYM_INNER_LABEL(machine_real_restart_paging_off, SYM_L_GLOBAL)
 	xorl	%eax, %eax
 	xorl	%edx, %edx
 	movl	$MSR_EFER, %ecx
-- 
2.22.0

