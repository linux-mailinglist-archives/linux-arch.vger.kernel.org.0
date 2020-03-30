Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E639F197EDA
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgC3OsP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:48:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42629 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgC3OsP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:48:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id e1so6803156plt.9
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zGYBhmvgID5eSC7rh+weNwge7uhFpNpVvXZwFggk8dg=;
        b=m7Eo7wtAE1p6N+oDcIdgjRKzH4EEFAw1Xd6iHhDCBEJ+itVTn+XOKWzMScgBiEoIT4
         lsePQeIegYwuD/m0dz3zzRCtCZvGB2FyhrP0/wIurta/JKDWsEWnVGfBpcQVNm0OzKAW
         B+BHD5PU61cz2sMKkcAdVjUawY1djk+CcHHoDOcdN9/iNJeTlXJqtTMF7tgWXsQ+wprd
         SuY/B7plNyxHQMR1KyeY7m4mFa5L1N5hT72DiVFrs7UDqtkT3l6Od/qB2TH04frfgW3p
         rjKixIRIghw1liB1GPBdEgFSV8LBI6SX9JGMTHkYu2aBZ4b+RJvvof53z2ThAF4OKtRw
         nuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGYBhmvgID5eSC7rh+weNwge7uhFpNpVvXZwFggk8dg=;
        b=umIG+0a8Cq3TACykHY5e/7WJ2WYuEQO7fAVodLDTQXBZroIcG78XIiJlXLR+RWWg9/
         Mywis802HNZoA5JppQoezDGG+fYK8qG8CoxGCsk0hUKRPgyIxpqQf3wlwkzXEykZMVqU
         X9WZozIMSorlo+qXU3W1vSacrFcB8psKIhYFpEcdbYCc/JU/tWsWs8JtvQV81TRr6qxP
         T1hcVwOKYZPv37051Hn8OaAAKm1AwIrAZ2BoEkrO0r5vw6EZGPRXe2fGqbDyaKc3H2Co
         PpacVUSY+IRGMmYIQIRaMw2Np1TjTw4ltDQ1LumTt3uXBX6wliFTzXnNaYCGIzkJkCDW
         BpKw==
X-Gm-Message-State: ANhLgQ3ZcsUcHhrrom047NQv4xYiEka6oYTVGPbkVqKnKo1vS009c3uB
        0V2X8eNQSuaylC9Osrl48s0=
X-Google-Smtp-Source: ADFU+vvPwYdGJGXdeoLCxx0Vp/QsQahYF1JlklOniLEW8B2ZV1ZoIJd7cNoA/vGALC6zgxZmGmc7VA==
X-Received: by 2002:a17:902:b004:: with SMTP id o4mr11997739plr.54.1585579693729;
        Mon, 30 Mar 2020 07:48:13 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id h4sm9893359pgk.72.2020.03.30.07.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:48:12 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id E99F2202804DC1; Mon, 30 Mar 2020 23:48:10 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Ben Wolsieffer <benwolsieffer@gmail.com>,
        Conrad Meyer <cem@FreeBSD.org>,
        Luca Dariz <luca.dariz@gmail.com>,
        Mark Stillwell <mark@stillwell.me>,
        Michael Zimmermann <sigmaepsilon92@gmail.com>,
        Motomu Utsumi <motomuman@gmail.com>,
        Patrick Collins <pscollins@google.com>,
        Petros Angelatos <petrosagg@gmail.com>,
        Thomas Liebetraut <thomas@tommie-lie.de>,
        Xiao Jia <xiaoj@google.com>, Yuan Liu <liuyuan@google.com>,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 12/25] lkl tools: skeleton for host side library
Date:   Mon, 30 Mar 2020 23:45:44 +0900
Message-Id: <901a5e531f9fcff3f9c0b165fde3bfcad98a19ee.1585579244.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

This patch adds the skeleton for the host library.

