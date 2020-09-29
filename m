Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF62427DAC7
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgI2Vqt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgI2Vqs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 17:46:48 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55016C0613DD
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:46:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 11so4547919pjh.5
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8Ng/zcoyfJ13YZKcoMDN8gZ1Jwe/pnq5fe0Ym5zenVI=;
        b=hJ2k1cYf7zI4meIHY8Uy4V6i8Jnw5zJ6gXSyG4ZS4WtWOLM04fL9+GCHaotwi3O1kD
         kTLYoVlgy7SsG3U4K1msUNtcb16oxXKr4/TQFI7s6Q8/WGPkSRsFDD2GxMPhFHntnEX1
         UqTAPnS+KdKGfOUHgSFQg4QyFtojd9IFM7aswALGg98Bion2yPHSsVlFOMvPOBbcGHRk
         x3eWkDC4MtkEKlr4m7hj4fkr/DRZ/f28+ZAVK6+8KyG71dVLNRRAWvoDBDJaCjYjg2Ib
         8nETBKgc3yK1LXOEVRu7drktVSLFory2Vrh/6aBQG6OWMUgiL14xdAH2/sO39VNUdeVj
         iuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8Ng/zcoyfJ13YZKcoMDN8gZ1Jwe/pnq5fe0Ym5zenVI=;
        b=E2EtQq/ejQ4SzhD06L1TmqWsnkseeBSb0xdPwbHDDFec2ny70hpyXP9jHOiK9tPJq5
         kSUEOIEhAjJVkDT5R9NYc73HMe7LzlXUX0kqUcSlwA+1VL6ZpAJIzshW9LAHq1zP83Ev
         pfB5qVYgR0LTXb4ISM9ED42ri/WSLHGdnYn8um8mv66/qGnJVMx9KVsaCngOXm5EOXXe
         BEJK+lmm4fNZpyppq2CxAqPK42z33sjZ3nJWRfTzvOxr6Wg5jQmEY3RhtR0SZsXWDghw
         HqZIFjKYXCMsJh8PXbMyIIx/wsn/BEfm705DZwDwbnKs0X0md+kpfM7b8XRj85GmUS8S
         y3aQ==
X-Gm-Message-State: AOAM530+c4FthIf5aPMSewayvyuLzb4so5nDMkX6lA+xOF+fbCTTXfdq
        yEVkEw/0SSWtd4q01Y8eyEjzGAjYgEYTvYcw8BY=
X-Google-Smtp-Source: ABdhPJxzUBWB0iwbH+cTGbJh9C57bW3bzJzflC/e22W7CVuaBq659lObOSZcWl0sKiYtAxO7YlDpc2NeS2tp52Yay5g=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a62:8607:0:b029:13f:b379:480a with
 SMTP id x7-20020a6286070000b029013fb379480amr5736037pfd.5.1601416004713; Tue,
 29 Sep 2020 14:46:44 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:08 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 06/29] tracing: move function tracer options to Kconfig
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move function tracer options to Kconfig to make it easier to add
new methods for generating __mcount_loc, and to make the options
available also when building kernel modules.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile               | 20 ++++++++------------
 kernel/trace/Kconfig   | 16 ++++++++++++++++
 scripts/Makefile.build |  6 ++----
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 476f19ccac17..77e4f0a9495e 100644
--- a/Makefile
+++ b/Makefile
@@ -841,12 +841,8 @@ KBUILD_CFLAGS += $(DEBUG_CFLAGS)
 export DEBUG_CFLAGS
 
 ifdef CONFIG_FUNCTION_TRACER
-ifdef CONFIG_FTRACE_MCOUNT_RECORD
-  # gcc 5 supports generating the mcount tables directly
-  ifeq ($(call cc-option-yn,-mrecord-mcount),y)
-    CC_FLAGS_FTRACE	+= -mrecord-mcount
-    export CC_USING_RECORD_MCOUNT := 1
-  endif
+ifdef CONFIG_FTRACE_MCOUNT_USE_CC
+  CC_FLAGS_FTRACE	+= -mrecord-mcount
   ifdef CONFIG_HAVE_NOP_MCOUNT
     ifeq ($(call cc-option-yn, -mnop-mcount),y)
       CC_FLAGS_FTRACE	+= -mnop-mcount
@@ -854,6 +850,12 @@ ifdef CONFIG_FTRACE_MCOUNT_RECORD
     endif
   endif
 endif
+ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
+  ifdef CONFIG_HAVE_C_RECORDMCOUNT
+    BUILD_C_RECORDMCOUNT := y
+    export BUILD_C_RECORDMCOUNT
+  endif
+endif
 ifdef CONFIG_HAVE_FENTRY
   ifeq ($(call cc-option-yn, -mfentry),y)
     CC_FLAGS_FTRACE	+= -mfentry
@@ -863,12 +865,6 @@ endif
 export CC_FLAGS_FTRACE
 KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
 KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
-ifdef CONFIG_DYNAMIC_FTRACE
-	ifdef CONFIG_HAVE_C_RECORDMCOUNT
-		BUILD_C_RECORDMCOUNT := y
-		export BUILD_C_RECORDMCOUNT
-	endif
-endif
 endif
 
 # We trigger additional mismatches with less inlining
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a4020c0b4508..927ad004888a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -595,6 +595,22 @@ config FTRACE_MCOUNT_RECORD
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_FTRACE_MCOUNT_RECORD
 
+config FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
+	bool
+	depends on FTRACE_MCOUNT_RECORD
+
+config FTRACE_MCOUNT_USE_CC
+	def_bool y
+	depends on $(cc-option,-mrecord-mcount)
+	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
+	depends on FTRACE_MCOUNT_RECORD
+
+config FTRACE_MCOUNT_USE_RECORDMCOUNT
+	def_bool y
+	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
+	depends on !FTRACE_MCOUNT_USE_CC
+	depends on FTRACE_MCOUNT_RECORD
+
 config TRACING_MAP
 	bool
 	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a467b9323442..a4634aae1506 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -178,8 +178,7 @@ cmd_modversions_c =								\
 	fi
 endif
 
-ifdef CONFIG_FTRACE_MCOUNT_RECORD
-ifndef CC_USING_RECORD_MCOUNT
+ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 # compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
@@ -206,8 +205,7 @@ recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
 cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
 	$(sub_cmd_record_mcount))
-endif # CC_USING_RECORD_MCOUNT
-endif # CONFIG_FTRACE_MCOUNT_RECORD
+endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 
 ifdef CONFIG_STACK_VALIDATION
 ifneq ($(SKIP_STACK_VALIDATION),1)
-- 
2.28.0.709.gb0816b6eb0-goog

