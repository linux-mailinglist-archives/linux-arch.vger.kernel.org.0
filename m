Return-Path: <linux-arch+bounces-14048-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B851ABD53EF
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 18:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFF8420E27
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D225D30DEC4;
	Mon, 13 Oct 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYyODbIN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C131197B
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369994; cv=none; b=AK+KWBoRe/+wnzt1nQwi/R8LLodqtOYrj5ZX8rtkyFpAV/d88uDrFRo1v1e3cU1T55l9yG3veyBPe5JOEH5F4dEOAokJ7TxJxGZx13BYhcTW1aftgosejQH5p1QT8ArXcmJ5F+ofWPbWxdkiKq6BoFznvkKEHhszk8AeAi8Xlww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369994; c=relaxed/simple;
	bh=dfr6XRob40CPKAWcqan5eteUxA+ytUveF2Ud2J29B08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mBV/ypRHwfymUT/xlKf9sqvGMOOQ549ivKei39qH5ycAh1prXQm/DZHlEqnOyiNzYwbgScQ2VqemMIhPkS9SYW3Dp1h3ofWsXmL0jJKvs80bcLgiLNuQ/YL3PVuQtZkLm6A1Ownsb5s2dozMttm0HWjOyeEZchvmRm17M/up78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYyODbIN; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e36f9c651so29351545e9.3
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760369990; x=1760974790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X313eGs97I2iWdqADzIwqZMEwq+XwpBGENiqEW2tqII=;
        b=bYyODbINI5+TiUYjPGv1mSgGUX7y8/KdS7sSYn0a18qSl5H98BFRq4K6t6/bn0l7um
         QuWAf2aC0QmZTzAeDDekBVP4cmClpqRnAmbn2Llypd6bbQ56Fb+LhwZxDOhnzob4sNGb
         1zpLoOHUu1as4qUqQAxfbXzkazdFAuTV7q2c9CsD1buocckghojqormYtoMM8P3TNI28
         DjPTtGqS+AjAVIR+5T77MWW0SiByQaJxp8gjY5jX+k0+aNFjKux6WChZHeqnpHVY2XaC
         icF1+1ngA9zHjqEmwkSUjcELAXxsWtlggTEdQvp9OrXxiBzmpW7X9vKnx8Ukzgh9ByHz
         ek/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369990; x=1760974790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X313eGs97I2iWdqADzIwqZMEwq+XwpBGENiqEW2tqII=;
        b=YQJE6sWOLqcH176y15kUH/qcfnayEZkzREV9UwahEr1vzPoP0UK4LRsv9jzNJieV0i
         WSolw5/LK1m1Jm3566JB9wC5t8WYjsXVKi6f2ExppInTeZ3yj9tIXfrEM/bIHcDF37wJ
         KU7B/fuQHEOiA5jJ3WOV+OlHCk9FP2R2WIw47BNFWJuYxdA/pUaGHVdUYSHwXKLdFXDd
         amSPGX0zhXMBkWSn9DkTCpNC0uWVfJOWBffRZiMQXNxK3mzTPjEZZftq2ZmsNUQg2yqq
         47txQPrOGOlA8J1mW9Bezpyxd7MmA6Q1XhEWkPdRDlPq1q4nwMKqz2pAETmjRYy2Q2id
         zW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSQlHmshYz4w1CRukpqJqoD0Mgk76cAy0OgIV51W86Sr/huwSoIYkKg3ec6J15fJevdAa6+TsrJ78t@vger.kernel.org
X-Gm-Message-State: AOJu0YyEwJXvCqp03DpNQV+lugnr0rFKxUjqvpuk805QEnZvocT/0POH
	VGoEBd4y3vdZ93B7f/5a6rw8lXvBLas+kZ8lHzwIUiVdFNF/NUoKPjiHfdGXIMGGo2q8DlyhDJP
	uq32QnW9mTjmftzUhAA==
X-Google-Smtp-Source: AGHT+IF1OUtaJZbznzCIqJxNUxLFx37pVHVCwzTbAWrYjRCpog3arVCAEs4KerdChcXAgLggL/JaQE+k6VXD5b4=
X-Received: from wmlu17.prod.google.com ([2002:a05:600c:2111:b0:46e:2eb4:38d])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b42:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-46fa9b16607mr165506645e9.34.1760369990483;
 Mon, 13 Oct 2025 08:39:50 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:39:12 +0000
In-Reply-To: <20251013153918.2206045-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013153918.2206045-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013153918.2206045-5-sidnayyar@google.com>
Subject: [PATCH v2 04/10] module loader: use kflagstab instead of *_gpl sections
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com
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
2.51.0.740.g6adb054d12-goog


