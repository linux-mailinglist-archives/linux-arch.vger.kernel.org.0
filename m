Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030E1276A67
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgIXHQE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXHQE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:16:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5590EC0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:16:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f1so1168622plo.13
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+EfrryUMCL7dAKUwTQI3rDTtu8cnZJN4QfF5pBjSyY=;
        b=XSAI0NJYSfH/OUrsLJg4wuX5Y9DD5i3xRZ++HX9BnjSe/o5lsPuIfnXYkauQvVUtu8
         2YIKgeJc1CyRZbOVdrq04ZG9sefQ/V0t4YyxgxbtSiOawcrKa9KEhm4a20i7txGHlq2e
         t0kBi+uhmwDRw/T8nE6UBaxXZKfULdy19wnvuMjDFNHduwlS/Khj/4GVA/EpUZoe0/sY
         OuGsu1Z3kAJVFR7kDq1H1ALbpshCbSJG90IJnibP99vexpJc34yQMenlb0ygR9M5LMH3
         CL5SpFHY1Q+nhglBkFip4gxUargLJLm8dYZ2RF0Xu91Lyw7wAu0mXHEmfokvbkmaaDjO
         pf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+EfrryUMCL7dAKUwTQI3rDTtu8cnZJN4QfF5pBjSyY=;
        b=fv6Uxatn9DwYnF5AW6IqYeuzTEndrQFRTNVQij57Qm5StGoBV2ZHVmUyqqM8ScLFCo
         uSF7g9WNHthd+uXe9o2rlrNGs29YvEmFbb8/EtFcBH0wPInCx/3/o/KNzfN46upgScot
         Gv4OTvsKjLw37DuUkertg4mx4D/RagIs1tUjMzAiObG+lH4+OuJE13LCT6YVo/3RUQaU
         X6lsKKwtq4Ck0ePGYnYNGjFKJUcl+kryA4BBjt3KlbkolKfvoRmDGRhuXaW0pjKF38oL
         zwpAyoAJhkSYpD2z8xapPUcLnHAyuzJ4LGgMfbayfmh/KL3JzTidjdawcOHrTN70D0tu
         eyJQ==
X-Gm-Message-State: AOAM532GA6QC+RbrUqH/VTfpJ34EhtyfoW0ES//iEEjnoRUY2QtBJcIT
        yr1GlyEOMZzBBQAUGVf3dDA=
X-Google-Smtp-Source: ABdhPJwdQoxxfqH9UED8pz+nyIQsa2d+m40FuBdHRW8Hzx4pnWRxSbLhjEFnCBkg2kRCMyLOG4JEGA==
X-Received: by 2002:a17:902:b90b:b029:d2:2a15:53e9 with SMTP id bf11-20020a170902b90bb02900d22a1553e9mr3176210plb.84.1600931763682;
        Thu, 24 Sep 2020 00:16:03 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id bj2sm1368098pjb.20.2020.09.24.00.16.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:16:03 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 33B642037C20EB; Thu, 24 Sep 2020 16:16:00 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v6 17/21] um: host: add nommu build for ARCH=um
Date:   Thu, 24 Sep 2020 16:12:57 +0900
Message-Id: <3999a68d78871b3378a7c15915cec49af708357c.1600922529.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds the skeleton for the host library.

The host library is implementing the host operations needed by nommu
mode and is split into host dependent (depends on a specific host, e.g.
POSIX hosts) and host independent parts (will work on all supported
hosts).

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/um/Makefile                  |   7 +-
 tools/um/Targets                   |   3 +-
 tools/um/include/lkl.h             | 151 +++++++++++++++++++++++++++++
 tools/um/include/lkl_host.h        |  26 +++++
 tools/um/uml/Build                 |  15 ++-
 tools/um/uml/nommu/Build           |   1 +
 tools/um/uml/nommu/registers.c     |  21 ++++
 tools/um/uml/nommu/unimplemented.c |  21 ++++
 8 files changed, 238 insertions(+), 7 deletions(-)
 create mode 100644 tools/um/include/lkl.h
 create mode 100644 tools/um/include/lkl_host.h
 create mode 100644 tools/um/uml/nommu/Build
 create mode 100644 tools/um/uml/nommu/registers.c
 create mode 100644 tools/um/uml/nommu/unimplemented.c