The host library is implementing the host operations needed by LKL and
is split into host dependent (depends on a specific host, e.g. POSIX
hosts) and host independent parts (will work on all supported hosts).

Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
Cc: Conrad Meyer <cem@FreeBSD.org>
Cc: H.K. Jerry Chu <hkchu@google.com>
Cc: Luca Dariz <luca.dariz@gmail.com>
Cc: Mark Stillwell <mark@stillwell.me>
Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc: Motomu Utsumi <motomuman@gmail.com>
Cc: Patrick Collins <pscollins@google.com>
Cc: Petros Angelatos <petrosagg@gmail.com>
Cc: Thomas Liebetraut <thomas@tommie-lie.de>
Cc: Xiao Jia <xiaoj@google.com>
Cc: Yuan Liu <liuyuan@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/lkl/.gitignore         |   4 +
 tools/lkl/Build              |   0
 tools/lkl/Makefile           | 125 ++++++++++++
 tools/lkl/Makefile.autoconf  |  65 +++++++
 tools/lkl/Targets            |   3 +
 tools/lkl/include/.gitignore |   1 +
 tools/lkl/include/lkl.h      | 358 +++++++++++++++++++++++++++++++++++
 tools/lkl/include/lkl_host.h |  19 ++
 tools/lkl/lib/.gitignore     |   3 +
 tools/lkl/lib/Build          |   1 +
 10 files changed, 579 insertions(+)
 create mode 100644 tools/lkl/.gitignore
 create mode 100644 tools/lkl/Build
 create mode 100644 tools/lkl/Makefile
 create mode 100644 tools/lkl/Makefile.autoconf
 create mode 100644 tools/lkl/Targets
 create mode 100644 tools/lkl/include/.gitignore
 create mode 100644 tools/lkl/include/lkl.h
 create mode 100644 tools/lkl/include/lkl_host.h
 create mode 100644 tools/lkl/lib/.gitignore
 create mode 100644 tools/lkl/lib/Build

