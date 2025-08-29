Return-Path: <linux-arch+bounces-13336-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7B7B3B979
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 12:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6711CC00E0
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE38315771;
	Fri, 29 Aug 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGSIPRlm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D401314A88
	for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464882; cv=none; b=hxaBgM+Aae3I8GIA5wme1Vs955z4aRaTfM46tVQt2BKr4z8K2rfM5PgXBvLKi9nVjd0bdXAY6fWHrrBZylgUKWp8hZmX9qZ4C5s75Dkoc/uWLo5dA5zKP6ORsqJWCbfTSYpgA8Gw2GnNkxJFuB+Zb7+UsNdvJLlIhJJ4T1bC9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464882; c=relaxed/simple;
	bh=F31B1S8lHw87bvdOmxvFQVJauzkbFRHPz4qUM68sjcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HG6aRfAc53v4gBYJe4r6zaEAWgRZCeow3KyterneCN1FQ1TBybDC8boqBzNSSDmODIZ3hjsVV6JttZakKkYZmLpxVikGA0xFHeIg7W6Y6q6GLb9f03I9qxujPOfh4VHiveXPplAkiKGQ84yiW+wqtDjBeFdc1zhio0L8UBMpMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGSIPRlm; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3cba0146f7aso982010f8f.3
        for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464878; x=1757069678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kFTnM3F0cCHrWnaJ2kM4zCxpKLKVf/l5ppuLW/5eUHs=;
        b=cGSIPRlmktkUNTjZ/Hb8zPD9Z70NI1Y1IeFkMKxT1I/+vQZXpHTvVDep1+6fJwJZ94
         3hFfZoOyBH0+0aoisQ6CbKxg3aKESEQ7fiKmgoXSCXXizkA7MIJCXp5O7K7m33ib7kzI
         PMIrIPtA7JzqbSl/hVHUFhq9pHOttltTROaxkBJAK1br+8VoP0JWglFrhXOomkYe4flM
         8/A6XbemSr7s1MZnVHUT4p0pVrRCxtTHx4ZEg+rEb68w/awtxynslrfoCkFHz0bU1O7k
         G2MNE87S3lX4zW8PSn0sVvE+YnLl5DunH8iqrFl/gFcCmctkuQt8kWx4uEKah8uzP7u9
         aC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464878; x=1757069678;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFTnM3F0cCHrWnaJ2kM4zCxpKLKVf/l5ppuLW/5eUHs=;
        b=oC/9jOgMF8FUOKmHHV659WwTqvoXrg9pUkdDpQH0PZ+R1PxeB5lQEpILqRQKg72xib
         g9C3onf+9KKQoDXk0RoLH3AomLqUoLS7PmaCioAKm6zaAC5LgnWYrhLtma6SkBJSSj9o
         /Y3aKvkly29CtwE4DwPNMFMwN36GNQBlFIgFGGHIVxN8kIyZH0xzri3Ug13IsJxjazdY
         A2ZufEzU2y/m2cnlwJqLjvLS6T5XQosJHDzOz9HB22uX6jJ+mVAeTKl1ccssj9TvMuuO
         rjTZ/AmZgVW0+whU0hzjKGIPh55goSD+X8etvQin3jXSIjCOjpkojj5XMu0UtdN7GXz3
         4szA==
X-Forwarded-Encrypted: i=1; AJvYcCVv/D3vX65LAvXfqymgJ2BLoAXzmqzeAq1AQK4XqgSMWXotzCFoOnKpMGqhaC6f1oiH/a+FBUkPD8zC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5I0EYzKgtoQOosI/Av4gRcrZFv/L6awOfm3r15TFgZBMzP7Yo
	kHuykmRll3BMSkULXWsITr5/0Dsume/zxKKHmAVZ9iFCAm09wl9KftfYpwosxR6Jxq9eUtduMuX
	/rZVHTCbf3MgJQ+Lhzg==
X-Google-Smtp-Source: AGHT+IGhXlg73AG74XQ1K/78bczfgGZ6cx/K2NS3Xdv76qWZPKey7zRbs4h7QieTBU1hVrcYOEW0Rwi8beEOsYs=
X-Received: from wmbfp6.prod.google.com ([2002:a05:600c:6986:b0:45b:803d:733])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:188d:b0:3ca:c607:ad8a with SMTP id ffacd0b85a97d-3cac607b234mr11307773f8f.57.1756464878576;
 Fri, 29 Aug 2025 03:54:38 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:17 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-10-sidnayyar@google.com>
Subject: [PATCH 09/10] modpost: add symbol import protection flag to kflagstab
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

When the unused exports whitelist is provided, the symbol protection bit
is set for symbols not present in the unused exports whitelist.

The flag will be used in the following commit to prevent unsigned
modules from the using symbols other than those explicitly declared by
the such modules ahead of time.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/linux/module_symbol.h |  3 ++-
 scripts/mod/modpost.c         | 13 +++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 574609aced99..96fe3f4d7424 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -3,8 +3,9 @@
 #define _LINUX_MODULE_SYMBOL_H
 
 /* Kernel symbol flags bitset. */
-enum ksym_flags {
+enum symbol_flags {
 	KSYM_FLAG_GPL_ONLY	= 1 << 0,
+	KSYM_FLAG_PROTECTED	= 1 << 1,
 };
 
 /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 8936db84779b..8d360bab50d6 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -61,6 +61,9 @@ static bool extra_warn;
 bool target_is_big_endian;
 bool host_is_big_endian;
 
+/* Are symbols protected against being used by unsigned modules? */
+static bool default_symbol_protected_status;
+
 /*
  * Cut off the warnings when there are too many. This typically occurs when
  * vmlinux is missing. ('make modules' without building vmlinux.)
@@ -225,6 +228,7 @@ struct symbol {
 	bool is_func;
 	bool is_gpl_only;	/* exported by EXPORT_SYMBOL_GPL */
 	bool used;		/* there exists a user of this symbol */
+	bool protected;		/* this symbol cannot be used by unsigned modules */
 	char name[];
 };
 
@@ -246,7 +250,8 @@ static struct symbol *alloc_symbol(const char *name)
 
 static uint8_t get_symbol_flags(const struct symbol *sym)
 {
-	return sym->is_gpl_only ? KSYM_FLAG_GPL_ONLY : 0;
+	return (sym->is_gpl_only ? KSYM_FLAG_GPL_ONLY : 0) |
+		(sym->protected ? KSYM_FLAG_PROTECTED : 0);
 }
 
 /* For the hash of exported symbols */
@@ -370,6 +375,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	s->namespace = xstrdup(namespace);
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
+	s->protected = default_symbol_protected_status;
 
 	return s;
 }
@@ -1785,8 +1791,10 @@ static void handle_white_list_exports(const char *white_list)
 	while ((name = strsep(&p, "\n"))) {
 		struct symbol *sym = find_symbol(name);
 
-		if (sym)
+		if (sym) {
 			sym->used = true;
+			sym->protected = false;
+		}
 	}
 
 	free(buf);
@@ -2294,6 +2302,7 @@ int main(int argc, char **argv)
 			break;
 		case 'u':
 			unused_exports_white_list = optarg;
+			default_symbol_protected_status = true;
 			break;
 		case 'W':
 			extra_warn = true;
-- 
2.51.0.338.gd7d06c2dae-goog


