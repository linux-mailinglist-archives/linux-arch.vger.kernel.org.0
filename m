Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928361526EC
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 08:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBEHbS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 02:31:18 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51588 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgBEHbS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:31:18 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so602396pjb.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4D6xsqZQAiwvIAfG9pncMPrvhxiq5VDyTcRha79Ea0=;
        b=S++W/IuvGyCCYhOdymVm6W1arpqZ3x+5x4CN9upuj3HaeprnsGIXUw+sTCkKvI9qCt
         Wb/SiLmVvop8iFOEpLTGbe8cU+kXYulOdbs/9Ad341PR0OmqefDqxVqMOK6OkNRCYWys
         Vbb2fPxaZc1HUklfo6Gc/4HoyimbEdp3ncMH366senLJ9xeYKrrS2l2a41X9fCAcEReY
         MTJdeFDmc5F9JoOuNudJ+HxzpRTyWvl+GBLCf5dkIBcGvoWkyvuuypCO5BWIleoH9iN7
         z5pl8GyAIPYfwegADS2n33HRfOQJkzaIezVfIqOxeGDNirAo2N7ylP5b8hb3LPXVzxJI
         7tbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4D6xsqZQAiwvIAfG9pncMPrvhxiq5VDyTcRha79Ea0=;
        b=e8RsUzrt98Au1yTyBky9GGIDYMNk5cycgV1QuuayVWeT1QQixEAQyo0UsNJSusRGnG
         QeOIMASi9wMOn8hTzKowxdV2s1st8rHSi2nXeUdTuJh6RgS+nAArFj0LfbG8v09hHQy1
         f4UHzGfCFqOqgmUIKBbv0TQr0piykGMwK+7qEURxGhsIjeRvQeM4l54VXcCtafH1mWRR
         axibxzag0BPzXf17TZ/if9vO7oYhmSsuFHjqpxpXccGcECbw36co5GvQtRJS9YPudIxe
         l7kGxcRao0uWIK4onEyMRNF9COBInHHmm24hUb4XoLKDZ0KTFlTGNi+WNk2C9WXPd9fA
         iceg==
X-Gm-Message-State: APjAAAVVD/K00C+4g15I2RUoJOoWcPJcS9Upu4cvAaN7f50zF7hbynS/
        4wlkZppWSZWTyEf6mQRYJa8=
X-Google-Smtp-Source: APXvYqwg5XusmPWiQ1ws8tOYterE+Jh1sFKmDneJ4FG9ulB409XB6XVHxfkqC1+zE2uKRIZZBoILDg==
X-Received: by 2002:a17:902:444:: with SMTP id 62mr30712107ple.209.1580887876134;
        Tue, 04 Feb 2020 23:31:16 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id z18sm27658502pfk.19.2020.02.04.23.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 23:31:15 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id B3910202573041; Wed,  5 Feb 2020 16:31:13 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v3 12/26] um lkl: plug in the build system
Date:   Wed,  5 Feb 2020 16:30:21 +0900
Message-Id: <123419ed2c13799ed92540d412042be037d8246b.1580882335.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

Basic Makefiles for building LKL. Add a new architecture specific
target for installing the resulting library files and headers.

To make LKL binaries build, UML introduced an additional option, UMMODE
variable, to switch the output file of build: kernel (default), or
library (LKL).  Those modes are not able to be ON at the same time.

To build on library mode, users do the following:

  make defconfig ARCH=um UMMODE=library
  make ARCH=um UMMODE=library

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Signed-off-by: Akira Moroo <retrage01@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/Kconfig             | 13 +++++++
 arch/um/Makefile            | 19 ++++++++++-
 arch/um/Makefile.um         | 10 ++++++
 arch/um/lkl/Kconfig         | 31 +++++++++++++++--
 arch/um/lkl/Makefile        | 67 +++++++++++++++++++++++++++++++++++++
 arch/um/lkl/auto.conf       |  1 +
 arch/um/lkl/kernel/Makefile |  4 +++
 arch/um/lkl/mm/Makefile     |  1 +
 8 files changed, 143 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/Makefile.um
 create mode 100644 arch/um/lkl/Makefile
 create mode 100644 arch/um/lkl/auto.conf
 create mode 100644 arch/um/lkl/kernel/Makefile
 create mode 100644 arch/um/lkl/mm/Makefile

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 0917f8443c28..fce63e42198d 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -5,6 +5,10 @@ menu "UML-specific options"
 config UML
 	bool
 	default y
+
+config UMMODE_KERN
+	bool "UML mode: kernel mode"
+	default y if "$(UMMODE)" = "kernel"
 	select ARCH_HAS_KCOV
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
@@ -20,7 +24,12 @@ config UML
 	select GENERIC_CLOCKEVENTS
 	select HAVE_GCC_PLUGINS
 	select TTY # Needed for line.c
