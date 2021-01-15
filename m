Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B712F8738
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 22:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbhAOVHn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 16:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbhAOVHm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 16:07:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A861C06179A
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 13:06:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n76so7494676ybg.7
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 13:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=WwUdb2o6/JIc/+fz+e0NhIo1IFclKkxRZVZ3uFNIMcs=;
        b=P98utPfE6V667LGwTk/IdGWWjs1i97DTxFXdD6FraJ/KKKWgNoEaRBbxZ5phN52hfH
         nDeTjvnhKRW/+FmCsSU+a0ByuNJP2F+Io4jbDhySATDrrnQFLaYSR44keYYmmfBBJoYq
         h+deIqj8r6oJ1KqkWf9euVm/PkBcINapnocm6aqqq6PRdVuUmS9zxAaXF//OAQHLJWi7
         KuUvn19Vgodzjl78CtFaFVyCwJVmqRHjq6Mde/X8DTE4onvHWAqFcyFnB68qcHKONg9u
         NDURrcYtPVIq9OWtnW3/9GnSF76L6hDE8KjAZd9WJ0v9ky5M3UOE1HFnEdUaUxpYvxT3
         fo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WwUdb2o6/JIc/+fz+e0NhIo1IFclKkxRZVZ3uFNIMcs=;
        b=HWvdvekYAHJ0M7IqcqDyRSN1tERLjbN+kPI+9Bc8MTUxRe69AP6pZ6LsvaWc9g16zt
         KIr0O42C76agzJ+AlBI/QCnDttKuHWFnbZHXnmOG3AXi2vuw7hfdvRn6KjBRD/RNEZkw
         avhEA+qyV7z8AuoukUYa490Ehz0bXkbbgocxsBX6AkarBR/56//Gew/g6w0UaXYcDlZI
         xoTGNGcD3NPUVKX8VDTqYratvaXMv4ryL0ejoMqcgV55chG8oJjLMq5qgaN83eQISuKx
         sqOmc7omn199QebVpsrB1RiT2uHaD7HkBxyoofm/puEcH4c6joh9tGGe4QzywPpibrP7
         7vyA==
X-Gm-Message-State: AOAM530PcpIpxbFspKSLlZyUkVuMGsEsWACFAyl/wAsjcUGD0BTW0R/o
        oGNJdz4lB1SKjaWP290pyXwjW6vLMWxFlw5ykRk=
X-Google-Smtp-Source: ABdhPJwl7tCUSN0P/LCMkvXJn+0QmVuXApbC9wW8nC1jUNLza17eauSiMeqgT4K/PaLA6wvRmXPjX8w+C6i38FJPLDE=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:340c:: with SMTP id
 b12mr4325908yba.474.1610744783536; Fri, 15 Jan 2021 13:06:23 -0800 (PST)
Date:   Fri, 15 Jan 2021 13:06:15 -0800
In-Reply-To: <20210115210616.404156-1-ndesaulniers@google.com>
Message-Id: <20210115210616.404156-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v5 2/3] Kbuild: make DWARF version a choice
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
way that's forward compatible with existing configs, and makes adding
future versions more straightforward.

Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile          | 13 ++++++-------
 lib/Kconfig.debug | 21 ++++++++++++++++-----
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index d49c3f39ceb4..4eb3bf7ee974 100644
--- a/Makefile
+++ b/Makefile
@@ -826,13 +826,12 @@ else
 DEBUG_CFLAGS	+= -g
 endif
 
-ifneq ($(LLVM_IAS),1)
-KBUILD_AFLAGS	+= -Wa,-gdwarf-2
-endif
-
-ifdef CONFIG_DEBUG_INFO_DWARF4
-DEBUG_CFLAGS	+= -gdwarf-4
-endif
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
+DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
+# Binutils 2.35+ required for -gdwarf-4+ support.
+dwarf-aflag	:= $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
+KBUILD_AFLAGS	+= $(dwarf-aflag)
 
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+= $(call cc-option, -femit-struct-debug-baseonly) \
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dd7d8d35b2a5..e80770fac4f0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -256,13 +256,24 @@ config DEBUG_INFO_SPLIT
 	  to know about the .dwo files and include them.
 	  Incompatible with older versions of ccache.
 
+choice
+	prompt "DWARF version"
+	help
+	  Which version of DWARF debug info to emit.
+
+config DEBUG_INFO_DWARF2
+	bool "Generate DWARF Version 2 debuginfo"
+	help
+	  Generate DWARF v2 debug info.
+
 config DEBUG_INFO_DWARF4
-	bool "Generate dwarf4 debuginfo"
+	bool "Generate DWARF Version 4 debuginfo"
 	help
-	  Generate dwarf4 debug info. This requires recent versions
-	  of gcc and gdb. It makes the debug information larger.
-	  But it significantly improves the success of resolving
-	  variables in gdb on optimized code.
+	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
+	  It makes the debug information larger, but it significantly
+	  improves the success of resolving variables in gdb on optimized code.
+
+endchoice # "DWARF version"
 
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
-- 
2.30.0.284.gd98b1dd5eaa7-goog

