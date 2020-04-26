Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74871B904C
	for <lists+linux-arch@lfdr.de>; Sun, 26 Apr 2020 15:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDZNB2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Apr 2020 09:01:28 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:62214 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDZNB2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Apr 2020 09:01:28 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4997MS4qqFzQlKB;
        Sun, 26 Apr 2020 15:01:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 8JlkoUFgfQI2; Sun, 26 Apr 2020 15:01:18 +0200 (CEST)
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC] ptrace, pidfd: add pidfd_ptrace syscall
Date:   Sun, 26 Apr 2020 15:01:00 +0200
Message-Id: <20200426130100.306246-1-hagen@jauu.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A24BE1742
X-Rspamd-Score: 3.37 / 15.00 / 15.00
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Working on a safety-critical stress testing tool, using ptrace in an
rather uncommon way (stop, peeking memory, ...) for a bunch of
applications in an automated way I realized that once opened processes
where restarted and PIDs recycled.  Resulting in monitoring and
manipulating the wrong processes.

With the advent of pidfd we are now able to stick with one stable handle
to identifying processes exactly. We now have the ability to get this
race free. Sending signals now works like a charm, next step is to
extend the functionality also for ptrace.

API:
         long pidfd_ptrace(int pidfd, enum __ptrace_request request,
                           void *addr, void *data, unsigned flags);

Based on original ptrace, the following API changes where made:

- Process identificator (pidfd) is now moved as first argument, this is aligned
  with pidfd_send_signal(int pidfd, ...) because potential future pidfd_* will have
  one thing in common: the pid identifier. I think is natural to have
  this argument upfront
- Add an additional flags argument, not used now - but you never know

All other arguments are identical compared to ptrace - no other
modifications where made.

Currently there are some pieces missing! This is just an early proposal
for a new syscall. Still missing:
- support for every architecture
- re-use shared functions and move to common place
- perf syscall registration
- selftests
- ...

Signed-off-by: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: Christian Brauner <christian@brauner.io>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Sargun Dhillon <sargun@sargun.me>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/syscalls.h               |   2 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 kernel/ptrace.c                        | 129 ++++++++++++++++++++-----
 kernel/sys_ni.c                        |   1 +
 6 files changed, 115 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 54581ac671b4..593f7fab90eb 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -442,3 +442,4 @@
 435	i386	clone3			sys_clone3
 437	i386	openat2			sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd
