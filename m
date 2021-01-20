Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78AB2FC910
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbhATDen (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731982AbhATC3f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:35 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78E5C061793
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:29:20 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id v19so14193139pgj.12
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TnbxlQtHOOSR1UjdJYrHMUANWgwLreFhRecaPDeoXc0=;
        b=nZK8UUNrJfm/LqYi1pksUq5e42Wl5SKW3HosuQIFeyVz5/0Tn+z4CjBdeTJCl5RUvk
         h2w0kNSW+nrLJQbaYM3OeWbhqX4bw2Vgq2JvItXkaLIxdC5FZdh/K+wvLccy2iF+y7+N
         d03+SxYPACSu8ZhbbC6fzH+zCfKWgFmixE3nKs/0aof9MI8gfI79KY4SJItcEMrMvEg/
         ClbJu793YlsSnktNx3UgS9tiRNn0aZcgxAstCj7uX5nWw5quz7wfwwKmBwn6njRT7kzF
         DztkWNjnV1GQxrWsKCV3Fk9FP1PuyOQ9v+P3gHyxOXFaRIGXv2omGFsgJ+hxspMrThsM
         1czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TnbxlQtHOOSR1UjdJYrHMUANWgwLreFhRecaPDeoXc0=;
        b=rFaaWnRmNFLloeFwFRmXrIOk0POK2Ppb4TlQJWAuCXTGWSX5cbHEsFLY7H4LpidoRC
         9yEM183PbgA9HcGWiKSJ2rXCyNTX8PDF9kVR2gUFLqza3ShUfiPEmTckRJfp3FFvF5XY
         Nu5tBEJtRqb3fnP5vNX+L3qhqdGa0S+Fm5nkHOSj0a+mDwOOJYRSRzCgvYHiRRJRaG1/
         EEfGAi+AUrA56jH9/qEIJ2VCVH8zRJKTxseFLOE5TG3Xst25hi7KBGoi+gvP3PrXOmHY
         3vSVY9BfORL7CnzHnpoReo+5QOGXWCEcL8eZduY5Z2Osj1FWoQ4IAV15PoJxFJvcHCO9
         EgRA==
X-Gm-Message-State: AOAM532DdcFepDvjaDwuYsDMl8PpUFTy4QiVVn+aI67Uh7QU5f9vZEP/
        tPPwh+PWxIB0MLBpHdX4Bf4=
X-Google-Smtp-Source: ABdhPJx+oFZ3Zw1B9duYD+TkeeQ9E+UIyt6NIGOk8pTJWtKWchGpbt4xuAHaode05GjElrcWQXM8/A==
X-Received: by 2002:a63:cf56:: with SMTP id b22mr7248541pgj.16.1611109760230;
        Tue, 19 Jan 2021 18:29:20 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id n15sm245434pjk.57.2021.01.19.18.29.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:29:19 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 99C7320442D3B8; Wed, 20 Jan 2021 11:29:17 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 15/20] um: host: add library mode build for ARCH=um
Date:   Wed, 20 Jan 2021 11:27:20 +0900
Message-Id: <800d34cda146c025770e5a802de592417dfced30.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds the skeleton for the host library.

The host library is implementing the host operations needed by library
mode and splits into host dependent (e.g., POSIX hosts) and host
independent parts.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/um/.gitignore              |   1 +
 tools/um/Makefile                |   1 +
 tools/um/Targets                 |   6 +-
 tools/um/include/lkl.h           | 135 +++++++++++++++++++++++++++++++
 tools/um/include/lkl_host.h      |  18 +++++
 tools/um/uml/Build               |  16 +++-
 tools/um/uml/lkl/Build           |   1 +
 tools/um/uml/lkl/registers.c     |  21 +++++
 tools/um/uml/lkl/unimplemented.c |  21 +++++
 9 files changed, 214 insertions(+), 6 deletions(-)
 create mode 100644 tools/um/.gitignore
 create mode 100644 tools/um/include/lkl.h
 create mode 100644 tools/um/include/lkl_host.h
 create mode 100644 tools/um/uml/lkl/Build
 create mode 100644 tools/um/uml/lkl/registers.c
 create mode 100644 tools/um/uml/lkl/unimplemented.c

