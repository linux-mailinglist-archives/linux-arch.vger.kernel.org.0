Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5092FC7EB
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 03:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbhATC3h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 21:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbhATC2h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:28:37 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8F0C0613CF
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:27:57 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id o20so5152795pfu.0
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8aqEGe9gJjhgVO/J+ck8NrnG1w662lSG1QzQueg5EM=;
        b=n38oVFbTDAtQpg9YVz1/W03wYOIh3qoojjHAl/cKdtK58N87/b8uQGnfXAIGN7fvIN
         loh083K4cAUJlLzu9DZnWODJOe75f2dh7R49/uAVMF86sT9fu3ATpCnE6zxmo6UGEMXf
         XLwR2RdaFD6KUsRx+REnkDpMIGRZpQ4OrdZGIhr7+RER2GYNBxoLAQnqwQYm/7y2Cy9A
         XmZDzSQLcYFPbuVMZqKPz7DuBhb7zb29MI9rGCqozwY0W+B2mM+/35vlguLIde9SzvFc
         ZuCYbZQGUbGpLBkRgc14Dy9vCwElp0sEfoY4z33OANNTAztFdRLNUakhT2bgsQ6+beOK
         /A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8aqEGe9gJjhgVO/J+ck8NrnG1w662lSG1QzQueg5EM=;
        b=oCAMp7bjuc2ew2ALBjQuRZBKOV+nPF5kWmkAhTwuUAI2ClQDHQUPxxO3VYc3lsQ80d
         U0xvP2WhuMER0Gocdv8AwtaO6GKmrI+TDhMstylAv/p/EZHselduOUjrmnpjzc+tuR1h
         38N/rxcKAKd7K752Xa0626ys04NL7wF2E+bKAn1VKbzzic1jKwx/Uh+h2pSGJ0MINpP2
         2uir0dM/bEnzFPxZsL1WgKjI0aZOL1UJY16oalrKNvhbWiY2DGHwat3kar2RCkN/8ecU
         kKIKeZOjAZLD/W6jhkaCwzvoU1cQaUl8W7yrazaDGvL7wPyee4i3Cv9fPewrIWetRwt9
         q0sA==
X-Gm-Message-State: AOAM533+dSJqs+tjdQ6M5HFdNmyYa4mBeWm4V/IgncnijYrVpsaZAbRk
        XyrcoYWcg/qe0hi088FgEB0=
X-Google-Smtp-Source: ABdhPJw0MCbPizyYVdp8LoiO4E9/9yqD3thHhcx2tqltfUWNiaDAO3OBWdiXdKE4204qbEN8Zj0eCw==
X-Received: by 2002:a63:1f21:: with SMTP id f33mr7334001pgf.31.1611109676599;
        Tue, 19 Jan 2021 18:27:56 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id x14sm402272pfj.15.2021.01.19.18.27.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:27:56 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 28ACC20442D296; Wed, 20 Jan 2021 11:27:54 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 03/20] um: move arch/x86/um/os-Linux to tools/um/uml/
Date:   Wed, 20 Jan 2021 11:27:08 +0900
Message-Id: <04a14158366274d995d05910e4a4e8da5c73fce1.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
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
 tools/um/uml/Build                                  |  1 +
 tools/um/uml/x86/Build                              | 11 +++++++++++
 .../x86/um/os-Linux => tools/um/uml/x86}/mcontext.c |  0
 {arch/x86/um/os-Linux => tools/um/uml/x86}/prctl.c  |  0
 .../um/os-Linux => tools/um/uml/x86}/registers.c    |  0
 .../um/os-Linux => tools/um/uml/x86}/task_size.c    |  0
 {arch/x86/um/os-Linux => tools/um/uml/x86}/tls.c    |  0
 9 files changed, 13 insertions(+), 14 deletions(-)
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
diff --git a/tools/um/uml/Build b/tools/um/uml/Build
index 0e629c9cb8eb..810aa99f8409 100644
--- a/tools/um/uml/Build
+++ b/tools/um/uml/Build
@@ -14,6 +14,7 @@ liblinux-y += execvp.o file.o helper.o irq.o main.o mem.o process.o \
 
 CFLAGS_signal.o += -Wframe-larger-than=4096
 
+liblinux-y += x86/
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