+        help
+	  This mode switches a mode to build a regular kernel executable
+          of UML.
+
 
+if UMMODE_KERN
 config MMU
 	bool
 	default y
@@ -200,6 +209,10 @@ config UML_TIME_TRAVEL_SUPPORT
 
 	  It is safe to say Y, but you probably don't need this.
 
+endif #UMMODE_KERN
+
 endmenu
 
 source "arch/um/drivers/Kconfig"
+
+source "arch/um/lkl/Kconfig"
diff --git a/arch/um/Makefile b/arch/um/Makefile
index d2daa206872d..f2a537f700c2 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # This file is included by the global makefile so that you can add your own
 # architecture-specific flags and dependencies.
@@ -44,7 +45,7 @@ HOST_DIR := arch/$(HEADER_ARCH)
 include $(ARCH_DIR)/Makefile-skas
 include $(HOST_DIR)/Makefile.um
 
-core-y += $(HOST_DIR)/um/
+
 
 SHARED_HEADERS	:= $(ARCH_DIR)/include/shared
 ARCH_INCLUDE	:= -I$(srctree)/$(SHARED_HEADERS)
@@ -144,5 +145,21 @@ CLEAN_FILES += linux x.i gmon.out
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)rm -rf $(srctree)/$(LKL_DIR)/include/generated
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
+
+
+
+# SPDX-License-Identifier: GPL-2.0
+# select mode of UML build
+UMMODE ?= kernel
+LKL_DIR := $(ARCH_DIR)/lkl
+
+ifeq ($(UMMODE),kernel)
+	include $(ARCH_DIR)/Makefile.um
+else ifeq ($(UMMODE),library)
+	include $(ARCH_DIR)/lkl/Makefile
+endif
+
+export UMMODE LKL_DIR
diff --git a/arch/um/Makefile.um b/arch/um/Makefile.um
new file mode 100644
index 000000000000..be7ee4d1adde
--- /dev/null
+++ b/arch/um/Makefile.um
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
+# Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+# Licensed under the GPL
+#
+
+core-y += $(HOST_DIR)/um/
diff --git a/arch/um/lkl/Kconfig b/arch/um/lkl/Kconfig
index f7b641ea7aef..f72b423fad5b 100644
--- a/arch/um/lkl/Kconfig
+++ b/arch/um/lkl/Kconfig
@@ -1,6 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config UML_LKL
+menu "LKL-specific options"
+
+config UML
+	bool
+	default y
+
+config UMMODE_LIB
+	bool "UML mode: library mode"
+	depends on !UMMODE_KERN
+	select LKL
+	default y if "$(UMMODE)" = "library"
+	help
+	  This mode switches a mode to build a library of UML (Linux
+	  Kernel Library/LKL).  This switch is exclusive to "kernel mode"
+	  of UML, which is traditional mode of UML.
+
+	  For more detail about LKL, see
+	  <file:Documentation/virt/uml/lkl.txt>.
+
+config LKL
        def_bool y
        depends on !SMP && !MMU && !COREDUMP && !SECCOMP && !UPROBES && !COMPAT && !USER_RETURN_NOTIFIER
        select ARCH_THREAD_STACK_ALLOCATOR
@@ -29,6 +48,12 @@ config OUTPUT_FORMAT
 config ARCH_DMA_ADDR_T_64BIT
        def_bool 64BIT
 
+config X86_64
+       def_bool y if "$(OUTPUT_FORMAT)" = "elf64-x86-64"
+
+config X86_32
+       def_bool y if "$(OUTPUT_FORMAT)" = "elf32-i386"
+
 config 64BIT
        def_bool n
 
@@ -39,7 +64,7 @@ config BIG_ENDIAN
        def_bool n
 
 config GENERIC_CSUM
-       def_bool y
+       def_bool LKL
 
 config GENERIC_HWEIGHT
        def_bool y
@@ -54,3 +79,5 @@ config RWSEM_GENERIC_SPINLOCK
 config HZ
         int
         default 100
