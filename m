Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97236276A65
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgIXHP4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXHPz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:15:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09097C0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:15:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k8so1349869pfk.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nKyrI8T3WpefS58p4nYoXNvPuy8WkBwPKR8dWEqpiec=;
        b=pzaY2AuLkHBpmT2HSX6hCrBvpQKijE79tfz00pvsIymQHL7nid/ivk12crWkAkqLOf
         FgUZesbVCZSpYPYSNUvV0BkTnQ1cAsqrzFxaVWS4Xyvk6tzmAQvebTBCpFmXg/HwA7c5
         GVf55DjGyCci83TtKYaDDImCeQ0ltUY68MZMpK+j4Htvy3i3ZlBjly7mgGURXH497r3k
         6K2U2dg1fq13BRhUIBaYXnu94hEFUjnWUQPeXirVEyOa8Y8QIhXSlxVC6+kokqivexq3
         eHUhvmWMX6RNsyb5XpOkf3r8q5I9zml+SJG5tcuz0zkIvlIgSLjsZyL55K/cJYH5jQFj
         UMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nKyrI8T3WpefS58p4nYoXNvPuy8WkBwPKR8dWEqpiec=;
        b=NG89hwihTPjYXV+o4QK47oRGeUUkvIe2tiITUUghQtZQq/gdCfvvANupk6zdGDIW16
         oyThnWYrV61X7S+zrhFsMAxonfxIGUCdR3FxfQk8KgotZ7SL1V5d/hHmM3Zc7W4ztVJ6
         WGoiMYNI3/JEKt+y9LulPbbsOCYrlUfi/GinzUfJb3sCuhaRNplhDecndZG7uTp822GP
         dk6Pk8w37HJsGZItXFNNZGUWUkttQMeP0VvvEqtVmRqrWq2RaM5rGr+KAR+E+cuVVkdu
         ULn2SKLYB6mz1M7F62+CYRapMNWeUxq2EbvTx6XKKttPBqmvmd8dAoeUlqErcwCQvcNe
         P4TA==
X-Gm-Message-State: AOAM533Zb9SC39zqutv6x5JL17zL3JVkkYS2k6U6LQ7K/UyqlOOUGniA
        8p41lx1oqqZED3CyGe44qHA=
X-Google-Smtp-Source: ABdhPJxlY33RutyUgn6a2ahhIO736oQkAwLVlBiuZVcMtSfRX4/cVVjmnQM71v9A+iWF3JFGD0pOXg==
X-Received: by 2002:a63:5363:: with SMTP id t35mr2816015pgl.443.1600931755411;
        Thu, 24 Sep 2020 00:15:55 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id gj6sm1371509pjb.10.2020.09.24.00.15.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:15:54 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 0A0A52037C20E7; Thu, 24 Sep 2020 16:15:52 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v6 16/21] um: nommu: plug in the build system
Date:   Thu, 24 Sep 2020 16:12:56 +0900
Message-Id: <8e8af2d046852b7ddedf36e36e522261ebd2350e.1600922529.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
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
 arch/um/Makefile          | 10 +++++++++-
 arch/um/kernel/Makefile   | 12 ++++++++----
 arch/um/nommu/um/Kconfig  | 37 +++++++++++++++++++++++++++++++++++++
 arch/um/nommu/um/Makefile |  4 ++++
 5 files changed, 72 insertions(+), 8 deletions(-)
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
index 1f958a9280fe..73d3ac061b77 100644
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
@@ -102,9 +106,13 @@ all: linux.o
 
 linux.o: vmlinux
 	@echo '  LINK $@'
-	$(Q)$(OBJCOPY) -R .eh_frame $< $@
+	$(Q)$(OBJCOPY) -R .eh_frame -L sem_init -L sem_post -L sem_wait -L sem_destroy $< $@
 
+ifeq ($(UMMODE),library)
+install: linux.o um_headers_install
+else
 install: linux.o
+endif
 	@echo "  INSTALL $(INSTALL_PATH)/lib/$<"
 	@mkdir -p $(INSTALL_PATH)/lib/
 	@cp $< $(INSTALL_PATH)/lib/
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 5aa882011e04..bdc4108bc52e 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -14,10 +14,14 @@ CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
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

