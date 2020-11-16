Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0627D2B4E2F
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 18:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbgKPRml (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 12:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387935AbgKPRml (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 12:42:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F13C0613CF;
        Mon, 16 Nov 2020 09:42:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C56B41F45E62
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     hch@infradead.org, mingo@redhat.com, keescook@chromium.org,
        arnd@arndb.de, luto@amacapital.net, wad@chromium.org,
        rostedt@goodmis.org, paul@paul-moore.com, eparis@redhat.com,
        oleg@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 07/10] ptrace: Migrate TIF_SYSCALL_EMU to use SYSCALL_WORK flag
Date:   Mon, 16 Nov 2020 12:42:03 -0500
Message-Id: <20201116174206.2639648-8-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116174206.2639648-1-krisman@collabora.com>
References: <20201116174206.2639648-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For architectures that rely on the generic syscall entry code, use the
syscall_work field in struct thread_info and the specific SYSCALL_WORK
flag.  This set of flags has the advantage of being architecture
independent.

Users of the flag outside of the generic entry code should rely on the
accessor macros, such that the flag is still correctly resolved for
architectures that don't use the generic entry code and still rely on
TIF flags for system call work.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Drop explicit value assignment in enum (tglx)
  - Avoid FLAG/_FLAG defines (tglx)
  - Fix comment to refer to SYSCALL_WORK (me)
---
 include/linux/entry-common.h |  8 ++------
 include/linux/thread_info.h  |  2 ++
 include/linux/tracehook.h    |  2 +-
 kernel/entry/common.c        | 19 ++++++++++---------
 kernel/fork.c                |  4 ++--
 kernel/ptrace.c              | 10 +++++-----
 6 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index dc864edb7950..39d56558818d 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -13,10 +13,6 @@
  * Define dummy _TIF work flags if not defined by the architecture or for
  * disabled functionality.
  */
-#ifndef _TIF_SYSCALL_EMU
-# define _TIF_SYSCALL_EMU		(0)
-#endif
-
 #ifndef _TIF_SYSCALL_AUDIT
 # define _TIF_SYSCALL_AUDIT		(0)
 #endif
@@ -42,7 +38,6 @@
 
 #define SYSCALL_ENTER_WORK						\
 	(_TIF_SYSCALL_AUDIT  |						\
-	 _TIF_SYSCALL_EMU |						\
 	 ARCH_SYSCALL_ENTER_WORK)
 
 /*
@@ -58,7 +53,8 @@
 
 #define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
 				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
-				 SYSCALL_WORK_SYSCALL_TRACE)
+				 SYSCALL_WORK_SYSCALL_TRACE |		\
+				 SYSCALL_WORK_SYSCALL_EMU)
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE)
 
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 8fe85cdca822..844c9a102317 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -39,11 +39,13 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SECCOMP,
 	SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT,
 	SYSCALL_WORK_BIT_SYSCALL_TRACE,
+	SYSCALL_WORK_BIT_SYSCALL_EMU,
 };
 
 #define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
 #define SYSCALL_WORK_SYSCALL_TRACEPOINT	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT)
 #define SYSCALL_WORK_SYSCALL_TRACE	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
+#define SYSCALL_WORK_SYSCALL_EMU	BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
 
 #include <asm/thread_info.h>
 
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 3f20368afe9e..54b925224a13 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -84,7 +84,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs,
  * @regs:		user register state of current task
  *
  * This will be called if %SYSCALL_WORK_SYSCALL_TRACE or
- * %TIF_SYSCALL_EMU have been set, when the current task has just
+ * %SYSCALL_WORK_SYSCALL_EMU have been set, when the current task has just
  * entered the kernel for a system call.  Full user register state is
  * available here.  Changing the values in @regs can affect the system
  * call number and arguments to be tried.  It is safe to block here,
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 2682eba47c33..a7233cca01ba 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -47,9 +47,9 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	long ret = 0;
 
 	/* Handle ptrace */
-	if (work & SYSCALL_WORK_SYSCALL_TRACE || ti_work & _TIF_SYSCALL_EMU) {
+	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
 		ret = arch_syscall_enter_tracehook(regs);
-		if (ret || (ti_work & _TIF_SYSCALL_EMU))
+		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
 	}
 
@@ -208,21 +208,22 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 }
 
 #ifndef _TIF_SINGLESTEP
-static inline bool report_single_step(unsigned long ti_work)
+static inline bool report_single_step(unsigned long work)
 {
 	return false;
 }
 #else
 /*
- * If TIF_SYSCALL_EMU is set, then the only reason to report is when
+ * If SYSCALL_EMU is set, then the only reason to report is when
  * TIF_SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
  * instruction has been already reported in syscall_enter_from_user_mode().
  */
-#define SYSEMU_STEP	(_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)
-
-static inline bool report_single_step(unsigned long ti_work)
+static inline bool report_single_step(unsigned long work)
 {
-	return (ti_work & SYSEMU_STEP) == _TIF_SINGLESTEP;
+	if (!(work & SYSCALL_WORK_SYSCALL_EMU))
+		return false;
+
+	return !!(current_thread_info()->flags & _TIF_SINGLESTEP);
 }
 #endif
 
@@ -236,7 +237,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work,
 	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
-	step = report_single_step(ti_work);
+	step = report_single_step(work);
 	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
 		arch_syscall_exit_tracehook(regs, step);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 6f934a930015..4f131cb0192a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2159,8 +2159,8 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	user_disable_single_step(p);
 	clear_task_syscall_work(p, SYSCALL_TRACE);
-#ifdef TIF_SYSCALL_EMU
-	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
+#if defined(CONFIG_GENERIC_ENTRY) || defined(TIF_SYSCALL_EMU)
+	clear_task_syscall_work(p, SYSCALL_EMU);
 #endif
 	clear_tsk_latency_tracing(p);
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 55a2bc3186a7..237bcd6d255c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -118,8 +118,8 @@ void __ptrace_unlink(struct task_struct *child)
 	BUG_ON(!child->ptrace);
 
 	clear_task_syscall_work(child, SYSCALL_TRACE);
-#ifdef TIF_SYSCALL_EMU
-	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+#if defined(CONFIG_GENERIC_ENTRY) || defined(TIF_SYSCALL_EMU)
+	clear_task_syscall_work(child, SYSCALL_EMU);
 #endif
 
 	child->parent = child->real_parent;
@@ -816,11 +816,11 @@ static int ptrace_resume(struct task_struct *child, long request,
 	else
 		clear_task_syscall_work(child, SYSCALL_TRACE);
 
-#ifdef TIF_SYSCALL_EMU
+#if defined(CONFIG_GENERIC_ENTRY) || defined(TIF_SYSCALL_EMU)
 	if (request == PTRACE_SYSEMU || request == PTRACE_SYSEMU_SINGLESTEP)
-		set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		set_task_syscall_work(child, SYSCALL_EMU);
 	else
-		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		clear_task_syscall_work(child, SYSCALL_EMU);
 #endif
 
 	if (is_singleblock(request)) {
-- 
2.29.2