diff --git a/tools/um/Makefile b/tools/um/Makefile
index 552ed5f1edae..a93e060b1f89 100644
--- a/tools/um/Makefile
+++ b/tools/um/Makefile
@@ -5,6 +5,7 @@
 MAKEFLAGS += -r --no-print-directory
 
 KCONFIG?=defconfig
+UMMODE?=kernel
 
 ifneq ($(silent),1)
   ifneq ($(V),1)
@@ -47,8 +48,9 @@ all: $(TARGETS)
 
 # rule to build linux.o
 $(OUTPUT)lib/linux.o:
-	$(Q)CFLAGS= $(MAKE) -C ../.. ARCH=um $(KOPT) $(KCONFIG)
-	$(Q)CFLAGS= $(MAKE) -C ../.. ARCH=um $(KOPT) install INSTALL_PATH=$(OUTPUT)
+	$(Q)CFLAGS= $(MAKE) -C ../.. ARCH=um UMMODE=$(UMMODE) $(KOPT) $(KCONFIG)
+	$(Q)CFLAGS= $(MAKE) -C ../.. ARCH=um UMMODE=$(UMMODE) $(KOPT) install \
+	INSTALL_PATH=$(OUTPUT)
 
 $(OUTPUT)liblinux.a: $(OUTPUT)lib/linux.o $(OUTPUT)uml/liblinux-in.o $(OUTPUT)lib/liblinux-in.o
 	$(QUIET_AR)$(AR) -rc $@ $^
@@ -67,6 +69,7 @@ $(OUTPUT)%-in.o: $(OUTPUT)lib/linux.o FORCE
 clean:
 	$(call QUIET_CLEAN, objects)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd'\
 	 -delete -o -name '\.*.d' -delete
+	$(call QUIET_CLEAN, headers)$(RM) -r $(OUTPUT)/include/lkl/
 	$(call QUIET_CLEAN, liblinux.a)$(RM) $(OUTPUT)/liblinux.a
 	$(call QUIET_CLEAN, $(TARGETS))$(RM) $(TARGETS)
 
diff --git a/tools/um/Targets b/tools/um/Targets
index a4711f1ef422..4e1f0f4d81a3 100644
--- a/tools/um/Targets
+++ b/tools/um/Targets
@@ -1,4 +1,5 @@
 progs-y += uml/linux
-LDLIBS_linux-y := -lrt -lpthread -lutil
+
+LDLIBS := -lrt -lpthread -lutil
 LDFLAGS_linux-y := -no-pie -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 LDFLAGS_linux-$(UML_STATIC) += -static
