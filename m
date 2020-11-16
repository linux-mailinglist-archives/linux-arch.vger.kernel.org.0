Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E092B4E34
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 18:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbgKPRmt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 12:42:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34424 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387935AbgKPRms (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 12:42:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D5BE81F45E45
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     hch@infradead.org, mingo@redhat.com, keescook@chromium.org,
        arnd@arndb.de, luto@amacapital.net, wad@chromium.org,
        rostedt@goodmis.org, paul@paul-moore.com, eparis@redhat.com,
        oleg@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 09/10] entry: Drop usage of TIF flags in the generic syscall code
Date:   Mon, 16 Nov 2020 12:42:05 -0500
Message-Id: <20201116174206.2639648-10-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116174206.2639648-1-krisman@collabora.com>
References: <20201116174206.2639648-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that the flags migration in the common syscall entry is complete and
the code relies exclusively on syscall_work, clean up the
accesses to TI flags in that path.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Fix subsystem prefix (tglx)
---
 include/linux/entry-common.h | 20 +++++++++-----------
 kernel/entry/common.c        | 17 +++++++----------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index afeb927e8545..cffd8bf1e085 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -26,31 +26,29 @@
 #endif
 
 /*
- * TIF flags handled in syscall_enter_from_user_mode()
+ * SYSCALL_WORK flags handled in syscall_enter_from_user_mode()
  */
-#ifndef ARCH_SYSCALL_ENTER_WORK
-# define ARCH_SYSCALL_ENTER_WORK	(0)
+#ifndef ARCH_SYSCALL_WORK_ENTER
+# define ARCH_SYSCALL_WORK_ENTER	(0)
 #endif
 
-#define SYSCALL_ENTER_WORK ARCH_SYSCALL_ENTER_WORK
-
 /*
  * TIF flags handled in syscall_exit_to_user_mode()
  */
-#ifndef ARCH_SYSCALL_EXIT_WORK
-# define ARCH_SYSCALL_EXIT_WORK		(0)
+#ifndef ARCH_SYSCALL_WORK_EXIT
+# define ARCH_SYSCALL_WORK_EXIT		(0)
 #endif
 
-#define SYSCALL_EXIT_WORK ARCH_SYSCALL_EXIT_WORK
-
 #define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
 				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_EMU |		\
-				 SYSCALL_WORK_SYSCALL_AUDIT)
+				 SYSCALL_WORK_SYSCALL_AUDIT |		\
+				 ARCH_SYSCALL_WORK_ENTER)
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
-				 SYSCALL_WORK_SYSCALL_AUDIT)
+				 SYSCALL_WORK_SYSCALL_AUDIT |		\
+				 ARCH_SYSCALL_WORK_EXIT)
 
 /*
  * TIF flags handled in exit_to_user_mode_loop()
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index a7233cca01ba..61b6936a0623 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -42,7 +42,7 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 }
 
 static long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long ti_work, unsigned long work)
+				unsigned long work)
 {
 	long ret = 0;
 
@@ -75,11 +75,9 @@ static __always_inline long
 __syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-	unsigned long ti_work;
 
-	ti_work = READ_ONCE(current_thread_info()->flags);
-	if (work & SYSCALL_WORK_ENTER || ti_work & SYSCALL_ENTER_WORK)
-		syscall = syscall_trace_enter(regs, syscall, ti_work, work);
+	if (work & SYSCALL_WORK_ENTER)
+		syscall = syscall_trace_enter(regs, syscall, work);
 
 	return syscall;
 }
@@ -227,8 +225,8 @@ static inline bool report_single_step(unsigned long work)
 }
 #endif
 
-static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work,
-			      unsigned long work)
+
+static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
 	bool step;
 
@@ -249,7 +247,6 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work,
 static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-	u32 cached_flags = READ_ONCE(current_thread_info()->flags);
 	unsigned long nr = syscall_get_nr(current, regs);
 
 	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
@@ -266,8 +263,8 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 	 * enabled, we want to run them exactly once per syscall exit with
 	 * interrupts enabled.
 	 */
-	if (unlikely(work & SYSCALL_WORK_EXIT || cached_flags & SYSCALL_EXIT_WORK))
-		syscall_exit_work(regs, cached_flags, work);
+	if (unlikely(work & SYSCALL_WORK_EXIT))
+		syscall_exit_work(regs, work);
 }
 
 __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
-- 
2.29.2

