Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF642FC8FD
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbhATC3e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 21:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729965AbhATC2f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:28:35 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8802C0613C1
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:27:53 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id my11so2364234pjb.1
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5r5bI8A65LN2SI4myGsB2aomb7p4f4PRN/9IrfOYQGw=;
        b=khJbnrwkWyvFb5tUPJ7leMw1h7O+x77ma+2G4vr9L4baP55QPgcmBDx42yPzFsYmYK
         ESKk3o407rV3WcV4/n7iBLVMsAzIQFhr2mH7VHH8GYnWcjFn22Kc1iVYnFRSOwmm2vxE
         MHmUBuzs6EEwsbgaicn2n9Wgd2KuDHeId9ki9+i2l1zIHGQSTuoj0klHCdvd+9gVuFmF
         BlX5+371/JtuiYS61aSua7Gh0SqqAF6gUbcFvFgxHey62da1j0GeOAbTDxdzDov0+tgH
         I7uktJzR6emDTlMy3HVbpG5/WeMEZ9PzkmC7FIYbIbbD2zkxn4yt/mkriMTaOmqXihfs
         NyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5r5bI8A65LN2SI4myGsB2aomb7p4f4PRN/9IrfOYQGw=;
        b=U5XrqHgA/lMcstXlaIYa8559feoJjCABe1KkoJtcX+wIJJed30ccHgDO5BQrJ356bh
         1mAw32gmImMzn2LVG1vVLJtX2YmPGMS9/whRyvUS5EXGMFeMj+f9R7keAGLDgF2f4ujB
         etUYm6A1TZGHDrzosAhJk6zdN7ylixo1JHhaQc5ln+wLDuxokxQX89+66eODGcOfwO1u
         jIu6ob0zqYhG+KCS88SseRvrn+ixQhCr+yYz67asbhaMwm3YZECDhFMRn0b6VI9nj9RJ
         Hr2yKnfaotB3OSP7/7Oo+JQ3DxBrSk2I/f8cHjyIoFyZyZGKUEUbUJWwY0em+RP+biI2
         zifg==
X-Gm-Message-State: AOAM533ErskORR6M/Sa6JN89U1ZYguIlle5gI8HteA0kifq3hiJm2NVq
        lyG85QKcEHZGklck1HeH7W4=
X-Google-Smtp-Source: ABdhPJzVeuKu9Dd37ocJGzEKWEkh6elw1a/G9plpRyMu8857zzzEn3iqT9pDzs/m0E0jd5oHTPwgmA==
X-Received: by 2002:a17:902:8f91:b029:de:302e:cfda with SMTP id z17-20020a1709028f91b02900de302ecfdamr7521459plo.69.1611109673185;
        Tue, 19 Jan 2021 18:27:53 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id a2sm355030pgi.8.2021.01.19.18.27.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:27:52 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 6770120442D294; Wed, 20 Jan 2021 11:27:50 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 02/20] um: move arch/um/os-Linux dir to tools/um/uml
