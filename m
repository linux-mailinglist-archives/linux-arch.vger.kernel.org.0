Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCCB2B2B11
	for <lists+linux-arch@lfdr.de>; Sat, 14 Nov 2020 04:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNDaB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 22:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgKNDaA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 22:30:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DE8C0613D1;
        Fri, 13 Nov 2020 19:30:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 52F4C1F47986
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, keescook@chromium.org, arnd@arndb.de,
        luto@amacapital.net, wad@chromium.org, rostedt@goodmis.org,
        paul@paul-moore.com, eparis@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 06/10] ptrace: Migrate to use SYSCALL_TRACE flag
Date:   Fri, 13 Nov 2020 22:29:13 -0500
Message-Id: <20201114032917.1205658-7-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201114032917.1205658-1-krisman@collabora.com>
References: <20201114032917.1205658-1-krisman@collabora.com>
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
 include/asm-generic/syscall.h | 14 +++++++-------
 include/linux/entry-common.h  | 10 ++++++----
 include/linux/thread_info.h   |  2 ++
 include/linux/tracehook.h     |  6 +++---
 kernel/entry/common.c         |  4 ++--
 kernel/fork.c                 |  2 +-
 kernel/ptrace.c               |  6 +++---
 7 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index f3135e734387..5042d1ba4bc5 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -43,7 +43,7 @@ int syscall_get_nr(struct task_struct *task, struct pt_regs *regs);
  * @regs:	task_pt_regs() of @task
  *
  * It's only valid to call this when @task is stopped for system
- * call exit tracing (due to TIF_SYSCALL_TRACE or TIF_SYSCALL_AUDIT),
+ * call exit tracing (due to SYSCALL_TRACE or TIF_SYSCALL_AUDIT),
  * after tracehook_report_syscall_entry() returned nonzero to prevent
  * the system call from taking place.
  *
@@ -63,7 +63,7 @@ void syscall_rollback(struct task_struct *task, struct pt_regs *regs);
  * Returns 0 if the system call succeeded, or -ERRORCODE if it failed.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
 long syscall_get_error(struct task_struct *task, struct pt_regs *regs);
 
@@ -76,7 +76,7 @@ long syscall_get_error(struct task_struct *task, struct pt_regs *regs);
  * This value is meaningless if syscall_get_error() returned nonzero.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
 long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
 
@@ -93,7 +93,7 @@ long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
  * code; the user sees a failed system call with this errno code.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
 void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 			      int error, long val);
@@ -108,7 +108,7 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 *  @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * entry to a system call, due to %SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
 void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 			   unsigned long *args);
@@ -123,7 +123,7 @@ void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
  * The first argument gets value @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * entry to a system call, due to %SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
 void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 			   const unsigned long *args);
@@ -135,7 +135,7 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
  * Returns the AUDIT_ARCH_* based on the system call convention in use.
  *
  * It's only valid to call this when @task is stopped on entry to a system
- * call, due to %TIF_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %TIF_SECCOMP.
+ * call, due to %SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %TIF_SECCOMP.
  *
  * Architectures which permit CONFIG_HAVE_ARCH_SECCOMP_FILTER must
  * provide an implementation of this.
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 8aba367e5c79..dc864edb7950 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -41,7 +41,7 @@
 #endif
 
 #define SYSCALL_ENTER_WORK						\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT  |			\
+	(_TIF_SYSCALL_AUDIT  |						\
 	 _TIF_SYSCALL_EMU |						\
 	 ARCH_SYSCALL_ENTER_WORK)
 
@@ -53,12 +53,14 @@
 #endif
 
 #define SYSCALL_EXIT_WORK						\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
+	(_TIF_SYSCALL_AUDIT |						\
 	 ARCH_SYSCALL_EXIT_WORK)
 
 #define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