diff --git a/tools/lkl/.gitignore b/tools/lkl/.gitignore
new file mode 100644
index 000000000000..1aed58bfe171
--- /dev/null
+++ b/tools/lkl/.gitignore
@@ -0,0 +1,4 @@
+Makefile.conf
+include/lkl_autoconf.h
+tests/autoconf.sh
+bin/stat
diff --git a/tools/lkl/Build b/tools/lkl/Build
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/lkl/Makefile b/tools/lkl/Makefile
new file mode 100644
index 000000000000..11ea7e9095bb
--- /dev/null
+++ b/tools/lkl/Makefile
@@ -0,0 +1,125 @@
+# Do not use make's built-in rules
+# (this improves performance and avoids hard-to-debug behaviour);
+# also do not print "Entering directory..." messages from make
+.SUFFIXES:
+MAKEFLAGS += -r --no-print-directory
+
+KCONFIG?=defconfig
+
+ifneq ($(silent),1)
+  ifneq ($(V),1)
+	QUIET_AUTOCONF       = @echo '  AUTOCONF '$@;
+	Q = @
+  endif
+endif
+
+PREFIX   := /usr
+
+ifeq (,$(srctree))
+  srctree := $(patsubst %/,%,$(dir $(shell pwd)))
+  srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+export srctree
+
+-include $(srctree)/tools/scripts/Makefile.include
+
+# OUTPUT fixup should be *after* include ../scripts/Makefile.include
+ifneq ($(OUTPUT),)
+  OUTPUT := $(OUTPUT)/tools/lkl/
+else
+  OUTPUT := $(CURDIR)/
+endif
+export OUTPUT
+
+
+all:
+
+conf: $(OUTPUT)Makefile.conf
+
+$(OUTPUT)Makefile.conf: Makefile.autoconf
+	$(call QUIET_AUTOCONF, headers)$(MAKE) -f Makefile.autoconf -s
+
+-include $(OUTPUT)Makefile.conf
+
+export CFLAGS += -I$(OUTPUT)/include -Iinclude -Wall -g -O2 -Wextra \
+	 -Wno-unused-parameter \
+	 -Wno-missing-field-initializers -fno-strict-aliasing
+
+-include Targets
+
+TARGETS := $(progs-y:%=$(OUTPUT)%$(EXESUF))
+TARGETS += $(libs-y:%=$(OUTPUT)%$(SOSUF))
+all: $(TARGETS)
+
+# this workaround is for FreeBSD
+bin/stat:
+	$(Q)mkdir -p bin/
+ifeq ($(LKL_HOST_CONFIG_BSD),y)
+	$(Q)ln -sf `which gnustat` bin/stat
+	$(Q)ln -sf `which gsed` bin/sed
+else
+	$(Q)touch bin/stat
+endif
+
+# rule to build lkl.o
+$(OUTPUT)lib/lkl.o: bin/stat
+	$(Q)$(MAKE) -C $(srctree) ARCH=um UMMODE=library $(KOPT) $(KCONFIG)
+# this workaround is for arm32 linker (ld.gold)
+	$(Q)export PATH=$(shell pwd)/bin/:${PATH} ;\
+	$(MAKE) -C $(srctree) ARCH=um UMMODE=library $(KOPT) install INSTALL_PATH=$(OUTPUT)
+
+# rules to link libs
+$(OUTPUT)%$(SOSUF): LDFLAGS += -shared
+$(OUTPUT)%$(SOSUF): $(OUTPUT)%-in.o $(OUTPUT)liblkl.a
+	$(QUIET_LINK)$(CC) $(LDFLAGS) $(LDFLAGS_$*-y) -o $@ $^ $(LDLIBS) $(LDLIBS_$*-y)
+
+# liblkl is special
+$(OUTPUT)liblkl$(SOSUF): $(OUTPUT)%-in.o $(OUTPUT)lib/lkl.o
+$(OUTPUT)liblkl.a: $(OUTPUT)lib/liblkl-in.o $(OUTPUT)lib/lkl.o
+	$(QUIET_AR)$(AR) -rc $@ $^
+
+# rule to link programs
+$(OUTPUT)%$(EXESUF): $(OUTPUT)%-in.o $(OUTPUT)liblkl.a
+	$(QUIET_LINK)$(CC) $(LDFLAGS) $(LDFLAGS_$*-y) -o $@ $^ $(LDLIBS) $(LDLIBS_$*-y)
+
+# rule to build objects
+$(OUTPUT)%-in.o: $(OUTPUT)lib/lkl.o FORCE
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
+
+
+clean:
+	$(call QUIET_CLEAN, objects)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd'\
+	 -delete -o -name '\.*.d' -delete
+	$(call QUIET_CLEAN, headers)$(RM) -r $(OUTPUT)/include/lkl/
+	$(call QUIET_CLEAN, liblkl.a)$(RM) $(OUTPUT)/liblkl.a
+	$(call QUIET_CLEAN, targets)$(RM) $(TARGETS) bin/stat
+
+clean-conf: clean
+	$(call QUIET_CLEAN, Makefile.conf)$(RM) $(OUTPUT)/Makefile.conf
+
+headers_install: $(TARGETS)
+	$(call QUIET_INSTALL, headers) \
+	    install -d $(DESTDIR)$(PREFIX)/include ; \
+	    install -m 644 include/lkl.h include/lkl_host.h $(OUTPUT)include/lkl_autoconf.h \
+	      include/lkl_config.h $(DESTDIR)$(PREFIX)/include ; \
+	    cp -r $(OUTPUT)include/lkl $(DESTDIR)$(PREFIX)/include
+
+libraries_install: $(libs-y:%=$(OUTPUT)%$(SOSUF)) $(OUTPUT)liblkl.a
+	$(call QUIET_INSTALL, libraries) \
+	    install -d $(DESTDIR)$(PREFIX)/lib ; \
+	    install -m 644 $^ $(DESTDIR)$(PREFIX)/lib
+
+programs_install: $(progs-y:%=$(OUTPUT)%$(EXESUF))
+	$(call QUIET_INSTALL, programs) \
+	    install -d $(DESTDIR)$(PREFIX)/bin ; \
+	    install -m 755 $^ $(DESTDIR)$(PREFIX)/bin
+
+install: headers_install libraries_install programs_install
+
+
+FORCE: ;
+.PHONY: all clean FORCE
+.PHONY: headers_install libraries_install programs_install install
+.NOTPARALLEL : lib/lkl.o
+.SECONDARY:
+
diff --git a/tools/lkl/Makefile.autoconf b/tools/lkl/Makefile.autoconf
new file mode 100644
index 000000000000..268c367d9962
--- /dev/null
+++ b/tools/lkl/Makefile.autoconf
@@ -0,0 +1,65 @@
+POSIX_HOSTS=elf64-x86-64 elf32-i386 elf64-x86-64-freebsd
+
+define set_autoconf_var
+  $(shell echo "#define LKL_HOST_CONFIG_$(1) $(2)" \
+	  >> $(OUTPUT)/include/lkl_autoconf.h)
+  $(shell echo "LKL_HOST_CONFIG_$(1)=$(2)" >> $(OUTPUT)/tests/autoconf.sh)
+  export LKL_HOST_CONFIG_$(1)=$(2)
+endef
+
+define find_include
+  $(eval include_paths=$(shell $(CC) -E -Wp,-v -xc /dev/null 2>&1 | grep '^ '))
+  $(foreach f, $(include_paths), $(wildcard $(f)/$(1)))
+endef
+
+define is_defined
+$(shell $(CC) -dM -E - </dev/null | grep $(1))
+endef
+
+define bsd_host
+  $(call set_autoconf_var,BSD,y)
+endef
+
+define arm_host
+  $(call set_autoconf_var,ARM,y)
+endef
+
+define aarch64_host
+  $(call set_autoconf_var,AARCH64,y)
+endef
+
+define posix_host
+  $(call set_autoconf_var,POSIX,y)
+  LDFLAGS += -pie
+  CFLAGS += -fPIC -pthread
+  SOSUF := .so
+  LDLIBS += -lrt -lpthread
+  $(if $(filter $(1),elf64-x86-64-freebsd),$(call bsd_host))
+  $(if $(filter $(1),elf32-littlearm),$(call arm_host))
+  $(if $(filter $(1),elf64-littleaarch64),$(call aarch64_host))
+  $(if $(strip $(call find_include,fuse.h)),$(call set_autoconf_var,FUSE,y))
+  $(if $(strip $(call find_include,archive.h)),$(call set_autoconf_var,ARCHIVE,y))
+  $(if $(filter $(1),elf64-x86-64-freebsd),$(call set_autoconf_var,NEEDS_LARGP,y))
+  $(if $(filter $(1),elf32-i386),$(call set_autoconf_var,I386,y))
+endef
+
+define do_autoconf
+  export CROSS_COMPILE := $(CROSS_COMPILE)
+  export CC := $(CROSS_COMPILE)gcc
+  export LD := $(CROSS_COMPILE)ld
+  export AR := $(CROSS_COMPILE)ar
+  $(eval LD := $(CROSS_COMPILE)ld)
+  $(eval CC := $(CROSS_COMPILE)gcc)
+  $(eval LD_FMT := $(shell $(LD) -r -print-output-format))
+  $(if $(filter $(LD_FMT),$(POSIX_HOSTS)),$(call posix_host,$(LD_FMT)))
+endef
+
+export do_autoconf
+
+
+$(OUTPUT)Makefile.conf: Makefile.autoconf
+	$(shell mkdir -p $(OUTPUT)/include)
+	$(shell mkdir -p $(OUTPUT)/tests)
+	$(shell echo -n "" > $(OUTPUT)/include/lkl_autoconf.h)
+	$(shell echo -n "" > $(OUTPUT)/tests/autoconf.sh)
+	@echo "$$do_autoconf" > $(OUTPUT)/Makefile.conf
diff --git a/tools/lkl/Targets b/tools/lkl/Targets
new file mode 100644
index 000000000000..24c985e64638
--- /dev/null
+++ b/tools/lkl/Targets
@@ -0,0 +1,3 @@
+libs-y += lib/liblkl
+
+
diff --git a/tools/lkl/include/.gitignore b/tools/lkl/include/.gitignore
new file mode 100644
index 000000000000..c41a463c898d
--- /dev/null
+++ b/tools/lkl/include/.gitignore
@@ -0,0 +1 @@
+lkl/
\ No newline at end of file
diff --git a/tools/lkl/include/lkl.h b/tools/lkl/include/lkl.h
new file mode 100644
index 000000000000..4b95d0ef8e5b
--- /dev/null
+++ b/tools/lkl/include/lkl.h
@@ -0,0 +1,358 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_H
+#define _LKL_H
+
+#include "lkl_autoconf.h"
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
+#if defined(__MINGW32__)
+#define strtok_r strtok_s
+#define inet_pton lkl_inet_pton
+
+int inet_pton(int af, const char *src, void *dst);
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
+static inline int lkl_sys_nanosleep_time32(struct __lkl__kernel_timespec *rqtp,
+					   struct __lkl__kernel_timespec *rmtp)
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
+#ifdef __lkl__NR_llseek
+/**
+ * lkl_sys_lseek - wrapper for lkl_sys_llseek
+ */
+static inline long long lkl_sys_lseek(unsigned int fd, __lkl__kernel_loff_t off,
+				      unsigned int whence)
+{
+	long long res;
+	long ret = lkl_sys_llseek(fd, off >> 32, off & 0xffffffff, &res,
+				  whence);
+
+	return ret < 0 ? ret : res;
+}
+#endif
+
+static inline void *lkl_sys_mmap(void *addr, size_t length, int prot, int flags,
+				 int fd, off_t offset)
+{
+	return (void *)lkl_sys_mmap_pgoff((long)addr, length, prot, flags, fd,
+					  offset >> 12);
+}
+
+#define lkl_sys_mmap2 lkl_sys_mmap_pgoff
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
+
+#ifdef __lkl__NR_faccessat
+/**
+ * lkl_sys_access - wrapper for lkl_sys_faccessat
+ */
+static inline long lkl_sys_access(const char *file, int mode)
+{
+	return lkl_sys_faccessat(LKL_AT_FDCWD, file, mode);
+}
+#endif
+
+#ifdef __lkl__NR_fchownat
+/**
+ * lkl_sys_chown - wrapper for lkl_sys_fchownat
+ */
+static inline long lkl_sys_chown(const char *path, lkl_uid_t uid, lkl_gid_t gid)
+{
+	return lkl_sys_fchownat(LKL_AT_FDCWD, path, uid, gid, 0);
+}
+#endif
+
+#ifdef __lkl__NR_fchmodat
+/**
+ * lkl_sys_chmod - wrapper for lkl_sys_fchmodat
+ */
+static inline long lkl_sys_chmod(const char *path, mode_t mode)
+{
+	return lkl_sys_fchmodat(LKL_AT_FDCWD, path, mode);
+}
+#endif
+
+#ifdef __lkl__NR_linkat
+/**
+ * lkl_sys_link - wrapper for lkl_sys_linkat
+ */
+static inline long lkl_sys_link(const char *existing, const char *new)
+{
+	return lkl_sys_linkat(LKL_AT_FDCWD, existing, LKL_AT_FDCWD, new, 0);
+}
+#endif
+
+#ifdef __lkl__NR_unlinkat
+/**
+ * lkl_sys_unlink - wrapper for lkl_sys_unlinkat
+ */
+static inline long lkl_sys_unlink(const char *path)
+{
+	return lkl_sys_unlinkat(LKL_AT_FDCWD, path, 0);
+}
+#endif
+
+#ifdef __lkl__NR_symlinkat
+/**
+ * lkl_sys_symlink - wrapper for lkl_sys_symlinkat
+ */
+static inline long lkl_sys_symlink(const char *existing, const char *new)
+{
+	return lkl_sys_symlinkat(existing, LKL_AT_FDCWD, new);
+}
+#endif
+
+#ifdef __lkl__NR_readlinkat
+/**
+ * lkl_sys_readlink - wrapper for lkl_sys_readlinkat
+ */
+static inline long lkl_sys_readlink(const char *path, char *buf, size_t bufsize)
+{
+	return lkl_sys_readlinkat(LKL_AT_FDCWD, path, buf, bufsize);
+}
+#endif
+
+#ifdef __lkl__NR_renameat
+/**
+ * lkl_sys_rename - wrapper for lkl_sys_renameat
+ */
+static inline long lkl_sys_rename(const char *old, const char *new)
+{
+	return lkl_sys_renameat(LKL_AT_FDCWD, old, LKL_AT_FDCWD, new);
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
+#ifdef __lkl__NR_unlinkat
+/**
+ * lkl_sys_rmdir - wrapper for lkl_sys_unlinkrat
+ */
+static inline long lkl_sys_rmdir(const char *path)
+{
+	return lkl_sys_unlinkat(LKL_AT_FDCWD, path, LKL_AT_REMOVEDIR);
+}
+#endif
+
+#ifdef __lkl__NR_mknodat
+/**
+ * lkl_sys_mknod - wrapper for lkl_sys_mknodat
+ */
+static inline long lkl_sys_mknod(const char *path, mode_t mode, dev_t dev)
+{
+	return lkl_sys_mknodat(LKL_AT_FDCWD, path, mode, dev);
+}
+#endif
+
+#ifdef __lkl__NR_pipe2
+/**
+ * lkl_sys_pipe - wrapper for lkl_sys_pipe2
+ */
+static inline long lkl_sys_pipe(int fd[2])
+{
+	return lkl_sys_pipe2(fd, 0);
+}
+#endif
+
+#ifdef __lkl__NR_sendto
+/**
+ * lkl_sys_send - wrapper for lkl_sys_sendto
+ */
+static inline long lkl_sys_send(int fd, void *buf, size_t len, int flags)
+{
+	return lkl_sys_sendto(fd, buf, len, flags, 0, 0);
+}
+#endif
+
+#ifdef __lkl__NR_recvfrom
+/**
+ * lkl_sys_recv - wrapper for lkl_sys_recvfrom
+ */
+static inline long lkl_sys_recv(int fd, void *buf, size_t len, int flags)
+{
+	return lkl_sys_recvfrom(fd, buf, len, flags, 0, 0);
+}
+#endif
+
+#ifdef __lkl__NR_pselect6
+/**
+ * lkl_sys_select - wrapper for lkl_sys_pselect
+ */
+static inline long lkl_sys_select(int n, lkl_fd_set *rfds, lkl_fd_set *wfds,
+				  lkl_fd_set *efds, struct lkl_timeval *tv)
+{
+	long data[2] = { 0, _LKL_NSIG/8 };
+	struct lkl_timespec ts;
+	lkl_time_t extra_secs;
+	const lkl_time_t max_time = ((1ULL<<8)*sizeof(time_t)-1)-1;
+
+	if (tv) {
+		if (tv->tv_sec < 0 || tv->tv_usec < 0)
+			return -LKL_EINVAL;
+
+		extra_secs = tv->tv_usec / 1000000;
+		ts.tv_nsec = tv->tv_usec % 1000000 * 1000;
+		ts.tv_sec = extra_secs > max_time - tv->tv_sec ?
+			max_time : tv->tv_sec + extra_secs;
+	}
+	return lkl_sys_pselect6(n, rfds, wfds, efds, tv ?
+				(struct __lkl__kernel_timespec *)&ts : 0, data);
+}
+#endif
+
+#ifdef __lkl__NR_ppoll
+/**
+ * lkl_sys_poll - wrapper for lkl_sys_ppoll
+ */
+static inline long lkl_sys_poll(struct lkl_pollfd *fds, int n, int timeout)
+{
+	return lkl_sys_ppoll(fds, n, timeout >= 0 ?
+			     (struct __lkl__kernel_timespec *)
+			     &((struct lkl_timespec){ .tv_sec = timeout/1000,
+				   .tv_nsec = timeout%1000*1000000 }) : 0,
+			     0, _LKL_NSIG/8);
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
+
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
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/tools/lkl/include/lkl_host.h b/tools/lkl/include/lkl_host.h
new file mode 100644
index 000000000000..b5f96096fe69
--- /dev/null
+++ b/tools/lkl/include/lkl_host.h
@@ -0,0 +1,19 @@
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
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/tools/lkl/lib/.gitignore b/tools/lkl/lib/.gitignore
new file mode 100644
index 000000000000..427ae0273fdd
--- /dev/null
+++ b/tools/lkl/lib/.gitignore
@@ -0,0 +1,3 @@
+lkl.o
+liblkl.a
+
diff --git a/tools/lkl/lib/Build b/tools/lkl/lib/Build
new file mode 100644
index 000000000000..8b137891791f
--- /dev/null
+++ b/tools/lkl/lib/Build
@@ -0,0 +1 @@
+
-- 
2.21.0 (Apple Git-122.2)