Date:   Wed, 20 Jan 2021 11:27:07 +0900
Message-Id: <a1e04393b966ec467f2ef91e8941e700ca5d80fc.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch moves underlying OS dependent part under arch/um to tools/um
directory so that arch/um code does not need to build host build
facilities (e.g., libc).

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/Makefile                              |  3 +-
 arch/um/drivers/Makefile                      |  2 +
 .../um/{os-Linux => }/drivers/ethertap_kern.c |  0
 arch/um/{os-Linux => }/drivers/tuntap_kern.c  |  0
 .../drivers => include/shared}/etap.h         |  0
 arch/um/include/shared/init.h                 |  5 ++
 .../drivers => include/shared}/tuntap.h       |  0
 arch/um/kernel/Makefile                       |  1 +
 arch/um/{os-Linux => kernel}/user_syms.c      |  0
 arch/um/os-Linux/Makefile                     | 21 --------
 arch/um/os-Linux/drivers/Makefile             | 13 -----
 tools/um/Makefile                             |  4 +-
 tools/um/uml/Build                            | 50 +++++++++++++++++++
 tools/um/uml/drivers/Build                    | 10 ++++
 .../um/uml}/drivers/ethertap_user.c           |  0
 .../um/uml}/drivers/tuntap_user.c             |  0
 {arch/um/os-Linux => tools/um/uml}/elf_aux.c  |  0
 {arch/um/os-Linux => tools/um/uml}/execvp.c   |  4 --
 {arch/um/os-Linux => tools/um/uml}/file.c     |  0
 {arch/um/os-Linux => tools/um/uml}/helper.c   |  0
 {arch/um/os-Linux => tools/um/uml}/irq.c      |  0
 {arch/um/os-Linux => tools/um/uml}/main.c     |  0
 {arch/um/os-Linux => tools/um/uml}/mem.c      |  0
 {arch/um/os-Linux => tools/um/uml}/process.c  |  0
 .../um/os-Linux => tools/um/uml}/registers.c  |  0
 {arch/um/os-Linux => tools/um/uml}/sigio.c    |  0
 {arch/um/os-Linux => tools/um/uml}/signal.c   |  0
 .../skas/Makefile => tools/um/uml/skas/Build  |  6 +--
 {arch/um/os-Linux => tools/um/uml}/skas/mem.c |  0
 .../os-Linux => tools/um/uml}/skas/process.c  |  3 +-
 {arch/um/os-Linux => tools/um/uml}/start_up.c |  0
 {arch/um/os-Linux => tools/um/uml}/time.c     |  0
 {arch/um/os-Linux => tools/um/uml}/tty.c      |  0
 {arch/um/os-Linux => tools/um/uml}/umid.c     |  0
 {arch/um/os-Linux => tools/um/uml}/util.c     |  0
 35 files changed, 73 insertions(+), 49 deletions(-)
 rename arch/um/{os-Linux => }/drivers/ethertap_kern.c (100%)
 rename arch/um/{os-Linux => }/drivers/tuntap_kern.c (100%)
 rename arch/um/{os-Linux/drivers => include/shared}/etap.h (100%)
 rename arch/um/{os-Linux/drivers => include/shared}/tuntap.h (100%)
 rename arch/um/{os-Linux => kernel}/user_syms.c (100%)
 delete mode 100644 arch/um/os-Linux/Makefile
 delete mode 100644 arch/um/os-Linux/drivers/Makefile
 create mode 100644 tools/um/uml/drivers/Build
 rename {arch/um/os-Linux => tools/um/uml}/drivers/ethertap_user.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/drivers/tuntap_user.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/elf_aux.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/execvp.c (98%)
 rename {arch/um/os-Linux => tools/um/uml}/file.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/helper.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/irq.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/main.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/mem.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/process.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/registers.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/sigio.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/signal.c (100%)
 rename arch/um/os-Linux/skas/Makefile => tools/um/uml/skas/Build (56%)
 rename {arch/um/os-Linux => tools/um/uml}/skas/mem.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/skas/process.c (99%)
 rename {arch/um/os-Linux => tools/um/uml}/start_up.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/time.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/tty.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/umid.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/util.c (100%)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 48fbbc3a0032..bce0cccae085 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -24,8 +24,7 @@ OS := $(shell uname -s)
 SHELL := /bin/bash
 
 core-y			+= $(ARCH_DIR)/kernel/		\
-			   $(ARCH_DIR)/drivers/		\
-			   $(ARCH_DIR)/os-$(OS)/
+			   $(ARCH_DIR)/drivers/
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
 
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 2a249f619467..ae96c83e312d 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -48,6 +48,8 @@ obj-$(CONFIG_UML_NET_VECTOR) += vector.o
 obj-$(CONFIG_UML_NET_VDE) += vde.o
 obj-$(CONFIG_UML_NET_MCAST) += umcast.o
 obj-$(CONFIG_UML_NET_PCAP) += pcap.o
+obj-$(CONFIG_UML_NET_ETHERTAP) += ethertap_kern.o
+obj-$(CONFIG_UML_NET_TUNTAP) += tuntap_kern.o
 obj-$(CONFIG_UML_NET) += net.o 
 obj-$(CONFIG_MCONSOLE) += mconsole.o
 obj-$(CONFIG_MMAPPER) += mmapper_kern.o 
