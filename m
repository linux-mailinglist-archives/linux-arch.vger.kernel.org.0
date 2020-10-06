Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BFF28498B
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJFJpH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFJpH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:45:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B88C061755
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:45:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ds1so1285552pjb.5
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DMse0UzGBpJqoUxXkdntnZooTtifnfEs1Etpb6Q6goM=;
        b=NpXv3LC62Iq797FCqzFDJZqx+Y7SZVmnCkBwPbTDdQsQXYNwONdBfZprbRIueW9vG0
         gqzoNDPSfyboeuGJ5lsO5WLAs5Af6ub4IgrIrc9nwVD5hE5qc2uwiW2b5Zv4se5DJEfF
         Tpdut/BeWGn+ca5lYGNgEwhqfsqffp9kWZQqitcfSkk7jn8dgFPNwW+lv3oG3TPL7Xa1
         cmeOiDl36XKdhXo5WfkMuHbNe/sdBc0ax6+S4ALVtdE729IWeAThmmBLqelrEVDLYhrf
         WCnhQcAKHnbqh6n5b+FINHIABRIvh8lPjJspuLA0lEG/zCnf6yrXahZvpBVsYlmI1/o1
         TeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMse0UzGBpJqoUxXkdntnZooTtifnfEs1Etpb6Q6goM=;
        b=pRMtJxj6r9Lm21uXLhZgb5TkNN8YH5iyyyGzVbzms+bcydtSqMfYdd4zbHSrNWyqLt
         uQvbovp5jmWHMQjo1BWbIGBp3iS2cosJsYqKUHX3Ms1qNH2K/cyczUj6JpovI0bLtGcj
         K3L79ZbL6vMbTXHK8tSMi4j+Ygs8b8Irqz/IZnUbtaEV5d+svOUa45yYixUN/crYOmrM
         ivcSQpUWfaafAyxCE3cH3mActohpmIctq2NUs5DS9DloNpBmrvPwM0crt3FQYQR6XVT2
         /vNvXf+Sev7SkgMPi+tvSj7cHIFK2/2RF+WJp0M5s2w+QWUrGVzqk2rCW1KGL4J5nTvB
         rUDA==
X-Gm-Message-State: AOAM533nHo2zDtn94bvOCXdJnpSbAFbhHNJo/e101qfK1HVHf/CYbju7
        ucUcX05yt2UKT/32BVhm7Lg=
X-Google-Smtp-Source: ABdhPJxzR0Yh20SXsM4Nf/OPHvOVwNzQoTtTUjJ0MGRmjs59lSfUsSCoIzok/2pS2tZgY5zh2Lws1Q==
X-Received: by 2002:a17:902:b7c7:b029:d3:c9df:f268 with SMTP id v7-20020a170902b7c7b02900d3c9dff268mr2431339plz.56.1601977506523;
        Tue, 06 Oct 2020 02:45:06 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id hk17sm1919851pjb.14.2020.10.06.02.45.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:45:05 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 930E220390F49D; Tue,  6 Oct 2020 18:45:03 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 05/21] um: move arch/x86/um/os-Linux to tools/um/uml/
Date:   Tue,  6 Oct 2020 18:44:14 +0900
Message-Id: <451a47b488766c4bc67d69dacff3d6dbc01d0843.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
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
index ad93c6ad51fc..0d87d601bc06 100644
--- a/tools/um/uml/Build
+++ b/tools/um/uml/Build
@@ -12,6 +12,8 @@ liblinux-y += execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
 	umid.o util.o drivers/ skas/
 
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