-				 SYSCALL_WORK_SYSCALL_TRACEPOINT)
-#define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT)
+				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
+				 SYSCALL_WORK_SYSCALL_TRACE)
+#define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
+				 SYSCALL_WORK_SYSCALL_TRACE)
 
 /*
  * TIF flags handled in exit_to_user_mode_loop()
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index f764314b00b9..b01f05282158 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -39,10 +39,12 @@ enum syscall_work_bit {
 
 	SYSCALL_WORK_SECCOMP		= 0,
 	SYSCALL_WORK_SYSCALL_TRACEPOINT	= 1,
+	SYSCALL_WORK_SYSCALL_TRACE	= 2,
 };
 
 #define _SYSCALL_WORK_SECCOMP		 BIT(SYSCALL_WORK_SECCOMP)
 #define _SYSCALL_WORK_SYSCALL_TRACEPOINT BIT(SYSCALL_WORK_SYSCALL_TRACEPOINT)
+#define _SYSCALL_WORK_SYSCALL_TRACE	 BIT(SYSCALL_WORK_SYSCALL_TRACE)
 
 #include <asm/thread_info.h>
 
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index f7d82e4fafd6..0aa3771d1df5 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -83,7 +83,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs,
  * tracehook_report_syscall_entry - task is about to attempt a system call
  * @regs:		user register state of current task
  *
- * This will be called if %TIF_SYSCALL_TRACE or %TIF_SYSCALL_EMU have been set,
+ * This will be called if %SYSCALL_TRACE or %TIF_SYSCALL_EMU have been set,
  * when the current task has just entered the kernel for a system call.
  * Full user register state is available here.  Changing the values
  * in @regs can affect the system call number and arguments to be tried.
@@ -109,7 +109,7 @@ static inline __must_check int tracehook_report_syscall_entry(
  * @regs:		user register state of current task
  * @step:		nonzero if simulating single-step or block-step
  *
- * This will be called if %TIF_SYSCALL_TRACE has been set, when the
+ * This will be called if %SYSCALL_TRACE has been set, when the
  * current task has just finished an attempted system call.  Full
  * user register state is available here.  It is safe to block here,
  * preventing signals from being processed.
@@ -117,7 +117,7 @@ static inline __must_check int tracehook_report_syscall_entry(
  * If @step is nonzero, this report is also in lieu of the normal
  * trap that would follow the system call instruction because
  * user_enable_block_step() or user_enable_single_step() was used.
- * In this case, %TIF_SYSCALL_TRACE might not be set.
+ * In this case, %SYSCALL_TRACE might not be set.
  *
  * Called without locks, just before checking for pending signals.
  */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 745b847f4ed4..55ede5fed650 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -47,7 +47,7 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	long ret = 0;
 
 	/* Handle ptrace */
-	if (ti_work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
+	if (work & _SYSCALL_WORK_SYSCALL_TRACE || ti_work & _TIF_SYSCALL_EMU) {
 		ret = arch_syscall_enter_tracehook(regs);
 		if (ret || (ti_work & _TIF_SYSCALL_EMU))
 			return -1L;
@@ -237,7 +237,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work,
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
 	step = report_single_step(ti_work);
-	if (step || ti_work & _TIF_SYSCALL_TRACE)
+	if (step || work & _SYSCALL_WORK_SYSCALL_TRACE)
 		arch_syscall_exit_tracehook(regs, step);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 4433c9c60100..6f934a930015 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2158,7 +2158,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 * child regardless of CLONE_PTRACE.
 	 */
 	user_disable_single_step(p);
-	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
+	clear_task_syscall_work(p, SYSCALL_TRACE);
 #ifdef TIF_SYSCALL_EMU
 	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
 #endif
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..55a2bc3186a7 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -117,7 +117,7 @@ void __ptrace_unlink(struct task_struct *child)
 	const struct cred *old_cred;
 	BUG_ON(!child->ptrace);
 
-	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+	clear_task_syscall_work(child, SYSCALL_TRACE);
 #ifdef TIF_SYSCALL_EMU
 	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 #endif
@@ -812,9 +812,9 @@ static int ptrace_resume(struct task_struct *child, long request,
 		return -EIO;
 
 	if (request == PTRACE_SYSCALL)
-		set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		set_task_syscall_work(child, SYSCALL_TRACE);
 	else
-		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		clear_task_syscall_work(child, SYSCALL_TRACE);
 
 #ifdef TIF_SYSCALL_EMU
 	if (request == PTRACE_SYSEMU || request == PTRACE_SYSEMU_SINGLESTEP)
-- 
2.29.2

