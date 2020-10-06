Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B783284996
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJFJqP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFJqP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:46:15 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7203BC061755
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:46:15 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y20so952474pll.12
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rH4gei9MPvx6IQYMRAhuOETSp1Podm8Z71dGBNsbxHU=;
        b=OO87hkx0Fkvh8sCQ2mngO/0j2s+yoaZkbPem8w9Dve0mw/rhD19f888Hh99Fe3IZTw
         5EGq3n3a0S/9d6N7o+h9Bgf4MqHDAp0Nz1I1E/8y3rpAJvqUN8Pgc3pXMYarbQ0no7Hl
         HHWbB0yQsj8VNHsBZvTfLbA5iFP7m/2xftV+G7JIgUfbR8n+BIblt2/OlU2UnZhQHG0B
         Jk9K2wTt25mNK790O8xnls3sQ/IXm3Us7ul6s9YIUlqxU6JmoTzrxjwqOojFXY8+my+f
         ADC3pVtzXEAjetVUMYff3xQRdiN1+0FVotl2ShQfDInubwglrhwMP95Ap9J7Py2E9aIr
         6pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rH4gei9MPvx6IQYMRAhuOETSp1Podm8Z71dGBNsbxHU=;
        b=Q+eYojtRbdIXpaTHFJqF1vU1qMS12JNpE7u/lxoxjwtYRyGcCUXASnBJx7pgqZt2Sj
         WehcdZEdcl2kNgvujzSGb3tnmZ0ftCiiVUBEADUQb0MQzqi13I5l5Te9DyT00oljy+qj
         CUTGmCYHiyp6hxq1gidRA8UYq0gN4e10D9RqCANPHPExmDyRsFqqggERFQfukk0B7AR1
         IYku19tmMSaFIHsuPECNk4yknyU8Rgglz02trSWcAq3SOwilMdaELmBRmX0FyiathFFW
         QAxLwywUcRKTHNAoIABwvlBDbwmWXr/SxQYCYQiO9WYr0DHXSfD/uIRQRwg5VhZkqW2H
         vXgw==
X-Gm-Message-State: AOAM531xCZ5EXBw1G/fp09m08hoF5B7xYIqsy06TtTjH8X7N1ikHaQVO
        2+yAfUZpRFNq6WdVTNQNCyE=
X-Google-Smtp-Source: ABdhPJx8E2x1lx0f38YgFzshBcQjfxbFVLPcUHE/c8D9fr3FNLDNCApc3QVfIFJR8gwudfT5ctdnMQ==
X-Received: by 2002:a17:90a:d57:: with SMTP id 23mr3470735pju.232.1601977574887;
        Tue, 06 Oct 2020 02:46:14 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id j12sm2227595pjd.36.2020.10.06.02.46.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:46:14 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 1DF1420390F50C; Tue,  6 Oct 2020 18:46:12 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 16/21] um: nommu: plug in the build system
Date:   Tue,  6 Oct 2020 18:44:25 +0900
Message-Id: <714783a8d1d6aace7d0e315fc12ffc60b5867ada.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Basic Makefiles for building library of nommu mode. Add a new architecture
specific target for installing the resulting library files and headers.

To make nommu binaries build, UML introduced an additional option, UMMODE
variable, to switch the output file of build: kernel (default), or
library (nommu).  Those modes are not able to be ON at the same time.

To build on library mode, users do the following:

  make defconfig ARCH=um UMMODE=library
  make ARCH=um UMMODE=library

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/Kconfig           | 17 ++++++++++++++---
 arch/um/Makefile          | 12 +++++++++++-
 arch/um/kernel/Makefile   | 14 +++++++++-----
 arch/um/nommu/um/Kconfig  | 37 +++++++++++++++++++++++++++++++++++++
 arch/um/nommu/um/Makefile |  4 ++++
 5 files changed, 75 insertions(+), 9 deletions(-)
 create mode 100644 arch/um/nommu/um/Kconfig
 create mode 100644 arch/um/nommu/um/Makefile

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index e41d31d0d875..df7daceb095c 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -22,9 +22,20 @@ config UML
 	select TTY # Needed for line.c
 	select MODULE_REL_CRCS if MODVERSIONS
 
+config UMMODE_LIB
+	bool "UML mode: library mode"
+	default y if "$(UMMODE)" = "library"
+	help
+	 This mode switches a mode to build a library of UML (Linux
+	 Kernel Library/LKL).  This switch is exclusive to "kernel mode"
+	 of UML, which is traditional mode of UML.
+
+	 For more detail about LKL, see
+	 <file:Documentation/virt/uml/lkl.txt>.
+
 config MMU
 	bool
