Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DD3309125
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 02:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhA3A7y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 19:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhA3A4i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 19:56:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C142C06178B
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 16:44:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 11so11242633ybl.21
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 16:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=e8ediMGbRKukecpLwO0eR0sbXZYBrlkFjlLmuC8GnoE=;
        b=fEyFzt3KHtoL6uGy0iZx8DvfLSlWMOs9K+nvo6MTXB4KKESIT3QfMhTqnnlNqCo2wx
         Vv8lttyIGu0PEa848lroNrZSNvRoXp+fHVC2A3nKhCZMllY+PKdRoMn1Vea3HRFGBgoT
         ANNgdC8oU7mEwR2Q1iyP97cMyy7NZqyjQZm9VmcjzvE7a1yLXDl+xBlolhJa02hdLFo/
         EcDmrfTncaAX7EmA9Oo78pfzv7J8725gpteecb9oVgY3D1nBcMxPdlo0CaNzSvH6I4UF
         gXimS8DkkshvToLySWby18nrU/+94IUBHynNqo2209XIHHe7jjbtq+NV4CYx57+CF49i
         dK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e8ediMGbRKukecpLwO0eR0sbXZYBrlkFjlLmuC8GnoE=;
        b=EDNa5wgBcFad1W0PhgrXMyc1I3oSvhJ7/kCLcuBkqrdE3Pga3zK7HrSpvNWLlZbeUM
         ACuLir34eIHNNnHaK+J+YYp+bKdFFUJQjAEEupWVv7AK+uuLc3b7T9LzSEwi1Bj2LvO9
         gSZ/opVzhc6kNP59WyaApWpZBnn92JvKapPnvGIC3PvS/wyV0kFiKZE+8Pe+JOnT0tOw
         WSxl2i4hfjFsKNkTIDHlA899b00Ge1q+7bWQC1rdXXqgEuJUA2nTS/cZVUcelv7w+guq
         y3YrYoTHw/v40/lFDH/PIkVktVtmmTvsIji/KWqnVxp5cAEn9Sj90tzpbH2LuQ1+J0Lz
         A1Mg==
X-Gm-Message-State: AOAM533ihhEnKU5cLqoQA7dgQArX5g3Cr8HFB/LYkLmKNT/rhXmWmUeh
        dvf4ExO7PPvi6405D9+DpEVN1K6VcwoMD3ioyN4=
X-Google-Smtp-Source: ABdhPJxM+p5XwbuYGK6EpDfDaxgYt7Be1GcIn8X1grBEIql7ANp7rNTvPHoFhNKDxI107oNYdXu7/tcPEgPlRKI/Yns=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:d293:: with SMTP id
 j141mr9709920ybg.56.1611967447754; Fri, 29 Jan 2021 16:44:07 -0800 (PST)
Date:   Fri, 29 Jan 2021 16:44:00 -0800
In-Reply-To: <20210130004401.2528717-1-ndesaulniers@google.com>
Message-Id: <20210130004401.2528717-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v7 1/2] Kbuild: make DWARF version a choice
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
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
the default. Does so in a way that's forward compatible with existing
configs, and makes adding future versions more straightforward.

GCC since ~4.8 has defaulted to this DWARF version implicitly.

Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile          |  5 ++---
 lib/Kconfig.debug | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 95ab9856f357..d2b4980807e0 100644
--- a/Makefile
+++ b/Makefile
@@ -830,9 +830,8 @@ ifneq ($(LLVM_IAS),1)
 KBUILD_AFLAGS	+= -Wa,-gdwarf-2
 endif
 
-ifdef CONFIG_DEBUG_INFO_DWARF4
-DEBUG_CFLAGS	+= -gdwarf-4
-endif
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
+DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
 
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+= $(call cc-option, -femit-struct-debug-baseonly) \
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e906ea906cb7..94c1a7ed6306 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -256,13 +256,19 @@ config DEBUG_INFO_SPLIT
 	  to know about the .dwo files and include them.
 	  Incompatible with older versions of ccache.
 
+choice
+	prompt "DWARF version"
+	help
+	  Which version of DWARF debug info to emit.
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
2.30.0.365.g02bc693789-goog

