Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92B7276A46
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgIXHOA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXHOA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:14:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3914C0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:14:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o25so1370290pgm.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V39OSq8BYtEwCP/WlLr+fNgdgKv2eYc9I6KQ+MlDE8I=;
        b=oGivdU6AJxfNAcYQJD30qCYP+6+l5dPXyiebKfpaEskk6ln0rmNkxnoaHPAT9oULpg
         aiLoInIhal68QrzMYpkTSu/U5mlnpydtytqu4rBHHyiVvqhQ1rQ7WigE8FHPSkIJAfOF
         psezfVmRvsbC6ZsSN6hQjlG1iTzwmRsVLfovFn65MdNG3pubhxExTJN2Isjhj/rCf6OY
         2+mcJ4zmTOienRiwCpRmnDxLd1U4meSMmPud+j54chfbQDhtGuNNKTprc7DuE7EMmuOP
         bgzICGJsPOa6KCFrwuZOLN0XvDbxwMbab7+N+mgbl28DQx0tijG7s9kF4VYLdeF5UsIA
         9pWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V39OSq8BYtEwCP/WlLr+fNgdgKv2eYc9I6KQ+MlDE8I=;
        b=aVq47ZyAu+xkkUaERALnFi2DODgNpPCXwsl75yNFjRNUSO+ZrAhZPR2r0n7dStow2A
         kgiiP3Ph4qrwZRqXuzF8ZjXNRoOP90qcDliQ5mMt89ldZbiUh9YmZA7NqKR9gNCTZ0Iq
         7IK3GOExREqQfUOGoAyZ+wV/bpy/LAjWUBpVxGiUIJyTkervnL1iUJBxZgStJbi6v2q2
         AJgc8cIEs1PYZRRvxt8AJAMdxDyEpmpARU6bMGPCI6ete+ULKhfmqloxO8T3mEmWFDG7
         KWPnfYD8ugX5qi77N1e4tv2kP8j9rGtb+XaW/9tNZTo76NG6AwUieAwxb9sQD5TXwGaj
         22Yg==
X-Gm-Message-State: AOAM530+ZdISiSr48ZDHB0Ho5e2/r+910IOP04rnbLI0q1cXWJ1JyU3l
        SXkhtGLbwU6dZfA1yKAzsUw=
X-Google-Smtp-Source: ABdhPJwIRzRaurRWjMgy0EBoDbqpmJStrS/2eT7p2204Qd9z59AnjorNZ84PD1CP/l9mH7L7DXhg0A==
X-Received: by 2002:a62:52d3:0:b029:142:2501:3a00 with SMTP id g202-20020a6252d30000b029014225013a00mr3188378pfb.79.1600931639900;
        Thu, 24 Sep 2020 00:13:59 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id r16sm1416899pjo.19.2020.09.24.00.13.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:13:59 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id C7B392037C2035; Thu, 24 Sep 2020 16:13:56 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v6 03/21] um: move arch/um/os-Linux dir to tools/um/uml
Date:   Thu, 24 Sep 2020 16:12:43 +0900
Message-Id: <364a2fc126e5d3035e6968c339aa04944614405d.1600922528.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
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
 arch/um/os-Linux/Makefile                     | 19 --------
 arch/um/os-Linux/drivers/Makefile             | 13 -----
 tools/um/Makefile                             |  6 ++-
 tools/um/uml/Build                            | 48 +++++++++++++++++++
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
 .../um/os-Linux => tools/um/uml}/user_syms.c  |  1 +
 {arch/um/os-Linux => tools/um/uml}/util.c     |  0
 34 files changed, 74 insertions(+), 46 deletions(-)
 rename arch/um/{os-Linux => }/drivers/ethertap_kern.c (100%)
 rename arch/um/{os-Linux => }/drivers/tuntap_kern.c (100%)
 rename arch/um/{os-Linux/drivers => include/shared}/etap.h (100%)
 rename arch/um/{os-Linux/drivers => include/shared}/tuntap.h (100%)
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
 rename {arch/um/os-Linux => tools/um/uml}/user_syms.c (99%)
 rename {arch/um/os-Linux => tools/um/uml}/util.c (100%)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index fdfaff4633e8..1f958a9280fe 100644
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
index d09308330ca5..305789667584 100644
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
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
deleted file mode 100644
index 839915b8c31c..000000000000
--- a/arch/um/os-Linux/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
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
index a63466ef7ef5..07b9b93ed817 100644
--- a/tools/um/Makefile
+++ b/tools/um/Makefile
@@ -50,7 +50,7 @@ $(OUTPUT)lib/linux.o:
 	$(Q)CFLAGS= $(MAKE) -C ../.. ARCH=um $(KOPT) $(KCONFIG)
 	$(Q)CFLAGS= $(MAKE) -C ../.. ARCH=um $(KOPT) install INSTALL_PATH=$(OUTPUT)
 
-$(OUTPUT)liblinux.a: $(OUTPUT)lib/linux.o $(OUTPUT)uml/liblinux-in.o
+$(OUTPUT)liblinux.a: $(OUTPUT)lib/linux.o $(OUTPUT)uml/liblinux-in.o $(OUTPUT)lib/liblinux-in.o
 	$(QUIET_AR)$(AR) -rc $@ $^
 
 # rule to link programs
@@ -60,6 +60,10 @@ $(OUTPUT)%: $(OUTPUT)%-in.o $(OUTPUT)liblinux.a
 $(OUTPUT)%-in.o: FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
 
+# rule to build objects
+$(OUTPUT)%-in.o: $(OUTPUT)lib/linux.o
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
+
 clean:
 	$(call QUIET_CLEAN, objects)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd'\
 	 -delete -o -name '\.*.d' -delete
diff --git a/tools/um/uml/Build b/tools/um/uml/Build
index e69de29bb2d1..8e0607ee8b0a 100644
--- a/tools/um/uml/Build
+++ b/tools/um/uml/Build
@@ -0,0 +1,48 @@
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
+	umid.o user_syms.o util.o drivers/ skas/
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
index 4fb877b99dde..fca6a08e81bd 100644
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
diff --git a/arch/um/os-Linux/user_syms.c b/tools/um/uml/user_syms.c
similarity index 99%
rename from arch/um/os-Linux/user_syms.c
rename to tools/um/uml/user_syms.c
index 715594fe5719..4047fd7bfdb7 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/tools/um/uml/user_syms.c
@@ -13,6 +13,7 @@
 #undef strstr
 #undef memcpy
 #undef memset
+#define EXPORT_SYMBOL(x)
 
 extern size_t strlen(const char *);
 extern void *memmove(void *, const void *, size_t);
diff --git a/arch/um/os-Linux/util.c b/tools/um/uml/util.c
similarity index 100%
rename from arch/um/os-Linux/util.c
rename to tools/um/uml/util.c
-- 
2.21.0 (Apple Git-122.2)

