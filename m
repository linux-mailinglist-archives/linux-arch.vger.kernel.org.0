Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10702CAED3
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 22:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbgLAVjQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 16:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388640AbgLAVjP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 16:39:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB708C094252
        for <linux-arch@vger.kernel.org>; Tue,  1 Dec 2020 13:37:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i184so4043259ybg.7
        for <linux-arch@vger.kernel.org>; Tue, 01 Dec 2020 13:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=baTa63xSC0ZZvL8LmEJ0rysXSGBclqJkA0eq2XdQYu4=;
        b=uSKl5HygxSFku3YpTdgH92zmKIE08ozZOIdku0rdE1QVetGDukAW5zNct8DUP027uw
         URWQdtClz2Lqmykr7qURlRRoi54XeEUu1RNFyDxIDeMUvpG0iHYLlEVkKi2WrwC16Mag
         xqCGvMXwV9ADAX0kd9iwYYuz8KAJgAR0vAiOyZY3HFSRXyr3ecyoAG3asfhKd5xnA56j
         C0uauidumM11pi4Ni2mqK2sj3jEgFKCHCeIHT8eOoI3Oj7Se9gobAyg97sPy9VAmfmeW
         k2WyX9FDP9jnedQUelDpCgdiXGQAEN9BsBj4WsylG4Z2JMb6iSYkZx7yItSsSxiRphQJ
         57Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=baTa63xSC0ZZvL8LmEJ0rysXSGBclqJkA0eq2XdQYu4=;
        b=hA4FBjFkUPSKHBCmdFETTSnfVrKrNZfNPnlglJDaSCMkqRwf3AcbUhhCvxm8D3Lc8J
         4ghNUgeYTHsyUIqZzIfkpzEGCvT7dwb2TYCGWs5Q4EGKmnpVE7PC+zjyYLNM+/FiKJAP
         YRVsbfdpzWMKH/KXlfQr/oqxE5d0IBRh8IlXo0vNqkXpnEA6w3c6N8qo0gaYJL0zot2k
         +EC+GbnKJlNj3XRk12kKIShc09AyVIX6anJMwY/EqbRnvGi8imacilSs4s1Q9QkeyWbO
         cE+H2xTXE0FBDuz7J6kC6qfpDkbS6hm0VzydkFLlVTmPmDA4XsQUZL2z1jk1PxAHsl9s
         uueQ==
X-Gm-Message-State: AOAM533rIorj1KvJv3k0cd0ZQhX6hfQrfnJEBb8mDFSM12PiJxoK/KeH
        my/HHTZweNuuLMs+jKwZiIuBZRgIwIsHrEwOFjY=
X-Google-Smtp-Source: ABdhPJx9UrJOBuVJFMgVMAJwkGX1h9O45KDxr7BrRQG9YqDPMiMlGPu3qHVL93NOaWHRQVSxnOLCqPD+XrASLbiYizk=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:8401:: with SMTP id
 u1mr9324352ybk.96.1606858655207; Tue, 01 Dec 2020 13:37:35 -0800 (PST)
Date:   Tue,  1 Dec 2020 13:37:01 -0800
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
Message-Id: <20201201213707.541432-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v8 10/16] modpost: lto: strip .lto from module names
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With LTO, everything is compiled into LLVM bitcode, so we have to link
each module into native code before modpost. Kbuild uses the .lto.o
suffix for these files, which also ends up in module information. This
change strips the unnecessary .lto suffix from the module name.

Suggested-by: Bill Wendling <morbo@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/mod/modpost.c    | 16 +++++++---------
 scripts/mod/modpost.h    |  9 +++++++++
 scripts/mod/sumversion.c |  6 +++++-
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f882ce0d9327..ebb15cc3f262 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -17,7 +17,6 @@
 #include <ctype.h>
 #include <string.h>
 #include <limits.h>
-#include <stdbool.h>
 #include <errno.h>
 #include "modpost.h"
 #include "../../include/linux/license.h"
@@ -80,14 +79,6 @@ modpost_log(enum loglevel loglevel, const char *fmt, ...)
 		exit(1);
 }
 
-static inline bool strends(const char *str, const char *postfix)
-{
-	if (strlen(str) < strlen(postfix))
-		return false;
-
-	return strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
-}
-
 void *do_nofail(void *ptr, const char *expr)
 {
 	if (!ptr)
@@ -1984,6 +1975,10 @@ static char *remove_dot(char *s)
 		size_t m = strspn(s + n + 1, "0123456789");
 		if (m && (s[n + m] == '.' || s[n + m] == 0))
 			s[n] = 0;
+
+		/* strip trailing .lto */
+		if (strends(s, ".lto"))
+			s[strlen(s) - 4] = '\0';
 	}
 	return s;
 }
@@ -2007,6 +2002,9 @@ static void read_symbols(const char *modname)
 		/* strip trailing .o */
 		tmp = NOFAIL(strdup(modname));
 		tmp[strlen(tmp) - 2] = '\0';
+		/* strip trailing .lto */
+		if (strends(tmp, ".lto"))
+			tmp[strlen(tmp) - 4] = '\0';
 		mod = new_module(tmp);
 		free(tmp);
 	}
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 3aa052722233..fab30d201f9e 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -2,6 +2,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -180,6 +181,14 @@ static inline unsigned int get_secindex(const struct elf_info *info,
 	return info->symtab_shndx_start[sym - info->symtab_start];
 }
 
+static inline bool strends(const char *str, const char *postfix)
+{
+	if (strlen(str) < strlen(postfix))
+		return false;
+
+	return strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
+}
+
 /* file2alias.c */
 extern unsigned int cross_build;
 void handle_moddevtable(struct module *mod, struct elf_info *info,
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index d587f40f1117..760e6baa7eda 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -391,10 +391,14 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen)
 	struct md4_ctx md;
 	char *fname;
 	char filelist[PATH_MAX + 1];
+	int postfix_len = 1;
+
+	if (strends(modname, ".lto.o"))
+		postfix_len = 5;
 
 	/* objects for a module are listed in the first line of *.mod file. */
 	snprintf(filelist, sizeof(filelist), "%.*smod",
-		 (int)strlen(modname) - 1, modname);
+		 (int)strlen(modname) - postfix_len, modname);
 
 	buf = read_text_file(filelist);
 
-- 
2.29.2.576.ga3fc446d84-goog

