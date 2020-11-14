Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C6A2B2B08
	for <lists+linux-arch@lfdr.de>; Sat, 14 Nov 2020 04:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgKND3r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 22:29:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58522 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKND3q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 22:29:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id F2D131F4798C
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, keescook@chromium.org, arnd@arndb.de,
        luto@amacapital.net, wad@chromium.org, rostedt@goodmis.org,
        paul@paul-moore.com, eparis@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 02/10] kernel: entry: Expose helpers to migrate TIF to SYSCALL_WORK flags
Date:   Fri, 13 Nov 2020 22:29:09 -0500
Message-Id: <20201114032917.1205658-3-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201114032917.1205658-1-krisman@collabora.com>
References: <20201114032917.1205658-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the goal to split the syscall work related flags into a separate field
that is architecture independent, expose transitional helpers that
resolve to either the TIF flags or to the corresponding SYSCALL_WORK
flags.  This will allow architectures to migrate only when they port to
the generic syscall entry code.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/thread_info.h | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index e93e249a4e9b..18755373dc4d 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -97,6 +97,48 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 #define test_thread_flag(flag) \
 	test_ti_thread_flag(current_thread_info(), flag)
 
+#ifdef CONFIG_GENERIC_ENTRY
+static inline void __set_task_syscall_work(struct thread_info *ti, int flag)
+{
+	set_bit(flag, (unsigned long *)&ti->syscall_work);
+}
+static inline int __test_task_syscall_work(struct thread_info *ti, int flag)
+{
+	return test_bit(flag, (unsigned long *)&ti->syscall_work);
+}
+static inline void __clear_task_syscall_work(struct thread_info *ti, int flag)
+{
+	return clear_bit(flag, (unsigned long *)&ti->syscall_work);
+}
+#define set_syscall_work(fl) \
+	__set_task_syscall_work(current_thread_info(), SYSCALL_WORK_##fl)
+#define test_syscall_work(fl) \
+	__test_task_syscall_work(current_thread_info(), SYSCALL_WORK_##fl)
+#define clear_syscall_work(fl) \
+	__clear_task_syscall_work(current_thread_info(), SYSCALL_WORK_##fl)
+
+#define set_task_syscall_work(t, fl) \
+	__set_task_syscall_work(task_thread_info(t), SYSCALL_WORK_##fl)
+#define test_task_syscall_work(t, fl) \
+	__test_task_syscall_work(task_thread_info(t), SYSCALL_WORK_##fl)
+#define clear_task_syscall_work(t, fl) \
+	__clear_task_syscall_work(task_thread_info(t), SYSCALL_WORK_##fl)
+#else
+#define set_syscall_work(fl) \
+	set_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+#define test_syscall_work(fl) \
+	test_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+#define clear_syscall_work(fl) \
+	clear_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+
+#define set_task_syscall_work(t, fl) \
+	set_ti_thread_flag(task_thread_info(t), TIF_##fl)
+#define test_task_syscall_work(t, fl) \
+	test_ti_thread_flag(task_thread_info(t), TIF_##fl)
+#define clear_task_syscall_work(t, fl) \
+	clear_ti_thread_flag(task_thread_info(t), TIF_##fl)
+#endif /* CONFIG_GENERIC_ENTRY */
+
 #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
 
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
-- 
2.29.2