diff --git a/arch/um/os-Linux/drivers/ethertap_kern.c b/arch/um/drivers/ethertap_kern.c
similarity index 100%
rename from arch/um/os-Linux/drivers/ethertap_kern.c
rename to arch/um/drivers/ethertap_kern.c
diff --git a/arch/um/os-Linux/drivers/tuntap_kern.c b/arch/um/drivers/tuntap_kern.c
similarity index 100%
rename from arch/um/os-Linux/drivers/tuntap_kern.c
rename to arch/um/drivers/tuntap_kern.c
diff --git a/arch/um/os-Linux/drivers/etap.h b/arch/um/include/shared/etap.h
similarity index 100%
rename from arch/um/os-Linux/drivers/etap.h
rename to arch/um/include/shared/etap.h
diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
index 1a659e2e8cc3..fa2d3138d497 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -41,7 +41,12 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
+#ifndef __UM_HOST__
 #include <linux/compiler_types.h>
+#else
+#define __used                          __attribute__((__used__))
+#define __section(S)                    __attribute__((__section__(#S)))
+#endif
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
diff --git a/arch/um/os-Linux/drivers/tuntap.h b/arch/um/include/shared/tuntap.h
similarity index 100%
rename from arch/um/os-Linux/drivers/tuntap.h
rename to arch/um/include/shared/tuntap.h
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 5aa882011e04..9b63831a69e1 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
+obj-y += user_syms.o
 
 USER_OBJS := config.o
 
diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/kernel/user_syms.c
similarity index 100%
rename from arch/um/os-Linux/user_syms.c
rename to arch/um/kernel/user_syms.c
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
deleted file mode 100644
index 77ac50baa3f8..000000000000
--- a/arch/um/os-Linux/Makefile
+++ /dev/null
@@ -1,21 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# 
-# Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
-#
-
-# Don't instrument UML-specific code
-KCOV_INSTRUMENT                := n
-
-obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
-	registers.o sigio.o signal.o start_up.o time.o tty.o \
-	umid.o user_syms.o util.o drivers/ skas/
-
-CFLAGS_signal.o += -Wframe-larger-than=4096
-
-obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
-
-USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
-	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
-	tty.o umid.o util.o
-
-include arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/drivers/Makefile b/arch/um/os-Linux/drivers/Makefile
deleted file mode 100644
index d79e75f1b69a..000000000000
--- a/arch/um/os-Linux/drivers/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# 
-# Copyright (C) 2000, 2002 Jeff Dike (jdike@karaya.com)
-#
-
-ethertap-objs := ethertap_kern.o ethertap_user.o
-tuntap-objs := tuntap_kern.o tuntap_user.o
-
-obj-y = 
-obj-$(CONFIG_UML_NET_ETHERTAP) += ethertap.o
-obj-$(CONFIG_UML_NET_TUNTAP) += tuntap.o
-
-include arch/um/scripts/Makefile.rules
diff --git a/tools/um/Makefile b/tools/um/Makefile
index 2b4e6b63355b..0fdf77261e74 100644
--- a/tools/um/Makefile
+++ b/tools/um/Makefile
@@ -50,7 +50,7 @@ $(objtree)/linux.o:
 $(OUTPUT)lib/linux.o: $(objtree)/linux.o
 	$(Q)cp $(objtree)/linux.o $(OUTPUT)lib/linux.o
 
-$(OUTPUT)liblinux.a: $(OUTPUT)lib/linux.o $(OUTPUT)uml/liblinux-in.o
+$(OUTPUT)liblinux.a: $(OUTPUT)lib/linux.o $(OUTPUT)uml/liblinux-in.o $(OUTPUT)lib/liblinux-in.o
 	$(QUIET_AR)$(AR) -rc $@ $^
 
 # rule to link programs
@@ -58,7 +58,7 @@ $(OUTPUT)%: $(OUTPUT)%-in.o $(OUTPUT)liblinux.a
 	$(QUIET_LINK)$(CC) $(LDFLAGS) $(LDFLAGS_$(notdir $*)-y) -o $@ $^ $(LDLIBS) $(LDLIBS_$(notdir $*)-y)
 
 # rule to build objects
-$(OUTPUT)%-in.o: FORCE
+$(OUTPUT)%-in.o: $(OUTPUT)lib/linux.o FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
 
 RM := rm -f
