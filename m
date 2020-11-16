Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E81C2B4E24
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 18:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbgKPRmZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 12:42:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34282 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387899AbgKPRmY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 12:42:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7F99C1F45E49
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     hch@infradead.org, mingo@redhat.com, keescook@chromium.org,
        arnd@arndb.de, luto@amacapital.net, wad@chromium.org,
        rostedt@goodmis.org, paul@paul-moore.com, eparis@redhat.com,
        oleg@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 02/10] entry: Expose helpers to migrate TIF to SYSCALL_WORK flags
Date:   Mon, 16 Nov 2020 12:41:58 -0500
Message-Id: <20201116174206.2639648-3-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116174206.2639648-1-krisman@collabora.com>
References: <20201116174206.2639648-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the goal to split the syscall work related flags into a separate
field that is architecture independent, expose transitional helpers that
resolve to either the TIF flags or to the corresponding SYSCALL_WORK
flags.  This will allow architectures to migrate only when they port to
the generic syscall entry code.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Drop bogus cast to ulong (hch)
  - Fix subsystem prefix (tglx)
---
 include/linux/thread_info.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index e93e249a4e9b..f2d78de55840 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -97,6 +97,36 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 #define test_thread_flag(flag) \
 	test_ti_thread_flag(current_thread_info(), flag)
 
+#ifdef CONFIG_GENERIC_ENTRY
+#define set_syscall_work(fl) \
+	set_bit(SYSCALL_WORK_BIT_##fl, &current_thread_info()->syscall_work)
+#define test_syscall_work(fl) \
+	test_bit(SYSCALL_WORK_BIT_##fl, &current_thread_info()->syscall_work)
+#define clear_syscall_work(fl) \
+	clear_bit(SYSCALL_WORK_BIT_##fl, &current_thread_info()->syscall_work)
+
+#define set_task_syscall_work(t, fl) \
+	set_bit(SYSCALL_WORK_BIT_##fl, &task_thread_info(t)->syscall_work)
+#define test_task_syscall_work(t, fl) \
+	test_bit(SYSCALL_WORK_BIT_##fl, &task_thread_info(t)->syscall_work)
+#define clear_task_syscall_work(t, fl) \
+	clear_bit(SYSCALL_WORK_BIT_##fl, &task_thread_info(t)->syscall_work)
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