diff --git a/tools/um/include/lkl.h b/tools/um/include/lkl.h
new file mode 100644
index 000000000000..707e01b64a70
--- /dev/null
+++ b/tools/um/include/lkl.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_H
+#define _LKL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define _LKL_LIBC_COMPAT_H
+
+#ifdef __cplusplus
+#define class __lkl__class
+#endif
+
+/*
+ * Avoid collisions between Android which defines __unused and
+ * linux/icmp.h which uses __unused as a structure field.
+ */
+#pragma push_macro("__unused")
+#undef __unused
+
+#include <lkl/asm/syscalls.h>
+
+#pragma pop_macro("__unused")
+
+#ifdef __cplusplus
+#undef class
+#endif
+
+/**
+ * lkl_strerror - returns a string describing the given error code
+ *
+ * @err - error code
+ * @returns - string for the given error code
+ */
+const char *lkl_strerror(int err);
+
+/**
+ * lkl_perror - prints a string describing the given error code
+ *
+ * @msg - prefix for the error message
+ * @err - error code
+ */
+void lkl_perror(char *msg, int err);
+
+#if __LKL__BITS_PER_LONG == 64
+#define lkl_sys_fstatat lkl_sys_newfstatat
+#define lkl_sys_fstat lkl_sys_newfstat
+
+#else
+#define __lkl__NR_fcntl __lkl__NR_fcntl64
+
+#define lkl_stat lkl_stat64
+#define lkl_sys_stat lkl_sys_stat64
+#define lkl_sys_lstat lkl_sys_lstat64
+#define lkl_sys_truncate lkl_sys_truncate64
+#define lkl_sys_ftruncate lkl_sys_ftruncate64
+#define lkl_sys_sendfile lkl_sys_sendfile64
+#define lkl_sys_fstatat lkl_sys_fstatat64
+#define lkl_sys_fstat lkl_sys_fstat64
+#define lkl_sys_fcntl lkl_sys_fcntl64
+
+#define lkl_statfs lkl_statfs64
+
+static inline int lkl_sys_statfs(const char *path, struct lkl_statfs *buf)
+{
+	return lkl_sys_statfs64(path, sizeof(*buf), buf);
+}
+
+static inline int lkl_sys_fstatfs(unsigned int fd, struct lkl_statfs *buf)
+{
+	return lkl_sys_fstatfs64(fd, sizeof(*buf), buf);
+}
+
+#define lkl_sys_nanosleep lkl_sys_nanosleep_time32
+static inline int lkl_sys_nanosleep_time32(struct lkl_timespec *rqtp,
+					   struct lkl_timespec *rmtp)
+{
+	long p[6] = {(long)rqtp, (long)rmtp, 0, 0, 0, 0};
+
+	return lkl_syscall(__lkl__NR_nanosleep, p);
+}
+
+#endif
+
+static inline int lkl_sys_stat(const char *path, struct lkl_stat *buf)
+{
+	return lkl_sys_fstatat(LKL_AT_FDCWD, path, buf, 0);
+}
+
+static inline int lkl_sys_lstat(const char *path, struct lkl_stat *buf)
+{
+	return lkl_sys_fstatat(LKL_AT_FDCWD, path, buf,
+			       LKL_AT_SYMLINK_NOFOLLOW);
+}
+
+#ifdef __lkl__NR_openat
+/**
+ * lkl_sys_open - wrapper for lkl_sys_openat
+ */
+static inline long lkl_sys_open(const char *file, int flags, int mode)
+{
+	return lkl_sys_openat(LKL_AT_FDCWD, file, flags, mode);
+}
+
+/**
+ * lkl_sys_creat - wrapper for lkl_sys_openat
+ */
+static inline long lkl_sys_creat(const char *file, int mode)
+{
+	return lkl_sys_openat(LKL_AT_FDCWD, file,
+			      LKL_O_CREAT|LKL_O_WRONLY|LKL_O_TRUNC, mode);
+}
+#endif
+
+#ifdef __lkl__NR_mkdirat
+/**
+ * lkl_sys_mkdir - wrapper for lkl_sys_mkdirat
+ */
+static inline long lkl_sys_mkdir(const char *path, mode_t mode)
+{
+	return lkl_sys_mkdirat(LKL_AT_FDCWD, path, mode);
+}
+#endif
+
+#ifdef __lkl__NR_epoll_create1
+/**
+ * lkl_sys_epoll_create - wrapper for lkl_sys_epoll_create1
+ */
+static inline long lkl_sys_epoll_create(int size)
+{
+	return lkl_sys_epoll_create1(0);
+}
+#endif
+
+#ifdef __lkl__NR_epoll_pwait
+/**
+ * lkl_sys_epoll_wait - wrapper for lkl_sys_epoll_pwait
+ */
+static inline long lkl_sys_epoll_wait(int fd, struct lkl_epoll_event *ev,
+				      int cnt, int to)
+{
+	return lkl_sys_epoll_pwait(fd, ev, cnt, to, 0, _LKL_NSIG/8);
+}
+#endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/tools/um/include/lkl_host.h b/tools/um/include/lkl_host.h
new file mode 100644
index 000000000000..85e80eb4ad0d
--- /dev/null
+++ b/tools/um/include/lkl_host.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_HOST_H
+#define _LKL_HOST_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <lkl/asm/host_ops.h>
+#include <lkl.h>
+
+extern struct lkl_host_operations lkl_host_ops;
+
+/**
+ * lkl_printf - print a message via the host print operation
+ *
+ * @fmt: printf like format string
+ */
+int lkl_printf(const char *fmt, ...);
+
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/tools/um/uml/Build b/tools/um/uml/Build
index 435a9670d3ff..191c6479ad72 100644
--- a/tools/um/uml/Build
+++ b/tools/um/uml/Build
@@ -8,11 +8,19 @@ KCOV_INSTRUMENT                := n
 
 include $(objtree)/include/config/auto.conf
 
