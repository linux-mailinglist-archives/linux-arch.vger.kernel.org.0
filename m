Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B92B4E29
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbgKPRmd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 12:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387911AbgKPRmb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 12:42:31 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0F9C0613CF;
        Mon, 16 Nov 2020 09:42:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D321E1F45E54
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     hch@infradead.org, mingo@redhat.com, keescook@chromium.org,
        arnd@arndb.de, luto@amacapital.net, wad@chromium.org,
        rostedt@goodmis.org, paul@paul-moore.com, eparis@redhat.com,
        oleg@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 04/10] seccomp: Migrate to use SYSCALL_WORK flag
Date:   Mon, 16 Nov 2020 12:42:00 -0500
Message-Id: <20201116174206.2639648-5-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116174206.2639648-1-krisman@collabora.com>
References: <20201116174206.2639648-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When one the generic syscall entry code, use the syscall_work field in
struct thread_info and specific SYSCALL_WORK flags to setup this syscall
work.  This flag has the advantage of being architecture independent.

Users of the flag outside of the generic entry code should rely on the
accessor macros, such that the flag is still correctly resolved for
architectures that don't use the generic entry code and still rely on
TIF flags for system call work.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Drop explicit value assignment in enum (tglx)
  - Avoid FLAG/_FLAG defines (tglx)
  - Fix comment to refer to SYSCALL_WORK_SECCOMP (me)
---
 include/asm-generic/syscall.h | 2 +-
 include/linux/entry-common.h  | 8 ++------
 include/linux/seccomp.h       | 2 +-
 include/linux/thread_info.h   | 6 ++++++
 kernel/entry/common.c         | 2 +-
 kernel/fork.c                 | 2 +-
 kernel/seccomp.c              | 6 +++---
 7 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index f3135e734387..524d8e68ff5e 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -135,7 +135,7 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
  * Returns the AUDIT_ARCH_* based on the system call convention in use.
  *
  * It's only valid to call this when @task is stopped on entry to a system
- * call, due to %TIF_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %TIF_SECCOMP.
+ * call, due to %TIF_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %SYSCALL_WORK_SECCOMP.
  *
  * Architectures which permit CONFIG_HAVE_ARCH_SECCOMP_FILTER must
  * provide an implementation of this.
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index cbc5c702ee4d..f3fc4457f63f 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -21,10 +21,6 @@
 # define _TIF_SYSCALL_TRACEPOINT	(0)
 #endif
 
-#ifndef _TIF_SECCOMP
-# define _TIF_SECCOMP			(0)
-#endif
-
 #ifndef _TIF_SYSCALL_AUDIT
 # define _TIF_SYSCALL_AUDIT		(0)
 #endif
@@ -49,7 +45,7 @@
 #endif
 
 #define SYSCALL_ENTER_WORK						\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP |	\
+	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT  |			\
 	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
 	 ARCH_SYSCALL_ENTER_WORK)
 
@@ -64,7 +60,7 @@
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
 	 _TIF_SYSCALL_TRACEPOINT | ARCH_SYSCALL_EXIT_WORK)
 
-#define SYSCALL_WORK_ENTER	(0)
+#define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP)
 #define SYSCALL_WORK_EXIT	(0)
 
 /*
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 02aef2844c38..47763f3999f7 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -42,7 +42,7 @@ struct seccomp {
 extern int __secure_computing(const struct seccomp_data *sd);
 static inline int secure_computing(void)
 {
-	if (unlikely(test_thread_flag(TIF_SECCOMP)))
+	if (unlikely(test_syscall_work(SECCOMP)))
 		return  __secure_computing(NULL);
 	return 0;
 }
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index f2d78de55840..1d6488130b5c 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -35,6 +35,12 @@ enum {
 	GOOD_STACK,
 };
 
+enum syscall_work_bit {
+	SYSCALL_WORK_BIT_SECCOMP,
+};
+
+#define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
+
 #include <asm/thread_info.h>
 
 #ifdef __KERNEL__
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 51c25f774791..c321056c73d7 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -54,7 +54,7 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	}
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
-	if (ti_work & _TIF_SECCOMP) {
+	if (work & SYSCALL_WORK_SECCOMP) {
 		ret = __secure_computing(NULL);
 		if (ret == -1L)
 			return ret;
diff --git a/kernel/fork.c b/kernel/fork.c
index 7199d359690c..4433c9c60100 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1625,7 +1625,7 @@ static void copy_seccomp(struct task_struct *p)
 	 * to manually enable the seccomp thread flag here.
 	 */
 	if (p->seccomp.mode != SECCOMP_MODE_DISABLED)
-		set_tsk_thread_flag(p, TIF_SECCOMP);
+		set_task_syscall_work(p, SECCOMP);
 #endif
 }
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 8ad7a293255a..f67e92d11ad7 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -356,14 +356,14 @@ static inline void seccomp_assign_mode(struct task_struct *task,
 
 	task->seccomp.mode = seccomp_mode;
 	/*
-	 * Make sure TIF_SECCOMP cannot be set before the mode (and
+	 * Make sure SYSCALL_WORK_SECCOMP cannot be set before the mode (and
 	 * filter) is set.
 	 */
 	smp_mb__before_atomic();
 	/* Assume default seccomp processes want spec flaw mitigation. */
 	if ((flags & SECCOMP_FILTER_FLAG_SPEC_ALLOW) == 0)
 		arch_seccomp_spec_mitigate(task);
-	set_tsk_thread_flag(task, TIF_SECCOMP);
+	set_task_syscall_work(task, SECCOMP);
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
@@ -929,7 +929,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 
 	/*
 	 * Make sure that any changes to mode from another thread have
-	 * been seen after TIF_SECCOMP was seen.
+	 * been seen after SYSCALL_WORK_SECCOMP was seen.
 	 */
 	rmb();
 
-- 
2.29.2

