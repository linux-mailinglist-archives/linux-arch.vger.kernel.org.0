Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7662B2B0E
	for <lists+linux-arch@lfdr.de>; Sat, 14 Nov 2020 04:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKND35 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 22:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKND35 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 22:29:57 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E7CC0613D1;
        Fri, 13 Nov 2020 19:29:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B5AB91F47976
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, keescook@chromium.org, arnd@arndb.de,
        luto@amacapital.net, wad@chromium.org, rostedt@goodmis.org,
        paul@paul-moore.com, eparis@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 05/10] tracepoints: Migrate to use SYSCALL_WORK flag
Date:   Fri, 13 Nov 2020 22:29:12 -0500
Message-Id: <20201114032917.1205658-6-krisman@collabora.com>
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
 include/linux/entry-common.h | 13 +++++--------
 include/linux/thread_info.h  |  3 +++
 include/trace/syscall.h      |  6 +++---
 kernel/entry/common.c        |  4 ++--
 kernel/trace/trace_events.c  |  2 +-
 kernel/tracepoint.c          |  4 ++--
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index f3fc4457f63f..8aba367e5c79 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -17,10 +17,6 @@
 # define _TIF_SYSCALL_EMU		(0)
 #endif
 
-#ifndef _TIF_SYSCALL_TRACEPOINT
-# define _TIF_SYSCALL_TRACEPOINT	(0)
-#endif
-
 #ifndef _TIF_SYSCALL_AUDIT
 # define _TIF_SYSCALL_AUDIT		(0)
 #endif
@@ -46,7 +42,7 @@
 
 #define SYSCALL_ENTER_WORK						\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT  |			\
-	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
+	 _TIF_SYSCALL_EMU |						\
 	 ARCH_SYSCALL_ENTER_WORK)
 
 /*
@@ -58,10 +54,11 @@
 
 #define SYSCALL_EXIT_WORK						\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
-	 _TIF_SYSCALL_TRACEPOINT | ARCH_SYSCALL_EXIT_WORK)
+	 ARCH_SYSCALL_EXIT_WORK)
 
-#define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP)
-#define SYSCALL_WORK_EXIT	(0)
+#define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
+				 SYSCALL_WORK_SYSCALL_TRACEPOINT)
+#define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT)
 
 /*
  * TIF flags handled in exit_to_user_mode_loop()
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index fb53c24fc8a6..f764314b00b9 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -36,10 +36,13 @@ enum {
 };
 
 enum syscall_work_bit {
+
 	SYSCALL_WORK_SECCOMP		= 0,
+	SYSCALL_WORK_SYSCALL_TRACEPOINT	= 1,
 };
 
 #define _SYSCALL_WORK_SECCOMP		 BIT(SYSCALL_WORK_SECCOMP)
+#define _SYSCALL_WORK_SYSCALL_TRACEPOINT BIT(SYSCALL_WORK_SYSCALL_TRACEPOINT)
 
 #include <asm/thread_info.h>
 
diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index dc8ac27d27c1..8e193f3a33b3 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -37,10 +37,10 @@ struct syscall_metadata {
 #if defined(CONFIG_TRACEPOINTS) && defined(CONFIG_HAVE_SYSCALL_TRACEPOINTS)
 static inline void syscall_tracepoint_update(struct task_struct *p)
 {
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		set_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
+	if (test_syscall_work(SYSCALL_TRACEPOINT))
+		set_task_syscall_work(p, SYSCALL_TRACEPOINT);
 	else
-		clear_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
+		clear_task_syscall_work(p, SYSCALL_TRACEPOINT);
 }
 #else
 static inline void syscall_tracepoint_update(struct task_struct *p)
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index ef49786e5c5b..745b847f4ed4 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -63,7 +63,7 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	/* Either of the above might have changed the syscall number */
 	syscall = syscall_get_nr(current, regs);
 
-	if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
+	if (unlikely(work & _SYSCALL_WORK_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall);
 
 	syscall_enter_audit(regs, syscall);
@@ -233,7 +233,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work,
 
 	audit_syscall_exit(regs);
 
-	if (ti_work & _TIF_SYSCALL_TRACEPOINT)
+	if (work & _SYSCALL_WORK_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
 	step = report_single_step(ti_work);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 47a71f96e5bc..950764dd226f 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3428,7 +3428,7 @@ static __init int event_trace_enable(void)
  * initialize events and perhaps start any events that are on the
  * command line. Unfortunately, there are some events that will not
  * start this early, like the system call tracepoints that need
- * to set the TIF_SYSCALL_TRACEPOINT flag of pid 1. But event_trace_enable()
+ * to set the SYSCALL_TRACEPOINT flag of pid 1. But event_trace_enable()
  * is called before pid 1 starts, and this flag is never set, making
  * the syscall tracepoint never get reached, but the event is enabled
  * regardless (and not doing anything).
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 3f659f855074..7261fa0f5e3c 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -594,7 +594,7 @@ int syscall_regfunc(void)
 	if (!sys_tracepoint_refcount) {
 		read_lock(&tasklist_lock);
 		for_each_process_thread(p, t) {
-			set_tsk_thread_flag(t, TIF_SYSCALL_TRACEPOINT);
+			set_task_syscall_work(t, SYSCALL_TRACEPOINT);
 		}
 		read_unlock(&tasklist_lock);
 	}
@@ -611,7 +611,7 @@ void syscall_unregfunc(void)
 	if (!sys_tracepoint_refcount) {
 		read_lock(&tasklist_lock);
 		for_each_process_thread(p, t) {
-			clear_tsk_thread_flag(t, TIF_SYSCALL_TRACEPOINT);
+			clear_task_syscall_work(t, SYSCALL_TRACEPOINT);
 		}
 		read_unlock(&tasklist_lock);
 	}
-- 
2.29.2

