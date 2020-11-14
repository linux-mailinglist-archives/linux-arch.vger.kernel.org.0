Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30C92B2B15
	for <lists+linux-arch@lfdr.de>; Sat, 14 Nov 2020 04:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgKNDaI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 22:30:08 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58646 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgKNDaH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 22:30:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 165F61F47991
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, keescook@chromium.org, arnd@arndb.de,
        luto@amacapital.net, wad@chromium.org, rostedt@goodmis.org,
        paul@paul-moore.com, eparis@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 08/10] audit: Migrate to use SYSCALL_WORK flag
Date:   Fri, 13 Nov 2020 22:29:15 -0500
Message-Id: <20201114032917.1205658-9-krisman@collabora.com>
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
 include/linux/entry-common.h  | 18 ++++++------------
 include/linux/thread_info.h   |  2 ++
 kernel/auditsc.c              |  4 ++--
 4 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 5042d1ba4bc5..66ada3b099eb 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -43,7 +43,7 @@ int syscall_get_nr(struct task_struct *task, struct pt_regs *regs);
  * @regs:	task_pt_regs() of @task
  *
  * It's only valid to call this when @task is stopped for system
- * call exit tracing (due to SYSCALL_TRACE or TIF_SYSCALL_AUDIT),
+ * call exit tracing (due to SYSCALL_TRACE or SYSCALL_AUDIT),
  * after tracehook_report_syscall_entry() returned nonzero to prevent
  * the system call from taking place.
  *
@@ -63,7 +63,7 @@ void syscall_rollback(struct task_struct *task, struct pt_regs *regs);
  * Returns 0 if the system call succeeded, or -ERRORCODE if it failed.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_TRACE or %SYSCALL_AUDIT.
  */
 long syscall_get_error(struct task_struct *task, struct pt_regs *regs);
 
@@ -76,7 +76,7 @@ long syscall_get_error(struct task_struct *task, struct pt_regs *regs);
  * This value is meaningless if syscall_get_error() returned nonzero.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_TRACE or %SYSCALL_AUDIT.
  */
 long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
 
@@ -93,7 +93,7 @@ long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
  * code; the user sees a failed system call with this errno code.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_TRACE or %SYSCALL_AUDIT.
  */
 void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 			      int error, long val);
@@ -108,7 +108,7 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 *  @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * entry to a system call, due to %SYSCALL_TRACE or %SYSCALL_AUDIT.
  */
 void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 			   unsigned long *args);
@@ -123,7 +123,7 @@ void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
  * The first argument gets value @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * entry to a system call, due to %SYSCALL_TRACE or %SYSCALL_AUDIT.
  */
 void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 			   const unsigned long *args);
@@ -135,7 +135,7 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
  * Returns the AUDIT_ARCH_* based on the system call convention in use.
  *
  * It's only valid to call this when @task is stopped on entry to a system
- * call, due to %SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %TIF_SECCOMP.
+ * call, due to %SYSCALL_TRACE, %SYSCALL_AUDIT, or %TIF_SECCOMP.
  *
  * Architectures which permit CONFIG_HAVE_ARCH_SECCOMP_FILTER must
  * provide an implementation of this.
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 39d56558818d..afeb927e8545 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -13,10 +13,6 @@
  * Define dummy _TIF work flags if not defined by the architecture or for
  * disabled functionality.
  */
-#ifndef _TIF_SYSCALL_AUDIT
-# define _TIF_SYSCALL_AUDIT		(0)
-#endif
-
 #ifndef _TIF_PATCH_PENDING
 # define _TIF_PATCH_PENDING		(0)
 #endif
@@ -36,9 +32,7 @@
 # define ARCH_SYSCALL_ENTER_WORK	(0)
 #endif
 
-#define SYSCALL_ENTER_WORK						\
-	(_TIF_SYSCALL_AUDIT  |						\
-	 ARCH_SYSCALL_ENTER_WORK)
+#define SYSCALL_ENTER_WORK ARCH_SYSCALL_ENTER_WORK
 
 /*
  * TIF flags handled in syscall_exit_to_user_mode()
@@ -47,16 +41,16 @@
 # define ARCH_SYSCALL_EXIT_WORK		(0)
 #endif
 
-#define SYSCALL_EXIT_WORK						\
-	(_TIF_SYSCALL_AUDIT |						\
-	 ARCH_SYSCALL_EXIT_WORK)
+#define SYSCALL_EXIT_WORK ARCH_SYSCALL_EXIT_WORK
 
 #define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
 				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
-				 SYSCALL_WORK_SYSCALL_EMU)
+				 SYSCALL_WORK_SYSCALL_EMU |		\
+				 SYSCALL_WORK_SYSCALL_AUDIT)
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
-				 SYSCALL_WORK_SYSCALL_TRACE)
+				 SYSCALL_WORK_SYSCALL_TRACE |		\
+				 SYSCALL_WORK_SYSCALL_AUDIT)
 
 /*
  * TIF flags handled in exit_to_user_mode_loop()
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 3c7dedadf94d..3fb475583af0 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -41,12 +41,14 @@ enum syscall_work_bit {
 	SYSCALL_WORK_SYSCALL_TRACEPOINT	= 1,
 	SYSCALL_WORK_SYSCALL_TRACE	= 2,
 	SYSCALL_WORK_SYSCALL_EMU	= 3,
+	SYSCALL_WORK_SYSCALL_AUDIT	= 4,
 };
 
 #define _SYSCALL_WORK_SECCOMP		 BIT(SYSCALL_WORK_SECCOMP)
 #define _SYSCALL_WORK_SYSCALL_TRACEPOINT BIT(SYSCALL_WORK_SYSCALL_TRACEPOINT)
 #define _SYSCALL_WORK_SYSCALL_TRACE	 BIT(SYSCALL_WORK_SYSCALL_TRACE)
 #define _SYSCALL_WORK_SYSCALL_EMU	 BIT(SYSCALL_WORK_SYSCALL_EMU)
+#define _SYSCALL_WORK_SYSCALL_AUDIT	 BIT(SYSCALL_WORK_SYSCALL_AUDIT)
 
 #include <asm/thread_info.h>
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8dba8f0983b5..c00aa5837965 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -952,7 +952,7 @@ int audit_alloc(struct task_struct *tsk)
 
 	state = audit_filter_task(tsk, &key);
 	if (state == AUDIT_DISABLED) {
-		clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+		clear_task_syscall_work(tsk, SYSCALL_AUDIT);
 		return 0;
 	}
 
@@ -964,7 +964,7 @@ int audit_alloc(struct task_struct *tsk)
 	context->filterkey = key;
 
 	audit_set_context(tsk, context);
-	set_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+	set_task_syscall_work(tsk, SYSCALL_AUDIT);
 	return 0;
 }
 
-- 
2.29.2

