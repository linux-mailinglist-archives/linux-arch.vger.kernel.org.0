Return-Path: <linux-arch+bounces-14485-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADAAC2D16A
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 17:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCDCB4ED9F2
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1886318139;
	Mon,  3 Nov 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niHXI75D"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF162319851
	for <linux-arch@vger.kernel.org>; Mon,  3 Nov 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186812; cv=none; b=UTMX5OCc3aEvDb9R7Dw8qNsOg47xfVJ2b2khZ31PDoZYJfgFwm1cv11v0KkZU8JvFYwycHEg8/S6v4S+uSsY5OiGwrtneV1ZYyh2Pqzz/x17FHXMqGG4hB0R3J5ZdB1fZdakkV4KKiSj3V63QMmYdSPGlVPA0qUIOWdN/Sq45E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186812; c=relaxed/simple;
	bh=QGAi+ONyMbMm0xeVQDTKnmccX0ZHWeVKKtypFmAuEsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qkbriHD+2J85dfp82uB7n2FQG8O88i/kSRaCTZJjUSjbikU0IMIa3CoqMagX8MbG03sjzfI1Lxtr2yPIJcizWX/17+4CxOrp8tr3IQZS/o8RMi49pEjmECTVlJs2HikVOUeK4WWEsNofgjA7RIMNJUMt5GsfhUj8LmL8mHpbjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niHXI75D; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-471201dc0e9so36312835e9.2
        for <linux-arch@vger.kernel.org>; Mon, 03 Nov 2025 08:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186808; x=1762791608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NeBc1PqOxKqd9rI2R/vzteBDEeuRiti7tKcE1sQ8cJ8=;
        b=niHXI75DTv99udGcKgEAAl0bIpB+eCQ6iTsos5QOF3RNmmMZ9vSmY2veHmWdXiygkm
         D7YAmU2TmgvbTWQrt7HmvxMaO5PeszN0/FJRm0LEfbZWXfxCFYrMJezTAkObezTCYQOC
         H9d7pt6/5l9Iv+7Nsj2dIwVW5nOBybEceHvBju500Kpdd7ilBU9uC/SxngdE0P8IMpfV
         dKlGbElsDzWZQp4gDsEAiScRpnFtq5zj6KSvFNTZUuytvmJrdh14lpiD2D4rXECLJvyF
         Li4ddkuVZl5trHRS5EWyqRUeqKPj0BV4CaftmdLliubcENXouNSV7Hd8xv7Q44ALIQ96
         iLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186808; x=1762791608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeBc1PqOxKqd9rI2R/vzteBDEeuRiti7tKcE1sQ8cJ8=;
        b=md7hgiaHsGXfZQzN4m2nveaIhfJC2Cqbm2XeZA19rz0tqH7QDAZX47V7ShrmBLeLZF
         nHLhhSnH0H2ziFBJFcvfDrAxBJdVpGY02sDB+aOKb6Br+KTDjItZqddIV8qyCQakIY/S
         DE7n65ThTTbrL1tO4Ts3xsxnnmIfanwE0bSGquS5nnkAohCfYQox4pLV0G5ZUZ2m9hqr
         IJOhaK3NM1AihBVlOMnAZJuWhBR1OE24siXMi5HR3X1RZT033Zgm48rMg+oNmem9NlQ3
         /b1tXV5w+KgyR6hvYpFQM1gR1pLaVUAb0CTPE61IpirT+oDemNrQ3V6wYo1+mcGmN7cz
         gemg==
X-Forwarded-Encrypted: i=1; AJvYcCUOlOOjSXtBD97UojcPB7J8uZl9J0vwLM8vje1NhiQlmjebgXoaJhmlDQ8VnLRFsWftEznfCSz+gOqr@vger.kernel.org
X-Gm-Message-State: AOJu0YwbB0V/4idw72EGlGep0Sv4mz2Gwu9toRPgAZIuVurM+TTrOV/v
	6rsNMq5AabdRAJUf1dhMw2ZrbV1r7nas2WXQJnEikSHki47fRGqpNKg/F+YSBosL20XuekRC9vd
	qMsTOFwxSu6oNsN6RVA==
X-Google-Smtp-Source: AGHT+IGeGN1Hp41Ud0+9yWo+cHpbvWWoB9BA2YL+XnuANZQqI/3R4uVwNj2QKUQsp0r9uk24ApiOFtFuDXR98YE=
X-Received: from wma5.prod.google.com ([2002:a05:600c:8905:b0:477:31ea:6473])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e17:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-477308aec8amr143460475e9.31.1762186808290;
 Mon, 03 Nov 2025 08:20:08 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:52 +0000
