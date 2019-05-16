Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D6F208D5
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 16:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfEPOAV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 10:00:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46362 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfEPOAV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 10:00:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id f37so5367761edb.13
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdh1LHywkV2wJSJtwTdvTYm1jPecNAhthVSzWzS8x28=;
        b=EfH+kmAUPYIdi8i/ZLz20DN6VfddPwKIm3dOIsBvKjGp8+W3IVOVFCAyF9CZwJ7FGu
         JdaJzyjLq9y5QgSU/ju1uz/X1/LtrpPOPnntcJCBY0OYfIGuUgdQg0Vi+xqyKb/PdM/+
         a+T366Z3pa1iMVFlJDKD4CKvzNn+L6ClSzOJSLu89C4k2UmhfsuqufaanjNx0ajIpeI2
         idCeGjvnfgorO7tvg2yAl7Rvqo+lBO9Du3ETT99moeRztpkhh/8x7MhN02EkQwgnPU4h
         JuD3AcqSnkGl9eliZBLPnSQ00nDlMTmMKW7zXW04kg7OjT6kraFritUXTjITi9F6MT6P
         o69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdh1LHywkV2wJSJtwTdvTYm1jPecNAhthVSzWzS8x28=;
        b=D43BHs84zJm2UuRAmDmWc79WKbVQOKyLFi9WT8n+e2QpTzUgyyCArOSTHJubj3GrRK
         3uXrUJeQHaaHet1KOMA0NzIOmjv8Y+6x0drYJrGe4kybM0SIqzFHDwuVamKlnhQ0dJxf
         7katWL0sGiZ7CHKas9jStXDjDdFbJ5jaxLqpOy8/8elkVOFb34lwedi65O4Rn292PXOj
         KH77Q8sj/mmRtjJ1mbKjW4nPQaqitxvJCerk9H9NmP3I5iSM22lBtQLb0FR7iRa/ONNj
         ikD4neA/dW5i+s7xq7Fu5kA+ys3EY7JkVDindR8BZVfdlJd3rbXIP3fsIwTIByEq2knA
         VU6w==
X-Gm-Message-State: APjAAAWqLoyDWm8ewOnAX5wuTUO5Wv83wEj883sSDwhNa2PWPJl/NZBL
        s529hIKNQM4ZXKDorEdEy8tBUA==
X-Google-Smtp-Source: APXvYqwuOTQfi39bbLw0or9wCLE252NbPANqnRP1ECxNn0OftR1CtJ17zgJSULTBTb8tkyCdghu/TQ==
X-Received: by 2002:a50:89b0:: with SMTP id g45mr51448451edg.200.1558015218674;
        Thu, 16 May 2019 07:00:18 -0700 (PDT)
Received: from localhost.localdomain ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id y20sm1093563ejb.40.2019.05.16.07.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:00:17 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jannh@google.com, oleg@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Cc:     akpm@linux-foundation.org, cyphar@cyphar.com, dhowells@redhat.com,
        ebiederm@xmission.com, elena.reshetova@intel.com,
        keescook@chromium.org, luto@amacapital.net, luto@kernel.org,
        tglx@linutronix.de, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, joel@joelfernandes.org,
        dancol@google.com, serge@hallyn.com,
        Christian Brauner <christian@brauner.io>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v1 1/2] pid: add pidfd_open()
Date:   Thu, 16 May 2019 15:59:42 +0200
Message-Id: <20190516135944.7205-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds the pidfd_open() syscall. It allows a caller to retrieve pollable
pidfds for a process which did not get created via CLONE_PIDFD, i.e. for a
process that is created via traditional fork()/clone() calls that is only
referenced by a PID:

int pidfd = pidfd_open(1234, 0);
ret = pidfd_send_signal(pidfd, SIGSTOP, NULL, 0);

With the introduction of pidfds through CLONE_PIDFD it is possible to
created pidfds at process creation time.
However, a lot of processes get created with traditional PID-based calls
such as fork() or clone() (without CLONE_PIDFD). For these processes a
caller can currently not create a pollable pidfd. This is a huge problem
for Android's low memory killer (LMK) and service managers such as systemd.
Both are examples of tools that want to make use of pidfds to get reliable
notification of process exit for non-parents (pidfd polling) and race-free
signal sending (pidfd_send_signal()). They intend to switch to this API for
process supervision/management as soon as possible. Having no way to get
pollable pidfds from PID-only processes is one of the biggest blockers for
them in adopting this api. With pidfd_open() making it possible to retrieve
pidfd for PID-based processes we enable them to adopt this api.

In line with Arnd's recent changes to consolidate syscall numbers across
architectures, I have added the pidfd_open() syscall to all architectures
at the same time.

Signed-off-by: Christian Brauner <christian@brauner.io>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-api@vger.kernel.org
---
v1:
- kbuild test robot <lkp@intel.com>:
  - add missing entry for pidfd_open to arch/arm/tools/syscall.tbl
- Oleg Nesterov <oleg@redhat.com>:
  - use simpler thread-group leader check
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/include/asm/unistd32.h           |  2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 include/linux/pid.h                         |  1 +
 include/linux/syscalls.h                    |  1 +
 include/uapi/asm-generic/unistd.h           |  4 +-
 kernel/fork.c                               |  2 +-
 kernel/pid.c                                | 50 +++++++++++++++++++++
 20 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 165f268beafc..ddc3c93ad7a7 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -467,3 +467,4 @@
 535	common	io_uring_setup			sys_io_uring_setup
 536	common	io_uring_enter			sys_io_uring_enter
 537	common	io_uring_register		sys_io_uring_register
