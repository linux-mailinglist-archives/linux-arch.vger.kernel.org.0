Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE425CB27
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 22:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgICUiu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 16:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbgICUbb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 16:31:31 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CB4C0619C2
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 13:31:10 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q131so2279880qke.22
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/qNzjrcyr5XKcvklD+GZQa7NZ7u6sAXpUN3H65DCv0U=;
        b=Zsq/hG7XAc4mwLU8SBGtWoXCI16CctA7+BH9jQ5VxbO2BJLbC+6FgawBmmjPDrNYD8
         kYLK4S5KB9WCwaWGEcaOIDi92B0t9YROgAR/TDbV9fyw9yUJywcMexGdaF/1Iwzs87ZN
         NRQu9/IzlFlx6ERBgUteP3jl1xRfP2aHL3vambh4FSyiWOPQ6kASPXKbYhq6mT/8+sQT
         7HGqm6vlRwjCG/BIjNDm/J4yDrq8EuBzLQ4kU3eF1t1Td0NzBQonQSn7fXs/MlQq/w9q
         bJE+U0yfjLtcw9rAdKYYQuiPZeaAtpfle/Ztssg3jka5z8KkzkRqxF5j/+zMpJAKxxfR
         InPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/qNzjrcyr5XKcvklD+GZQa7NZ7u6sAXpUN3H65DCv0U=;
        b=MbNYfXLcmtJpZVgTWdkouVbTkJevA3nGLBGx6D+QTVr9svtf9g2gpNBiMK/O5fJzM2
         /wuRBKXvv+6UYx0H3WkowITTRWGHPY11QOdtLf53mcxiVP2NymY3+RKpgPw9u8Hy+V8z
         O56ir8qMcB633r0u2pw5EmEVimaYLNurYKQBZsQiAYzeQAE1VCP4m3LaXWM2Bb5fboD0
         TaQnMMU8Dsx5n5zBP+a45M+GGTnzSpvJmPIRf+jzlkvT4MOwWzCQYpi/mGbe8sXhkc3o
         AXjnm52qCK+WIuWhoa/9xdkgWIxIl9Q/NsfES0Yu3HN5A7NJL048XosaPJkrBAETOpao
         d2mg==
X-Gm-Message-State: AOAM532TattmkkHMgrHVtx6gXpWz1Rlg77V/H7ChCMNVHNHUDYY3Ju9d
        Fqk+yp5+kxNC1ji0fj2xdffiCeuNgqbMwoEjyYM=
X-Google-Smtp-Source: ABdhPJyLRS5zhOlsTPIghggsBo02eHCvGWDIp2OJgb326kojzCylZPPrFhxZrtPlMoRBECX9OwEwfr6KBZ+bjrldyC0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:ca87:: with SMTP id
 a7mr4619179qvk.17.1599165069140; Thu, 03 Sep 2020 13:31:09 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:32 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 07/28] kbuild: add support for objtool mcount
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This change adds build support for using objtool to generate
__mcount_loc sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile               | 38 ++++++++++++++++++++++++++++++--------
 kernel/trace/Kconfig   |  5 +++++
 scripts/Makefile.build |  9 +++++----
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index ff5e0731d26d..a9dae26c93b5 100644
--- a/Makefile
+++ b/Makefile
@@ -859,17 +859,34 @@ ifdef CONFIG_HAVE_FENTRY
   ifeq ($(call cc-option-yn, -mfentry),y)
     CC_FLAGS_FTRACE	+= -mfentry
     CC_FLAGS_USING	+= -DCC_USING_FENTRY
+    export CC_USING_FENTRY := 1
   endif
 endif
 export CC_FLAGS_FTRACE
-KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
-KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 ifdef CONFIG_DYNAMIC_FTRACE
-	ifdef CONFIG_HAVE_C_RECORDMCOUNT
-		BUILD_C_RECORDMCOUNT := y
-		export BUILD_C_RECORDMCOUNT
-	endif
+  ifndef CC_USING_RECORD_MCOUNT
+  ifndef CC_USING_PATCHABLE_FUNCTION_ENTRY
+    # use objtool or recordmcount to generate mcount tables
+    ifdef CONFIG_HAVE_OBJTOOL_MCOUNT
+      ifdef CC_USING_FENTRY
+        USE_OBJTOOL_MCOUNT := y
+        CC_FLAGS_USING += -DCC_USING_NOP_MCOUNT
+        export USE_OBJTOOL_MCOUNT
+      endif
+    endif
+    ifndef USE_OBJTOOL_MCOUNT
+      USE_RECORDMCOUNT := y
+      export USE_RECORDMCOUNT
+      ifdef CONFIG_HAVE_C_RECORDMCOUNT
+        BUILD_C_RECORDMCOUNT := y
+        export BUILD_C_RECORDMCOUNT
+      endif
+    endif
+  endif
+  endif
 endif
+KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
+KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 endif
 
 # We trigger additional mismatches with less inlining
@@ -1218,11 +1235,16 @@ uapi-asm-generic:
 PHONY += prepare-objtool prepare-resolve_btfids
 prepare-objtool: $(objtool_target)
 ifeq ($(SKIP_STACK_VALIDATION),1)
+objtool-lib-prompt := "please install libelf-dev, libelf-devel or elfutils-libelf-devel"
+ifdef USE_OBJTOOL_MCOUNT
+	@echo "error: Cannot generate __mcount_loc for CONFIG_DYNAMIC_FTRACE=y, $(objtool-lib-prompt)" >&2
+	@false
+endif
 ifdef CONFIG_UNWINDER_ORC
-	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, $(objtool-lib-prompt)" >&2
 	@false
 else
-	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, $(objtool-lib-prompt)" >&2
 endif
 endif
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a4020c0b4508..b510af5b216c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -56,6 +56,11 @@ config HAVE_C_RECORDMCOUNT
 	help
 	  C version of recordmcount available?
 
+config HAVE_OBJTOOL_MCOUNT
+	bool
+	help
+	  Arch supports objtool --mcount
+
 config TRACER_MAX_TRACE
 	bool
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a467b9323442..6ecf30c70ced 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -178,8 +178,7 @@ cmd_modversions_c =								\
 	fi
 endif
 
-ifdef CONFIG_FTRACE_MCOUNT_RECORD
-ifndef CC_USING_RECORD_MCOUNT
+ifdef USE_RECORDMCOUNT
 # compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
@@ -206,8 +205,7 @@ recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
 cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
 	$(sub_cmd_record_mcount))
-endif # CC_USING_RECORD_MCOUNT
-endif # CONFIG_FTRACE_MCOUNT_RECORD
+endif # USE_RECORDMCOUNT
 
 ifdef CONFIG_STACK_VALIDATION
 ifneq ($(SKIP_STACK_VALIDATION),1)
@@ -230,6 +228,9 @@ endif
 ifdef CONFIG_X86_SMAP
   objtool_args += --uaccess
 endif
+ifdef USE_OBJTOOL_MCOUNT
+  objtool_args += --mcount
+endif
 
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
-- 
2.28.0.402.g5ffc5be6b7-goog

