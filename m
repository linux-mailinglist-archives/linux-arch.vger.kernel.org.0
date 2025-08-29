Return-Path: <linux-arch+bounces-13331-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C700B3B965
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 12:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203631BA4C43
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 10:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB6A313E38;
	Fri, 29 Aug 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVQZPi02"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0ED30FF13
	for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464877; cv=none; b=JLFyv8vEMPAjRgRhefoCaaub+moIootrApHXXIXmIvvnePVCu6dlk/N1rla46sF+y1PglqODCVnxbeHQNl1pplVmyKczVjyWDKbZRLluFjDsKL1E6hv1IkoaTfQh6AvmIqcUWQ/COYu2YckxbxQpg9QPdMWkrwvCQbAiNP9cuKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464877; c=relaxed/simple;
	bh=XdwddMlnNDe/bejk9AlmOKSmzkod84XNORyHGHdp5tQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UZCsRz8IpjDIMGZ9ky0Xqjtltk+94yVVBO1oag7OVJfWeFW5GCOYHLdqDM3uCTmhY0w440ssoPPv0tkIp50LziuuukQuhvo4fd1LdsAkYgI5qLQ82eZ1VJVUKdJyvXFA61oo1SMriVfD5CKJqzTeV7W9+hti/IPiwaIh1DRFHhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVQZPi02; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b51411839so11083715e9.0
        for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464874; x=1757069674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZkdXrnu4rlNqr6nvqy7s2PHRCwIZIrYjOI0uDxkuo0=;
        b=FVQZPi02OrLY+h9w6d9mz/U2t/rLyG+ylXdwMosWOMbdcZ+D8FuWI9/iOm+E+BfE7s
         iddbFq8vl0Dd6aWZp6PWGhlltRGX8NCZFYRF0SQmvwYYCdljU851Lq82h8UwsIasU7H9
         Xcyk3OJ1YlFJz++Gvev1cW9vzt52jsBv479Uki5WORzgUn0l2m6t3KkQAY3FcTrE9+qz
         w6JALXp8GB+LYZtcY+PwDp8c0jdVr70w5Saz33Jwde5yc34NZKNnFS6H5JEc9g3acN8c
         rNPGftRRi+fdCNF7w8KW6Mb2tC5qSxOZNIP3mLMcyHcUwWxbMlL9pw4pISElY5Wkddt3
         aa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464874; x=1757069674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZkdXrnu4rlNqr6nvqy7s2PHRCwIZIrYjOI0uDxkuo0=;
        b=ZkqMetdpMPtzTkh/id+qQ7r6IS6B2Bcchx6R9SH9uXFQrpKomZJP25CoIcueUAZVNm
         bV09Blwr6YSjRL98hHWDH+vrVbbNbGv4GzleZh23J8DvPsMXkf7zBOGd6MeX9jVCX8U+
         OT07zXz9ir8roHCmto4nlp/knOZDxOsv7wwHh/BnZq136K4EldwJbICuM4O2whz4MJDs
         Kz4aW0jbHUaJWMNmOJT7DD4GyufJ/uiJzxasE8dQjyj6pa84+SssgO2weOIEh8TUFjnU
         U/HiyeFsjWW4mDjn3gKP1Ut45rncr4O3qM83ddU/a3rAkTwy12d8ERNTJsuxGFouLw48
         mYag==
X-Forwarded-Encrypted: i=1; AJvYcCUCbmnhh6i4DLAlXQlThLHJjuXF95cKOB2fE4Fewy8jddnEvcKAM7APkb0EY5VJxHlwhT8aDaKRJYRy@vger.kernel.org
X-Gm-Message-State: AOJu0YxZMNSX8QCfg0fPo0dTwx1hcr79qTc/nbnsaqNVN6oTU47zwIyI
	WbexO/nBW+Ts51JZUiPatIHquaSbRf57pAKbmAKnuwO+H0Ia3OtcimDD8bJomnpG/w5iB5ZaAqV
	Hl1oEgtAaQ5zrPHaCRw==
X-Google-Smtp-Source: AGHT+IETLQhhj0TWH9cTHkmUejWaasllcxIG4MgQGiEsNA2+oYnEukedB/VKaaNhilCldwAcOXfj5vhFRG0qg14=
X-Received: from wmbee21.prod.google.com ([2002:a05:600c:6415:b0:459:dd4e:4446])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19d4:b0:45b:6365:794e with SMTP id 5b1f17b1804b1-45b70ee5db1mr92752335e9.24.1756464873773;
 Fri, 29 Aug 2025 03:54:33 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:12 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-5-sidnayyar@google.com>
Subject: [PATCH 04/10] module loader: use kflagstab instead of *_gpl sections
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