+538	common	pidfd_open			sys_pidfd_open
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 0393917eaa57..fc41fb34a636 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -441,3 +441,4 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	pidfd_open			sys_pidfd_open
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 23f1a44acada..350e2049b4a9 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -874,6 +874,8 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
 __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
+#define __NR_pidfd_open 428
+__SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 56e3d0b685e1..7115f6dd347a 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -348,3 +348,4 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	pidfd_open			sys_pidfd_open
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index df4ec3ec71d1..44bf12b16ffe 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -427,3 +427,4 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	pidfd_open			sys_pidfd_open
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 4964947732af..0d32e5152dc0 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -433,3 +433,4 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	pidfd_open			sys_pidfd_open
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 9392dfe33f97..726e107b3c9f 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -366,3 +366,4 @@
 425	n32	io_uring_setup			sys_io_uring_setup
 426	n32	io_uring_enter			sys_io_uring_enter
 427	n32	io_uring_register		sys_io_uring_register
+428	n32	pidfd_open			sys_pidfd_open
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index fe8ca623add8..83b46b568d51 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -424,3 +424,4 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	pidfd_open			sys_pidfd_open
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 00f5a63c8d9a..5294d04d7fa5 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -509,3 +509,4 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	pidfd_open			sys_pidfd_open
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 061418f787c3..dcdb838adf49 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -430,3 +430,4 @@
 425  common	io_uring_setup		sys_io_uring_setup              sys_io_uring_setup
 426  common	io_uring_enter		sys_io_uring_enter              sys_io_uring_enter
 427  common	io_uring_register	sys_io_uring_register           sys_io_uring_register
+428  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 480b057556ee..8e66edfbc521 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -430,3 +430,4 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	pidfd_open			sys_pidfd_open
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index a1dd24307b00..d6f3bc686939 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -473,3 +473,4 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	pidfd_open			sys_pidfd_open
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4cd5f982b1e5..1af6b469160a 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
 426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
 427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
+428	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 64ca0d06259a..c18e6ebe3387 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
 427	common	io_uring_register	__x64_sys_io_uring_register
+428	common	pidfd_open		__x64_sys_pidfd_open
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 30084eaf8422..21ee795f3003 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -398,3 +398,4 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	pidfd_open			sys_pidfd_open
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 3c8ef5a199ca..c938a92eab99 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -67,6 +67,7 @@ struct pid
 extern struct pid init_struct_pid;
 
 extern const struct file_operations pidfd_fops;
+extern int pidfd_create(struct pid *pid);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe1be5b..989055e0b501 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -929,6 +929,7 @@ asmlinkage long sys_clock_adjtime32(clockid_t which_clock,
 				struct old_timex32 __user *tx);
 asmlinkage long sys_syncfs(int fd);
 asmlinkage long sys_setns(int fd, int nstype);
+asmlinkage long sys_pidfd_open(pid_t pid, unsigned int flags);
 asmlinkage long sys_sendmmsg(int fd, struct mmsghdr __user *msg,
 			     unsigned int vlen, unsigned flags);
 asmlinkage long sys_process_vm_readv(pid_t pid,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index dee7292e1df6..94a257a93d20 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -832,9 +832,11 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
 __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
+#define __NR_pidfd_open 428
+__SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 
 #undef __NR_syscalls
-#define __NR_syscalls 428
+#define __NR_syscalls 429
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/fork.c b/kernel/fork.c
index 737db1828437..980cc1d2b8d4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1714,7 +1714,7 @@ const struct file_operations pidfd_fops = {
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
  */
-static int pidfd_create(struct pid *pid)
+int pidfd_create(struct pid *pid)
 {
 	int fd;
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 20881598bdfa..4afca3d6dcb8 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -38,6 +38,7 @@
 #include <linux/syscalls.h>
 #include <linux/proc_ns.h>
 #include <linux/proc_fs.h>
+#include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/idr.h>
 
@@ -451,6 +452,55 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 	return idr_get_next(&ns->idr, &nr);
 }
 
+/**
+ * pidfd_open() - Open new pid file descriptor.
+ *
+ * @pid:   pid for which to retrieve a pidfd
+ * @flags: flags to pass
+ *
+ * This creates a new pid file descriptor with the O_CLOEXEC flag set for
+ * the process identified by @pid. Currently, the process identified by
+ * @pid must be a thread-group leader. This restriction currently exists
+ * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
+ * be used with CLONE_THREAD) and pidfd polling (only supports thread group
+ * leaders).
+ *
+ * Return: On success, a cloexec pidfd is returned.
+ *         On error, a negative errno number will be returned.
+ */
+SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
+{
+	int fd, ret;
+	struct pid *p;
+	struct task_struct *tsk;
+
+	if (flags)
+		return -EINVAL;
+
+	if (pid <= 0)
+		return -EINVAL;
+
+	p = find_get_pid(pid);
+	if (!p)
+		return -ESRCH;
+
+	ret = 0;
+	rcu_read_lock();
+	/*
+	 * If this returns non-NULL the pid was used as a thread-group
+	 * leader. Note, we race with exec here: If it changes the
+	 * thread-group leader we might return the old leader.
+	 */
+	tsk = pid_task(p, PIDTYPE_TGID);
+	if (!tsk)
+		ret = -ESRCH;
+	rcu_read_unlock();
+
+	fd = ret ?: pidfd_create(p);
+	put_pid(p);
+	return fd;
+}
+
 void __init pid_idr_init(void)
 {
 	/* Verify no one has done anything silly: */
-- 
2.21.0

