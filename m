Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEB02FC911
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbhATDfK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731936AbhATC3a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:30 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A95C06179C
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:29:13 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id y12so1202391pji.1
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ypgiu6q1Iz0Yn4IRUnjyh+oh2jFCd4nbbIEvAdriWkc=;
        b=C0e6cnygwKk6Y9XF6vxQ0vcFiifcdTbW181s5RjoVPl40L+dcFnwKQIC9limi/xs/U
         sNanCYEPYLBBbLw8ltoZ3WwQ0rsCklPI78VpBZ8FfsUwiqSeQrzzYlWDHigtbQsrDkFY
         FdFo38RvEBbZ+7AR9pS4WfG392jtmEA2KRXM1XYWdcLf3FjkiyB2ANofLYQFQ3Rhe5tu
         L0jIqqaspaCJ7EwhLawyrYLO4/sXXJHu7PFzX36WUh9+pLIXB+IBU+JKaL6kXYGq/WNH
         34Q2jdhKlPxBCGbKR6mTzd5zEgL/wouzZs/RyMakq6Su/gUHE0lwLjexiHse+PnFHY8x
         1BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ypgiu6q1Iz0Yn4IRUnjyh+oh2jFCd4nbbIEvAdriWkc=;
        b=VOp28T9GL5GF75rizbnU2WYfGVsxNMyvpg/ON1KceUXLSXLI8oI9hD1JHB1pEbcst+
         d0rGtOti/zAMhweHjNX64TxAA5/Xqwq1NdoFod6jOFuGdLn2b4eW3AogMylsibbA12K5
         p+rzkCwzAeItaNQZwAvbkxodQGlOu6ENoHChHSIJvb7p+Ijkd4JvCuoTcYnoku7JVfqL
         YhoVjp9rNgbSTEbpbGC4Iwldy7x2z8HeSpFNbV+Qmd6ddASfd6ID4wZR2TJ0cPH62KXW
         gRm2PwA6GUN4C0vkaYXGYCEgTZUfXHiaI1QuXnKIzuFtVADwDMp2UApnJe2lFeV0v91W
         pSqg==
X-Gm-Message-State: AOAM533pWaCBcx97ajtWY+WtqfGShTTp29i8Et8s0yI3Ppr+x2ctML4z
        sd/dFf7N+h1SSwMHU1wyQnY=
X-Google-Smtp-Source: ABdhPJzqa8uR2DbbFBTVcxjURcmO3NvsV+8B+mYGJjsVv8miCKayaFHrS0wExD8jC00JTzpvWbJzDw==
X-Received: by 2002:a17:90a:e396:: with SMTP id b22mr2935724pjz.155.1611109752672;
        Tue, 19 Jan 2021 18:29:12 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id 6sm389592pfz.34.2021.01.19.18.29.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:29:11 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 8E67F20442D38F; Wed, 20 Jan 2021 11:29:08 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 12/20] um: lkl: initialization and cleanup
Date:   Wed, 20 Jan 2021 11:27:17 +0900
Message-Id: <031847ceca73023566fba8e84433a615eac6a2f3.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/um/lkl/include/uapi/asm/host_ops.h |  20 +++
 arch/um/lkl/um/setup.c                  | 162 ++++++++++++++++++++++++
 tools/um/uml/process.c                  |   2 +
 3 files changed, 184 insertions(+)
 create mode 100644 arch/um/lkl/um/setup.c

diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index 976fc4301b3d..85d7d4790602 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -252,4 +252,24 @@ void *lkl_tls_get(struct lkl_tls_key *key);
  */
 void lkl_print(const char *str, int len);
 
+/**
+ * lkl_panic - called during a kernel panic
+ *
+ */
+void lkl_panic(void);
+
+/**
+ * lkl_start_kernel() - registers the host operations and starts the kernel
+ *
+ * @ops: pointer to host operations
+ * @fmt: format for command line string that is going to be used to
+ * generate the Linux kernel command line
+ *
+ * Return: 0 if there is no error; otherwise non-zero value returns.
+ *
+ * The function returns only after the kernel is shutdown with lkl_sys_halt.
+ */
+int lkl_start_kernel(struct lkl_host_operations *ops,
+		     const char *fmt, ...);
+
 #endif
diff --git a/arch/um/lkl/um/setup.c b/arch/um/lkl/um/setup.c
new file mode 100644
index 000000000000..ba8338d4fc23
--- /dev/null
+++ b/arch/um/lkl/um/setup.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/binfmts.h>
+#include <linux/init.h>
+#include <linux/init_task.h>
+#include <linux/personality.h>
+#include <linux/reboot.h>
+#include <linux/fs.h>
+#include <linux/start_kernel.h>
+#include <linux/fdtable.h>
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
+	lkl_panic();
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
+	init_sem = lkl_sem_alloc(0);
+	if (!init_sem)
+		return -ENOMEM;
+
+	ret = lkl_cpu_init();
+	if (ret)
+		goto out_free_init_sem;
+
+	ret = lkl_thread_create(lkl_run_kernel, NULL);
+	if (!ret) {
+		ret = -ENOMEM;
+		goto out_free_init_sem;
+	}
+
+	lkl_sem_down(init_sem);
+	lkl_sem_free(init_sem);
+	current_thread_info()->task->thread.arch.tid = lkl_thread_self();
+	lkl_cpu_change_owner(current_thread_info()->task->thread.arch.tid);
+
+	lkl_cpu_put();
+	is_running = 1;
+
+	return 0;
+
+out_free_init_sem:
+	lkl_sem_free(init_sem);
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
+	lkl_thread_join(current_thread_info()->task->thread.arch.tid);
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
+	ret = begin_new_exec(bprm);
+	if (ret)
+		return ret;
+	set_personality(PER_LINUX);
+	setup_new_exec(bprm);
+
+	set_binfmt(&lkl_run_init_binfmt);
+
+	init_pid_ns.child_reaper = 0;
+
+	syscalls_init();
+
+	lkl_sem_up(init_sem);
+	lkl_thread_exit();
+
+	return 0;
+}
+
+
+/* skip mounting the "real" rootfs. ramfs is good enough. */
+static int __init fs_setup(void)
+{
+	int fd, flags = 0;
+
+	if (force_o_largefile())
+		flags |= O_LARGEFILE;
+	fd = do_sys_open(AT_FDCWD, "/init", O_CREAT | flags, 0700);
+	WARN_ON(fd < 0);
+	close_fd(fd);
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

