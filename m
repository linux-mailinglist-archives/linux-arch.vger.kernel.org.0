Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4827DAC5
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgI2Vqt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgI2Vqs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 17:46:48 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7133C0613E3
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:46:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id r4so4084071pgl.20
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=19SL9ILYFnZ21fbCFqMg6UAhhhxZhQrjD+s35+X1B+w=;
        b=dgV6SDo9/nGgyVMUAcMHx0gvXIYyOXF6ty1/3uITkICbHspZeHQbvHxGwlJqzzv9XW
         4V5LMwCn5zT2oQ8f4LzGfojh5OquEucov8kBAZlsAbKj8gS7+rq5Zf2MIFybCbJwmh+A
         b2F8LeTYsJjCidyUsKW6BDyg8O8Sinw+WaY1c0mDlAt5XShrnPVlrIVqksLlFRGU1Dp8
         A8Bl7ulvb9diUaImQKfi6sNHBwVH8SiGCv69MXqgXzBQsCNHc9rP0hmPStj/ZcNkXD/B
         KaKtBNLUeB6r12MkOyu4JMGxpeLWC59hDNbjZmRjkjPVuauMgp1y6CR+/HcBDH41STN0
         Kwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=19SL9ILYFnZ21fbCFqMg6UAhhhxZhQrjD+s35+X1B+w=;
        b=j0PcSBPo1vLal04kVgr4tta7ErHA2C9VRehnasO4PeYXGLVpGjRq58t3Qd5RYbjrwq
         9i6qt3NV+kIR9C9bGgiw5WQg+1QqaVKr3kURSfQ/diejh1BBMx/WeJAepOQgQkWa1SZd
         gRj9w9vJihW73ibpFxK7LsQVRxw4sFiz8T0ZihXFrsQqaPmVG88CEUJB3XtZmDJ/7SiW
         F74xYklcD5YmNJjl45u0l3VCqHWAkGYB1CbG9QvLGH1yldJ71M4NTiJv/VWFqFN6oF8d
         dN2igNrAUZk36L7X7c/wAGqasblkKHRMvKc8ezWP7AanJvjyWMmX21LZVcyoP4W6biMV
         fCVQ==
X-Gm-Message-State: AOAM533GhitGQpAhpT6L/jZ905HoKI2xvWxbJG2TIz9gml3nB7RFmgMZ
        3G1xRlWvV6dtvEg1E8oi8HdlCB0XcJZyKJK/1/w=
X-Google-Smtp-Source: ABdhPJx1IWNK7mnxuP/Nk+1pT7lWQ22j29Zw+7lY5TtajrC4ZWI/DVx3Sv0QEYCQpGeJUBhPmBSAfh824OrxIAP+HiE=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:c907:: with SMTP id
 v7mr5593265pjt.204.1601416007270; Tue, 29 Sep 2020 14:46:47 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:09 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 07/29] tracing: add support for objtool mcount
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
index 77e4f0a9495e..9717005e41c4 100644
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
2.28.0.709.gb0816b6eb0-goog