diff --git a/tools/um/uml/Build b/tools/um/uml/Build
index e69de29bb2d1..0e629c9cb8eb 100644
--- a/tools/um/uml/Build
+++ b/tools/um/uml/Build
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+#
+
+# Don't instrument UML-specific code
+KCOV_INSTRUMENT                := n
+
+include $(objtree)/include/config/auto.conf
+
+liblinux-y += execvp.o file.o helper.o irq.o main.o mem.o process.o \
+	registers.o sigio.o signal.o start_up.o time.o tty.o \
+	umid.o util.o drivers/ skas/
+
+CFLAGS_signal.o += -Wframe-larger-than=4096
+
+liblinux-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
+
+export O = $(srctree)
+objtree := $(O)
+# reset CFLAGS
+CFLAGS := -g -O2
+
+# from arch/um/Makefile
+ARCH_DIR := arch/um
+HEADER_ARCH 	:= x86
+HOST_DIR := arch/$(HEADER_ARCH)
+ifdef CONFIG_64BIT
+  KBUILD_CFLAGS += -mcmodel=large
+endif
+KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
+	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
+	-Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
+	-Din6addr_loopback=kernel_in6addr_loopback \
+	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
+SHARED_HEADERS	:= $(ARCH_DIR)/include/shared
+MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
+ARCH_INCLUDE	:= -I$(srctree)/$(SHARED_HEADERS)
+ARCH_INCLUDE	+= -I$(srctree)/$(HOST_DIR)/um/shared
+KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/um
+USER_CFLAGS := $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
+		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
+		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include/uapi \
+		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
+
+# from Makefile-os-Linux
+USER_CFLAGS += -D_GNU_SOURCE -D_LARGEFILE64_SOURCE
+
+# from Makefile.rules
+CFLAGS += $(USER_CFLAGS) -include $(srctree)/tools/include/linux/kern_levels.h -include user.h $(CFLAGS_$(basetarget).o)
diff --git a/tools/um/uml/drivers/Build b/tools/um/uml/drivers/Build
new file mode 100644
index 000000000000..c7a8eaa97d72
--- /dev/null
+++ b/tools/um/uml/drivers/Build
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2000, 2002 Jeff Dike (jdike@karaya.com)
+#
+
+include $(objtree)/include/config/auto.conf
+
+
+liblinux-$(CONFIG_UML_NET_ETHERTAP) += ethertap_user.o
+liblinux-$(CONFIG_UML_NET_TUNTAP) += tuntap_user.o
diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/tools/um/uml/drivers/ethertap_user.c
similarity index 100%
rename from arch/um/os-Linux/drivers/ethertap_user.c
rename to tools/um/uml/drivers/ethertap_user.c
diff --git a/arch/um/os-Linux/drivers/tuntap_user.c b/tools/um/uml/drivers/tuntap_user.c
similarity index 100%
rename from arch/um/os-Linux/drivers/tuntap_user.c
rename to tools/um/uml/drivers/tuntap_user.c
diff --git a/arch/um/os-Linux/elf_aux.c b/tools/um/uml/elf_aux.c
similarity index 100%
rename from arch/um/os-Linux/elf_aux.c
rename to tools/um/uml/elf_aux.c
diff --git a/arch/um/os-Linux/execvp.c b/tools/um/uml/execvp.c
similarity index 98%
rename from arch/um/os-Linux/execvp.c
rename to tools/um/uml/execvp.c
index 84a0777c2a45..c105e0e7b778 100644
--- a/arch/um/os-Linux/execvp.c
+++ b/tools/um/uml/execvp.c
@@ -26,12 +26,8 @@
 #include <errno.h>
 #include <limits.h>
 
-#ifndef TEST
-#include <um_malloc.h>
-#else
 #include <stdio.h>
 #define um_kmalloc malloc