-	default y
+	default y if !UMMODE_LIB
 
 config NO_IOMEM
 	def_bool y
@@ -45,12 +56,12 @@ config LOCKDEP_SUPPORT
 
 config STACKTRACE_SUPPORT
 	bool
-	default y
+	default y if MMU
 	select STACKTRACE
 
 config GENERIC_CALIBRATE_DELAY
 	bool
-	default y
+	default y if MMU
 
 config HZ
 	int
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 8be7bc479442..ee35bd030bf8 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -17,6 +17,10 @@ else
         KBUILD_DEFCONFIG := $(SUBARCH)_defconfig
 endif
 
+ifeq ($(UMMODE),library)
+  SUBARCH := um/nommu
+endif
+
 ARCH_DIR := arch/um
 OS := $(shell uname -s)
 # We require bash because the vmlinux link and loader script cpp use bash
@@ -97,8 +101,14 @@ KBUILD_CFLAGS += $(KERNEL_DEFINES)
 LDFLAGS_vmlinux += -r
 
 INSTALL_PATH=$(objtree)/tools/um
+ifeq ($(UMMODE),library)
+all: install
+	$(Q)$(MAKE) -C $(srctree)/tools/um
+install: linux.o um_headers_install
+else
 all: linux
 install: linux.o
+endif
 	@echo "  INSTALL	$(INSTALL_PATH)/lib/$<"
 	@mkdir -p $(INSTALL_PATH)/lib/
 	@cp $< $(INSTALL_PATH)/lib/
@@ -111,7 +121,7 @@ linux: linux.o
 
 linux.o: vmlinux
 	@echo '  LINK	$@'
-	$(Q)$(OBJCOPY) -R .eh_frame $< $@
+	$(Q)$(OBJCOPY) -R .eh_frame -L sem_init -L sem_post -L sem_wait -L sem_destroy $< $@
 	$(Q)mkdir -p $(objtree)/tools/um/lib
 
 define archhelp
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 9b63831a69e1..01605ed439cb 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -14,17 +14,21 @@ CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
 			$(LDS_EXTRA)
 extra-y := vmlinux.lds
 
-obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
-	physmem.o process.o ptrace.o reboot.o sigio.o \
-	signal.o syscall.o sysrq.o time.o tlb.o trap.o \
-	um_arch.o umid.o maccess.o kmsg_dump.o skas/
+obj-y = config.o exitcode.o irq.o ksyms.o \
+	process.o reboot.o sigio.o \
+	signal.o syscall.o time.o \
+	um_arch.o umid.o maccess.o kmsg_dump.o
+
+ifdef CONFIG_MMU
+obj-y += exec.o mem.o physmem.o ptrace.o sysrq.o tlb.o trap.o skas/
+endif
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
-obj-y += user_syms.o
+obj-$(CONFIG_MMU) += user_syms.o
 
 USER_OBJS := config.o
 
diff --git a/arch/um/nommu/um/Kconfig b/arch/um/nommu/um/Kconfig
new file mode 100644
index 000000000000..20b3eaccb6f0
--- /dev/null
+++ b/arch/um/nommu/um/Kconfig
@@ -0,0 +1,37 @@
+config UML_NOMMU
+	def_bool y
+	depends on !SMP && !MMU
+	select UACCESS_MEMCPY
+	select ARCH_THREAD_STACK_ALLOCATOR
+	select ARCH_HAS_SYSCALL_WRAPPER
+
+config 64BIT
+	bool
+	default y
+
+config GENERIC_CSUM
+	def_bool y
+
+config GENERIC_ATOMIC64
+	bool
+	default y if !64BIT
+
+config SECCOMP
+	bool
+	default n
+
+config GENERIC_HWEIGHT
+	def_bool y
+
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default n
+
+config STACKTRACE_SUPPORT
+	bool
+	default n
+
+# XXX: need this to work well with tap13.py
+config PRINTK_TIME
+	bool
+	default y
diff --git a/arch/um/nommu/um/Makefile b/arch/um/nommu/um/Makefile
new file mode 100644
index 000000000000..b580e0fe97b5
--- /dev/null
+++ b/arch/um/nommu/um/Makefile
@@ -0,0 +1,4 @@
+include/generated/user_constants.h: $(srctree)/arch/um/nommu/um/user_constants.h
+	$(Q)cp -f $^ $@
+
+obj-y = bootmem.o console.o cpu.o delay.o setup.o syscalls.o threads.o unimplemented.o
-- 
2.21.0 (Apple Git-122.2)

