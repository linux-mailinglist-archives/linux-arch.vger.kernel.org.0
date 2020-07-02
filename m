Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4A72125A8
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgGBOJX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgGBOJW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:09:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC0C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:09:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x3so7058417pfo.9
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wT5jpOPDB0NInqu4SBIEU+dMeRQLws/J0n6IzbaAb/A=;
        b=sXKldrSRb/lxDuTfQhPsI2OIvNCMPPyMmjF2BAMvLz+8jQIO2T9lONWgqAfVpLV6mP
         lBaFjgq+NIbScP/nXRPM/wlWdCDBunpiifKHGTVuhQbEBGsSYRJHzUjpTHGBRY0FJcm7
         jb13oPoVK6EwiBwD+ztBHzJAiaHEkDfnTxfurnQezOh8twwwleX36prCaqznwDI2A4xN
         fT0C/IfB2QcFxPcVXpT0ozF/5xXqYnGgL8O10KZ1QWe8ws4Zaw5pRYcegs4J61sREa7u
         qs7JugCw2y17rlFoHEGeRZKed3k7f+MAYTJRnq1us0rq8xOy+IEDcMPdCChpJeHZdB4m
         kC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wT5jpOPDB0NInqu4SBIEU+dMeRQLws/J0n6IzbaAb/A=;
        b=eiL/L2807p4EVYKcpKXLO/zngQ2pk58XkKtgan2HPN9kZim73qYmadbPi41oyb2Qre
         S/35nz1xAaUJ+22nAxAOWqoZgnPxZEuBrS39vXFRWQb+YMbNqknUbTYz1Z+QYlDGERm8
         bsI2gloQhvAV9jkRmpR23rID6Id0kySYRxqoMnmJ0tIXGzOp8snVxU3pEAZE3X/iFlUc
         6fkMlA4OJDegW6QMs6gVYo4doN7fddR6GXlGXJHppgEtANd4fChgqpabZq1+MlzcIGJa
         W7KuvP4jw90DHkQ0pd4MlmPV2yu/MwWVNIcrsc5mTG8htaaibWcQogHmGtvhvxvlIQHY
         dSwA==
X-Gm-Message-State: AOAM53223FMYbFcZMZYJA5i/9r6R1AFGDtvowmANZMjMji71p5HuQThD
        YUZbpMiu9YvfVi0jILAZamc=
X-Google-Smtp-Source: ABdhPJxacTFZTHVqPViNI4Ff2QLf+ulpqUN7Djs5GkBStsk7Csli4Zffes2RRioLOpL3h5/pAdH3Aw==
X-Received: by 2002:a63:5b07:: with SMTP id p7mr24218517pgb.250.1593698961727;
        Thu, 02 Jul 2020 07:09:21 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id t5sm8986680pgl.38.2020.07.02.07.09.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:09:21 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 0ADB0202D31D33; Thu,  2 Jul 2020 23:09:19 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 12/21] um: nommu: system call interface and application API
Date:   Thu,  2 Jul 2020 23:07:06 +0900
Message-Id: <f16b6d0a7d32c1d0669c22a24c58a8565e0eded1.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The application API is based on the kernel system call interface in
order to offer a stable API to applications. Note that we can't
offer the full Linux system call interface due to the limitations of
nommu mode such as lack of virtual memory, signal, user processes, etc.

The host is using dedicated kernel thread, which is switched upon the
entry of lkl_syscall so that numbers of context switches can be reduced
for the faster performance.

To expose the API definitions to applications, this commit uses
syscall_wrapper to define arch-specific information of syscall, and this
is used to generate syscall_defs.h for lkl so that it can be used
as a template of the list of syscall available for LKL apps.

To avoid collisions between the Linux API and the LKL API (e.g.  struct
stat, MKNOD, etc.) we use a python script to modify the user headers
and to prefix all of the global symbols (structures, typedefs,
defines) with LKL, lkl, _LKL, _lkl, __LKL or __lkl.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/include/uapi/asm/Kbuild             |   2 +
 arch/um/nommu/include/asm/syscall_wrapper.h |  57 ++++
 arch/um/nommu/include/asm/syscalls.h        |  15 +
 arch/um/nommu/include/uapi/asm/host_ops.h   |  14 +
 arch/um/nommu/include/uapi/asm/syscalls.h   | 287 ++++++++++++++++++++
 arch/um/nommu/include/uapi/asm/unistd.h     |  15 +
 arch/um/nommu/um/syscalls.c                 | 199 ++++++++++++++
 arch/um/scripts/headers_install.py          | 197 ++++++++++++++
 8 files changed, 786 insertions(+)
 create mode 100644 arch/um/include/uapi/asm/Kbuild
 create mode 100644 arch/um/nommu/include/asm/syscall_wrapper.h
 create mode 100644 arch/um/nommu/include/asm/syscalls.h
 create mode 100644 arch/um/nommu/include/uapi/asm/syscalls.h
 create mode 100644 arch/um/nommu/include/uapi/asm/unistd.h
 create mode 100644 arch/um/nommu/um/syscalls.c
 create mode 100755 arch/um/scripts/headers_install.py

