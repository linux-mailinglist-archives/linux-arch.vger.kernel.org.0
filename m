Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1522B4E26
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 18:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgKPRm3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 12:42:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34306 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387899AbgKPRm2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 12:42:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E4A1C1F45E68
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     hch@infradead.org, mingo@redhat.com, keescook@chromium.org,
        arnd@arndb.de, luto@amacapital.net, wad@chromium.org,
        rostedt@goodmis.org, paul@paul-moore.com, eparis@redhat.com,
        oleg@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 03/10] entry: Wire up syscall_work in common entry code
Date:   Mon, 16 Nov 2020 12:41:59 -0500
Message-Id: <20201116174206.2639648-4-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116174206.2639648-1-krisman@collabora.com>
References: <20201116174206.2639648-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Prepare the common entry code to use the SYSCALL_WORK flags. They will
be defined in subsequent patches for each type of syscall
work. SYSCALL_WORK_ENTRY/EXIT are defined for the transition, as they
will replace the TIF_ equivalent defines.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Fix subsystem prefix (tglx)
  - Fix verb in commit message (tglx)
  - Sort variable declaration (tglx)
---
 include/linux/entry-common.h |  3 +++
 kernel/entry/common.c        | 15 +++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 1a128baf3628..cbc5c702ee4d 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -64,6 +64,9 @@
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
 	 _TIF_SYSCALL_TRACEPOINT | ARCH_SYSCALL_EXIT_WORK)
 
+#define SYSCALL_WORK_ENTER	(0)
+#define SYSCALL_WORK_EXIT	(0)
+
 /*
  * TIF flags handled in exit_to_user_mode_loop()
  */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bc75c114c1b3..51c25f774791 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -42,7 +42,7 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 }
 
 static long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long ti_work)
+				unsigned long ti_work, unsigned long work)
 {
 	long ret = 0;
 
@@ -74,11 +74,12 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 static __always_inline long
 __syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
 {
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	unsigned long ti_work;
 
 	ti_work = READ_ONCE(current_thread_info()->flags);
-	if (ti_work & SYSCALL_ENTER_WORK)
-		syscall = syscall_trace_enter(regs, syscall, ti_work);
+	if (work & SYSCALL_WORK_ENTER || ti_work & SYSCALL_ENTER_WORK)
+		syscall = syscall_trace_enter(regs, syscall, ti_work, work);
 
 	return syscall;
 }
@@ -225,7 +226,8 @@ static inline bool report_single_step(unsigned long ti_work)
 }
 #endif
 
-static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work)
+static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work,
+			      unsigned long work)
 {
 	bool step;
 
@@ -245,6 +247,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work)
  */
 static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 {
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	u32 cached_flags = READ_ONCE(current_thread_info()->flags);
 	unsigned long nr = syscall_get_nr(current, regs);
 
@@ -262,8 +265,8 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 	 * enabled, we want to run them exactly once per syscall exit with
 	 * interrupts enabled.
 	 */
-	if (unlikely(cached_flags & SYSCALL_EXIT_WORK))
-		syscall_exit_work(regs, cached_flags);
+	if (unlikely(work & SYSCALL_WORK_EXIT || cached_flags & SYSCALL_EXIT_WORK))
+		syscall_exit_work(regs, cached_flags, work);
 }
 
 __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
-- 
2.29.2

