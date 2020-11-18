Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2352B876F
	for <lists+linux-arch@lfdr.de>; Wed, 18 Nov 2020 23:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgKRWH5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 17:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgKRWH4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 17:07:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3A9C0613D6
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:07:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a13so4536024ybj.3
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=viQfWSBnWWQkhdsfshg6wjQjXkrLrUdatQTDtGtOjLo=;
        b=dbW3OmpXPLinNMGxA3qqhmIvkxGOzMc7C/RLfKw2PW/qdCHjGaq5Rs1hCGsIzYh/jX
         cUO3w+ryPubJXJGol/AuBCcRFfqimlfssxX4y6J+iwik+/cszhw9jew2aOb9Lmdvu7q3
         qieIDuh+CLwus3Se4ineY0Vi/kyTjXVxXyZ5lorAi2Hmy7HlCWwt7n7Fopjj6RXhZLX7
         kv5Z35uHWmDhqECCVyNr9OPFyUHAODR3hYTPnvLnPLJZNbu1ZVXJIfgazGluz4pgyU8J
         qMfDZ+fkDzZG6An4ZATuVPNoDZGPBmol5zRBPXVr5pn1bl81Wq0RE3gdh/WU/xznOT8P
         KR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=viQfWSBnWWQkhdsfshg6wjQjXkrLrUdatQTDtGtOjLo=;
        b=RnLbb9Ndb8iCggk4NoQtGeMqD3EnO3TNbzqZQUdA7TWxZ98dpzN0KFi5oja0jfJT55
         0ivdY6RpyG65SOSeEQ4NfYLF7JxJM3+F2B1yF9T4O7h1Apqp9Ug09lvYat/+JdWfZmIZ
         nKfps8xPmRjxbxh7u8fYxs+0vFs/lK2K2dT9n8dWoz8dVNdnaBfIJ8Ld0M2ov6cgN57u
         cFleiGckhSMCTEp9lw9kuo0Ey/BaDFa19zse1DyodqxZpf+ZwV+vg72UX05wq5wYzbap
         x0SlyA5sIHeysvwyL8JyuHKG3SxIZ/BxsHwBeu5aq6FlNjLkkx07CPAl2hQ+z3hmXaqM
         34VA==
X-Gm-Message-State: AOAM530GthLOTSBD8DGrEuBo4sdaHui0ZfVIeO8rjbhX/cStrXvjmLXW
        rSQfGCPIjiRrPe2NKLiLbKEoTWvHG5gRF2MFlgA=
X-Google-Smtp-Source: ABdhPJzhC6bbGfgKTOT/DdbCJcRfllDjQ4hY6LJihFMdwChNr7SRK4RBgObFPHKV0TZJgGDSTsKPIHTsuMaflYXpbFA=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:9248:: with SMTP id
 e8mr12067724ybo.223.1605737275399; Wed, 18 Nov 2020 14:07:55 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:24 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 10/17] modpost: lto: strip .lto from module names
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
2.29.2.299.gdc1121823c-goog

