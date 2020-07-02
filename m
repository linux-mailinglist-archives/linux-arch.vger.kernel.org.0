Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDC62125AE
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgGBOJr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgGBOJr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:09:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255A3C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:09:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f16so2202430pjt.0
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNmV1cP3BxVauRaaBo/eHiB6+hB5AglmloLB9q7cTJc=;
        b=I0hpZO8J9mRhtT4V5+U0CT8dw9l00PFQZ2GhK283WSQWBUUvWIB870C/PWxRouieeZ
         I71k06VMFuGi8k6oH6td0ggxJ+E/m1dykZwxbP/oYHbGz2NpxG9KUi75IelxoXo+lvGA
         UH89CPsj+LP1MSpcdjsSU0On3NC6hzJ68qO6CN/J/J6Clt60S1DM2uoLEF6owc/cfA+c
         ONElxt2Se3WOC8NkELr0bxOP1grcr/aZ99ayuA0EiJbOinOizU2RXfEILTOmls8lqIar
         hE9vTosGvvsw2yGfMI1sVXnkiPpZB/JaNjUJQHP/reAANdJjYK1efJtifhdm6LoFL8sJ
         EG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNmV1cP3BxVauRaaBo/eHiB6+hB5AglmloLB9q7cTJc=;
        b=FLu9mMXshoYxli/T+iFpKhZij0A7rz4rmUgEEDhuYElpFlc1VYds87frKSmqDb/d2B
         l3xkB95m4PmxZ4MUXVqoLUYTXMpeDUeecqOHq37RiYHDYvuAq6SOjMKEaxyEgd97QSPY
         XhLOHHfS5HLqCVRemtsjc98nbQgMwSjrAU0W5n9ndVVn7MRsh9DvQkZJv9F27BsfH4KT
         5ziDW1uWNKbuCCu9oVANja5BgHQxJCRqF3CpTOeVoQTRYTXI3tVQfYtbaPcwEMaqJTsK
         ItIqq6MzgwftDOvW/V0M4zB+W92FR4+rTkiYxMS+4J/yDK/L82vp7RA3lSL54pbef78e
         pI/Q==
X-Gm-Message-State: AOAM531lIz+PvO0jo2ZzfODAIdEwXHCYZ/dd9/5FulgJEV8mMy2AemRq
        fP9PY1jdqWVPfe9q6BwRUls1oAudJzg=
X-Google-Smtp-Source: ABdhPJxiTp208ffv2eSaZZk9buPVr4X7lGuKEw9hvBF5AhGcpWqBDFb/P/lfOZueqbFwxbr+PlFQmA==
X-Received: by 2002:a17:90a:f695:: with SMTP id cl21mr33978544pjb.86.1593698986538;
        Thu, 02 Jul 2020 07:09:46 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id c23sm8501269pfo.32.2020.07.02.07.09.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:09:45 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id C8F85202D31D63; Thu,  2 Jul 2020 23:09:35 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 14/21] um: nommu: initialization and cleanup
Date:   Thu,  2 Jul 2020 23:07:08 +0900
Message-Id: <9463433f1d147f7a951435cab573052c01b8b3c0.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add the lkl_start_kernel and lkl_sys_halt APIs that start and
respectively stops the Linux kernel.

lkl_start_kernel creates a separate threads that will run the initial
and idle kernel thread. It waits for the kernel to complete
initialization before returning, to avoid races with system calls
issues by the host application.

During the setup phase, we create "/init" in initial ramfs root
filesystem to avoid mounting the "real" rootfs since ramfs is good
enough for now.

lkl_sys_halt will shutdown the kernel, terminate all threads and
free all host resources used by the kernel before returning.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/nommu/include/uapi/asm/host_ops.h |  14 ++
 arch/um/nommu/um/setup.c                  | 161 ++++++++++++++++++++++
 tools/um/uml/process.c                    |   2 +
 3 files changed, 177 insertions(+)
 create mode 100644 arch/um/nommu/um/setup.c

