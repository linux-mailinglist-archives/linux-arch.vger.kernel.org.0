Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B11B276A4B
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgIXHOW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXHOV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:14:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9D2C0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:14:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so1352483pgf.5
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47LI9gybmx8klq4KsxiEL3i23ye+Wbjeal49mNMq+js=;
        b=PrbxtanWZPrk4/P4t4XJcH42p58dhbzoAcZRrVniRvWo1M+gjwsxwzquEn0tMN/32B
         KEIDzBM3FZq4hse4PIK+Cuvpg/UOMiNLCtB1un7p/dq26GyZhhTFp0Yg75cULR1wpSJU
         4PuQ/u2/Z8LO1+lX/7jXMEE0+G+KXFTsvmDcupI6W+gaApZSzMupNHblnKNaUy9DpbT/
         wEju4Rug80kKWEL+ctonQqvXQUIm7+Nlg2ySviUOGzLgHPpm9qwbn5jY7Tkur5ZjFXkC
         B5zYYvNmTXY5uvLZNNu7pGzT16+gxcEaLl1aJFC8ebO+LVRbz3L5dX5fXcgwlx3UGWz+
         kTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47LI9gybmx8klq4KsxiEL3i23ye+Wbjeal49mNMq+js=;
        b=YFSaP4ShVykc6+V90uqLnoqMCZrKDHEfKRg4sjZir5aAr10aYsx4Gg8O8UsmjuUuIZ
         zg947Sb9vuEQixVR9l4/Vi/GuZpmnIxWNKYr4ZP72TsWF1L5EHuqVebvODA3SWmgURUW
         8wos8lwyGWIdYKxSR3F5JLTMGdLXnk7QhE7alz5nmjSkLSQQCFjlnD4qBK/q31JFELW3
         ftn7lfv3LcFUhfURTod/B5z10Xz61RzEBwH0UiGcsblyulOrk8VUOkIUmw4adh9Jw9jt
         Kt07O7NHOZDq4n7vORNSPuZdesRLDPPQsOiEnDUAzAE9L6r2Te9HGnHPQR3EeI7B6ZEg
         FHFg==
X-Gm-Message-State: AOAM530/xPv6U/6uwtICaWW5afQdZetsRTE+bPIWqYr1O/RnuC845IDq
        gbtrrHTitmNo7hoA1kb/45Q=
X-Google-Smtp-Source: ABdhPJzrCV7ckpkPuk3w1HYurznDoZxodAv8mOknAH184zS7pQyap2xs79T9r19ifBD5dV4iFRdCeg==
X-Received: by 2002:a63:b44f:: with SMTP id n15mr2907772pgu.282.1600931661297;
        Thu, 24 Sep 2020 00:14:21 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id z1sm1687528pgu.80.2020.09.24.00.14.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:14:20 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 8273D2037C204E; Thu, 24 Sep 2020 16:14:18 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v6 05/21] um: move arch/x86/um/os-Linux to tools/um/uml/
Date:   Thu, 24 Sep 2020 16:12:45 +0900
Message-Id: <3e7c2da8fc1ad973d4b1df0a770e8ccfc75e45a6.1600922528.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Similar to arch/um/os-Linux code, arch/x86 also contains OS dependent
part as well.  This patch moves underlying OS dependent part to tools/um
directory so that arch/x86 code does not need to build host build
facilities (e.g., libc).

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/x86/um/Makefile                                |  2 +-
 arch/x86/um/os-Linux/Makefile                       | 13 -------------
 tools/um/Makefile                                   |  2 +-
 tools/um/uml/Build                                  |  2 ++
 tools/um/uml/x86/Build                              | 11 +++++++++++
 .../x86/um/os-Linux => tools/um/uml/x86}/mcontext.c |  0
 {arch/x86/um/os-Linux => tools/um/uml/x86}/prctl.c  |  0
 .../um/os-Linux => tools/um/uml/x86}/registers.c    |  0
 .../um/os-Linux => tools/um/uml/x86}/task_size.c    |  0
 {arch/x86/um/os-Linux => tools/um/uml/x86}/tls.c    |  0
 10 files changed, 15 insertions(+), 15 deletions(-)
 delete mode 100644 arch/x86/um/os-Linux/Makefile
 create mode 100644 tools/um/uml/x86/Build
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/mcontext.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/prctl.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/registers.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/task_size.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/tls.c (100%)

diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 77f70b969d14..25e9846b36a2 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -13,7 +13,7 @@ obj-y = bugs_$(BITS).o delay.o fault.o ldt.o \
 	ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
 	stub_$(BITS).o stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
-	mem_$(BITS).o subarch.o os-$(OS)/
+	mem_$(BITS).o subarch.o
 
 ifeq ($(CONFIG_X86_32),y)
 
diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
deleted file mode 100644
index 253bfb8cb702..000000000000
--- a/arch/x86/um/os-Linux/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
-# Licensed under the GPL
-#
-
-obj-y = registers.o task_size.o mcontext.o
-
-obj-$(CONFIG_X86_32) += tls.o
-obj-$(CONFIG_64BIT) += prctl.o
-
-USER_OBJS := $(obj-y)
-
-include arch/um/scripts/Makefile.rules
diff --git a/tools/um/Makefile b/tools/um/Makefile
index 07b9b93ed817..552ed5f1edae 100644
--- a/tools/um/Makefile
+++ b/tools/um/Makefile
@@ -61,7 +61,7 @@ $(OUTPUT)%-in.o: FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
 
 # rule to build objects
-$(OUTPUT)%-in.o: $(OUTPUT)lib/linux.o
+$(OUTPUT)%-in.o: $(OUTPUT)lib/linux.o FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
 
 clean:
diff --git a/tools/um/uml/Build b/tools/um/uml/Build
index 8e0607ee8b0a..435a9670d3ff 100644
--- a/tools/um/uml/Build
+++ b/tools/um/uml/Build
@@ -12,6 +12,8 @@ liblinux-y += execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
 	umid.o user_syms.o util.o drivers/ skas/
 
+liblinux-y += x86/
+
 liblinux-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
 export O = $(srctree)
diff --git a/tools/um/uml/x86/Build b/tools/um/uml/x86/Build
new file mode 100644
index 000000000000..16bbc7eb19d1
--- /dev/null
+++ b/tools/um/uml/x86/Build
@@ -0,0 +1,11 @@
+#
+# Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+# Licensed under the GPL
+#
+
+include $(objtree)/include/config/auto.conf
+
+liblinux-y = registers.o task_size.o mcontext.o
+
+liblinux-$(CONFIG_X86_32) += tls.o
+liblinux-$(CONFIG_64BIT) += prctl.o
diff --git a/arch/x86/um/os-Linux/mcontext.c b/tools/um/uml/x86/mcontext.c
similarity index 100%
rename from arch/x86/um/os-Linux/mcontext.c
rename to tools/um/uml/x86/mcontext.c
diff --git a/arch/x86/um/os-Linux/prctl.c b/tools/um/uml/x86/prctl.c
similarity index 100%
rename from arch/x86/um/os-Linux/prctl.c
rename to tools/um/uml/x86/prctl.c
diff --git a/arch/x86/um/os-Linux/registers.c b/tools/um/uml/x86/registers.c
similarity index 100%
rename from arch/x86/um/os-Linux/registers.c
rename to tools/um/uml/x86/registers.c
diff --git a/arch/x86/um/os-Linux/task_size.c b/tools/um/uml/x86/task_size.c
similarity index 100%
rename from arch/x86/um/os-Linux/task_size.c
rename to tools/um/uml/x86/task_size.c
diff --git a/arch/x86/um/os-Linux/tls.c b/tools/um/uml/x86/tls.c
similarity index 100%
rename from arch/x86/um/os-Linux/tls.c
rename to tools/um/uml/x86/tls.c
-- 
2.21.0 (Apple Git-122.2)

