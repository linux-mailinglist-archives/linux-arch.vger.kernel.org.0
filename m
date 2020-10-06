Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBA0284997
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJFJqR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJFJqR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:46:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14345C061755
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:46:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id az3so1291315pjb.4
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RTsRKN46qO2QbaafqLBaq3bjYwnZ6DkoWryfKzkfcqk=;
        b=hPDX5mnZkoo3DeKuhxGk3FQrVz9LrI+OHcWYDEMyDxc9MGrUg50l3vZ4P1BKxeku8V
         fLlmX9Mb5yfVR5p95q65Ww5yeT3IbnhLt8SPPQp5AKiUbl0kXOQ3bkKAalrbwedE1UF2
         0KpGhsg7P7z6D5YK8BYvlXtt2/Awgh/VBVz/1h+jXAeI0ASOJF8U2NcDvKCpJISt6OwG
         K6aN1CBx/WTRdDN7YSWca03x+eRlL+CIGErC9QwPEnDQIj0xFGuGEUSsQb6gRsdLVjNJ
         A0lda3kgQOTh8uS8y0Fq+sjNtWHMn70KzwNvx8lAu4f9dyEC11l+9TeY0lWdCBs/UFYZ
         IYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RTsRKN46qO2QbaafqLBaq3bjYwnZ6DkoWryfKzkfcqk=;
        b=huNUK3Lndy1mFwlNEz7efkzU+42L7P67ZUOCXKkH++XMORUMNoNW3ELowWh/WueEqc
         AYrcEkwZmypApcPVd5J6CRY3kuUxYAoMpDTwnMI6z6ebjHqsMcNH0f1MGJZSZWEimVbw
         yumJKivUl+X63R3W5xWPlekszzA4YrB8u+5maI+HQmdGNQG2h7zynSb8c/XEV1SuC1dF
         qJHFlhldjvR5gADlU7wRiV3a84NUJV4YvmIqla1PLFLqLAaefISe5UERiuo/01zOmpZR
         BVtGCUrq/lfXnJagUoYCQyneOfTpVaAiTq4cwT8fnz9+mUtz379W50lr5oFJd68FT8hO
         g8Lg==
X-Gm-Message-State: AOAM533nKWoTA9j7ESUee9gJd0pyEPca5KOZ8/UkHETHLVClsCsecmOA
        fCa7NbG0gsgIiNUKnOylnRQ=
X-Google-Smtp-Source: ABdhPJwKOfrxoEx6mGlokSm0CxOoISbopcUp5oqK2Pec+uCztX/a+V6fuop6AZaoqVvFbcSkGaXhIA==
X-Received: by 2002:a17:90a:6985:: with SMTP id s5mr757312pjj.17.1601977576269;
        Tue, 06 Oct 2020 02:46:16 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id b185sm2602915pgc.68.2020.10.06.02.46.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:46:15 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id E19F720390F50F; Tue,  6 Oct 2020 18:46:13 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 17/21] um: host: add nommu build for ARCH=um
Date:   Tue,  6 Oct 2020 18:44:26 +0900
Message-Id: <c32143deac8960b7bb1cfdb1ab8393985178f81f.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
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
 tools/um/.gitignore                |   1 +
 tools/um/Makefile                  |  32 +++---
 tools/um/Targets                   |   3 +-
 tools/um/include/lkl.h             | 151 +++++++++++++++++++++++++++++
 tools/um/include/lkl_host.h        |  26 +++++
 tools/um/uml/Build                 |  16 ++-
 tools/um/uml/nommu/Build           |   1 +
 tools/um/uml/nommu/registers.c     |  21 ++++
 tools/um/uml/nommu/unimplemented.c |  21 ++++
 9 files changed, 252 insertions(+), 20 deletions(-)
 create mode 100644 tools/um/.gitignore
 create mode 100644 tools/um/include/lkl.h
 create mode 100644 tools/um/include/lkl_host.h
 create mode 100644 tools/um/uml/nommu/Build
 create mode 100644 tools/um/uml/nommu/registers.c
 create mode 100644 tools/um/uml/nommu/unimplemented.c

