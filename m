Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107C42FC90A
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbhATDcC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732059AbhATC3x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:53 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75021C0613D3
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:50 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x12so11662907plr.10
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVsmm0PG5z3WdArxPZod8DyojNLUmU9ogrzEl7sHLN0=;
        b=MmrWcN0o3wOgZUudNSQC7Tn9/N3nCo4jbrxTC0G3l2a3ckLMkOoVdgX0Gk8n7lCBQ9
         BcJdAimIEjAfX5Xkmx86uvtLojP/+Ale+FeJ/Wu9AzOYDZLWAcdtFLpXa7KynflnR/SF
         qDIApEqM8QBO4gjn/zbW0tG93THS6CIPAFqpgHKz9pFuMobqvTn+JbQu9MzvcQ1Vx260
         VggzrUjjglAfLzLbUC0qy+IsdTpPjUX4V6YU3xiFosfnZnYax4Fw6wQ7R1ix36DS2LtP
         52cgtXx9SuzU/2LYjldn2aUALVf00tTUqXfPFrmwiw15PEqS14L8nTTFffyN0LpzTy3M
         U36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVsmm0PG5z3WdArxPZod8DyojNLUmU9ogrzEl7sHLN0=;
        b=Gu2aAClGmzxhHvkg+ExW2IWZtFArx1vx1ThuZUpL+Jv5gCkKp+tbghXOJUKuGinSqa
         UsW8DWe0Fiu5c9vIhLIBP1zXKeWMMTW37Es1W3/An5VvGvHmlmIKrEMLtUVsZMghlNmc
         Yaq33YIgCZ+Xx11wmBuZ0pwWGUJ7wjyKz396uj+8LOPyHJ3CQFtoefKWPFyWnGzO8Ml0
         ANmrKsbF3gqQ2DVY1GQRo7lIVz/Gb4SU8jgaSoWJ6ZtzavZbo6wo2QH9YR5dkH1iAux9
         RyS+UMSaUd/5fFChAdbTQF3FuXvhyI3/MkAFLIWCsNxMzngBG8cPIOkRrytrwQ/86/i8
         TBfg==
X-Gm-Message-State: AOAM532zE9z2KBfOwa57pYaQ4FJRtProts6wweT4dX3XhATMYaeHDelA
        iJMXXYQJVA4Y5EAN9IRmE4Q=
X-Google-Smtp-Source: ABdhPJyPJM3ActgkX7nE6LQk6EMwjlZ6agJ/M4ajSLM/oyi8AYtXws5iXoLS0SYWK02fkoawbInQVg==
X-Received: by 2002:a17:90b:34b:: with SMTP id fh11mr2865687pjb.225.1611109729750;
        Tue, 19 Jan 2021 18:28:49 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id a19sm370223pfi.130.2021.01.19.18.28.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:28:49 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id B1A5820442D348; Wed, 20 Jan 2021 11:28:46 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [RFC v8 10/20] um: lkl: system call interface and application API
Date:   Wed, 20 Jan 2021 11:27:15 +0900
Message-Id: <04ab68956d43fea811745957f014a9a44dbdf4bd.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The application API is based on the kernel system call interface in
order to offer a stable API to applications. Note that we can't
offer the full Linux system call interface due to the limitations of
library mode such as lack of virtual memory, signal, user processes, etc.

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

