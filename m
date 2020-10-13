Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4F28C5CE
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgJMAcX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgJMAcQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:32:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6403C0613D0
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u35so18965950ybd.13
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oNoCiComLTOHVg2bP6STufgWA9yaYfJ6ObCLDl+jrho=;
        b=iWb8IMXO138pO3VxQeiLtRHBFKLEZX34wfy/I5tnQOY8tAz+5KN10zF+c5wKc0NGf9
         V81W5t0kz8+T12z9fdWu+sNnGkAeOhHE8X9D+RroweYzMnASv3Hwpkndl/8bioQpHZUz
         mX+LtD994yaPGz2JhGYYCZ77UH77NBl51OSJVt2PNtGh/uJ/Id01J2GrYmku+3i3+EME
         0RSLPnMFIoJMJWfen1rEiGkUdPfD4MN+VkmyC3f7ZHxJqifMISzpW0Ypub7BPOfBxhkE
         v+NEFC6Ds2T1GWHGqFR6HDQWg9+W5tlsLsaS1VukIHrqKwvMN5C/M7+MuFGvKKyjBneT
         I2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oNoCiComLTOHVg2bP6STufgWA9yaYfJ6ObCLDl+jrho=;
        b=FaNXdDdD6IqdtZ8GAjxkA3Z/yuby9Epec2/e8QSXprcvFeY5pyd7iTrVHJ2rFzPHCZ
         SlIz+bycTVfcPISC5XI/+QDJJVYXBh4whY0tRYd1c+frYbzNBIZSpKYqJREa45hiQLbL
         4J4u3WgRPg4O0Ryfrt0SX5RnaewZSCoHJxKS8zwDK67U0VSDg96i39fzKQe89BfyIOGG
         qf+s8UWTtI0AFTH540/OEBz8pJCbAML2df9/S5e+6DMBOeHmtlfIw80WMicTaGJsUo9f
         Na8pVVSKLVy2KVgKk/PIJ0cBSIxnDsEFDlWUPEbxnuT66cF8p7zjpwh5EvtUd/j5F3Z+
         LwuQ==
X-Gm-Message-State: AOAM5324jIee0eBvgP6lqztW1vLaKMTWBiJZMbXKoChFkjxkoBnay/iJ
        N8UyFPWoS6YdsCoZBmCNVQR/D/1zkqYaUMx3B1U=
X-Google-Smtp-Source: ABdhPJwwb1BOagS9KB2HJy67TJEwj+dNfREWLJyGXBWcLbfd0WCh9RIc4B6fwHPAmc6V1LYLv5oY+bdj39+DqlbHxJM=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:a4e1:: with SMTP id
 g88mr11556641ybi.267.1602549135037; Mon, 12 Oct 2020 17:32:15 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:43 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 05/25] tracing: add support for objtool mcount
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

This change adds build support for using objtool to generate
__mcount_loc sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile               | 12 ++++++++++--
 kernel/trace/Kconfig   | 13 +++++++++++++
 scripts/Makefile.build |  3 +++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 129001b38357..fda1f8a0b1c7 100644
--- a/Makefile
+++ b/Makefile
@@ -850,6 +850,9 @@ ifdef CONFIG_FTRACE_MCOUNT_USE_CC
     endif
   endif
 endif
+ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
+  CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT
+endif
 ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
   ifdef CONFIG_HAVE_C_RECORDMCOUNT
     BUILD_C_RECORDMCOUNT := y
@@ -1209,11 +1212,16 @@ uapi-asm-generic:
 PHONY += prepare-objtool prepare-resolve_btfids
 prepare-objtool: $(objtool_target)
 ifeq ($(SKIP_STACK_VALIDATION),1)
+objtool-lib-prompt := "please install libelf-dev, libelf-devel or elfutils-libelf-devel"
+ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
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
index 927ad004888a..89263210ab26 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -51,6 +51,11 @@ config HAVE_NOP_MCOUNT
 	help
 	  Arch supports the gcc options -pg with -mrecord-mcount and -nop-mcount
 
+config HAVE_OBJTOOL_MCOUNT
+	bool
+	help
+	  Arch supports objtool --mcount
+
 config HAVE_C_RECORDMCOUNT
 	bool
 	help
@@ -605,10 +610,18 @@ config FTRACE_MCOUNT_USE_CC
 	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
 	depends on FTRACE_MCOUNT_RECORD
 
+config FTRACE_MCOUNT_USE_OBJTOOL
+	def_bool y
+	depends on HAVE_OBJTOOL_MCOUNT
+	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
+	depends on !FTRACE_MCOUNT_USE_CC
+	depends on FTRACE_MCOUNT_RECORD
+
 config FTRACE_MCOUNT_USE_RECORDMCOUNT
 	def_bool y
 	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
 	depends on !FTRACE_MCOUNT_USE_CC
+	depends on !FTRACE_MCOUNT_USE_OBJTOOL
 	depends on FTRACE_MCOUNT_RECORD
 
 config TRACING_MAP
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a4634aae1506..cd4294435fef 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -228,6 +228,9 @@ endif
 ifdef CONFIG_X86_SMAP
   objtool_args += --uaccess
 endif
+ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
+  objtool_args += --mcount
+endif
 
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
-- 
2.28.0.1011.ga647a8990f-goog