-liblinux-y += execvp.o file.o helper.o irq.o main.o mem.o process.o \
-	registers.o sigio.o signal.o start_up.o time.o tty.o \
-	umid.o user_syms.o util.o drivers/ skas/
+liblinux-y += execvp.o file.o helper.o irq.o mem.o process.o \
+	registers.o sigio.o signal.o time.o tty.o \
+	umid.o user_syms.o util.o drivers/
 
+ifdef CONFIG_MMU
+liblinux-y += main.o start_up.o skas/
+HEADER_ARCH 	:= x86
 liblinux-y += x86/
+else
+HEADER_ARCH 	:= um/nommu
+liblinux-y += nommu/
+endif
+
 
 liblinux-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
@@ -23,7 +31,6 @@ CFLAGS := -g -O2
 
 # from arch/um/Makefile
 ARCH_DIR := arch/um
-HEADER_ARCH 	:= x86
 HOST_DIR := arch/$(HEADER_ARCH)
 ifdef CONFIG_64BIT
   KBUILD_CFLAGS += -mcmodel=large
diff --git a/tools/um/uml/nommu/Build b/tools/um/uml/nommu/Build
new file mode 100644
index 000000000000..98fd6b86a085
--- /dev/null
+++ b/tools/um/uml/nommu/Build
@@ -0,0 +1 @@
+liblinux-y = registers.o unimplemented.o
diff --git a/tools/um/uml/nommu/registers.c b/tools/um/uml/nommu/registers.c
new file mode 100644
index 000000000000..11573a204720
--- /dev/null
+++ b/tools/um/uml/nommu/registers.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+struct uml_pt_regs;
+
+int get_fp_registers(int pid, unsigned long *regs)
+{
+	return 0;
+}
+
+int save_i387_registers(int pid, unsigned long *fp_regs)
+{
+	return 0;
+}
+
+void arch_init_registers(int pid)
+{
+}
+
+void get_regs_from_mc(struct uml_pt_regs *regs, void *mc)
+{
+}
diff --git a/tools/um/uml/nommu/unimplemented.c b/tools/um/uml/nommu/unimplemented.c
new file mode 100644
index 000000000000..9da3e5c8bafb
--- /dev/null
+++ b/tools/um/uml/nommu/unimplemented.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <generated/user_constants.h>
+
+struct uml_pt_regs;
+
+/* os-Linux/skas/process.c */
+int userspace_pid[UM_NR_CPUS];
+void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
+{}
+
+
+/* x86/os-Linux/task_size.c */
+unsigned long os_get_top_address(void)
+{
+	return 0;
+}
+
+/* start-up.c */
+void os_early_checks(void)
+{
+}
-- 
2.21.0 (Apple Git-122.2)