-#endif
 #include <os.h>
 
 /* Execute FILE, searching in the `PATH' environment variable if it contains
diff --git a/arch/um/os-Linux/file.c b/tools/um/uml/file.c
similarity index 100%
rename from arch/um/os-Linux/file.c
rename to tools/um/uml/file.c
diff --git a/arch/um/os-Linux/helper.c b/tools/um/uml/helper.c
similarity index 100%
rename from arch/um/os-Linux/helper.c
rename to tools/um/uml/helper.c
diff --git a/arch/um/os-Linux/irq.c b/tools/um/uml/irq.c
similarity index 100%
rename from arch/um/os-Linux/irq.c
rename to tools/um/uml/irq.c
diff --git a/arch/um/os-Linux/main.c b/tools/um/uml/main.c
similarity index 100%
rename from arch/um/os-Linux/main.c
rename to tools/um/uml/main.c
diff --git a/arch/um/os-Linux/mem.c b/tools/um/uml/mem.c
similarity index 100%
rename from arch/um/os-Linux/mem.c
rename to tools/um/uml/mem.c
diff --git a/arch/um/os-Linux/process.c b/tools/um/uml/process.c
similarity index 100%
rename from arch/um/os-Linux/process.c
rename to tools/um/uml/process.c
diff --git a/arch/um/os-Linux/registers.c b/tools/um/uml/registers.c
similarity index 100%
rename from arch/um/os-Linux/registers.c
rename to tools/um/uml/registers.c
diff --git a/arch/um/os-Linux/sigio.c b/tools/um/uml/sigio.c
similarity index 100%
rename from arch/um/os-Linux/sigio.c
rename to tools/um/uml/sigio.c
diff --git a/arch/um/os-Linux/signal.c b/tools/um/uml/signal.c
similarity index 100%
rename from arch/um/os-Linux/signal.c
rename to tools/um/uml/signal.c
diff --git a/arch/um/os-Linux/skas/Makefile b/tools/um/uml/skas/Build
similarity index 56%
rename from arch/um/os-Linux/skas/Makefile
rename to tools/um/uml/skas/Build
index c4566e788815..5fc9d62df863 100644
--- a/arch/um/os-Linux/skas/Makefile
+++ b/tools/um/uml/skas/Build
@@ -3,8 +3,4 @@
 # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
 #
 
-obj-y := mem.o process.o
-
-USER_OBJS := $(obj-y)
-
-include arch/um/scripts/Makefile.rules
+liblinux-y += mem.o process.o
diff --git a/arch/um/os-Linux/skas/mem.c b/tools/um/uml/skas/mem.c
similarity index 100%
rename from arch/um/os-Linux/skas/mem.c
rename to tools/um/uml/skas/mem.c
diff --git a/arch/um/os-Linux/skas/process.c b/tools/um/uml/skas/process.c
similarity index 99%
rename from arch/um/os-Linux/skas/process.c
rename to tools/um/uml/skas/process.c
index 0621d521208e..0af44c2857b8 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/tools/um/uml/skas/process.c
@@ -21,7 +21,6 @@
 #include <registers.h>
 #include <skas.h>
 #include <sysdep/stub.h>
-#include <linux/threads.h>
 
 int is_skas_winch(int pid, int fd, void *data)
 {
@@ -248,7 +247,7 @@ static int userspace_tramp(void *stack)
 	return 0;
 }
 
-int userspace_pid[NR_CPUS];
+int userspace_pid[UM_NR_CPUS];
 
 /**
  * start_userspace() - prepare a new userspace process
diff --git a/arch/um/os-Linux/start_up.c b/tools/um/uml/start_up.c
similarity index 100%
rename from arch/um/os-Linux/start_up.c
rename to tools/um/uml/start_up.c
diff --git a/arch/um/os-Linux/time.c b/tools/um/uml/time.c
similarity index 100%
rename from arch/um/os-Linux/time.c
rename to tools/um/uml/time.c
diff --git a/arch/um/os-Linux/tty.c b/tools/um/uml/tty.c
similarity index 100%
rename from arch/um/os-Linux/tty.c
rename to tools/um/uml/tty.c
diff --git a/arch/um/os-Linux/umid.c b/tools/um/uml/umid.c
similarity index 100%
rename from arch/um/os-Linux/umid.c
rename to tools/um/uml/umid.c
diff --git a/arch/um/os-Linux/util.c b/tools/um/uml/util.c
similarity index 100%
rename from arch/um/os-Linux/util.c
rename to tools/um/uml/util.c
-- 
2.21.0 (Apple Git-122.2)