diff --git a/tools/um/.gitignore b/tools/um/.gitignore
new file mode 100644
index 000000000000..0d20b6487c61
--- /dev/null
+++ b/tools/um/.gitignore
@@ -0,0 +1 @@
+*.pyc
diff --git a/tools/um/Makefile b/tools/um/Makefile
index 552ed5f1edae..bbd5e0dcadbc 100644
--- a/tools/um/Makefile
+++ b/tools/um/Makefile
@@ -5,6 +5,7 @@
 MAKEFLAGS += -r --no-print-directory
 
 KCONFIG?=defconfig
+UMMODE?=kernel
 
 ifneq ($(silent),1)
   ifneq ($(V),1)
@@ -15,10 +16,8 @@ endif
 
 PREFIX   := /usr
 
-ifeq (,$(srctree))
-  srctree := $(patsubst %/,%,$(dir $(shell pwd)))
-  srctree := $(patsubst %/,%,$(dir $(srctree)))
-endif
+srctree := $(patsubst %/,%,$(dir $(shell pwd)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
 export srctree
 
 -include ../scripts/Makefile.include
@@ -32,9 +31,6 @@ endif
 export OUTPUT
 export objtree := $(OUTPUT)/../..
 
-
-all:
-
 export CFLAGS += -I$(OUTPUT)/include -Iinclude -Wall -g -O2 -Wextra -fPIC \
 	 -Wno-unused-parameter \
 	 -Wno-missing-field-initializers -fno-strict-aliasing
@@ -45,28 +41,34 @@ TARGETS := $(progs-y:%=$(OUTPUT)%)
 TARGETS += $(libs-y:%=$(OUTPUT)%)
 all: $(TARGETS)
 
-# rule to build linux.o
-$(OUTPUT)lib/linux.o:
-	$(Q)CFLAGS= $(MAKE) -C ../.. ARCH=um $(KOPT) $(KCONFIG)
-	$(Q)CFLAGS= $(MAKE) -C ../.. ARCH=um $(KOPT) install INSTALL_PATH=$(OUTPUT)
+$(objtree)/linux.o:
+	$(Q)echo ""
+	$(Q)echo ""
+	$(Q)echo "==> $@ isn't found; please make ARCH=um"
+	$(Q)echo ""
+	$(Q)echo ""
+	$(Q)exit 1
 
-$(OUTPUT)liblinux.a: $(OUTPUT)lib/linux.o $(OUTPUT)uml/liblinux-in.o $(OUTPUT)lib/liblinux-in.o
+$(OUTPUT)lib/linux.o: $(objtree)/linux.o
+	$(Q)cp $(objtree)/linux.o $(OUTPUT)lib/linux.o
+
+# rule to build linux.o
+$(OUTPUT)liblinux.a: $(OUTPUT)uml/liblinux-in.o $(OUTPUT)lib/liblinux-in.o $(OUTPUT)lib/linux.o
 	$(QUIET_AR)$(AR) -rc $@ $^
 
 # rule to link programs
 $(OUTPUT)%: $(OUTPUT)%-in.o $(OUTPUT)liblinux.a
 	$(QUIET_LINK)$(CC) $(LDFLAGS) $(LDFLAGS_$(notdir $*)-y) -o $@ $^ $(LDLIBS) $(LDLIBS_$(notdir $*)-y)
 
-$(OUTPUT)%-in.o: FORCE
-	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
-
 # rule to build objects
 $(OUTPUT)%-in.o: $(OUTPUT)lib/linux.o FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
 
+RM := rm -f
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
index 0d87d601bc06..a55c5cc3ebc0 100644
--- a/tools/um/uml/Build
+++ b/tools/um/uml/Build
@@ -8,11 +8,19 @@ KCOV_INSTRUMENT                := n
 
 include $(objtree)/include/config/auto.conf
 
-liblinux-y += execvp.o file.o helper.o irq.o main.o mem.o process.o \
-	registers.o sigio.o signal.o start_up.o time.o tty.o \
-	umid.o util.o drivers/ skas/
+liblinux-y += execvp.o file.o helper.o irq.o mem.o process.o \
+	registers.o sigio.o signal.o time.o tty.o \
+	umid.o util.o drivers/
 
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
@@ -33,6 +40,7 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 	-Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
 	-Din6addr_loopback=kernel_in6addr_loopback \
 	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
+KBUILD_CFLAGS := $(filter-out -Dsigprocmask=kernel_sigprocmask,$(KBUILD_CFLAGS))
 SHARED_HEADERS	:= $(ARCH_DIR)/include/shared
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
 ARCH_INCLUDE	:= -I$(srctree)/$(SHARED_HEADERS)
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