This commit also added an exception to SPDX-License-Identifier for the
library mode of UML, since applications may statically link the library,
thus this the GPL exception to the exported headers doesn't apply to.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/Kconfig                            |   1 +
 arch/um/lkl/Makefile.um                    |  16 ++
 arch/um/lkl/include/asm/syscall_wrapper.h  |  57 ++++
 arch/um/lkl/include/asm/syscalls.h         |  15 +
 arch/um/lkl/include/uapi/asm/Kbuild        |   6 +
 arch/um/lkl/include/uapi/asm/bitsperlong.h |   5 +-
 arch/um/lkl/include/uapi/asm/byteorder.h   |   6 +-
 arch/um/lkl/include/uapi/asm/host_ops.h    |  43 +++
 arch/um/lkl/include/uapi/asm/syscalls.h    | 301 +++++++++++++++++++++
 arch/um/lkl/include/uapi/asm/unistd.h      |  15 +
 arch/um/lkl/um/syscalls.c                  | 193 +++++++++++++
 arch/um/scripts/headers_install.py         | 200 ++++++++++++++
 scripts/headers_install.sh                 |   6 +-
 13 files changed, 860 insertions(+), 4 deletions(-)
 create mode 100644 arch/um/lkl/include/asm/syscall_wrapper.h
 create mode 100644 arch/um/lkl/include/asm/syscalls.h
 create mode 100644 arch/um/lkl/include/uapi/asm/Kbuild
 create mode 100644 arch/um/lkl/include/uapi/asm/syscalls.h
 create mode 100644 arch/um/lkl/include/uapi/asm/unistd.h
 create mode 100644 arch/um/lkl/um/syscalls.c
 create mode 100755 arch/um/scripts/headers_install.py

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 53c7919ec5b7..24c6596260de 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -28,6 +28,7 @@ config UMMODE_LIB
 	depends on !SMP
 	select UACCESS_MEMCPY
 	select ARCH_THREAD_STACK_ALLOCATOR
+	select ARCH_HAS_SYSCALL_WRAPPER
 	help
 	 This mode switches a mode to build a library of UML (Linux
 	 Kernel Library/LKL).  If this is Y, the build only generates,
diff --git a/arch/um/lkl/Makefile.um b/arch/um/lkl/Makefile.um
index 7d3f590d88a2..8c3f4f1a2032 100644
--- a/arch/um/lkl/Makefile.um
+++ b/arch/um/lkl/Makefile.um
@@ -1,2 +1,18 @@
 KBUILD_CFLAGS += -fno-builtin -fPIC
 ELF_FORMAT=$(shell $(LD) -r -print-output-format)
+
+INSTALL_PATH ?= $(objtree)/tools/um
+SYSCALL_DEFS_H := $(objtree)/$(HOST_DIR)/include/generated/uapi/asm/syscall_defs.h
+REPLACED_SYSCALL_DEFS_H := $(INSTALL_PATH)/include/lkl/asm/syscall_defs.h
+
+um_headers_install: $(REPLACED_SYSCALL_DEFS_H) scripts_unifdef
+
+$(REPLACED_SYSCALL_DEFS_H): $(SYSCALL_DEFS_H) $(srctree)/$(ARCH_DIR)/scripts/headers_install.py
+	$(Q)$(srctree)/$(ARCH_DIR)/scripts/headers_install.py \
+		$(INSTALL_PATH)/include
+
+$(objtree)/$(HOST_DIR)/include/generated/uapi/asm/syscall_defs.h: vmlinux
+	$(Q)$(OBJCOPY) -j .syscall_defs -O binary --set-section-flags \
+		       .syscall_defs=alloc $< $@
+	$(Q) export tmpfile=$(shell mktemp); \
+	sed 's/\x0//g' $@ > $$tmpfile; mv $$tmpfile $@ ; rm -f $$tmpfile
diff --git a/arch/um/lkl/include/asm/syscall_wrapper.h b/arch/um/lkl/include/asm/syscall_wrapper.h
new file mode 100644
index 000000000000..bb2a7d4274f6
--- /dev/null
+++ b/arch/um/lkl/include/asm/syscall_wrapper.h
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
diff --git a/arch/um/lkl/include/asm/syscalls.h b/arch/um/lkl/include/asm/syscalls.h
new file mode 100644
index 000000000000..6061d9415dad
--- /dev/null
+++ b/arch/um/lkl/include/asm/syscalls.h
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
diff --git a/arch/um/lkl/include/uapi/asm/Kbuild b/arch/um/lkl/include/uapi/asm/Kbuild
new file mode 100644
index 000000000000..1c89a1640263
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/Kbuild
@@ -0,0 +1,6 @@
+# UAPI Header export list
+
+generated-y += syscall_defs.h
+
+# generated-y file is parsed by special user headers handling
+# see arch/um/script/headers_install.py
diff --git a/arch/um/lkl/include/uapi/asm/bitsperlong.h b/arch/um/lkl/include/uapi/asm/bitsperlong.h
index f6657ba0ff9b..b3a5adf0b04f 100644
--- a/arch/um/lkl/include/uapi/asm/bitsperlong.h
+++ b/arch/um/lkl/include/uapi/asm/bitsperlong.h
@@ -2,7 +2,10 @@
 #ifndef __UM_LIBMODE_UAPI_BITSPERLONG_H
 #define __UM_LIBMODE_UAPI_BITSPERLONG_H
 