+438	i386	pidfd_ptrace		sys_pidfd_ptrace
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 37b844f839bc..cd76d8343510 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -359,6 +359,7 @@
 435	common	clone3			sys_clone3
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd		sys_pidfd_getfd
+439	common	pidfd_ptrace		sys_pidfd_ptrace
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..254b071a5334 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1003,6 +1003,8 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_pidfd_ptrace(int pidfd, long request, unsigned long addr,
+		                 unsigned long data, unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 3a3201e4618e..64749a6f156e 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -855,9 +855,11 @@ __SYSCALL(__NR_clone3, sys_clone3)
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+#define __NR_pidfd_getfd 439
+__SYSCALL(__NR_pidfd_ptrace, sys_pidfd_ptrace)
 
 #undef __NR_syscalls
-#define __NR_syscalls 439
+#define __NR_syscalls 440
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..8f4e99247742 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -29,6 +29,7 @@
 #include <linux/regset.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/cn_proc.h>
+#include <linux/proc_fs.h>
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
 
@@ -1239,48 +1240,132 @@ int ptrace_request(struct task_struct *child, long request,
 #define arch_ptrace_attach(child)	do { } while (0)
 #endif
 
+static inline long ptrace_call(struct task_struct *task, long request, unsigned long addr,
+		               unsigned long data)
+{
+	long ret;
+
+	if (request == PTRACE_ATTACH || request == PTRACE_SEIZE) {
+		ret = ptrace_attach(task, request, addr, data);
+		/*
+		 * Some architectures need to do book-keeping after
+		 * a ptrace attach.
+		 */
+		if (!ret)
+			arch_ptrace_attach(task);
+		goto out;
+	}
+
+	ret = ptrace_check_attach(task, request == PTRACE_KILL ||
+				  request == PTRACE_INTERRUPT);
+	if (ret < 0)
+		goto out;
+
+	ret = arch_ptrace(task, request, addr, data);
+	if (ret || request != PTRACE_DETACH)
+		ptrace_unfreeze_traced(task);
+
+ out:
+	put_task_struct(task);
+	return ret;
+}
+
 SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 		unsigned long, data)
 {
-	struct task_struct *child;
+	struct task_struct *task;
 	long ret;
 
 	if (request == PTRACE_TRACEME) {
 		ret = ptrace_traceme();
 		if (!ret)
 			arch_ptrace_attach(current);
-		goto out;
+		return ret;
 	}
 
-	child = find_get_task_by_vpid(pid);
-	if (!child) {
+	task = find_get_task_by_vpid(pid);
+	if (!task) {
 		ret = -ESRCH;
 		goto out;
 	}
 
-	if (request == PTRACE_ATTACH || request == PTRACE_SEIZE) {
-		ret = ptrace_attach(child, request, addr, data);
-		/*
-		 * Some architectures need to do book-keeping after
-		 * a ptrace attach.
-		 */
+
+	ret = ptrace_call(task, request, addr, data);
+out:
+	return ret;
+}
+
+static struct pid *pidfd_to_pid(const struct file *file)
+{
+	struct pid *pid;
+
+	pid = pidfd_pid(file);
+	if (!IS_ERR(pid))
+		return pid;
+
+	return tgid_pidfd_to_pid(file);
+}
+
+static bool access_pidfd_pidns(struct pid *pid)
+{
+	struct pid_namespace *active = task_active_pid_ns(current);
+	struct pid_namespace *p = ns_of_pid(pid);
+
+	for (;;) {
+		if (!p)
+			return false;
+		if (p == active)
+			break;
+		p = p->parent;
+	}
+
+	return true;
+}
+
+SYSCALL_DEFINE5(pidfd_ptrace, int, pidfd, long, request, unsigned long, addr,
+		unsigned long, data, unsigned int, flags)
+{
+	long ret;
+	struct fd f;
+	struct pid *pid;
+	struct task_struct *task;
+
+	/* Enforce flags be set to 0 until we add an extension. */
+	if (flags)
+		return -EINVAL;
+
+	if (request == PTRACE_TRACEME) {
+		ret = ptrace_traceme();
 		if (!ret)
-			arch_ptrace_attach(child);
-		goto out_put_task_struct;
+			arch_ptrace_attach(current);
+		goto out;
 	}
 
-	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
-				  request == PTRACE_INTERRUPT);
-	if (ret < 0)
-		goto out_put_task_struct;
+	f = fdget(pidfd);
+	if (!f.file)
+		return -EBADF;
 
-	ret = arch_ptrace(child, request, addr, data);
-	if (ret || request != PTRACE_DETACH)
-		ptrace_unfreeze_traced(child);
+	/* Is this a pidfd? */
+	pid = pidfd_to_pid(f.file);
+	if (IS_ERR(pid)) {
+		ret = PTR_ERR(pid);
+		goto err;
+	}
 
- out_put_task_struct:
-	put_task_struct(child);
- out:
+	ret = -EINVAL;
+	if (!access_pidfd_pidns(pid))
+		goto err;
+
+	task = pid_task(pid, PIDTYPE_PID);
+	if (!task) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = ptrace_call(task, request, addr, data);
+err:
+	fdput(f);
+out:
 	return ret;
 }
 
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 3b69a560a7ac..f7795294b8c4 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -166,6 +166,7 @@ COND_SYSCALL(delete_module);
 COND_SYSCALL(syslog);
 
 /* kernel/ptrace.c */
+COND_SYSCALL_COMPAT(pidfd_ptrace);
 
 /* kernel/sched/core.c */
 
-- 
2.26.2

