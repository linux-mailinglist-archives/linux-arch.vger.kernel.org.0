Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FB328C665
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgJMAe7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbgJMAdL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:33:11 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4D6C0613A5
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:46 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id es11so4334298qvb.10
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=q9NeEgeJtjuDXz46HWaR2aTcr7U+m+G2Xtw7ZYj0i80=;
        b=CRqhP/uYxJIvrJ7JFPmz8eieDBpzOaZtoHbS8QXp5nwuPeyuXjSGwF+OiqCNfxI5CI
         f9yeAi6kntV3Hcb0QAvynqG7PhefhCKc+wf5MgUqjtr36fAj0pAt2fao57QEfV3dPubY
         qGJERG8RZRx1XLbLQX6q3jLoJmOhxxfuFiNcV2xSqDCoRghQrfZVNu4ZAhFk5CS6GT3/
         8Pt5+A54/c+NAPCc64rs9VaZY7zwtEz0DPx7y815vR14O2JTyeWKP0oBmk5RkEWaLa7A
         4TZQZriVb4hxzadVvazocXnBKpQ+glS0GUjQz9+czCuxdUNkAumiLnp2/6AngY9hOLxO
         KvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q9NeEgeJtjuDXz46HWaR2aTcr7U+m+G2Xtw7ZYj0i80=;
        b=kaPpRrGKU5veNq/y83mykOx8D1v34tDWkzGNT6dNeAhLOCAHaB7KTPpuHmxLnry/7U
         H5XGXzMN4fDM1Z2nxODBYY8eqxj1dHYkLwRnGyjr5d0ntq6hkV4QoDTksZSwD6aZMWPO
         jxoSKy6sqblHn8vmMFcKc9wdX3zLA5G/q87C3yWipp6Ti/25A+WhZpFFBCNZpkGkxlkK
         eLNoyjIxClRAEINrv1NauFD6JXeG8ItJjuDzgPKGnsKvQMXuVs90Qjqx719BO0nHibEq
         u7BqEIJSAICbIyJn6BRIcsxCVf7fgDdRMFfItiXi6d5CBmp/a7xW3BC5QVEWTycuv2BI
         6PPw==
X-Gm-Message-State: AOAM531/yo4hT9WSIKOuDe4wMbOFJnuyiI05F3wZcWbYIGEqZ9jXmcRx
        s0QawxteOqa6ifN5aEtTRwgUk8Eyler7B+hhR4g=
X-Google-Smtp-Source: ABdhPJwNLiDeOTBP4r3W42txfMRPPrerXEwzhxthxcVcHLs0FVIRyeH0/TIJTUqrtTv7hlK+NeLjhdidQu3kmodb/0Q=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:c548:: with SMTP id
 y8mr20871526qvi.41.1602549165345; Mon, 12 Oct 2020 17:32:45 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:56 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-19-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 18/25] modpost: lto: strip .lto from module names
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
index 69341b36f271..5a329df55cc3 100644
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
2.28.0.1011.ga647a8990f-goog

