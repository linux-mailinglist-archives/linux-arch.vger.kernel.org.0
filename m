Return-Path: <linux-arch+bounces-14050-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 39602BD4AC2
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 18:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1E87350181
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A231CA60;
	Mon, 13 Oct 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SjQIS3Ul"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FF31BCA6
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369996; cv=none; b=IEzOs5ae73zQ1Ct1P9zQhhjEdfMffYl8ibhuymZdug2N9X5lv5+LcNlxMWJXILCtq2b/BtrqnP6lhO8s4QDNAeqwILsFVdgtXYCrtZ9EJT+76vMsNLiBJ+0/kjAEmaCHaS7Mbp6ii4MJiErglceb05ULdPluN9jOyRGi5VcxdA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369996; c=relaxed/simple;
	bh=RLWrJA6e0o1fvEZPXCTEkfPrFrwKqhIpIw4wVbO6co8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oc56c8cZXTMAsyqjtYu5WawLV9kmIGCQkmygC3B7W/mBPT7v7argSpXDRK+DAxlsw+Dv4E8NBFU2N8f3lP1N6Jm+85oRdNi4U6h4IGXzH1aSn9xUmHZzIP+yCoE+UttOXJ+RzFeg+Sg/qeLBvYMEmKuDx0aeaBlHoxVRUjJnl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SjQIS3Ul; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e4335fa87so30540505e9.0
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760369992; x=1760974792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a+g1ys0MMb9WULZqvnNzuABkcTm+/NGxqiHjvVRRSBI=;
        b=SjQIS3Ul7/PrB8Pe97ZCMHCNseoYl5UvPNI27D7c+HJ3hHzFY/1b1sPpHkwcN1XhHe
         6DelFYo3MAXKB58aIWz3RUmtaaS+HItuauZJsaFqfA6wrhInQZlXQQaC6HZhqsLg0wN1
         WOD8e03pvhHhZ8Q/LAI3nwJMuK1UR5lfkiQy+jw7G6JYF5M7oMlKxvd6vtH3YHkydxss
         +MO3pRmjlRar8/4u0YEI/IuELW5qoCB/DK0Re6ihFlxMo7N9/ekX8tcqKxF3DmAgpPJr
         WDZmLzLITaOVQtQ1ohxPoJAY50Ou27HMkBcl1+AHivBqcKByMT4vwA53HR1mrGRGSsXL
         LoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369992; x=1760974792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+g1ys0MMb9WULZqvnNzuABkcTm+/NGxqiHjvVRRSBI=;
        b=Pg4qVWMGiKIOa+2otRg86we0Bun/wNVQSG9S0OrVqZrqctufpx3v0SQTtBJiZTJEZh
         tAuPV1H+B2Ip3n3Si/HkD4dpBbpls9SCJ5L+CIHgx5UGPUGLwTcW1M0wABa4LvG6sZHF
         Avu+Ayz0lFWeB8lTNOa3tWuMV+cu37xSJqpqK5OZ0COjPTbDQRTnidZ6kWS7jGeNibVG
         A2GFvHSAkdjTTKp11+WnVRxtCb/fgwW2CACN+K+MZh1S2lHz6fynpVK2nz+XZAKMtaWE
         RzI7vpMkXcF27HktQc6xnzt7H5GmzwhxhlJiAncsrdDhvtqBrMHv65h8JdDUdCsyX7uz
         I6GA==
X-Forwarded-Encrypted: i=1; AJvYcCUNOerBS1FOKZwhYpBg9kwgCC+InK8MVpgU1F4YHEFNt3RLMu5p1d1XftODxanK64FZY/ElinFBpqZn@vger.kernel.org
X-Gm-Message-State: AOJu0YyTL4zBwda2FDIJ7IzjByq4Tqm4Fk2roTBKDBiP3SxWRSVmf1AO
	Q1sUYMek6x2DlLYsSiZdKltZiJscJJBrxIYkAx5StPFoIeiBbkfLbjvgs5Ndj4Ep12ro64bCs4N
	0XhdfGlJv88aGXvuhQQ==
X-Google-Smtp-Source: AGHT+IGLaf0ASghwkahJRWS3hPq7oT6ve24L37x4B6OnXmFbgLy02R9Qw5r8wqjyhj+HwGR3CdmVAm9wSPmh24g=
X-Received: from wmbgx15.prod.google.com ([2002:a05:600c:858f:b0:46f:b153:bfb7])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c4ab:b0:46e:46c8:edac with SMTP id 5b1f17b1804b1-46fce364066mr11500775e9.11.1760369992506;
 Mon, 13 Oct 2025 08:39:52 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:39:14 +0000
In-Reply-To: <20251013153918.2206045-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013153918.2206045-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013153918.2206045-7-sidnayyar@google.com>
Subject: [PATCH v2 06/10] module loader: remove references of *_gpl sections
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com
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
2.51.0.740.g6adb054d12-goog


