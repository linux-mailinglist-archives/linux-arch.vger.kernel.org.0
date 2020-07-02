Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF70721259A
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgGBOI3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgGBOI3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:08:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13462C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:08:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so12589221pjc.4
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47LI9gybmx8klq4KsxiEL3i23ye+Wbjeal49mNMq+js=;
        b=AWzZQvG4MRtry0t1te93bdGkzqH6Xe977oWWeJDN+hq6ZFo9aHG/kpmRoR9KE2spJs
         Sq1A/j19feHVxP/3G1xWXAn87r7/WutEeik88oHdNiysGTYR5ebFv2HG7z1XIQvH3j54
         fv5bLIJOlwue5ckNEksWda2CihqRmqLevQ6JluoVJcI8cwhx6CbOBUYk0IFIvdikBo9F
         JAOgcsnCu22PAuWkHTmPTR/w9CnrDeSdK9PKXB6IIJ7jm3tV0M7egBXwyAfrbk0VyEV6
         71aSPKp95rCE0AeJt9/Xfqcw2LHfTXOfntiMvm4IefmRm+boZJ8tMpKu66WGtwRFBmRa
         iGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47LI9gybmx8klq4KsxiEL3i23ye+Wbjeal49mNMq+js=;
        b=TBquP1uTwLZaHXSxpuiDizQ10N2TAff/q7zcyHAOfiN91TAu0KLPDse4IL47Bbsdar
         KoP9/tH0oV6micyiQ7mAYokdsw76UsTlrSZRaqOBCX5KaTq9IGBkPotip63GvoEPxtBO
         W1c6hvpv/MpRMrkiaaKTEPumJ/XloVZdR2sme6MQYoS2ISQQLn+59vYfcP9xyASTWC+d
         zLWSlmeONigrd8CEjh+0PHK/i5OX8fa9JOp15symKDh7vBt92bjHrSRLYbc0JTr1MKUq
         KNqCab3V6wZE1zHzwjh3kRzVIx3oY7xXAJAuJPSsuxhyA2x5v3FlUUpp5yY+v7Ci7HWx
         ntsw==
X-Gm-Message-State: AOAM533EAC4lRfPbqJObBaZZR8olzbuK4LeNAVhLIrgFMRmrNuxpYX13
        07qERO4HpKwn8oXPuwE1+fU=
X-Google-Smtp-Source: ABdhPJwBmwR03hlLcJDgrCbR2OqpECTZdspLy29IZ8k4jwL2ZXaY9xhvAGifD4own8o0Czi1LuAa+Q==
X-Received: by 2002:a17:902:778d:: with SMTP id o13mr25750038pll.247.1593698908494;
        Thu, 02 Jul 2020 07:08:28 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id g26sm6372324pfq.205.2020.07.02.07.08.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:08:27 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 94DF9202D31CFC; Thu,  2 Jul 2020 23:08:25 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 05/21] um: move arch/x86/um/os-Linux to tools/um/uml/
Date:   Thu,  2 Jul 2020 23:06:59 +0900
Message-Id: <92ac407875bfb718371ef95c40610ec1ed50ff32.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
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

