Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FEE2A0A59
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 16:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgJ3Ptj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 11:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbgJ3Pti (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 11:49:38 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF182223F;
        Fri, 30 Oct 2020 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604072977;
        bh=fY6p+lkklIuvlOl6LSOK1NSbGCEH/SLgf43BZ+YXIi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OncIA6fgT7xFpJo++EiS1WLvS/pajpXd+csgRgpXj9iJfxdcXoVFvkZC2udyZ7Gc0
         A7YWdxoVLtkUb/MfCSuNuR2coybydBXmuGgODODKEQw7OYawqvdhClLdjklrO58mlD
         gWrbJrvaqoWYAbuuzGAp2QfG0RB11vi75z2ReBXs=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk, linus.walleij@linaro.org, arnd@arndb.de
Subject: [PATCH 4/9] ARM: syscall: always store thread_info->syscall
Date:   Fri, 30 Oct 2020 16:49:14 +0100
Message-Id: <20201030154919.1246645-4-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201030154919.1246645-1-arnd@kernel.org>
References: <20201030154519.1245983-1-arnd@kernel.org>
 <20201030154919.1246645-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The system call number is used in a a couple of places, in particular
ptrace, seccomp and /proc/<pid>/syscall.

The last one apparently never worked reliably on ARM for tasks
that are not currently getting traced.

Storing the syscall number in the normal entry path makes it work,
as well as allowing us to see if the current system call is for
OABI compat mode, which is the next thing I want to hook into.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/syscall.h | 5 ++++-
 arch/arm/kernel/asm-offsets.c  | 1 +
 arch/arm/kernel/entry-common.S | 8 ++++++--
 arch/arm/kernel/ptrace.c       | 9 +++++----
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index fd02761ba06c..89898497edd6 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -22,7 +22,10 @@ extern const unsigned long sys_call_table[];
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
 {
-	return task_thread_info(task)->syscall;
+	if (IS_ENABLED(CONFIG_AEABI) && !IS_ENABLED(CONFIG_OABI_COMPAT))
+		return task_thread_info(task)->syscall;
+
+	return task_thread_info(task)->syscall & ~__NR_OABI_SYSCALL_BASE;
 }
 
 static inline void syscall_rollback(struct task_struct *task,
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index a1570c8bab25..97af6735172b 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -46,6 +46,7 @@ int main(void)
   DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
   DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
   DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
+  DEFINE(TI_SYSCALL,		offsetof(struct thread_info, syscall));
   DEFINE(TI_USED_CP,		offsetof(struct thread_info, used_cp));
   DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
   DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 271cb8a1eba1..9a76467bbb47 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -223,6 +223,7 @@ ENTRY(vector_swi)
 	/* saved_psr and saved_pc are now dead */
 
 	uaccess_disable tbl
+	get_thread_info tsk
 
 	adr	tbl, sys_call_table		@ load syscall table pointer
 
@@ -234,13 +235,17 @@ ENTRY(vector_swi)
 	 * get the old ABI syscall table address.
 	 */
 	bics	r10, r10, #0xff000000
+	strne	r10, [tsk, #TI_SYSCALL]
+	streq	scno, [tsk, #TI_SYSCALL]
 	eorne	scno, r10, #__NR_OABI_SYSCALL_BASE
 	ldrne	tbl, =sys_oabi_call_table
 #elif !defined(CONFIG_AEABI)
 	bic	scno, scno, #0xff000000		@ mask off SWI op-code
+	str	scno, [tsk, #TI_SYSCALL]
 	eor	scno, scno, #__NR_SYSCALL_BASE	@ check OS number
+#else
+	str	scno, [tsk, #TI_SYSCALL]
 #endif
-	get_thread_info tsk
 	/*
 	 * Reload the registers that may have been corrupted on entry to
 	 * the syscall assembly (by tracing or context tracking.)
@@ -285,7 +290,6 @@ ENDPROC(vector_swi)
 	 * context switches, and waiting for our parent to respond.
 	 */
 __sys_trace:
-	mov	r1, scno
 	add	r0, sp, #S_OFF
 	bl	syscall_trace_enter
 	mov	scno, r0
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 2771e682220b..683edb8b627d 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -25,6 +25,7 @@
 #include <linux/tracehook.h>
 #include <linux/unistd.h>
 
+#include <asm/syscall.h>
 #include <asm/traps.h>
 
 #define CREATE_TRACE_POINTS
@@ -885,9 +886,9 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 	regs->ARM_ip = ip;
 }
 
-asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
+asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
-	current_thread_info()->syscall = scno;
+	int scno;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
@@ -898,11 +899,11 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
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
2.27.0