In-Reply-To: <20251103161954.1351784-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103161954.1351784-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-7-sidnayyar@google.com>
Subject: [PATCH v3 6/8] module loader: remove references of *_gpl sections
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

The *_gpl section are not being used populated by modpost anymore. Hence
the module loader doesn't need to find and process these sections in
modules.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h   |  3 ---
 kernel/module/internal.h |  3 ---
 kernel/module/main.c     | 47 ++++++++++++++++------------------------
 3 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 9ba6ce433ac3..1a9c41318e22 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -431,9 +431,6 @@ struct module {
 	unsigned int num_kp;
 
 	/* GPL-only exported symbols. */
-	unsigned int num_gpl_syms;
-	const struct kernel_symbol *gpl_syms;
-	const u32 *gpl_crcs;
 	bool using_gplonly_symbols;
 
 #ifdef CONFIG_MODULE_SIG
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 69b84510e097..061161cc79d9 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -53,10 +53,7 @@ extern const size_t modinfo_attrs_count;
 /* Provided by the linker */
 extern const struct kernel_symbol __start___ksymtab[];
 extern const struct kernel_symbol __stop___ksymtab[];
-extern const struct kernel_symbol __start___ksymtab_gpl[];
-extern const struct kernel_symbol __stop___ksymtab_gpl[];
 extern const u32 __start___kcrctab[];
-extern const u32 __start___kcrctab_gpl[];
 extern const u8 __start___kflagstab[];
 
 #define KMOD_PATH_LEN 256
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 4197af526087..f5f9872dc070 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1464,29 +1464,18 @@ EXPORT_SYMBOL_GPL(__symbol_get);
  */
 static int verify_exported_symbols(struct module *mod)
 {
-	unsigned int i;
 	const struct kernel_symbol *s;
-	struct {
-		const struct kernel_symbol *sym;
-		unsigned int num;
-	} arr[] = {
-		{ mod->syms, mod->num_syms },
-		{ mod->gpl_syms, mod->num_gpl_syms },
-	};
-
-	for (i = 0; i < ARRAY_SIZE(arr); i++) {
-		for (s = arr[i].sym; s < arr[i].sym + arr[i].num; s++) {
-			struct find_symbol_arg fsa = {
-				.name	= kernel_symbol_name(s),
-				.gplok	= true,
-			};
-			if (find_symbol(&fsa)) {
-				pr_err("%s: exports duplicate symbol %s"
-				       " (owned by %s)\n",
-				       mod->name, kernel_symbol_name(s),
-				       module_name(fsa.owner));
-				return -ENOEXEC;
-			}
+	for (s = mod->syms; s < mod->syms + mod->num_syms; s++) {
+		struct find_symbol_arg fsa = {
+			.name	= kernel_symbol_name(s),
+			.gplok	= true,
+		};
+		if (find_symbol(&fsa)) {
+			pr_err("%s: exports duplicate symbol %s"
+				" (owned by %s)\n",
+				mod->name, kernel_symbol_name(s),
+				module_name(fsa.owner));
+			return -ENOEXEC;
 		}
 	}
 	return 0;
@@ -2601,12 +2590,15 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->syms = section_objs(info, "__ksymtab",
 				 sizeof(*mod->syms), &mod->num_syms);
 	mod->crcs = section_addr(info, "__kcrctab");
-	mod->gpl_syms = section_objs(info, "__ksymtab_gpl",
-				     sizeof(*mod->gpl_syms),
-				     &mod->num_gpl_syms);
-	mod->gpl_crcs = section_addr(info, "__kcrctab_gpl");
 	mod->flagstab = section_addr(info, "__kflagstab");
 
+	if (section_addr(info, "__ksymtab_gpl"))
+		pr_warn("%s: ignoring obsolete section __ksymtab_gpl\n",
+			mod->name);
+	if (section_addr(info, "__kcrctab_gpl"))
+		pr_warn("%s: ignoring obsolete section __kcrctab_gpl\n",
+			mod->name);
+
 #ifdef CONFIG_CONSTRUCTORS
 	mod->ctors = section_objs(info, ".ctors",
 				  sizeof(*mod->ctors), &mod->num_ctors);
@@ -2816,8 +2808,7 @@ static int check_export_symbol_sections(struct module *mod)
 		return -ENOEXEC;
 	}
 #ifdef CONFIG_MODVERSIONS
-	if ((mod->num_syms && !mod->crcs) ||
-	    (mod->num_gpl_syms && !mod->gpl_crcs)) {
+	if (mod->num_syms && !mod->crcs) {
 		return try_to_force_load(mod,
 					 "no versions for exported symbols");
 	}
-- 
2.51.1.930.gacf6e81ea2-goog