diff --git a/arch/um/nommu/include/uapi/asm/host_ops.h b/arch/um/nommu/include/uapi/asm/host_ops.h
index 133877c857a1..0811494c080c 100644
--- a/arch/um/nommu/include/uapi/asm/host_ops.h
+++ b/arch/um/nommu/include/uapi/asm/host_ops.h
@@ -16,6 +16,7 @@ struct lkl_jmp_buf {
  * These operations must be provided by a host library or by the application
  * itself.
  * @print - optional operation that receives console messages
+ * @panic - called during a kernel panic
  *
  * @sem_alloc - allocate a host semaphore an initialize it to count
  * @sem_free - free a host semaphore
@@ -65,6 +66,7 @@ struct lkl_jmp_buf {
  */
 struct lkl_host_operations {
 	void (*print)(const char *str, int len);
+	void (*panic)(void);
 
 	struct lkl_sem *(*sem_alloc)(int count);
 	void (*sem_free)(struct lkl_sem *sem);
@@ -96,6 +98,18 @@ struct lkl_host_operations {
 	void (*mem_free)(void *mem);
 };
 
+/**
+ * lkl_start_kernel - registers the host operations and starts the kernel
+ *
+ * The function returns only after the kernel is shutdown with lkl_sys_halt.
+ *
+ * @lkl_ops - pointer to host operations
+ * @cmd_line - format for command line string that is going to be used to
+ * generate the Linux kernel command line
+ */
+int lkl_start_kernel(struct lkl_host_operations *ops,
+		     const char *fmt, ...);
+
 void lkl_bug(const char *fmt, ...);
 
 #endif
diff --git a/arch/um/nommu/um/setup.c b/arch/um/nommu/um/setup.c
new file mode 100644
index 000000000000..25aa003792d4
--- /dev/null
+++ b/arch/um/nommu/um/setup.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/binfmts.h>
+#include <linux/init.h>
+#include <linux/init_task.h>
+#include <linux/personality.h>
+#include <linux/reboot.h>
+#include <linux/fs.h>
+#include <linux/start_kernel.h>
+#include <linux/syscalls.h>
+#include <linux/tick.h>
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <asm/host_ops.h>
+#include <asm/irq.h>
+#include <asm/unistd.h>
+#include <asm/syscalls.h>
+#include <asm/cpu.h>
+#include <os.h>
+#include <as-layout.h>
+
+
+static void *init_sem;
+static int is_running;
+
+
+struct lkl_host_operations *lkl_ops;
+
+long lkl_panic_blink(int state)
+{
+	lkl_ops->panic();
+	return 0;
+}
+
+static void __init *lkl_run_kernel(void *arg)
+{
+
+	panic_blink = lkl_panic_blink;
+
+	threads_init();
+	lkl_cpu_get();
+	start_kernel();
+
+	return NULL;
+}
+
+int __init lkl_start_kernel(struct lkl_host_operations *ops,
+			    const char *fmt, ...)
+{
+	int ret;
+
+	lkl_ops = ops;
+
+	init_sem = lkl_ops->sem_alloc(0);
+	if (!init_sem)
+		return -ENOMEM;
+
+	ret = lkl_cpu_init();
+	if (ret)
+		goto out_free_init_sem;
+
+	ret = lkl_ops->thread_create(lkl_run_kernel, NULL);
+	if (!ret) {
+		ret = -ENOMEM;
+		goto out_free_init_sem;
+	}
+
+	lkl_ops->sem_down(init_sem);
+	lkl_ops->sem_free(init_sem);
+	current_thread_info()->task->thread.arch.tid = lkl_ops->thread_self();
+	lkl_cpu_change_owner(current_thread_info()->task->thread.arch.tid);
+
+	lkl_cpu_put();
+	is_running = 1;
+
+	return 0;
+
+out_free_init_sem:
+	lkl_ops->sem_free(init_sem);
+
+	return ret;
+}
+
+int lkl_is_running(void)
+{
+	return is_running;
+}
+
+
+long lkl_sys_halt(void)
+{
+	long err;
+	long params[6] = {LINUX_REBOOT_MAGIC1,
+		LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_RESTART, };
+
+	err = lkl_syscall(__NR_reboot, params);
+	if (err < 0)
+		return err;
+
+	is_running = false;
+
+	lkl_cpu_wait_shutdown();
+
+	syscalls_cleanup();
+	threads_cleanup();
+	/* Shutdown the clockevents source. */
+	tick_suspend_local();
+	free_mem();
+	lkl_ops->thread_join(current_thread_info()->task->thread.arch.tid);
+
+	return 0;
+}
+
+
+static int lkl_run_init(struct linux_binprm *bprm);
+
+static struct linux_binfmt lkl_run_init_binfmt = {
+	.module		= THIS_MODULE,
+	.load_binary	= lkl_run_init,
+};
+
+static int lkl_run_init(struct linux_binprm *bprm)
+{
+	int ret;
+
+	if (strcmp("/init", bprm->filename) != 0)
+		return -EINVAL;
+
+	ret = flush_old_exec(bprm);
+	if (ret)
+		return ret;
+	set_personality(PER_LINUX);
+	setup_new_exec(bprm);
+	install_exec_creds(bprm);
+
+	set_binfmt(&lkl_run_init_binfmt);
+
+	init_pid_ns.child_reaper = 0;
+
+	syscalls_init();
+
+	lkl_ops->sem_up(init_sem);
+	lkl_ops->thread_exit();
+
+	return 0;
+}
+
+
+/* skip mounting the "real" rootfs. ramfs is good enough. */
+static int __init fs_setup(void)
+{
+	int fd;
+
+	fd = ksys_open("/init", O_CREAT, 0700);
+	WARN_ON(fd < 0);
+	ksys_close(fd);
+
+	register_binfmt(&lkl_run_init_binfmt);
+
+	return 0;
+}
+late_initcall(fs_setup);
diff --git a/tools/um/uml/process.c b/tools/um/uml/process.c
index e52dd37ddadc..c39d914e80ac 100644
--- a/tools/um/uml/process.c
+++ b/tools/um/uml/process.c
@@ -114,6 +114,8 @@ void os_kill_process(int pid, int reap_child)
 
 void os_kill_ptraced_process(int pid, int reap_child)
 {
+	if (pid == 0)
+		return;
 	kill(pid, SIGKILL);
 	ptrace(PTRACE_KILL, pid);
 	ptrace(PTRACE_CONT, pid);
-- 
2.21.0 (Apple Git-122.2)

