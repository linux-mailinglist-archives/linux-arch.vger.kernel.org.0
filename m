Return-Path: <linux-arch+bounces-14483-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E85BC2D155
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 17:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1944E188B8FE
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E86331A7EA;
	Mon,  3 Nov 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVmVEh0L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256A23191D1
	for <linux-arch@vger.kernel.org>; Mon,  3 Nov 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186811; cv=none; b=nPpMYdkODcgx3liQ+vaqWhC+Frd9cAYW1+QP/I4JoCAocZdinJbEkJyd/8fjIjSSqe0Rv1k7uqdbF5/c9VKQ1ChbD7gAHUAaX1I/3fEkI8YFpClXnDiRG1N5Aj+Z57//5w9lrnRHY0oG2p4wEZrYeS2S9UyALCexMV/VdafzXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186811; c=relaxed/simple;
	bh=tuyLXUvi/ESqwW2v6QjC+olXsEHZK/Kv3IdYAAA8beM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rl7X5sajhNKZ4PwEMw2uFUiCcEd1BxW7O7stb7dmp7v6Bz/FRRLTkYS6bC5saDFmKPjCboNBSy9gUtyPyTldQRmGRmKeW0VDnSUDMUliEFbU820jvOvLnd8UvaXmf2bWxEX9LPslRtmXgllVDrHEwZytOpOxVpulaPmN5KJgGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVmVEh0L; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429ce8ac89bso856570f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 03 Nov 2025 08:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186806; x=1762791606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+VzLCYAN+u3C81ZeCic6e0B5W6UCDTRzeShogr9CFM=;
        b=RVmVEh0LByx8eUVYFmsZLGJ3IFZZf5bQUYcdmr1Bwf/mlp7+Zkzrv1gTT/3WJdEocq
         6h/uCbp7EvTatnQCw5LU+KTO42vlJPY/qeba7nZVmwhQImN4Sj7js/6soiraBuSQRJxJ
         2xKSQ5yT2l2nFuVPBGU4Z7Hx73S4tM/f+RCJJ7Ukk5tj/pOzN5WcA/y2CSWvRtfovJIE
         RiXgpyb2Qg3Z0ZuGCeUJl4KUs/SxWsS99zWpVVvYk99u4pGnGIXpS3y2tk6uK3/XYMW0
         3E7K3zLweCq4QBmy0rrFz21akcPmj9utMTJkVAbPo31kvqqVorOFNhaSyYYz/0C//T7T
         4qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186806; x=1762791606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+VzLCYAN+u3C81ZeCic6e0B5W6UCDTRzeShogr9CFM=;
        b=uUl3OQB3jlRnsNqJcLpuPQPDGg4tP64xPHfP9NR1zRIX6mZ7utDckwzbOwleR586sW
         KXLZABqKpTG4TIU+pw63zRxnlahK84EIamlWOQ8sS4I2m75EcB9VOw42TnO04viWW/YM
         0m0gZysOwxK3+Q0jT4E7yx1aOQFoD+E9OtVjS9Il2c6+i//OwUHq4HsGiGoQ4RI/2Oac
         Gl/i/Uun7plI7A3sWIQ2GA/YiLjtd3rtgZqYeyuAiNj/lno6ZO85t+7BAUx2UbSJ3fXf
         DsVmXy6aRmgQc3MsWdRUsnCr9L6/6EZZ8EIN/ifnYlkndnk7br/Ii+77x3o2xTc70X7E
         DbgA==
X-Forwarded-Encrypted: i=1; AJvYcCUj7JPOnFnFSWNHxTevh1e8sL0WyiuozXZCp+ax87so1ydOMuMiUd2l2D4FwkMcHV61n9kbWrI3zKLH@vger.kernel.org
X-Gm-Message-State: AOJu0YwCaLw6Q8UaQJ/VEatRFQeMA+6xULwmw/5ITSvr+ZzXVmPZgl8+
	kCfJksqKM3ere6UH46TEioGtWgBTtO+3yuhbaGs5xeNWX8rdUgCi+IzDug9dJSxF9PQo2eR2HSZ
	0qVuJL30bC165lyvMbg==
X-Google-Smtp-Source: AGHT+IHsA0v7E+SnXH75SrlLLdZznHgP2mGDuTma0AhnTccBK/k4OR/i3RdgETyahE/jGzsOOaCC+90khENn44c=
X-Received: from wmbjt1.prod.google.com ([2002:a05:600c:5681:b0:477:1186:dfaf])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:22c7:b0:429:d79f:c86b with SMTP id ffacd0b85a97d-429d79fcb0cmr2277909f8f.58.1762186806407;
 Mon, 03 Nov 2025 08:20:06 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:50 +0000
In-Reply-To: <20251103161954.1351784-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103161954.1351784-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-5-sidnayyar@google.com>
Subject: [PATCH v3 4/8] module loader: use kflagstab instead of *_gpl sections
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

Read __kflagstab section for vmlinux and modules to determine whether
kernel symbols are GPL only.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h   |  1 +
 kernel/module/internal.h |  1 +
 kernel/module/main.c     | 55 +++++++++++++++++++++-------------------
 3 files changed, 31 insertions(+), 26 deletions(-)

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
index c66b26184936..4197af526087 100644
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
@@ -2810,8 +2809,12 @@ static int move_module(struct module *mod, struct load_info *info)
 	return ret;
 }
 
-static int check_export_symbol_versions(struct module *mod)
+static int check_export_symbol_sections(struct module *mod)
 {
+	if (mod->num_syms && !mod->flagstab) {
+		pr_err("%s: no flags for exported symbols\n", mod->name);
+		return -ENOEXEC;
+	}
 #ifdef CONFIG_MODVERSIONS
 	if ((mod->num_syms && !mod->crcs) ||
 	    (mod->num_gpl_syms && !mod->gpl_crcs)) {
@@ -3427,7 +3430,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err)
 		goto free_unload;
 
-	err = check_export_symbol_versions(mod);
+	err = check_export_symbol_sections(mod);
 	if (err)
 		goto free_unload;
 
-- 
2.51.1.930.gacf6e81ea2-goog


