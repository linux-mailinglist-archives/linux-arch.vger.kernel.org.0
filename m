Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494E42125B0
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgGBOKF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgGBOKF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:10:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A50DC08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:10:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bj10so6134573plb.11
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+EfrryUMCL7dAKUwTQI3rDTtu8cnZJN4QfF5pBjSyY=;
        b=rdLCXj4DqlbBGPfEeu0fxp0rbywJfXzD/xhv4yNjU6w0S8CIJKcqfX2I3Se3pSJgFx
         K5SoUFwXS8ODkC+38bYpvj27kfK8JEcGY9WxzXvl36LcYTRkuAml2JCoxTyTXQ58FjYc
         s9kdxBkRPvzVBVdPucdGDtMy0+JTg+Zi6H0wStZIwFU0tjcgAngC4ayvBtGkOgLLjr8G
         uahRu6tvDoWToSafeGeyB/lZZYKVN79QwVSvUVcpZfI7qZNBjfW2IwThhFqJuI9cePA2
         iWkbRrg2Sbp6pqDc4s1WAfoGwurH3BYdtABXP/DL1IkOc8QpZyFvX+z2U9pjIMPJoBJ2
         PjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+EfrryUMCL7dAKUwTQI3rDTtu8cnZJN4QfF5pBjSyY=;
        b=S4hvlEua9Hh1DX8VhcHDZN+N9ViTKRTDp3BJIchrlhJhrCyPtxFm5oM9hv+2CLXZGq
         SIRdOHrDF3lcvs0cicHhJiZUE39dv+uXofDDz58On0T5ht++/oCOc3cfje4mpdH0AcEg
         ZDZtKG77knOcsDE4g9AMOlJNf+MIvowdiUeYLQNqd6q2b8ByWQbaR/+qyojEJlR0AfMP
         b9ZXHJb2Wah0zK25hmAFZkJFIr/J5CCWoAitrG7pB+PPX+lo8PIxB3KqV83kRWXpyua+
         6e0yT9/ZZyz3p4RYxqNh7PA7LykRZGw5nA090baWWXUhUf5lKWLgsBvJo8rl//TiRl/Q
         dFPw==
X-Gm-Message-State: AOAM530b3NgQGG6keOH5e/LeOF9P77K7pyw8+Z0M9Pi30PUmMKjK4ApA
        Ziq64EATKaclOhgF5/4IfSw=
X-Google-Smtp-Source: ABdhPJyjY+xTMIGEoF/+tIEGDBT1l/Xu7Wvuqe1dt/iBNaBYb0aj7Hm5kbOU2j65R6rF9FnWSjFLIw==
X-Received: by 2002:a17:90a:8b09:: with SMTP id y9mr33006359pjn.90.1593699004679;
        Thu, 02 Jul 2020 07:10:04 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id 7sm9101774pgw.85.2020.07.02.07.10.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:10:04 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id AA5D1202D31D7F; Thu,  2 Jul 2020 23:10:01 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 17/21] um: host: add nommu build for ARCH=um
Date:   Thu,  2 Jul 2020 23:07:11 +0900
Message-Id: <bbe11c3c35f96c7c0870af4f0a599ecc2d04ed20.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
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

