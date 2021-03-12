Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CF333829F
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 01:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhCLAtr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 19:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhCLAte (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 19:49:34 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F687C061761
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 16:49:34 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id k10so16811344qte.17
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 16:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ESYHITiLKQTwMyQqI1+m44L/vavOiNb2UPXKfL/7dqU=;
        b=PMMCvUIZcIon/8qm3dGSSMmSpSk17nnpfqLvQCEMkzCunL9P1EWlysAS/DkD/MfutX
         1w1/wJnwkSiTt+U2xZVHuaivOHCZf+fZak5dE4YifpFkF99l9X+DsGc/bWkEp8bvRYS/
         aUIn7XdeB8JfnFfWf7tfFFz/xlaKy6OfTVERBhxfduSc75BOY9WqG39v697PyoyNxDMX
         eodj7W4qoX56Zh4KBqIIeQPO34Z4lyJD7DKBgla6OY1hXT1FPMrB8OMnNmDGvqVVo8th
         KdEdF5feGy3XhlMp/PeUmvcQRN06NhZJ2OKCl+oEIQH+hiqvH3wNEPNO4Z/29KyBgHcM
         p6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ESYHITiLKQTwMyQqI1+m44L/vavOiNb2UPXKfL/7dqU=;
        b=ohCYEEdWtBsSfmLzEA6NOzM9+K2uvOD8eszJhgj87bhJ/aF/ORFmX9Bo8pybcmCBwl
         C44TTs0PodPlRt9Uz8Pg3bDNf2RI38QidzNDUIPGf8OKxDu5Fyelma3X7TUTBfePrDlR
         ZASmn17CZqe4FHZkeSKrOnCVzRHbiHK6Y25qjeGEsBi600c/mzawfSuC5/xLSnFJpsNi
         NYGLlbOpmBFV66TWQDMYKc/0CCIZ31KbIlBH2e47G6QhI/bUwD8GVoz23tpm8J64Y1mh
         I7gFML/kgEGtFIA++dsIAbA5j170xEVEQGtaUa00zI6NpOzUaw8SJYQMP7smg8i91NyR
         zlPA==
X-Gm-Message-State: AOAM533/Vv65THSLkF8VE/MILjaFoeoYBEuhcCcrR/BYTKVQeQEf2TdQ
        PrRO/kPiGwHic6jx4JxszVT+XFy6BMnsX4KRUD4=
X-Google-Smtp-Source: ABdhPJzW0uEN8Oxm3LYKJ3R+Njx+t1h43HBF2drlUWKH1BuuoAb2LD5zpQfKztTYQBZfsEf8ydjOwv14o3YXhwxEA5s=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:21a5:: with SMTP id
 t5mr10258052qvc.20.1615510173523; Thu, 11 Mar 2021 16:49:33 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:09 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 07/17] kallsyms: cfi: strip hashes from static functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
---
 kernel/kallsyms.c | 54 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 8043a90aa50e..17d3a704bafa 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -161,6 +161,26 @@ static unsigned long kallsyms_sym_address(int idx)
 	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
 }
 
+#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
+/*
+ * LLVM appends a hash to static function names when ThinLTO and CFI are
+ * both enabled, which causes confusion and potentially breaks user space
+ * tools, so we will strip the postfix from expanded symbol names.
+ */
+static inline char *cleanup_symbol_name(char *s)
+{
+	char *res = NULL;
+
+	res = strrchr(s, '$');
+	if (res)
+		*res = '\0';
+
+	return res;
+}
+#else
+static inline char *cleanup_symbol_name(char *s) { return NULL; }
+#endif
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -173,6 +193,9 @@ unsigned long kallsyms_lookup_name(const char *name)
 
 		if (strcmp(namebuf, name) == 0)
 			return kallsyms_sym_address(i);
+
+		if (cleanup_symbol_name(namebuf) && strcmp(namebuf, name) == 0)
+			return kallsyms_sym_address(i);
 	}
 	return module_kallsyms_lookup_name(name);
 }
@@ -303,7 +326,9 @@ const char *kallsyms_lookup(unsigned long addr,
 				       namebuf, KSYM_NAME_LEN);
 		if (modname)
 			*modname = NULL;
-		return namebuf;
+
+		ret = namebuf;
+		goto found;
 	}
 
 	/* See if it's in a module or a BPF JITed image. */
@@ -316,11 +341,16 @@ const char *kallsyms_lookup(unsigned long addr,
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
 
@@ -331,15 +361,23 @@ int lookup_symbol_name(unsigned long addr, char *symname)
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
 
@@ -351,10 +389,16 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
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
2.31.0.rc2.261.g7f71774620-goog

