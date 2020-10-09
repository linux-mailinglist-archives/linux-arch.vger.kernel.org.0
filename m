Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14620288E7A
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbgJIQQC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389676AbgJIQNw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:13:52 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E721C0613DB
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:13:52 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id y24so6635389plr.20
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fZ3RySPWXLEyLlwdfUBpRpGrz5rbV/kevtEX3k0sv+Y=;
        b=h0+iMSN91xyn7Dij5lJ5UbfgKe5O3aXq0nghcYk8xVnglIOCrQqxOVA8AUxH1ox9lY
         S643yCM1/EupRGz2gOHgxQ/5gvY/herznEKaLgVjp1sIBiDgFItKoMQtTvQvf2UU/zqV
         5ztVLJloZBfDrTzUMvL5OeXrDhFdMnPJ4FhTwo35ts/tnx/zpGiS8axwHCdHChiAsy5u
         YA3wPTak4Usradm7+BsNh1Hj45M6+dloyt70hARr+Abgvw4m8BW58l6uHGxwH+KxmDG8
         kcIGcr+ag1qz/bDFIAXEhS+n1UiFqbFQj74/EllM5dvSE2qM7vf+EsUuLM6wi2vT8Gc2
         syxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fZ3RySPWXLEyLlwdfUBpRpGrz5rbV/kevtEX3k0sv+Y=;
        b=tpYyWMwUoU6WpT3XQ5dNq+IPykljvzAElFlSYaVikuEob8v3FwBpIYYg772RM4tfvo
         bRbnfKM3L6/glvET927FmYPUGAxcfReW0rAFtR9vc5H8RJq4K618rzXcuc7kI0E5rgGM
         LgRxWswPQeKUWRNlIEzUlHXH91DlaNaJmu4N0bjAIxc+uVRYWIDpCUD03yPB6AR7H2Hq
         SiBZZx/wSQNaFFpWNZt4l/XwPXIpOOIb1FslikTGLcQMJlZGVgpyUfDhHy2T7MtUKFlH
         k4eZs5rpTCdQwWFNUoQ1pcbtA81lpU2GznUfuXDkLiOAG1p2EqRdOLCcEy7w6k0NP4Id
         szHg==
X-Gm-Message-State: AOAM532sqUTrF6E2wIJNosjxkZgc2V6HtbqrZunSNkfBPpXX/Imq639Z
        wLeAWlGCsQD9JX3ycHi2c748wx37xSdKflT29sU=
X-Google-Smtp-Source: ABdhPJyc4blDzdYkWSMfGJdy/E9dbY7N6G3wThrVqnkIlxKSMtyHPwEItcmQswW4Ja4IB9mj/wYhj+U071oOqaOsOz0=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a63:160b:: with SMTP id
 w11mr3996703pgl.110.1602260031610; Fri, 09 Oct 2020 09:13:51 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:14 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 05/29] tracing: add support for objtool mcount
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

This change adds build support for using objtool to generate
__mcount_loc sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile             | 12 ++++++++++--
 kernel/trace/Kconfig | 13 +++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 434da9fcbf3c..fb2cf557d3ca 100644
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
-- 
2.28.0.1011.ga647a8990f-goog