diff --git a/tools/um/.gitignore b/tools/um/.gitignore
new file mode 100644
index 000000000000..0d20b6487c61
--- /dev/null
+++ b/tools/um/.gitignore
@@ -0,0 +1 @@
+*.pyc
diff --git a/tools/um/Makefile b/tools/um/Makefile
index 877d0bdefa67..c07e91a93372 100644
--- a/tools/um/Makefile
+++ b/tools/um/Makefile
@@ -66,6 +66,7 @@ RM := rm -f
 clean:
 	$(call QUIET_CLEAN, objects)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd'\
 	 -delete -o -name '\.*.d' -delete
+	$(call QUIET_CLEAN, headers)$(RM) -r $(OUTPUT)/include/lkl/
 	$(call QUIET_CLEAN, liblinux.a)$(RM) $(OUTPUT)/liblinux.a
 	$(call QUIET_CLEAN, $(TARGETS))$(RM) $(TARGETS)
 
diff --git a/tools/um/Targets b/tools/um/Targets
index e8b43c7758fe..ae6c8d8b168e 100644
--- a/tools/um/Targets
+++ b/tools/um/Targets
@@ -1,7 +1,9 @@
-ifneq ($(CONFIG_UMMODE_LIB),y)
+ifeq ($(CONFIG_UMMODE_LIB),y)
+libs-y += liblinux.a
+else
 progs-y += uml/linux
 endif
 
-LDLIBS_linux-y := -lrt -lpthread -lutil
+LDLIBS := -lrt -lpthread -lutil
 LDFLAGS_linux-y := -no-pie -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 LDFLAGS_linux-$(CONFIG_STATIC_LINK) += -static
diff --git a/tools/um/include/lkl.h b/tools/um/include/lkl.h
new file mode 100644
index 000000000000..2417ed5ccf71
--- /dev/null
+++ b/tools/um/include/lkl.h
@@ -0,0 +1,135 @@
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
index 000000000000..5fe7a64dc4dd
--- /dev/null
+++ b/tools/um/include/lkl_host.h
@@ -0,0 +1,18 @@
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
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/tools/um/uml/Build b/tools/um/uml/Build
index 810aa99f8409..b523923afd45 100644
--- a/tools/um/uml/Build
+++ b/tools/um/uml/Build
@@ -8,13 +8,21 @@ KCOV_INSTRUMENT                := n
 
 include $(objtree)/include/config/auto.conf
 
-liblinux-y += execvp.o file.o helper.o irq.o main.o mem.o process.o \
-	registers.o sigio.o signal.o start_up.o time.o tty.o \
-	umid.o util.o drivers/ skas/
+liblinux-y += execvp.o file.o helper.o irq.o mem.o process.o \
+	registers.o sigio.o signal.o time.o tty.o \
+	umid.o util.o drivers/
 
 CFLAGS_signal.o += -Wframe-larger-than=4096
 
+ifndef CONFIG_UMMODE_LIB
+liblinux-y += main.o start_up.o skas/
+HEADER_ARCH 	:= x86
 liblinux-y += x86/
+else
+HEADER_ARCH 	:= um/lkl
+liblinux-y += lkl/
+endif
+
 liblinux-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
 export O = $(srctree)
@@ -24,7 +32,6 @@ CFLAGS := -g -O2
 
 # from arch/um/Makefile
 ARCH_DIR := arch/um
-HEADER_ARCH 	:= x86
 HOST_DIR := arch/$(HEADER_ARCH)
 ifdef CONFIG_64BIT
   KBUILD_CFLAGS += -mcmodel=large
@@ -34,6 +41,7 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 	-Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
 	-Din6addr_loopback=kernel_in6addr_loopback \
 	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
+KBUILD_CFLAGS := $(filter-out -Dsigprocmask=kernel_sigprocmask,$(KBUILD_CFLAGS))
 SHARED_HEADERS	:= $(ARCH_DIR)/include/shared
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
 ARCH_INCLUDE	:= -I$(srctree)/$(SHARED_HEADERS)
diff --git a/tools/um/uml/lkl/Build b/tools/um/uml/lkl/Build
new file mode 100644
index 000000000000..98fd6b86a085
--- /dev/null
+++ b/tools/um/uml/lkl/Build
@@ -0,0 +1 @@
+liblinux-y = registers.o unimplemented.o
diff --git a/tools/um/uml/lkl/registers.c b/tools/um/uml/lkl/registers.c
new file mode 100644
index 000000000000..11573a204720
--- /dev/null
+++ b/tools/um/uml/lkl/registers.c
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
diff --git a/tools/um/uml/lkl/unimplemented.c b/tools/um/uml/lkl/unimplemented.c
new file mode 100644
index 000000000000..9da3e5c8bafb
--- /dev/null
+++ b/tools/um/uml/lkl/unimplemented.c
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