-#ifdef CONFIG_64BIT
+/* need to add new arch defines here, as we cannot use CONFIG_64BIT here
+ * to avoid CONFIG leaks to userspace
+ */
+#if defined(__x86_64__)
 #define __BITS_PER_LONG 64
 #else
 #define __BITS_PER_LONG 32
diff --git a/arch/um/lkl/include/uapi/asm/byteorder.h b/arch/um/lkl/include/uapi/asm/byteorder.h
index a4ae973f440b..ed19f6a836c6 100644
--- a/arch/um/lkl/include/uapi/asm/byteorder.h
+++ b/arch/um/lkl/include/uapi/asm/byteorder.h
@@ -2,10 +2,12 @@
 #ifndef __UM_LIBMODE_UAPI_BYTEORDER_H
 #define __UM_LIBMODE_UAPI_BYTEORDER_H
 
-#if defined(CONFIG_BIG_ENDIAN)
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #include <linux/byteorder/big_endian.h>
-#else
+#elif __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #include <linux/byteorder/little_endian.h>
+#else
+#error "cannot detect endian of the target"
 #endif
 
 #endif
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index 039a17972d7d..b97aa1099a17 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -200,4 +200,47 @@ void lkl_jmp_buf_set(struct lkl_jmp_buf *jmpb, void (*f)(void));
  */
 void lkl_jmp_buf_longjmp(struct lkl_jmp_buf *jmpb, int val);
 
+/**
+ * lkl_tls_alloc - allocate a thread local storage key
+ *
+ * @destructor: a destructor called upon termination. if this is not NULL it
+ * will be called when a thread terminates with its argument set to the current
+ * thread local storage value
+ *
+ * Return: non-NULL address of allocated struct lkl_tls_key if successful;
+ * otherwise NULL
+ *
+ */
+struct lkl_tls_key *lkl_tls_alloc(void (*destructor)(void *));
+
+/**
+ * lkl_tls_free - frees a thread local storage key
+ *
+ * @key: lkl_tls_key to be freed
+ *
+ */
+void lkl_tls_free(struct lkl_tls_key *key);
+
+/**
+ * lkl_tls_set - associate data to the thread local storage key
+ *
+ * @key: lkl_tls_key to be configured
+ * @data: the value associated with the @key
+ *
+ * Return: 0 if successful
+ *
+ */
+int lkl_tls_set(struct lkl_tls_key *key, void *data);
+
+/**
+ * lkl_tls_get - obtain the value associated with tls
+ *
+ * @key: lkl_tls_key to be queried
+ *
+ * Return: data associated with the thread local storage key or NULL
+ * on error
+ *
+ */
+void *lkl_tls_get(struct lkl_tls_key *key);
+
 #endif