Read __kflagstab section for vmlinux and modules to determine whether
kernel symbols are GPL only.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/linux/module.h   |  1 +
 kernel/module/internal.h |  1 +
 kernel/module/main.c     | 47 ++++++++++++++++++++--------------------
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 3319a5269d28..9ba6ce433ac3 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -415,6 +415,7 @@ struct module {
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
 	const u32 *crcs;
+	const u8 *flagstab;
 	unsigned int num_syms;
 
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 618202578b42..69b84510e097 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -57,6 +57,7 @@ extern const struct kernel_symbol __start___ksymtab_gpl[];
 extern const struct kernel_symbol __stop___ksymtab_gpl[];
 extern const u32 __start___kcrctab[];
 extern const u32 __start___kcrctab_gpl[];
+extern const u8 __start___kflagstab[];
 
 #define KMOD_PATH_LEN 256
 extern char modprobe_path[];
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..400d59a7f44b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -11,6 +11,7 @@
 #include <linux/extable.h>
 #include <linux/moduleloader.h>
 #include <linux/module_signature.h>
+#include <linux/module_symbol.h>
 #include <linux/trace_events.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
@@ -87,7 +88,7 @@ struct mod_tree_root mod_tree __cacheline_aligned = {
 struct symsearch {
 	const struct kernel_symbol *start, *stop;
 	const u32 *crcs;
-	enum mod_license license;
+	const u8 *flagstab;
 };
 
 /*
@@ -364,19 +365,21 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 					    struct find_symbol_arg *fsa)
 {
 	struct kernel_symbol *sym;
-
-	if (!fsa->gplok && syms->license == GPL_ONLY)
-		return false;
+	u8 sym_flags;
 
 	sym = bsearch(fsa->name, syms->start, syms->stop - syms->start,
 			sizeof(struct kernel_symbol), cmp_name);
 	if (!sym)
 		return false;
 
+	sym_flags = *(syms->flagstab + (sym - syms->start));
+	if (!fsa->gplok && (sym_flags & KSYM_FLAG_GPL_ONLY))
+		return false;
+
 	fsa->owner = owner;
 	fsa->crc = symversion(syms->crcs, sym - syms->start);
 	fsa->sym = sym;
-	fsa->license = syms->license;
+	fsa->license = (sym_flags & KSYM_FLAG_GPL_ONLY) ? GPL_ONLY : NOT_GPL_ONLY;
 
 	return true;
 }
@@ -387,36 +390,31 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
  */
 bool find_symbol(struct find_symbol_arg *fsa)
 {
-	static const struct symsearch arr[] = {
-		{ __start___ksymtab, __stop___ksymtab, __start___kcrctab,
-		  NOT_GPL_ONLY },
-		{ __start___ksymtab_gpl, __stop___ksymtab_gpl,
-		  __start___kcrctab_gpl,
-		  GPL_ONLY },
+	const struct symsearch syms = {
+		.start		= __start___ksymtab,
+		.stop		= __stop___ksymtab,
+		.crcs		= __start___kcrctab,
+		.flagstab	= __start___kflagstab,
 	};
 	struct module *mod;
-	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(arr); i++)
-		if (find_exported_symbol_in_section(&arr[i], NULL, fsa))
-			return true;
+	if (find_exported_symbol_in_section(&syms, NULL, fsa))
+		return true;
 
 	list_for_each_entry_rcu(mod, &modules, list,
 				lockdep_is_held(&module_mutex)) {
-		struct symsearch arr[] = {
-			{ mod->syms, mod->syms + mod->num_syms, mod->crcs,
-			  NOT_GPL_ONLY },
-			{ mod->gpl_syms, mod->gpl_syms + mod->num_gpl_syms,
-			  mod->gpl_crcs,
-			  GPL_ONLY },
+		const struct symsearch syms = {
+			.start		= mod->syms,
+			.stop		= mod->syms + mod->num_syms,
+			.crcs		= mod->crcs,
+			.flagstab	= mod->flagstab,
 		};
 
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
 
-		for (i = 0; i < ARRAY_SIZE(arr); i++)
-			if (find_exported_symbol_in_section(&arr[i], mod, fsa))
-				return true;
+		if (find_exported_symbol_in_section(&syms, mod, fsa))
+			return true;
 	}
 
 	pr_debug("Failed to find symbol %s\n", fsa->name);
@@ -2607,6 +2605,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 				     sizeof(*mod->gpl_syms),
 				     &mod->num_gpl_syms);
 	mod->gpl_crcs = section_addr(info, "__kcrctab_gpl");
+	mod->flagstab = section_addr(info, "__kflagstab");
 
 #ifdef CONFIG_CONSTRUCTORS
 	mod->ctors = section_objs(info, ".ctors",
-- 
2.51.0.338.gd7d06c2dae-goog


