Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E407A3D5B10
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 16:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhGZNbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 09:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234271AbhGZNb0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 09:31:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A9B460F9D;
        Mon, 26 Jul 2021 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627308715;
        bh=Lzb0rI8ezKQ/fVredrC1398NDBNvAdJ5u5ejW/DHsXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTg05R2g9pqjCuxEEH5ZiQzNKE76zEqQvKr1GsizTDii1s2zsKda+s7AKDdzusPst
         esUwO3T4gVTOR9znMBhSzQEJ9OjMMeS4sDeCo2SWJQ93PXVVHrYzfqc93ak8blDXzY
         0mfyOm5wM6qq/W+xuKZYz1leIfYVAP1a/uafMaZPRjO5owWZlEoyxKu6On2pJXUko8
         XVrzwjPVV9TJWOUlRsFaOVoa1sPoyKfo/pD0Pdloj80el3PIvqzn/prcg3zujFgfqP
         D8xMpYqG5wN2K7/MzuODsQ/3ktkRALfVkdbH4wFT0FADx2DsvRwgwXmpVfptbC8C68
         D89sDQqLV3QTw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 04/10] ARM: syscall: always store thread_info->abi_syscall
Date:   Mon, 26 Jul 2021 16:11:35 +0200
Message-Id: <20210726141141.2839385-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210726141141.2839385-1-arnd@kernel.org>
References: <20210726141141.2839385-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The system call number is used in a a couple of places, in particular
ptrace, seccomp and /proc/<pid>/syscall.

The last one apparently never worked reliably on ARM for tasks that are
not currently getting traced.

Storing the syscall number in the normal entry path makes it work,
as well as allowing us to see if the current system call is for OABI
compat mode, which is the next thing I want to hook into.

Since the thread_info->syscall field is not just the number any more, it
is now renamed to abi_syscall. In kernels that enable both OABI and EABI,
the upper bits of this field encode 0x900000 (__NR_OABI_SYSCALL_BASE)
for OABI tasks, while normal EABI tasks do not set the upper bits. This
makes it possible to implement the in_oabi_syscall() helper later.

All other users of thread_info->syscall go through the syscall_get_nr()
helper, which in turn filters out the ABI bits.