+
+endmenu
diff --git a/arch/um/lkl/Makefile b/arch/um/lkl/Makefile
new file mode 100644
index 000000000000..e1161fa3fb63
--- /dev/null
+++ b/arch/um/lkl/Makefile
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+
+include $(LKL_DIR)/auto.conf
+
+# fixup CFLAGS of um build
+KBUILD_CFLAGS := $(subst $(CFLAGS),,$(KBUILD_CFLAGS))
+
+SRCARCH := um/lkl
+ARCH_INCLUDE += -I$(srctree)/$(LKL_DIR)/um/include
+LINUXINCLUDE := $(subst $(ARCH_DIR),$(LKL_DIR),$(LINUXINCLUDE)) $(ARCH_INCLUDE)
+KBUILD_CFLAGS += -fno-builtin
+KBUILD_DEFCONFIG := lkl_defconfig
+
+ifneq (,$(filter $(OUTPUT_FORMAT),elf64-x86-64 elf32-i386 elf64-x86-64-freebsd elf32-littlearm elf64-littleaarch64))
+KBUILD_CFLAGS += -fPIC
+else ifneq (,$(filter $(OUTPUT_FORMAT),pe-i386 pe-x86-64 ))
+ifneq ($(OUTPUT_FORMAT),pe-x86-64)
+prefix=_
+endif
+# workaround for #include_next<stdarg.h> errors
+LINUXINCLUDE := -isystem $(LKL_DIR)/include/system $(LINUXINCLUDE)
+# workaround for https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52991
+KBUILD_CFLAGS += -mno-ms-bitfields
+else
+$(error Unrecognized platform: $(OUTPUT_FORMAT))
+endif
+
+ifeq ($(shell uname -s), Linux)
+NPROC=$(shell nproc)
+else # e.g., FreeBSD
+NPROC=$(shell sysctl -n hw.ncpu)
+endif
+
+LDFLAGS_vmlinux += -r
+LKL_ENTRY_POINTS := lkl_start_kernel lkl_sys_halt lkl_syscall lkl_trigger_irq \
+	lkl_get_free_irq lkl_put_irq lkl_is_running lkl_bug lkl_printf
+
+ifeq ($(OUTPUT_FORMAT),elf32-i386)
+LKL_ENTRY_POINTS += \
+	__x86.get_pc_thunk.bx __x86.get_pc_thunk.dx __x86.get_pc_thunk.ax \
+	__x86.get_pc_thunk.cx __x86.get_pc_thunk.si __x86.get_pc_thunk.di
+endif
+
+core-y += $(LKL_DIR)/kernel/
+core-y += $(LKL_DIR)/mm/
+
+all: lkl.o
+
+lkl.o: vmlinux
+	$(OBJCOPY) -R .eh_frame -R .syscall_defs $(foreach sym,$(LKL_ENTRY_POINTS),-G$(prefix)$(sym)) vmlinux lkl.o
+
+$(LKL_DIR)/include/generated/uapi/asm/syscall_defs.h: vmlinux
+	$(OBJCOPY) -j .syscall_defs -O binary --set-section-flags .syscall_defs=alloc $< $@
+	$(Q) export tmpfile=$(shell mktemp); \
+	sed 's/\x0//g' $@ > $$tmpfile; mv $$tmpfile $@ ; rm -f $$tmpfile
+
+install: lkl.o headers $(LKL_DIR)/include/generated/uapi/asm/syscall_defs.h
+	@echo "  INSTALL	$(INSTALL_PATH)/lib/lkl.o"
+	@mkdir -p $(INSTALL_PATH)/lib/
+	@cp lkl.o $(INSTALL_PATH)/lib/
+	$(Q)$(srctree)/$(LKL_DIR)/scripts/headers_install.py \
+		$(subst -j,-j$(NPROC),$(findstring -j,$(MAKEFLAGS))) \
+		$(INSTALL_PATH)/include
+
+define archhelp
+  echo '  install	- Install library and headers to INSTALL_PATH/{lib,include}'
+endef
diff --git a/arch/um/lkl/auto.conf b/arch/um/lkl/auto.conf
new file mode 100644
index 000000000000..4bfd65a02d73
--- /dev/null
+++ b/arch/um/lkl/auto.conf
@@ -0,0 +1 @@
+export OUTPUT_FORMAT=$(shell $(LD) -r -print-output-format)
diff --git a/arch/um/lkl/kernel/Makefile b/arch/um/lkl/kernel/Makefile
new file mode 100644
index 000000000000..ef489f2f7176
--- /dev/null
+++ b/arch/um/lkl/kernel/Makefile
@@ -0,0 +1,4 @@
+extra-y := vmlinux.lds
+
+obj-y = setup.o threads.o irq.o time.o syscalls.o misc.o console.o \
+	syscalls_32.o cpu.o
diff --git a/arch/um/lkl/mm/Makefile b/arch/um/lkl/mm/Makefile
new file mode 100644
index 000000000000..2af6e3051897
--- /dev/null
+++ b/arch/um/lkl/mm/Makefile
@@ -0,0 +1 @@
+obj-y = bootmem.o
-- 
2.21.0 (Apple Git-122.2)