diff --git a/arch/um/include/uapi/asm/Kbuild b/arch/um/include/uapi/asm/Kbuild
new file mode 100644
index 000000000000..a983c7f049bc
--- /dev/null
+++ b/arch/um/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+# no generated-y since we need special user headers handling
+# see arch/um/script/headers_install.py
diff --git a/arch/um/nommu/include/asm/syscall_wrapper.h b/arch/um/nommu/include/asm/syscall_wrapper.h
new file mode 100644
index 000000000000..bb2a7d4274f6
--- /dev/null
+++ b/arch/um/nommu/include/asm/syscall_wrapper.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __UM_SYSCALL_WRAPPER_H
+#define __UM_SYSCALL_WRAPPER_H
+
+#define __SC_ASCII(t, a) #t "," #a
+
+#define __ASCII_MAP0(m, ...)
+#define __ASCII_MAP1(m, t, a) m(t, a)
+#define __ASCII_MAP2(m, t, a, ...) m(t, a) "," __ASCII_MAP1(m, __VA_ARGS__)
+#define __ASCII_MAP3(m, t, a, ...) m(t, a) "," __ASCII_MAP2(m, __VA_ARGS__)
+#define __ASCII_MAP4(m, t, a, ...) m(t, a) "," __ASCII_MAP3(m, __VA_ARGS__)
+#define __ASCII_MAP5(m, t, a, ...) m(t, a) "," __ASCII_MAP4(m, __VA_ARGS__)
+#define __ASCII_MAP6(m, t, a, ...) m(t, a) "," __ASCII_MAP5(m, __VA_ARGS__)
+#define __ASCII_MAP(n, ...) __ASCII_MAP##n(__VA_ARGS__)
+
+#ifdef __MINGW32__
+#define SECTION_ATTRS "n0"
+#else
+#define SECTION_ATTRS "a"
+#endif
+
+#define __SYSCALL_DEFINE_ARCH(x, name, ...)				\
+	asm(".section .syscall_defs,\"" SECTION_ATTRS "\"\n"		\
+	    ".ascii \"#ifdef __NR" #name "\\n\"\n"			\
+	    ".ascii \"SYSCALL_DEFINE" #x "(" #name ","			\
+	    __ASCII_MAP(x, __SC_ASCII, __VA_ARGS__) ")\\n\"\n"		\
+	    ".ascii \"#endif\\n\"\n"					\
+	    ".section .text\n")
+
+#define SYSCALL_DEFINE0(sname)					\
+	SYSCALL_METADATA(_##sname, 0);				\
+	__SYSCALL_DEFINE_ARCH(0, _##sname);			\
+	asmlinkage long sys_##sname(void);			\
+	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
+	asmlinkage long sys_##sname(void)
+
+#define __SYSCALL_DEFINEx(x, name, ...)					\
+	__SYSCALL_DEFINE_ARCH(x, name, __VA_ARGS__);			\
+	__diag_push();							\
+	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
+		      "Type aliasing is used to sanitize syscall arguments");\
+	asmlinkage long sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))	\
+		__attribute__((alias(__stringify(__se_sys##name))));	\
+	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
+	static inline long __do_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__)); \
+	asmlinkage long __se_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__)); \
+	asmlinkage long __se_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__)) \
+	{								\
+		long ret = __do_sys##name(__MAP(x, __SC_CAST, __VA_ARGS__)); \
+		__MAP(x, __SC_TEST, __VA_ARGS__);			\
+		__PROTECT(x, ret, __MAP(x, __SC_ARGS, __VA_ARGS__));	\
+		return ret;						\
+	}								\
+	__diag_pop();							\
+	static inline long __do_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))
+
+#endif /* __UM_SYSCALL_WRAPPER_H */
diff --git a/arch/um/nommu/include/asm/syscalls.h b/arch/um/nommu/include/asm/syscalls.h
new file mode 100644
index 000000000000..6061d9415dad
--- /dev/null
+++ b/arch/um/nommu/include/asm/syscalls.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+int syscalls_init(void);
+void syscalls_cleanup(void);
+long lkl_syscall(long no, long *params);
+void wakeup_idle_host_task(void);
+
+#define sys_mmap sys_ni_syscall
+#define sys_rt_sigreturn sys_ni_syscall
+#define sys_arch_prctl sys_ni_syscall
+#define sys_iopl sys_ni_syscall
+#define sys_ioperm sys_ni_syscall
+#define sys_clone sys_ni_syscall
+
+int run_syscalls(void);
diff --git a/arch/um/nommu/include/uapi/asm/host_ops.h b/arch/um/nommu/include/uapi/asm/host_ops.h
index 720385fccbdf..6ee9489fc47e 100644
--- a/arch/um/nommu/include/uapi/asm/host_ops.h
+++ b/arch/um/nommu/include/uapi/asm/host_ops.h
@@ -38,6 +38,15 @@ struct lkl_jmp_buf {
  * @gettid - returns the host thread id of the caller, which need not
  * be the same as the handle returned by thread_create
  *
+ * @tls_alloc - allocate a thread local storage key; returns 0 if successful; if
+ * destructor is not NULL it will be called when a thread terminates with its
+ * argument set to the current thread local storage value
+ * @tls_free - frees a thread local storage key; returns 0 if successful
+ * @tls_set - associate data to the thread local storage key; returns 0 if
+ * successful
+ * @tls_get - return data associated with the thread local storage key or NULL
+ * on error
+ *
  * @jmp_buf_set - runs the give function and setups a jump back point by saving
  * the context in the jump buffer; jmp_buf_longjmp can be called from the give
  * function or any callee in that function to return back to the jump back
@@ -72,6 +81,11 @@ struct lkl_host_operations {
 	int (*thread_equal)(lkl_thread_t a, lkl_thread_t b);
 	long (*gettid)(void);
 
+	struct lkl_tls_key *(*tls_alloc)(void (*destructor)(void *));
+	void (*tls_free)(struct lkl_tls_key *key);
+	int (*tls_set)(struct lkl_tls_key *key, void *data);
+	void *(*tls_get)(struct lkl_tls_key *key);
+
 	void (*jmp_buf_set)(struct lkl_jmp_buf *jmpb, void (*f)(void));
 	void (*jmp_buf_longjmp)(struct lkl_jmp_buf *jmpb, int val);
 
diff --git a/arch/um/nommu/include/uapi/asm/syscalls.h b/arch/um/nommu/include/uapi/asm/syscalls.h
new file mode 100644
index 000000000000..751957b978cd
--- /dev/null
+++ b/arch/um/nommu/include/uapi/asm/syscalls.h
@@ -0,0 +1,287 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __UM_NOMMU_UAPI_SYSCALLS_H
+#define __UM_NOMMU_UAPI_SYSCALLS_H
+
+#include <autoconf.h>
+#include <linux/types.h>
+
+typedef __kernel_uid32_t	qid_t;
+typedef __kernel_fd_set		fd_set;
+typedef __kernel_mode_t		mode_t;
+typedef unsigned short		umode_t;
+typedef __u32			nlink_t;
+typedef __kernel_off_t		off_t;
+typedef __kernel_pid_t		pid_t;
+typedef __kernel_key_t		key_t;
+typedef __kernel_suseconds_t	suseconds_t;
+typedef __kernel_timer_t	timer_t;
+typedef __kernel_clockid_t	clockid_t;
+typedef __kernel_mqd_t		mqd_t;
+typedef __kernel_uid32_t	uid_t;
+typedef __kernel_gid32_t	gid_t;
+typedef __kernel_uid16_t        uid16_t;
+typedef __kernel_gid16_t        gid16_t;
+typedef unsigned long		uintptr_t;
+#ifdef CONFIG_UID16
+typedef __kernel_old_uid_t	old_uid_t;
+typedef __kernel_old_gid_t	old_gid_t;
+#endif
+typedef __kernel_loff_t		loff_t;
+typedef __kernel_size_t		size_t;
+typedef __kernel_ssize_t	ssize_t;
+typedef __kernel_time_t		time_t;
+typedef __kernel_clock_t	clock_t;
+typedef __u32			u32;
+typedef __s32			s32;
+typedef __u64			u64;
+typedef __s64			s64;
+
+typedef __kernel_long_t	__kernel_old_time_t;
+
+#define __user
+
+#include <asm/unistd.h>
+/* Temporary undefine system calls that don't have data types defined in UAPI
+ * headers
+ */
+#undef __NR_kexec_load
+#undef __NR_getcpu
+#undef __NR_sched_getattr
+#undef __NR_sched_setattr
+#undef __NR_sched_setparam
+#undef __NR_sched_getparam
+#undef __NR_sched_setscheduler
+#undef __NR_name_to_handle_at
+#undef __NR_open_by_handle_at
+
+/* deprecated system calls */
+#undef __NR_access
+#undef __NR_chmod
+#undef __NR_chown
+#undef __NR_lchown
+#undef __NR_open
+#undef __NR_creat
+#undef __NR_readlink
+#undef __NR_pipe
+#undef __NR_mknod
+#undef __NR_mkdir
+#undef __NR_rmdir
+#undef __NR_unlink
+#undef __NR_symlink
+#undef __NR_link
+#undef __NR_rename
+#undef __NR_getdents
+#undef __NR_select
+#undef __NR_poll
+#undef __NR_dup2
+#undef __NR_sysfs
+#undef __NR_ustat
+#undef __NR_inotify_init
+#undef __NR_epoll_create
+#undef __NR_epoll_wait
+#undef __NR_signalfd
+#undef __NR_eventfd
+
+#undef __NR_umount
+#define __NR_umount __NR_umount2
+
+#ifdef CONFIG_64BIT
+#define __NR_newfstat __NR3264_fstat
+#define __NR_newfstatat __NR3264_fstatat
+#endif
+
+#include <linux/time.h>
+#include <linux/times.h>
+#include <linux/timex.h>
+#include <linux/capability.h>
+#define __KERNEL__ /* to pull in S_ definitions */
+#include <linux/stat.h>
+#undef __KERNEL__
+#include <linux/errno.h>
+#include <linux/fcntl.h>
+#include <linux/fs.h>
+#include <asm/statfs.h>
+#include <asm/stat.h>
+#include <linux/bpf.h>
+#include <linux/msg.h>
+#include <linux/resource.h>
+#include <linux/sysinfo.h>
+#include <linux/shm.h>
+#include <linux/aio_abi.h>
+#include <linux/socket.h>
+#include <linux/perf_event.h>
+#include <linux/sem.h>
+#include <linux/futex.h>
+#include <linux/poll.h>
+#include <linux/mqueue.h>
+#include <linux/eventpoll.h>
+#include <linux/uio.h>
+#include <asm/signal.h>
+#include <asm/siginfo.h>
+#include <linux/utime.h>
+#include <asm/socket.h>
+#include <linux/icmp.h>
+#include <linux/ip.h>
+
+/* Define data structures used in system calls that are not defined in UAPI
+ * headers
+ */
+struct sockaddr {
+	unsigned short int sa_family;
+	char sa_data[14];
+};
+
+#define __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO 1
+#define __UAPI_DEF_IF_IFNAMSIZ	1
+#define __UAPI_DEF_IF_NET_DEVICE_FLAGS 1
+#define __UAPI_DEF_IF_IFREQ	1
+#define __UAPI_DEF_IF_IFMAP	1
+#include <linux/if.h>
+#define __UAPI_DEF_IN_IPPROTO	1
+#define __UAPI_DEF_IN_ADDR	1
+#define __UAPI_DEF_IN6_ADDR	1
+#define __UAPI_DEF_IP_MREQ	1
+#define __UAPI_DEF_IN_PKTINFO	1
+#define __UAPI_DEF_SOCKADDR_IN	1
+#define __UAPI_DEF_IN_CLASS	1
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/sockios.h>
+#include <linux/route.h>
+#include <linux/ipv6_route.h>
+#include <linux/ipv6.h>
+#include <linux/netlink.h>
+#include <linux/neighbour.h>
+#include <linux/rtnetlink.h>
+#include <linux/fib_rules.h>
+
+#include <linux/kdev_t.h>
+#include <linux/virtio_blk.h>
+#include <linux/virtio_net.h>
+#include <linux/virtio_ring.h>
+#include <linux/pkt_sched.h>
+#include <linux/io_uring.h>
+#include <linux/utsname.h>
+
+struct user_msghdr {
+	void		__user *msg_name;
+	int		msg_namelen;
+	struct iovec	__user *msg_iov;
+	__kernel_size_t	msg_iovlen;
+	void		__user *msg_control;
+	__kernel_size_t	msg_controllen;
+	unsigned int	msg_flags;
+};
+
+typedef __u32 key_serial_t;
+
+struct mmsghdr {
+	struct user_msghdr  msg_hdr;
+	unsigned int        msg_len;
+};
+
+struct linux_dirent64 {
+	u64		d_ino;
+	s64		d_off;
+	unsigned short	d_reclen;
+	unsigned char	d_type;
+	char		d_name[0];
+};
+
+struct linux_dirent {
+	unsigned long	d_ino;
+	unsigned long	d_off;
+	unsigned short	d_reclen;
+	char		d_name[1];
+};
+
+struct ustat {
+	__kernel_daddr_t	f_tfree;
+	__kernel_ino_t		f_tinode;
+	char			f_fname[6];
+	char			f_fpack[6];
+};
+
+struct __aio_sigset;
+struct clone_args;
+
+typedef __kernel_rwf_t		rwf_t;
+
+long lkl_syscall(long no, long *params);
+long lkl_sys_halt(void);
+
+#define __MAP0(m, ...)
+#define __MAP1(m, t, a) m(t, a)
+#define __MAP2(m, t, a, ...) m(t, a), __MAP1(m, __VA_ARGS__)
+#define __MAP3(m, t, a, ...) m(t, a), __MAP2(m, __VA_ARGS__)
+#define __MAP4(m, t, a, ...) m(t, a), __MAP3(m, __VA_ARGS__)
+#define __MAP5(m, t, a, ...) m(t, a), __MAP4(m, __VA_ARGS__)
+#define __MAP6(m, t, a, ...) m(t, a), __MAP5(m, __VA_ARGS__)
+#define __MAP(n, ...) __MAP##n(__VA_ARGS__)
+
+#define __SC_LONG(t, a) (long)(a)
+#define __SC_TABLE(t, a) {sizeof(t), (long long)(a)}
+#define __SC_DECL(t, a) t a
+
+#define LKL_SYSCALL0(name)					       \
+	static inline long lkl_sys##name(void)			       \
+	{							       \
+		long params[6];					       \
+		return lkl_syscall(__lkl__NR##name, params);	       \
+	}
+
+#if __BITS_PER_LONG == 32
+#define LKL_SYSCALLx(x, name, ...)					\
+	static inline							\
+	long lkl_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))		\
+	{								\
+		struct {						\
+			unsigned int size;				\
+			long long value;				\
+		} lkl_params[x] = { __MAP(x, __SC_TABLE, __VA_ARGS__) }; \
+		long sys_params[6], i, k;				\
+		for (i = k = 0; i < x && k < 6; i++, k++) {		\
+			if (lkl_params[i].size > sizeof(long) &&	\
+			    k + 1 < 6) {				\
+				sys_params[k] =				\
+					(long)(lkl_params[i].value & (-1UL)); \
+				k++;					\
+				sys_params[k] =				\
+					(long)(lkl_params[i].value >>	\
+					       __BITS_PER_LONG);	\
+			} else {					\
+				sys_params[k] = (long)(lkl_params[i].value); \
+			}						\
+		}							\
+		return lkl_syscall(__lkl__NR##name, sys_params);	\
+	}
+#else
+#define LKL_SYSCALLx(x, name, ...)					\
+	static inline							\
+	long lkl_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))		\
+	{								\
+		long lkl_params[6] = { __MAP(x, __SC_LONG, __VA_ARGS__) }; \
+		return lkl_syscall(__lkl__NR##name, lkl_params);	\
+	}
+#endif
+
+#define SYSCALL_DEFINE0(name, ...) LKL_SYSCALL0(name)
+#define SYSCALL_DEFINE1(name, ...) LKL_SYSCALLx(1, name, __VA_ARGS__)
+#define SYSCALL_DEFINE2(name, ...) LKL_SYSCALLx(2, name, __VA_ARGS__)
+#define SYSCALL_DEFINE3(name, ...) LKL_SYSCALLx(3, name, __VA_ARGS__)
+#define SYSCALL_DEFINE4(name, ...) LKL_SYSCALLx(4, name, __VA_ARGS__)
+#define SYSCALL_DEFINE5(name, ...) LKL_SYSCALLx(5, name, __VA_ARGS__)
+#define SYSCALL_DEFINE6(name, ...) LKL_SYSCALLx(6, name, __VA_ARGS__)
+
+#if __BITS_PER_LONG == 32
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpointer-to-int-cast"
+#endif
+
+#include <asm/syscall_defs.h>
+
+#if __BITS_PER_LONG == 32
+#pragma GCC diagnostic pop
+#endif
+
+#endif
diff --git a/arch/um/nommu/include/uapi/asm/unistd.h b/arch/um/nommu/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..1762ebb829f5
--- /dev/null
+++ b/arch/um/nommu/include/uapi/asm/unistd.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __UM_NOMMU_UAPI_UNISTD_H
+#define __UM_NOMMU_UAPI_UNISTD_H
+
+#define __ARCH_WANT_NEW_STAT
+#include <asm/bitsperlong.h>
+
+#if __BITS_PER_LONG == 64
+#define __ARCH_WANT_SYS_NEWFSTATAT
+#endif
+
+#include <asm-generic/unistd.h>
+
+
+#endif
diff --git a/arch/um/nommu/um/syscalls.c b/arch/um/nommu/um/syscalls.c
new file mode 100644
index 000000000000..fd343f855bad
--- /dev/null
+++ b/arch/um/nommu/um/syscalls.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
+#undef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
+#include <linux/syscalls.h>
+#define CONFIG_ARCH_HAS_SYSCALL_WRAPPER
+#endif
+
+#include <linux/stat.h>
+#include <linux/irq.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/jhash.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/net.h>
+#include <linux/task_work.h>
+
+#include <asm/host_ops.h>
+#include <asm/syscalls.h>
+#include <asm/cpu.h>
+#include <asm/sched.h>
+#include <kern_util.h>
+#include <os.h>
+
+typedef long (*syscall_handler_t)(long arg1, ...);
+
+#undef __SYSCALL
+#define __SYSCALL(nr, sym)[nr] = (syscall_handler_t)sym,
+
+syscall_handler_t syscall_table[__NR_syscalls] = {
+	[0 ... __NR_syscalls - 1] =  (syscall_handler_t)sys_ni_syscall,
+#undef __UM_NOMMU_UAPI_UNISTD_H
+#include <asm/unistd.h>
+
+#if __BITS_PER_LONG == 32
+#include <asm/unistd_32.h>
+#endif
+};
+
+
+static long run_syscall(long no, long *params)
+{
+	long ret;
+
+	if (no < 0 || no >= __NR_syscalls)
+		return -ENOSYS;
+
+	ret = syscall_table[no](params[0], params[1], params[2], params[3],
+				params[4], params[5]);
+
+	task_work_run();
+
+	return ret;
+}
+
+
+#define CLONE_FLAGS (CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_THREAD |	\
+		     CLONE_SIGHAND | SIGCHLD)
+
+static int host_task_id;
+static struct task_struct *host0;
+
+static int new_host_task(struct task_struct **task)
+{
+	pid_t pid;
+
+	switch_to_host_task(host0);
+
+	pid = kernel_thread(host_task_stub, NULL, CLONE_FLAGS);
+	if (pid < 0)
+		return pid;
+
+	rcu_read_lock();
+	*task = find_task_by_pid_ns(pid, &init_pid_ns);
+	rcu_read_unlock();
+
+	host_task_id++;
+
+	snprintf((*task)->comm, sizeof((*task)->comm), "host%d", host_task_id);
+
+	return 0;
+}
+static void exit_task(void)
+{
+	do_exit(0);
+}
+
+static void del_host_task(void *arg)
+{
+	struct task_struct *task = (struct task_struct *)arg;
+	struct thread_info *ti = task_thread_info(task);
+
+	if (lkl_cpu_get() < 0)
+		return;
+
+	switch_to_host_task(task);
+	host_task_id--;
+	set_ti_thread_flag(ti, TIF_SCHED_JB);
+	lkl_ops->jmp_buf_set(&ti->task->thread.arch.sched_jb, exit_task);
+}
+
+static struct lkl_tls_key *task_key;
+
+long lkl_syscall(long no, long *params)
+{
+	struct task_struct *task = host0;
+	long ret;
+
+	ret = lkl_cpu_get();
+	if (ret < 0)
+		return ret;
+
+	if (lkl_ops->tls_get) {
+		task = lkl_ops->tls_get(task_key);
+		if (!task) {
+			ret = new_host_task(&task);
+			if (ret)
+				goto out;
+			lkl_ops->tls_set(task_key, task);
+		}
+	}
+
+	switch_to_host_task(task);
+
+	ret = run_syscall(no, params);
+
+	if (no == __NR_reboot) {
+		thread_sched_jb();
+		return ret;
+	}
+
+out:
+	lkl_cpu_put();
+
+	return ret;
+}
+
+static struct task_struct *idle_host_task;
+
+/* called from idle, don't failed, don't block */
+void wakeup_idle_host_task(void)
+{
+	if (!need_resched() && idle_host_task)
+		wake_up_process(idle_host_task);
+}
+
+static int idle_host_task_loop(void *unused)
+{
+	struct thread_info *ti = task_thread_info(current);
+
+	snprintf(current->comm, sizeof(current->comm), "idle_host_task");
+	set_thread_flag(TIF_HOST_THREAD);
+	idle_host_task = current;
+
+	for (;;) {
+		lkl_cpu_put();
+		lkl_ops->sem_down(ti->task->thread.arch.sched_sem);
+		if (idle_host_task == NULL) {
+			lkl_ops->thread_exit();
+			return 0;
+		}
+		schedule_tail(ti->task->thread.prev_sched);
+	}
+}
+
+int syscalls_init(void)
+{
+	snprintf(current->comm, sizeof(current->comm), "host0");
+	set_thread_flag(TIF_HOST_THREAD);
+	host0 = current;
+
+	if (lkl_ops->tls_alloc) {
+		task_key = lkl_ops->tls_alloc(del_host_task);
+		if (!task_key)
+			return -1;
+	}
+
+	if (kernel_thread(idle_host_task_loop, NULL, CLONE_FLAGS) < 0) {
+		if (lkl_ops->tls_free)
+			lkl_ops->tls_free(task_key);
+		return -1;
+	}
+
+	return 0;
+}
+
+void syscalls_cleanup(void)
+{
+	if (idle_host_task) {
+		struct thread_info *ti = task_thread_info(idle_host_task);
+
+		idle_host_task = NULL;
+		lkl_ops->sem_up(ti->task->thread.arch.sched_sem);
+		lkl_ops->thread_join(ti->task->thread.arch.tid);
+	}
+
+	if (lkl_ops->tls_free)
+		lkl_ops->tls_free(task_key);
+}
diff --git a/arch/um/scripts/headers_install.py b/arch/um/scripts/headers_install.py
new file mode 100755
index 000000000000..ec7356c0dee9
--- /dev/null
+++ b/arch/um/scripts/headers_install.py
@@ -0,0 +1,197 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0
+import re, os, sys, argparse, multiprocessing, fnmatch
+
+srctree = os.environ["srctree"]
+objtree = os.environ["objtree"]
+install_hdr_path = os.environ["INSTALL_HDR_PATH"]
+header_paths = [ install_hdr_path + "/include/", "arch/um/nommu/include/uapi/",
+                 "arch/um/nommu/include/generated/uapi/", "include/generated/" ]
+
+headers = set()
+includes = set()
+
+def relpath2abspath(relpath):
+    if "generated" in relpath or install_hdr_path in relpath:
+        return objtree + "/" + relpath
+    else:
+        return srctree + "/" + relpath
+
+def find_headers(path):
+    headers.add(path)
+    f = open(relpath2abspath(path))
+    for l in f.readlines():
+        m = re.search("#\s*include <(.*)>", l)
+        try:
+            i = m.group(1)
+            for p in header_paths:
+                if os.access(relpath2abspath(p + i), os.R_OK):
+                    if p + i not in headers:
+                        includes.add(i)
+                        headers.add(p + i)
+                        find_headers(p + i)
+        except:
+            pass
+    f.close()
+
+def has_lkl_prefix(w):
+  return w.startswith("lkl") or w.startswith("_lkl") or w.startswith("__lkl") \
+         or w.startswith("LKL") or w.startswith("_LKL") or w.startswith("__LKL")
+
+def find_symbols(regexp, store):
+    for h in headers:
+        f = open(h)
+        for l in f.readlines():
+            m = regexp.search(l)
+            if not m:
+                continue
+            for e in reversed(m.groups()):
+                if e:
+                    if not has_lkl_prefix(e):
+                        store.add(e)
+                    break
+        f.close()
+
+def find_ml_symbols(regexp, store):
+    for h in headers:
+        for i in regexp.finditer(open(h).read()):
+            for j in reversed(i.groups()):
+                if j:
+                    if not has_lkl_prefix(j):
+                        store.add(j)
+                    break
+
+def find_enums(block_regexp, symbol_regexp, store):
+    for h in headers:
+        # remove comments
+        content = re.sub(re.compile("(\/\*(\*(?!\/)|[^*])*\*\/)", re.S|re.M), " ", open(h).read())
+        # remove preprocesor lines
+        clean_content = ""
+        for l in content.split("\n"):
+            if re.match("\s*#", l):
+                continue
+            clean_content += l + "\n"
+        for i in block_regexp.finditer(clean_content):
+            for j in reversed(i.groups()):
+                if j:
+                    for k in symbol_regexp.finditer(j):
+                        for l in k.groups():
+                            if l:
+                                if not has_lkl_prefix(l):
+                                    store.add(l)
+                                break
+
+def lkl_prefix(w):
+    r = ""
+
+    if w.startswith("__"):
+        r = "__"
+    elif w.startswith("_"):
+        r = "_"
+
+    if w.isupper():
+        r += "LKL"
+    else:
+        r += "lkl"
+
+    if not w.startswith("_"):
+        r += "_"
+
+    r += w
+
+    return r
+
+def replace(h):
+    content = open(h).read()
+    for i in includes:
+        search_str = "(#[ \t]*include[ \t]*[<\"][ \t]*)" + i + "([ \t]*[>\"])"
+        replace_str = "\\1" + "lkl/" + i + "\\2"
+        content = re.sub(search_str, replace_str, content)
+    tmp = ""
+    for w in re.split("(\W+)", content):
+        if w in defines:
+            w = lkl_prefix(w)
+        tmp += w
+    content = tmp
+    for s in structs:
+        search_str = "(\W?struct\s+)" + s + "(\W)"
+        replace_str = "\\1" + lkl_prefix(s) + "\\2"
+        content = re.sub(search_str, replace_str, content, flags = re.MULTILINE)
+    for s in unions:
+        search_str = "(\W?union\s+)" + s + "(\W)"
+        replace_str = "\\1" + lkl_prefix(s) + "\\2"
+        content = re.sub(search_str, replace_str, content, flags = re.MULTILINE)
+    open(h, 'w').write(content)
+
+parser = argparse.ArgumentParser(description='install lkl headers')
+parser.add_argument('path', help='path to install to', )
+parser.add_argument('-j', '--jobs', help='number of parallel jobs', default=1, type=int)
+args = parser.parse_args()
+
+find_headers("arch/um/nommu/include/uapi/asm/syscalls.h")
+headers.add("arch/um/nommu/include/uapi/asm/host_ops.h")
+
+if 'LKL_INSTALL_ADDITIONAL_HEADERS' in os.environ:
+    with open(os.environ['LKL_INSTALL_ADDITIONAL_HEADERS'], 'rU') as f:
+        for line in f.readlines():
+            line = line.split('#', 1)[0].strip()
+            if line != '':
+                headers.add(line)
+
+new_headers = set()
+
+for h in headers:
+    h = relpath2abspath(h)
+    dir = os.path.dirname(h)
+    out_dir = args.path + "/" + re.sub("(" + srctree + "/arch/um/nommu/include/uapi/|arch/um/nommu/include/generated/uapi/|include/generated/uapi/|include/generated|" + install_hdr_path + "/include/)(.*)", "lkl/\\2", dir)
+    try:
+        os.makedirs(out_dir)
+    except:
+        pass
+    print("  INSTALL\t%s" % (out_dir + "/" + os.path.basename(h)))
+    os.system(srctree+"/scripts/headers_install.sh %s %s" % (os.path.abspath(h),
+                                                       out_dir + "/" + os.path.basename(h)))
+    new_headers.add(out_dir + "/" + os.path.basename(h))
+
+headers = new_headers
+
+defines = set()
+structs = set()
+unions = set()
+
+p = re.compile("#[ \t]*define[ \t]*(\w+)")
+find_symbols(p, defines)
+p = re.compile("typedef.*(\(\*(\w+)\)\(.*\)\s*|\W+(\w+)\s*|\s+(\w+)\(.*\)\s*);")
+find_symbols(p, defines)
+p = re.compile("typedef\s+(struct|union)\s+\w*\s*{[^\\{\}]*}\W*(\w+)\s*;", re.M|re.S)
+find_ml_symbols(p, defines)
+defines.add("siginfo_t")
+defines.add("sigevent_t")
+p = re.compile("struct\s+(\w+)\s*\{")
+find_symbols(p, structs)
+structs.add("iovec")
+p = re.compile("union\s+(\w+)\s*\{")
+find_symbols(p, unions)
+p = re.compile("static\s+__inline__(\s+\w+)+\s+(\w+)\([^)]*\)\s")
+find_symbols(p, defines)
+p = re.compile("static\s+__always_inline(\s+\w+)+\s+(\w+)\([^)]*\)\s")
+find_symbols(p, defines)
+p = re.compile("enum\s+(\w*)\s*{([^}]*)}", re.M|re.S)
+q = re.compile("(\w+)\s*(,|=[^,]*|$)", re.M|re.S)
+find_enums(p, q, defines)
+
+# needed for i386
+defines.add("__NR_stime")
+
+def process_header(h):
+    print("  REPLACE\t%s" % (out_dir + "/" + os.path.basename(h)))
+    replace(h)
+
+p = multiprocessing.Pool(args.jobs)
+try:
+    p.map_async(process_header, headers).wait(999999)
+    p.close()
+except:
+    p.terminate()
+finally:
+    p.join()
-- 
2.21.0 (Apple Git-122.2)