Note that the ABI information is lost with PTRACE_SET_SYSCALL, so one
cannot set the internal number to a particular version, but this was
already the case. We could change it to let gdb encode the ABI type along
with the syscall in a CONFIG_OABI_COMPAT-enabled kernel, but that itself
would be a (backwards-compatible) ABI change, so I don't do it here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/syscall.h     |  5 ++++-
 arch/arm/include/asm/thread_info.h |  2 +-
 arch/arm/include/uapi/asm/unistd.h |  1 +
 arch/arm/kernel/asm-offsets.c      |  1 +
 arch/arm/kernel/entry-common.S     |  8 ++++++--
 arch/arm/kernel/ptrace.c           | 14 ++++++++------
 6 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index fd02761ba06c..f055e846a5cc 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -22,7 +22,10 @@ extern const unsigned long sys_call_table[];
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
 {
-	return task_thread_info(task)->syscall;
+	if (IS_ENABLED(CONFIG_AEABI) && !IS_ENABLED(CONFIG_OABI_COMPAT))
+		return task_thread_info(task)->abi_syscall;
+
+	return task_thread_info(task)->abi_syscall & __NR_SYSCALL_MASK;
 }
 
 static inline void syscall_rollback(struct task_struct *task,
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 70d4cbc49ae1..17c56051747b 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -62,7 +62,7 @@ struct thread_info {
 	unsigned long		stack_canary;
 #endif
 	struct cpu_context_save	cpu_context;	/* cpu context */
-	__u32			syscall;	/* syscall number */
+	__u32			abi_syscall;	/* ABI type and syscall nr */
 	__u8			used_cp[16];	/* thread used copro */
 	unsigned long		tp_value[2];	/* TLS registers */
 #ifdef CONFIG_CRUNCH
diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index ae7749e15726..a1149911464c 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -15,6 +15,7 @@
 #define _UAPI__ASM_ARM_UNISTD_H
 
 #define __NR_OABI_SYSCALL_BASE	0x900000
+#define __NR_SYSCALL_MASK	0x0fffff
 
 #if defined(__thumb__) || defined(__ARM_EABI__)
 #define __NR_SYSCALL_BASE	0
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 70993af22d80..a0945b898ca3 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -48,6 +48,7 @@ int main(void)
   DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
   DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
   DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
+  DEFINE(TI_ABI_SYSCALL,	offsetof(struct thread_info, abi_syscall));
   DEFINE(TI_USED_CP,		offsetof(struct thread_info, used_cp));
   DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
   DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 7f0b7aba1498..e837af90cd44 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -226,6 +226,7 @@ ENTRY(vector_swi)
 	/* saved_psr and saved_pc are now dead */
 
 	uaccess_disable tbl
+	get_thread_info tsk
 
 	adr	tbl, sys_call_table		@ load syscall table pointer
 
@@ -237,13 +238,17 @@ ENTRY(vector_swi)
 	 * get the old ABI syscall table address.
 	 */
 	bics	r10, r10, #0xff000000
+	strne	r10, [tsk, #TI_ABI_SYSCALL]
+	streq	scno, [tsk, #TI_ABI_SYSCALL]
 	eorne	scno, r10, #__NR_OABI_SYSCALL_BASE
 	ldrne	tbl, =sys_oabi_call_table
 #elif !defined(CONFIG_AEABI)
 	bic	scno, scno, #0xff000000		@ mask off SWI op-code
+	str	scno, [tsk, #TI_ABI_SYSCALL]
 	eor	scno, scno, #__NR_SYSCALL_BASE	@ check OS number
+#else
+	str	scno, [tsk, #TI_ABI_SYSCALL]
 #endif
-	get_thread_info tsk
 	/*
 	 * Reload the registers that may have been corrupted on entry to
 	 * the syscall assembly (by tracing or context tracking.)
@@ -288,7 +293,6 @@ ENDPROC(vector_swi)
 	 * context switches, and waiting for our parent to respond.
 	 */
 __sys_trace:
-	mov	r1, scno
 	add	r0, sp, #S_OFF
 	bl	syscall_trace_enter
 	mov	scno, r0
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 2771e682220b..d886ea8910cb 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -25,6 +25,7 @@
 #include <linux/tracehook.h>
 #include <linux/unistd.h>
 
+#include <asm/syscall.h>
 #include <asm/traps.h>
 
 #define CREATE_TRACE_POINTS
@@ -811,7 +812,8 @@ long arch_ptrace(struct task_struct *child, long request,
 			break;
 
 		case PTRACE_SET_SYSCALL:
-			task_thread_info(child)->syscall = data;
+			task_thread_info(child)->abi_syscall = data &
+							__NR_SYSCALL_MASK;
 			ret = 0;
 			break;
 
@@ -880,14 +882,14 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 	if (dir == PTRACE_SYSCALL_EXIT)
 		tracehook_report_syscall_exit(regs, 0);
 	else if (tracehook_report_syscall_entry(regs))
-		current_thread_info()->syscall = -1;
+		current_thread_info()->abi_syscall = -1;
 
 	regs->ARM_ip = ip;
 }
 
-asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
+asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
-	current_thread_info()->syscall = scno;
+	int scno;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
@@ -898,11 +900,11 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
 		return -1;
 #else
 	/* XXX: remove this once OABI gets fixed */
-	secure_computing_strict(current_thread_info()->syscall);
+	secure_computing_strict(syscall_get_nr(current, regs));
 #endif
 
 	/* Tracer or seccomp may have changed syscall. */
-	scno = current_thread_info()->syscall;
+	scno = syscall_get_nr(current, regs);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, scno);
-- 
2.29.2

