Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE05238A2
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2019 15:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbfETNqj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 May 2019 09:46:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36026 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbfETNqc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 May 2019 09:46:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so14712998wru.3
        for <linux-arch@vger.kernel.org>; Mon, 20 May 2019 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVaG2UauaR9vj3yryOR+m+3UOXCKK0FL2c+RhB+Oxmo=;
        b=PmbXM4nqGpRsrXwN0mWhsNiU71a5IPvHFUvuWw0JF5i2lXD6CBX/P8HsGDNMx8Dk3r
         gRUaoZ+uU5NKecYvq24D/6byIxMzC1d/eTJQ56BH2gikkBVWTWESf0eIfuKb7oYNsA8x
         HQKUyNLssnSwx1A50bP9ZEh4lJhAxIZ1ZYAqRqIZ/CaIloR9t7vJaeMI4xMWNIy/zsKl
         gsuL0qGLsKS0tJ4bFVkSNmHhlpPEztAkI4Aa/wu0djjR/hP1RoHM3nI1GjfyFDr9EJt/
         E5+yuXqwqszfl1GFIhAzJrG6HBCS9vy3Nb+kJkHX0avLZTA7XJBr/rMyj0hgy1zuigIT
         lYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVaG2UauaR9vj3yryOR+m+3UOXCKK0FL2c+RhB+Oxmo=;
        b=ZNyxCF3xuF3DyP8hApX5LIXbZw6rQPgtAnAx8LHv43A2XDVugDOYHkcWviYmlzeq9B
         DtB5rcDznKnN5fEIgUlzDUt4B2Ntop/YQP3pFIygAlY9Zmv0mWX56kCt7mpjCDxz935/
         0bzRSNffovkmJdNh7BMdgFBMbA93sO9Mhs5GieF6nS02UH5Kp2legMWx4cuMeDbPp1HU
         DvciGX5SUFuig6Z+VdWzdLDJa6i9MAh1qUy4apqWfE12+lMyDTU/Ww+85n7rctzfyc5x
         N1iKkVucBKUtCXAUZ+R6TvDI1S+wLdGKoP60kGif+2rP3PiImXCKJ7swyufhp7dsM3ne
         YQug==
X-Gm-Message-State: APjAAAUSeAkoS0DAdlEdZAvrmKdsV5OWAloTQ6vceV7GlAAYQ+oInykY
        aeJGs88zerAq9XSfHDrqV+623A==
X-Google-Smtp-Source: APXvYqzr/Y5sIjHVcRHmSNSgylllDyZ9BvOb+aml+6rIUUFOCdp+HSi2RPIQZqy48m5HlGjEeGZ14A==
X-Received: by 2002:adf:fc46:: with SMTP id e6mr17267433wrs.298.1558359988390;
        Mon, 20 May 2019 06:46:28 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id k17sm14506592wrm.73.2019.05.20.06.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 06:46:27 -0700 (PDT)
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
        dancol@google.com, serge@hallyn.com, surenb@google.com,
        kernel-team@android.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 1/2] pid: add pidfd_open()
Date:   Mon, 20 May 2019 15:46:04 +0200
Message-Id: <20190520134605.29116-1-christian@brauner.io>
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
caller can currently not create a pollable pidfd. This is a problem for
Android's low memory killer (LMK) and service managers such as systemd.
Both are examples of tools that want to make use of pidfds to get reliable
notification of process exit for non-parents (pidfd polling) and race-free
signal sending (pidfd_send_signal()). They intend to switch to this API for
process supervision/management as soon as possible. Having no way to get
pollable pidfds from PID-only processes is one of the biggest blockers for
them in adopting this api. With pidfd_open() making it possible to retrieve
pidfds for PID-based processes we enable them to adopt this api.

In line with Arnd's recent changes to consolidate syscall numbers across
architectures, I have added the pidfd_open() syscall to all architectures
at the same time.

Signed-off-by: Christian Brauner <christian@brauner.io>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
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
v2:
- Oleg Nesterov <oleg@redhat.com>:
  - avoid using additional variable
  - remove unneeded comment
- Arnd Bergmann <arnd@arndb.de>:
  - switch from 428 to 434 since the new mount api has taken it
  - bump syscall numbers in arch/arm64/include/asm/unistd.h
- Joel Fernandes (Google) <joel@joelfernandes.org>:
  - switch from ESRCH to EINVAL when the passed-in pid does not refer to a
    thread-group leader
- Christian Brauner <christian@brauner.io>:
  - rebase on v5.2-rc1
  - adapt syscall number to account for new mount api syscalls
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/include/asm/unistd.h             |  2 +-
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
 kernel/pid.c                                | 43 +++++++++++++++++++++
 21 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 9e7704e44f6d..1db9bbcfb84e 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -473,3 +473,4 @@
 541	common	fsconfig			sys_fsconfig
 542	common	fsmount				sys_fsmount
 543	common	fspick				sys_fspick
+544	common	pidfd_open			sys_pidfd_open
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index aaf479a9e92d..81e6e1817c45 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -447,3 +447,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 70e6882853c0..e8f7d95a1481 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		434
+#define __NR_compat_syscalls		435
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index c39e90600bb3..7a3158ccd68e 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -886,6 +886,8 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_pidfd_open 434
+__SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index e01df3f2f80d..ecc44926737b 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -354,3 +354,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7e3d0734b2f3..9a3eb2558568 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -433,3 +433,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 26339e417695..ad706f83c755 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -439,3 +439,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 0e2dd68ade57..97035e19ad03 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -372,3 +372,4 @@
 431	n32	fsconfig			sys_fsconfig
 432	n32	fsmount				sys_fsmount
 433	n32	fspick				sys_fspick
+434	n32	pidfd_open			sys_pidfd_open
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index c9e377d59232..5022b9e179c2 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -430,3 +430,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 103655d84b4b..f2c3bda2d39f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -515,3 +515,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index e822b2964a83..6ebacfeaf853 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -436,3 +436,4 @@
 431  common	fsconfig		sys_fsconfig			sys_fsconfig
 432  common	fsmount			sys_fsmount			sys_fsmount
 433  common	fspick			sys_fspick			sys_fspick
+434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 016a727d4357..834c9c7d79fa 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -436,3 +436,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index e047480b1605..c58e71f21129 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -479,3 +479,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ad968b7bac72..43e4429a5272 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
 432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
+434	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..1bee0a77fdd3 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+434	common	pidfd_open		__x64_sys_pidfd_open
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 5fa0ee1c8e00..782b81945ccc 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -404,3 +404,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
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
index a87904daf103..e5684a4512c0 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_pidfd_open 434
+__SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 435
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/fork.c b/kernel/fork.c
index b4cba953040a..c3df226f47a1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1724,7 +1724,7 @@ const struct file_operations pidfd_fops = {
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
  */
-static int pidfd_create(struct pid *pid)
+int pidfd_create(struct pid *pid)
 {
 	int fd;
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 89548d35eefb..8fc9d94f6ac1 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -37,6 +37,7 @@
 #include <linux/syscalls.h>
 #include <linux/proc_ns.h>
 #include <linux/proc_fs.h>
+#include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/idr.h>
 
@@ -450,6 +451,48 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
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
+	if (!pid_task(p, PIDTYPE_TGID))
+		ret = -EINVAL;
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