diff --git a/arch/um/lkl/include/uapi/asm/syscalls.h b/arch/um/lkl/include/uapi/asm/syscalls.h
new file mode 100644
index 000000000000..62c343199625
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/syscalls.h
@@ -0,0 +1,301 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_UAPI_SYSCALLS_H
+#define __UM_LIBMODE_UAPI_SYSCALLS_H
+
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
+
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
+#if defined(__x86_64__)
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
+/**
+ * lkl_syscall() - issue LKL system calls
+ *
+ * @no: system call number
+ * @params: parameters of system calls
+ *
+ * Return: 0 if there is no error; otherwise non-zero value returns.
+ *
+ * The function is an entry point of LKL system call.
+ */
+long lkl_syscall(long no, long *params);
+
+/**
+ * lkl_sys_halt() - terminate LKL kernel
+ *
+ * Return: 0 if there is no error; otherwise non-zero value returns.
+ *
+ * The function requests the termination of LKL kernel.
+ */
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
diff --git a/arch/um/lkl/include/uapi/asm/unistd.h b/arch/um/lkl/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..6f5d67b45fbd
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/unistd.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_UAPI_UNISTD_H
+#define __UM_LIBMODE_UAPI_UNISTD_H
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
diff --git a/arch/um/lkl/um/syscalls.c b/arch/um/lkl/um/syscalls.c
new file mode 100644
index 000000000000..45cb5c656f69
--- /dev/null
+++ b/arch/um/lkl/um/syscalls.c
@@ -0,0 +1,193 @@
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
+#undef __UM_LIBMODE_UAPI_UNISTD_H
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
+	lkl_jmp_buf_set(&ti->task->thread.arch.sched_jb, exit_task);
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
+	task = lkl_tls_get(task_key);
+	if (!task) {
+		ret = new_host_task(&task);
+		if (ret)
+			goto out;
+		lkl_tls_set(task_key, task);
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
+		lkl_sem_down(ti->task->thread.arch.sched_sem);
+		if (idle_host_task == NULL) {
+			lkl_thread_exit();
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
+	task_key = lkl_tls_alloc(del_host_task);
+	if (!task_key)
+		return -1;
+
+	if (kernel_thread(idle_host_task_loop, NULL, CLONE_FLAGS) < 0) {
+		lkl_tls_free(task_key);
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
+		lkl_sem_up(ti->task->thread.arch.sched_sem);
+		lkl_thread_join(ti->task->thread.arch.tid);
+	}
+
+	lkl_tls_free(task_key);
+}
diff --git a/arch/um/scripts/headers_install.py b/arch/um/scripts/headers_install.py
new file mode 100755
index 000000000000..0309f3478698
--- /dev/null
+++ b/arch/um/scripts/headers_install.py
@@ -0,0 +1,200 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+import re, os, sys, argparse, multiprocessing, fnmatch
+
+srctree = os.environ["srctree"]
+objtree = os.environ["objtree"]
+header_paths = [ "include/uapi/", "arch/um/lkl/include/uapi/",
+                 "arch/um/lkl/include/generated/uapi/" ]
+
+headers = set()
+includes = set()
+
+def relpath2abspath(relpath):
+    if "generated" in relpath:
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
+args = parser.parse_args()
+
+find_headers("arch/um/lkl/include/uapi/asm/syscalls.h")
+headers.add("arch/um/lkl/include/uapi/asm/host_ops.h")
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
+    out_dir = args.path + "/" + re.sub("(" + srctree + "/arch/um/lkl/include/uapi/|"
+                                       + srctree + "/include/uapi/|"
+                                       + "arch/um/lkl/include/generated/uapi/|"
+                                       + "include/generated/uapi/|"
+                                       + "include/generated)(.*)", "lkl/\\2", dir)
+    try:
+        os.makedirs(out_dir)
+    except:
+        pass
+    print("  INSTALL %s" % (out_dir + "/" + os.path.basename(h)))
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
+    print("  REPLACE %s" % h)
+    replace(h)
+
+# use num of processors determined by os.cpu_count()
+p = multiprocessing.Pool(None)
+try:
+    p.map_async(process_header, headers).wait(999999)
+    p.close()
+except:
+    p.terminate()
+finally:
+    p.join()
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index dd554bd436cc..d44b92979db4 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -24,7 +24,11 @@ TMPFILE=$OUTFILE.tmp
 trap 'rm -f $OUTFILE $TMPFILE' EXIT
 
 # SPDX-License-Identifier with GPL variants must have "WITH Linux-syscall-note"
-if [ -n "$(sed -n -e "/SPDX-License-Identifier:.*GPL-/{/WITH Linux-syscall-note/!p}" $INFILE)" ]; then
+#
+# ARCH=um with library mode exposes uapi headers but applications may be linked
+# statically, thus this GPL exception doesn't apply to.
+if [ -n "$(sed -n -e "/SPDX-License-Identifier:.*GPL-/{/WITH Linux-syscall-note/!p}" $INFILE)" ] &&
+	[ "$SRCARCH" != "um" ]; then
 	echo "error: $INFILE: missing \"WITH Linux-syscall-note\" for SPDX-License-Identifier" >&2
 	exit 1
 fi
-- 
2.21.0 (Apple Git-122.2)

