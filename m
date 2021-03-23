Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E59346A1C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 21:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhCWUkf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Mar 2021 16:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhCWUkD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Mar 2021 16:40:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7615CC061574
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:40:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k189so3819379ybb.17
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i1PxfqvHNAZaUSY0Wt2J9hLbKLkB/NragVXsh/CJXkk=;
        b=r3h1x+fU5lE/E/LEWwengkgZi5PRsX186ijNQ327TMBLawIZY6LBYeXoo+w52nP2gv
         rF5I2VWq76FFpaCoMspUWvw8qDIKJm1AsH0+oLVk3E9T+doX05a07ZFN00OhJPnaxkmu
         jxmLG5HZc+yt4wtJhjo3sZUXCMUwF3pZoczzJSo1cNByG2VVWNmY/KAxOvwH7o3TUBYH
         bGowaPWnFDFXQgdWtgWmUwuCqSOx5f/zwc5Gwk2eWSiXszhRE499K2081dnK0xsNlJj1
         /F+vI9niI/hzqmXXXuXFw6fn+8OOPf3ryNNVi941QfjddB4grHq+9+iY1IfzHYtwau73
         lqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i1PxfqvHNAZaUSY0Wt2J9hLbKLkB/NragVXsh/CJXkk=;
        b=eueNbLSweFE2RmLiak3i6x4AnYn8FbJbariPy7nuG87CiG++70SulzAhR6PKA2Zo2W
         hbkmzqqjDvT5kUhvGqGMIg031hueK5BabmCplAZlAFGOeVSfT8UQ6QB098DLuizqej+V
         LnJPgVg2kbyFlKcmwlq7/BgQcsLCka0LzNg8M/HjvE0ZO54+dQXr84sAQEDHgdjgUsFz
         iFfGqvEkDYuwVsC5rNNtsanCbRn9RbRyyFldw5sKS7Y+CaeC70g7s8Sw2WmE+b6xAHd2
         oNUDhkjDsY0rc3M/T8DoRUFqrkWcQzjixdcHIj6lgpgpAQ4er26BR0L/VBqo+EBP9wxK
         fi3g==
X-Gm-Message-State: AOAM532zN58AmYoIIJ4THJhg5WN06KrdcTjONe/dmYeuSMsjnbombEXj
        pMMgJvSHsQemDYl9I+ONipHx/5c8SBH5m63fFP0=
X-Google-Smtp-Source: ABdhPJxSGEWBzQB/5ovI2vIjo7a1D7A+5mPzIG6DfuCWCyGPkoV9bpBY6tsZB7tVHHd6ltUsB02iXZ3BUgMvr1I18/M=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a25:a166:: with SMTP id
 z93mr111661ybh.354.1616532001793; Tue, 23 Mar 2021 13:40:01 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:36 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 07/17] kallsyms: strip ThinLTO hashes from static functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_CFI_CLANG and ThinLTO, Clang appends a hash to the names
of all static functions not marked __used. This can break userspace
tools that don't expect the function name to change, so strip out the
hash from the output.

Suggested-by: Jack Pham <jackp@codeaurora.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/kallsyms.c | 55 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 8043a90aa50e..c851ca0ed357 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -161,6 +161,27 @@ static unsigned long kallsyms_sym_address(int idx)
 	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
 }
 
+#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
+/*
+ * LLVM appends a hash to static function names when ThinLTO and CFI are
+ * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
+ * This causes confusion and potentially breaks user space tools, so we
+ * strip the suffix from expanded symbol names.
+ */
+static inline bool cleanup_symbol_name(char *s)
+{
+	char *res;
+
+	res = strrchr(s, '$');
+	if (res)
+		*res = '\0';
+
+	return res != NULL;
+}
+#else
+static inline bool cleanup_symbol_name(char *s) { return false; }
+#endif
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -173,6 +194,9 @@ unsigned long kallsyms_lookup_name(const char *name)
 
 		if (strcmp(namebuf, name) == 0)
 			return kallsyms_sym_address(i);
+
+		if (cleanup_symbol_name(namebuf) && strcmp(namebuf, name) == 0)
+			return kallsyms_sym_address(i);
 	}
 	return module_kallsyms_lookup_name(name);
 }
@@ -303,7 +327,9 @@ const char *kallsyms_lookup(unsigned long addr,
 				       namebuf, KSYM_NAME_LEN);
 		if (modname)
 			*modname = NULL;
-		return namebuf;
+
+		ret = namebuf;
+		goto found;
 	}
 
 	/* See if it's in a module or a BPF JITed image. */
@@ -316,11 +342,16 @@ const char *kallsyms_lookup(unsigned long addr,
 	if (!ret)
 		ret = ftrace_mod_address_lookup(addr, symbolsize,
 						offset, modname, namebuf);
+
+found:
+	cleanup_symbol_name(namebuf);
 	return ret;
 }
 
 int lookup_symbol_name(unsigned long addr, char *symname)
 {
+	int res;
+
 	symname[0] = '\0';
 	symname[KSYM_NAME_LEN - 1] = '\0';
 
@@ -331,15 +362,23 @@ int lookup_symbol_name(unsigned long addr, char *symname)
 		/* Grab name */
 		kallsyms_expand_symbol(get_symbol_offset(pos),
 				       symname, KSYM_NAME_LEN);
-		return 0;
+		goto found;
 	}
 	/* See if it's in a module. */
-	return lookup_module_symbol_name(addr, symname);
+	res = lookup_module_symbol_name(addr, symname);
+	if (res)
+		return res;
+
+found:
+	cleanup_symbol_name(symname);
+	return 0;
 }
 
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 			unsigned long *offset, char *modname, char *name)
 {
+	int res;
+
 	name[0] = '\0';
 	name[KSYM_NAME_LEN - 1] = '\0';
 
@@ -351,10 +390,16 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 		kallsyms_expand_symbol(get_symbol_offset(pos),
 				       name, KSYM_NAME_LEN);
 		modname[0] = '\0';
-		return 0;
+		goto found;
 	}
 	/* See if it's in a module. */
-	return lookup_module_symbol_attrs(addr, size, offset, modname, name);
+	res = lookup_module_symbol_attrs(addr, size, offset, modname, name);
+	if (res)
+		return res;
+
+found:
+	cleanup_symbol_name(name);
+	return 0;
 }
 
 /* Look up a kernel symbol and return it in a text buffer. */
-- 
2.31.0.291.g576ba9dcdaf-goog

